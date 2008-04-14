Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3EN8cWw016563
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2008 19:08:38 -0400
Received: from relay1.gtri.gatech.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3EN8cmg008251
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2008 23:08:38 GMT
Received: from apatlisdmail24.core.gtri.org (apatlisdmail24.core.gtri.org [130.207.199.195])
	by relay1.gtri.gatech.edu (Spam Firewall) with ESMTP id 339788EE92
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2008 18:33:32 -0400 (EDT)
Received: from apatlisdmail24.core.gtri.org (apatlisdmail24.core.gtri.org [130.207.199.195]) by relay1.gtri.gatech.edu with ESMTP id SdtOLGT5FKKODsYH for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2008 18:33:34 -0400 (EDT)
Subject: [refpolicy] trivial HAL doc patch
From: rob myers <rob.myers@gtri.gatech.edu>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-6Zfd53PyAFW/Qw4Cpkva"
Date: Mon, 14 Apr 2008 18:33:31 -0400
Message-ID: <1208212411.31069.65.camel@rxm-581b.stl.gtri.gatech.edu>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-6Zfd53PyAFW/Qw4Cpkva
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Correct summary for hal_write_log interface.

Index: policy/modules/services/hal.if
===================================================================
--- policy/modules/services/hal.if	(revision 2659)
+++ policy/modules/services/hal.if	(working copy)
@@ -195,7 +195,7 @@
 ## </summary>
 ## <param name="domain">
 ##	<summary>
-##	Domain to not audit
+##	Domain to allow to write log files
 ##	</summary>
 ## </param>
 #




--=-6Zfd53PyAFW/Qw4Cpkva
Content-Disposition: attachment; filename="hal_trivial.patch"
Content-Type: text/x-patch; name="hal_trivial.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Correct summary for hal_write_log interface.

Index: policy/modules/services/hal.if
===================================================================
--- policy/modules/services/hal.if	(revision 2659)
+++ policy/modules/services/hal.if	(working copy)
@@ -195,7 +195,7 @@
 ## </summary>
 ## <param name="domain">
 ##	<summary>
-##	Domain to not audit
+##	Domain to allow to write log files
 ##	</summary>
 ## </param>
 #

--=-6Zfd53PyAFW/Qw4Cpkva--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
