Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8HFVbrT002906
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 11:31:37 -0400 (EDT)
Message-ID: <414B034A.4050407@redhat.com>
Date: Fri, 17 Sep 2004 11:31:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Important fix for targeted policy
References: <200409162151.44819.russell@coker.com.au>	 <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil> <1095356454.17251.10.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1095356454.17251.10.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff --exclude-from=exclude -N -u -r 
nsapolicy/targeted/domains/program/init.te 
policy-1.17.18/targeted/domains/program/init.te
--- nsapolicy/targeted/domains/program/init.te  2004-09-09 
15:36:12.000000000 -0400
+++ policy-1.17.18/targeted/domains/program/init.te     2004-09-17 
10:22:33.591562641 -0400
@@ -15,4 +15,4 @@
 # strict policy.  /sbin/init will get this policy.
 #
 type init_exec_t, file_type, sysadmfile, exec_type;
-type initctl_t, file_type, sysadmfile;
+type initctl_t, file_type, sysadmfile, dev_fs;
diff --exclude-from=exclude -N -u -r 
nsapolicy/targeted/domains/program/udev.te 
policy-1.17.18/targeted/domains/program/udev.te
--- nsapolicy/targeted/domains/program/udev.te  2004-09-09 
15:36:12.000000000 -0400
+++ policy-1.17.18/targeted/domains/program/udev.te     2004-09-17 
10:22:22.119860649 -0400
@@ -13,4 +13,4 @@
 #
 type udev_exec_t, file_type, sysadmfile, exec_type;
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
-type udev_tbl_t, file_type, sysadmfile;
+type udev_tbl_t, file_type, sysadmfile, dev_fs;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
