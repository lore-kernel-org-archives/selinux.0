Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SCQm8C027849
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 08:26:48 -0400
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SCQkM5022099
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 12:26:47 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-Id: <50C59BF9-3A4B-4BC2-8F78-F0CFC68592D7@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-2--456607052
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] dovecot: handling of hard links
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Tue, 28 Aug 2007 14:26:30 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-2--456607052
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

dovecot uses a hard link:

/var/lib/dovecot/ssl-parameters.dat
/var/run/dovecot/login/ssl-parameters.dat

and the policy file looks like that:

/var/run/dovecot(-login)?(/.*)?	gen_context 
(system_u:object_r:dovecot_var_run_t,s0)
/var/lib/dovecot(/.*)?			gen_context 
(system_u:object_r:dovecot_var_lib_t,s0)

While relabel:

$ fixfiles relabel

...
matchpathcon_filespec_add:  conflicting specifications for /var/run/ 
dovecot/login/ssl-parameters.dat and /var/lib/dovecot/ssl- 
parameters.dat, using system_u:object_r:dovecot_var_run_t:s0.
....

Since the comment in the policy dovecot.te the file should be labeled  
dovecot_var_lib_t but fixfiles relabels it as dovecot_var_run_t.  
Attached is a patch which solves this.

PS: tested on CentOS5


--Apple-Mail-2--456607052
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=dovecot.fc.patch
Content-Disposition: attachment;
	filename=dovecot.fc.patch

--- /usr/src/refpolicy-20070629/policy/modules/services/dovecot.fc	2006-07-28 17:13:58.000000000 +0200
+++ policy/modules/services/dovecot.fc	2007-08-28 14:16:44.000000000 +0200
@@ -27,6 +27,8 @@
 # /var
 #
 /var/run/dovecot(-login)?(/.*)?		gen_context(system_u:object_r:dovecot_var_run_t,s0)
+# this is a hard link to /var/lib/dovecot/ssl-parameters.dat
+/var/run/dovecot/login/ssl-parameters.dat	gen_context(system_u:object_r:dovecot_var_lib_t,s0)
 
 /var/lib/dovecot(/.*)?			gen_context(system_u:object_r:dovecot_var_lib_t,s0)
 

--Apple-Mail-2--456607052--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
