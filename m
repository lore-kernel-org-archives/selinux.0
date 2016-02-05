Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u15Kuq2K031606
 for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2016 15:56:54 -0500
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BF3F05647AE
 for <selinux@tycho.nsa.gov>; Fri,  5 Feb 2016 21:56:48 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] policycoreutils: sepolicy: do not overwrite CFLAGS
Date: Fri,  5 Feb 2016 21:55:50 +0100
Message-Id: <1454705751-1448-2-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1454705751-1448-1-git-send-email-nicolas.iooss@m4x.org>
References: <1454705751-1448-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

sepolicy Makefile overwrites CFLAGS value, which prevents compiling its
Python module with custom compilation flags.  Modify it to append flags
to CFLAGS instead, like other policycoreutils programs do.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/sepolicy/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/sepolicy/Makefile b/policycoreutils/sepolicy/Makefile
index 45edb0c2a499..099a8a057fe1 100644
--- a/policycoreutils/sepolicy/Makefile
+++ b/policycoreutils/sepolicy/Makefile
@@ -11,7 +11,7 @@ MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 BASHCOMPLETIONDIR ?= $(DESTDIR)/usr/share/bash-completion/completions
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS = -I$(PREFIX)/include -DPACKAGE="policycoreutils" -Wall -Werror -Wextra -W  -DSHARED -shared
+override CFLAGS += -I$(PREFIX)/include -DPACKAGE="policycoreutils" -Wall -Werror -Wextra -W  -DSHARED -shared
 
 BASHCOMPLETIONS=sepolicy-bash-completion.sh
 
-- 
2.7.0
