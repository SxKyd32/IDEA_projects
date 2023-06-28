<template>
  <div id="building">
  <div>
    <edit-form @onSubmit="loadWorker()" ref="edit"></edit-form>
    <el-card style="margin: 18px 2%;width: 95%">
      <el-table
          :data="worker"
          stripe
          style="width: 100%"
          :max-height="tableHeight">
        <el-table-column
            prop="worker.name"
            label="姓名"
            fit>
        </el-table-column>
        <el-table-column
            prop="posName"
            label="职称"
            width="100">
        </el-table-column>
        <el-table-column
            prop="worker.num"
            label="员工号"
            fit>
        </el-table-column>
        <el-table-column
            prop="worker.age"
            label="年龄"
            width="120">
        </el-table-column>
        <el-table-column
            prop="worker.salary"
            label="薪资"
            fit>
        </el-table-column>
        <!--<el-table-column-->
        <!--prop="abs"-->
        <!--label="摘要"-->
        <!--show-overflow-tooltip-->
        <!--fit>-->
        <!--</el-table-column>-->
        <el-table-column
            fixed="right"
            label="操作"
            width="120">
          <template slot-scope="scope">
            <el-button
                @click.native.prevent="editWorker(scope.row)"
                type="text"
                size="small">
              编辑
            </el-button>
            <el-button
                @click.native.prevent="deleteWorker(scope.row.worker.id)"
                type="text"
                size="small">
              移除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
  </div>
</template>

<script>
import EditForm from "@/components/EditForm";
export default {
  name: 'WorkerManagement',
  components: {EditForm},
  data () {
    return {
      worker: []
    }
  },
  mounted () {
    this.loadWorker()
  },
  computed: {
    tableHeight () {
      return window.innerHeight - 320
    }
  },
  methods: {
    deleteWorker (id) {
      this.$confirm('此操作将永久删除该员工信息,是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
            this.$axios
                // eslint-disable-next-line no-unused-vars
                .get('/worker/delete/' + id).then(res => {
                  this.loadWorker()
                }
            )
          }
      ).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })
    },
    editWorker (item) {
      this.$refs.edit.dialogFormVisible = true
      this.$refs.edit.form = {
        id: item.worker.id,
        name: item.worker.name,
        num: item.worker.num,
        age: item.worker.age,
        salary: item.worker.salary,
        pos: item.posName
      }
      // this.$refs.edit.category = {
      //   id: item.category.id.toString()
      // }
    },
    loadWorker () {
      var _this = this
      this.$axios.get('/workers').then(resp => {
        _this.worker = resp.data
      })
    }
  }
}
</script>

<style scoped>
#building {
  background: url("../../assets/manage_bg.jpg");
  width: 100%;
  height: 100%;
  position: fixed;
  background-size: 100% 100%;
}
</style>
