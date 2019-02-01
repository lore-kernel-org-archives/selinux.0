Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC87C282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 17:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5014321872
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 17:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM9+4gvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfBAR6e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:58:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40613 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbfBAR6e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 12:58:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so3269677pgp.7;
        Fri, 01 Feb 2019 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yuBq+p/+RIOzZlkxjHuTgou8HUguPZ2ENXLbgDkUCE=;
        b=gM9+4gvmij3S4ggChDo5gYBx/hmUZDCbJ3Vdw2M1+dz7sgVfHif1eXUuXQvFl3HNe8
         h2zLdT4oEMvo9G3lsorkQRbmIIhTQoI8svUKVFTBjZViIYwTTVQMH/jXqU4dRWcItnMs
         PABIVMR7kcnTv51E/yobTyKlZXOF6LcYdk63zSmAsrBLhUNbwPKAb9q0jPL4/TrKUOZR
         hFXphOlGJt+zFvE219ExT1QK+dKbGobbN9lbLufHDAc4QhCCexAMcizaVPEssS48eR+U
         B3Bg5XcN5gfWS7MqQzOI+aizLVr461iHE2ejxutkS1l3UHBBhJnPrE/GOHF+ihU/xE7M
         SWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yuBq+p/+RIOzZlkxjHuTgou8HUguPZ2ENXLbgDkUCE=;
        b=kvhc3iq9sWJk0COvf44eCp/juxgQSRT2G296qqeQquzuvFPcB5sjkj5Jj9yzfdWeJV
         9Qos2rmHC37J4bhpTcSM/HzR5gq6GyeXLlQzDDThV0AxLUXqHYUKzrMlPAOD+ROsRhVO
         z4im34mr0xVcTfBTlhA2L0Zt66pvbBVtEL42y687A3BZFXkDcH1+HZOmZVH19kIX5xKJ
         dFpr27Ph5Q9jsMzhVh5zlJh9yY0DVPyqaEYMb0VfbAmDH0iew/MItP4skcEzMuSRxeXA
         BvvkBZ2XCslinyUIQRDpvlkL+stB01Kxv51IITM5Fv8jtFBWYcpuc6/INlVvR3D/5+Jt
         tzjw==
X-Gm-Message-State: AJcUuke7a3rbvCrRJNyc08tP4R6Ed1hm/BQzEmPgGGMLJE8Qn8dd46H4
        MhJwdbiB7Aay4DWIecqvHtQmGk0qhiWq06xR+iWsYfLn
X-Google-Smtp-Source: ALg8bN6yASHOz9sZp7zjWPUG/er+KvYlzzK69PxUj6IKgqZQAo/fTdNeXndppya+S9dsntYn78Fn9+893+J++PK0S3E=
X-Received: by 2002:a62:c613:: with SMTP id m19mr40629116pfg.207.1549043913029;
 Fri, 01 Feb 2019 09:58:33 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003d28d10580b335cd@google.com> <CAHC9VhR9wwqVcnmAVcqfwmRuX02F8oMVzNNNQym-TeceHFLqOQ@mail.gmail.com>
 <CACT4Y+Yk=bsS7Ti3PjeZm8yG_txt=orBztowHwddHRP_MzuTxw@mail.gmail.com>
In-Reply-To: <CACT4Y+Yk=bsS7Ti3PjeZm8yG_txt=orBztowHwddHRP_MzuTxw@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 1 Feb 2019 09:58:21 -0800
Message-ID: <CAM_iQpV42EyuUFcxR7kn7WipkTAkvSxMc+-Me_QZCCUziy_wiQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in selinux_netlbl_socket_setsockopt
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Miller <davem@davemloft.net>,
        linux-hams <linux-hams@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzbot <syzbot+1bfc00ca3aabe5bcd4cb@syzkaller.appspotmail.com>,
        Eric Paris <eparis@parisplace.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 10:56 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> Hi Paul,
>
> Searching for af_netrom across other syzbot bugs:
> https://groups.google.com/forum/#!searchin/syzkaller-bugs/af_netrom%7Csort:date
>
> I see at least:
> https://syzkaller.appspot.com/bug?extid=b0b1952f5864b4009b09
> https://syzkaller.appspot.com/bug?extid=febf3c50d4262e578b1c
> https://syzkaller.appspot.com/bug?extid=defa700d16f1bd1b9a05
>
> Which suggests there are some serious lifetime problems in netrom
> sockets. That would probably explain this crash as well.

This is supposed to be fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=63346650c1a94a92be61a57416ac88c0a47c4327

Please let me know if it isn't.

Thanks.
