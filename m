Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KcdmY025225
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:38:39 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KcZTm006500
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:38:36 GMT
Date: Thu, 2 Aug 2007 16:38:32 -0400
Message-Id: <200708022038.l72KcW6E032504@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_sendmail changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

postfix sends signals to sendmail
--- nsaserefpolicy/policy/modules/services/sendmail.if	2007-05-30 11:47:29.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/sendmail.if	2007-08-02 11:02:02.000000000 -0400
@@ -131,3 +131,21 @@
 
 	logging_log_filetrans($1,sendmail_log_t,file)
 ')
+
+########################################
+## <summary>
+##f	allow domain to signal sendmail
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`sendmail_signal',`
+	gen_require(`
+		type sendmail_t;
+	')
+	allow $1 sendmail_t:process signal;
+')
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
