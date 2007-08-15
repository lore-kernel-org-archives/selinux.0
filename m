Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7FFUDt5017078
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 11:30:13 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7FFUC9K005297
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 15:30:12 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: SELinux List <selinux@tycho.nsa.gov>
Message-Id: <477DC293-F96F-4AFB-AD19-E66C80CC3AB4@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-2-578693313
Cc: "Christopher PeBenito J." <cpebenito@tresys.com>
Subject: [refpolicy] selinuxutils (semodule)
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Wed, 15 Aug 2007 17:30:07 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-2-578693313
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

semodule needs to read semanage.py which is located under debian: / 
var/lib/python-support/python2.4/semanage.py

Second semodule tries to getattr the filesystem

Attached is a patch which solves this. I added the allow rules  
without a debian distribution check. Maybe we should allow it only to  
debian?


--Apple-Mail-2-578693313
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=selinuxutil.te.patch
Content-Disposition: attachment;
	filename=selinuxutil.te.patch

--- /usr/src/refpolicy-20070629/policy/modules/system/selinuxutil.te	2007-06-29 16:48:13.000000000 +0200
+++ policy/modules/system/selinuxutil.te	2007-08-15 15:06:14.000000000 +0200
@@ -478,6 +478,8 @@
 files_read_etc_runtime_files(semanage_t)
 files_read_usr_files(semanage_t)
 files_list_pids(semanage_t)
+files_read_var_lib_files(semanage_t)
+files_read_var_lib_symlinks(semanage_t)
 
 mls_file_write_down(semanage_t)
 mls_rangetrans_target(semanage_t)
@@ -518,6 +520,8 @@
 
 userdom_search_sysadm_home_dirs(semanage_t)
 
+selinux_dontaudit_getattr_fs(semanage_t)
+
 # cjp: need a more general way to handle this:
 ifdef(`enable_mls',`
 	# read secadm tmp files

--Apple-Mail-2-578693313--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
