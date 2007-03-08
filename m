Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28FM6vh006657
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:22:06 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28FM5Y3011861
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:22:05 GMT
Message-ID: <45F02A1B.7040007@redhat.com>
Date: Thu, 08 Mar 2007 10:22:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: kudzu needs to init_telinit to change its runlevel
Content-Type: multipart/mixed;
 boundary="------------040403020107050307060400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040403020107050307060400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------040403020107050307060400
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_admin_kudzu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_admin_kudzu.patch"

--- nsaserefpolicy/policy/modules/admin/kudzu.te	2007-01-02 12:57:51.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/admin/kudzu.te	2007-03-08 08:42:36.000000000 -0500
@@ -103,6 +103,7 @@
 init_use_fds(kudzu_t)
 init_use_script_ptys(kudzu_t)
 init_stream_connect_script(kudzu_t)
+init_telinit(kudzu_t)
 
 libs_use_ld_so(kudzu_t)
 libs_use_shared_libs(kudzu_t)

--------------040403020107050307060400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
