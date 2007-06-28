Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5SJH6Wv029235
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 15:17:06 -0400
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5SJH5mi013913
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 19:17:05 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5SJH5Sb017896
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 15:17:05 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5SJH4oo218812
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 13:17:04 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5SJH4W5006750
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 13:17:04 -0600
Received: from sergelap.hallyn.com ([9.65.82.0])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l5SJH48M006716
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 13:17:04 -0600
Date: Thu, 28 Jun 2007 14:17:07 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [patch] refpolicy update for cap_setfcap
Message-ID: <20070628191707.GA13973@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A tentative patch to support file capabilities introduces a new
CAP_SETFCAP capability.  This patch adds setfcap to the refpolicy
access_vectors.

thanks,
-serge

Index: policy/flask/access_vectors
===================================================================
--- policy/flask/access_vectors	(revision 2359)
+++ policy/flask/access_vectors	(working copy)
@@ -363,6 +363,7 @@
 	lease
 	audit_write
 	audit_control
+	setfcap
 }
 
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
