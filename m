Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBEqDQL000528
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 09:52:13 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBBEqAHI008641
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 14:52:11 GMT
Date: Tue, 11 Dec 2007 15:52:08 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Cc: selinux-devel@lists.alioth.debian.org
Subject: refpolicy HEAD, patch for Debian logs of syslog rotation
Message-ID: <20071211145208.GA5106@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
there is another change for the refpolicy, so the Debian system can run
/etc/cron.daily/sysklogd successfully. This is rotation for logs parsed
from syslog.conf config file. Script /usr/sbin/syslogd-listfiles lists
logs, that needs rotation. Logs are rotated using script
/usr/bin/savelog then.

Without attached patch domain logrotate_t is not allowed to read
syslog_conf_t and following denials are generated:

audit(1197384508.149:3): avc:  denied  { read } for  pid=1589 comm="syslogd-listfil" name="syslog.conf" dev=sda1 ino=213265 scontext=system_u:system_r:logrotate_t:s0 tcontext=system_u:object_r:syslog_conf_t:s0 tclass=file
audit(1197384508.149:4): avc:  denied  { ioctl } for  pid=1589 comm="syslogd-listfil" name="syslog.conf" dev=sda1 ino=213265 scontext=system_u:system_r:logrotate_t:s0 tcontext=system_u:object_r:syslog_conf_t:s0 tclass=file
audit(1197384508.149:5): avc:  denied  { getattr } for  pid=1589 comm="syslogd-listfil" name="syslog.conf" dev=sda1 ino=213265 scontext=system_u:system_r:logrotate_t:s0 tcontext=system_u:object_r:syslog_conf_t:s0 tclass=file

Can be changes applied?
Thanks
-- 
Zito

--2oS5YaxWCcQjTEyO
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="refpolicy-debian-syslog.patch"

Index: policy/modules/system/logging.if
===================================================================
--- policy/modules/system/logging.if	(revision 2550)
+++ policy/modules/system/logging.if	(working copy)
@@ -663,6 +663,25 @@
 
 ########################################
 ## <summary>
+##	Read syslog_conf_t file.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`logging_read_syslog_conf',`
+	gen_require(`
+		type syslog_conf_t;
+	')
+
+	allow $1 syslog_conf_t:file read_file_perms;
+')
+
+########################################
+## <summary>
 ##	All of the rules required to administrate
 ##	the audit environment
 ## </summary>
Index: policy/modules/admin/logrotate.te
===================================================================
--- policy/modules/admin/logrotate.te	(revision 2550)
+++ policy/modules/admin/logrotate.te	(working copy)
@@ -108,6 +108,11 @@
 # cjp: why is this needed?
 logging_exec_all_logs(logrotate_t)
 
+ifdef(`distro_debian', `
+	# for syslogd-listfiles
+	logging_read_syslog_conf(logrotate_t)
+')
+
 libs_use_ld_so(logrotate_t)
 libs_use_shared_libs(logrotate_t)
 

--2oS5YaxWCcQjTEyO--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
