Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3EN8bRx016554
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2008 19:08:38 -0400
Received: from relay1.gtri.gatech.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3EN8bmg008240
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2008 23:08:37 GMT
Received: from apatlisdmail24.core.gtri.org (apatlisdmail24.core.gtri.org [130.207.199.195])
	by relay1.gtri.gatech.edu (Spam Firewall) with ESMTP id 08A748EE55
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2008 18:52:06 -0400 (EDT)
Received: from apatlisdmail24.core.gtri.org (apatlisdmail24.core.gtri.org [130.207.199.195]) by relay1.gtri.gatech.edu with ESMTP id aZdwYkppN1jLp9fX for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2008 18:52:04 -0400 (EDT)
Subject: [refpolicy] RFC: hal_read_log interface
From: rob myers <rob.myers@gtri.gatech.edu>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-nZ7uEHI5/t7+iDJad5k6"
Date: Mon, 14 Apr 2008 18:52:05 -0400
Message-ID: <1208213525.31069.77.camel@rxm-581b.stl.gtri.gatech.edu>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-nZ7uEHI5/t7+iDJad5k6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

While trying to create a domain that could read all the files
in /var/log, I noticed that hald_log_t files do not have the logfile
attribute.  This appears to be intentional because the
logging_log_filetrans interface was used instead of the logging_log_file
interface.  Is this still the intention?

Attached is a patch to add an interface to allow domains to read
hald_log_t in case hald_log_t needs to remain a private type.

Thoughts?

rob.

--=-nZ7uEHI5/t7+iDJad5k6
Content-Disposition: attachment; filename="hal_read_log.patch"
Content-Type: text/x-patch; name="hal_read_log.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Index: policy/modules/services/hal.if
===================================================================
--- policy/modules/services/hal.if	(revision 2659)
+++ policy/modules/services/hal.if	(working copy)
@@ -210,6 +210,28 @@
 
 ########################################
 ## <summary>
+##	Allow attempts to read the hal
+##	log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to allow to read log files
+##	</summary>
+## </param>
+#
+interface(`hal_read_log',`
+	gen_require(`
+		type hald_log_t;
+	')
+
+	logging_search_logs($1)
+	allow $1 hald_log_t:dir search_dir_perms;
+	allow $1 hald_log_t:dir r_dir_perms;
+	allow $1 hald_log_t:file read_file_perms;
+')
+
+########################################
+## <summary>
 ##	Do not audit attempts to write the hal
 ##	log files.
 ## </summary>

--=-nZ7uEHI5/t7+iDJad5k6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
