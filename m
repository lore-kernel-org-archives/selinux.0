Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PEnhkf018619
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 09:49:43 -0500
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1PEnfa4011514
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:49:41 GMT
Subject: Re: [refpolicy] dovecot.fc.patch (resend)
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1203948348.32061.45.camel@gorn>
References: <1203789897.2668.5.camel@vogon> <1203948348.32061.45.camel@gorn>
Content-Type: multipart/mixed; boundary="=-QpRG1+rmevP7AQQENVaV"
Date: Mon, 25 Feb 2008 15:49:33 +0100
Message-Id: <1203950973.5535.11.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-QpRG1+rmevP7AQQENVaV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Yeah I forgot to attach the other patches. Now all three patches should
be included. If they get accepted I will open a bugzilla entry to get
them backported to RHEL5.

On Mon, 2008-02-25 at 09:05 -0500, Christopher J. PeBenito wrote:
> On Sat, 2008-02-23 at 19:04 +0100, Stefan Schulze Frielinghaus wrote:
> > Dovecot needs a hard link and therefor a special label.
> > 
> > I resend this patch. For background have a look at this thread:
> > http://marc.info/?l=selinux&m=118830456207512&w=2
> 
> This still needs the dontaudit for initrc_t that you were speaking of.
> 

--=-QpRG1+rmevP7AQQENVaV
Content-Disposition: attachment; filename=dovecot.fc.patch
Content-Type: text/x-patch; name=dovecot.fc.patch; charset=utf-8
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
 

--=-QpRG1+rmevP7AQQENVaV
Content-Disposition: attachment; filename=dovecot.if.patch
Content-Type: text/x-patch; name=dovecot.if.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- /usr/src/refpolicy-20070629/policy/modules/services/dovecot.if	2006-12-12 21:08:08.000000000 +0100
+++ policy/modules/services/dovecot.if	2007-09-07 13:18:30.000000000 +0200
@@ -18,3 +18,21 @@
 	manage_files_pattern($1,dovecot_spool_t,dovecot_spool_t)
 	manage_lnk_files_pattern($1,dovecot_spool_t,dovecot_spool_t)
 ')
+
+########################################
+### <summary>
+###      Dontaudit attempts to unlink dovecot_var_lib_t files.
+### </summary>
+### <param name="domain">
+###      <summary>
+###      Domain to not audit.
+###      </summary>
+### </param>
+##
+interface(`dovecot_dontaudit_unlink_var_lib_files',`
+	gen_require(`
+		type dovecot_var_lib_t;
+	')
+
+	dontaudit $1 dovecot_var_lib_t:file unlink;
+')

--=-QpRG1+rmevP7AQQENVaV
Content-Disposition: attachment; filename=init.te.patch
Content-Type: text/x-patch; name=init.te.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- /usr/src/refpolicy-20070629/policy/modules/system/init.te	2007-06-29 16:48:13.000000000 +0200
+++ policy/modules/system/init.te	2007-09-07 13:25:37.000000000 +0200
@@ -604,6 +604,14 @@
 ')
 
 optional_policy(`
+	# /var/run/dovecot/login/ssl-parameters.dat is a hard link to
+	# /var/lib/dovecot/ssl-parameters.dat and init tries to clean up
+	# the directory. But we do not want to allow this.
+	# The master process of dovecot will manage this file.
+	dovecot_dontaudit_unlink_var_lib_files(initrc_t)
+')
+
+optional_policy(`
 	ftp_read_config(initrc_t)
 ')
 

--=-QpRG1+rmevP7AQQENVaV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
