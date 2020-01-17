Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69294C33CB1
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 08:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A65F2072B
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 08:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0VXl6lU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgAQI6m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:58:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48629 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727531AbgAQI6m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 03:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579251521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jbzOvpeuyjW0OUajo1G7uCG1pCme7Gv8mTPW8J+7R/A=;
        b=U0VXl6lUYPSL2tVEUOAOxc8POLMm1sF5+tT2/DiVglEB+dNtlLsFd86w4kjrjO1bn12cwr
        8/FlxLBLg9JN2Bk7qJOs3SbsaG3XZbDddfYloz6/dM7k/xCMheQg27Dwn8cdHaU1W+1obn
        NVC29bRNZUBs4ek19ojTNNp+yYdx6ps=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-gj91dKZANiu2GPTeLiumbA-1; Fri, 17 Jan 2020 03:58:40 -0500
X-MC-Unique: gj91dKZANiu2GPTeLiumbA-1
Received: by mail-wm1-f71.google.com with SMTP id g26so996049wmk.6
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 00:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbzOvpeuyjW0OUajo1G7uCG1pCme7Gv8mTPW8J+7R/A=;
        b=lbMfNQmDOLS0I6FqfA4fRH4CpJt9Tm+nw1CtiqQuibYMh5dZcTMyRPvbn20DPpe4px
         UKzP2NJELjabWCR3jskaL+1cr3c8gA77jSKNzwU/MtyHZxIWJP62gIv4mBD7ic0763em
         VFKSFu+5MwAM0A+LpB8k1ohqnmFD0GgPIGvmQmVpVdk5CFSBVp06+Kgwok3p2t5HN1SI
         VpIHM/pv5tuwsUh4fgw6Cm3RKt0ObXakhH5HU8XHaNLBhdYDKU5j9CWWGjVIy9tQwQ12
         WWDcMYBw8YfJCI3RrZLBMSvg4C8ZRwTovFLQe9sq108G6YJPkS9CtrBYk4AhlFZixC5l
         nOrg==
X-Gm-Message-State: APjAAAVftwe4a8V3yIVbkh6ljvVS4iF8NGnE6opgwTK7tGMLVZ4txEXU
        hnIG0FdngxfZuYk31bVfj09VvJvmFmGlCdcfTi6YleLq2PMwGxv6RFV1EJSfGZ7LHfZyRqCTfxC
        WAo29ZISEYIxLk87dGg==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr3455770wmh.58.1579251519239;
        Fri, 17 Jan 2020 00:58:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRmOpjx3E14fbUX3N5MzitD+eNukeZvC6KMvkcIFw5sCFF5YK/R/NAyUGy6XyblUJgTyjf0Q==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr3455758wmh.58.1579251519042;
        Fri, 17 Jan 2020 00:58:39 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x18sm33391312wrr.75.2020.01.17.00.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 00:58:38 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2 0/5] selinux: Assorted simplifications and cleanups
Date:   Fri, 17 Jan 2020 09:58:31 +0100
Message-Id: <20200117085836.445797-1-omosnace@redhat.com>
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

 security/selinux/include/conditional.h |   6 +-
 security/selinux/selinuxfs.c           |   4 +-
 security/selinux/ss/conditional.c      | 252 ++++++++++---------------
 security/selinux/ss/conditional.h      |  27 +--
 security/selinux/ss/policydb.c         |   2 +-
 security/selinux/ss/policydb.h         |   3 +-
 security/selinux/ss/services.c         |  32 ++--
 7 files changed, 137 insertions(+), 189 deletions(-)

-- 
2.24.1

