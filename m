Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1NI5BaU008939
	for <selinux@tycho.nsa.gov>; Sat, 23 Feb 2008 13:05:11 -0500
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1NI56Lr002631
	for <selinux@tycho.nsa.gov>; Sat, 23 Feb 2008 18:05:07 GMT
Subject: [refpolicy] dovecot.fc.patch (resend)
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-/Vlnsvx5k82aDWIMybC2"
Date: Sat, 23 Feb 2008 19:04:57 +0100
Message-Id: <1203789897.2668.5.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/Vlnsvx5k82aDWIMybC2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dovecot needs a hard link and therefor a special label.

I resend this patch. For background have a look at this thread:
http://marc.info/?l=selinux&m=118830456207512&w=2


--=-/Vlnsvx5k82aDWIMybC2
Content-Disposition: attachment; filename=dovecot.fc.patch
Content-Type: text/x-patch; name=dovecot.fc.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- /usr/src/refpolicy-20070629/policy/modules/services/dovecot.fc	2006-07-28 17:13:58.000000000 +0200
+++ policy/modules/services/dovecot.fc	2007-08-28 14:16:44.000000000 +0200
@@ -27,6 +27,8 @@
 # /var
 #
 /var/run/dovecot(-login)?(/.*)?		gen_context(system_u:object_r:dovecot_var_run_t,s0)
+# this is a hard link to /var/lib/dovecot/ssl-parameters.dat
+/var/run/dovecot/login/ssl-parameters.dat	gen_context(system_u:object_r:dovecot_var_lib_t,s0)
 
 /var/lib/dovecot(/.*)?			gen_context(system_u:object_r:dovecot_var_lib_t,s0)
 

--=-/Vlnsvx5k82aDWIMybC2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
