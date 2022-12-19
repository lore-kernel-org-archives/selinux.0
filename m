Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B086EC4332F
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 17:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiLSRzk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 12:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSRzj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 12:55:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD5412748
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 09:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671472495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A9vuU5Z4D8BDai4R1MtulQviiaupoVVoxrdaniDuSmc=;
        b=aQxSb+01YqBYuFvh+3cEAZDtOgp59uKNyCPibQPJdo0ZFpu6LC0+0lj38iiJrUvwT4Rn1X
        uqYYQYS/+CJPjcLWNqPjnxXy+zW4MwdKLio2A4tEb8ujoWsmwc9a/esiz4UHZ316UcRrhb
        HKUzTmIDpxejSwjEu2qAeXbznIxoAuQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-147t_bBkMaeLJ8aotynIWQ-1; Mon, 19 Dec 2022 12:54:54 -0500
X-MC-Unique: 147t_bBkMaeLJ8aotynIWQ-1
Received: by mail-ej1-f71.google.com with SMTP id qw20-20020a1709066a1400b007c1727f7c55so6563461ejc.2
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 09:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9vuU5Z4D8BDai4R1MtulQviiaupoVVoxrdaniDuSmc=;
        b=E2zjAg7v8djeeSRXN4DRbi5Qtlmon9LkAaVpV/s5acWGumgdrcsH46XNWcBsym7ZsM
         758drxbixnDPB5zdwGffZiFmK/jM/JmwjsMwhqhZVZPfHu1tcLedpAhxSpAptJ/2/uv5
         rXNdgcuB2ipCW6uRW0//oj49dnZzUb3esk4XzUFaeIl1SnPwgF/t+WXP9afbiAU8JbaI
         JgEwYlAvC2BTwWI966McTq1eqGJL0HOEU+l0cHUz855IrjQKIOo/FV2mAbkyU5Z0plqp
         6DG5PBPofz5ILFDs1YkxYF0SsWHfmuHHBM0AmeRvPQVhXRrNC4xu9XyE3SdOut/vHPqs
         Vt2w==
X-Gm-Message-State: ANoB5pnNEU1+dbu8UPLyToembGGmKtWd9fsSvZ0XpT2DjiPFQQuXkB88
        +rjBh3Xo1qLEExa1TYHx3Vr9EFX95zeAG7YmpwOwAxt0uh8zrlZ5GgmzQteIVEfB+ATt917O8YV
        8hJiNE4tYwvvd6BBUvw==
X-Received: by 2002:a17:906:6d0:b0:7c1:33b2:6a02 with SMTP id v16-20020a17090606d000b007c133b26a02mr25072789ejb.30.1671472493086;
        Mon, 19 Dec 2022 09:54:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7QnSsvJl0qbchhgN7/T6EmdIMrXYMaGvctjJdaBF70LE3Z1Z3Ja+l487e1h6E1lUWBbvbMPg==
X-Received: by 2002:a17:906:6d0:b0:7c1:33b2:6a02 with SMTP id v16-20020a17090606d000b007c133b26a02mr25072780ejb.30.1671472492946;
        Mon, 19 Dec 2022 09:54:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id g4-20020a1709063b0400b007bdc2de90e6sm4604210ejf.42.2022.12.19.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 09:54:52 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Michal Sekletar <msekleta@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: [PATCH 0/2] Provide matching audit timestamp in the SELinux AVC trace event
Date:   Mon, 19 Dec 2022 18:54:47 +0100
Message-Id: <20221219175449.1657640-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series allows to match the SELinux AVC trace events to the
corresponding audit events via the audit event timestamp. This
will help with troubleshooting SELinux denials.

Ondrej Mosnacek (2):
  audit: introduce a struct to represent an audit timestamp
  selinux: provide matching audit timestamp in the AVC trace event

 include/linux/audit.h      | 13 +++++++++++++
 include/trace/events/avc.h | 25 +++++++++++++++++--------
 kernel/audit.c             | 23 +++++++++++++++--------
 kernel/audit.h             |  4 ++--
 kernel/auditsc.c           |  9 ++++-----
 security/selinux/avc.c     |  4 +++-
 6 files changed, 54 insertions(+), 24 deletions(-)

-- 
2.38.1

