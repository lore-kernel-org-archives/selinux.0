Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QIjsFX020428
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 14:45:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id A2FBC1A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 20:45:53 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OE72hVJUWifx for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 20:45:52 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 55C7C1A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 20:45:52 +0200 (CEST)
Date: Mon, 26 Mar 2012 20:45:49 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux -- Hide unnecessarily-exported library
 destructors
Message-ID: <20120326204549.1127d58b@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Description: Hide unnecessarily-exported library destructors
 This change was extracted from the old monolithic Debian patch.  I have not
 been able to find an explanation for why it is needed, but it should be
 forwarded upstream for review.
 .
Author: Unknown

---
Forwarded: no
Last-Update: 2011-10-13

--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -291,7 +291,7 @@ static void matchpathcon_thread_destruct
 	matchpathcon_fini();
 }
 
-void __attribute__((destructor)) matchpathcon_lib_destructor(void)
+void hidden __attribute__((destructor)) matchpathcon_lib_destructor(void)
 {
 	if (destructor_key_initialized)
 		__selinux_key_delete(destructor_key);
--- libselinux-2.1.0.orig/src/setrans_client.c
+++ libselinux-2.1.0/src/setrans_client.c
@@ -253,7 +253,7 @@ static void setrans_thread_destructor(vo
 	free(prev_r2c_raw);
 }
 
-void __attribute__((destructor)) setrans_lib_destructor(void)
+void hidden __attribute__((destructor)) setrans_lib_destructor(void)
 {
 	if (destructor_key_initialized)
 		__selinux_key_delete(destructor_key);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
