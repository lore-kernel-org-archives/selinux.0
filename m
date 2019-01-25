Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1326EC282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1AD218A2
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 10:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfAYKHq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:07:46 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:50516 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfAYKHq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 05:07:46 -0500
Received: by mail-wm1-f49.google.com with SMTP id n190so6176635wmd.0
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 02:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7LnWD8CIm+vsez1GJWcnV1L73xue0rRlR70Oc8ikQI=;
        b=U+4LQo3/zNPh9tP/RV6tSlfBzo+qNwSUGDFs1ffuMa2/S0xgT4zJbnVAMdBQwoAnw9
         H1g9XO59YgfCwpcKVu3Tqwf/qdmflyttCC6/1068sqBtwS3nljM3x8NbjmfPi4WNay+k
         EUmwc/O0af/DrHCFcT+pHUOVNo/z51Xza7ysMazhmSoYwiGRCklZtPExzv+hJ0AFLd7A
         wJ7QA8mBQhmH+vNnuQtNLXS9O5FmbP7J1o69nSE5z4sX1SUtkzDVuv94J62ThPpgx/sE
         0Y6GPZeT4md+L9XmYEC2nD3XFjjbpoAw1Kiy8N952iAGhuKJ4me9g6jTAbtx0XIQW+hv
         eesw==
X-Gm-Message-State: AJcUukcvS6IjxIY43OLUDs8SIaXnwn+hgATTSQcehC3+Mm3suSq/8ghm
        xUUoEOu+5TIBVo/y2Rv7a8yzaPubJZE=
X-Google-Smtp-Source: ALg8bN7ifiJerLnKgXI264w56hzYpw/6ONdSloEoNP1Ht5nGvpCbCoN/xmcTDu44HiUlIHRuU2opyA==
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr6078190wmc.43.1548410864138;
        Fri, 25 Jan 2019 02:07:44 -0800 (PST)
Received: from p600.fit.wifi.vutbr.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id v6sm89155089wro.57.2019.01.25.02.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 02:07:43 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3 0/4] Report raw context in AVCs + refactoring
Date:   Fri, 25 Jan 2019 11:06:47 +0100
Message-Id: <20190125100651.21753-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Changes in v3:
- do some minor refactoring while there
- move new fields to the end of the record
- introduce a new security_sid_to_context_inval() function to get the raw
  context instead of (ab)using strcmp() to check if the raw context is
  different from the effective one

v2: https://lore.kernel.org/selinux/20190121153605.26847-1-omosnace@redhat.com/T/
Changes in v2:
- rename new fields to *rawcon

v1: https://lore.kernel.org/selinux/20190118100429.11703-1-omosnace@redhat.com/T/

Ondrej Mosnacek (4):
  selinux: inline some AVC functions used only once
  selinux: replace some BUG_ON()s with a WARN_ON()
  selinux: remove some useless BUG_ONs
  selinux: log invalid contexts in AVCs

 security/selinux/avc.c              | 159 +++++++++++++---------------
 security/selinux/include/security.h |   3 +
 security/selinux/ss/services.c      |  37 ++++++-
 3 files changed, 109 insertions(+), 90 deletions(-)

-- 
2.20.1

