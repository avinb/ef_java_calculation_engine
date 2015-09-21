<html>
  <head>
    <title>DB Test</title>
  </head>
  <body>

  <%
    foo.DBTest tst = new foo.DBTest();
    tst.init();
  %>

  <h2>Results</h2>
    Foo <%= tst.getFoo() %><br/>
    Bar <%= tst.getBar() %>
    Bar3 <%= tst.getBar3() %>

  </body>
</html>
