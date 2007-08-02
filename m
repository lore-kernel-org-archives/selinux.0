Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KnsVu026887
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:49:54 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KnrM1009983
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:49:53 GMT
Date: Thu, 2 Aug 2007 16:49:47 -0400
Message-Id: <200708022049.l72KnlxS000411@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_nagios changes Fix file context
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/nagios.fc	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/nagios.fc	2007-08-02 11:02:02.000000000 -0400
@@ -4,8 +4,8 @@
 /usr/bin/nagios			--	gen_context(system_u:object_r:nagios_exec_t,s0)
 /usr/bin/nrpe			--	gen_context(system_u:object_r:nrpe_exec_t,s0)
 
-/usr/lib(64)?/cgi-bin/netsaint/.+ --	gen_context(system_u:object_r:nagios_cgi_exec_t,s0)
-/usr/lib(64)?/nagios/cgi/.+	--	gen_context(system_u:object_r:nagios_cgi_exec_t,s0)
+/usr/lib(64)?/cgi-bin/netsaint(/.*)?	gen_context(system_u:object_r:nagios_cgi_exec_t,s0)
+/usr/lib(64)?/nagios/cgi(/.*)?		gen_context(system_u:object_r:nagios_cgi_exec_t,s0)
 
 /var/log/nagios(/.*)?			gen_context(system_u:object_r:nagios_log_t,s0)
 /var/log/netsaint(/.*)?			gen_context(system_u:object_r:nagios_log_t,s0)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
