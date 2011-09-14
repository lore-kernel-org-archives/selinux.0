From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, guido@trentalancia.com, Eric Paris <eparis@redhat.com>
Subject: [PATCH 2/2] libselinux: do not use relative path when creating libselinux symlinks
Date: Wed, 14 Sep 2011 14:50:39 -0400
Message-Id: <1316026239-27148-2-git-send-email-eparis@redhat.com>
In-Reply-To: <1316026239-27148-1-git-send-email-eparis@redhat.com>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At the moment we create a symlink:

/usr/lib/libselinux.so -> ../../lib/libselinux.so.1

This works if (and only if) $SHLIBDIR and $LIBDIR are different only by
../../.  Instead create a symlink from

$LIBDIR/libselinux.so->$SHLIBDIR/libselinux.so.1

Thus it works no matter what values one might use for LIBDIR and
SHLIBDIR.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 libselinux/src/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 78874be..bccc777 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -126,7 +126,7 @@ install: all
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	test -d $(LIBDIR)/pkgconfig || install -m 755 -d $(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(LIBDIR)/pkgconfig
-	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
+	ln -sf $(SHLIBDIR)/$(LIBSO) $(LIBDIR)/$(TARGET)
 
 install-pywrap: pywrap
 	test -d $(PYLIBDIR)/site-packages/selinux || install -m 755 -d $(PYLIBDIR)/site-packages/selinux
-- 
1.7.6.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
