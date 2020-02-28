Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B29BC3F2CD
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8B22469D
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 13:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAv8+UD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgB1Nc3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:32:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37407 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgB1Nc2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 08:32:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id z12so1547183pgl.4
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Rlq5oVkxSX8db+jDUw+H7Im2GVqUXUi+exDwS5eohA=;
        b=RAv8+UD3vDbGZNNpXeh8Azr/HueWjYRd2ZGuiVpsYqUTV5t2kRv3NzgNQXWtC3Eto3
         Hzyd0waoWVotiSCD0HKFF6+f5CRQViVAotDmTIGMIfNZB9mYKkfUccWHpI0/Zgn1WvHg
         ipQGTg3GsyhnwIfmJvuKFwsSaWRnUyJF5VayB379Xm+wXDjTVpwNIBBfuSFjlGjXrtSo
         U38Z3KN2+a9rGaR5+2VwOAqCa2X1upTKcqrzFK1usM8xNLZuiUS40T5cKqcuhczsjVza
         kX28KfrNR/kMhFwvsx5x+e9ElfRleKK7v3uHFyBii8HxxjVN6qZ3bY7ZeRnvfZhXPTHP
         1gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Rlq5oVkxSX8db+jDUw+H7Im2GVqUXUi+exDwS5eohA=;
        b=nrzOox1Q9wa1/julNPJ4i637tTjUJ7JXSG/qZtNzI/ZFoNYNXi1JMm/MP5Fc78yNS7
         FjqvpEmHCrNJ+zjWzbB1BTlxW30PTEVe7qBScqL6Y2jbiYbBdJA3XxCd6LyaFpwNFWuV
         4WXgVPUnKIqJ9XKcueFv/qyH36DQlOBOiHF+5qtfodqahLp8tiQOLoayzk/h4CX78jsk
         QRt9kvz2W2kPZOjdV/36wiON3Cvo6bxqjWZGftHAFx/CWrpLRfBhA63HsXLGUieB1IvD
         OAE395qStj7Q/iPd4rTEoIP3CWl/rW+1XKQP6Pt0UYI7HGBxnd/AVMyIkxyZ73mW0/jI
         z8SQ==
X-Gm-Message-State: APjAAAXWPILtc0PdvdGIzANI9fQxSoahwlJhjzYCHYLbkLAnnLZXpgUx
        W8WPpQ3FWC5TtzTi+ACM7ykLhHbm
X-Google-Smtp-Source: APXvYqxi3mojIs8sjgUTyG03n/EBNTSW3mOehkV4b7eyG7emCAy9X2Cp10H76fw5koGJmQdnTTI6Tg==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr4600308pfi.25.1582896747398;
        Fri, 28 Feb 2020 05:32:27 -0800 (PST)
Received: from localhost.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id dw10sm2453686pjb.11.2020.02.28.05.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:32:26 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org, omosnace@redhat.com
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] libsemanage: check libsepol version
Date:   Fri, 28 Feb 2020 07:32:07 -0600
Message-Id: <20200228133207.32441-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
References: <CAFftDdr0uCE106AYCgs27nubTntevz40WiFzMr7rn4sFrdWazQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

If libsepol is older than version 3.0, the required routine
sepol_policydb_optimize will not be present. Use pkg-config to get the
modversion and check that it is 3.0 or higher.

This can manifest as a compilation issue:
direct_api.c: In function ‘semanage_direct_commit’:
direct_api.c:1466:13: error: implicit declaration of function ‘sepol_policydb_optimize’; did you mean ‘sepol_policydb_to_image’? [-Werror=implicit-function-declaration]
     retval = sepol_policydb_optimize(out);

Which is not really clear on how to check.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsemanage/src/Makefile | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index f6780dc6048e..a329797fe1cc 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -65,6 +65,14 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
 
 SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
 
+sepol-version-check:
+	@v=$$($(PKG_CONFIG) --modversion libsepol); \
+	major=$$(echo "$$v" | cut -d"." -f 1-1); \
+	if [ "$$major" -lt 3 ]; then \
+		>&2 echo "libsepol is required to be version 3.0 or higher, got: $$v"; \
+		exit 1; \
+	fi
+
 all: $(LIBA) $(LIBSO) $(LIBPC)
 
 pywrap: all $(SWIGSO)
@@ -83,12 +91,12 @@ $(SWIGSO): $(SWIGLOBJ)
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
 	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lsemanage $(RUBYLIBS)
 
-$(LIBA): $(OBJS)
-	$(AR) rcs $@ $^
+$(LIBA): sepol-version-check $(OBJS)
+	$(AR) rcs $@ $(filter-out $<,$^)
 	$(RANLIB) $@
 
-$(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+$(LIBSO): sepol-version-check $(LOBJS)
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $(filter-out $<,$^) -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
@@ -163,4 +171,4 @@ distclean: clean
 indent:
 	../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
 
-.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
+.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean sepol-version-check
-- 
2.17.1

