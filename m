Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B87C433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6402071E
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBT3QkzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgHXPwa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26925 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbgHXPwY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 11:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598284343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nY4WAncEcTrbMZSUyLSIZD/YApYuNoFcgRDNbZMUPkc=;
        b=QBT3QkzSu8uOg4qqDAqsqQxYPG7MB6IByFzwrs0Z/UlZxBcM6ktALKth1ScuEjM6kMs6pz
        t0wmy1cGYQ1h6jTqO4KKODm9NE9ZjaySqNhWs9mg2HFxcl+yXli0Z94an+wiq/tB0ZX4xJ
        4HTPTksRH44jypjZkOc4Ui8Cvkdp3kE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-FM3ZGAnOMAeyHcC0bwnJkA-1; Mon, 24 Aug 2020 11:52:14 -0400
X-MC-Unique: FM3ZGAnOMAeyHcC0bwnJkA-1
Received: by mail-wr1-f70.google.com with SMTP id m7so4098055wrb.20
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 08:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nY4WAncEcTrbMZSUyLSIZD/YApYuNoFcgRDNbZMUPkc=;
        b=DHEO42Ez4WXqt9ZrRennjCzrpIaqRjTqU1hCbZzQ76Jnthy0noROi8uRfyujMv4O5A
         U6GB0mO/SYUDZuQjR7CZWnujN7/a9wCo25mTimld1x30HhUbsoBwJ0okPdgF32LJXbs/
         Bh2FRCxbYLS0u3sjGoMR+ee+Kj6zSDW3ugeiWg8Pgn9HCFQfPT0wXFdANZL9LPIcy2n0
         AsN8wks0vgBrB1ykkyIGQ46KlmymtKfaO8UIBqfiIRZRo83P5B4efS4+0I1HAPca1I9r
         +Q/7Xky3gV78PKHzm/vbvTR6rhKPZvnZhjfIcNSC9oju30y0Q1sorRZH50lpsFcV+ZFA
         eVLA==
X-Gm-Message-State: AOAM533ohHJXy4qpp0k0Z0/Pqbwka2Hc5zQbWCVPfgnPRaZEj1/olnX6
        KPc4NZFc0xhMu3t+avcU7DitxZzfo+JzHPFeioJOPEx9aTxz33vEvgbFSF9SR8zPUFFRWemZk/R
        uCS6b6/TM8C/7vnidZA==
X-Received: by 2002:a5d:4145:: with SMTP id c5mr6592719wrq.18.1598284333168;
        Mon, 24 Aug 2020 08:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy33SxKimsrBovM00jN1j0dAs0aC6PiPWoQcHv92DXJvKNBYRSupXKty2rUyUzK4XJtD3yTjA==
X-Received: by 2002:a5d:4145:: with SMTP id c5mr6592691wrq.18.1598284332849;
        Mon, 24 Aug 2020 08:52:12 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id x133sm25684215wmg.39.2020.08.24.08.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:52:12 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 0/2] selinux: Clean up GFP flag usage
Date:   Mon, 24 Aug 2020 17:52:08 +0200
Message-Id: <20200824155210.1481720-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series corrects a few places where GFP_ATOMIC was used instead of
GFP_KERNEL for no reason and removes the no longer needed GFP flag
argument from str_read().

Ondrej Mosnacek (2):
  selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
  selinux: drop the gfp_t argument from str_read()

 security/selinux/hooks.c       |  6 ++---
 security/selinux/ss/policydb.c | 42 +++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.26.2

