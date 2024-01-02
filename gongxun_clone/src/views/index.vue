<template>
  <div class="app-container home">

    <div class="dashboard-editor-container">

    <panel-group @handleSetLineChartData="handleSetLineChartData" />

    <el-row style="background:#fff;padding:16px 16px 0;margin-bottom:32px;">
      <line-chart :chart-data="lineChartData" />
    </el-row>

    <!-- <el-row :gutter="32">
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <raddar-chart />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <pie-chart />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="8">
        <div class="chart-wrapper">
          <bar-chart />
        </div>
      </el-col>
    </el-row> -->

<el-row :gutter="20">
      <el-col :span="8">
        <el-card shadow="hover" style="height:380px">
          <div id="pieChart" style="height:400px"></div>
        </el-card>
      </el-col>

      <el-col :span="8">
        <el-card shadow="hover" class="update-log" style="height:380px">
          <div slot="header" class="clearfix">
            <span>网点公告</span>
          </div>
          <el-collapse   :data="menuList"  accordion>
            <div v-for="(menu,index) in menuList" @click="details_list(index,menuList)">
              <el-collapse-item :title="menu.noticeTitle"  :name="index" style="border-bottom: 1px solid #eee;">
                <span>{{menu.noticeContent}}</span>

              </el-collapse-item>
            </div>
          </el-collapse>
        </el-card>
      </el-col>

      <el-col :span="8">
        <el-card shadow="hover" style="height:380px">
           <div id="barChart" style="height:350px"></div>
         </el-card>
      </el-col>
    </el-row>
    
  </div>

    <!-- <el-divider /> -->

    
    
    <!-- <el-divider /> -->
  </div>
</template>

<script>
import * as echarts from "echarts";
import { listOrder,getCountByTime, orderByTime } from "@/api/system/order";
import { listNotice, getNotice, delNotice, addNotice, updateNotice } from "@/api/system/notice";
import PanelGroup from './dashboard/PanelGroup'
import LineChart from './dashboard/LineChart'
import RaddarChart from './dashboard/RaddarChart'
import PieChart from './dashboard/PieChart'
import BarChart from './dashboard/BarChart'

const lineChartData = {
  newVisitis: {
    expectedData: [100, 120, 161, 134, 105, 160, 165],
    actualData: [120, 82, 91, 154, 162, 140, 145]
  },
  messages: {
    expectedData: [2, 3, 4, 2, 5, 3, 6],
    actualData: [180, 160, 151, 106, 145, 150, 130]
  },
  purchases: {
    expectedData: [4, 5, 8, 4, 10, 6, 12],
    actualData: [120, 90, 100, 138, 142, 130, 130]
  },
  shoppings: {
    expectedData: [13, 16, 24, 12, 18, 19, 36],
    actualData: [120, 82, 91, 154, 162, 140, 130]
  }
}

export default {
  name: "Index",
  components: {
    PanelGroup,
    LineChart,
    RaddarChart,
    PieChart,
    BarChart
  },
  data() {
    return {

      lineChartData: lineChartData.newVisitis,

      // 版本号
      version: "3.8.3",
      menuList:[],
      dateArr:[],
      newDateArr:[],
      dayOrder:0,
      weekOrder:0,
      monthOrder:0,
      allOrder:0,
      pieData:[
                { value: 0, name: '待接单' },
                { value: 0, name: '已接单' },
                { value: 0, name: '运输中' },
                { value: 0, name: '派送中' },
                { value: 0, name: '待取件' }
              ],
            // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10000,
        noticeTitle: undefined,
        createBy: undefined,
        status: undefined
      },
      barData:[0,0,0,0,0,0,0],
      barDataYue:[0,0,0,0,0,0,0],
      barDataNian:[0,0,0,0,0,0,0]
    };
  },
  methods: {
    /** 查询公告列表 */
    getList() {
      this.loading = true;
      listNotice(this.queryParams).then(response => {
        this.menuList = response.rows;
        console.log(this.menuList)
        this.total = response.total;
        this.loading = false;
      });
// this.addDateRange(this.queryParams, this.dateRange)
// this.pieData[4].value++
      listOrder(this.queryParams).then(response => {
        this.allOrder = response.rows.length;
        let self=this
        response.rows.forEach(function(item,index){
          if(item.orderStatus=='0'){
            self.pieData[2].value++
            console.log(item)
          }
          if(item.orderStatus=='1'){
            self.pieData[3].value++
          }
          if(item.orderStatus=='3'){
            self.pieData[0].value++
          }
          if(item.orderStatus=='4'){
            self.pieData[1].value++
          }
          if(item.orderStatus=='5'){
            self.pieData[4].value++
          }
          
        }.bind(this));
        // response.rows.forEach(function(item,index){
        //   if(item.orderStatus=='0'){
        //     self.pieData[2].value--
        //   }
        //   if(item.orderStatus=='1'){
        //     self.pieData[3].value--
        //   }
        //   if(item.orderStatus=='3'){
        //     self.pieData[0].value--
        //   }
        //   if(item.orderStatus=='4'){
        //     self.pieData[1].value--
        //   }
        //   if(item.orderStatus=='5'){
        //     self.pieData[4].value--
        //   }
          
        // }.bind(this));
        console.log(this.allOrder)
        this.getDataPie();
      });
      console.log(this.pieData)

    },

    handleSetLineChartData(type) {
      this.lineChartData = lineChartData[type]
    },

    goTarget(href) {
      window.open(href, "_blank");
    },

    // 获取近的日期
    getDate(){
      const d = new Date()
      const d6 = `${d.getMonth()+1}/${d.getDate()}`
      this.da
      var day6 = d.getTime()
      d.setTime(day6-86400000*6)
      var d0 = `${d.getMonth()+1}/${d.getDate()}`
      d.setTime(day6-86400000*5)
      var d1 = `${d.getMonth()+1}/${d.getDate()}`
      d.setTime(day6-86400000*4)
      var d2 = `${d.getMonth()+1}/${d.getDate()}`
      d.setTime(day6-86400000*3)
      var d3 = `${d.getMonth()+1}/${d.getDate()}`
      d.setTime(day6-86400000*2)
      var d4 = `${d.getMonth()+1}/${d.getDate()}`
      d.setTime(day6-86400000)
      var d5 = `${d.getMonth()+1}/${d.getDate()}`
      this.dateArr.push(d0.length==5?d0:d0.slice(0, 3)+'0'+d0.slice(3,4))
      this.dateArr.push(d1.length==5?d1:d1.slice(0, 3)+'0'+d1.slice(3,4))
      this.dateArr.push(d2.length==5?d2:d2.slice(0, 3)+'0'+d2.slice(3,4))
      this.dateArr.push(d3.length==5?d3:d3.slice(0, 3)+'0'+d3.slice(3,4))
      this.dateArr.push(d4.length==5?d4:d4.slice(0, 3)+'0'+d4.slice(3,4))
      this.dateArr.push(d5.length==5?d5:d5.slice(0, 3)+'0'+d5.slice(3,4))
      this.dateArr.push(d6.length==5?d6:d6.slice(0, 3)+'0'+d6.slice(3,4))
      console.log(this.dateArr);
    },
getDataPie(){

        // 饼图
        var pieChartDom = document.getElementById('pieChart');
        var myPieChart = echarts.init(pieChartDom);
        var pieOption = {
          title: {
            text: '订单组成',
            subtext: '各订单占比',
            left: 'center'
          },
          tooltip: {
            trigger: 'item'
          },
          legend: {
            orient: 'vertical',
            left: 'left'
          },
          series: [
            {
              name: 'Access From',
              type: 'pie',
              radius: '50%',
              data: this.pieData,
              emphasis: {
                itemStyle: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
              }
            }
          ]
        };
        pieOption && myPieChart.setOption(pieOption);
},
StrToDate(datestr) {
    return new Date(datestr);
},
    getData(){

        // 获取近一日内订单数
        getCountByTime(0).then(response => {
          this.dayOrder = response.data
        })

        // 获取近一周内订单数
        getCountByTime(1).then(response => {
          this.weekOrder = response.data
        })

        // 获取近一月内订单数
        getCountByTime(2).then(response => {
          this.monthOrder = response.data
        })
        let self=this
        // 获取近七天每天的订单数
        orderByTime(1).then(response => {
          console.log(response)
          let j = 0
          for(var i=6;i>=0;i--){
            if(j==response.rows.length) break
            if(self.dateArr[i].charAt(4)==response.rows[j].dataTime.charAt(9)) {
              // console.log(22222);
              self.barData[i] = response.rows[j].count
              j++
            }
          }
          let date1 = new Date()
          j=0;
          for(var i=6;i>=0;i--){
            if(j>=response.rows.length) break
            for(var k=0;k<4;k++){
              
              let dataTimeItem=self.StrToDate(response.rows[j].dataTime)
              console.log(dataTimeItem)
              // console.log(date1.getDate() - dataTimeItem.getDate())
              if(date1.getDate() - dataTimeItem.getDate()==0) {
                // console.log(22222);
                self.barDataYue[i] =self.barDataYue[i]+response.rows[j].count
                j++
                if(j==response.rows.length) break
              }
              date1=dataTimeItem
            }
            console.log(self.barDataYue)
          }

          let date2 = new Date()
          j=0;
          for(var i=6;i>=0;i--){
            if(j>=response.rows.length) break
            for(var k=0;k<29;k++){
              let dataTimeItem=self.StrToDate(response.rows[j].dataTime)
              // console.log(date1.getDate() - dataTimeItem.getDate())
              if(date2.getDate() - dataTimeItem.getDate()==0) {
                // console.log(22222);
                self.barDataNian[i] =self.barDataNian[i]+response.rows[j].count
                j++
                if(j==response.rows.length) break
              }
              date2=dataTimeItem
            }
            console.log(self.barDataNian)
          }


            lineChartData.messages.actualData= this.barData
             lineChartData.purchases.actualData=this.barDataYue
              lineChartData.shoppings.actualData=this.barDataNian

          // 柱状图
          var barChartDom = document.getElementById('barChart');
          var myBarChart = echarts.init(barChartDom);
          var barOption = {
            title: {
              text: '订单统计',
              subtext: '近七日订单',
            left: 'center'
          },
            tooltip: {
              trigger: 'axis',
              axisPointer: {
                type: 'shadow'
              }
            },
            grid: {
              left: '3%',
              right: '4%',
              bottom: '3%',
              containLabel: true
            },
            xAxis: [
              {
                type: 'category',
                data: this.dateArr,
                axisTick: {
                  alignWithLabel: true
                }
              }
            ],
            yAxis: [
              {
                type: 'value'
              }
            ],
            series: [
              {
                color:"#728dda",
                name: 'Direct',
                type: 'bar',
                barWidth: '60%',
                data: this.barData
              }
            ]
          };
          barOption && myBarChart.setOption(barOption);
        })
        
    },
    // 写方法
  },
  created(){
    this.getDate();
    // this.getList();
  },
  mounted() {
    this.getData();
    this.getList();
    // this.getDate();
  },
  watch:{
    pieData:{
      handler(newValue, oldValue) {
      for (let i = 0; i < newValue.length; i++) {
      if (oldValue[i] != newValue[i]) {
      console.log(newValue)
      }
      }
      },
      deep: true
    }
  }
};
</script>

<style scoped lang="scss">



.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    height: 400px;
    overflow-y: auto;
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}

.orderInfo {
  margin-bottom: 20px;
    &:last-child {
      margin-bottom: 0;
    }
}
.order {
    text-indent: .5em;
    font-size: 16px;
    line-height: 40px;
    vertical-align: center;
    // background-color: #8cc5ff;
    border-radius: 4px;
  }
.day-order {
  background-color: #ecf5ff;
}
.week-order {
  background-color: #d9ecff;
}
.month-order {
  background-color: #c6e2ff;
}
.orderTop {
    font-size: 16px;
    vertical-align: center;
    background-color: #66b1ff;
  }
  .grid-content {
    border-radius: 4px;
    min-height: 36px;
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }

.dashboard-editor-container {
  padding: 32px;
  height: 1020px;
  background-color: rgb(240, 242, 245);
  position: relative;

  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;
  }
}

@media (max-width:1024px) {
  .chart-wrapper {
    padding: 8px;
  }
}

</style>

