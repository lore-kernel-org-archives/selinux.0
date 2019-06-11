Return-Path: <SRS0=utbs=UK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE629C43218
	for <selinux@archiver.kernel.org>; Tue, 11 Jun 2019 03:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDCD20820
	for <selinux@archiver.kernel.org>; Tue, 11 Jun 2019 03:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY0W/W8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390936AbfFKDFi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jun 2019 23:05:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40446 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390791AbfFKDFh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jun 2019 23:05:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so3157991pfp.7;
        Mon, 10 Jun 2019 20:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UyJgv7diIvsGV8yNapWATBHWh5ErPBRaSoIXVIecPDQ=;
        b=GY0W/W8dLBHKkrHL2nfX4mjMoxYMJArz0NAt5yCD/WyI2puDS2djFJ2jCLOfYH/jD8
         niMueqxfkKwcE7BpKxOkYGhkvVs3JytYpjtPwMuNZWAGNT11GzNEXoE+3ird/ChA4+Gb
         pxu9tUmrxA1oETJAaluDL1qOFx0oVD0NTuw07YLPN40iCfDbPCFOhSlykJfvu4X5pO2g
         z6WHaxiWh42LbjwYsrpr07d+xq7fZ4+OI5Kp9lbAtB3CkGirK5WJuvXW6uEx3HWsPJwg
         l/wxqR9JNb4McHMv17tdEG9IdfEB7nFSTVW0UNCkHtvaxVeaCAi/h81kw36RAGB0JM6P
         rNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UyJgv7diIvsGV8yNapWATBHWh5ErPBRaSoIXVIecPDQ=;
        b=ADOqRM8xrH2SYpTiB9jo2NlsBQS/EvTlOPxLziHq//S1xFQ2xbYW3rppOzr3cSx0dP
         kxHMDTbl/ACw9aCo2bxaUeaZyyKAmSgS3d5r/9c4FufBrBFhC3K2bgJvo0pRSp5PphDS
         OHW+VrDsU2yGNhOvWZS6LOs6IqDtoXud0csr5Q96lx6d5SHgk51dDAHr/AsoWnDLMw2K
         SGMcH/2+19yS0WLMNTJsRhUKKNC2bwft4DOukd82w9KUl5WBMKngjE0iVpuOX+bIju6A
         pjc4coyNi1AHZ8Ua5c3+jZRn+tEtOm8/4+hvrNFbDaSZQyujJLGqD9Roxn5xiHqEqcL9
         pELw==
X-Gm-Message-State: APjAAAW57bCIeK2OI7T3o4MjRpc/7LkAa+P3ffDEYxOnGzzn2EV/R2yr
        p2ZGcKiIk4NKMcPYKpbQKfVyxPxeenl14w==
X-Google-Smtp-Source: APXvYqxB1TznsG2txR630wRTasQQMNG3n9JBoWYroGId67CZHYM1NNMiNqlwx8hwZ71MmwNtaT5TKw==
X-Received: by 2002:a17:90a:3a85:: with SMTP id b5mr8505271pjc.84.1560222337087;
        Mon, 10 Jun 2019 20:05:37 -0700 (PDT)
Received: from ubuntu ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id r4sm781677pjd.25.2019.06.10.20.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 20:05:36 -0700 (PDT)
Date:   Mon, 10 Jun 2019 20:05:31 -0700
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] selinux: lsm: fix a missing-check bug in
 selinux_sb_eat_lsm_o pts()
Message-ID: <20190611030529.GB4013@ubuntu>
References: <20190606085524.GA21119@zhanggen-UX430UQ>
 <CAFqZXNvM94T2reUsn6Mwuz6GNGNCR=wUNBE8w4tcjNuhJ6rCeQ@mail.gmail.com>
 <CAHC9VhT+e2Z+4=5P0g4B4F1g0w2SkQjwUnhQkmu5V+HvuZi8Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT+e2Z+4=5P0g4B4F1g0w2SkQjwUnhQkmu5V+HvuZi8Cg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 10, 2019 at 04:20:28PM -0400, Paul Moore wrote:
> On Fri, Jun 7, 2019 at 4:41 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Jun 6, 2019 at 10:55 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> > > In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> > > returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> > > should be freed when error.
> > >
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
> >
> > My comments about the subject and an empty line before label apply
> > here as well, but Paul can fix both easily when applying ...
> 
> Since we've been discussing general best practices for submitting
> patches in this thread (and the other related thread), I wanted to
> (re)clarify my thoughts around maintainers fixing patches when merging
> them upstream.
> 
> When in doubt, do not ever rely on the upstream maintainer fixing your
> patch while merging it, and if problems do arise during review, it is
> best to not ask the maintainer to fix them for you, but for you to fix
> them instead (you are the patch author after all!).  Similarly, making
> comments along the lines of "X can fix both easily when applying", is
> also a bad thing to say when reviewing patches.  It's the patch
> author's responsibility to fix the patch by address review comments,
> not the maintainer.  I'll typically let you know if you don't need to
> rework a patch(set).
> 
> That said, there are times when the maintainer will change the patch
> during merging, most of which are due to resolving merge
> conflicts/fuzz with changes already in the tree (that *is* the
> maintainer's responsibility).  Speaking for myself, sometimes I will
> also make some minor changes if the patch author is away, or
> unreliable, or if there is a hard deadline near and I'm worried that
> the updated patch might not be ready in time.  I'll also sometimes
> make the changes directly if the patch is holding up a larger, more
> important patch(set), but that is really rare.  I'm sure I've made
> changes for other reasons in the past, and I'm sure I'll make changes
> for other reasons in the future, but hopefully this will give you a
> better idea of how the process works :)
> 
> -- 
> paul moore
> www.paul-moore.com
Thanks for your comments. I will resend a patch after revising.

Thanks
Gen
