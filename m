Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IIB6Ob000382
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:11:06 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7II1j4R005497
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 18:01:45 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j7II1t6A032575
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:01:55 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j7II1tBa032574
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 14:01:55 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IHZTOb000092
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:35:29 -0400 (EDT)
Received: from e4.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7IHP4sQ015862
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 17:25:04 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7IHQ7j4028757
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:26:07 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7IHQ7H6297146
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:26:07 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7IHQ7lL020713
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:26:07 -0400
Received: from serge.austin.ibm.com (sig-9-65-101-195.mts.ibm.com [9.65.101.195])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7IHQ6lt020655
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:26:06 -0400
Received: from serge.austin.ibm.com (localhost [127.0.0.1])
	by serge.austin.ibm.com (8.13.3/8.13.3) with ESMTP id j7IIMJXK007665
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:22:19 -0500
Received: (from hallyn@localhost)
	by serge.austin.ibm.com (8.13.4/8.13.3/Submit) id j7IIMJ5C007664
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 13:22:19 -0500
Date: Thu, 18 Aug 2005 13:22:19 -0500
From: hallyn@serge.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol: potential NULL dereference from next_entry()
Message-ID: <20050818182219.GC7622@serge.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a bug found by Coverity:

	If next_entry returns NULL in role_trans_rule_read(),
	we nevertheless reference buf[0].

Index: src/policydb.c
===================================================================
--- src.orig/policydb.c
+++ src/policydb.c
@@ -2145,6 +2145,8 @@ static int role_trans_rule_read(role_tra
                         return -1;
 
                 buf = next_entry(fp, sizeof(uint32_t));
+		if (!buf)
+			return -1;
                 tr->new_role = le32_to_cpu(buf[0]);
                 ltr = tr;
         }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
