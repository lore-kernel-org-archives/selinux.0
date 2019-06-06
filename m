Return-Path: <SRS0=xZUV=UF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1B6C04AB5
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 19:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3275220872
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 19:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NtsdxQmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfFFTLr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:11:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33081 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfFFTLr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jun 2019 15:11:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so1898195pgv.0
        for <selinux@vger.kernel.org>; Thu, 06 Jun 2019 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=38gGdRoJJh5s3XL5GqQH4QpahGYeo/J9ALAU4Xq5gsQ=;
        b=NtsdxQmpdlHUHDoM7ezeJJyCJ/EN01ialtZnizMUCACrot9iMvpaK+UQtg3SB7Gv6u
         rLcEGazRzihgJzWKhTOB3tMkxKFsucOLsvOUvcx79SNaDExFkn2Cb8j4VWFHKwZ8lCpz
         KzBu4eCwAMz/IlGAER9yLA/hBvDwYVxbLX5m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=38gGdRoJJh5s3XL5GqQH4QpahGYeo/J9ALAU4Xq5gsQ=;
        b=WgBSgEJcLNFgZJHbPwP0UzbsY6gU/5J3dpnwFA1zrfklsow6afolJ+vwI5xF8wRqgE
         CMnrvmMlDISCpTqjx0sLFpxUe3rpjUE6wW4OJget9Nup5d+KlaJ6NYZaCuv7TrGVKwnq
         wXGGulBvZ748KxoeVADkp5rEY99IQZHyKX9wEO6gqR2ddBBeoyQIicAWsJGB7kj88E7b
         QuqH5h9jkglbrq73krnoK39Asg33Lz1rSeklCGUyJl6yTmkhUNWxBLOaLGQ9Z48zizrx
         Nq7UC+P9rjNVV29rmu3FfZBzUKLzO5rDswde3ibWsfMCsNTShPf1zLJa7fFVByO9MRfy
         SQHg==
X-Gm-Message-State: APjAAAVtdZwqIU47pjhWMJW2haAJBLtRWsfGnVPQxPQ2FgM7e9hjZWFq
        BE9KAwVnGeHKi3YM1r45VsRS6Q==
X-Google-Smtp-Source: APXvYqyqcyBaI4c88/M86lczjphItrLGwoaGkPepujAbKlUA79L0wkiNPkvudTtBAuRyIv4BvSkimw==
X-Received: by 2002:a63:2ad2:: with SMTP id q201mr99011pgq.94.1559848306401;
        Thu, 06 Jun 2019 12:11:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d21sm2900892pfr.162.2019.06.06.12.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 12:11:45 -0700 (PDT)
Date:   Thu, 6 Jun 2019 12:11:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 05/58] LSM: Use lsm_export in the inode_getsecid hooks
Message-ID: <201906061141.77FE9A9@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-6-casey@schaufler-ca.com>
 <201906011845.96774A4@keescook>
 <46c5cbbb-b703-403f-96dd-d90f49d74e5e@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c5cbbb-b703-403f-96dd-d90f49d74e5e@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 03, 2019 at 05:29:45PM -0700, Casey Schaufler wrote:
> On 6/1/2019 6:57 PM, Kees Cook wrote:
> > On Fri, May 31, 2019 at 04:09:27PM -0700, Casey Schaufler wrote:
> >> Convert the inode_getsecid hooks to use the lsm_export
> >> structure instead of a u32 secid. There is some scaffolding
> >> involved that will be removed when security_inode_getsecid()
> >> is updated.
> > So, there are like 20 patches that all have basically identical subject
> > and changelog, but some evolve the API in subtle ways. For example,
> > in this patch, there is no mention of adding lsm_export_init(). I would
> > expect all the lsm_export infrastructure and support functions to be
> > introduced in patch 4 where struct lsm_export is initially introduced.
> 
> Fair enough. I didn't introduce helpers until they were used.
> I hoped to avoid the "what is this for?" question that can
> come up when you add functions that aren't used.

True, but since we know a giant set of changes is coming, I think it's
okay. As long there's kerndoc on the helpers, it should be clear what
they're for. And the commit log can include the context for why the
helpers exist. "In later patches, we'll replace secids with lsm_context,
so we need to use foo to do bar etc"

> > Instead, various helper functions are scattered through these patches
> > and I'm left struggling to figure out where things are actually
> > changing.
> 
> I think it's possible that the patches may be too small
> to contain enough context for them to be sensible. It may
> make things more obvious if I combined
> 
> [PATCH 05/58] LSM: Use lsm_export in the inode_getsecid hooks
> [PATCH 20/58] LSM: Use lsm_export in security_inode_getsecid
> 
> into a single patch. That would reduce the amount of scaffolding
> that has to get set up and torn down.

Yeah, that's fine. If you have to do a lot of work to split up a pair of
patches, I think that's fine to combine them. What I usually want to see
is a split of separable changes. Like, adding all the helpers: I can
look at those individually as I read the patch. Then the next patch
might swap a whole logical set of things like putting lsm_context into
the LSMs, but leaving all the interfaces alone. Then fixing the high
level things that use secids, etc.

But, really, the cover letter should cover the evolutionary steps the
series takes: that should serve as a guide for everything trying to
follow your thinking.

> The inconsistency is comes from my use of "lsm_export" for
> the name of the LSM data structure. This is something you've
> commented on elsewhere. The underscore makes the function name
> look like it has an lsm_ prefix, rather than just being the
> name of the structure. If I changed "struct lsm_export" to
> "struct lsmdata" the names:
> 
> lsm_lsmdata_to_secid() and smack_secid_to_lsmdata()
> would be more consistent.

Right. Having a distinct verb in the helper name should solve all my
confusion. :)

lsm_context_to_secid() secid_to_lsm_context() smack_secid_to_lsm_export()
etc

> > Which brings me to another thing I find awkward here: I feel like an LSM
> > shouldn't need to do anything with this object: it should be opaque to
> > the LSM. The LSM infrastructure knows which LSM it has called into. Why
> > isn't this just like the other blobs?
> 
> There's a lot more rework required if the lsm_export has to be
> life-cycle managed. The audit code, for example, passes them about,
> copying, storing and dropping them without a care. I'm not completely
> opposed to taking that on, but it's essentially a rewrite of the
> audit LSM handling. The SO_PEERSEC handling probably has issues as
> well. I think netlabel would be OK, but there's stuff going on elsewhere
> in the networking stack that isn't going to like anything it has to
> worry about allocating and/or freeing.

I didn't mean life-cycle managed, but rather "opaque" to LSM. I just now
tried to construct an example, and have decided it's too crazy. :) The
benefits of your current system are that they are trivially able to be
put on the stack since they're a fixed size. The down side is that each
LSM must manage its own flags, etc. I will ponder alternatives after I
see the next version of your series.

-- 
Kees Cook
