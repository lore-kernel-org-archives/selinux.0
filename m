Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA82C433B4
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 03:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4716144A
	for <selinux@archiver.kernel.org>; Thu, 22 Apr 2021 03:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhDVDcD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Apr 2021 23:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhDVDcC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Apr 2021 23:32:02 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D740C06174A
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 20:31:28 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id bs7so20880421qvb.12
        for <selinux@vger.kernel.org>; Wed, 21 Apr 2021 20:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bhyON68KVnYW1Rh4D4HbOVrgbiCbbK6xrtgiZdimxq4=;
        b=wh8V7OMxF9fMUzTBqpWQHC0eSfSvsBAqo0uXInZXqjKz1gg8ui+MehX2aqvsbYE5ej
         f1L81ErnpNLqtVRCDGcTOH1UM0PgahXtdPYDKQ1U1i1Do0PJ0SgooN1tBnTYHEHhN8lr
         wnzMSAQb/vYqbMOc0RBMQChtddQ9wbpjX8yzuRVI1QX1i9Awvo+LF/Hu/HczuJy80Iq3
         Bl8SfqixsrHD21OsJ4x04AoycA4oOfFwkEXMuj9oONQc+W1g2JwVRS54m1p5fxXehAis
         WQDDdv5sBQt+Wuvfhjlo2WWf2kgG5AJubvjZlhKhrBS9GFWB21bflE7SMshGWdkkM3uK
         cKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=bhyON68KVnYW1Rh4D4HbOVrgbiCbbK6xrtgiZdimxq4=;
        b=gAxy+qyRIZlWlJXVMpDfB9KGH6YKEiPFQGlX0+cTFNk4YFaCaqP9VRY43Ia1bCaXiQ
         CVLUlZyKEiEJnRdoYhbpZb/UF8ugI28zoaa5LdH9NaB4M+AnfMwZ6d1WYVmKSRkyHjkc
         LTU49h4JacjP52kRtszLMi5nzV2umq5PX9c74ArYAPUgc2Sf91Qi2NBHmFqk1JFpgIX2
         s8+YQn5tOc/9sPKdBWkkUbifPRULzTF+t2bfgYgakUnCG8yzJcKH49fRHgIIQ+Evtlbx
         k5vql3XA1xZWYVf+As5njA/fKvp8xTuRISXM9u3C8lDM3JYNiH5HXMwKMgkF21vIB/RP
         v/Nw==
X-Gm-Message-State: AOAM533xgDc7OH4UW3rt7dvRkqYE0sPluBbGg4ucONF+Ug5v0E4wYOOU
        NP6/NJEMWKcHq3lbv+9MFc1kFKvWOp4N
X-Google-Smtp-Source: ABdhPJyBdPuZZaO9BdGkdexK5eLWdLmBsXeLPa3qYeOZ5snpBxDLQJZuBSd9vrnuo8ze0iPcOOozhg==
X-Received: by 2002:a0c:a404:: with SMTP id w4mr1176372qvw.45.1619062287013;
        Wed, 21 Apr 2021 20:31:27 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id y15sm1276995qkp.17.2021.04.21.20.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 20:31:26 -0700 (PDT)
Subject: [PATCH] selinux: add proper NULL termination to the secclass_map
 permissions
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Wed, 21 Apr 2021 23:31:24 -0400
Message-ID: <161906228493.81125.6079062739552342511.stgit@olly>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch adds the missing NULL termination to the "bpf" and
"perf_event" object class permission lists.

This missing NULL termination should really only affect the tools
under scripts/selinux, with the most important being genheaders.c,
although in practice this has not been an issue on any of my dev/test
systems.  If the problem were to manifest itself it would likely
result in bogus permissions added to the end of the object class;
thankfully with no access control checks using these bogus
permissions and no policies defining these permissions the impact
would likely be limited to some noise about undefined permissions
during policy load.

Cc: stable@vger.kernel.org
Fixes: ec27c3568a34 ("selinux: bpf: Add selinux check for eBPF syscall operations")
Fixes: da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/include/classmap.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index ba2e01a6955c..62d19bccf3de 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -242,11 +242,12 @@ struct security_class_mapping secclass_map[] = {
 	{ "infiniband_endport",
 	  { "manage_subnet", NULL } },
 	{ "bpf",
-	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
+	  { "map_create", "map_read", "map_write", "prog_load", "prog_run",
+	    NULL } },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "perf_event",
-	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
+	  { "open", "cpu", "kernel", "tracepoint", "read", "write", NULL } },
 	{ "lockdown",
 	  { "integrity", "confidentiality", NULL } },
 	{ "anon_inode",

