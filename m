Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k19JgcXf028837
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 14:42:39 -0500 (EST)
Received: from e6.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k19JgZL4026125
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 19:42:35 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k19Jgbl8015237
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 14:42:37 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k19JgbN6205678
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 14:42:37 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k19JgbOa013110
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 14:42:37 -0500
Received: from sergelap.hallyn.com (sig-9-76-3-182.mts.ibm.com [9.76.3.182])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k19Jgasl013097
	for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2006 14:42:37 -0500
Date: Thu, 9 Feb 2006 13:42:36 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: seref: trivial patch:
Message-ID: <20060209194236.GF10534@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix compilation failure for cron with apache=off.

Now maybe cron as a policy module doesn't make sense anyway...  but
I'd say the below was wrong regardless.

thanks,
-serge

Index: refpolicy/policy/modules/services/cron.te
===================================================================
--- refpolicy.orig/policy/modules/services/cron.te
+++ refpolicy/policy/modules/services/cron.te
@@ -208,7 +208,7 @@ ifdef(`TODO',`
 # crond tries to search /root.  Not sure why.
 allow crond_t sysadm_home_dir_t:dir r_dir_perms;
 
-ifdef(`apache.te',`
+optional_policy(`apache',`
 allow system_crond_t httpd_modules_t:lnk_file read;
 # Needed for certwatch
 can_exec(system_crond_t, httpd_modules_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
