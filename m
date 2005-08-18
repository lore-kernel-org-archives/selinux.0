Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IIB8Ob000389
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:11:08 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7II0hsQ022969
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 18:00:43 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j7II1tT3032579
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:01:55 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j7II1t24032578
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 14:01:55 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IHaHOb000131
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:36:17 -0400 (EDT)
Received: from e35.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7IHPqsQ016102
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 17:25:53 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7IHQr48545326
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:26:53 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7IHQvmb179558
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 11:26:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7IHQq6B023210
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 11:26:52 -0600
Received: from serge.austin.ibm.com (sig-9-65-101-195.mts.ibm.com [9.65.101.195])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7IHQpwK023183
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 11:26:51 -0600
Received: from serge.austin.ibm.com (localhost [127.0.0.1])
	by serge.austin.ibm.com (8.13.3/8.13.3) with ESMTP id j7IIN4vU007672
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:23:04 -0500
Received: (from hallyn@localhost)
	by serge.austin.ibm.com (8.13.4/8.13.3/Submit) id j7IIN39A007671
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 13:23:03 -0500
Date: Thu, 18 Aug 2005 13:23:03 -0500
From: hallyn@serge.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol: NULL dereference of tmp_roles[] on error path
Message-ID: <20050818182303.GD7622@serge.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch addresses a bug found by Coverity:

	If the calloc for tmp_roles failed, we proceed to omem: where
	we dereference tmp_roles[1..num_roles].

Index: src/user_record.c
===================================================================
--- src.orig/user_record.c
+++ src/user_record.c
@@ -184,12 +184,14 @@ int sepol_user_set_roles(
 	DEBUG(__FUNCTION__, "out of memory, could not "
 		"allocate roles array for user %s\n", user->name);
 
-	for (i = 0; i < num_roles; i++ ) {
-		if (!tmp_roles[i])
-			break;
-		free(tmp_roles[i]);	
+	if (tmp_roles) {
+		for (i = 0; i < num_roles; i++ ) {
+			if (!tmp_roles[i])
+				break;
+			free(tmp_roles[i]);
+		}
+		free(tmp_roles);
 	}
-	free(tmp_roles);
 	return STATUS_ERR;	
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
