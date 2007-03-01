Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21Gww6Y008597
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 11:58:58 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l21H0KJC017530
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 17:00:21 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l21H02Sx018664
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 12:00:02 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l21H019N005849
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 12:00:01 -0500
Received: from [10.11.15.91] (vpn-15-91.rdu.redhat.com [10.11.15.91])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l21H00oi030103
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 12:00:01 -0500
Subject: [PATCH] sepolgen: process USER_AVC messages
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 11:59:26 -0500
Message-Id: <1172768366.30103.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds USER_AVC messages to the message types parsed by
sepolgen.

diff -r 9bb2118cf4a4 sepolgen/src/sepolgen/audit.py
--- a/sepolgen/src/sepolgen/audit.py	Thu Mar 01 11:33:49 2007 -0500
+++ b/sepolgen/src/sepolgen/audit.py	Thu Mar 01 11:58:51 2007 -0500
@@ -32,7 +32,7 @@ def get_audit_msgs():
        string contain all of the audit messages returned by ausearch.
     """
     import subprocess
-    output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,MAC_POLICY_LOAD,DAEMON_START"],
+    output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,DAEMON_START"],
                               stdout=subprocess.PIPE).communicate()[0]
     return output
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
