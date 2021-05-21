Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD269C04FF3
	for <selinux@archiver.kernel.org>; Fri, 21 May 2021 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A951261164
	for <selinux@archiver.kernel.org>; Fri, 21 May 2021 20:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhEUUTs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 May 2021 16:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhEUUTr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 May 2021 16:19:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEABC0613CE
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 13:18:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb17so14187661ejc.8
        for <selinux@vger.kernel.org>; Fri, 21 May 2021 13:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HRq3a79BTOfjNk8E8ggTZT/+wBIRKwD0NpYc594HzrI=;
        b=UH99zw+vtI7dopQApmvoMsy3tQTx8crrO5RdqATQKJeGjj9X9HW4DJr6L/KgJhmb52
         EbOrdP18PpptzmqaEHEVLWqQhtg2ig/nDIcYozVDVoiohObZZKY2YB9gIDMb0e7q4k2h
         IyQ2rdNQeDvuIuqW3YsOBLk0SDrGifHMGI8nFYhawD6A9zoZrDJzuKUgo9StDPYvvOHn
         Wc3hBFqw6dMMK+mCL3rTZ8a91vq1n7VyeMMm3rb1q0C+d+WDIMRK4GgKT2KiSDlUh0oG
         yuLQrav2371H6hx0/zqlPYxLPg3J12q4NvDSVYEZDNY2gSA8spZfahSOykEClF02T37Y
         5fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HRq3a79BTOfjNk8E8ggTZT/+wBIRKwD0NpYc594HzrI=;
        b=Exn9LlK3vEltncQI5aEhIEEUVfKUdRtI4w6OPYWhNwz7TLIBYVR0bVV3+HCUoFjs74
         cq4YFwJ/8BbVg3OJhC4e5tkvgJBOfBWXOr75Z1FZrPcExi63cMdJ4AbT3XL48H1diMqs
         rvKSuO5w4FERzdC5xKtM7uWJWlqA7swZUJHbWe+Qre1TRWV4Wnpa5n5Xc0kb8Lda/x1D
         wZoUtbHWe4g8RcvvBs8OWU3NRhaoe9vTZzoPafBfM6hreM1sAMxTpqaX0sae5uC+BUKP
         tFAXRke0aD7Y+Gi6xq3HmhwJp1/hJnAtvIV9nur4wgTjSD8RxFqhOl15dX8pFGdDCTZt
         d/WA==
X-Gm-Message-State: AOAM533BUXWJDqFXzGICBG73X+X4gm9N7KM9qC2NmNOEDLhpDRktAi1a
        Bo9bii8toLAeAD2RtJ6zaXo1WatlTWbjezIwWDNk
X-Google-Smtp-Source: ABdhPJxLHNN51avk7YeEqYnny9tixz6B4/nVEaokiaEMktyaFuLHwTU/FmzSQ8cmk+6m7bv1Outbe1fzb6k8sZfbRLA=
X-Received: by 2002:a17:906:8389:: with SMTP id p9mr12291163ejx.106.1621628302546;
 Fri, 21 May 2021 13:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210513200807.15910-1-casey@schaufler-ca.com> <20210513200807.15910-8-casey@schaufler-ca.com>
In-Reply-To: <20210513200807.15910-8-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 16:18:11 -0400
Message-ID: <CAHC9VhR_eDyfUUH=0PyJ06R739yFJLgxGsi5i9My3PXaPEskNA@mail.gmail.com>
Subject: Re: [PATCH v26 07/25] LSM: Use lsmblob in security_secctx_to_secid
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 13, 2021 at 4:16 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change the security_secctx_to_secid interface to use a lsmblob
> structure in place of the single u32 secid in support of
> module stacking. Change its callers to do the same.
>
> The security module hook is unchanged, still passing back a secid.
> The infrastructure passes the correct entry from the lsmblob.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: netdev@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  include/linux/security.h          | 26 ++++++++++++++++++--
>  kernel/cred.c                     |  4 +---
>  net/netfilter/nft_meta.c          | 10 ++++----
>  net/netfilter/xt_SECMARK.c        |  7 +++++-
>  net/netlabel/netlabel_unlabeled.c | 23 +++++++++++-------
>  security/security.c               | 40 ++++++++++++++++++++++++++-----
>  6 files changed, 85 insertions(+), 25 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>


--
paul moore
www.paul-moore.com
