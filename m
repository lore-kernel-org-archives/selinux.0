Return-Path: <SRS0=B1VM=5E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F5FC4332B
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A812072D
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kP7vDO3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgCSTtL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:49:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42906 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSTtL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 15:49:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id t3so1490460plz.9
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2020 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0lvm8V3Nqb2qNRlTYmb14kUnylZqbItmMKRuK5xsTWg=;
        b=kP7vDO3IX++G2ynyj7KxxSdUuZ4wJW3B/gkK3NqbRaXg8RKZY9Mq3KkL3EQFe/UrfO
         UWdK24FVDX6GZO7N4+3Vx+Xd3+0Fo/y35e7uhEMtxqjVzTfPiPUxTTtmi1K3np9uona8
         u2XiMHLJeVdiTGrlNPXR2HiXfibY/tgoFS5buZbvkBvsqDJfcpyLxc/UVLcyP4029l0F
         CzEpOG+24qR+6QBYExOWhe4EzP29saRLw9oHGnDp0oVFUONf6gzYOKODwCxKQa8j3tTp
         kEIBu2Ns/oKVOUlI1bxM19AvIXWdFpkh+hIzm4RynTQx8k/aUHdyKRtISBhVW2QLWFvm
         ILyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0lvm8V3Nqb2qNRlTYmb14kUnylZqbItmMKRuK5xsTWg=;
        b=OUMHBXIFOyjGIOdJRa+/COWVthvCID7EcanyAKeAlWV1hI7VwhPmI/JIC7sUmLu6Cd
         dQaWOgkEicSWIT9FiIODjgWLXc1GxA4kCSb1LWv7eoYEy5EXxLH3k2hMu9hldZDnJH4E
         fp+QhIFedkEOpOXxfku6f8fseVKVYm17+6puKDgJVMfUFVbJ6YUB13Mk97dGhui3cOvC
         F1Ov/mr5bKb0hny7VqgL6E9DalInQ7B+4ZIWsNAFFTgfmdakKROSv8S1x6SWYfKT97mi
         o3NXRJk9P86i0BvZMzdoFTaazp7+LaYmIEUlBdIugfn2zQSPJ59cTQ5QICBV70Mfo5gR
         Eazg==
X-Gm-Message-State: ANhLgQ3Qpq22opclM6hl4/dV1UmFGazS+ViO0Ep2stpc6FmRnLGYi/7y
        NSYUo+o9pILNdWIjgBDCI4Q=
X-Google-Smtp-Source: ADFU+vuWY4DONOrAzRuoyFuqwjYRojUTiomI/CzXwzp4KSSCJgVLprbJ7Hk5mkvO8PnKxjzoTFfKSw==
X-Received: by 2002:a17:90a:9501:: with SMTP id t1mr5681693pjo.108.1584647350140;
        Thu, 19 Mar 2020 12:49:10 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id 64sm3322938pfd.48.2020.03.19.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 12:49:09 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] cil: drop remaining dso.h include
Date:   Thu, 19 Mar 2020 14:48:53 -0500
Message-Id: <20200319194853.15709-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFftDdqYnjyrXYRpUhaXere+jz-RXXWM9qPF5w1vzyi3SZOYKg@mail.gmail.com>
References: <CAFftDdqYnjyrXYRpUhaXere+jz-RXXWM9qPF5w1vzyi3SZOYKg@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/cil/src/cil.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index c010ca2aeaf4..12cc28eff389 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -50,7 +50,6 @@
 #include "cil_binary.h"
 #include "cil_policy.h"
 #include "cil_strpool.h"
-#include "dso.h"
 
 #ifndef DISABLE_SYMVER
 asm(".symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0");
-- 
2.17.1

