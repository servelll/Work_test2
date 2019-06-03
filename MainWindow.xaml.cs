
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Media;

namespace Work_test2
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        MySqlConnection connection;
        public MainWindow()
        {
            InitializeComponent();
            string connectionString = @"Server=localhost;Database=work;port=3306;User Id=root;password=root";
            //testtextbox.Text = connectionString;

            connection = new MySqlConnection(connectionString);
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Открываем подключение
                connection.Open();
                //MessageBox.Show("Подключение успешно открыто");

                string sum = (combosum.SelectedIndex == 1) ? "SUM" : "AVG";
                bool uvol = checkb.IsChecked ?? true;
                int m = mycalend.SelectedDate.Value.Month;
                string sqlCmd = @"SELECT employee.Name, IFNULL(t.sum, 0) FROM work.employee LEFT JOIN
                                    (SELECT Name, Active, " + sum + @"(Salary) as sum
                                    FROM work.employee INNER JOIN work.salary On work.employee.Id = work.salary.employee_Id
                                    WHERE DATE_FORMAT(Datetime, '%Y %m') = '" +
                                    mycalend.SelectedDate.Value.Year + " " + ((m < 10) ? "0" + m : m.ToString()) +
                                    "' GROUP BY Name) t Using(Name)" +
                            (!uvol ? " WHERE employee.Active = 1 " : "") +
                                    " ORDER BY t.sum DESC;";
                MySqlDataAdapter adr = new MySqlDataAdapter(sqlCmd, connection);
                adr.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                adr.Fill(dt);

                List<Table> t = new List<Table>(dt.Rows.Count);
                foreach (DataRow item in dt.Rows)
                {
                    t.Add(new Table(item[0].ToString(), item[1].ToString()));
                }
                mydatadrid.ItemsSource = t;
            }
            catch (MySqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                if (connection != null)
                {
                    connection.Close();
                    // закрываем подключение
                    MessageBox.Show("Подключение закрыто...");
                }
            }
        }

        private void Searchbox_TextChanged(object sender, TextChangedEventArgs e)
        {
            string s = searchbox.Text;
            if (s == "") return;
            for (int i = 0; i < mydatadrid.Items.Count; i++)
            {
                if (((Table)mydatadrid.Items[i]).Name.Contains(s))
                {
                    mydatadrid.SelectedIndex = i;
                    break;
                }
                mydatadrid.SelectedIndex = -1;
            }
        }

        private void Calendar_DisplayModeChanged(object sender, CalendarModeChangedEventArgs e)
        {
            if (mycalend.DisplayMode == CalendarMode.Month)
            {
                mycalend.DisplayMode = CalendarMode.Year;
            }
            if (monthseltext != null) monthseltext.Text = mycalend.DisplayDate.ToLongDateString();
        }
    }

    public class SalaryToColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            try
            {
                return (int)value <= 20000 ? new SolidColorBrush(Colors.OrangeRed) : new SolidColorBrush(Colors.White);
            }
            catch
            {
                return new SolidColorBrush(Colors.White);
            }
        }
        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new Exception("The method or operation is not implemented.");
        }
    }
}
