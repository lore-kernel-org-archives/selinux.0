Message-Id: <20080121160225.053814842@manicmethod.com>
References: <20080121160031.792610312@manicmethod.com>
Date: Tue, 22 Jan 2008 14:43:32 -0500
From: Joshua Brindle <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com, tmiller@tresys.com
Subject: [POLICYREP] [patch 1/7] remove makefile targets that dont build
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

temporarilly remove targets that don't build with policyrep

---
 policycoreutils/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- policyrep.new.orig/policycoreutils/Makefile
+++ policyrep.new/policycoreutils/Makefile
@@ -1,4 +1,5 @@
-SUBDIRS=setfiles semanage load_policy newrole run_init restorecond secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
+SUBDIRS=setfiles load_policy newrole run_init restorecond secon audit2allow audit2why scripts sestatus po
+#setsebool semodule_package semanage semodule semodule_link semodule_expand semodule_deps 
 
 all install relabel clean indent:
 	@for subdir in $(SUBDIRS); do \

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
