Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IIB6Ob000381
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:11:22 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7II1i4R005496
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 18:01:44 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j7II1teq032563
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:01:55 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j7II1tkK032562
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 14:01:55 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IGC2Ob029423
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 12:12:03 -0400 (EDT)
Received: from e5.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7IG2f4R019503
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 16:02:42 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7IG2ghs027268
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 12:02:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7IG2fIc297420
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 12:02:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7IG2ebg017743
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 12:02:40 -0400
Received: from serge.austin.ibm.com (sig-9-65-101-195.mts.ibm.com [9.65.101.195])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7IG2e6e017129
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 12:02:40 -0400
Received: from serge.austin.ibm.com (localhost [127.0.0.1])
	by serge.austin.ibm.com (8.13.3/8.13.3) with ESMTP id j7IGwfnf002849
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 11:58:42 -0500
Received: (from hallyn@localhost)
	by serge.austin.ibm.com (8.13.4/8.13.3/Submit) id j7IGwfe3002848
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 11:58:41 -0500
Date: Thu, 18 Aug 2005 11:58:41 -0500
From: hallyn@serge.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] checkpolicy: fix use-after-free
Message-ID: <20050818165841.GA2788@serge.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following fixes a use after free bug found by Coverity in
module_compiler.c.  The dest_id is freed by get_local_type()
itself.

I'm doing this one before the libsepol patches because this
was the only error found in checkpolicy :)

thanks,
-serge

--- module_compiler.c.orig	2005-08-18 10:46:58.252400576 -0500
+++ module_compiler.c	2005-08-18 10:49:34.287679608 -0500
@@ -288,7 +288,6 @@ type_datum_t *declare_type(unsigned char
                 }
                 if ((dest_typdatum = get_local_type(dest_id, value)) == NULL) {
                         yyerror("Out of memory!");
-			free(dest_id);
                         return NULL;
                 }       
         }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
