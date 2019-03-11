Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A61C43381
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 23:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46C6214AF
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 23:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A19rHr5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfCKXtr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:49:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34245 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfCKXtr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Mar 2019 19:49:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id x20so667173qto.1;
        Mon, 11 Mar 2019 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XRjjjnPmsGObz555HOZd9fZnWPz0VJv5I6ntNN2IRzo=;
        b=A19rHr5X0FbMCl1jJXdoaDYmhr3SsgxN1cZ2roTOQHVF80DoGhuWQ7u59+yrUtpq6G
         t9z7fozGBJGHrA/AFy6L55fYr9wmanLH/phJyNF9a3g49kZLYxzEJxdaziOXxBhdSOEa
         w54Jg1akMq7WOClwt+kb9lLCtQEv0+RHu0uDnxY78jUNWIX73+bL5ulaVckgbpJ931kM
         RYHQmolxeX74CI4hg60rsZZSara1ME3PApueueUicm+9ounPRpWkS1u0jyuR4ezE0Vfs
         aK4/no96sW2fH7DV5aFyOS/M7ja/np7TSWU348LmoVhBw8hXPD6w+yUnD1ZqI2GPL+Wx
         rCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XRjjjnPmsGObz555HOZd9fZnWPz0VJv5I6ntNN2IRzo=;
        b=tkkPX39pBPfYYSf+MuPCKFYDIDuOsHm6TX2pLLqqh6aqEL1Ts5e9STMjSXn+AsUUXU
         1zx7Zn+79xSGxYMUIc3IkD8+3dc+dvwfKVeZAHD66HQ2Vgf4ugngDunqNb9VPBCkpf7d
         p9zi+Rf2/2UjufSn4WcvKjvN6/S4TRRbDBPYfMrc3jyjRU3dGg1YERg0wikmrzLKVkW/
         rjAfytqXXS/3vVDfqIEbkpjwo7dGaHbqcYbKOIFAoRkwiLdF7mEo/GHwb6qP0hC87VjP
         KYAxsV7NUvdCIXBEqy+wRcRXyCldhGA/a0KqCwVXSV0H5f4rOmLR7HGzN1LD2dxJrp4t
         AnKA==
X-Gm-Message-State: APjAAAUT0BY3R9UO+gP6V2H8Z+j/ELO6TWHRT/RldMtX0846GuJbZjSj
        +++KGod0jEcD1eKit6c9MGY=
X-Google-Smtp-Source: APXvYqwr/3kp3gpwrztZ4gZMxqPhgl/dw4JogsXXqC2BQuHqmyD0s+JzgADZ2sJT898tqBN6kGEN1A==
X-Received: by 2002:a0c:be8f:: with SMTP id n15mr6800696qvi.203.1552348185434;
        Mon, 11 Mar 2019 16:49:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f016:48d4:6842:cfac:4a10:314f])
        by smtp.gmail.com with ESMTPSA id r68sm3850149qkd.68.2019.03.11.16.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 16:49:44 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 3A461180B5B; Mon, 11 Mar 2019 20:49:42 -0300 (-03)
Date:   Mon, 11 Mar 2019 20:49:42 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Xin Long <lucien.xin@gmail.com>, selinux@vger.kernel.org,
        network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH net] selinux: add the missing walk_size + len check in
 selinux_sctp_bind_connect
Message-ID: <20190311234942.GG13515@localhost.localdomain>
References: <1e5accb3a4a5575ada1dbdfc6e5d9e4358131f83.1552061254.git.lucien.xin@gmail.com>
 <20190308170838.GF13515@localhost.localdomain>
 <CAHC9VhSdkFORw88rusQ6Kzr3zFX9HB_GNkrbB2LViqOb1ozUzg@mail.gmail.com>
 <CAHC9VhSy0X1Pz+C8UqpiU32obSMZoBASzoP543qbLLWGSxYEOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSy0X1Pz+C8UqpiU32obSMZoBASzoP543qbLLWGSxYEOA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 11, 2019 at 04:11:32PM -0400, Paul Moore wrote:
> On Fri, Mar 8, 2019 at 9:47 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Mar 8, 2019 at 12:08 PM Marcelo Ricardo Leitner
> > <marcelo.leitner@gmail.com> wrote:
> > > On Sat, Mar 09, 2019 at 12:07:34AM +0800, Xin Long wrote:
> > > > As does in __sctp_connect(), when checking addrs in a while loop, after
> > > > get the addr len according to sa_family, it's necessary to do the check
> > > > walk_size + af->sockaddr_len > addrs_size to make sure it won't access
> > > > an out-of-bounds addr.
> > > >
> > > > The same thing is needed in selinux_sctp_bind_connect(), otherwise an
> > > > out-of-bounds issue can be triggered:
> > > >
> > > >   [14548.772313] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x1aa/0x1f0
> > > >   [14548.927083] Call Trace:
> > > >   [14548.938072]  dump_stack+0x9a/0xe9
> > > >   [14548.953015]  print_address_description+0x65/0x22e
> > > >   [14548.996524]  kasan_report.cold.6+0x92/0x1a6
> > > >   [14549.015335]  selinux_sctp_bind_connect+0x1aa/0x1f0
> > > >   [14549.036947]  security_sctp_bind_connect+0x58/0x90
> > > >   [14549.058142]  __sctp_setsockopt_connectx+0x5a/0x150 [sctp]
> > > >   [14549.081650]  sctp_setsockopt.part.24+0x1322/0x3ce0 [sctp]
> > > >
> > > > Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> > > > Reported-by: Chunyu Hu <chuhu@redhat.com>
> > > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > >
> > > Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> >
> > Thanks, this patch looks good to me.
> >
> > > Paul, how can we get this into -stable trees? SELinux process may be
> > > different from -net trees.
> >
> > For patches that warrant inclusion in -stable, I merge them into the
> > current selinux/stable-X.Y and send it up to Linus once it passes some
> > basic sanity tests.  Since we're still only half-way through the merge
> > window, and this is an obvious bug fix, I think this qualifies as
> > -stable material.
> >
> > I'm traveling at the moment with not-so-great connectivity, but I'll
> > get this merged and verified early next week.
> 
> FYI, I just merged this into selinux/stable-5.1.  Assuming it tests
> okay (and I can't imagine it would cause a regression), I'll send it
> to Linus tomorrow.

Thanks Paul.

  Marcelo
