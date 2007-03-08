Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28FFnMC006261
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:15:49 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28FFlwk014479
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:15:47 GMT
Message-ID: <45F02885.90109@redhat.com>
Date: Thu, 08 Mar 2007 10:15:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Add bugzilla policy.
Content-Type: multipart/mixed;
 boundary="------------020800040605090502030409"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020800040605090502030409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Forgot patch.


--------------020800040605090502030409
Content-Type: text/x-patch;
 name="bugzilla.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bugzilla.patch"

--- nsaserefpolicy/policy/modules/services/apache.te	2007-02-23 16:50:01.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/apache.te	2007-03-08 08:42:37.000000000 -0500
@@ -713,3 +742,19 @@
 	term_dontaudit_use_generic_ptys(httpd_rotatelogs_t)
 	term_dontaudit_use_unallocated_ttys(httpd_rotatelogs_t)
 ')
+
+#============= bugzilla policy ==============
+apache_content_template(bugzilla)
+allow httpd_bugzilla_script_t self:netlink_route_socket r_netlink_socket_perms;
+
+files_search_var_lib(httpd_bugzilla_script_t)
+
+optional_policy(`
+	mysql_search_db(httpd_bugzilla_script_t)
+	mysql_stream_connect(httpd_bugzilla_script_t)
+')
+
+optional_policy(`
+	postgresql_stream_connect(httpd_bugzilla_script_t)
+')
+
--- nsaserefpolicy/policy/modules/services/apache.fc	2007-02-23 16:50:01.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/apache.fc	2007-03-08 08:42:37.000000000 -0500
80a78,82
> 
> #Bugzilla file context
> /usr/share/bugzilla(/.*)?	-d	gen_context(system_u:object_r:httpd_bugzilla_content_t,s0)
> /usr/share/bugzilla(/.*)?	--	gen_context(system_u:object_r:httpd_bugzilla_script_exec_t,s0)
> /var/lib/bugzilla(/.*)?			gen_context(system_u:object_r:httpd_bugzilla_script_rw_t,s0)

--------------020800040605090502030409--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
