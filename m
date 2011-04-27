Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3REN4Pg031068
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 10:23:05 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3REN3fC016206
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 14:23:04 GMT
Received: by wwb39 with SMTP id 39so1588644wwb.30
        for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 07:23:03 -0700 (PDT)
From: Elia Pinto <andronicus.spiros@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] fix description of init_system_domain in init.if
Date: Wed, 27 Apr 2011 16:22:59 +0200
Message-Id: <1303914179-527553-1-git-send-email-andronicus.spiros@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Elia Pinto <gitter.spiros@gmail.com>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Changelog                     |    2 ++
 policy/modules/system/init.if |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Changelog b/Changelog
index 99e8f45..e385097 100644
--- a/Changelog
+++ b/Changelog
@@ -1,3 +1,5 @@
+- Fix policy/modules/system/init.if init_system_domain description from 
+  Elia Pinto.
 - Postgresql selabel_lookup update from KaiGai Kohei.
 - Dovecot managesieve support from Mika Pfluger.
 - Semicolon after interface/template calls cleanup from Elia Pinto.
diff --git a/policy/modules/system/init.if b/policy/modules/system/init.if
index cc83689..6553873 100644
--- a/policy/modules/system/init.if
+++ b/policy/modules/system/init.if
@@ -304,7 +304,7 @@ interface(`init_ranged_daemon_domain',`
 ## </summary>
 ## <desc>
 ##	<p>
-##	Create a domain for long running processes (daemons/services)
+##	Create a domain for short running processes (daemons/services)
 ##	which are started by init scripts. These are generally applications that
 ##	are used to initialize the system during boot.
 ##	Long running processes
-- 
1.7.2.1.44.g721e7


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
