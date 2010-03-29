Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2TH5ls5010427
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2010 13:05:48 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o2TH5MgJ017410
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2010 17:05:22 GMT
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Dan Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH] Make building sandbox conditional on presence of cap-ng.h
Date: Mon, 29 Mar 2010 13:08:36 -0400
Message-Id: <1269882516-17933-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sandbox requires cap-ng so I added a conditional build the same way we have one for inotify.h. It would be nice to have a better dependency system some day.

This should be applied on top of the Sandbox patch by Dan Walsh <dwalsh@redhat.com> 

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 policycoreutils/Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
index c7a590e..c68194a 100644
--- a/policycoreutils/Makefile
+++ b/policycoreutils/Makefile
@@ -1,4 +1,4 @@
-SUBDIRS = setfiles semanage load_policy newrole run_init secon audit2allow audit2why sandbox scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
+SUBDIRS = setfiles semanage load_policy newrole run_init secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
 
 INOTIFYH = $(shell ls /usr/include/sys/inotify.h 2>/dev/null)
 
@@ -6,6 +6,12 @@ ifeq (${INOTIFYH}, /usr/include/sys/inotify.h)
 	SUBDIRS += restorecond
 endif
 
+CAPNGH = $(shell ls /usr/include/cap-ng.h 2>/dev/null)
+
+ifeq (${CAPNGH}, /usr/include/cap-ng.h)
+	SUBDIRS += sandbox
+endif
+
 all install relabel clean indent:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
-- 
1.7.0.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
