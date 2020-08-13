Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C238C433E1
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 16:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B4F20829
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 16:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH3r5r8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHMQcC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHMQcC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 12:32:02 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF4C061757
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 09:32:02 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z22so5601925oid.1
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=u4Z/oChoG9/4VBHvPTSGu5SRNcsrLudvsmimHOw2Dms=;
        b=GH3r5r8vVZcy7bu+fyjFEZF7smG8xpNAk3hZSez826OgQveQf9/dAIP4oMbR5pwAVD
         sH2rfC3nTxR192d+I2f+NKBR6E7rD2IUi5lMAVGt649XTpZQ6Qf3Bn3xK1Pj6ONAKskR
         45oTihqfGyBDk+rjaNfA5ICJdR0oxFgFiH7jaN5ixOd1Aun8zoT2t9mHekVTv403DeZW
         8+lGr12jgHns4zjlzs8jTY3OZ7GWizCtwzHZndJxg39okqy65k9BTgaIsz/OjWn0TeoM
         DORyUcNOR5Uyrs5OpZG2D3LoxPSZZnUnuBxVbaGJ7mFKEOC9yZtxeg8ycwwDIq+LRJeN
         ItzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u4Z/oChoG9/4VBHvPTSGu5SRNcsrLudvsmimHOw2Dms=;
        b=T7JR2u5f5Psnj1SnyEfUeW2M37u+AgJ9Mib8Nb7kDQPd9CmY99AbqKKKRf64mtefEe
         ztBZNJ3GxkyHKl2ktfusqy7YS3aVlNi8THohTrSKNv/UPvXxmM73GmiJceIvcDkOKI6I
         ZefFLWHOOUFYxk1RanzqRTFVi8LfeY5ZFpJtrwsnLZ1nnaj+NYJumQUODf8yGGmSxeBC
         46aHbY09cBeS/HZxFzEBqa9yGO6chFEwU+ThTSxhxMXXxeq58OLXNy9bPclJj9/oArA0
         igi8JVkNqArDG9zWOizwK2Ebyh/ksc5WYLBUzXd5ANj1DFS+Cue0yn8gl5V3yVmVlUQk
         8xwg==
X-Gm-Message-State: AOAM532MG0/8Q1yOIbSqFqCcTXg5dpq5b1uuE71ISZ1/U5GtUxD5cOyy
        U40R0nXBIoi6de4E8sOwawG6RrI1tXnRDY/pB21LF+dlsM4=
X-Google-Smtp-Source: ABdhPJzLJt9kmPV9efG2sk03DQB4dYrOgcLD+BiPSwhLfRK+1wMalp+0SQIWeicrAhiYnjmDiL3zZfbUxvhLqe3ZjQ4=
X-Received: by 2002:aca:fd44:: with SMTP id b65mr3903687oii.160.1597336319403;
 Thu, 13 Aug 2020 09:31:59 -0700 (PDT)
MIME-Version: 1.0
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 13 Aug 2020 12:31:48 -0400
Message-ID: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
Subject: potential memory leak in netlbl_mgmt_add_common
To:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I noticed this in /sys/kernel/debug/kmemleak while testing other
patches.  This is on 5.8.0-rc1 but may be older.

unreferenced object 0xffff888158b40380 (size 32):
  comm "netlabelctl", pid 2982, jiffies 4295212079 (age 3234.561s)
  hex dump (first 32 bytes):
    80 03 b4 58 81 88 ff ff 80 03 b4 58 81 88 ff ff  ...X.......X....
    90 03 b4 58 81 88 ff ff 90 03 b4 58 81 88 ff ff  ...X.......X....
  backtrace:
    [<000000009fe161a4>] netlbl_mgmt_add_common+0x2df/0x9b0
    [<00000000816cc1d9>] netlbl_mgmt_adddef+0x133/0x190
    [<00000000f060e456>] genl_rcv_msg+0x2dd/0x490
    [<000000001c733400>] netlink_rcv_skb+0xd0/0x200
    [<00000000c42f6f58>] genl_rcv+0x24/0x40
    [<000000005421c040>] netlink_unicast+0x2b4/0x3e0
    [<00000000ab107bba>] netlink_sendmsg+0x3a6/0x660
    [<00000000643024bd>] sock_sendmsg+0x96/0xa0
    [<00000000ba78e5a6>] ____sys_sendmsg+0x404/0x440
    [<000000006f3de0f5>] ___sys_sendmsg+0xd8/0x140
    [<000000009b8c70ea>] __sys_sendmsg+0xa3/0x110
    [<00000000e65194c3>] do_syscall_64+0x52/0xb0
    [<00000000367aebc6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
