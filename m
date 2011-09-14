From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, guido@trentalancia.com, Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/2] libselinux: put libselinux.so.1 in /lib not /usr/lib
Date: Wed, 14 Sep 2011 14:50:38 -0400
Message-Id: <1316026239-27148-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Commit 874bac80bbfbf0a5 incorrectly changed the default install location
of libselinux.so.1 from /lib to /usr/lib.  This patch fixes that problem
by reverting that portion of the change.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 7680008..78874be 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -7,7 +7,7 @@ PYPREFIX ?= $(notdir $(PYTHON))
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
-SHLIBDIR ?= $(PREFIX)/lib
+SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
 PYLIBVER ?= $(shell $(PYTHON) -c 'import sys;print("python%d.%d" % sys.version_info[0:2])')
 PYINC ?= $(shell pkg-config --cflags $(PYPREFIX))
-- 
1.7.6.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
