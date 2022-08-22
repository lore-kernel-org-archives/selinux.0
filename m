Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6499C28D13
	for <selinux@archiver.kernel.org>; Mon, 22 Aug 2022 17:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiHVRv5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiHVRv4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Aug 2022 13:51:56 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672B431DC6
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 10:51:53 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u14so13103187oie.2
        for <selinux@vger.kernel.org>; Mon, 22 Aug 2022 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=CNpe4ChRW88RPnpYtSaMK7KbNwpr92gM6kQvq121v28=;
        b=L5WhlDEP5DnA1UchedU8YRJOPr8Z8ERvhMIF+sSkfGlp8IoWdiVJ2l+0bTAkQ0vioh
         zegt2BjfwGWoJU8WLtA0A7pPmwFrVao+mhrhW26fUTj5ECsp5VwEhWNrK0+69/ZmFFGC
         MzI78MzVb0N0GpELHz8LO5Kr9DMVw68JTZda2Lpof01sFUDH2bkvOfmBEW2Ge1LdP3tB
         ul5NGvNE4qOqkP+1C7z58UmwmhtyK09gaSa9xiua8kmSoZB2+hhZlaQAxotVf3u0FcRA
         UqsbwaNXZ4eGA84QJVYhatPeL6swqqyTw2c7U29Y/iN/QK+pHoyBaACd/6TZAnE6ik0u
         cswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CNpe4ChRW88RPnpYtSaMK7KbNwpr92gM6kQvq121v28=;
        b=eXgNEmowHjsJpiEPlyoy/wvP5QzC+PCY5BpiDKlkCiKD6YiOuhKzvIJlGoc8fFG/Ca
         HW+amaQoDDwJe3wRUcfK14p6xHAueMIHc7knK2brxGiXF/bzRX2kxePhdkS6K1GzH/CC
         1oEAOEa9hTXYfX+fGLT1BzbmyhQ5Kbd+kGEHBKdXY4nA1BrmkKgPe5PRaMAr/qjDH+xE
         F7vuEm6l/LiF65J8DkwTpxJJgBVT6yh1BNVzyJzGmapzYC043wIYwHIkHRC67Uv+zSU7
         G3GZZDdx1wPvhotMY4JTrNAJQMeAZGc/o/KtQ048+aF1p7CifN+WBU2O3pj9E1VH/SXw
         xa+Q==
X-Gm-Message-State: ACgBeo0hgL4jS46tE/jFvZ33lkp4w1cZEDz7d+lizfsKoElejdYDimbD
        BCw6Y5eHL1XZWZuKYc2qUk5Bn7E4pQ6fEFOVncORlbXV45nl
X-Google-Smtp-Source: AA6agR4Dot4hjidZ4/XYp2XtPGAd9eM8KxbsttOz/LpzNADmZCyDJdaQP6HjbZE4eyQAvsoOdFtbcNMvB/Z9hLULu18=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr11787453oie.41.1661190712706; Mon, 22
 Aug 2022 10:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <359d1273-135c-33f1-940a-7ff570a4fda7.ref@schaufler-ca.com> <359d1273-135c-33f1-940a-7ff570a4fda7@schaufler-ca.com>
In-Reply-To: <359d1273-135c-33f1-940a-7ff570a4fda7@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Aug 2022 13:51:42 -0400
Message-ID: <CAHC9VhRtO78=N2acDrsMqXE-oSWGmPGRPqRRwH+CPZy2ZQ6gMA@mail.gmail.com>
Subject: Re: SELinux testsuite on 6.0-rc2 binder BUG
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 22, 2022 at 1:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> I see the following BUG reported when I run the SELinux test suite on
> 6.0-rc1 and 6.0-rc2. Is this a known issue? I'm running on Fedora 36
> under KVM. There's nothing fancy in my config, it's lightly tweaked
> generic with the test suite modifications applied. I've attached the
> config just in case.
>
>
> <4>[  471.300818] ------------[ cut here ]------------
> <2>[  471.300822] kernel BUG at include/linux/mmap_lock.h:156!
> <4>[  471.300842] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> <4>[  471.300850] CPU: 6 PID: 4666 Comm: service_provide Not tainted 6.0.0-rc2stack+ #1380
> <4>[  471.300856] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-1.fc36 04/01/2014
> <4>[  471.300860] RIP: 0010:find_vma+0x34/0x80
> <4>[  471.300869] Code: 48 83 ec 08 48 8b 47 78 48 85 c0 74 18 48 89 f3 e8 f1 85 fe ff 48 85 c0 74 12 48 83 c4 08 5b 5d c3 cc cc cc cc e8 e2 5b a4 00 <0f> 0b 48 8b 55 08 48 85 d2 75 15 eb e3 48 8d 42 e0 48 3b 5a e0 73
> <4>[  471.300875] RSP: 0018:ffffb5f041cefa18 EFLAGS: 00010292
> <4>[  471.300881] RAX: 000000000000033f RBX: ffff8fa55ce76810 RCX: 0000000000000000
> <4>[  471.300886] RDX: 0000000000000001 RSI: ffffffff9e68680f RDI: 00000000ffffffff
> <4>[  471.300889] RBP: ffff8fa64175f700 R08: 0000000000000000 R09: ffffb5f041cef798
> <4>[  471.300893] R10: 0000000000000003 R11: ffffffff9eb44b08 R12: 0000000000000008
> <4>[  471.300896] R13: 0000000000000000 R14: ffff8fa64bbc99a8 R15: 00007f61f5cc2000
> <4>[  471.300900] FS:  00007fa9a3afd800(0000) GS:ffff8fa6bbb80000(0000) knlGS:0000000000000000
> <4>[  471.300905] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  471.300909] CR2: 00007fa9a3c2eb50 CR3: 0000000059488004 CR4: 0000000000370ee0
> <4>[  471.300918] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> <4>[  471.300922] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> <4>[  471.300926] Call Trace:
> <4>[  471.300929]  <TASK>
> <4>[  471.300933]  binder_alloc_new_buf+0x4a/0x850
> <4>[  471.300947]  binder_transaction+0x553/0x3120

Yes, there is a problem in the binder code.  The good news is that a
fix has been identified and a patch is working its way upstream.  I've
tested a prior version of the linked patch below with good effect.
Unfortunately I was still seeing some XFS problems in the test suite
last time I ran it which I haven't yet had time to investigate, I'm
not sure if Ondrej is seeing something similar with the XFS portions
of the test suite.

https://lore.kernel.org/lkml/CAFqZXNuOvt_p0ZNjh89Vt9sGQ=CE5_GLr+XOT6OkzxcHdEHgKQ@mail.gmail.com/T/#m49642734166118c4666b0d5f84f4e9f96aeda12b

-- 
paul-moore.com
