Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503FAC433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 14:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306E22224D
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 14:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lwC+gQdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgHUOI4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgHUOIz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 10:08:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E120C061573
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 07:08:55 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c191so1468992qkb.4
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=/nsE/W4nJ7wAzFSlbqSsmngFyg++wjvDvN8DWqY3F/4=;
        b=lwC+gQdgq8YdHvNsY/O5GtQ+byMersGQZmc0YaWo6WkauTKG+J+wffUG3Pa8BSZIcR
         wXTu7cf/GT8HPARuDWe4ojyYjB3zNnQuZKGCYiiDC08OcSDMElNag4sHTDD3dRirZySx
         tjVZ8uazzZJSmCasAZUz4JAzgohyNA0rHA3owl/yDx9TQRTgOrcgc+8Nv82mUAj4dHGb
         5o43vPgi44b8bFNYXtiTB0xDYgcuiFt1K96J5o0onZ284SF/MAfO4OHc1EF6r5aUhpZL
         IZV2r2pEfw80EevC5g2xIz1RcIMZXG3JiVutI6v+BKbCAdMimEZl2KOyN4nPhzHO9EPb
         1f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=/nsE/W4nJ7wAzFSlbqSsmngFyg++wjvDvN8DWqY3F/4=;
        b=QjK4PfGc7opGAoulEuGdTzCLM1RM6llpCPxKnI27Qvh2GbvfjtpWIJqZ8zsR47s/l1
         U5QAx/bVeSamYiAv5+Gpo7ZDhTE9VL85QTWUEo0uhgULsi0wHK3P9E5e905kqPKFZ2Qj
         pJf576DOPyZQ3ro9cgc5E8vwvMhzzsdiNfWqNehPA23Zj/b1TYa6TTYrs9ME/zt/eQr1
         azpl576yZvc1LWFz7y82fVJ4dJEzzErt8oUjD9w6bCcmUe2uGNtwo6OvvDRDgCkhB+vI
         bRSWqkqBXumR6/YYId2ZXTfv7/ujK6IkJREYkVedlXJmVhP2mIOp8cLCug77/zeeUX0A
         wxdA==
X-Gm-Message-State: AOAM533A4BbpvZgAqp69sDZDLItsm/vlUn+8OFX6hCoQDOdh4qFNJsyp
        F1srx6h984hVWEgsSSS7CitoelXzDA==
X-Google-Smtp-Source: ABdhPJxRkRhlJSydiiBr15eFhnIGnyD/G8li7QUKnO02K6mRrYQ4d24uAwzRWAEs2oOxHqfhboXJLrDDMQ==
X-Received: from tweek1.zrh.corp.google.com ([2a00:79e0:61:100:f693:9fff:fef4:a93d])
 (user=tweek job=sendgmr) by 2002:a0c:e90b:: with SMTP id a11mr2547816qvo.168.1598018931267;
 Fri, 21 Aug 2020 07:08:51 -0700 (PDT)
Date:   Fri, 21 Aug 2020 16:08:20 +0200
Message-Id: <20200821140836.3707282-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 0/2] selinux: add detailed tracepoint on audited events
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The audit data currently captures which process and which target
is responsible for a denial. There is no data on where exactly in the
process that call occurred. Debugging can be made easier by adding a
trace point when an event is audited.

This series of patch defines this new trace point and extra attributes
to easily match the tracepoint event with the audit event. It is also
possible to filter the events based on these attributes.

Changes since v3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Remove patch to include decoded permissions.
- Remove extra braces in patch 2.

Changes since v2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Add patch to include decoded permissions.
- Remove ssid and tsid from attributes list.
- Update commit log with more context.

Peter Enderborg (1):
  selinux: add basic filtering for audit trace events

Thi=C3=A9baud Weksteen (1):
  selinux: add tracepoint on audited events

 MAINTAINERS                |  1 +
 include/trace/events/avc.h | 53 ++++++++++++++++++++++++++++++++++++++
 security/selinux/avc.c     | 29 +++++++++++++--------
 3 files changed, 72 insertions(+), 11 deletions(-)
 create mode 100644 include/trace/events/avc.h

--=20
2.28.0.297.g1956fa8f8d-goog

