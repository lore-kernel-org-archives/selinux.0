Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IIB7Ob000385
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:11:08 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7II0gsQ022966
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 18:00:42 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j7II1tad032567
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:01:55 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j7II1ttZ032566
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 14:01:55 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IHXxOb000066
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:34:00 -0400 (EDT)
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7IHNasQ015485
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 17:23:36 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7IHOcwh125548
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:24:38 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7IHO9J7483794
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 11:24:14 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7IHOW2f014757
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 11:24:32 -0600
Received: from serge.austin.ibm.com (sig-9-65-101-195.mts.ibm.com [9.65.101.195])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7IHOVsN014719
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 11:24:32 -0600
Received: from serge.austin.ibm.com (localhost [127.0.0.1])
	by serge.austin.ibm.com (8.13.3/8.13.3) with ESMTP id j7IIKikG007652
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:20:44 -0500
Received: (from hallyn@localhost)
	by serge.austin.ibm.com (8.13.4/8.13.3/Submit) id j7IIKhB9007651
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 13:20:43 -0500
Date: Thu, 18 Aug 2005 13:20:43 -0500
From: hallyn@serge.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol resource leak
Message-ID: <20050818182043.GA7622@serge.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(I am sending out four patches to libsepol.  Another 6 or so which I
investigated were not actual bugs.  This leaves me with a little over
half to still look at, hopefully tomorrow.  After that I'll hop to
libsemanage or the kernel code).

This patch fixes a bug found by Coverity:

	On error in sepol_context_to_string(), 'str' is not freed.

Index: src/context_record.c
===================================================================
--- src.orig/context_record.c
+++ src/context_record.c
@@ -253,5 +253,7 @@ char* sepol_context_to_string(sepol_cont
 
 	err:
 	DEBUG(__FUNCTION__, "could not convert context to string\n");
+	if (str)
+		free(str);
 	return NULL;
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
