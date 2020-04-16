Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5364EC2BA19
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 01:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5B020656
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 01:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BTXyF+aG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgDPBlO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgDPBlL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Apr 2020 21:41:11 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F05C061A0C
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 18:41:10 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a43so7365569edf.6
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2020 18:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aC3Bl8fkq/OLg0t8udOsYncGaRH4GYHuUy+ICl6YKe0=;
        b=BTXyF+aGjLVgCv7m3MD4NF6TSE12h3+jFgr192gvnYcij5k8swfKMj59JXaGQ0fjT7
         770W1V+Z7DiCMvByg2yQd3lyPRbO6PPt39kJwgmgTkL7WyyDn+2WBPmMkMvxpaFzZFIB
         7kh73gMvWRgzsevyRMyEHoEsCkImV/dnFE7ngSaFfXev6Zg73FuUPtqtxgSutFjKjKr/
         uoXN4ygp7U5aUhHyoQhAvJwqvcMpihTgK933Xf2PGk34dE5gRN7+qNKgXpK2zMVa28xk
         c3u4ZQ88UJM1jFQC9lgScwArDyWQKHx+3EtuV7W2aROA8SRRoF83GL0nEttGPxE30Gpp
         Dwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aC3Bl8fkq/OLg0t8udOsYncGaRH4GYHuUy+ICl6YKe0=;
        b=skGASxnIADw2eOfxw+YttT32KYqQbgzFrWV0fjoSiweE6QlMQ8gYKDXzrXw0FH4G6J
         pxGLlYj9fM5dd6AIpFe+XzKIhUe0as+rBR4h3dGO7jk6bLtfLhSfS+qE3UuVGUTKUsOC
         WJiDtwB1QZxf80NUpCKw5vOcV4cvgFSyQXYREkmhD209tECP2xti1rXaDxm1UTgF9Wxu
         7PWxI792SC19wUtd5/hDcOtxa5jzhwrSWYrtWYwqcPWsP4+N7zXhnMvEhO0sA1Z96qBQ
         k9crIkugVPNg9Xr2HRpY7OIBCaOvl9cLzDJbaq6PI6Yv+zWe+hYoZQVLFglRbM3TqEzR
         kpjg==
X-Gm-Message-State: AGi0PuaMMszQuhl0QX+IoOxchXSa2k0cYo2y79kkMdn6XhEGBS+THFbL
        G9OgcAFCWOwlbLhDVCDlw8ZfilAKsD/BYBqjZNtIsJY=
X-Google-Smtp-Source: APiQypLcN+XQrAdmaoOGvqJ2GO17gcqk43tgdj31L8/j/5/gOBB7nrTMVjBbX2o3A+kh0YnBBpVgt0S5w3YMBdBIFyA=
X-Received: by 2002:aa7:cb0f:: with SMTP id s15mr1197738edt.164.1587001268572;
 Wed, 15 Apr 2020 18:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200407182858.1149087-1-omosnace@redhat.com>
In-Reply-To: <20200407182858.1149087-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Apr 2020 21:40:57 -0400
Message-ID: <CAHC9VhQu0B8KwBLP+qD9JvtyFJS-X3ANThp8EytG4R0scyzoCA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: store role transitions in a hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 7, 2020 at 2:29 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Currently, they are stored in a linked list, which adds significant
> overhead to security_transition_sid(). On Fedora, with 428 role
> transitions in policy, converting this list to a hash table cuts down
> its run time by about 50%. This was measured by running 'stress-ng --msg
> 1 --msg-ops 100000' under perf with and without this patch.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2:
>  - fix typo scontext->tcontext in security_compute_sid()
>  - suggest a better command for testing in the commit msg
>
>  security/selinux/ss/policydb.c | 138 ++++++++++++++++++++++-----------
>  security/selinux/ss/policydb.h |   8 +-
>  security/selinux/ss/services.c |  21 +++--
>  3 files changed, 107 insertions(+), 60 deletions(-)

...

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 70ecdc78efbd..4f0cfffd008d 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -458,6 +465,30 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
>         return v;
>  }
>
> +static u32 role_trans_hash(struct hashtab *h, const void *k)
> +{
> +       const struct role_trans_key *key = k;
> +
> +       return (key->role + (key->type << 3) + (key->tclass << 5)) &
> +               (h->size - 1);
> +}
> +
> +static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
> +{
> +       const struct role_trans_key *key1 = k1, *key2 = k2;
> +       int v;
> +
> +       v = key1->role - key2->role;
> +       if (v)
> +               return v;
> +
> +       v = key1->type - key2->type;
> +       if (v)
> +               return v;
> +
> +       return key1->tclass - key2->tclass;

Why just a simple boolean statement?

  return key1->role != key2->role || \
         key1->type != key2->type || \
         key1->tclass != key2->tclass;

-- 
paul moore
www.paul-moore.com
