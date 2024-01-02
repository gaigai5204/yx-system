<template>
  <div class="showMap">
    <div style="display: flex" class="top-control">
      <!-- <button @click="startMeasure">测距</button>
      <button @click="stopMeasure">清除</button> -->
      <!-- <img src="/temp/tran-car.svg" alt="" style="width:200px;height:200px;"> -->
      <div class="control_button" @click="ControlReplace()">
      <img src="@/views/static/replace.png">
    </div>      
    </div>

    <div class="search-input">
        <el-input 
          placeholder="请输入订单编号" 
          v-model="orderNumber"          
          clearable
          @keyup.enter.native="handleQuery"/>
    </div>        
    <div class="search-button">
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery()">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>          
        </div>

    <div class="address-input">
            <el-input
            style="width:100px;"
              placeholder="lng坐标"
              v-model="selectLng"
              clearable>
            </el-input>
            <el-input
            style="width:100px;margin-left:30px;"
              placeholder="lat坐标"
              v-model="selectLat"
              clearable>
            </el-input>   

<div class="submit-button">
  <!-- <el-button type="danger" plain @click="updateOrderRouter()">确认添加</el-button> -->
<el-button type="primary" icon="el-icon-edit" circle @click="updateOrderRouter()"></el-button>  
<div class="blank">确认添加</div>
</div>

  
          <div style="margin-top:10px;">
          <el-amap-search-box
            :search-option="searchOption"
            :on-search-result="onSearchResult"
          />           
          </div>

    </div>   
    <div id="map" class="map" tabindex="0"></div>
            <div id="popup" class="ol-popup">
            <a href="#" id="popup-closer" class="ol-popup-closer"></a>
            <div id="popup-content" class="popup-content"></div>
        </div>



  </div>
</template>

<script>
import "ol/ol.css";
import Map from "ol/Map";
import View from "ol/View";
import TileLayer from "ol/layer/Tile";
import { getTyphoonData } from "@/api/tranRoute";
import { Vector as VectorLayer } from "ol/layer";
import { WMTS as WMTS, Vector as VectorSource } from "ol/source";
import Feature from "ol/Feature";
import { getTopLeft, getWidth } from "ol/extent";
import {transform, toLonLat, fromLonLat, get as getProjection } from "ol/proj";
import { Point, MultiLineString, LineString, Polygon, Circle } from "ol/geom";
import { Fill, Circle as CircleStyle, Icon,Style, Stroke } from "ol/style";
import { toStringHDMS } from "ol/coordinate";
import { getOrderTran,updateOrderTran } from "@/api/system/orderTran";
import WMTSTileGrid from "ol/tilegrid/WMTS";

import Overlay from "ol/Overlay";
import Draw from "ol/interaction/Draw";
import { getLength } from "ol/sphere";
import { unByKey } from "ol/Observable";
export default {
  name: "index",
  data() {
    return {
      map: null,
      overlay: null,
      showAddPoints:false,
      address:'',
      selectLng:'',
      selectLat:'',
      replaceX:'',
      replaceY:'',
      input:'',
      orderNumber:'',
      searchOption: {
        city: "全国",
        citylimit: true,
      },
      featurePoint:{},
      source:{},
      layer:{},
      pointsArr:[],
      lastShowSolar: null,
      lastZoomPoint: null,
      mapPollutionImage: null,
      typhoonData: {},
      tfOverlay: null,
      drawLayers: [],
      drawDoms: [],
    };
  },

  methods: {

    InitRouter:async function(){
      const { data } = await getTyphoonData();
      this.pointsArr=data.points;
      this.drawTyphoonPathInterval();
    },
    awaitTest:async function(){
      await this.ControlReplace();
      setTimeout(function(){
        console.log(222);
        this.drawTyphoonPathInterval(); 
      }.bind(this), 1000);
       
    },
    handleQuery(){
      getOrderTran(this.orderNumber).then(response => {
        //this.form = response.data;
        if(response.data!=null){
          
          this.map.removeLayer(this.layer);
          console.log(response.data)
          this.pointsArr=JSON.parse(response.data.orderTran);
          if(this.pointsArr.length>1){
            this.awaitTest() 
          }else{
            this.$modal.msgSuccess("该快递刚刚出发，请稍后查询！");
          }
                  
        }
        else{
          this.$modal.msgError("该订单暂无物流信息！");
        }
      
    });
    },

// javascript 转换
lonLat2Mercator(lonlat){
    var mercator = {
		x:0,
    	y:0
	};
    var earthRad = 6378137.0;
    mercator.x = lonlat.lng * Math.PI / 180 * earthRad;
    var a = lonlat.lat * Math.PI / 180;
    mercator.y = earthRad / 2 * Math.log((1.0 + Math.sin(a)) / (1.0 - Math.sin(a)));
    return mercator;
},

// javascript 转换
mercatorTolonlat(mercator){
    var lonlat={
    	x:0,
    	y:0
    };
    var x = mercator.x/20037508.34*180;
    var y = mercator.y/20037508.34*180;
    y= 180/Math.PI*(2*Math.atan(Math.exp(y*Math.PI/180))-Math.PI/2);
    lonlat.x = x;
    lonlat.y = y;
    return lonlat;
},


    // 地图搜索回调
    onSearchResult(pois) {
      const vm = this;

      console.log("地图回调", pois);
      if (pois.length > 0) {
        pois.forEach((poi, index) => {
          const { lng, lat } = poi;
          if (index === 0) {
            const obj = {
              position: [poi.lng, poi.lat],
              text: poi.name,
              offset: [0, 30],
            };
            this.selectLng=poi.lng
            this.selectLat=poi.lat
            console.log("地图搜索回调", poi);

            // 获取到弹框的节点DOM
            var container = document.getElementById("popup");
            var content = document.getElementById("popup-content");
            var closer = document.getElementById("popup-closer");
            //弹窗关闭事件
            closer.onclick = function () {
                _that.overlay.setPosition(undefined);
                closer.blur();
                isShowDialog = false;
                return false;
            };
            // 创建一个弹窗 Overlay 对象
            this.overlay = new Overlay({
                element: container, //绑定 Overlay 对象和 DOM 对象的
                autoPan: true, // 定义弹出窗口在边缘点击时候可能不完整 设置自动平移效果
                autoPanAnimation: {
                    duration: 250 //自动平移效果的动画时间 9毫秒
                }
            });
            //控制是否显示弹窗
            var isShowDialog = false;
            this.map.addOverlay(this.overlay);
            let _that = this;
            let coordinate = this.lonLat2Mercator(poi)


            var lnglatXY = [this.selectLng,this.selectLat] // 地图上所标点的坐标
            AMap.service('AMap.Geocoder', function () {
              // 回调函数
              let geocoder = new AMap.Geocoder({})
              geocoder.getAddress(lnglatXY, function (status, result) {
                console.log(status, result)
                if (status === 'complete' && result.info === 'OK') {
                  // console.log(result.regeocode.formattedAddress);
                  let address=result.regeocode.formattedAddress
        
                  content.innerHTML = `
                  <p>地点选择：</p>${address}
                  <p>坐标：</p>Lng：${poi.lng} <br> Lat: ${poi.lat }`;
                  _that.overlay.setPosition([coordinate.x,coordinate.y]); //把 overlay 显示到指定的 x,y坐标
                  isShowDialog = true

                } else {
                  console.log('error')
                }
              })
            })   

          }
        });

      }
    },



    // 画出快递路径 interval版
    drawTyphoonPathInterval: async function () {

      let points = this.pointsArr;
      let index = 0;
      this.layer = new VectorLayer();
      this.source = new VectorSource();
      this.layer.setSource(this.source);
      let intervalLogo = setInterval(() => {
        if (index == points.length) {
          clearInterval(intervalLogo);
          return;
        }
        let position = [points[index].lng, points[index].lat];
        if (index == 0) {
          this.map.getView().setCenter(fromLonLat(position));
        }
        // 点 的 数据源设置
        this.featurePoint = new Feature({
          geometry: new Point(fromLonLat(position)),
        });
        this.featurePoint.setStyle(
          new Style({
            image: new CircleStyle({
              fill: new Fill({
                color: "#1890FF",
              }),
              radius: 4,
            }),
          })
        );
        this.featurePoint.set("typhoonPoint", true);
        this.featurePoint.set("points", points[index]);
        let flag=false;
        // 写到这里的时候 预期的结果 应该是 如果有 全部都绘制了  、 没有清除  上一个被绘制的目标点
        if (
          points[index+1]!=undefined
        ) {
          let featureSolar = this.drawSolarExact(points[index],points[index+1]);
          let lastShowSolar = this.lastShowSolar;
          if (lastShowSolar != null) {
             this.source.removeFeature(lastShowSolar);
          }
          this.lastShowSolar = featureSolar;
          this.source.addFeature(featureSolar);
        }
        else{
          if(flag==false){
            let featureSolar = this.drawSolarExact(points[index],points[index-1]);
            let lastShowSolar = this.lastShowSolar;
            if (lastShowSolar != null) {
              this.source.removeFeature(lastShowSolar);
            }
            this.lastShowSolar = featureSolar;
            this.source.addFeature(featureSolar);   
            flag=true; 


       // 获取到弹框的节点DOM
        var container = document.getElementById("popup");
        var content = document.getElementById("popup-content");
        var closer = document.getElementById("popup-closer");
        //弹窗关闭事件
        closer.onclick = function () {
            _that.overlay.setPosition(undefined);
            closer.blur();
            isShowDialog = false;
            return false;
        };

        // 创建一个弹窗 Overlay 对象
        this.overlay = new Overlay({
            element: container, //绑定 Overlay 对象和 DOM 对象的
            autoPan: true, // 定义弹出窗口在边缘点击时候可能不完整 设置自动平移效果
            autoPanAnimation: {
                duration: 250 //自动平移效果的动画时间 9毫秒
            }
        });
        this.map.addOverlay(this.overlay);
        //控制是否显示弹窗
        var isShowDialog = false;
        let _that = this;
        let coordinate = this.lonLat2Mercator(points[index])


      var lnglatXY = [points[index].lng,points[index].lat] // 地图上所标点的坐标
      AMap.service('AMap.Geocoder', function () {
        // 回调函数
        let geocoder = new AMap.Geocoder({})
        geocoder.getAddress(lnglatXY, function (status, result) {
          console.log(status, result)
          if (status === 'complete' && result.info === 'OK') {
            // console.log(result.regeocode.formattedAddress);
            let address=result.regeocode.formattedAddress
          if (featureSolar) { //捕捉到要素
              content.innerHTML = `
                  <p>快递已送至：</p>
                  <p id="badao">${address}</p>`;
          
              _that.overlay.setPosition([coordinate.x,coordinate.y]); //把 overlay 显示到指定的 x,y坐标
              isShowDialog = true;
          } else {
              console.log("没有元素");
          }	

          } else {
            console.log('error')
          }
        })
      })  
      
      
              const view = this.map.getView()
        view.setZoom(12)
        view.setCenter([coordinate.x,coordinate.y])
        this.replaceX=coordinate.x
        this.replaceY=coordinate.y
              
          }
       
        }


        this.source.addFeature(this.featurePoint);

        if (index > 0) {
          let lastPosition = [points[index - 1].lng, points[index - 1].lat];
          let featureLine = new Feature({
            geometry: new LineString([
              fromLonLat(position),
              fromLonLat(lastPosition),
            ]),
          });
          this.source.addFeature(featureLine);
        }
        // 需要一个出口
        index++;
      }, 100);
      this.map.addLayer(this.layer);
    },

    getPositionByLonLats(lng, lat) {
    var that = this;
      var lnglatXY = [lng, lat] // 地图上所标点的坐标
      AMap.service('AMap.Geocoder', function () {
        // 回调函数
        let geocoder = new AMap.Geocoder({})
        geocoder.getAddress(lnglatXY, function (status, result) {
          console.log(status, result)
          if (status === 'complete' && result.info === 'OK') {
            // console.log(result.regeocode.formattedAddress);
            that.address=result.regeocode.formattedAddress
            console.log(that.address)
          } else {
            console.log('error')
          }
        })
      })      


    },



        /**
         * 创建一个 Overlay 叠加从对象用作显示弹窗
         * 思路：
         * 1. 点击地图上的位置
         * 2. 获取经纬度的坐标
         * 3. 调用 ol 内置的方法 ol.Overlay 实现弹出
         */
        addPopup() {
            // 使用变量存储弹窗所需的 DOM 对象
            var container = document.getElementById("popup");
            var closer = document.getElementById("popup-closer");
            var content = document.getElementById("popup-content");

            // 创建一个弹窗 Overlay 对象
            this.overlay = new Overlay({
                element: container, //绑定 Overlay 对象和 DOM 对象的
                autoPan: true, // 定义弹出窗口在边缘点击时候可能不完整 设置自动平移效果
                autoPanAnimation: {
                    duration: 250 //自动平移效果的动画时间 9毫秒
                }
            });
            // 将弹窗添加到 map 地图中
            this.map.addOverlay(this.overlay);
            let _that = this;
            /**
             * 添加单击响应函数来处理弹窗动作
             */
            this.map.on("click", function(evt) {
                // "EPSG:3857", "EPSG:4326" 转换
                let coordinate = transform(
                    evt.coordinate,
                    "EPSG:3857",
                    "EPSG:4326"
                );
                // let obj={}
                // obj.x=coordinate[0]
                // obj.y=coordinate[1]

                // let adrXY = this.mercatorTolonlat(obj)
                // console.log(adrXY)
                this.selectLat=coordinate[1]
                this.selectLng=coordinate[0] 
                
                var lnglatXY = [this.selectLng,this.selectLat] // 地图上所标点的坐标
                AMap.service('AMap.Geocoder', function () {
                  // 回调函数
                  let geocoder = new AMap.Geocoder({})
                  geocoder.getAddress(lnglatXY, function (status, result) {
                    console.log(status, result)
                    if (status === 'complete' && result.info === 'OK') {
                      // console.log(result.regeocode.formattedAddress);
                      let address=result.regeocode.formattedAddress

                          content.innerHTML = `
                          <p>地点选择：</p>${address}
                          <p>坐标：</p>Lng：${coordinate[0]} <br> Lat: ${coordinate[1] }`;
                          _that.overlay.setPosition(evt.coordinate); //把 overlay 显示到指定的 x,y坐标

                    } else {
                      console.log('error')
                    }
                  })
                })  


            }.bind(this));
            /**
             * 为弹窗添加一个响应关闭的函数
             */
            closer.onclick = function() {
                _that.overlay.setPosition(undefined);
                closer.blur();
                return false;
            };
        },

    // 注册一个 hover 事件
    designHoverOnMap: function () {
      let _this = this;
      this.map.on("pointermove", function (ev) {
        let pixel = ev.pixel;
        let feature = _this.map.forEachFeatureAtPixel(
          pixel,
          function (feature) {
            return feature;
          }
        );
        // if (feature) {
        //   let execName = featureObj.typeJudge(feature) + "Hover";
        //   featureObj[execName].apply(_this, [feature]);
        // } else {
        //   _this.clearPointZoomStyle();
        //   _this.map.getTargetElement().style.cursor = "";
        //   _this.tfOverlay.setPosition(undefined);
        // }
      });
    },


    // clearPoint Zoom Style
    clearPointZoomStyle: function () {
      let _this = this;
      if (_this.lastZoomPoint != null) {
        _this.lastZoomPoint.getStyle().getImage().setRadius(4);
        _this.lastZoomPoint.changed();
      }
    },

    // drawSolar 绘制送货车
    /**
     * 应该是明确的只让他返回 一个 feature
     */
    initSvgImage(src) {
        const image = new Image(40, 40) // 这里设置的大小为原始大小
        image.src = src // src 为svg地址
        return image
    },

    // 准确的绘制送货车
    drawSolarExact: function (points,nextPoints) {
      const _feature = new Feature({
        geometry: new Point(fromLonLat([points.lng, points.lat])),
      
      });
      //_feature.set("typhoonSolar", true);
      //console.log(nextPoints)
      let k = -(Math.abs(nextPoints.lat-points.lat))/(Math.abs(nextPoints.lng-points.lng))//斜率取反（旋转是顺时针）
      let h=Math.atan(k)
      let a =Math.floor( h * (180 / Math.PI))
      //console.log(a);
      
      this.mapPollutionImage = this.initSvgImage('/temp/tran-car.svg')
      let _style = new Style({
        image: new Icon({
          img: this.mapPollutionImage,
          anchor: [0.3, 0.3],
          imgSize: [40, 40],
          rotation:(a+90)*6.3/360,
          scale:1.2
        }),


      });

      _feature.setStyle(_style);
      //console.log(_feature)
      _feature.set("typhoonSolar", true);

      return _feature;
    },

    // 测距功能
    startMeasure: function () {
      const source = new VectorSource();

      const layer = new VectorLayer({
        source: source,
        style: new Style({
          fill: new Fill({
            color: "rgba(255, 255, 255, 0.2)",
          }),
          stroke: new Stroke({
            color: "#ffcc33",
            width: 2,
          }),
          image: new CircleStyle({
            radius: 7,
            fill: new Fill({
              color: "#ffcc33",
            }),
          }),
        }),
      });
      let _this = this;

      let feature;
      // overlay
      let helpTooltip;
      let measureTooltip;
      // dom节点
      let helpTooltipElement;
      let measureTooltipElement;
      // 交互类 绘制
      let draw;
      let listener;

      let pointermoveListener = this.map.on("pointermove", function (ev) {
        let helpMsg = "点击地图作为目标点";
        if (feature) {
          helpMsg = "双击地图作为结束点";
        }
        helpTooltipElement.innerHTML = helpMsg;
        helpTooltip.setPosition(ev.coordinate);
        helpTooltipElement.classList.remove("hidden");
      });

      draw = new Draw({
        source,
        type: "LineString",
        style: new Style({
          fill: new Fill({
            color: "rgba(255, 255, 255, 0.2)",
          }),
          stroke: new Stroke({
            color: "rgba(0, 0, 0, 0.5)",
            lineDash: [10, 10],
            width: 2,
          }),
          image: new CircleStyle({
            radius: 5,
            stroke: new Stroke({
              color: "rgba(0, 0, 0, 0.7)",
            }),
            fill: new Fill({
              color: "rgba(255, 255, 255, 0.2)",
            }),
          }),
        }),
      });

      // 监听开始绘制 、
      draw.on("drawstart", function (evt) {
        // set sketch
        feature = evt.feature;

        /** @type {import("../src/ol/coordinate.js").Coordinate|undefined} */
        let tooltipCoord = evt.coordinate;

        listener = feature.getGeometry().on("change", function (evt) {
          const geom = evt.target;
          let output = formatLength(geom);
          tooltipCoord = geom.getLastCoordinate();
          measureTooltipElement.innerHTML = output;
          measureTooltip.setPosition(tooltipCoord);
        });
      });

      this.map.getViewport().addEventListener("mouseout", function () {
        helpTooltipElement.classList.add("hidden");
      });

      draw.on("drawend", function () {
        measureTooltipElement.className = "ol-tooltip ol-tooltip-static";
        measureTooltip.setOffset([0, -7]);
        // unset sketch
        feature = null;
        // unset tooltip so that a new one can be created
        measureTooltipElement = null;
        createMeasureTooltip();
        _this.map.removeInteraction(draw);
        unByKey(listener);
        unByKey(pointermoveListener);
      });

      // 格式化长度
      const formatLength = function (line) {
        const length = getLength(line);
        let output;
        if (length > 100) {
          output = Math.round((length / 1000) * 100) / 100 + " " + "km";
        } else {
          output = Math.round(length * 100) / 100 + " " + "m";
        }
        return output;
      };

      function createHelpTooltip() {
        if (helpTooltipElement) {
          helpTooltipElement.parentNode.removeChild(helpTooltipElement);
        }
        helpTooltipElement = document.createElement("div");
        helpTooltipElement.className = "ol-tooltip hidden";
        helpTooltip = new Overlay({
          element: helpTooltipElement,
          offset: [15, 0],
          positioning: "center-left",
        });
        //_this.map.addOverlay(helpTooltip);
      }
      function createMeasureTooltip() {
        if (measureTooltipElement) {
          measureTooltipElement.parentNode.removeChild(measureTooltipElement);
        }
        measureTooltipElement = document.createElement("div");
        measureTooltipElement.className = "ol-tooltip ol-tooltip-measure";
        measureTooltip = new Overlay({
          element: measureTooltipElement,
          offset: [0, -15],
          positioning: "bottom-center",
          stopEvent: false,
          insertFirst: false,
        });
        _this.drawDoms.push(measureTooltipElement);
        //_this.map.addOverlay(measureTooltip);
      }
      createHelpTooltip();
      createMeasureTooltip();

      this.map.addInteraction(draw);
      this.drawLayers.push(layer);
      this.map.addLayer(layer);
    },

    // 清除
    stopMeasure: function () {
      let layers = this.drawLayers;
      console.log(this.drawDoms);
      for(let i = 0;i < layers.length;i++){
        this.map.removeLayer(layers[i]);
      }
      for(let i = 0;i < this.drawDoms.length;i++){
        this.drawDoms[i].parentNode.removeChild(this.drawDoms[i]);
      }
    },

    // 设置弹窗 位置
    setTFINFOPostion: function (points) {
      let position = fromLonLat([points.lng, points.lat]);
      this.tfOverlay.setPosition(position);
    },

    // 添加叠加层
    // addOverlay: function () {
    //   const overlay = new Overlay({
    //     element: this.$refs.typhoonInfo.$el,
    //     autoPan: true,
    //     autoPanAnimation: {
    //       duration: 250,
    //     },
    //   });
    //   overlay.setPosition(undefined);
    //   this.tfOverlay = overlay;
    //   this.map.addOverlay(overlay);
    // },

    /**
     * @param {index} 想要初始化的地图类型的相关索引 支持：矢量图、影像图、地形图，分别对应 0 1 2
     * @param {key} 天地图 中申请的秘钥key
     * @param {*} centerPosition 中心点的经纬度坐标
     * @notice 参数不能为空
     */
    tiandituInit(index, key) {
      // 如果传进来的 map2d的参数为null，说明需要新建一个map地图
      if (this.map == null) {
        let layerArr = this.JudgeBaseAndNoteByType(index);
        // 地图注记 与 底图的相关配置
        console.log(layerArr);
        var projection = getProjection("EPSG:3857");
        var projectionExtent = projection.getExtent();
        var size = getWidth(projectionExtent) / 256;
        var resolutions = new Array(14);
        var matrixIds = new Array(14);
        for (var z = 0; z < 14; ++z) {
          // generate resolutions and matrixIds arrays for this WMTS
          resolutions[z] = size / Math.pow(2, z);
          matrixIds[z] = z;
        }
        let layer_Base = new TileLayer({
          opacity: 1,
          source: new WMTS({
            url:
              "http://t{0-7}.tianditu.gov.cn/" +
              layerArr[0] +
              "_w/wmts?tk=" +
              key,
            layer: layerArr[0],
            matrixSet: "w",
            format: "tiles",
            style: "default",
            tileGrid: new WMTSTileGrid({
              origin: getTopLeft(projectionExtent),
              resolutions: resolutions,
              matrixIds: matrixIds,
            }),
            wrapX: true,
          }),
          visible: true,
        });
        let layer_Note = new TileLayer({
          opacity: 1,
          source: new WMTS({
            url:
              "http://t{0-7}.tianditu.gov.cn/" +
              layerArr[1] +
              "_w/wmts?tk=" +
              key,
            layer: layerArr[1],
            matrixSet: "w",
            format: "tiles",
            style: "default",
            tileGrid: new WMTSTileGrid({
              origin: getTopLeft(projectionExtent),
              resolutions: resolutions,
              matrixIds: matrixIds,
            }),
            wrapX: true,
          }),
          visible: true,
        });
        var map = new Map({
          layers: [layer_Base, layer_Note],
          target: "map",
          view: new View({
            center: fromLonLat([100, 20]),
            zoom: 7,
            minZoom: 4,
          }),
        });
        console.log(map);
        this.map = map;
      }
    },

    // 根据 约定的 类型的索引 判别 底图 与 注记图 需要渲染的layer类型
    JudgeBaseAndNoteByType(index) {
      let map = [
        ["vec", "cva"],
        ["ter", "cta"],
        ["img", "cia"],
      ];
      return map[index];
    },
    resetQuery(){
      this.orderNumber='';
    },
    updateOrderRouter(){
      this.ControlReplace()
      getOrderTran(this.orderNumber).then(response => {
        //this.form = response.data;
        if(response.data!=null){
          this.map.removeLayer(this.layer);
          console.log(response)
          this.pointsArr=JSON.parse(response.data.orderTran);
          var obj={}
          obj.lat=this.selectLat
          obj.lng=this.selectLng
          this.pointsArr.push(obj)
          console.log(JSON.stringify(this.pointsArr))
          let tranObj={}
          tranObj.orderTranId=response.data.orderTranId
          tranObj.orderNumber=this.orderNumber
          tranObj.orderTran=JSON.stringify(this.pointsArr)
          //let orderTranString = JSON.stringify(this.pointsArr)
          updateOrderTran(tranObj).then(response=>{
             this.$modal.msgSuccess("修改成功");
             this.drawTyphoonPathInterval();
          })
        }
        else{
          alert("该订单暂无物流信息");
        }
      
    });
    },
      ControlReplace(){
        const view = this.map.getView()
        view.setZoom(7)
        view.setCenter([this.replaceX,this.replaceY])
      }

  },
  created() {},
  mounted() {
    this.tiandituInit(0, "66067842d639f1bb22df449351609860");
    // this.drawTyphoonPath();
    this.InitRouter();
    this.addPopup();
    //this.designHoverOnMap();

    //this.addOverlay();
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
.showMap{
  height: 88vh;

}
.top-control{
  position: absolute;
  z-index: 99;
}
.search-input{
  position: absolute;
  z-index: 99;
  width: 230px;
  left: 520px;
  top: 56px;
}
.address-input{
  position: absolute;
  z-index: 99;
  width: 230px;
  right: 150px;
  top: 56px;
}
.submit-button{
  margin-left: 250px;
  margin-top: -35px;
}
.blank{
  width: 85px;
  height: 24px;
  padding-left: 18px;
  padding-top: 2px;
  font-size: 14px;
  color: #7564ca;
  margin-left: 20px;
  margin-top: -24px;
  background-color: #B8D5D7;
}
.search-button{
    position: absolute;
  z-index: 99;
  left: 780px;
  top: 60px;
}
.map {
  width: 100%;
  height: 100%;
}

#map:focus {
  outline: #4a74a8 solid 0.15em;
}
.hidden{
  display: none;
}
.ol-tooltip {
  position: relative;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 4px;
  color: white;
  padding: 4px 8px;
  opacity: 0.7;
  white-space: nowrap;
  font-size: 12px;
  cursor: default;
  user-select: none;
}
.ol-tooltip-measure {
  opacity: 1;
  font-weight: bold;
}
.ol-tooltip-static {
  background-color: #ffcc33;
  color: black;
  border: 1px solid white;
}
.ol-tooltip-measure:before,
.ol-tooltip-static:before {
  border-top: 6px solid rgba(0, 0, 0, 0.5);
  border-right: 6px solid transparent;
  border-left: 6px solid transparent;
  content: "";
  position: absolute;
  bottom: -6px;
  margin-left: -7px;
  left: 50%;
}
.ol-tooltip-static:before {
  border-top-color: #ffcc33;
}


.ol-popup {
    position: absolute;
    background-color: white;
    -webkit-filter: drop-shadow(0 1px 4px rgba(0, 0, 0, 0.2));
    filter: drop-shadow(0 1px 4px rgba(0, 0, 0, 0.2));
    padding: 15px;
    border-radius: 10px;
    border: 1px solid #cccccc;
    bottom: 12px;
    left: -50px;
}
.ol-popup:after,
.ol-popup:before {
    top: 100%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
    pointer-events: none;
}
.ol-popup:after {
    border-top-color: white;
    border-width: 10px;
    left: 48px;
    margin-left: -10px;
}
.ol-popup:before {
    border-top-color: #cccccc;
    border-width: 11px;
    left: 48px;
    margin-left: -11px;
}
.ol-popup-closer {
    text-decoration: none;
    position: absolute;
    top: 2px;
    right: 8px;
}
.popup-content {
    width: 210px;
}
.ol-popup-closer:after {
    content: "✖";
}

	.control_button{
    position:absolute;
    left: 40px;
    top: 50px;
		width:32px;
		height:32px;

		border-radius: 50px;
		cursor: pointer;
		box-shadow:1px 1px 1px 1px #ccc;
		background-color: rgb(255, 255, 255);
	}
	.control_button img{
		width:18px;
		height:18px;
		margin-left: 7px;
		margin-top: 6px;

		/* background-color: rgb(76, 132, 253); */
	}
	.control_button:hover {
  		background-color: rgb(164, 196, 255);
	}
</style>
