Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B58C28CC3
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 01:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930DD2780A
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 01:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jw/d+jhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFBB5u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Jun 2019 21:57:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41425 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfFBB5u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Jun 2019 21:57:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id q17so8502189pfq.8
        for <selinux@vger.kernel.org>; Sat, 01 Jun 2019 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ep7WyKCrIhcucSMGIhPEnSqRa3dNEF0mFYRaQmVADgU=;
        b=jw/d+jhTG8bDfR+IPUGg4Rebgz9Do9K27iHD0a+egMMBrrAqmEpgwUrt++JgpwdEDE
         sEW67WC24B2E8kcH1GJBEUiDS5Y4xfqQfbQQHajJpSi/TyqDbUJO7VJxwAqtjjyf2dPK
         vFYX97B1ZGDMS60TFQCBhpbJNDPscjs5NFEvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ep7WyKCrIhcucSMGIhPEnSqRa3dNEF0mFYRaQmVADgU=;
        b=QoCCmnYCv6Vjv73XEcm2vZ+il5fND0YJEekUnBMtakgWqccqE+WgbsLqiN1paLj6pG
         5Uk0GD/QgkfXJy82e+nmdgUyrVAkvfyECbqEGbDklTJudCeyXTK2xV8j+Hm/f8Ths1fj
         85rI6rIos+QzpnRBtPnGMfy/6DLRyan7G01s2xlPBMXolS39YSoYoaZWeCSbpnpg+Fu0
         AJPcoaXYYFgN795rGWopLY5DUFTIci/eev0SXBv92K/cI2a0QNifEjeMjBnlAZwX+2WB
         boa/6+WfZauw60HRS6Q9oUpa4NPho/xDO0Ha8Bw1wk9BLjs4ILg/AoXiiL5JUPj9xzpu
         fRxQ==
X-Gm-Message-State: APjAAAVmqQgTTHWXk0BpHUFYmDB/WRsXjjKRXu15q4LT+hpGCr8u+V9l
        2x2Fm3SnJgv88UHgGX0wkz/pLQ==
X-Google-Smtp-Source: APXvYqwyv37wZZpw2F4g3IY4wzY64uo9+E0OCYVNM+IjrVUjpfdUvIihT8zsZN4lAsX4qC0rfvSy3w==
X-Received: by 2002:a17:90a:fa0d:: with SMTP id cm13mr21046650pjb.115.1559440669258;
        Sat, 01 Jun 2019 18:57:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f11sm17078374pjg.1.2019.06.01.18.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 18:57:48 -0700 (PDT)
Date:   Sat, 1 Jun 2019 18:57:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 05/58] LSM: Use lsm_export in the inode_getsecid hooks
Message-ID: <201906011845.96774A4@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-6-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-6-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 31, 2019 at 04:09:27PM -0700, Casey Schaufler wrote:
> Convert the inode_getsecid hooks to use the lsm_export
> structure instead of a u32 secid. There is some scaffolding
> involved that will be removed when security_inode_getsecid()
> is updated.

So, there are like 20 patches that all have basically identical subject
and changelog, but some evolve the API in subtle ways. For example,
in this patch, there is no mention of adding lsm_export_init(). I would
expect all the lsm_export infrastructure and support functions to be
introduced in patch 4 where struct lsm_export is initially introduced.
Instead, various helper functions are scattered through these patches
and I'm left struggling to figure out where things are actually
changing.

Also, I find the helper naming to be not easy to follow but this is
mainly due to me repeatedly trying to parse the helpers as
noun-verb-noun, so lsm_export_secid() kind of makes sense ("write to
secid, based on the flags") but then I see smack_export_secid() and this
is "write to the internal lsm_export storage, the value of this secid".
The direction here is what ends up confusing me. Which direction is the
data moving?

lsm_export_to_secid() <- from lsm_export to secid
smack_secid_to_lsm_export() <- from secid to smack's lsm_export record

> +static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
> +{
> +	l->selinux = secid;
> +	l->flags |= LSM_EXPORT_SELINUX;
> +}

Which brings me to another thing I find awkward here: I feel like an LSM
shouldn't need to do anything with this object: it should be opaque to
the LSM. The LSM infrastructure knows which LSM it has called into. Why
isn't this just like the other blobs?

Anyway, I'll keep reading maybe I just haven't gotten far enough, but
I'd love some help in the 0/NN cover letter describing what the
evolution actually does through the series so I can follow along and you
can set my expectations about what I'll be looking for in each patch.

-- 
Kees Cook
