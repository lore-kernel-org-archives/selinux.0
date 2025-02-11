Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC5266F03
	for <selinux@vger.kernel.org>; Tue, 11 Feb 2025 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308773; cv=none; b=M7zGpv2U5rRd3cj0Eqj/fDk8TGQrsdPYlsh3XjrFZI+AV+zIaOY4LP9n3bx5NBn/rbuEXvJ3OFcd4RvS33LHYK4kumw7CAuLhyWfKzRQxL5Jj6ew7KHFTLZos41zrdrMRJMQjbGscLO0iPOCxh5Vly43uhEJeFg4GP1oizOpvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308773; c=relaxed/simple;
	bh=dsK8tynRW8RqcikBfPmcMHXfMX+sOraaGNs1lqkhZFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkAKgwg12x0LAeu3cM8In/JJ5S2J/DQM85cJoUSm2kj4iMozzJYIX1rr9+NkIV9LB3X+F52V9CMzyOBH39ibuXK1giO+U+Tj9dZSJr2fEyZN3HHyjEqHE31wjw+E0kGprRYe7TCN9np51MPoADMTOkTVxTR7lrjZuAI7Glrx0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=QO9rxGF3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dsRNXGrw; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="QO9rxGF3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dsRNXGrw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AA3E0138099B;
	Tue, 11 Feb 2025 16:19:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 11 Feb 2025 16:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1739308768; x=1739395168; bh=FrJ6lsft3Igdr6w2bvUoT
	gkgULa1RI2BaQR/YnwXEbs=; b=QO9rxGF33FGIU1ab9szsPmlWbnS/m2ts91bIC
	CJJ2Y16vhFxWdINKijrSw/qXFEASFKrvC2P81+pi0g5oV+ITa+dhzTvzbvzibGb8
	aCnsZ7MiyqO+n9+CmY3dgmrNQFjkuPBR57V9Ms2MssFQ83c3RRYMgxWVbsM6aGDW
	WwzxE6/ax6oo+z8YvOE6qOUnX55JpPwr9qMAIwGVXIAi+sxZRC/lwhmrkNOTGciz
	5ICImtyfbO2iMOdy62bPk2T7FgXWH+c5DBPFOiQRvrOhX4i3R+qIZsz67TC7lVMC
	mR5eOmtDM48Lh3CbA9vUGW0yl8Y/+tueEUXFUnPt4ZsKEXinw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739308768; x=1739395168; bh=FrJ6lsft3Igdr6w2bvUoTgkgULa1RI2BaQR
	/YnwXEbs=; b=dsRNXGrwwDHgHuirqP1y691/VvPs7eM4oUOTKfI5OTZMZCLwimP
	11Kq94OcG9rMtpYr2qqflbSccuA+twzc+CoNqo59K0w5Bpf37IqE5kIBD79Q3Hlk
	FlDglHeNBWBvYX7zmJk3BTGQGcmGBEPRZJEq4YjZxjChi6+THplbaVB/wXcJVUkp
	b5GXWWifmf130yc2WnaG6fyQTa6orn7OcNvv2bjqPinuoF/PeFAEQdjx8v9BzNJ3
	48HYqFXrm/Lp66fMSGS15aY89gqTr+FAEtMdi7C8LMs1IdWfWfNYxpjqbo1wW5a2
	4lf5A7HSi27U3aSOCrBgpXOv1KamqG2RSnQ==
X-ME-Sender: <xms:376rZ8JIjk9x2cxZxBj6P8YPZsP4tBj8tDPXuXPWGrAQ533oAUAJuQ>
    <xme:376rZ8JiwUvAIpzB_LdxpJ1Xig77rClYepwMdI5q7ZFhYEMhHOpsxKq3zQvNY1e7-
    1FUrCY0NemZUT990Q>
X-ME-Received: <xmr:376rZ8uwST6u18wvDcgk5puSj11kHjBh0UrIdAiZ97xHJHrpog3hQcKQTjAHVVKHZztASekBF8zml9R_tPIDKge6Qsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtf
    frrghtthgvrhhnpeeufeeivdehffevgeeijeejvefgjeejudevkeffieevueevvdetvdfh
    leeiuedtgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhspdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnihgtoh
    hlrghsrdhiohhoshhssehmgeigrdhorhhgpdhrtghpthhtohepshgvlhhinhhugiesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4L6rZ5YUPgTQm_znE3wNSgEOK2WjGd_wUHsALROa_AmR2DVwM6-hNg>
    <xmx:4L6rZzZMed_aKREbCpl8jyTbOqdDRRtYmkIWiHxC6Pv3pMaPNayZ_w>
    <xmx:4L6rZ1CTzLfS5iEY88BoQO79RCrlFOkDD9O9ovGJ8H_n70Bsnb5dVQ>
    <xmx:4L6rZ5Yq0q5Bo-iPTdi-rManoS3U30smQ86Fl9ItSvdJ0wrI8jLfqQ>
    <xmx:4L6rZylqkW95k4XX6trAgDWB3X4d0lWZH5UGRtVqH7gnBrNq1aODWoRS>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 16:19:27 -0500 (EST)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id 070EE3AA3890; Tue, 11 Feb 2025 22:19:24 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: selinux@vger.kernel.org
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH v3] Support static-only builds
Date: Tue, 11 Feb 2025 22:16:53 +0100
Message-ID: <20250211211651.1297357-3-hi@alyssa.is>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes it's useful to have a static-only toolchain.  This can be
due to targetting some weird embedded platform, or it can be because
it ensures that no dynamic libraries are sneaking into a system that's
supposed to be 100% static due to non-cooperative build systems.  Most
build systems support static-only builds, e.g. autoconf provides a
--disable-shared configure option.

selinux's custom make-based build system did not support such an
option, so here I've added one.  Apart from the obvious changes, I had
to make the utilities that use external libraries link against them
manually, because that can't be inferred from the static selinux
libraries.  For downstream users of libselinux using pkg-config, this
shouldn't be a problem, because libselinux.pc already includes the
Requires.private line that specifies libpcre should be linked against
as well.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
Changes since v3:

 • Resolve conflicts.
 • Add selabel_compare to PCRE_USERS.
 • Use pkg-config for libselinux in policycoreutils, so PCRE is linked.

v2: https://lore.kernel.org/selinux/20211113141616.361640-1-hi@alyssa.is

 libselinux/src/Makefile              | 11 ++++++++---
 libselinux/utils/Makefile            |  8 +++++++-
 libsemanage/src/Makefile             |  9 +++++++--
 libsepol/src/Makefile                | 11 ++++++++---
 policycoreutils/Makefile             |  5 +++++
 policycoreutils/load_policy/Makefile |  2 +-
 policycoreutils/newrole/Makefile     |  2 +-
 policycoreutils/run_init/Makefile    |  2 +-
 policycoreutils/secon/Makefile       |  2 +-
 policycoreutils/semodule/Makefile    |  3 ++-
 policycoreutils/sestatus/Makefile    |  2 +-
 policycoreutils/setfiles/Makefile    |  2 +-
 policycoreutils/setsebool/Makefile   |  3 ++-
 policycoreutils/unsetfiles/Makefile  |  2 +-
 14 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 213c7d34..261c22d4 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -147,7 +147,10 @@ endif
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
 
-all: $(LIBA) $(LIBSO) $(LIBPC)
+all: $(LIBA) $(LIBPC)
+ifneq ($(DISABLE_SHARED),y)
+all: $(LIBSO)
+endif
 
 pywrap: all selinuxswig_python_exception.i
 	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
@@ -186,11 +189,13 @@ $(SWIGRUBYCOUT): $(SWIGRUBYIF)
 install: all 
 	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
 	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
-	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
-	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
 	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
+ifneq ($(DISABLE_SHARED),y)
+	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
+	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
+endif
 
 install-pywrap: pywrap
 	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 0d7095b1..6b1dc7c9 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -53,7 +53,13 @@ else
 TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 endif
 
-sefcontext_compile: LDLIBS += ../src/libselinux.a $(PCRE_LDLIBS) -lsepol
+sefcontext_compile: LDLIBS += ../src/libselinux.a -lsepol
+
+PCRE_USERS = matchpathcon sefcontext_compile selabel_compare \
+	selabel_digest selabel_get_digests_all_partial_matches \
+	selabel_lookup selabel_lookup_best_match \
+	selabel_partial_match
+$(PCRE_USERS): LDLIBS += $(PCRE_LDLIBS)
 
 all: $(TARGETS)
 
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 8dfbd762..7d60b1e9 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -67,7 +67,10 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 
-all: $(LIBA) $(LIBSO) $(LIBPC)
+all: $(LIBA) $(LIBPC)
+ifneq ($(DISABLE_SHARED),y)
+all: $(LIBSO)
+endif
 
 pywrap: all $(SWIGSO)
 
@@ -137,11 +140,13 @@ swigify: $(SWIGIF)
 install: all
 	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
 	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
-	install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
 	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
 	test -f $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION)
+ifneq ($(DISABLE_SHARED),y)
+	install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
 	cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
+endif
 
 install-pywrap: pywrap
 	test -d $(DESTDIR)$(PYTHONLIBDIR) || install -m 755 -d $(DESTDIR)$(PYTHONLIBDIR)
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 71fa3ed7..a1aed072 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -45,7 +45,10 @@ LDFLAGS += -undefined dynamic_lookup
 LN=gln
 endif
 
-all: $(LIBA) $(LIBSO) $(LIBPC)
+all: $(LIBA) $(LIBPC)
+ifneq ($(DISABLE_SHARED),y)
+all: $(LIBSO)
+endif
 
 
 $(LIBA):  $(OBJS)
@@ -87,11 +90,13 @@ endif
 install: all
 	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
 	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
-	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
-	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
 	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
 	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
+ifneq ($(DISABLE_SHARED),y)
+	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
+	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
 	$(LN) -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
+endif
 
 relabel:
 	/sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
index 32ad0201..7acd51dd 100644
--- a/policycoreutils/Makefile
+++ b/policycoreutils/Makefile
@@ -1,5 +1,10 @@
 SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setsebool scripts po man hll unsetfiles
 
+PKG_CONFIG ?= pkg-config
+
+LIBSELINUX_LDLIBS := $(shell $(PKG_CONFIG) --libs libselinux)
+export LIBSELINUX_LDLIBS
+
 all install relabel clean indent:
 	@for subdir in $(SUBDIRS); do \
 		(cd $$subdir && $(MAKE) $@) || exit 1; \
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index ad80d500..37c0111b 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -7,7 +7,7 @@ LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += $(LDFLAGS) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-override LDLIBS += -lsepol -lselinux
+override LDLIBS += $(LIBSELINUX_LDLIBS) -lsepol
 
 TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 
diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index 4b8145d3..6e95e79f 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -25,7 +25,7 @@ VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
 EXTRA_OBJS =
 override CFLAGS += -DVERSION=\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-override LDLIBS += -lselinux
+override LDLIBS += $(LIBSELINUX_LDLIBS)
 ifeq ($(PAMH), y)
 	override CFLAGS += -DUSE_PAM
 	EXTRA_OBJS += hashtab.o
diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
index 619ebc1d..a5002587 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -11,7 +11,7 @@ AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-override LDLIBS += -lselinux
+override LDLIBS += $(LIBSELINUX_LDLIBS)
 ifeq ($(PAMH), y)
 	override CFLAGS += -DUSE_PAM
 	override LDLIBS += -lpam -lpam_misc
diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
index 440503a1..daa3e10e 100644
--- a/policycoreutils/secon/Makefile
+++ b/policycoreutils/secon/Makefile
@@ -8,7 +8,7 @@ WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wca
 VERSION = $(shell cat ../VERSION)
 CFLAGS ?= $(WARNS) -O1
 override CFLAGS += -DVERSION=\"$(VERSION)\"
-override LDLIBS += -lselinux
+override LDLIBS += $(LIBSELINUX_LDLIBS)
 
 all: secon
 
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index 9fbf99d6..3855f95e 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -5,11 +5,12 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
-override LDLIBS += -lsepol -lselinux -lsemanage
+override LDLIBS += -lsemanage -lsepol $(LIBSELINUX_LDLIBS)
 SEMODULE_OBJS = semodule.o
 
 all: semodule genhomedircon
 
+semodule: LDLIBS += -laudit -lbz2
 semodule: $(SEMODULE_OBJS)
 
 genhomedircon:
diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index aebf050c..b0df6d28 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -8,7 +8,7 @@ ETCDIR ?= /etc
 
 CFLAGS ?= -Werror -Wall -W
 override CFLAGS += -D_FILE_OFFSET_BITS=64
-override LDLIBS += -lselinux
+override LDLIBS += $(LIBSELINUX_LDLIBS)
 
 all: sestatus
 
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index 84ffb08b..0b27e934 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
 AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
 
 CFLAGS ?= -g -Werror -Wall -W
-override LDLIBS += -lselinux -lsepol -lpthread
+override LDLIBS += $(LIBSELINUX_LDLIBS) -lsepol -lpthread
 
 ifeq ($(AUDITH), y)
 	override CFLAGS += -DUSE_AUDIT
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index fc5b4ff6..12b6315d 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -6,13 +6,14 @@ MANDIR = $(PREFIX)/share/man
 BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
 
 CFLAGS ?= -Werror -Wall -W
-override LDLIBS += -lselinux -lsemanage
+override LDLIBS += -lsemanage $(LIBSELINUX_LDLIBS)
 SETSEBOOL_OBJS = setsebool.o
 
 BASHCOMPLETIONS=setsebool-bash-completion.sh 
 
 all: setsebool
 
+setsebool: LDLIBS += -laudit -lbz2
 setsebool: $(SETSEBOOL_OBJS)
 
 install: all
diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unsetfiles/Makefile
index 9e5edc04..bdc1b9de 100644
--- a/policycoreutils/unsetfiles/Makefile
+++ b/policycoreutils/unsetfiles/Makefile
@@ -3,7 +3,7 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 
 override CFLAGS += -D_GNU_SOURCE
-override LDLIBS += -lselinux
+override LDLIBS += $(LIBSELINUX_LDLIBS)
 
 
 all: unsetfiles

base-commit: 71aec30d068789e856e7cc429b620ae1cfa890f1
-- 
2.47.0

