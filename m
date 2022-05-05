Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8757C433EF
	for <selinux@archiver.kernel.org>; Thu,  5 May 2022 17:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382979AbiEERsU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 May 2022 13:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382889AbiEERsR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 May 2022 13:48:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A024ECF1
        for <selinux@vger.kernel.org>; Thu,  5 May 2022 10:43:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ks9so3694269ejb.2
        for <selinux@vger.kernel.org>; Thu, 05 May 2022 10:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpdEwmRBtbxOfwmx55vyOANzAeGpL6DVAYZswRItdMA=;
        b=Bf8VY4mKwfhnMjrR0UjVQUvK4llKnM3XnMbxJ4IRlkC2DjKmEk2k7f3OzmX9oJW/Bs
         v7QHfAWERQL09F80L+nwa+66w/FLEqVYb+4UsxiqfcN9zC8RwQsCgr/D3jc/boLBmB0K
         w06sZC1XJAWdgP4/W3slAiBG7orMINxNyZbQRXM+/smjsSS6PZxQ8N9vN82HmugOdzD0
         Qdnn3Wo3h+Zw4v74wJcf/blPvNvj9yVTUMm1a0LAj5JypdvzQ+fYTKq94Z5iJw37qrZj
         17SfvVR57TGjcFTjB2cFMI8FL0OpTfgjno4OWOCDUoqBVoaqFk78tuNqgUs7Un3r5+ad
         3V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpdEwmRBtbxOfwmx55vyOANzAeGpL6DVAYZswRItdMA=;
        b=3p77jybi2QrxqPKwQyk1S/1mz2q2FduCkg4HupL328Gs+wFPvA0wFuvWqfmguCKxNW
         xGKb/MIMhuueuYpXO84UJBdPtL8AjTa9oSGvY0tg1hTIuuaQ5BZz652glAilJpoWBHl8
         qGIMK1Tm6iKgadofIUVi25DFMsIUao5tpKgtv7zS2H2rxnS2yaBxS6KRm8XPZkEhIh/I
         Gg21t3fRudMJPnFdUTofaCMqt3tImqcWTZNmHc9cNmFkQ7sYrW+IRZ+C/KrAxrZpeRG4
         h+5X8HXgUUwOVaX9yHNelX29t5NGxoyr3KkFz5P3crmHWMDBHKWEfxtXLK5oLpcLFZ6L
         P4NA==
X-Gm-Message-State: AOAM533I6KhzKxm+dzcUp/3tFuG/6xnU0VGFFF9s/jPcucH/6kjWxXu4
        CAsD8MvvRatEMVFmOnV6U8CX7pd+PaI=
X-Google-Smtp-Source: ABdhPJw1+ZBU67sEXdRXHPFan0qU0sKD0uR5bnDOgI1hCN11JNL8KGYXZw9qB36DxwZ+nOtZwtPu0g==
X-Received: by 2002:a17:907:6ea3:b0:6f4:ac50:3346 with SMTP id sh35-20020a1709076ea300b006f4ac503346mr12433071ejc.457.1651772625010;
        Thu, 05 May 2022 10:43:45 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-152-226.77.1.pool.telefonica.de. [77.1.152.226])
        by smtp.gmail.com with ESMTPSA id rb48-20020a170907693000b006f3ef214e10sm987722ejc.118.2022.05.05.10.43.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:43:44 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: update man page of setfilecon(3) family about context parameter
Date:   Thu,  5 May 2022 19:43:38 +0200
Message-Id: <20220505174338.24370-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The family of setfilecon(3) functions take the context as a read-only
`const char *` parameter.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/setfilecon.3 | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setfilecon.3
index 0e9a383f..6bd3e415 100644
--- a/libselinux/man/man3/setfilecon.3
+++ b/libselinux/man/man3/setfilecon.3
@@ -5,17 +5,17 @@ setfilecon, fsetfilecon, lsetfilecon \- set SELinux security context of a file
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int setfilecon(const char *" path ", char *" con );
+.BI "int setfilecon(const char *" path ", const char *" con );
 .sp
-.BI "int setfilecon_raw(const char *" path ", char *" con );
+.BI "int setfilecon_raw(const char *" path ", const char *" con );
 .sp
-.BI "int lsetfilecon(const char *" path ", char *" con );
+.BI "int lsetfilecon(const char *" path ", const char *" con );
 .sp
-.BI "int lsetfilecon_raw(const char *" path ", char *" con );
+.BI "int lsetfilecon_raw(const char *" path ", const char *" con );
 .sp
-.BI "int fsetfilecon(int "fd ", char *" con );
+.BI "int fsetfilecon(int "fd ", const char *" con );
 .sp
-.BI "int fsetfilecon_raw(int "fd ", char *" con );
+.BI "int fsetfilecon_raw(int "fd ", const char *" con );
 .
 .SH "DESCRIPTION"
 .BR setfilecon ()
-- 
2.36.0

