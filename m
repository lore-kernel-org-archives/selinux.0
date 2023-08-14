Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98925C001DB
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 14:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjHNOZ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 10:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHNOZ3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 10:25:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1929B2
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 07:25:27 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40694b191cfso35818501cf.3
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692023126; x=1692627926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYP6G7IdwZLL3wdIZSQ/WP4kNlNR4C08+ta1jzIZyKM=;
        b=SA2pa80vT92WYmZ520a2/0UcTtp+TCdb46VdzSX74cMyC36mkBmrSott6BTeBsISAK
         GANFE0wJyso12fMclP4Me3nkDNj89e2P0M5dxNWr7mUwj8heIqcMqyHOMd9gAV6n8VgG
         3Dpseqxl6P54AT0wgqWEmrt3pq8C2UFpuBCiODBCaPSY13Mdm3tyKG78BbdTRjrtdEEK
         vcuq6rHbSp9PvB6F+9S2/1HKyC58NjdNePC/Q+0xFppo0u4DWjyodF8WpcTB4WAc9DEd
         xGJbLSlE7m3+5SmqHWKy3+qVnYb+0AblbLOVtAKoRpkOFQcFtQQpEYmpgMWUXqzbAsFl
         KhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692023126; x=1692627926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYP6G7IdwZLL3wdIZSQ/WP4kNlNR4C08+ta1jzIZyKM=;
        b=NZKDzCt0PV98iTyDg67lfiR162fCtE3dRye3/oNFq0Ew7fgISoLksgo6CWS1+cSvSk
         D/r+2DY4INb1WZ7cObD8oFqEaByg4TEIfsGCqxYGtiO4cWo0RQ766TsygsKIOTRY5xyO
         +TXnXk0uNCwox1yvO1VB3k3ng28HWo+Naei6d03VZxpRnSQFOAuQ+QJ6DxX+2OFdnmHn
         9ihSejMaxwLsDOG9g3g03hs9K6lhK+AQBPi+u7RVatzUw71tNvHmWC2RfPyvYOONr6Tc
         KEzJgw0T4eW5Wlm0ns0ZAD7164R4XtECdnZDl+Riisodz3+bhuEENdZ3xD1DGbLetPMP
         s9sA==
X-Gm-Message-State: AOJu0Yx/2jv62M1Hrj1j2frp6ifypf5/c92qMTRkspJY93dEBWDYYBHH
        TQkZj01VJD5aK6ggQNE8A/LQIw9rX+U=
X-Google-Smtp-Source: AGHT+IEGLIQhlHQSMqsFHQYyeom7Y2xLdZ5p9nI14xOfk8mx/A2HWd4m9voMwAHipa1f1sLIYcNtAg==
X-Received: by 2002:a05:622a:5103:b0:400:9666:4349 with SMTP id ev3-20020a05622a510300b0040096664349mr13224473qtb.46.1692023126322;
        Mon, 14 Aug 2023 07:25:26 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id q5-20020ac87345000000b003fde3d63d22sm3103601qtp.69.2023.08.14.07.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:25:25 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] Do not automatically install Russian translations
Date:   Mon, 14 Aug 2023 10:25:16 -0400
Message-ID: <20230814142516.505390-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since they are being removed, there will be nothing to install.

Suggested-by: Petr Lautrbach <plautrba@redhat.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/Makefile                     | 2 +-
 gui/Makefile                             | 2 +-
 libselinux/man/Makefile                  | 2 +-
 libsemanage/man/Makefile                 | 2 +-
 libsepol/man/Makefile                    | 2 +-
 mcstrans/man/Makefile                    | 2 +-
 policycoreutils/load_policy/Makefile     | 2 +-
 policycoreutils/man/Makefile             | 2 +-
 policycoreutils/newrole/Makefile         | 2 +-
 policycoreutils/run_init/Makefile        | 2 +-
 policycoreutils/scripts/Makefile         | 2 +-
 policycoreutils/secon/Makefile           | 2 +-
 policycoreutils/semodule/Makefile        | 2 +-
 policycoreutils/sestatus/Makefile        | 2 +-
 policycoreutils/setfiles/Makefile        | 2 +-
 policycoreutils/setsebool/Makefile       | 2 +-
 python/audit2allow/Makefile              | 2 +-
 python/chcat/Makefile                    | 2 +-
 python/semanage/Makefile                 | 2 +-
 python/sepolicy/Makefile                 | 2 +-
 restorecond/Makefile                     | 2 +-
 sandbox/Makefile                         | 2 +-
 semodule-utils/semodule_expand/Makefile  | 2 +-
 semodule-utils/semodule_link/Makefile    | 2 +-
 semodule-utils/semodule_package/Makefile | 2 +-
 25 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index f9e1fc7c..c37e0310 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for building the checkpolicy program
 #
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/gui/Makefile b/gui/Makefile
index 4035fb21..b29610d4 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 SHAREDIR ?= $(PREFIX)/share/system-config-selinux
diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
index 4b3626d2..fdc0825f 100644
--- a/libselinux/man/Makefile
+++ b/libselinux/man/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX	?= /usr
 MANDIR ?=  $(PREFIX)/share/man
 MAN3SUBDIR ?= man3
diff --git a/libsemanage/man/Makefile b/libsemanage/man/Makefile
index f626447d..5e21a65e 100644
--- a/libsemanage/man/Makefile
+++ b/libsemanage/man/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 MANDIR ?=  $(PREFIX)/share/man
 MAN3SUBDIR ?= man3
diff --git a/libsepol/man/Makefile b/libsepol/man/Makefile
index f54e478d..0b410c19 100644
--- a/libsepol/man/Makefile
+++ b/libsepol/man/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 MANDIR ?=  $(PREFIX)/share/man
 MAN3SUBDIR ?= man3
diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
index 71713818..895a592d 100644
--- a/mcstrans/man/Makefile
+++ b/mcstrans/man/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 MANDIR ?=  $(PREFIX)/share/man
 MAN5SUBDIR ?= man5
diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
index c1ba805b..ad80d500 100644
--- a/policycoreutils/load_policy/Makefile
+++ b/policycoreutils/load_policy/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/policycoreutils/man/Makefile b/policycoreutils/man/Makefile
index 94bbf586..a4539f24 100644
--- a/policycoreutils/man/Makefile
+++ b/policycoreutils/man/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 MANDIR ?= $(PREFIX)/share/man
 MAN5DIR ?= $(MANDIR)/man5
diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
index b3ccf671..4b8145d3 100644
--- a/policycoreutils/newrole/Makefile
+++ b/policycoreutils/newrole/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
index e86364a4..619ebc1d 100644
--- a/policycoreutils/run_init/Makefile
+++ b/policycoreutils/run_init/Makefile
@@ -1,6 +1,6 @@
 
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Makefile
index 75e75b80..6d8196c6 100644
--- a/policycoreutils/scripts/Makefile
+++ b/policycoreutils/scripts/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
index 576a6203..440503a1 100644
--- a/policycoreutils/secon/Makefile
+++ b/policycoreutils/secon/Makefile
@@ -1,5 +1,5 @@
 # secon tool - command-line context
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
index 73801e48..9fbf99d6 100644
--- a/policycoreutils/semodule/Makefile
+++ b/policycoreutils/semodule/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
index 3dbb792b..aebf050c 100644
--- a/policycoreutils/sestatus/Makefile
+++ b/policycoreutils/sestatus/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 SBINDIR ?= $(PREFIX)/sbin
diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
index d7670a8f..84ffb08b 100644
--- a/policycoreutils/setfiles/Makefile
+++ b/policycoreutils/setfiles/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 SBINDIR ?= /sbin
 MANDIR = $(PREFIX)/share/man
diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
index c1440c1c..fc5b4ff6 100644
--- a/policycoreutils/setsebool/Makefile
+++ b/policycoreutils/setsebool/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
index 76bf4e37..fb04b8bd 100644
--- a/python/audit2allow/Makefile
+++ b/python/audit2allow/Makefile
@@ -2,7 +2,7 @@ PYTHON ?= python3
 SECILC ?= secilc
 
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/python/chcat/Makefile b/python/chcat/Makefile
index e4873bf4..7b3ee17f 100644
--- a/python/chcat/Makefile
+++ b/python/chcat/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/python/semanage/Makefile b/python/semanage/Makefile
index b53ee33d..628d135a 100644
--- a/python/semanage/Makefile
+++ b/python/semanage/Makefile
@@ -1,7 +1,7 @@
 PYTHON ?= python3
 
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
index 4e9e93d0..1a26cfdc 100644
--- a/python/sepolicy/Makefile
+++ b/python/sepolicy/Makefile
@@ -1,7 +1,7 @@
 PYTHON ?= python3
 
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/restorecond/Makefile b/restorecond/Makefile
index 8e9a5ef1..1ddfcc92 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -1,7 +1,7 @@
 PKG_CONFIG ?= pkg-config
 
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
diff --git a/sandbox/Makefile b/sandbox/Makefile
index 84cb5a39..360a8bc5 100644
--- a/sandbox/Makefile
+++ b/sandbox/Makefile
@@ -1,7 +1,7 @@
 PYTHON ?= python3
 
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 SYSCONFDIR ?= /etc/sysconfig
 BINDIR ?= $(PREFIX)/bin
diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-utils/semodule_expand/Makefile
index e63dcff2..ad776b15 100644
--- a/semodule-utils/semodule_expand/Makefile
+++ b/semodule-utils/semodule_expand/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/semodule-utils/semodule_link/Makefile b/semodule-utils/semodule_link/Makefile
index c5cf69cd..936d161c 100644
--- a/semodule-utils/semodule_link/Makefile
+++ b/semodule-utils/semodule_link/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
diff --git a/semodule-utils/semodule_package/Makefile b/semodule-utils/semodule_package/Makefile
index 680ab836..6a289f73 100644
--- a/semodule-utils/semodule_package/Makefile
+++ b/semodule-utils/semodule_package/Makefile
@@ -1,5 +1,5 @@
 # Installation directories.
-LINGUAS ?= ru
+LINGUAS ?=
 PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-- 
2.41.0

