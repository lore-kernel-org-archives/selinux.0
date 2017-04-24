Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OI0FkO026571
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 14:00:15 -0400
Received: by mail-pg0-f65.google.com with SMTP id t7so2321412pgt.1
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 11:00:12 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/7] policycoreutils: honour LINGUAS variable
Date: Tue, 25 Apr 2017 01:59:53 +0800
Message-Id: <20170424175959.20998-1-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If the user has the $LINGUAS environment variable set, only translations
for those languages should be installed to the system.

The gettext manual [1] says:

"Internationalized packages have usually many ll.po files. Unless
translations are disabled, all those available are installed together
with the package. However, the environment variable LINGUAS may be set,
prior to configuration, to limit the installed set. LINGUAS should then
contain a space separated list of two-letter codes, stating which
languages are allowed."

[1]: https://www.gnu.org/software/gettext/manual/html_node/Installers.html#Installers

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/po/Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/po/Makefile b/policycoreutils/po/Makefile
index f6069dd..5814861 100644
--- a/policycoreutils/po/Makefile
+++ b/policycoreutils/po/Makefile
@@ -20,8 +20,16 @@ MSGMERGE_FLAGS	= -q
 XGETTEXT	= xgettext --default-domain=$(NLSPACKAGE)
 MSGFMT		= msgfmt
 
-# What do we need to do
-POFILES		= $(wildcard *.po)
+# All possible linguas
+PO_LINGUAS := $(sort $(patsubst %.po,%,$(wildcard *.po)))
+
+# Only the files matching what the user has set in LINGUAS
+USER_LINGUAS := $(filter $(patsubst %,%%,$(LINGUAS)),$(PO_LINGUAS))
+
+# if no valid LINGUAS, build all languages
+USE_LINGUAS := $(if $(USER_LINGUAS),$(USER_LINGUAS),$(PO_LINGUAS))
+
+POFILES		= $(patsubst %,%.po,$(USE_LINGUAS))
 MOFILES		= $(patsubst %.po,%.mo,$(POFILES))
 POTFILES = \
 	../run_init/open_init_pty.c \
-- 
2.10.2
