<template>
  <el-row :gutter="40" class="panel-group">
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="handleSetLineChartData('newVisitis')">
        <div class="card-panel-icon-wrapper icon-people">
          <svg-icon icon-class="todayOrder" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            <!-- 访客 -->
            今日订单
          </div>
          <count-to :start-val="0" :end-val="dayOrder" :duration="2600" class="card-panel-num" />
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="handleSetLineChartData('messages')">
        <div class="card-panel-icon-wrapper icon-message">
          <svg-icon icon-class="weekOrder" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            <!-- 消息 -->
            本周订单
          </div>
          <count-to :start-val="0" :end-val="weekOrder" :duration="3000" class="card-panel-num" />
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="handleSetLineChartData('purchases')">
        <div class="card-panel-icon-wrapper icon-money">
          <svg-icon icon-class="mounthOrder" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            <!-- 金额 -->
            本月订单
          </div>
          <count-to :start-val="0" :end-val="monthOrder" :duration="3200" class="card-panel-num" />
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="handleSetLineChartData('shoppings')">
        <div class="card-panel-icon-wrapper icon-shopping">
          <svg-icon icon-class="allOrder" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            网点订单
          </div>
          <count-to :start-val="0" :end-val="allOrder" :duration="3600" class="card-panel-num" />
        </div>
      </div>
    </el-col>
  </el-row>
</template>

<script>
import CountTo from 'vue-count-to'
import {  listOrder,getCountByTime, orderByTime } from "@/api/system/order";

export default {
  data(){
    return {
      dayOrder:0,
      weekOrder:0,
      monthOrder:0,
      allOrder:0,
      queryParams: {
        pageNum: 1,
        pageSize: 10000,
        noticeTitle: undefined,
        createBy: undefined,
        status: undefined
      },
    }
  },
  components: {
    CountTo
  },
  methods: {
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
      listOrder(this.queryParams).then(response => {
        this.allOrder = response.rows.length;
        console.log(response.rows)
        //console.log(this.orderList)
        // this.total = response.total;
        // this.loading = false;
      });
    },
    handleSetLineChartData(type) {
      this.$emit('handleSetLineChartData', type)
    }
  },
  created(){
    // this.getDate();
  },
  mounted() {
    this.getData();
    // this.getDate();
  },
}
</script>

<style lang="scss" scoped>
.panel-group {
  margin-top: 18px;

  .card-panel-col {
    margin-bottom: 32px;
  }

  .card-panel {
    height: 108px;
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, .05);
    border-color: rgba(0, 0, 0, .05);

    &:hover {
      .card-panel-icon-wrapper {
        color: #fff;
      }

      .icon-people {
        background: #ffa0a0;
      }

      .icon-message {
        background: #ffe6b0;
      }

      .icon-money {
        background: #c9bcff;
      }

      .icon-shopping {
        background: #9edff3
      }
    }

    .icon-people {
      color: #40c9c6;
    }

    .icon-message {
      color: #36a3f7;
    }

    .icon-money {
      color: #f4516c;
    }

    .icon-shopping {
      color: #34bfa3
    }

    .card-panel-icon-wrapper {
      float: left;
      margin: 14px 0 0 14px;
      padding: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
    }

    .card-panel-icon {
      float: left;
      font-size: 48px;
    }

    .card-panel-description {
      float: right;
      font-weight: bold;
      margin: 26px;
      margin-left: 0px;

      .card-panel-text {
        line-height: 18px;
        color: rgba(0, 0, 0, 0.45);
        font-size: 16px;
        margin-bottom: 12px;
      }

      .card-panel-num {
        font-size: 20px;
      }
    }
  }
}

@media (max-width:550px) {
  .card-panel-description {
    display: none;
  }

  .card-panel-icon-wrapper {
    float: none !important;
    width: 100%;
    height: 100%;
    margin: 0 !important;

    .svg-icon {
      display: block;
      margin: 14px auto !important;
      float: none !important;
    }
  }
}
</style>
