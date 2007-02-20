Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KGocrV001218
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 11:50:38 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KGptQc018072
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 16:51:55 GMT
Message-ID: <45DB2729.9000201@redhat.com>
Date: Tue, 20 Feb 2007 11:51:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Policy patch apmd needs to call telinit to change runlevel.
Content-Type: multipart/mixed;
 boundary="------------060404000309040009080402"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060404000309040009080402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060404000309040009080402
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_apm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_services_apm.patch"

--- nsaserefpolicy/policy/modules/services/apm.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/apm.te	2007-02-20 10:25:41.000000000 -0500
@@ -126,7 +126,7 @@
 init_use_fds(apmd_t)
 init_use_script_ptys(apmd_t)
 init_rw_utmp(apmd_t)
-init_write_initctl(apmd_t)
+init_telinit(apmd_t)
 
 libs_exec_ld_so(apmd_t)
 libs_use_ld_so(apmd_t)

--------------060404000309040009080402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
