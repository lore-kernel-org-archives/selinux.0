Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C1C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E0D2065C
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJzBMBbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgEOLlU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgEOLlU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 07:41:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AE3C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:41:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v5so1515641lfp.13
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 04:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWEautx5/qXtQqdi7hbg9b23O66q157qKbN1y5HNhck=;
        b=aJzBMBbitVVsko3zrBUNW/YUs4pZn+IVJQsA1zmeRtSOt67Id4uhtLXUfVcBxvk/42
         s8hqVq127sc7Ob6D19vB3QZcspcqGUXojou+Rx/pFnkjyY6ogR2ccHLmvhqa8Rk/SIBm
         GlGdZYWONQmpJg2uXMSae19Ds262j+DmqBkxEWshi7+BT9zYoejLcOxTlKDl1o/pyiWs
         ZdxmD64G+dBxORw1WlRkZeVRK0NMFXQ4EOO+f/w8Aq/qib7VR07U6gmr7JUTdYo7AmAX
         czvnwblinb2FQcpqU3TZesgu2rorbuqGef50harJHb44mX3G7RnglFol0chCvPqPJAME
         XpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UWEautx5/qXtQqdi7hbg9b23O66q157qKbN1y5HNhck=;
        b=BTIXdM01z9LWlAjfokdW8e5HelTNPkLWohoqOs25IMfJdOQHWJdbh8rGW2lVWkms8Y
         Tl3LVi83ljTBUZeJ74ANqcK/i6ZuUyQVT60/JU6sB27e6agV8xNaBnTVLGi5TSTKM2o7
         Tl+EuTHwtv28Qh5nPnqgauZDkG8Xp04Op9ehpqu6jsAsv9OLDb7D09DBUVwcfhZMOyRg
         k8JMEGCUzmnHpyCS0FqH+CTuqnjmne6rCJpv+XVh71PjOhs3R0aLlqEJcfrK8T/bTIIY
         SZ0+8JuiGMKYZP2JJxTz7SoKiH8y+8TwFfj+SrhxgKoSFcigkJZ0+tSb+HxnW8XCVCCV
         5q/w==
X-Gm-Message-State: AOAM533gP0LTzQCGJRTxaZq/RYofHmjSlQrYFh6aj/0wavyu+BAQylAc
        NBToaBvy+0xZLDrHRhzRUNfme0Bz
X-Google-Smtp-Source: ABdhPJysfuTE7k/cBfCf/Kw5Et4+GuQn9N0/VfzGVcbuFaer+KYh+n40fG+ERIEOihQ8gBBVPuQHkA==
X-Received: by 2002:ac2:596e:: with SMTP id h14mr2114278lfp.215.1589542876435;
        Fri, 15 May 2020 04:41:16 -0700 (PDT)
Received: from localhost.localdomain (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id o27sm1377977lfi.27.2020.05.15.04.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 04:41:15 -0700 (PDT)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v3] secilc/docs: fix use of TMPDIR
Date:   Fri, 15 May 2020 14:41:11 +0300
Message-Id: <20200515114111.11428-1-toiwoton@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Environment variable TMPDIR may be already set for the user building
and this could be equal to $XDG_RUNTIME_DIR or /tmp which are existing
directories. Then when running 'make clean', there are unintended side
effects:

rm -rf /run/user/1000
rm: cannot remove '/run/user/1000/dconf/user': Permission denied
rm: cannot remove '/run/user/1000/systemd': Permission denied
rm: cannot remove '/run/user/1000/gnupg': Permission denied
rm: cannot remove '/run/user/1000/dbus-1': Is a directory
rm: cannot remove '/run/user/1000/inaccessible': Permission denied
make[1]: *** [Makefile:68: clean] Error 1

Fix by always setting the variable.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
Suggested-by: Petr Lautrbach <plautrba@redhat.com>
---
 secilc/docs/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
index 6b07ce7f..197ccef2 100644
--- a/secilc/docs/Makefile
+++ b/secilc/docs/Makefile
@@ -1,8 +1,8 @@
-CWD ?= $(shell pwd)
-HTMLDIR ?= $(CWD)/html
-PDFDIR ?= $(CWD)/pdf
-TMPDIR ?= $(CWD)/tmp
-TESTDIR ?= $(CWD)/../test
+CWD = $(shell pwd)
+HTMLDIR = $(CWD)/html
+PDFDIR = $(CWD)/pdf
+TMPDIR = $(CWD)/tmp
+TESTDIR = $(CWD)/../test
 
 # All the markdown files that make up the guide:
 FILE_LIST ?= cil_introduction.md \
-- 
2.26.2

