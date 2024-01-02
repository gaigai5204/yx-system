<template>
  <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import echarts from 'echarts'
require('echarts/theme/macarons') // echarts theme
import resize from './mixins/resize'
import { orderByTime } from "@/api/system/order";

const animationDuration = 6000

export default {
  mixins: [resize],
  props: {
    className: {
      type: String,
      default: 'chart'
    },
    width: {
      type: String,
      default: '100%'
    },
    height: {
      type: String,
      default: '300px'
    }
  },
  data() {
    return {
      dateArr:[],
      newDateArr:[],
      barData:[],
      chart: null
    }
  },
  mounted() {
    this.getDate();
    this.$nextTick(() => {
      this.initChart()
    })
  },
  beforeDestroy() {
    if (!this.chart) {
      return
    }
    this.chart.dispose()
    this.chart = null
  },
  methods: {

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
    initChart() {

      // 获取近七天每天的订单数
        orderByTime(1).then(response => {
          var j = 0
          for(var i=6;i>=0;i--){
            if(j==response.rows.length) break
            if(this.dateArr[i].charAt(4)==response.rows[j].dataTime.charAt(9)) {
              // console.log(22222);
              this.barData[i] = response.rows[j].count
              j++
            }
          }
        })

      this.chart = echarts.init(this.$el, 'macarons')

      this.chart.setOption({
        tooltip: {
          trigger: 'axis',
          axisPointer: { // 坐标轴指示器，坐标轴触发有效
            type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
          }
        },
        grid: {
          top: 10,
          left: '2%',
          right: '2%',
          bottom: '3%',
          containLabel: true
        },
        xAxis: [{
          type: 'category',
          // data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          data: this.dateArr,
          axisTick: {
            alignWithLabel: true
          }
        }],
        yAxis: [{
          type: 'value',
          axisTick: {
            show: false
          }
        }],
        series: [{
          name: 'pageA',
          type: 'bar',
          stack: 'vistors',
          barWidth: '60%',
          // data: [79, 52, 200, 334, 390, 330, 220],
          data:this.barData,
          animationDuration
        }, 
        // {
        //   name: 'pageB',
        //   type: 'bar',
        //   stack: 'vistors',
        //   barWidth: '60%',
        //   data: [80, 52, 200, 334, 390, 330, 220],
        //   animationDuration
        // }, {
        //   name: 'pageC',
        //   type: 'bar',
        //   stack: 'vistors',
        //   barWidth: '60%',
        //   data: [30, 52, 200, 334, 390, 330, 220],
        //   animationDuration
        // }
        ]
      })
    }
  }
}
</script>
