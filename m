Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4CDC4320E
	for <selinux@archiver.kernel.org>; Sat, 28 Aug 2021 02:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7AF60232
	for <selinux@archiver.kernel.org>; Sat, 28 Aug 2021 02:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhH1CMI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Aug 2021 22:12:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52028 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhH1CMI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Aug 2021 22:12:08 -0400
Received: by mail-io1-f72.google.com with SMTP id l4-20020a6bd104000000b005bb1bd35b3eso5137411iob.18
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 19:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=76HdtwbOVuUSM0zGrd3e0OmR58hv5g+WaLxPr1hL0E4=;
        b=VpLOosqN/5QYBAvlICGAaJroD3YQK8sU6bwXeQ/pjgjrkEbw2TDYyVBgLX0VCxqZHV
         rla42kfULTSvjfanaGW5CAZrMpGiVqZnmhIOGBfiJNO+yoLXKepHS6Ke0zX3Q3TRIU9p
         8D0orRWo2N2Qdwd8kmpYdN8N37+40hEeAKIjOrhAj67S75YPP32inggZvwWyYfRvI1TG
         fdSZGwUFOh9mIOhpPms6ZP/vfheqV994wK2vFggYkjwu1Qw9z7qFt/wk7k1cOrgGX8+M
         y3WZJ/fUpWNdNpXoP7CuWqFhlRx4DZywX8+hXxu9W2enWMD9IFdNTBRrwvz+1fAIHRrY
         o5Bw==
X-Gm-Message-State: AOAM5319CGaVmOBsReKweEyWVTgCPusiwl4N/3NGthUV73HlfHXvCm3K
        NIsMsL80twcgH+IhyCBKtXvdAs7rgXnB6DfEyOgMPMQj1q11
X-Google-Smtp-Source: ABdhPJwxHKu7FuMPwsV3/K93KbzrQVZacplDFFF1AqhALknBpGVJrTL9S9TggZdWzsPWSAJamrYeqbYL7FXnvQQ5smEHI6uIWlTf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9e:: with SMTP id h30mr8559944ila.195.1630116678280;
 Fri, 27 Aug 2021 19:11:18 -0700 (PDT)
Date:   Fri, 27 Aug 2021 19:11:18 -0700
In-Reply-To: <0000000000004e5ec705c6318557@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d2a0005ca951d94@google.com>
Subject: Re: [syzbot] general protection fault in legacy_parse_param
From:   syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        casey@schaufler-ca.com, christian.brauner@ubuntu.com,
        daniel@iogearbox.net, dhowells@redhat.com, dvyukov@google.com,
        jmorris@namei.org, kafai@fb.com, kpsingh@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        paul@paul-moore.com, selinux@vger.kernel.org,
        songliubraving@fb.com, stephen.smalley.work@gmail.com,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        viro@zeniv.linux.org.uk, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

syzbot has bisected this issue to:

commit 54261af473be4c5481f6196064445d2945f2bdab
Author: KP Singh <kpsingh@google.com>
Date:   Thu Apr 30 15:52:40 2020 +0000

    security: Fix the default value of fs_context_parse_param hook

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160c5d75300000
start commit:   77dd11439b86 Merge tag 'drm-fixes-2021-08-27' of git://ano..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=150c5d75300000
console output: https://syzkaller.appspot.com/x/log.txt?x=110c5d75300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2fd902af77ff1e56
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126d084d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16216eb1300000

Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
Fixes: 54261af473be ("security: Fix the default value of fs_context_parse_param hook")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
