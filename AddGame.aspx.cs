using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace CIS560_Team9_NBA_App
{
    public partial class AddGame : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            try { 
            con.ConnectionString = "Data Source=560final.database.windows.net;Initial Catalog=NBALeague;User ID=Team9;Password=tzdkD4mW";


            SqlCommand cmd = new SqlCommand("League.AddGame", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // If you are passing any parameters to your Stored procedure 
            cmd.Parameters.AddWithValue("@HomeTeam", SqlDbType.NVarChar).Value = HTName_input.Text.Trim();
            cmd.Parameters.AddWithValue("@AwayTeam", SqlDbType.NVarChar).Value = ATName_input.Text.Trim();
            cmd.Parameters.AddWithValue("@Arena", SqlDbType.NVarChar).Value = Arena_input.Text.Trim();
            cmd.Parameters.AddWithValue("@HomeScore", SqlDbType.NVarChar).Value = HScore_input.Text.Trim();
            cmd.Parameters.AddWithValue("@AwayScore", SqlDbType.Int).Value = Ascore_input.Text.Trim();
                cmd.Parameters.AddWithValue("@WinningTeam", SqlDbType.NVarChar).Value = WinningTeam(Convert.ToInt16(HScore_input.Text), Convert.ToInt16(Ascore_input.Text));
            cmd.Parameters.AddWithValue("@Attendance", SqlDbType.Int).Value = Attendance_input.Text.Trim();
            cmd.Parameters.AddWithValue("@Date", SqlDbType.NVarChar).Value = Date_input.Text.Trim();
            cmd.Parameters.AddWithValue("@StartTime", SqlDbType.NVarChar).Value = Time_input.Text.Trim();
            con.Open();
            int k = cmd.ExecuteNonQuery();
            if (k != 0)
            {
                lblmsg.Text = "Record Inserted Succesfully into the Database";
                lblmsg.ForeColor = System.Drawing.Color.CornflowerBlue;
            }
            con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("Query Failed. Check input or connection to database");
            }
        }

        private string WinningTeam(int HomeScore, int AwayScore)
        {
            if (HomeScore > AwayScore) return HTName_input.Text.Trim();
            return ATName_input.Text.Trim();
        }
    }
}