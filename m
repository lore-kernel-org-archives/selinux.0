Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB28EC433FE
	for <selinux@archiver.kernel.org>; Sat,  1 Oct 2022 13:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJANsD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Oct 2022 09:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJANsB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Oct 2022 09:48:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6747CACA15
        for <selinux@vger.kernel.org>; Sat,  1 Oct 2022 06:47:55 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j10so4204034qtv.4
        for <selinux@vger.kernel.org>; Sat, 01 Oct 2022 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc:subject:date;
        bh=lThnaEK1769WrtOgHVr38+Ki+TeOtnijRB37FoJsgiQ=;
        b=h6m2HcAtRtUy1ailmUV20WzxGilt8dcrKBVQdyUrhZBynP84FHp+cHQYcKUWu+Fm+F
         cFnOGcc9LcCu07AeUFGjm2GC9iPxmKzaq0SJJ03uhgRCNpjOTw5digmcWLX46iN3vEZ+
         LrXrZgyL90a1H4R6QMGsuBmqrUZ+V7SXSylkesA+vbLh/lJ8KVmm00Zk0STA3+BqEJts
         wk+8tyteAiN9YOV1FNeGLD+JvfCAEUxGfngM+ipX7fi0+D2qoeiuVSibRRomTKDURGI+
         aapJ/e+vnUPevAva0DFuvF/Y0FfnPTQj1tIW2fXhJM0guqcfn7pQKPQNZbE67xpY8JgN
         fc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc:subject:date;
        bh=lThnaEK1769WrtOgHVr38+Ki+TeOtnijRB37FoJsgiQ=;
        b=2Ss2OvIe5LvPuXIFM0tAl1dGw2ursyxYZqTpnD9K5bECNey9At19G9nfKQ4vWPLYMp
         FLhr6J39J8lqCloarisy4rT0/3MAB7HY9h96rbc/HhgjZ9ypZi85ONDjCYasFCbBYPgH
         cSCeptolezayymiNEd5sWBw1f9RXcrbf+TuQ77TdNIzSNkM4rJTLAsFnkHboe5dvK5DH
         QtzDdc78p94Yziq/YFsxpgLBSuyC7UDKN5Xs8wh4N60febsHj6rtHA6rUChuBUTeJmPG
         f2M7Ff3jpxShWOFsOie6j34KlbovoY6z6eALIga6L8KGtkW30YQfuCDuEwOiVqafZez8
         cCFA==
X-Gm-Message-State: ACrzQf32jIY5VRi2v0yFKW2Pu4TxpzpUGhHoO+ea6VrVS5IfgHOssmYR
        mq8VlqO0BA4Y29OmhF2Ljok7gDItI5Io
X-Google-Smtp-Source: AMsMyM5ZHT/UiJn0DaiFNdz0t3HKuP2B/o/V4I7RcKOjai5RM1EJU7T9n2a3dzOzgecA6zb1ZcbtTQ==
X-Received: by 2002:ac8:5dd4:0:b0:35c:e24b:c185 with SMTP id e20-20020ac85dd4000000b0035ce24bc185mr10716569qtx.562.1664632073590;
        Sat, 01 Oct 2022 06:47:53 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id br12-20020a05622a1e0c00b0035bb732ac93sm4473597qtb.88.2022.10.01.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 06:47:53 -0700 (PDT)
Subject: [PATCH =v2] docs: update the README.md with a basic SELinux
 description
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Sat, 01 Oct 2022 09:47:52 -0400
Message-ID: <166463207266.6015.2704084637353753709.stgit@olly>
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
index 74b0a0c3..e820ac30 100644
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
+mailing list.  You can subscribe by sending "subscribe selinux" in the body of
+an email to <majordomo@vger.kernel.org>.  Archives of the mailing list are
+available at https://lore.kernel.org/selinux.
 
 Installation
 ------------

