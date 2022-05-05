using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace WEBChungKhoan
{
    public partial class ChungKhoan : System.Web.UI.Page
    {
        private SqlConnection connection = new SqlConnection();
        private SqlDataReader myReader;
        private SqlCommand sqlcmd;
        private static string connectionString = "Data Source = DESKTOP-ENDFQT7\\NGOCLINH; Initial Catalog = CHUNGKHOAN; User ID = sa; Password=123;";
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void ShowMessage(string msg)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + msg + "')", true);
        }

        private SqlDataReader ExecSqlDataReader(String strLenh)
        {
            SqlDataReader myreader;
            SqlCommand sqlcmd = new SqlCommand(strLenh, connection);
            sqlcmd.CommandType = CommandType.Text;
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            try
            {
                myreader = sqlcmd.ExecuteReader();
                return myreader;
            }
            catch (SqlException ex)
            {
                connection.Close();
                ShowMessage(ex.Message);
                return null;
            }
        }

        private int KetNoi()
        {
            try
            {
                connection = new SqlConnection(connectionString);
                connection.Open();
                return 1;
            }
            catch (SqlException ex)
            {
                ShowMessage(ex.Message);
                return 0;
            }
        }

        private void Reset()
        {
            txtMaCP.Text = "";
            txtGiaDat.Text = "";
            txtSoLuong.Text = "";
            GridView1.DataBind();
        }

        private bool KTInput()
        {
            if (txtMaCP.Text == "")
            {
                ShowMessage("Vui lòng nhập mã cổ phiếu");
                txtMaCP.Focus();
                return false;
            }

            if (txtSoLuong.Text == "")
            {
                ShowMessage("Vui lòng nhập số lượng đặt");
                txtMaCP.Focus();
                return false;
            }
            else
            {
                try
                {
                    int sl = Int32.Parse(txtSoLuong.Text);
                    if (sl <= 0)
                    {
                        ShowMessage("Số lượng đặt phải là số nguyên dương");
                        txtSoLuong.Focus();
                        return false;
                    }
                }
                catch
                {
                    ShowMessage("Số lượng đặt phải là số nguyên dương");
                    txtSoLuong.Focus();
                    return false;
                }
            }

            if (txtGiaDat.Text == "")
            {
                ShowMessage("Vui lòng nhập giá đặt");
                return false;
            }
            else
            {
                try
                {
                    float giaDat = float.Parse(txtGiaDat.Text);
                    if (giaDat <= 0)
                    {
                        ShowMessage("Giá đặt phải lớn hơn 0");
                        txtGiaDat.Focus();
                        return false;
                    }
                }
                catch
                {
                    ShowMessage("Giá đặt phải lớn hơn 0");
                    txtGiaDat.Focus();
                    return false;
                }
            }

            return true;
        }

        protected void btnDatLenh_Click(object sender, EventArgs e)
        {
            if (KTInput() == false) return; ;
            int i = KetNoi();
            if (i == 0)
            {
                ShowMessage("Lỗi kết nối CSDL!");
                return;
            }
            //
            string maCP = txtMaCP.Text.Trim();
            maCP = maCP.ToUpper();
            string ngayDat = DateTime.Now.ToString();
            String loaiGD = (string) ddLoaiGD.SelectedValue;
            int sl = int.Parse(txtSoLuong.Text);
            float giaDat = float.Parse(txtGiaDat.Text);
            //
            string q = "EXEC sp_KhopLenhLienTuc '" + maCP + "', '" + ngayDat + "', '" + loaiGD + "', " + sl + ", " + giaDat;
            myReader = ExecSqlDataReader(q);
            if (myReader == null)
            {
                return;
            }
            //myReader.Read();
            myReader.Close();
            //
            Reset();
        }

        protected void btnHuy_Click(object sender, EventArgs e)
        {
            Reset();
        }
    }
}