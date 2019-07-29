Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E172C433FF
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D4920693
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 08:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfG2IlV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:41:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53887 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG2IlV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 04:41:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so53016864wmj.3
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 01:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9gq2u+A5dfODMGOeqg4bl/v73X/iz6hpcdQTucspmG8=;
        b=HpCyBjeopRZrlrPBZhuIEh5zHR4jVZg3+zhl2uXtMWyPxbO1OYS7V2Offuv2IIX4w7
         PvZWS/sk8m/WB+sPFXegm7ZydK0mlvptDcZ7oIhuYFfo8H2UDkQNOYuhMLuM+XuzmITP
         dnaCW7DLaiQDXG42ASGuXW+3gQHOZhScG75z4YMAxEkIQ7deNvyK7RB1wt2wmShQDPCQ
         IeEfUyeybdvap3Awsa9b56TsBZnhxYpAwty6wHgPsPuwtlH1rOhGWJsQN6coPhQtmq4w
         fuo5uSu4lYgJU5C5RrTzTbTy4w1pB5M51P6sEJD6UocNa5dhmfgFy4NXqR5OuCf9i3EE
         rE9w==
X-Gm-Message-State: APjAAAVj+kSWUJutR093fl1wsrXYJCVkciYek8fdiGY6sbGFILyaXN5B
        VaTghA0wD37yOkhrMRaMzFe+P79VFY2thA==
X-Google-Smtp-Source: APXvYqyVUuK8LOBj3DcKBUJGPJhkEAvCUCzUfdX+EpBjeB758pQMS73mhyqctji3fAwDwK7sMwH0zg==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr17148539wmj.71.1564389679787;
        Mon, 29 Jul 2019 01:41:19 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v5sm70190544wre.50.2019.07.29.01.41.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:41:19 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2 0/3] selinux: policydb - fix memory leak and do some cleanup
Date:   Mon, 29 Jul 2019 10:41:14 +0200
Message-Id: <20190729084117.18677-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Cahnges in v2:
 - move code around to avoid a forward declaration
 - add two patches to clean up checpatch.pl warnings detected in the
   moved code
v1: https://lore.kernel.org/selinux/20190725105243.28404-1-omosnace@redhat.com/T/

Ondrej Mosnacek (3):
  selinux: policydb - fix memory leak in policydb_init()
  selinux: policydb - fix some checkpatch.pl warnings
  selinux: policydb - rename type_val_to_struct_array

 security/selinux/ss/policydb.c | 980 +++++++++++++++++----------------
 security/selinux/ss/policydb.h |   2 +-
 security/selinux/ss/services.c |   6 +-
 3 files changed, 497 insertions(+), 491 deletions(-)

-- 
2.21.0

