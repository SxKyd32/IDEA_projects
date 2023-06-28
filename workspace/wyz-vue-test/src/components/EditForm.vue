<template>
  <div style="text-align: left">
    <el-button class="add-button" type="success" @click="dialogFormVisible = true">添加员工</el-button>
    <el-dialog
        title="添加/修改员工信息"
        :visible.sync="dialogFormVisible"
        @close="clear">
      <el-form v-model="form" style="text-align: left" ref="dataForm">
        <el-form-item label='姓名' :label-width="formLabelWidth" prop="name">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="员工号" :label-width="formLabelWidth" prop="num">
          <el-input v-model="form.num" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="年龄" :label-width="formLabelWidth" prop="age">
          <el-input v-model="form.age" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="薪资" :label-width="formLabelWidth" prop="salary">
          <el-input v-model="form.salary" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="职称" :label-width="formLabelWidth" prop="pos">
          <el-select v-model="form.pos" placeholder="请选择">
            <el-option label="总经理" value="1"></el-option>
            <el-option label="总监" value="2"></el-option>
            <el-option label="经理" value="3"></el-option>
            <el-option label="主管" value="4"></el-option>
            <el-option label="组长" value="5"></el-option>
            <el-option label="普通员工" value="6"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="id" style="height: 0">
          <el-input type="hidden" v-model="form.id" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="onSubmit">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: 'EditForm',
  data () {
    return {
      dialogFormVisible: false,
      form: {
        id: '',
        name: '',
        num: '',
        age: '',
        salary: '',
        pos: ''
      },
      formLabelWidth: '120px'
    }
  },
  methods: {
    clear () {
      this.form = {
        id: '',
        name: '',
        num: '',
        age: '',
        salary: '',
        pos: ''
      }
    },
    onSubmit () {
      this.$axios
          .post('/worker/add', {
            id: this.form.id,
            name: this.form.name,
            num: this.form.num,
            age: this.form.age,
            salary: this.form.salary,
            pos: this.form.pos
            // eslint-disable-next-line no-unused-vars
          }).then(resp => {
        this.dialogFormVisible = false
        this.$emit('onSubmit').then(this.clear)
      })
    }
  }
}
</script>

<style scoped>
.add-button {
  margin: 18px 0 0 10px;
}
</style>
