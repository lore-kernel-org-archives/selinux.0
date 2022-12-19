Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D050C10F1B
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 18:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiLSSBS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSSBQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 13:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7EE1261A
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 10:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671472829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FnAiHz6ljM7ODJu0/GD9MQOC3mm+47bLds2l/+g+s9s=;
        b=BlymvG73T2UJrnvqb0ak1fWXI/T3HLmqJFrpfUaCam2JRzuPBW8SFWycMEjWV8r4P3tbv/
        Q0hRPSphBJ3G1qEK5wIMIFEgR7hIu+DHw1X3QIxWrt08JZKmx0+wkGgsdzPgx0gYkeiny0
        SBXXpoECQQQ0T9/nT/bb//cDp7mOSXA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-Y8_mKFLkOaKogx7pnO34aw-1; Mon, 19 Dec 2022 13:00:28 -0500
X-MC-Unique: Y8_mKFLkOaKogx7pnO34aw-1
Received: by mail-ed1-f72.google.com with SMTP id h8-20020a056402280800b0046af59e0986so7193147ede.22
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 10:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnAiHz6ljM7ODJu0/GD9MQOC3mm+47bLds2l/+g+s9s=;
        b=3tbOw7xbFPuepIxExHgxYl5ukkRcBqA3odA248eBj/j+umQVHwriPnKIEysXUVUeWQ
         +axGXui2vJiA4uB8WpNKdR1amrBjaFxrtDSQngNakMrFay/Wbn22sdiYN2sw/gc6X8CL
         55SkA6NAdH6YU+SUP8/RnVNROt/EpxXuHFbgNXO8tlIwx2ajgTZ0ZmgkFE2kngQBGvBy
         25tChGXjUfr7n3kamwE7bLN2WGAAb5Dr/hGoGr/YPoZya9jbE9syl2QBq5GW8e0zFBgr
         kBWHjkl/aEQ9S9kdEoTpCI/kx6WefsSz8GoJeYCzKE+Ll0gmTCMEatRCcRlyRDrYf9lg
         /1bw==
X-Gm-Message-State: AFqh2krX8gGKvaTBE65/TB8PIQpy5pBT3ly/dWT3At6luBB4tWeTzYVl
        pB6lPHh9U8Rpx8KC1qSw6GssTAPG1ponkNZdwevjWSNREoXHsQt7RrxYoJpRW9KW9tOFbLAORZt
        8/A0732m1vm9Es9nioQ==
X-Received: by 2002:a05:6402:1f0d:b0:479:400a:d943 with SMTP id b13-20020a0564021f0d00b00479400ad943mr6176725edb.28.1671472827235;
        Mon, 19 Dec 2022 10:00:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvlBT/l+uXXqTk1XexJcN7ZXQbzHi34u/bh3Ff8AMn9P0qzZpjUeRRniCuAT6UP0aQe5u+iDA==
X-Received: by 2002:a05:6402:1f0d:b0:479:400a:d943 with SMTP id b13-20020a0564021f0d00b00479400ad943mr6176702edb.28.1671472826989;
        Mon, 19 Dec 2022 10:00:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id b10-20020a056402278a00b0046bb7503d9asm4617691ede.24.2022.12.19.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:00:26 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Michal Sekletar <msekleta@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: [PATCH RESEND 0/2] Provide matching audit timestamp in the SELinux AVC trace event
Date:   Mon, 19 Dec 2022 19:00:22 +0100
Message-Id: <20221219180024.1659268-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

(Resending due to an error on the first attempt.)

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

