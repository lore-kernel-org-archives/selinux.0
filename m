Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l84HJKFf019134
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 13:19:21 -0400
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l84HJJFI023030
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2007 17:19:19 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-Id: <C1E2C57A-C33B-42DC-9544-06CAAA6AAA35@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-9-165757019
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] terminal.if patch
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Tue, 4 Sep 2007 19:19:14 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-9-165757019
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

This patch adds an interface like term_write_all_user_ttys but this  
time for ptys


--Apple-Mail-9-165757019
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=terminal.if.patch
Content-Disposition: attachment;
	filename=terminal.if.patch

--- /usr/src/refpolicy-20070629/policy/modules/kernel/terminal.if	2007-06-12 15:06:13.000000000 +0200
+++ policy/modules/kernel/terminal.if	2007-09-04 17:52:13.000000000 +0200
@@ -755,6 +755,25 @@
 ')
 
 ########################################
+### <summary>
+###      Write to all user ptys.
+### </summary>
+### <param name="domain">
+###      <summary>
+###      Domain allowed access.
+###      </summary>
+### </param>
+##
+interface(`term_write_all_user_ptys',`
+	gen_require(`
+		attribute ptynode;
+	')
+
+	dev_list_all_dev_nodes($1)
+	allow $1 ptynode:chr_file write_chr_file_perms;
+')
+
+########################################
 ## <summary>
 ##	Get the attributes of all unallocated
 ##	tty device nodes.

--Apple-Mail-9-165757019--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
