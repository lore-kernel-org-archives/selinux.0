Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78126C433F5
	for <selinux@archiver.kernel.org>; Fri, 30 Sep 2022 21:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiI3V2K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiI3V14 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Sep 2022 17:27:56 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD437148A22
        for <selinux@vger.kernel.org>; Fri, 30 Sep 2022 14:27:52 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i12so3610066qvs.2
        for <selinux@vger.kernel.org>; Fri, 30 Sep 2022 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc:subject:date;
        bh=n3CsxGwPVQDuAhVOgt3F3jyE/RZWiBjZ3zZ7vgayOj0=;
        b=IW+aVSLGefeg+RuljmUxKWxICAhmRyAS8QhoEy+ZdWPK77q5qNvrDJ7jHm01Gh/JZ+
         1EjwNnGW4s6wc8Wb1M2VySTVBKVZC3M8S57N0OPqrLI2KDsJrmv9H8GLnwbsFtrobOBz
         m1b8QmYccIOKb+hHz6QYnXhZsmyBN1lG9HrpO1QjllGH/IazixAJG/CFfntIgEkRsdWG
         KZX0ObwrXt5SLmYXXXa3U0H69/JatguBixFhePZEDGV1sWcPe91RDyBbUx1l8yOUV46p
         9ijN/zeD7qdEfxpGdd4athJN45iewkyY2kIdUCNDyvln13+PD53kSf0pBG+dw6LqAxHa
         Z+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc:subject:date;
        bh=n3CsxGwPVQDuAhVOgt3F3jyE/RZWiBjZ3zZ7vgayOj0=;
        b=IZfXqQjSa/vZay7O1Vx65u0M65nG9Mvf4Hk/NBM0b8uIGV5hJQdQgOhj5VFx7QYOt6
         p6CuCQS0QmkvO21shEFbVq/sHsdrJoCj38dUx12zABxU6V60HMgpqt3OZ+httV12jxpi
         wUvE8EAkQMyRdHwrds/Htpi1hXMc+WOcvEQRnt/pukSqVRHK0RguNy/i86NheG2zKura
         oup+Jz47zO73hkHvjb7i5014ZrO7Rv0SiLXKExXvuN2bGQL1ou/k0UJgFXZ7IC04O1R3
         t0dbNUzkFVZvg6jpMZgSNwbIMIZA6At5HYTRD4XN35Hgd9b8wWzYp7QuCKllr7zRkm8v
         8odQ==
X-Gm-Message-State: ACrzQf33fKNAq5QyxlrNxksE2ezaJHB21QrFgT3UyOf6dj5eZyCnQiyY
        748/BPjRm/1t8j5zCGdDTfsaSnnRsbbm
X-Google-Smtp-Source: AMsMyM50qI2KsL4cAzKTywZDYMo7Yrzl3TlNWwv1W5SyWjLsdifiKuxQne5wePe1Vgno0llYYGeF0Q==
X-Received: by 2002:ad4:5c8e:0:b0:4af:7db6:29c4 with SMTP id o14-20020ad45c8e000000b004af7db629c4mr8366433qvh.27.1664573271488;
        Fri, 30 Sep 2022 14:27:51 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id r7-20020a05620a298700b006ce3e4fb328sm3578262qkp.42.2022.09.30.14.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:27:51 -0700 (PDT)
Subject: [PATCH] docs: update the README.md with a basic SELinux description
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Fri, 30 Sep 2022 17:27:50 -0400
Message-ID: <166457327058.375622.15969426802353557144.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is to help meet the OpenSSF Best Practices requirements.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 README.md |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/README.md b/README.md
index 74b0a0c3..306d9ed6 100644
--- a/README.md
+++ b/README.md
@@ -7,13 +7,18 @@ SELinux Userspace
 [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
 [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
 
-Please submit all bug reports and patches to <selinux@vger.kernel.org>.
-
-Subscribe by sending "subscribe selinux" in the body of an email
-to <majordomo@vger.kernel.org>.
-
-Archive of this mailing list is available on https://lore.kernel.org/selinux/.
-
+SELinux is a flexible Mandatory Access Control (MAC) system built into the
+Linux Kernel.  SELinux provides administrators with a comprehensive access
+control mechanism that enables greater access granularity over the existing
+Linux Discretionary Access Controls (DAC) and is present in many major Linux
+distributions.  This repository contains the sources for the SELinux utilities
+and system libraries which allow for the configuration and management of a
+SELinux-based system.
+
+Please submit all bug reports and patches to the <selinux@vger.kernel.org>
+maling list.  You can subscribe by sending "subscribe selinux" in the body of
+an email to <majordomo@vger.kernel.org>.  Archives of the mailing list are
+available at https://lore.kernel.org/selinux.
 
 Installation
 ------------

