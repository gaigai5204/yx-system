<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="订单编号" prop="orderNumber">
        <el-input
          v-model="queryParams.orderNumber"
          placeholder="请输入订单编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="网点名称" prop="orderDept" style="margin-left:30px;">
        <el-select v-model="queryParams.orderDept" placeholder="选择网点" clearable>
          <el-option
            v-for="userItem in userList"
            :key="userItem.userId"
            :label="userItem.nickName"
            :value="userItem.userId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="订单状态" prop="orderStatus">
        <el-select v-model="queryParams.orderStatus" placeholder="订单状态" clearable>
          <el-option
            v-for="dict in dict.type.sys_order_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="创建时间">
        <el-date-picker
          v-model="dateRange"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        ></el-date-picker>
      </el-form-item>
      <br>
      <el-form-item label="下单电话" prop="partyPhone">
        <el-input
          v-model="queryParams.partyPhone"
          placeholder="请输入下单电话"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="接单电话" prop="postmanPhone" style="margin-left:30px;">
        <el-input
          v-model="queryParams.postmanPhone"
          placeholder="请输入接单电话"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item style="margin-left:40px;">
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:post:add']"
        >新增订单信息</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:post:remove']"
        >批量删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:post:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="orderList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="订单编号" align="center" prop="orderNumber" />
      <el-table-column label="所属网点" align="center" prop="user.nickName" />
      <el-table-column label="寄件地址" align="center" prop="orderFromAddress" />
      <el-table-column label="收件地址" align="center" prop="orderToAddress" />
      <el-table-column label="订单价格" align="center" prop="orderPrice" />
      <el-table-column label="订单状态" align="center" prop="orderStatus">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_order_status" :value="scope.row.orderStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-search"
            @click="lookDetail(scope.row)"
          >查看</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:post:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-add-location"
            @click="handleAddTran(scope.row)"
          >路线</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:post:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
    <!-- 查看订单对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="650px">
      <el-descriptions :column="2" border>
        <el-descriptions-item labelStyle="width: 120px">
          <template slot="label">
            <i class="el-icon-paperclip"></i>
            订单编号
          </template>
          {{orderDetail.orderNumber}}
        </el-descriptions-item>        
        <el-descriptions-item labelStyle="width: 120px">
          <template slot="label">
            <i class="el-icon-place"></i>
            所属网点
          </template>
          {{orderDetail.user.nickName}}
        </el-descriptions-item>

        <el-descriptions-item labelStyle="width: 120px">
          <template slot="label">
            <i class="el-icon-user"></i>
            下单用户
          </template>
          {{orderDetail.party.partyName}}
        </el-descriptions-item>        
        <el-descriptions-item labelStyle="width: 120px">
          <template slot="label">
            <i class="el-icon-phone-outline"></i>
            下单电话
          </template>
          {{orderDetail.party.phonenumber}}
        </el-descriptions-item>

        <el-descriptions-item labelStyle="width: 120px">
          <template slot="label">
            <i class="el-icon-user"></i>
            接单账号
          </template>
          {{orderDetail.postman.userName}}
        </el-descriptions-item>        
        <el-descriptions-item labelStyle="width: 120px">
          <template slot="label">
            <i class="el-icon-phone-outline"></i>
            接单电话
          </template>
          {{orderDetail.postman.phonenumber}}
        </el-descriptions-item>

        <el-descriptions-item labelStyle="width: 120px">
          <template slot="label">
            <i class="el-icon-goods"></i>
            订单价格
          </template>
          {{orderDetail.orderPrice}}
        </el-descriptions-item>        
        <el-descriptions-item labelStyle="width: 120px">
          <template slot="label">
            <i class="el-icon-truck"></i>
            订单状态
          </template>
          <dict-tag :options="dict.type.sys_order_status" :value="orderDetail.orderStatus"/>
        </el-descriptions-item>

        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-user"></i>
            寄件姓名
          </template>
          {{orderDetail.orderFromName}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-mobile-phone"></i>
            寄件电话
          </template>
          {{orderDetail.orderFromPhone}}
        </el-descriptions-item>
        <el-descriptions-item span=3>
          <template slot="label">
            <i class="el-icon-office-building"></i>
            寄件地址
          </template>
          {{orderDetail.orderFromAddress}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-user"></i>
            收件姓名
          </template>
          {{orderDetail.orderToName}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-mobile-phone"></i>
            收件电话
          </template>
          {{orderDetail.orderToPhone}}
        </el-descriptions-item>
        <el-descriptions-item span=3>
          <template slot="label">
            <i class="el-icon-location-outline"></i>
            收件地址
          </template>
          {{orderDetail.orderToAddress}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-tickets"></i>
            备注
          </template>
          <el-tag size="small">{{orderDetail.remark}}</el-tag>
        </el-descriptions-item>
      </el-descriptions>
      <!-- <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="订单编号" prop="orderNumber">
          <el-input v-model="form.orderNumber" placeholder="请输入岗位名称" readonly/>
        </el-form-item>
        <el-form-item label="所属网点" prop="orderDept">
          <el-input v-model="form.orderDept" placeholder="请输入编码名称" readonly/>
        </el-form-item>
        <el-form-item label="寄件地址" prop="orderFromAddress">
          <el-input-number v-model="form.orderFromAddress" controls-position="right" :min="0" />
        </el-form-item>
        <el-form-item label="寄件人姓名" prop="orderFromName">
          <el-input v-model="form.orderFromName" placeholder="请输入编码名称" readonly/>
        </el-form-item>
        <el-form-item label="寄件人电话" prop="orderFromPhone">
          <el-input v-model="form.orderFromPhone" placeholder="请输入编码名称" readonly/>
        </el-form-item>
        <el-form-item label="收件地址" prop="orderToAddress">
          <el-input-number v-model="form.orderToAddress" controls-position="right" :min="0" />
        </el-form-item>
        <el-form-item label="收件人姓名" prop="orderToName">
          <el-input v-model="form.orderToName" placeholder="请输入编码名称" readonly/>
        </el-form-item>
        <el-form-item label="收件人电话" prop="orderToPhone">
          <el-input v-model="form.orderToPhone" placeholder="请输入编码名称" readonly/>
        </el-form-item>
        <el-form-item label="创建时间" prop="creatTime">
          <el-input v-model="form.creatTime" placeholder="请输入编码名称" readonly/>
        </el-form-item>
        <el-form-item label="订单状态" prop="orderStatus">
          <el-radio-group v-model="form.orderStatus">
            <el-radio
              v-for="dict in dict.type.sys_normal_disable"
              :key="dict.value"
              :label="dict.value"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form> -->
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="cancel">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

        <!-- 添加或修改岗位对话框 -->
    <el-dialog :title="title" :visible.sync="openAdd" width="1100px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <!-- <el-form-item label="订单编号" prop="orderNumber">
          <el-input v-model="form.orderNumber" placeholder="请输入岗位名称"/>
        </el-form-item> -->
        <el-row>
        <el-col :span="23" style="margin-left:20px;margin-top:-15px;">
          <el-card shadow="hover" style="margin-bottom:20px;">
            <div slot="header" class="clearfix">
              <span>基础信息</span>
            </div>   
            <el-col :span="6">
              <el-form-item label="所属网点" prop="orderDept">
                <el-select v-model="form.orderDept" placeholder="所属网点" clearable>
                  <el-option
                    v-for="dict in userList"
                    :key="dict.userId"
                    :label="dict.nickName"
                    :value="dict.userId"
                  />
                </el-select>
                <!-- <el-input v-model="form.orderDept" placeholder="请输入网点id"/> -->
              </el-form-item>            
            </el-col>
            <el-col :span="5">
              <el-form-item label="订单重量" prop="orderWeight" style="margin-left:10px;">
                <el-input v-model="form.orderWeight" placeholder="订单重量" style="width:70px;"/>
                <span style="margin-left:8px;font-size:17px;">kg</span>
              </el-form-item>         
            </el-col>

            <el-col :span="6">
              <el-form-item label="下单电话" prop="party"  maxlength="11" style="margin-left:10px;">
                <el-input v-model="form.party.phonenumber" placeholder="请输入下单电话"/>
              </el-form-item>            
            </el-col>
            <el-col :span="6">
              <el-form-item label="接单电话"  maxlength="11" style="margin-left:10px;">
                <el-input v-model="form.postman.phonenumber" placeholder="请输入接单电话"/>
              </el-form-item>            
            </el-col>
          </el-card>
        </el-col>
        <el-col :span="11" style="margin-left:20px;">
          <el-card shadow="hover" style="margin-bottom:20px;">
            <div slot="header" class="clearfix">
              <span>寄件信息</span>
              <el-dropdown @command="handleCommand">
                <span class="el-dropdown-link" style="margin-left:140px;">
                  地址簿<i class="el-icon-arrow-down el-icon--right"></i>
                </span>
                <el-dropdown-menu slot="dropdown" style="margin-left:60px;">
                  <el-dropdown-item 
                  v-for="addrItem in addrListFrom"
                  :key="addrItem.index"
                  :command="{addrName:addrItem.addrName,addrPhone:addrItem.addrPhone,addrDetail:addrItem.addrDetail}"
                  style="padding-top:10px;"
                  ><div>
                  <div class="addrName">{{addrItem.addrName}}</div>
                  <div class="addrPhone">{{addrItem.addrPhone}}</div>
                  <div class="addrDetail">{{addrItem.addrDetail}}</div>                    
                  </div>

                </el-dropdown-item>
                </el-dropdown-menu>
              </el-dropdown>
              <!-- <span style="margin-left:140px;">地址簿</span> -->
              <span class="el-dropdown-link" style="float:right;" @click="addToAddrFrom()">添加到地址簿</span>
            </div>  
          <el-col :span="11">
            <el-form-item label="寄件姓名" prop="orderFromName">
              <el-input v-model="form.orderFromName" placeholder="请输入寄件姓名"/>
            </el-form-item>            
          </el-col>
          <el-col :span="13">
            <el-form-item label="寄件电话" prop="orderFromPhone"  maxlength="11" style="margin-left:10px;">
              <el-input v-model="form.orderFromPhone" placeholder="请输入寄件电话"/>
            </el-form-item>            
          </el-col>
          <el-col :span="24">
            <el-form-item label="寄件地址" prop="orderFromAddress">
              <el-cascader
                size="large"
                :options="optionsFrom"
                v-model="selectedOptionsFrom"
                @change="handleChangeFrom">
              </el-cascader>
             <el-button @click="initAMapOne()" type="primary" style="margin-left: 16px;">
                地图定位
              </el-button>
              <el-drawer
                :visible.sync="showMap"
                :append-to-body="true"
                :with-header="false">
                <div class="amap-demo">
              
                  <Map ref="map" @updateLocation="updateLocation" :getChildInfo="getChildInfo"/>
                </div>     
              </el-drawer>
 

              <el-input style="margin-top:10px;" v-model="form.orderFromAddress" placeholder="请输入详细地址"/>
            </el-form-item>            
          </el-col>
        </el-card>
      </el-col>

      <el-col :span="1">
      <el-form-item></el-form-item>
      </el-col>

        <el-col :span="11">
          <el-card shadow="hover" style="margin-bottom:20px;">
            <div slot="header" class="clearfix">
              <span>收件信息</span>
              <el-dropdown @command="handleCommand">
                <span class="el-dropdown-link" style="margin-left:140px;">
                  地址簿<i class="el-icon-arrow-down el-icon--right"></i>
                </span>
                <el-dropdown-menu slot="dropdown" style="margin-left:60px;">
                  <el-dropdown-item 
                  v-for="addrItem in addrListTo"
                  :key="addrItem.index"
                  :command="{addrName:addrItem.addrName,addrPhone:addrItem.addrPhone,addrDetail:addrItem.addrDetail}"
                  style="padding-top:10px;"
                  ><div>
                  <div class="addrName">{{addrItem.addrName}}</div>
                  <div class="addrPhone">{{addrItem.addrPhone}}</div>
                  <div class="addrDetail">{{addrItem.addrDetail}}</div>                    
                  </div>

                </el-dropdown-item>
                </el-dropdown-menu>
              </el-dropdown>
              <!-- <span style="margin-left:140px;">地址簿</span> -->
              <span class="el-dropdown-link" style="float:right;" @click="addToAddrTo()">添加到地址簿</span>
            </div>  
          <el-col :span="11">
            <el-form-item label="收件姓名" prop="orderToName">
              <el-input v-model="form.orderToName" placeholder="请输入收件姓名"/>
            </el-form-item>            
          </el-col>
          <el-col :span="13">
            <el-form-item label="收件电话" prop="orderToPhone" style="margin-left:10px;">
              <el-input v-model="form.orderToPhone" placeholder="请输入收件电话"  maxlength="11"/>
            </el-form-item>            
          </el-col>
          <el-col :span="24">
            <el-form-item label="收件地址" prop="orderToAddress">
              <el-cascader
                size="large"
                :options="optionsTo"
                v-model="selectedOptionsTo"
                @change="handleChangeTo">
              </el-cascader>
              <el-button @click="initAMapOne()" type="primary" style="margin-left: 16px;">
                地图定位
              </el-button>
              <el-drawer
                :visible.sync="showMapOne"
                :append-to-body="true"
                :with-header="false">
                <div class="amap-demo">
                  <Map ref="map" @updateLocation="updateLocationOne" :getChildInfo="getChildInfo"/>
                </div>     
              </el-drawer>
              <el-input v-model="form.orderToAddress" placeholder="请输入收件地址" style="margin-top:10px;"/>
            </el-form-item>            
          </el-col>
        </el-card>
      </el-col>

      <el-col :span="23" style="margin-left:20px;">
        <el-card shadow="hover" style="margin-bottom:-18px;">
          <div slot="header" class="clearfix">
            <span>补充信息</span>

          </div>   
          <el-col :span="17">
            <el-form-item label="订单状态" prop="orderStatus">
              <el-radio-group v-model="form.orderStatus">
                <el-radio
                  v-for="dict in dict.type.sys_order_status"
                  :key="dict.value"
                  :label="dict.value"
                >{{dict.label}}</el-radio>
              </el-radio-group>
            </el-form-item>            
          </el-col>
            <el-col :span="4" >
              <el-form-item label="订单价格" prop="orderPrice" >
                <el-input v-model="form.orderPrice" placeholder="订单价格" style="width:60px;"/>
                <span style="margin-left:8px;font-size=17px;" >元</span>
              </el-form-item>            
            </el-col>
              <el-col :span="3" style="float:right;">
              <el-form-item label="计算价格">
                ：{{orderPrice}}
              </el-form-item>            
            </el-col>
          <el-col :span="23">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
            </el-form-item>              
          </el-col>
        </el-card>
      </el-col>
    </el-row>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>

    </el-dialog>

    <!-- <div class="amap-page-container" v-show="showMap">
     <el-amap vid="amap" :plugin="plugin" class="amap-demo" :center="center" :zoom="zoom" :events='events'>
       
       <el-amap-marker v-for="(marker, index) in markers" :key="marker.index" :position="marker.position"
              :icon="marker.icon" :title="marker.title" :events="marker.events" :visible="marker.visible"
              :draggable="marker.draggable" :vid="index"></el-amap-marker>
     </el-amap>
   </div> -->

  </div>
</template>

<script>

import { listOrder, getOrder, addOrder, updateOrder,delOrder,getCountByTime, orderByTime, getPost, delPost, addPost, updatePost } from "@/api/system/order";
import { insertTran } from "@/api/system/orderTran";
import { provinceAndCityData, regionData, provinceAndCityDataPlus, regionDataPlus, CodeToText, TextToCode } from 'element-china-area-data';
import { listUser } from "@/api/system/user";
import { listAddr,addAddr } from "@/api/system/addr";

import { getPartyByPhone } from "@/api/system/party";
import { getPostmanByPhone } from "@/api/system/postman";
import Map from '@/views/system/aliMap.vue'
const _ = require("lodash"); 
export default {
  name: "Order",
  dicts: ['sys_normal_disable','sys_order_status'],
  components: {
      Map
  },
  data() {
    let self = this;
      // const AddressRequired=(rule,value,callback)=>{
      //   if(this.selectedOptions === '') {
      //       callback(new Error('请选择省市区/县'))
      //   } else if (this.form.orderFromAddress === '') {
      //       callback(new Error('请填写详细地址'))
      //   } else {
      //       callback()
      // }
      // return{
      //   rules:{
      //             orderFromAddress: [
      //     { required: true,validator:AddressRequired, message: "寄件地址不能为空", trigger: "blur" }
      //   ]
      //   }
      // }
      // }
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      dateRange: [],
      orderPriceOne:0,
      nowAddress:'',
      listOrder: [],
      orderList: [],
      userList: [],
      addrListFrom:[],
      addrListTo:[],
      orderDetail:{user:{},party:{},postman:{}},
      lineData:{},
      countyOptions:{},
      //地址插件
      optionsTo: regionData,
      selectedOptionsTo: [],
      optionsFrom: regionData,
      selectedOptionsFrom: [],
      showMap:false,
      showMapOne:false,
        
      readonly: true,
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      openAdd: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        orderId: undefined,
        orderNumber: undefined,
        postmanPhone: undefined,
        partyPhone: undefined,
        orderParty: undefined,
        orderPostman: undefined,
        orderDept: undefined
      },
      // 表单参数
      form: {
        orderId: undefined,
        orderNumber: undefined,
        orderDept: undefined,
        partyPhone: undefined,
        postman: {},
        party:{},
        orderWeight: 1,
        orderPrice: undefined,
        orderFromAddress: '',

        orderFromName: undefined,
        orderFromPhone: undefined,
        orderToAddress: '',

        orderToName: undefined,
        orderToPhone: undefined,
        orderStatus: "3",
        remark: undefined
      },
      // 表单校验
      rules: {
        orderDept: [
          { required: true, message: "所属网点不能为空", trigger: "blur" }
        ],
        orderPrice: [
          { required: true, message: "订单价格不能为空", trigger: "blur" }
        ],
        orderWeight: [
          { required: true, message: "订单重量不能为空", trigger: "blur" }
        ],
        orderFromName: [
          { required: true, message: "寄件姓名不能为空", trigger: "blur" }
        ],
        party: [
          { required: true, message: "下单电话不能为空", trigger: "blur" }
        ],
        orderFromPhone: [
          {
            pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
            message: "请输入正确的手机号码",
            trigger: "blur"
          },
          { required: true, message: "寄件电话不能为空", trigger: "blur" }
        ],
        orderFromAddress: [
          { required: true, message: "寄件地址不能为空", trigger: "blur" }
        ],
        orderToName: [
          { required: true, message: "收件姓名不能为空", trigger: "blur" }
        ],
        orderToPhone: [
          {
            pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
            message: "请输入正确的手机号码",
            trigger: "blur"
          },
          { required: true, message: "收件电话不能为空", trigger: "blur" }
        ],
        orderToAddress: [
          { required: true, message: "收件地址不能为空", trigger: "blur" }
        ]
      },

    };
  },
  created() {
    this.getList();
    getCountByTime(1).then(res=>{
      console.log(res)
    })
    orderByTime(this.queryParams).then(res=>{
      console.log(res)
    })
    listUser(this.queryParams).then(res => {
      this.userList = res.rows;
      console.log(this.userList)
    })
  },
  methods: {
    handleCommand(command) {
      console.log(command)
      this.form.orderFromAddress=command.addrDetail
      this.form.orderFromPhone=command.addrPhone
      this.form.orderFromName=command.addrName
    },
    addToAddrFrom(){
      let formAddr={}
      formAddr.addrDetail=this.form.orderFromAddress
      formAddr.addrPhone=this.form.orderFromPhone+''
      formAddr.addrName=this.form.orderFromName
      formAddr.addrType='1'
      getPartyByPhone(this.form.party.phonenumber).then(response => {  
        formAddr.addrParty=response.data.partyId
        console.log(formAddr)
        addAddr(formAddr).then(res=>{
        console.log(res);
        this.$modal.msgSuccess("地址簿新增成功");
  })

}); 
    },

    addToAddrTo(){
      let formAddr={}
      formAddr.addrDetail=this.form.orderFromAddress
      formAddr.addrPhone=this.form.orderFromPhone+''
      formAddr.addrName=this.form.orderFromName
      formAddr.addrType='2'
      getPartyByPhone(this.form.party.phonenumber).then(response => {  
        formAddr.addrParty=response.data.partyId
        console.log(formAddr)
        addAddr(formAddr).then(res=>{
        console.log(res);
        this.$modal.msgSuccess("地址簿新增成功");
  })

}); 
    },
    /** 查询岗位列表 */
    getList() {
      this.loading = true;
      listOrder(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.orderList = response.rows;
        //console.log(this.orderList)
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.openAdd = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        orderId: undefined,
        orderNumber: undefined,
        orderDept: undefined,
        orderPrice: undefined,
        partyPhone: undefined,
        orderWeight: 1,
        postman:{},
        party:{},
        orderFromAddress: '',
        orderFromName: undefined,
        orderFromPhone: undefined,
        orderToAddress: '',
        orderToName: undefined,
        orderToPhone: undefined,
        orderStatus: "3",
        remark: undefined
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      if(this.queryParams.partyPhone!=undefined&&this.queryParams.partyPhone!=""){
        console.log(this.queryParams.partyPhone)
        getPartyByPhone(this.queryParams.partyPhone).then(res=>{
          if(res.data!=null)
            this.queryParams.orderParty=res.data.partyId;
          else
            this.queryParams.orderParty=9999999
          if(this.queryParams.postmanPhone!=undefined&&this.queryParams.postmanPhone!=""){
            getPostmanByPhone(this.queryParams.postmanPhone).then(res=>{
              if(res.data!=null)
                this.queryParams.orderPostman=res.data.userId;
              else
                this.queryParams.orderPostman=9999999
              this.getList();
            })   
          }  
          else{
            this.queryParams.orderPostman=undefined
            this.getList();
          }
        })
      }else{
        if(this.queryParams.postmanPhone!=undefined&&this.queryParams.postmanPhone!=""){
          getPostmanByPhone(this.queryParams.postmanPhone).then(res=>{
            if(res.data!=null)
              this.queryParams.orderPostman=res.data.userId;
            else
              this.queryParams.orderPostman=9999999
            this.getList();
          })   
        }  
        else{
          this.queryParams.orderPostman=undefined
          this.getList();
        }
        this.queryParams.orderParty=undefined
        this.getList();
      }
 
      
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.dateRange = [];
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.orderId)
      this.single = selection.length!=1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.openAdd = true;
      this.title = "新增订单";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const orderId = row.orderId || this.ids
      getOrder(orderId).then(response => {
        this.form = response.data;
        console.log(response.data)
        
        this.openAdd = true;
        this.title = "修改订单";

      });
    },
    //新增订单路线
    handleAddTran(row){
      this.reset();
      const orderId = row.orderId || this.ids
      getOrder(orderId).then(response => {
        this.form = response.data;
        console.log(response.data)
        let formTran={}
        formTran.orderNumber=response.data.orderNumber
        formTran.orderTran="[]"
        console.log(formTran)
          insertTran(formTran).then(res => {
            this.$modal.msgSuccess("新增路线成功");
            console.log(res)
          })

      });
    },
    // 查看订单详情
    lookDetail(row){
      this.reset();
      const orderId = row.orderId || this.ids
      getOrder(orderId).then(res => {
        console.log(res)
        this.orderDetail=res.data
      })
      this.open = true;
      this.title = "查看订单";
    },
    /** 提交按钮 */
    submitForm: function() {
      console.log(this.form.orderPostman)
      if(this.form.postman.phonenumber==undefined){
        this.form.postman.phonenumber='15888888888'
      }
      this.$refs["form"].validate(valid => {
        if (valid) {
          console.log(this.form.partyPhone)
          if(this.form.postman.phonenumber==undefined){
            getPartyByPhone(this.form.partyPhone).then(response => {
              if(response.data==null){
                this.$modal.msgError("下单用户不存在");
              }            
              this.form.orderParty=response.data.partyId;
              if (this.form.orderId != undefined) {
                console.log(this.form.orderParty)
                updateOrder(this.form).then(response => {
                  this.$modal.msgSuccess("修改成功");
                  this.openAdd = false;
                  this.getList();
                });
              } else {
                addOrder(this.form).then(response => {
                  this.$modal.msgSuccess("新增成功");
                  this.openAdd = false;
                  this.getList();
                });
              }   
            });    
          }
          else{
            getPartyByPhone(this.form.party.phonenumber).then(response => {
              if(response.data==null){
                this.$modal.msgError("下单用户不存在");
              }            
              this.form.orderParty=response.data.partyId;
              getPostmanByPhone(this.form.postman.phonenumber).then(res=>{
                if(res.data==null){
                  this.$modal.msgError("快递员不存在");
                }            
                this.form.orderPostman=res.data.userId;

                if (this.form.orderId != undefined) {
                  console.log(this.form.orderParty)
                  updateOrder(this.form).then(response => {
                    console.log('???')
                    this.$modal.msgSuccess("修改成功");
                    this.openAdd = false;
                    this.getList();
                  });
                } else {
                addOrder(this.form).then(response => {

                    this.$modal.msgSuccess("新增成功");
                    this.openAdd = false;
                    this.getList();
                  });
                }                
              })




            
            });            
          }

        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const orderIds = row.orderId || this.ids;
      const orderNumbers = row.orderNumber || this.ids;
      this.$modal.confirm('是否确认删除订单编号为"' + orderNumbers + '"的数据项？').then(function() {
        return delOrder(orderIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('system/order/export', {
        ...this.queryParams
      }, `order_${new Date().getTime()}.xlsx`)
    },


    handleChangeFrom (value) {
      let addressVar=this.form.orderFromAddress
      if(addressVar.split("县")[1] !=undefined){
        var codeArray = this.form.orderFromAddress.split("县")[1] || "";
      }
        
      else if(addressVar.split("区")[1] !=undefined)
        var codeArray = this.form.orderFromAddress.split("区")[1] || "";
      else
        var codeArray = this.form.orderFromAddress;
      if(codeArray!=-1){
        this.form.orderFromAddress=this.getCodeToText(value)+codeArray
      }else{
        this.form.orderFromAddress=this.getCodeToText(value)+this.form.orderFromAddress
      }
      
    },

    handleChangeTo (value) {

      let addressVar=this.form.orderToAddress
      if(addressVar.split("县")[1] !=undefined){
        var codeArray = this.form.orderToAddress.split("县")[1] || "";
      }
        
      else if(addressVar.split("区")[1] !=undefined)
        var codeArray = this.form.orderToAddress.split("区")[1] || "";
      else
        var codeArray = this.form.orderToAddress;
      if(codeArray!=-1){
        this.form.orderToAddress=this.getCodeToText(value)+codeArray
      }else{
        this.form.orderToAddress=this.getCodeToText(value)+this.form.orderToAddress
      }
      
      //console.log(this.form.orderToAddress);
      
    },

    //编码转为省市县/区
    getCodeToText(codeArray) {
          if (null === codeArray) {
            return null;
          } 
          let area = "";
          switch (codeArray.length) {
            case 1:
              area += CodeToText[codeArray[0]];
              break;
            case 2:
              area += CodeToText[codeArray[0]] + "/" + CodeToText[codeArray[1]];
              break;
            case 3:
              area +=
                CodeToText[codeArray[0]] +
                "" +
                CodeToText[codeArray[1]] +
                "" +
                CodeToText[codeArray[2]]+
                "" ;
              break;
            default:
              break;
          }
          return area;
        },
        

// initAMap(spot) {

//   AMapLoader.load({
//     key: '3203e0072d38c73e6ca542fd962b7221',  //设置您的key
//     version: "2.0",
//     plugins: ['AMap.ToolBar', 'AMap.Driving'],
//     AMapUI: {
//       version: "1.1",
//       plugins: [],
//     },
//     Loca: {
//       version: "2.0"
//     },
//   }).then((AMap) => {
//     this.map = new AMap.Map("container", {
//       resizeEnable: true,
//       center: [111.744718,40.78836],
//       zoom: 7
//     });
//     this.map.on('click',this.getLatLng);
//     if(spot!=null&&spot.length>1){
//       var marker = new AMap.Marker({
//         // icon: 'https://vdata.amap.com/icons/b18/1/2.png',
//         position: spot
//       });
//       this.map.add(marker)
//     }
//   }).catch(e => {
//   });
// },
// //地图点击事件
// getLatLng(e){
//   var that=this;
//   this.map.clearMap();
//   that.form.lat=e.lnglat.getLat();
//   that.form.lng=e.lnglat.getLng();
//   var marker = new AMap.Marker({
//     // icon: 'https://vdata.amap.com/icons/b18/1/2.png',
//     position: [e.lnglat.lng, e.lnglat.lat]
//   });
//   this.map.add(marker);
//   var geocoder;
//   this.map.plugin(["AMap.Geocoder"], function() {
//     geocoder = new AMap.Geocoder({
//       city:'全国'
//     });
//     var lnglat=[e.lnglat.lng, e.lnglat.lat];
//     geocoder.getAddress(lnglat,function (status,result){
//       if (status === "complete" && result.info === "OK") {
//         //城市
//         that.form.city=(result.regeocode.addressComponent.city).replace("市","");
//         console.log(that.form.city)
//         //详细地址
//         that.form.projectAddress=result.regeocode.formattedAddress
//       }
//     })
//   });
// },
initAMap(){
  this.showMap=!this.showMap;
},
initAMapOne(){
  this.showMapOne=!this.showMapOne;
  this.form.orderFromAddress=this.nowAddress;
},
getChildInfo(x){
    this.form.orderFromAddress=x;
    this.nowAddress=x;
},



        updateLocation(Addr) {
            console.log('位置信息：',Addr)
            this.form.orderFromAddress=Addr.orgAddr
        },
        updateLocationOne(Addr) {
            console.log('位置信息：',Addr)
            this.form.orderToAddress=Addr.orgAddr
        }


  },
  watch: {
    immediate: true,
    'form.party.phonenumber'(newV, oldV) {
      let self=this 
      console.log("watch", newV, oldV)
          getPartyByPhone(newV).then(response => {          
            listAddr(response.data.partyId).then(res=>{
              console.log(res);
              let indexVar=0
              let indexVarTo=0
              self.addrListFrom=res.rows;
              self.addrListTo=res.rows;
              res.rows.forEach((item,index) =>{
                if(item.addrType=='1'){
                   self.addrListFrom[indexVar]=item
                   console.log(self.addrListFrom)
                   indexVar++
                }
                if(item.addrType=='2'){
                   self.addrListTo[indexVarTo]=item
                   indexVarTo++
                }
              });

              // self.addrList=res.rows;
            })
  
          });  
        
    },
  },
  computed:{
    orderPrice: function(){

        this.form.orderPrice=this.form.orderWeight*10+10*(1-(this.form.orderFromAddress.substring(0,2)==this.form.orderToAddress.substring(0,2)))
        return this.form.orderWeight*10+10*(1-(this.form.orderFromAddress.substring(0,2)==this.form.orderToAddress.substring(0,2)))
     
    }
  }
};
</script>
<style scoped>
.amap-demo {
  position: absolute;
  width:100%;
  height: 300px;
}
  .el-dropdown-link {
    cursor: pointer;
    color: #409EFF;
  }
  .el-icon-arrow-down {
    font-size: 12px;
  }
  .addrDetail{
    display: inline-block;
    overflow: hidden;
    text-overflow:ellipsis;
    white-space: nowrap;
    width: 190px;
  }
  .addrName{
    display: inline-block;
    overflow: hidden;
    text-overflow:ellipsis;
    white-space: nowrap;
    width: 60px;
  }
  .addrPhone{
    display: inline-block;
    overflow: hidden;
    text-overflow:ellipsis;
    white-space: nowrap;
    width: 100px;
  }
</style>