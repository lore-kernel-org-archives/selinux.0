Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13833
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 16:02:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA23641
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 20:02:17 GMT
Received: from jsmith.org (pool-141-158-44-125.phil.east.verizon.net [141.158.44.125])
	by jazzband.ncsc.mil  with ESMTP id UAA23637
	for <selinux@tycho.nsa.gov>; Mon, 8 Oct 2001 20:02:17 GMT
Subject: Additions to file_contexts
From: "Justin R. Smith" <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 08 Oct 2001 16:02:13 -0400
Message-Id: <1002571333.3666.57.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I run Java servlets (using the Jakarta Tomcat engine) from my web site,
so I added the following lines to the setfiles/file_context file, since
servlets are LIKE scripts (sort of):

/var/www/tomcat(|/.*)           system_u:object_r:httpd_user_script_rw_t
/var/www/classes(|/.*)          system_u:object_r:httpd_user_script_rw_t

Note: /var/www/classes is a directory containing classes used by all
servlets and is in the Java CLASSPATH. /var/www/tomcat contains tomcat
and all deployed web applications.

I also had to make my html content writable because my cgi scripts and
servlets frequently write to it. 

In addition, Tomcat likes to compile jsp into servlets and, therefore,
must be able to write to its work directory.

-- 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
