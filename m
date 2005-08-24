Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7OMkbOb011909
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 18:46:38 -0400 (EDT)
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7OMaCDh025190
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 22:36:12 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7OMaDCJ027346
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 18:36:13 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7OMaD8a193152
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 18:36:13 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7OMaDm5014197
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 18:36:13 -0400
Received: from sergelap.austin.ibm.com ([9.49.203.151])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7OMaC9e014099
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 18:36:12 -0400
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.4/8.13.1) with ESMTP id j7OISMHm007896
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 13:28:22 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7OISMAf007895
	for selinux@tycho.nsa.gov; Wed, 24 Aug 2005 13:28:22 -0500
Date: Wed, 24 Aug 2005 13:28:22 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] libselinux: avoid NULL deref
Message-ID: <20050824182822.GB7291@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a bug found by Coverity in setsetbool.c.

After these two patches I sent today, the only bugs I'm finding are
1 false positive in libsemanage, and 22 unchecked in libsepol.

thanks,
-serge

--- utils/setsebool.c.orig	2005-08-24 17:24:32.278258504 -0500
+++ utils/setsebool.c	2005-08-24 17:30:37.914673320 -0500
@@ -154,6 +154,13 @@ int setbool(char **list, size_t start, s
 		   this above and aborted if something went wrong. */
 		name = list[i];
 		value_ptr = strchr(name, '=');
+		if (!value_ptr) {
+			syslog(LOG_NOTICE,
+				"Malformed entry for boolean %s\n",
+				name);
+			i++;
+			continue;
+		}
 		*value_ptr = 0;
 		value_ptr++;
 		if (pwd && pwd->pw_name)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
