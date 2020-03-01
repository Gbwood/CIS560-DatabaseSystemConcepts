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
    public partial class TeamPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void uxTeamDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView2.Columns[0].Visible = true;
            SqlConnection con = new SqlConnection();
            try
            {
                
                con.ConnectionString = "Data Source=560final.database.windows.net;Initial Catalog=NBALeague;User ID=Team9;Password=tzdkD4mW";

                con.Open();
                SqlCommand cmd = new SqlCommand("League.SearchedTeam", con);
                cmd.CommandType = CommandType.StoredProcedure;
                // If you are passing any parameters to your Stored procedure 
                cmd.Parameters.AddWithValue("@TeamName", SqlDbType.NVarChar).Value = uxTeamDropdown.SelectedValue.ToString();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView2.DataSource = dt;
                GridView2.DataBind();
                con.Close();
            } catch (Exception ex)
            {
                con.Close();
                Response.Write("Query Failed. Check input or connection to database");
            }
        }

        protected void uxShowAllTeams_Click(object sender, EventArgs e)
        {
            GridView2.Columns[0].Visible = true ;

            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = "Data Source=560final.database.windows.net;Initial Catalog=NBALeague;User ID=Team9;Password=tzdkD4mW";

                con.Open();
                SqlCommand cmd = new SqlCommand("League.AllTeams", con);
                cmd.CommandType = CommandType.StoredProcedure;
                // If you are passing any parameters to your Stored procedure 
                //cmd.Parameters.AddWithValue("@TeamName", SqlDbType.NVarChar).Value = uxTeamDropdown.SelectedValue.ToString();
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

     

        protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
           

            SqlConnection con = new SqlConnection();
            con.ConnectionString = "Data Source=560final.database.windows.net;Initial Catalog=NBALeague;User ID=Team9;Password=tzdkD4mW";

            con.Open();
            SqlCommand cmd = new SqlCommand("League.TeamRoster", con);
            cmd.CommandType = CommandType.StoredProcedure;
            // If you are passing any parameters to your Stored procedure 
            cmd.Parameters.AddWithValue("@TeamName", SqlDbType.NVarChar).Value = GridView2.Rows[Convert.ToInt16(e.CommandArgument.ToString())].Cells[1].Text;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView2.DataSource = dt;
            GridView2.DataBind();
            con.Close();

            GridView2.Columns[0].Visible = false;
        }
    }
}