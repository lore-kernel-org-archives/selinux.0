Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAGE5ZKO011164
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 09:05:42 -0500
Received: by mail-pf0-f194.google.com with SMTP id i88so9916591pfk.2
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 06:05:41 -0800 (PST)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/5] Add stub make test targets to new subdirs
Date: Wed, 16 Nov 2016 22:05:20 +0800
Message-Id: <1479305122-2419-3-git-send-email-jason@perfinion.com>
In-Reply-To: <1479305122-2419-1-git-send-email-jason@perfinion.com>
References: <1479305122-2419-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 dbus/Makefile        | 2 ++
 gui/Makefile         | 2 ++
 mcstrans/Makefile    | 2 ++
 restorecond/Makefile | 1 +
 4 files changed, 7 insertions(+)

diff --git a/dbus/Makefile b/dbus/Makefile
index c924052..9a6cc90 100644
--- a/dbus/Makefile
+++ b/dbus/Makefile
@@ -13,3 +13,5 @@ install:
 	install -m 755 selinux_server.py $(DESTDIR)/usr/share/system-config-selinux
 
 relabel:
+
+test:
diff --git a/gui/Makefile b/gui/Makefile
index 4170e94..d49a7ce 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -54,3 +54,5 @@ clean:
 indent:
 
 relabel:
+
+test:
diff --git a/mcstrans/Makefile b/mcstrans/Makefile
index eb3d955..c993a9f 100644
--- a/mcstrans/Makefile
+++ b/mcstrans/Makefile
@@ -14,3 +14,5 @@ clean:
 	$(MAKE) -C man clean
 
 relabel:
+
+test:
diff --git a/restorecond/Makefile b/restorecond/Makefile
index 02b7011..9f163f5 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -60,3 +60,4 @@ clean:
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
+test:
-- 
2.7.3
