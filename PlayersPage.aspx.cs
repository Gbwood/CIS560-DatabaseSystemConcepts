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
    public partial class PlayersPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            try
            {
                
                con.ConnectionString = "Data Source=560final.database.windows.net;Initial Catalog=NBALeague;User ID=Team9;Password=tzdkD4mW";

                con.Open();
                SqlCommand cmd = new SqlCommand("League.SearchedPlayer", con);
                cmd.CommandType = CommandType.StoredProcedure;
                // If you are passing any parameters to your Stored procedure 
                cmd.Parameters.AddWithValue("@PlayerName", SqlDbType.NVarChar).Value = uxSearchPlayerTB.Text.Trim();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView2.DataSource = dt;
                GridView2.DataBind();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("Query Failed. Check input or connection to database");
            }
        }

        protected void btnPlayerAdd_Click(object sender, EventArgs e)
        {

        }
    }
}