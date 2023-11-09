Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F9BC4167B
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjKINwA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjKINv7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:51:59 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1C530CD
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:51:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d216597f64so149285166b.3
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699537915; x=1700142715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGQM2SEI9u/FQP01YPSBFkhEMljoDRo9HcGhfhpxNM0=;
        b=CUXc5Y0053pBySJxUi3e2vtwhpA7htyw0gHlR+DO19fAWGRXLGcu50J9Jg/NcFbd0h
         YG0Uu7YA+BYyPUCpOSdMjszQLXTJx9DetIDOhXbI3DPpPkfyUSH3JThmoSUpI/Dsjce4
         0Hg29uauF+K1eZpAnm9Nh5cd1VxaYpAK7ItFBhubqzGY5HC5Bw/kpF7e7xal7gxrE5yG
         OzIsSdEr36bPXvODnhiTRIOhygbK+0wWjUkdhIfTVPy22tp4QPHnk6v8BXefgD/Rnh1c
         rfZKxohRrzgwHDWwC5sH08UnNIcGj8vr49mDhxVGjp1esPNkODLFLQPDWWZ0ngJeuYEF
         9uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699537915; x=1700142715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGQM2SEI9u/FQP01YPSBFkhEMljoDRo9HcGhfhpxNM0=;
        b=TYBapo2J6lOYaWYbaKp7EWaxyWgtHfwyQrAVkSbOUcGCAuaEf013WKbyTD4tSZ69GT
         9AixnKCh0zAlXskyOCIZ/bgirWBxMSh19KRYgSSdy/njeZ9ujeSmN09n7GDPJuPDx0Qy
         LIonaoRgnvXka6zCHpCM7z+tokb2a/v/7PSXsU+WT077Sgz1+MC6x7gCa0b58hPJ3UXZ
         VvR9GKRK+octfTa2/CAPhFf2/hbWsZHUexNCm7taq6U8WmyQ337nTPoNWtU6yHZOSrwb
         hTU1QhbkolfO9DqcgDXFrybdWw8Lwe/8JDybPaUfq6HhLuDM95vdqyhzo+yL4PlZP6Gb
         BcPg==
X-Gm-Message-State: AOJu0YzXAwEUEryL1k4TFxjCxYrd8jemVvrZvSo0AihOuIy6Dft9Rez4
        19rNOF8Hni1yLvhzIzG7Ym4IfGByx/Y=
X-Google-Smtp-Source: AGHT+IH/Xv8w6Qgkhy8tv4MrYL2FRpeZ3yQJdTlp2/Ss9kgXZ3CsKaPt0PEJO9JRMvMrd0yDVIz1Fg==
X-Received: by 2002:a17:907:9802:b0:9de:32bb:fa96 with SMTP id ji2-20020a170907980200b009de32bbfa96mr4735185ejc.9.1699537915601;
        Thu, 09 Nov 2023 05:51:55 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b009829d2e892csm2623563ejb.15.2023.11.09.05.51.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:51:55 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 6/7] Update Python installation on Debian
Date:   Thu,  9 Nov 2023 14:51:47 +0100
Message-ID: <20231109135148.42688-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135148.42688-1-cgzones@googlemail.com>
References: <20231109135148.42688-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Between Debian 11 and 12 the way to install Python packages into the
system location under /usr, and not /usr/local, changed[1].  The
previous setup argument --install-layout=deb is now unsupported and the
environment variable DEB_PYTHON_INSTALL_LAYOUT needs to be set instead.

See also [2].

[1]: https://lists.debian.org/debian-devel/2023/07/msg00307.html
[2]: https://salsa.debian.org/selinux-team/libselinux/-/commit/cbfb31a0925e01591a9cce1eb3a0e517f42b144c

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 README.md              | 6 +++++-
 scripts/run-scan-build | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 8c475126..765b5626 100644
--- a/README.md
+++ b/README.md
@@ -108,7 +108,11 @@ To build and install everything under a private directory, run:
 
     make DESTDIR=~/obj install install-rubywrap install-pywrap
 
-On Debian `PYTHON_SETUP_ARGS='--install-option "--install-layout=deb"'` needs to be set when installing the python wrappers in order to create the correct python directory structure.
+On Debian the environment variable `DEB_PYTHON_INSTALL_LAYOUT` needs to be set
+to `deb` when installing the Python wrappers in order to create the correct
+Python directory structure.
+On Debian systems older than bookworm set
+`PYTHON_SETUP_ARGS='--install-option "--install-layout=deb"'` instead.
 
 To run tests with the built libraries and programs, several paths (relative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PATH` and `$PYTHONPATH`.
 This can be done using [./scripts/env_use_destdir](./scripts/env_use_destdir):
diff --git a/scripts/run-scan-build b/scripts/run-scan-build
index 931ffd2a..7b731f3e 100755
--- a/scripts/run-scan-build
+++ b/scripts/run-scan-build
@@ -25,7 +25,7 @@ export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysc
 export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
 
 if [ -f /etc/debian_version ] && [ -z "${IS_CIRCLE_CI:-}" ] ; then
-    export PYTHON_SETUP_ARGS='--install-layout=deb'
+    export DEB_PYTHON_INSTALL_LAYOUT='deb'
 fi
 
 # Build and analyze
-- 
2.42.0

