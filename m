Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F69C433E1
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 17:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A28320657
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 17:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmPMU5wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389418AbgHQR2t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389330AbgHQRIS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 13:08:18 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0B1C061343
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 10:08:12 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id v11so6670749edr.13
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=+mx9UxHE8cqJm7GTmmUZEZc8F7xX2W2IqrfBBB9QOjA=;
        b=OmPMU5wRtJr+HOk95BLGxFsNz4Cn3KmNyYv+uJZ+XR/MdMjBb59LsNutLnfizNc3vY
         i4y5vMl2ZW3v4GtYM+f6YW2TNsLwkAG28WvG+fHwEkI5wwFSBoSyx2CYSTJq1BsNOZRP
         w/rIfsUFhj/RjkiSGfCnMOEenaZbyXoaR/72XgYoOYUA0nmxTgC/a6nAwVMDmsTdrWy8
         IapaImnbz2PzIHNUup3aCaZcrLoAzk5FwU3YHglWobL75Y/Q4Dc2l1BvE6I+oIenfoB+
         qY3mijGoVdpWQgd2BOL5+mbYkqU1ibOwbdc09vKwMajczltIvd61yViW6/iX6Oq06vfS
         5nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=+mx9UxHE8cqJm7GTmmUZEZc8F7xX2W2IqrfBBB9QOjA=;
        b=UV1vUwqke4gIlR49idQZI2KhDnscCIK1tFslpvrNkrOfBwOH4XDIvBc67k0QawnjON
         TVrgCy8T3OuDvhpnQCCOjVtK2BXITiAeBuQgrL2a5wj51EHmkoA1hESFSsXHX6D3jJsk
         J3JnFc64z5wMI0cAyNwV6tMI8lpUFRUTOkamU9Q6WtxmnLp6OaEaDih690mwO+8etKzP
         7oFYhXdqGUnujUS9a/988wz9qUQ+88b1N0MUNeSl9VR0h6gXkbvb2zkrX6Uz22bgvY9C
         26T7oIadQXYpP1/LLCab0Rru/Mjadar7+31VT1MHmMfrJfAauBd1gFcwGkSHBeFMk/rl
         VPBg==
X-Gm-Message-State: AOAM530Csr6TsNarqNYN5Mw9UxespwTwXWtgd8ppTaD2jNVtt1WZWATX
        XYvlIOn1t+eIIqB7mMfg+TAvyjv7yA==
X-Google-Smtp-Source: ABdhPJxjAsuqao+UCz19iDD3cRE1iqvUGgTUQRad5H4MDtyJjPX7rpcmAKVbSQMgky/6d8On1nKk8jFgug==
X-Received: by 2002:a05:6402:22d9:: with SMTP id dm25mr15617460edb.2.1597684089211;
 Mon, 17 Aug 2020 10:08:09 -0700 (PDT)
Date:   Mon, 17 Aug 2020 19:07:11 +0200
Message-Id: <20200817170729.2605279-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 0/3] selinux: add detailed tracepoint on audited events
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

Changes since v2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Add patch to include decoded permissions.
- Remove ssid and tsid from attributes list.
- Update commit log with more context.

Peter Enderborg (2):
  selinux: add basic filtering for audit trace events
  selinux: add permission names to trace event

Thi=C3=A9baud Weksteen (1):
  selinux: add tracepoint on denials

 MAINTAINERS                |  1 +
 include/trace/events/avc.h | 60 ++++++++++++++++++++++++++++++++++++++
 security/selinux/avc.c     | 59 ++++++++++++++++++++++++++++++++-----
 3 files changed, 113 insertions(+), 7 deletions(-)
 create mode 100644 include/trace/events/avc.h

--=20
2.28.0.220.ged08abb693-goog

