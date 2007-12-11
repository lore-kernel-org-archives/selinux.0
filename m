Message-ID: <475EEF4D.4000807@manicmethod.com>
Date: Tue, 11 Dec 2007 15:13:01 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] [STABLE] Makefile change to disable restorecond
References: <475EED72.3090607@manicmethod.com>
In-Reply-To: <475EED72.3090607@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> This patch is necessary to build stable on RHEL4. CLIP uses the 
> current stable toolchain and supports RHEL4 as a target so we are 
> trying to upstream any magic that is necessary to build on that platform.
>
Ignore last patch, this one is actually against stable :)

Index: policycoreutils/Makefile
===================================================================
--- policycoreutils/Makefile    (revision 2677)
+++ policycoreutils/Makefile    (working copy)
@@ -1,5 +1,9 @@
-SUBDIRS=setfiles semanage load_policy newrole run_init restorecon restorecond secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
+SUBDIRS=setfiles semanage load_policy newrole run_init restorecon secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
 
+ifndef NO_INOTIFY
+       SUBDIRS += restorecond
+endif
+
 all install relabel clean indent:
        @for subdir in $(SUBDIRS); do \
                (cd $$subdir && $(MAKE) $@) || exit 1; \
Index: Makefile
===================================================================
--- Makefile    (revision 2677)
+++ Makefile    (working copy)
@@ -1,6 +1,8 @@
 SUBDIRS=libsepol libselinux libsemanage checkpolicy policycoreutils # policy
 PYSUBDIRS=libselinux libsemanage
 
+export NO_INOTIFY
+
 ifeq ($(DEBUG),1)
        export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow
        export LDFLAGS = -g



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
