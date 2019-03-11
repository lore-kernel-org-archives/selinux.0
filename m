Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F43BC4360F
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 20:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471612064A
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 20:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Q6EdJ1Ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCKULq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:11:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47064 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfCKULq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Mar 2019 16:11:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id g12so237800lfb.13
        for <selinux@vger.kernel.org>; Mon, 11 Mar 2019 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+vAI56/QPfquitg2TdtKRPja4MIyPOwjcpVSxrxyvQ=;
        b=Q6EdJ1Ikjyrf+T4Jra7B6IdBYcH2OZ8LBH/SpKRCsU8BgxD/lkvuKBAf04ra7Chrbo
         mbZoepSa592GMe3+IBkfr9EIuSB2+Nn7hbd8imsB0CkWSYXTnF4Ql1taCRaM3i/4QRji
         KB+bUOQcp4Y6XEC9DvWXWLshbEjV/cFZBtEwMQUtbQgbJSqLPWmpYK3W8gwBlpf2UKCt
         ShQReYONc7bTcjPbS4ROySD5PPboIxu/2JElwsZc6I73OkcPQWMnoFIxqLN/3wc6OujJ
         6SPJBc9V2+qa2SHFUFpU0jEi/+M233WM9oQj2tP9TZNusUGQouq0KTHyQFE798Ln6LBW
         UNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+vAI56/QPfquitg2TdtKRPja4MIyPOwjcpVSxrxyvQ=;
        b=Pn/EJ4rINj2NPa3Hr6X9g0W7R2yNbiI+bMXIjYBLoP+9NbI5ikqRhYZ/O4gPPnozKg
         mUORlU9DVfB0Ufdmww3MURrcnNXGNyWq3kZVqsKRiBkaMgsKaalXDtGdUInw2jFbqOF/
         pJdUQf3y4WPAAemMG/A/ULSmGUUxkiXYH0U9m8pg6p3A5z0mmtaJsDYi8TLfzmdBqkF4
         wqSpx1CLOGNX95LJ5OaaznksbKBu9vuELRE+3rSQ/f0I6xuyjH+JSOmr5QA5o/wcmtNO
         aMuEONdIFJ4qSPdOdzMktaaT3ezwBi2jKTtABr3csn/QkFLJ4gWkZLqOX1AT4KiP84+V
         3nVw==
X-Gm-Message-State: APjAAAX/ySjGDczLqwQzMOX9Wivee/9jaxAtGNnE6bx2eF4fGt6wWpdC
        x7JhQKrrpIWxcbGAZc2ljZgx5Z6bmNRXj8xt7HxB
X-Google-Smtp-Source: APXvYqzqYIm0l2bN2/5Re+cp3xH10SO+09wTW6HHs0bm6AnXPacTyJvm69mAqdCW4poRhVxBG2RSn3kbvH6AS+L29eU=
X-Received: by 2002:a19:7613:: with SMTP id c19mr4974766lff.105.1552335103880;
 Mon, 11 Mar 2019 13:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <1e5accb3a4a5575ada1dbdfc6e5d9e4358131f83.1552061254.git.lucien.xin@gmail.com>
 <20190308170838.GF13515@localhost.localdomain> <CAHC9VhSdkFORw88rusQ6Kzr3zFX9HB_GNkrbB2LViqOb1ozUzg@mail.gmail.com>
In-Reply-To: <CAHC9VhSdkFORw88rusQ6Kzr3zFX9HB_GNkrbB2LViqOb1ozUzg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Mar 2019 16:11:32 -0400
Message-ID: <CAHC9VhSy0X1Pz+C8UqpiU32obSMZoBASzoP543qbLLWGSxYEOA@mail.gmail.com>
Subject: Re: [PATCH net] selinux: add the missing walk_size + len check in selinux_sctp_bind_connect
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Cc:     selinux@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 8, 2019 at 9:47 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Mar 8, 2019 at 12:08 PM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> > On Sat, Mar 09, 2019 at 12:07:34AM +0800, Xin Long wrote:
> > > As does in __sctp_connect(), when checking addrs in a while loop, after
> > > get the addr len according to sa_family, it's necessary to do the check
> > > walk_size + af->sockaddr_len > addrs_size to make sure it won't access
> > > an out-of-bounds addr.
> > >
> > > The same thing is needed in selinux_sctp_bind_connect(), otherwise an
> > > out-of-bounds issue can be triggered:
> > >
> > >   [14548.772313] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x1aa/0x1f0
> > >   [14548.927083] Call Trace:
> > >   [14548.938072]  dump_stack+0x9a/0xe9
> > >   [14548.953015]  print_address_description+0x65/0x22e
> > >   [14548.996524]  kasan_report.cold.6+0x92/0x1a6
> > >   [14549.015335]  selinux_sctp_bind_connect+0x1aa/0x1f0
> > >   [14549.036947]  security_sctp_bind_connect+0x58/0x90
> > >   [14549.058142]  __sctp_setsockopt_connectx+0x5a/0x150 [sctp]
> > >   [14549.081650]  sctp_setsockopt.part.24+0x1322/0x3ce0 [sctp]
> > >
> > > Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> > > Reported-by: Chunyu Hu <chuhu@redhat.com>
> > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >
> > Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>
> Thanks, this patch looks good to me.
>
> > Paul, how can we get this into -stable trees? SELinux process may be
> > different from -net trees.
>
> For patches that warrant inclusion in -stable, I merge them into the
> current selinux/stable-X.Y and send it up to Linus once it passes some
> basic sanity tests.  Since we're still only half-way through the merge
> window, and this is an obvious bug fix, I think this qualifies as
> -stable material.
>
> I'm traveling at the moment with not-so-great connectivity, but I'll
> get this merged and verified early next week.

FYI, I just merged this into selinux/stable-5.1.  Assuming it tests
okay (and I can't imagine it would cause a regression), I'll send it
to Linus tomorrow.

-- 
paul moore
www.paul-moore.com
