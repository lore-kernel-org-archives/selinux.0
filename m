Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49E3C433F5
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FDC6124D
	for <selinux@archiver.kernel.org>; Thu, 11 Nov 2021 16:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhKKQpk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Nov 2021 11:45:40 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38905 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234260AbhKKQpj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Nov 2021 11:45:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DD1EB5C0167
        for <selinux@vger.kernel.org>; Thu, 11 Nov 2021 11:42:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Nov 2021 11:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=SLMcWieriq/Hr49AqiTRFsz61h
        vcww915aiLFQhUT1k=; b=sq9DdH39y1b8jX8+r3DKEN+KWzU4IX65qlWElXOqAA
        RodmgpNi/Boj0i0oucFl9goYrBpwLHa5Sx5rH19G9NTFCqQV+cVSWwqgqCsrZcF2
        8mDwHcH9tAcm3g8iN+rPR6exTmBeyALvS6y5YZ18YhKprIh3y2OH2UzHQIoAFuvI
        5EwZJ8sEQ2zpEOpsLBF8ddAup7xQDXV1KblrnPseNVBhfMmK6qMtKDAleaKTwSWY
        XG4BiMFreOHEwxRM9p9r2TV/dIN52F9LLpHIkzQRNMA4Skn1k+xh2I8hmIvU2heL
        s3ROCT+E9K7gmET9U1mu5yh6CJyTS6aBNxIqfJrcTFGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SLMcWieriq/Hr49Aq
        iTRFsz61hvcww915aiLFQhUT1k=; b=Wxb8xzOik/tw7EQXBxeAOuA5ZRX/87eUy
        6eCw++k4iDogJKS/NZQm16NGpN/1vYZkrKLWXZFrTae5tR7Ix9E6EJjE+2d76Ucj
        DlmM932+Jd/UDXoJUJcA6QtEOFRPny3fdZFUR9zfx/dVD0D6KEROai9WtksfQ8ba
        q3tyZOlBqg46lZ80SdjMntXfPafNu9mOtlnKdiVnbBDpCnp7Ut/fq1mNgQx/m62G
        ZjHrjaMgG3sOr4A7eiIequBZIcGloGKkO0FCiQe97PS9oApJvXLl/E2+mpVft0cC
        52jnNj/5FeMt/iYMYUQHRhUN14mK4kr3idseFoeCA6FV1DW8QcMBg==
X-ME-Sender: <xms:CEiNYVOi2OQjjHUGZNcZkWly59PTV4fXGJxeJK7gedPPmKzejNM_9g>
    <xme:CEiNYX_LjfgdsW-ZBPqWhDpUm-S_1atrgoUppx7veci-CQdXMKNWWkrcF3iUSz8hj
    j4PR-qDSSymGieD2Q>
X-ME-Received: <xmr:CEiNYUQXqOtp020kskyR_O3xhb95pQY_bYLMt2J8uKXWSLJ8ZZt9aA2uq4qt8skXGtkxcKmNj48bVqTtCZ0hbBMdLxsCF0fk1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddugdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeen
    ucggtffrrghtthgvrhhnpeehvdffgffhteeijefgteeftdfghfdvheeuhedvjedugfeggf
    eljefgleefvefgfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehqhihlihhsshesgidvvddtrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:CEiNYRtsDAscvHAp2y3iPdR92Hz8qPZ77hHqkVUs8sH9zpk-8819zg>
    <xmx:CEiNYdcNkiwTC-FgLABQUf6dL3jbUXN28zGH-AVJom0dSAXTByRd4w>
    <xmx:CEiNYd2queeNazlLK9OvsH0OoveKei2byr_sSqq02Siom_FFf9V5QQ>
    <xmx:CUiNYTpPytUPal09JEdjR03lrZRX_b0CJc2uTDZTD2q64D6iGyuzbA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <selinux@vger.kernel.org>; Thu, 11 Nov 2021 11:42:48 -0500 (EST)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id DC8CA1BC; Thu, 11 Nov 2021 16:42:46 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     selinux@vger.kernel.org
Cc:     Alyssa Ross <hi@alyssa.is>
Subject: [PATCH] Support static-only builds
Date:   Thu, 11 Nov 2021 16:42:29 +0000
Message-Id: <20211111164229.9711-1-hi@alyssa.is>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Sometimes it's useful to have a static-only toolchain.  This can be
due to targetting some weird embedded platform, or it can be because
it ensures that no dynamic libraries are sneaking into a system that's
supposed to be 100% static due to non-cooperative build systems.  Most
build systems support static-only builds, e.g. autoconf provides a
--disable-shared configure option.

libselinux's custom make-based build system did not support such an
option, so here I've added one.  Apart from the obvious changes, I had
to make the utilities that use libpcre link against it manually,
because that can't be inferred from the static libselinux.  For
downstream users of libselinux using pkg-config, this shouldn't be a
problem, because libselinux.pc already includes the Requires.private
line that specifies libpcre should be linked against as well.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 libselinux/src/Makefile   | 11 ++++++++---
 libselinux/utils/Makefile |  6 +++++-
 libsepol/src/Makefile     | 11 ++++++++---
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 52c40f01..814012e1 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -136,7 +136,10 @@ endif
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
 
-all: $(LIBA) $(LIBSO) $(LIBPC)
+all: $(LIBA) $(LIBPC)
+ifneq ($(DISABLE_SHARED),y)
+all: $(LIBSO)
+endif
 
 pywrap: all selinuxswig_python_exception.i
 	CFLAGS="$(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
@@ -175,11 +178,13 @@ $(SWIGRUBYCOUT): $(SWIGRUBYIF)
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
 	$(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 36816155..12d028df 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -52,7 +52,11 @@ else
 TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
 endif
 
-sefcontext_compile: LDLIBS += ../src/libselinux.a $(PCRE_LDLIBS) -lsepol
+PCRE_USERS = matchpathcon sefcontext_compile selabel_digest \
+	selabel_get_digests_all_partial_matches selabel_lookup \
+	selabel_lookup_best_match selabel_partial_match
+$(PCRE_USERS): LDLIBS += $(PCRE_LDLIBS)
+sefcontext_compile: LDLIBS += ../src/libselinux.a -lsepol
 
 all: $(TARGETS)
 
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index dc8b1773..a3623635 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -39,7 +39,10 @@ LDFLAGS += -undefined dynamic_lookup
 LN=gln
 endif
 
-all: $(LIBA) $(LIBSO) $(LIBPC)
+all: $(LIBA) $(LIBPC)
+ifneq ($(DISABLE_SHARED),y)
+all: $(LIBSO)
+endif
 
 
 $(LIBA):  $(OBJS)
@@ -81,11 +84,13 @@ endif
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
-- 
2.33.0

