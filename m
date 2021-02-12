Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE66C433E0
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6BB64E99
	for <selinux@archiver.kernel.org>; Fri, 12 Feb 2021 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhBLTBG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:01:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhBLTBG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Feb 2021 14:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613156379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4L52yNn7kJE8H1ioaRj3H/UJqaqXCn9kXCMhoDFd4BE=;
        b=bX7PTXtHIPQ/EAiCajGzfwrI/lVK8U2o/rqyUq/EZeH36DGCuXOUYlz9j//46ZMYf+QsIj
        tosRMt35npQt279n5A6KOVRNmgI9rMgVANpFR2GCSzUf88v1butVna7xT2jhdx4KgmXk2Y
        lnfGuSgFE0/X6H/vlAQonpjdNnrE6H8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-wepePoOQPn-pQwzrNb7Hqg-1; Fri, 12 Feb 2021 13:59:37 -0500
X-MC-Unique: wepePoOQPn-pQwzrNb7Hqg-1
Received: by mail-ed1-f72.google.com with SMTP id a1so502993edt.8
        for <selinux@vger.kernel.org>; Fri, 12 Feb 2021 10:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4L52yNn7kJE8H1ioaRj3H/UJqaqXCn9kXCMhoDFd4BE=;
        b=dcVC0XxLOcr5q2Mgp1RLUKFgEfjBjohmneqhM11xn7Fg6rfjMkdRdL6bjsHSa4UwW6
         dfJcSganTSzv0Jzk9OCePG+yqOPxVOiaQyFRZIzkT486TbShN7RT5CYAyYOZmUPNbhMF
         CAHQK8CYS7MoX0FimzkSb6dx475tNUYMr2adyTu8yflk2YP63R9E1jYZvlq5JurqL9Gm
         YA7PcjG/uD9wtHLDdV/UlYIlD8UL1YpUrAGbt2Hr/EC1hsfv7eq2tY+a6p0d0mcrNT7T
         O5ADlEBwUJn6934vNUlzBYtTQJRSM/5YngVxiIZu/syKD5aBqfxB/sB9zQ1TEv/GJVj8
         6hCQ==
X-Gm-Message-State: AOAM532ghCL4IPshYypoOECW5idOleV6BkVygzW12xWr00Qbo1nH8688
        qvXmyUlyJgBC//F2+lfJwHW/s2f2Y2Dls+WPOFKB3PkhJs1iDOf6dzJEC8JFZ/flnxH++H97Gaz
        Bri6xjUrzB8IC4C+can4ZOlQ5k/6QePyDYogyF4eiMZlXWAZaCFzbs6Atg+0seYxzqzIZfw==
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr4732271edc.135.1613156375752;
        Fri, 12 Feb 2021 10:59:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXJrN5kvsjCNjlxUS7+ho6yd0JiKFkyatdc1pjIAknc6KVdUT7At6/UDhIIgpZom5wr5PKaQ==
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr4732255edc.135.1613156375533;
        Fri, 12 Feb 2021 10:59:35 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id u23sm6351128edt.87.2021.02.12.10.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 10:59:35 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 0/2] selinux: policy load fixes
Date:   Fri, 12 Feb 2021 19:59:28 +0100
Message-Id: <20210212185930.130477-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Changes in v2:
- switch to a more minimal fix which allocates the conversion params
  dynamically and passes them between the functions
- split out the MAC_POLICY_LOAD record fix into a separate patch

Ondrej Mosnacek (2):
  selinux: don't log MAC_POLICY_LOAD record on failed policy load
  selinux: fix variable scope issue in live sidtab conversion

 security/selinux/include/security.h | 15 ++++++---
 security/selinux/selinuxfs.c        | 13 ++++----
 security/selinux/ss/services.c      | 51 +++++++++++++++++++----------
 3 files changed, 50 insertions(+), 29 deletions(-)

-- 
2.29.2

