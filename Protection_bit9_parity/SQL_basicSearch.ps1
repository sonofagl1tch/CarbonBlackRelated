$DBServer = "LocalHost\SQLExpress"
$databasename = "Das"
$Connection = new-object system.data.sqlclient.sqlconnection #Set new object to connect to sql database
$Connection.ConnectionString ="server=$DBServer;database=$databasename;trusted_connection=True" # Connectiongstring setting for local machine database with window authentication
Write-host "Connection Information:"  -foregroundcolor yellow -backgroundcolor black
$Connection #List connection information


### Connect to Database and Run Query

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand #setting object to use sql commands

$SqlQuery = @"

Select top 2 * from events with(nolock)

"@

$Connection.open()
Write-host "Connection to database successful." -foregroundcolor green -backgroundcolor black
$SqlCmd.CommandText = $SqlQuery
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd
$SqlCmd.Connection = $Connection
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$Connection.Close()
$DataSet.Tables[0]