Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B943BC33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1642077C
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 12:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYg1+tfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgAPMEp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:04:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36013 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgAPMEp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 07:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579176284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DWMo51Hpjb7ultzomU9Bz2fLquEp+tKulUoY+Ysx28k=;
        b=TYg1+tfNh6BlZKRlisW0d4f9p/6GpVWmiAP6iH2UIhmzhVd18jKyB2Sz90tssO4yhhOpj6
        iw8jgXCRYAVxj810P/tNbjtaSvv3apYInuGKFj3Z9HgMtTn6ZHl8f2lY7ZgXtk9KIYZF/U
        ZIm/mc4q3su2u7+prZqfb3WBy8S5rGE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-P6jqR1mZPyC6PuU3DbWjsw-1; Thu, 16 Jan 2020 07:04:43 -0500
X-MC-Unique: P6jqR1mZPyC6PuU3DbWjsw-1
Received: by mail-wm1-f71.google.com with SMTP id t4so1126314wmf.2
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 04:04:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWMo51Hpjb7ultzomU9Bz2fLquEp+tKulUoY+Ysx28k=;
        b=Sj6WyAZNDzykEgZ3rS9SrR6QUcBKJHNzWDhHdDJzhqCVVe+/+Z52c0jyQGugwjqbT7
         qbdJ/7ZXAO76U67NOZS/qh7P8XIidbR5/T0E0HA+mIKiBKY4HHARS/ybZblfeqxjWl+K
         2VIJHoPMObHL+qakLmojSn0kv70AlDLJ7H1NIyYXsgIX2XsKI896nKvPDZcTkUGPeRPy
         /7Lj8qIyXec6AHr5t0y6JRtUMT6zxvEPFE9zD8TPzEoR0dt7xe3NleheKImnljOHYT5f
         b8YaC1QYv8UpYa1kMIcFizNiQpQKyjffbv4GejIBvUYUuGckSmSV4fP8CFBz5/sHiKgW
         UkZg==
X-Gm-Message-State: APjAAAVf/TONIUbug3LY98MikO/uzwyppcis5LagBvfJSLV6i82mMdD9
        r0DvSVUmZbmq6k7t3frnceEdyYk2KgiX0a5sc+GZ5U7upBS20B50KKlUHt/ZTVC6uEloB8ouEib
        7pPj2V6siPIYlasN7Bg==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr3068760wrx.288.1579176281769;
        Thu, 16 Jan 2020 04:04:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+uQrFpl8UQMvWoWFCTcmNfJBxko9fPefJeWoU+v2U/gnLzGQC379qjJDcAJ/ThobiEL+WJw==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr3068732wrx.288.1579176281514;
        Thu, 16 Jan 2020 04:04:41 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b67sm278117wmc.38.2020.01.16.04.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:04:40 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 0/6] selinux: Assorted simplifications and cleanups
Date:   Thu, 16 Jan 2020 13:04:33 +0100
Message-Id: <20200116120439.303034-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains some simplifications that I discovered while
working on another patch. I believe they also save some run time
(although not in any perf-critical paths) and some memory overhead.

The first patch is a cleanup in security_load_policy() that avoids a
pointless allocation during initial policy load. The rest are
cleanups/simplifications of the booleans-related code - mostly
converting linked lists to arrays.

Ondrej Mosnacek (6):
  selinux: do not allocate ancillary buffer on first load
  selinux: simplify security_preserve_bools()
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
 security/selinux/ss/services.c         |  95 ++++------
 7 files changed, 160 insertions(+), 229 deletions(-)

-- 
2.24.1

