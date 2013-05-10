Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACkCI8015981
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:13 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 16/16] policycoreutils: Do not include LDFLAGS in CFLAGS when building sepolicy
Date: Fri, 10 May 2013 14:45:24 +0200
Message-Id: <1368189924-8501-17-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

For some reasons, -fpie and -fPIE are being set in LDFLAGS, this is
causing a FTBFS on Debian.

-fpie and -fPIE are anyway useless for libraries
---
 policycoreutils/sepolicy/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/sepolicy/Makefile b/policycoreutils/sepolicy/Makefile
index 11b534f..47f00da 100644
--- a/policycoreutils/sepolicy/Makefile
+++ b/policycoreutils/sepolicy/Makefile
@@ -9,7 +9,7 @@ LOCALEDIR ?= /usr/share/locale
 PYTHON ?= /usr/bin/python
 BASHCOMPLETIONDIR ?= $(DESTDIR)/etc/bash_completion.d/
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS = $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="policycoreutils" -Wall -Werror -Wextra -W  -DSHARED -shared
+override CFLAGS = -I$(PREFIX)/include -DPACKAGE="policycoreutils" -Wall -Werror -Wextra -W  -DSHARED -shared
 
 BASHCOMPLETIONS=sepolicy-bash-completion.sh 
 
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
