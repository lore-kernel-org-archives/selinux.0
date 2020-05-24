Return-Path: <SRS0=Xk8N=7G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB68C433DF
	for <selinux@archiver.kernel.org>; Sun, 24 May 2020 18:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2732076C
	for <selinux@archiver.kernel.org>; Sun, 24 May 2020 18:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgEXSME (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 May 2020 14:12:04 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:43607 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgEXSME (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 May 2020 14:12:04 -0400
Received: by mail-il1-f199.google.com with SMTP id v14so13513954ilm.10
        for <selinux@vger.kernel.org>; Sun, 24 May 2020 11:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1e+UJBuT1k8k9TU3OPyghBUaf947khu0vC7FuIpxkqI=;
        b=E5fjM14Cr795rhZaEUssWkVMKBqcTzWWzERnhJdzxl+ViVV62tL5LCxkbiAWpdMJUC
         c5IHAHsBVV15N0bgNwYs2ExB4pLe0lMWmQ3TbQ1ybLmkjR2WKdZxNT3a7FyfmzINMhig
         NXFA39/0ixp2EqmC4eZ9v3D+cLuDEF8xbUETJfr1Gl6OMzjKgwqPR2Qy3ZJenI7Bk1xZ
         lWi3DXdicEf8J7LXle+rGwxyAssmQSV27lxGogImcW6iEtVrcRK9tCg0jf8RrIapefCF
         BepT27cRXQHJvnKloMsUnoRiWqbSyZNVvJCbtlFF6Y8YUyVSmvn3epdhCBR5i44BZCHE
         2+Fw==
X-Gm-Message-State: AOAM533FwNg3Cz2bMq1XIm6FGMv0lsjUrZynp0SA3mzR5GF1QrTLWgcq
        d6jlov8b9dvvHppp15fWj/0GCeIs+f0Mfem/2oh7wzdIkkqd
X-Google-Smtp-Source: ABdhPJwF9Bdk/vQYBRg4tVeymnZIBXmTz+Y935KEeBRmKqKCTHUUVdJXl+4iYgIDntbTkoRmisRFgeHNNKsHIPthaCS4+QtcZmr3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:5a2:: with SMTP id b2mr16907058jar.59.1590343923507;
 Sun, 24 May 2020 11:12:03 -0700 (PDT)
Date:   Sun, 24 May 2020 11:12:03 -0700
In-Reply-To: <00000000000054221d05a64b7ed8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1a76d05a668ccbb@google.com>
Subject: Re: general protection fault in selinux_socket_recvmsg
From:   syzbot <syzbot+c6bfc3db991edc918432@syzkaller.appspotmail.com>
To:     andriin@fb.com, anton@enomsg.org, ast@kernel.org,
        bpf@vger.kernel.org, ccross@android.com, daniel@iogearbox.net,
        davem@davemloft.net, dvyukov@google.com, edumazet@google.com,
        eparis@parisplace.org, john.fastabend@gmail.com, kafai@fb.com,
        keescook@chromium.org, kpsingh@chromium.org, kuba@kernel.org,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
        mptcp@lists.01.org, netdev@vger.kernel.org, omosnace@redhat.com,
        pabeni@redhat.com, paul@paul-moore.com,
        penguin-kernel@I-love.SAKURA.ne.jp, selinux@vger.kernel.org,
        songliubraving@fb.com, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, tony.luck@intel.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

syzbot has bisected this bug to:

commit 263e1201a2c324b60b15ecda5de9ebf1e7293e31
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Thu Apr 30 13:01:51 2020 +0000

    mptcp: consolidate synack processing.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12a5254a100000
start commit:   051143e1 Merge tag 'apparmor-pr-2020-05-21' of git://git.k..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11a5254a100000
console output: https://syzkaller.appspot.com/x/log.txt?x=16a5254a100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3368ce0cc5f5ace
dashboard link: https://syzkaller.appspot.com/bug?extid=c6bfc3db991edc918432
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13eeacba100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167163e6100000

Reported-by: syzbot+c6bfc3db991edc918432@syzkaller.appspotmail.com
Fixes: 263e1201a2c3 ("mptcp: consolidate synack processing.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
