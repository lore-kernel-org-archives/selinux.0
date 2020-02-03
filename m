Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA41FC33CAC
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF082082E
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 11:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iH4LJWoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgBCL1c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:27:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727276AbgBCL1b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 06:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580729250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ROCgiw8Xe42BY3G/OMowxjG0qd0EE/gejt0UlUzNXnI=;
        b=iH4LJWoya8ShSb5JXuH8isGZYIRVcfXVsXsmACX6Y1j6QvAevjJwImEGwsQJt5+1dmHvDW
        W7WuGoPcQvlo56cRDqW2nTDIlX3cF82bbIsi7sa/5R8bmzee3pjFEu8X+GHTnvCC5cCLom
        Ke2F73fUDRVJeAAQVKnC02qYskGC+aM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-6uyBjtoROdGj1LEbIaZQhA-1; Mon, 03 Feb 2020 06:27:27 -0500
X-MC-Unique: 6uyBjtoROdGj1LEbIaZQhA-1
Received: by mail-wm1-f72.google.com with SMTP id p2so3902978wma.3
        for <selinux@vger.kernel.org>; Mon, 03 Feb 2020 03:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ROCgiw8Xe42BY3G/OMowxjG0qd0EE/gejt0UlUzNXnI=;
        b=R9edsJfrAxSWorMrwIc55TVv2mg5MUiM22qXap9ddRT/oNLHIaifvpFUrVdy7cEN62
         TugQMzFMSBo4ryJV9JgezqTHO+La5QSebtBdHDPsn/x+qdSzYgfYVhdULxj+ZJGxr8/v
         5N9HMbGDkdv/UICuXufTBxCUfl1jI+WzLl3A+xqMIMVNfm9k+sdG5QTy8XiFoKjqcfnq
         StCvguuDPlQdrC+LboikjUziWqjTWX9TItGe3PXMG8tUoB6dZBDff4rpnfs8v9HNrXq6
         rmI7VqnF2vQec/RPxbnsPlWI7Vcjp+lAMYhZHI/3Wl+y6O4fPolB/y1ghEQSdtWiL4ea
         ZJSQ==
X-Gm-Message-State: APjAAAUAJCjMRBb/YdmYAEUPt6y0j3C3vcHnT3Ll6wJrTeoxQ83MSOvT
        5yF7T0dgYxrFAjamI0/V8uUgadGw90nJ8AzMjGwMbrkuUx4s0Fo2WsTH9JE6/kThgCU7ET1ZWz3
        m3WH1LLj8n8kpHFsD3Q==
X-Received: by 2002:adf:f406:: with SMTP id g6mr3326550wro.189.1580729245684;
        Mon, 03 Feb 2020 03:27:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7RWFxCAK+Zp+NGkqga+D7zGmFzQD4UJsI8j3q6sakDRbIw0T+5D4YDgQ/yt3Bp85llbgYUg==
X-Received: by 2002:adf:f406:: with SMTP id g6mr3326523wro.189.1580729245476;
        Mon, 03 Feb 2020 03:27:25 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b16sm22597593wmj.39.2020.02.03.03.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 03:27:24 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3 0/5] selinux: Assorted simplifications and cleanups
Date:   Mon,  3 Feb 2020 12:27:18 +0100
Message-Id: <20200203112723.405341-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains some boolean code simplifications that I discovered
while working on another patch. I believe they also save some run time
(although not in any perf-critical paths) and some memory overhead.

Changes in v3:
 - properly destroy all cond nodes in error path (bug found by Paul)
 - additional style fixes suggested by Paul

Changes in v2:
 - drop already merged 1st patch
 - drop the rewrite of security_preserve_bools(), keep only the
   evaluate_cond_node() return type change (requested by Paul)

Ondrej Mosnacek (5):
  selinux: simplify evaluate_cond_node()
  selinux: convert cond_list to array
  selinux: convert cond_av_list to array
  selinux: convert cond_expr to array
  selinux: generalize evaluate_cond_node()

 security/selinux/include/conditional.h |   8 +-
 security/selinux/selinuxfs.c           |   4 +-
 security/selinux/ss/conditional.c      | 251 ++++++++++---------------
 security/selinux/ss/conditional.h      |  27 +--
 security/selinux/ss/policydb.c         |   2 +-
 security/selinux/ss/policydb.h         |   3 +-
 security/selinux/ss/services.c         |  32 ++--
 7 files changed, 137 insertions(+), 190 deletions(-)

-- 
2.24.1

