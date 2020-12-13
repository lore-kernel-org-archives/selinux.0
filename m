Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6D6C2BB40
	for <selinux@archiver.kernel.org>; Sun, 13 Dec 2020 23:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF30522DFA
	for <selinux@archiver.kernel.org>; Sun, 13 Dec 2020 23:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405459AbgLMXBB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 13 Dec 2020 18:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbgLMXAy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 13 Dec 2020 18:00:54 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80631C0613D3
        for <selinux@vger.kernel.org>; Sun, 13 Dec 2020 15:00:14 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id u19so15253641edx.2
        for <selinux@vger.kernel.org>; Sun, 13 Dec 2020 15:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7XlCtFnQpWXdPLq8hdrC5r7fY/5pa4RVHpiXnxDixo=;
        b=phMwJHB9hrJuAPuoWHUETTAUr+ZXE5D8Ao7Ty3wpgc050dKNUUBoMKAXf1O7pY4AG2
         Xvk00py2QBa9gKDfoXui8tEcs2y9V79MuOSXo2ruf2ygLpdH+K/6J3L+CFCPs0Cd06zx
         LAdvXdZSbvPFKX0IuziZEm33XyeJTEhaVAT2EK+UaWO3UBeLYiHhD78GWArvt2zk4FoX
         l7qJQSQDN7srZVbqa+aqHAuVxDfPYDCfIRzSwdlyzoPLpEfHAqcRsAWKhVNvlKucQDeK
         JlCh88udcetwhUsaJi2ehJ6eQQFhsvVPgEAZCxNW+2ydC6oZD2RqcKbJKXkh/EFIFMKt
         3fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7XlCtFnQpWXdPLq8hdrC5r7fY/5pa4RVHpiXnxDixo=;
        b=IP4yU30ArXdGZnaHi5js/tpKJYd9Y/C2ZzyNaBHn/vlxFxWiyA4mMYSbXwqpwwMdIZ
         EoSzuI8oPoeuhVaeYpPaPrtqs2AHXnuFgWC+3IYU9zlIW8P3nVcn2Mf/27dl7cNCdcc1
         U4WK5PPVUL8Pgzo2i0ufUV9+nB1GMb+4lrTLV5s9C9isHC/2D+bcK27jQwpzkDinHRB9
         qvYLmFu8dsyyjJvSIm9lqHGCoer0l2gTrV4b1jhwl1SsFWBxBibWvfr0XqQDHzCoWpiA
         olMS/jD93GPL86VVfqbBCfAHoPX6i2lWipSrTDGGbrbBpcMOqZX7avgigC/A3L+eTDMj
         l2QQ==
X-Gm-Message-State: AOAM531F6tpIbMMeoHxNM84ZtmG4b6npnTC08Wu86ABDnN3CY1u0X6x1
        ME4IkORYNnmjyZZXqONp0T238YM2Q2t1RDY6kmehAPsygw==
X-Google-Smtp-Source: ABdhPJyT8YEFTOyPKj1YPFnMWE+J+xwjmaptRDMSvik5afJSTQCXwpVgWI9ImeHlYLjJ2Ma1kD7KLF+btWLmDE7O+p4=
X-Received: by 2002:aa7:d7d8:: with SMTP id e24mr21950323eds.135.1607900413041;
 Sun, 13 Dec 2020 15:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
 <20201212205522.GF2443@casper.infradead.org> <877dpln5uf.fsf@x220.int.ebiederm.org>
 <20201213162941.GG2443@casper.infradead.org>
In-Reply-To: <20201213162941.GG2443@casper.infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 13 Dec 2020 18:00:01 -0500
Message-ID: <CAHC9VhSytjTGPhaKFC7Cq1qotps7oyFjU7vN4oLYSxXrruTfAQ@mail.gmail.com>
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Dec 13, 2020 at 11:30 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Dec 13, 2020 at 08:22:32AM -0600, Eric W. Biederman wrote:
> > Matthew Wilcox <willy@infradead.org> writes:
> >
> > > On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
> > >> -void pid_update_inode(struct task_struct *task, struct inode *inode)
> > >> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
> > >> +                         unsigned int flags)
> > >
> > > I'm really nitpicking here, but this function only _updates_ the inode
> > > if flags says it should.  So I was thinking something like this
> > > (compile tested only).
> > >
> > > I'd really appreocate feedback from someone like Casey or Stephen on
> > > what they need for their security modules.
> >
> > Just so we don't have security module questions confusing things
> > can we please make this a 2 patch series?  With the first
> > patch removing security_task_to_inode?
> >
> > The justification for the removal is that all security_task_to_inode
> > appears to care about is the file type bits in inode->i_mode.  Something
> > that never changes.  Having this in a separate patch would make that
> > logical change easier to verify.
>
> I don't think that's right, which is why I keep asking Stephen & Casey
> for their thoughts.

The SELinux security_task_to_inode() implementation only cares about
inode->i_mode S_IFMT bits from the inode so that we can set the object
class correctly.  The inode's SELinux label is taken from the
associated task.

Casey would need to comment on Smack's needs.

> For example,
>
>  * Sets the smack pointer in the inode security blob
>  */
> static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
> {
>         struct inode_smack *isp = smack_inode(inode);
>         struct smack_known *skp = smk_of_task_struct(p);
>
>         isp->smk_inode = skp;
>         isp->smk_flags |= SMK_INODE_INSTANT;
> }
>
> That seems to do rather more than checking the file type bits.

-- 
paul moore
www.paul-moore.com
