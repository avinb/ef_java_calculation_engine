<html>
  <head>
    <title>Users</title>
  </head>
  <body>

  <%
    calculation_engine.Users users = new calculation_engine.Users();
    users.init();
  %>

  <h2>Results</h2>
    First name: <%= users.getFirstName() %>
    <br/>
    Last name: <%= users.getLastName() %>
    <br/>
    Age: <%= users.getAge() %>

  </body>
</html>
