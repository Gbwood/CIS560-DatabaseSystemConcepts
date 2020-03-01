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
    public partial class AddPlayer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = "Data Source=560final.database.windows.net;Initial Catalog=NBALeague;User ID=Team9;Password=tzdkD4mW";


                SqlCommand cmd = new SqlCommand("League.AddPlayer", con);
                cmd.CommandType = CommandType.StoredProcedure;
                // If you are passing any parameters to your Stored procedure 
                cmd.Parameters.AddWithValue("@FirstName", SqlDbType.NVarChar).Value = FirstName_input.Text.Trim();
                cmd.Parameters.AddWithValue("@LastName", SqlDbType.NVarChar).Value = LastName_input.Text.Trim();
                cmd.Parameters.AddWithValue("@TeamName", SqlDbType.NVarChar).Value = TeamInput.Text.Trim();
                cmd.Parameters.AddWithValue("@Height", SqlDbType.NVarChar).Value = HeightInput.Text.Trim();
                cmd.Parameters.AddWithValue("@PlayerNumber", SqlDbType.Int).Value = PlayerNumber_input.Text.Trim();
                cmd.Parameters.AddWithValue("@PlayerPosition", SqlDbType.NVarChar).Value = PositionInput.Text.Trim();
                cmd.Parameters.AddWithValue("@PlayerAge", SqlDbType.Int).Value = Age_input.Text.Trim();
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

        protected void Number_input_TextChanged(object sender, EventArgs e)
        {

        }
    }
}