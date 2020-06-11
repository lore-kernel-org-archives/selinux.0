Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9ADC433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 02:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4402074B
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 02:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="v8+6EYja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgFKCNa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKCN3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 22:13:29 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4973C08C5C2
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 19:13:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so4826268eju.2
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSclIs7n5vpOSvxh2OrnHeX+5b5kOfOtKGtkOgLl0/Y=;
        b=v8+6EYjaTY6Fw2wnUUu6UJNua3V+Lp53KEHLNac2TEyYj9A2BadRkPLnSl/9YGGSyY
         T+OtnVMqO3xg/6L/4Nz08Mjb8nZo6NBSLdJSDqdfsJfSBLSCJh8KebIiyYCwV/s5cM9p
         N4Xs60MSyKAQ/KYjoC7hCG5yphEFesouJle1fShaDIcorlZn0iBB3bbrrytdHDbAELFC
         UYcuflCA6Bvrd9rGKshvhPFITNVjLQFiijsQMxQ7HyFPN9KDpI8QFlufe6imer80UQPr
         4owye83ciH2aTw1fRvOmHgKrDhXFOgRLnp8gb82hFc5C85ZqJeNOSAiMFX+2AEbsAjdn
         lRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSclIs7n5vpOSvxh2OrnHeX+5b5kOfOtKGtkOgLl0/Y=;
        b=sAJM2XSHRVPBtU5bnzFXZXySixuIzT+bp1RN2KAaOQxtOeTkCy7jqsY6j5jLWudykm
         t1pZ6cS0JWSz1DLhfTJ/g0SHjLIvl6FiGGE2v1IQiY1ARpZxIpndusPhodeoHowFoHX/
         u4fklaAiyrw/cZp307NYlGDF6K9E94L7NQckrTOvZkrWnT3Mc5wQFCzOceFs1Fe7oG/A
         OnSBy4fX5lXXrMCliwIJCYmqMDG1Tx8GTEw1WE6CxktJFSSI1i13YN4cWF+9gkZgUyqi
         jiUk0A5TTTH1mBxdc+l6H/E3XkfyjLFu7GWK+0kSTIvXsKNIjjaeun5ov5dh5GKqCVj7
         G/ZQ==
X-Gm-Message-State: AOAM533JBOKvz3RhfuXirWohYbpK6/G5k1l7OYf8yKT5jtQ61C+7ibt5
        78pXE2SfzkESPTi94pfk1Gri8MGLL/Qbl1K3Vdn8
X-Google-Smtp-Source: ABdhPJyoOh4d1o3ex77cQD0moZLEf9Ht3wehb6wOgCo5liChTu7jBmv/acKYI4ooL1J0tjr7yhg8ntLwvLjO71Zudho=
X-Received: by 2002:a17:906:19d3:: with SMTP id h19mr6064005ejd.106.1591841606286;
 Wed, 10 Jun 2020 19:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200610215713.5319-1-trix@redhat.com> <20200610215713.5319-2-trix@redhat.com>
In-Reply-To: <20200610215713.5319-2-trix@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Jun 2020 22:13:15 -0400
Message-ID: <CAHC9VhTd0HSv6Yk8NxJeC=U7wPb0AtRturAGYLfxg8B13h0FOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix double free
To:     trix@redhat.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, jeffv@google.com,
        rgb@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 10, 2020 at 5:57 PM <trix@redhat.com> wrote:
> From: Tom Rix <trix@redhat.com>
>
> Clang's static analysis tool reports these double free memory errors.
>
> security/selinux/ss/services.c:2987:4: warning: Attempt to free released memory [unix.Malloc]
>                         kfree(bnames[i]);
>                         ^~~~~~~~~~~~~~~~
> security/selinux/ss/services.c:2990:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(bvalues);
>         ^~~~~~~~~~~~~~
>
> So improve the security_get_bools error handling by freeing these variables
> and setting their return pointers to NULL and the return len to 0
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  security/selinux/ss/services.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks Tom for the patch and Stephen for the review.

I've marked this for stable and merged it into selinux/stable-5.8.
Considering we are just a few days away from the close of the merge
window and -rc1, I'll probably hold off until next to send this up to
Linus.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 313919bd42f8..ef0afd878bfc 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2888,8 +2888,12 @@ int security_get_bools(struct selinux_state *state,
>         if (*names) {
>                 for (i = 0; i < *len; i++)
>                         kfree((*names)[i]);
> +               kfree(*names);
>         }
>         kfree(*values);
> +       *len = 0;
> +       *names = NULL;
> +       *values = NULL;
>         goto out;
>  }
>
> --
> 2.18.1

-- 
paul moore
www.paul-moore.com
