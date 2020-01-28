Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1877EC33CB2
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 15:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DA324688
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 15:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgA1P2C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:28:02 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:42348 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgA1P2C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 10:28:02 -0500
Received: by mail-io1-f70.google.com with SMTP id e7so8599093iog.9
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2020 07:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=kf/2DSY+al5mumI7h2ryUV9LTBu1iYUGw9WEv/U1Od0=;
        b=ss0Oqv7wNZtDTKid5y5hwX/P8UroaLyvB2DYdMHXVNW8H07JMYm7TiqnQ1KpXLydXW
         VI0vXRPGIKTPG6EyiHme39l17nmnQ8v2hvZNjJe3bAWLkE/w6qOKbmhhrpj/xl+foxie
         aZ0ORqDtW/FsZJNObUr/+8xFJpFRXnzzcozbB8+ezY9RP12q4oyC8LETZw4II6f9M7pa
         +yh+q5cogL8Wpvma1UgoNvrD/rb6ZMxubW/5o/VsXg45E3WKzWkOTGeyCoIH7eblxBTM
         kgaAQPB/CI5Cs7/S+iRfLTNLcXMSLAIy7/HnONenBB3xdQxdXc4ewAr7072tPnuhhDry
         oIgA==
X-Gm-Message-State: APjAAAU7u8czH0WJt/kuXofOQML9GozrJQM1nfZ07tsPxW0OzPeDtFLS
        +QMo5SFr8us0YD9A3GpFeWBR7tOH67Twq1Uf7Yz4eZDRE0P1
X-Google-Smtp-Source: APXvYqzy6PuA/euamEwBFqw/3xbkW5eZ7eJtHmPMU8+qYVEZwoaLB9/5JQSjUbtttEgIfBh11ag2qJBuLsLKwxJ0j/I3YKO5m9cE
MIME-Version: 1.0
X-Received: by 2002:a5d:9ad9:: with SMTP id x25mr15534203ion.253.1580225281799;
 Tue, 28 Jan 2020 07:28:01 -0800 (PST)
Date:   Tue, 28 Jan 2020 07:28:01 -0800
In-Reply-To: <000000000000143de7059d2ba3e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000963c75059d34ded7@google.com>
Subject: Re: possible deadlock in sidtab_sid2str_put
From:   syzbot <syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com>
To:     eparis@parisplace.org, jannh@google.com, jeffv@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        omosnace@redhat.com, paul@paul-moore.com, paulmck@kernel.org,
        sds@tycho.nsa.gov, selinux@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

syzbot has bisected this bug to:

commit d97bd23c2d7d866e99eb3a927c742715c85a90ef
Author: Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue Nov 26 13:57:00 2019 +0000

    selinux: cache the SID -> context string translation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fe5f69e00000
start commit:   b0be0eff Merge tag 'x86-pti-2020-01-28' of git://git.kerne..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10015f69e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17fe5f69e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9784e57c96a92f20
dashboard link: https://syzkaller.appspot.com/bug?extid=61cba5033e2072d61806
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10088e95e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fa605ee00000

Reported-by: syzbot+61cba5033e2072d61806@syzkaller.appspotmail.com
Fixes: d97bd23c2d7d ("selinux: cache the SID -> context string translation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
