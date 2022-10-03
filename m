Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E6EC433FE
	for <selinux@archiver.kernel.org>; Mon,  3 Oct 2022 13:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJCNrZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJCNrY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Oct 2022 09:47:24 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098CF2A973
        for <selinux@vger.kernel.org>; Mon,  3 Oct 2022 06:47:23 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id u28so6534984qku.2
        for <selinux@vger.kernel.org>; Mon, 03 Oct 2022 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc:subject:date;
        bh=Q0YfSO5TP03VDV6t9PiCPxDtnpuBKJbSPHFrPlSVtD0=;
        b=mRfE6UQxEEXwkqWchGHTJXha+OfG2WxxxLjutMG5jm1valRUb/PhEGQ1YSIN5hFPUx
         o/mWgn0pitEXmd1VzqoPfyoVghLbrw/btgzpG/zETF9D5uX7yQoTMOEwVZg+hPsxDzlK
         YGiOzL8ADooIo9ia/D8PDGmTUW63dAVrY9Cma7R3VZOgsRCSDX+KEAkOI1HRwHh6Capu
         f8Enec95bBGCiFu4gbB+1dUTcn/pQn8udX+aU3osqMs7adR4LEkUuu5SJhoDqNlxJVcI
         bUKOcQAxZnmWh+cByLdLHRpDx/IRzLlWhFKx7LGyhseUXBogWwZAEOWac/fjYfas45ha
         0+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc:subject:date;
        bh=Q0YfSO5TP03VDV6t9PiCPxDtnpuBKJbSPHFrPlSVtD0=;
        b=N1dhqzeXqhUuth3cWBD2DoHh85Vg4tlsIk9ZG5hmWjAaCT6sN6ysBWI/2XENOtsQjc
         4GLKh7/x/mdclzYXusNUtksc8cqIl7M64ROurSrfzNgx1QLPT3FkPhvlPc1X52uYoG3h
         azIsY/UCp5R1rtsr0+op0w+WWI5rYrpGiACI2d5pO+XTRlPo2WQHK9klwVAF9VIs6lJm
         nKufk4jigdYxLseKQyDYzLhQIbPKEjY+8HT0G9AlPVy1SwpQtrUA0X3Rzn1oHzP7XUoU
         TDT6Q26DYJjKbS5RybaVaHCCt1iPfg2SCUe9hOvte2Vp3EP3aYbOILgCW1dHkIyYJF9/
         ml0g==
X-Gm-Message-State: ACrzQf11brgV/lW4pPOEEbMD2BI3yJp4/uZJCUrIIRXjWSzPFfhm1s0u
        9zlex4aWFi0cZe16cJ906X+j5oY4w74G
X-Google-Smtp-Source: AMsMyM6durx8RWfOOAD8r4d+LLoKtWZ0m9OCORnDGEtF6oQjwGjBpyHLt+HpTDkoMOYpRHhPCq3UMQ==
X-Received: by 2002:a05:620a:211b:b0:6ce:13b8:c1c7 with SMTP id l27-20020a05620a211b00b006ce13b8c1c7mr13488309qkl.747.1664804841915;
        Mon, 03 Oct 2022 06:47:21 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id i68-20020a37b847000000b006bb49cfe147sm10865426qkf.84.2022.10.03.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:47:21 -0700 (PDT)
Subject: [PATCH v3] docs: update the README.md with a basic SELinux
 description
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Oct 2022 09:47:20 -0400
Message-ID: <166480484056.9276.9459961157065300430.stgit@olly>
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
index 74b0a0c3..f54e0555 100644
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
+and system libraries which allow for the configuration and management of an
+SELinux-based system.
+
+Please submit all bug reports and patches to the <selinux@vger.kernel.org>
+mailing list.  You can subscribe by sending "subscribe selinux" in the body of
+an email to <majordomo@vger.kernel.org>.  Archives of the mailing list are
+available at https://lore.kernel.org/selinux.
 
 Installation
 ------------

