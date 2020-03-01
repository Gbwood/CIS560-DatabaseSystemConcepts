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
    public partial class GamePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void searchSubmit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            if (TeamNameRadio.Checked)
            {
                
                
                try
                {
                    con.ConnectionString = "Data Source=560final.database.windows.net;Initial Catalog=NBALeague;User ID=Team9;Password=tzdkD4mW";

                    con.Open();
                    SqlCommand cmd = new SqlCommand("League.GamesByTeam", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    // If you are passing any parameters to your Stored procedure 
                    cmd.Parameters.AddWithValue("@userinput", SqlDbType.NVarChar).Value = TeamName.SelectedValue.ToString();
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
            else if (ArenaRadio.Checked)
            {
                
                try
                {
                    con.ConnectionString = "Data Source=560final.database.windows.net;Initial Catalog=NBALeague;User ID=Team9;Password=tzdkD4mW";

                    con.Open();
                    SqlCommand cmd = new SqlCommand("League.GamesByArena", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    // If you are passing any parameters to your Stored procedure 
                    cmd.Parameters.AddWithValue("@userinput", SqlDbType.NVarChar).Value = ArenaDropDown.SelectedValue.ToString();
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
            else
            {
               
                try
                {
                    con.ConnectionString = "Data Source=560final.database.windows.net;Initial Catalog=NBALeague;User ID=Team9;Password=tzdkD4mW";

                    con.Open();
                    SqlCommand cmd = new SqlCommand("League.GamesByBoth", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    // If you are passing any parameters to your Stored procedure 
                    cmd.Parameters.AddWithValue("@ArenaName", SqlDbType.NVarChar).Value = ArenaDropDown.SelectedValue.ToString();
                    cmd.Parameters.AddWithValue("@TeamName", SqlDbType.NVarChar).Value = TeamName.SelectedValue.ToString();
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
        }

        protected void btn_AddPlayer_Click(object sender, EventArgs e)
        {

        }
    }
}