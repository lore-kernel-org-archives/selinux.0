From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH libselinux 11/11] Enable many more gcc warnings for libselinux/utils builds
Date: Mon, 23 Jan 2012 15:41:21 +0000
Message-Id: <1327333281-4223-12-git-send-email-berrange@redhat.com>
In-Reply-To: <1327333281-4223-1-git-send-email-berrange@redhat.com>
References: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: "Daniel P. Berrange" <berrange@redhat.com>

---
 libselinux/utils/Makefile |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 6f5aa52..4b2f348 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -4,7 +4,25 @@ LIBDIR ?= $(PREFIX)/lib
 BINDIR ?= $(PREFIX)/sbin
 _BINDIR ?= $(DESTDIR)/sbin
 
-CFLAGS ?= -Werror -Wall -W
+MAX_STACK_SIZE=8192
+CFLAGS ?= -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissing-include-dirs \
+          -Wunused -Wunknown-pragmas -Wstrict-aliasing -Wshadow -Wpointer-arith \
+          -Wbad-function-cast -Wcast-align -Wwrite-strings -Wlogical-op -Waggregate-return \
+          -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes \
+          -Wmissing-declarations -Wmissing-noreturn -Wmissing-format-attribute \
+          -Wredundant-decls -Wnested-externs -Winline -Winvalid-pch -Wvolatile-register-var \
+          -Wdisabled-optimization -Wbuiltin-macro-redefined -Wmudflap -Wpacked-bitfield-compat \
+          -Wsync-nand -Wattributes -Wcoverage-mismatch -Wmultichar -Wcpp \
+          -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion -Wendif-labels -Wextra \
+          -Wformat-contains-nul -Wformat-extra-args -Wformat-zero-length -Wformat=2 -Wmultichar \
+          -Wnormalized=nfc -Woverflow -Wpointer-to-int-cast -Wpragmas -Wsuggest-attribute=const \
+          -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure -Wtrampolines \
+          -Wno-missing-field-initializers -Wno-sign-compare -Wjump-misses-init \
+          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=2 \
+          -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
+          -fasynchronous-unwind-tables -fdiagnostics-show-option -funit-at-a-time \
+          -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
+          -Werror -Wno-aggregate-return -Wno-redundant-decls
 override CFLAGS += -I../include -D_GNU_SOURCE $(EMFLAGS)
 LDLIBS += -L../src -lselinux -L$(LIBDIR)
 
-- 
1.7.7.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
