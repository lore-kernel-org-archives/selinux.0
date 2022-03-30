Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44141C433F5
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 13:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbiC3N4t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245107AbiC3N4s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 09:56:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0247C6EB1E
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 06:55:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q11so24790212iod.6
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FcK7QmkIiYJSoQw2INEcc2ogTo2eh1Iq2n21s2DHUY=;
        b=fXWvPM6W1jxz/Z7rQjc4QFPf1WnATQ69T+/sez9ryYVjX7UuxOgSoinJD5cUNr2EDz
         Mxkci9hjz1mYPp4uCfdzwNzVQ5AO6CbOdcvu71RUgBB5jHLLdmiihyiNsTY7vJoxC+Ci
         +WlSKoNM6tbmHTgtVRaVZ7UTLaZUaYosTKn6lxYKhJgdWaXSB2eu73zjGdwDb1x1aRa9
         wPFGvkQT8HYqYlvH7l7lMi5gazpu6ZvecGgkFz2DsOa+Hk3zaKWIPIj8o3/kDIbECjVo
         MVCB5A1cQXv2BQsM3RQDDk+oCm6o/yGo2D+LWhJ8PUN/S1KS5U79+4+Z9bn1Quuo3cYx
         DUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FcK7QmkIiYJSoQw2INEcc2ogTo2eh1Iq2n21s2DHUY=;
        b=uy5uJIvTNWw7XzOrOek268DiPFdfndxgVHo1XXl2yXcUlu8/znu86//3VtD8HzZCrV
         puO2t2X2AW0tEsZ8AczJipvczLElM+xiBYFwjSnB7TWvUFIvZx0TcFLWeYgWWs+965Tw
         +ISCzYSQi0Ya/Cu67j2H6l2tNzmPsnaQbBcpDlnUmLgLBhm0TNA3Ly9KPTNv4468K7bw
         E/MduFLz4wuG9im8ooAjLfavYCfmej5V/nTYOoazRoeFZaU1bLy8fn8BFO3uHkC2AMDa
         irElWim1cDcU30u5hKzFJthWTbOjONT36hlT10zF4URvdbOxRIh3lUb/9ssMi7GukvSK
         YG7w==
X-Gm-Message-State: AOAM533Q2zY2s0yTSNcKBL5VimQKOhitPCCAwcSIZA7oojwpnc2OI6+a
        m26ZyzDJ6+/k9loTQLTtBtFTwLLE8ET94eYnN1VFLg==
X-Google-Smtp-Source: ABdhPJzTiUQTToFkyOPJRB/TwF70NjXdErTbh21wJZxtb2Vj3+tSzKzQ34sXnXPRabammXURjXgK+MNAb9Xq6V+xgDQ=
X-Received: by 2002:a05:6602:2c0c:b0:5f0:793f:cb9e with SMTP id
 w12-20020a0566022c0c00b005f0793fcb9emr10908223iov.122.1648648502126; Wed, 30
 Mar 2022 06:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220314182400.121510-1-jwcart2@gmail.com>
In-Reply-To: <20220314182400.121510-1-jwcart2@gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Wed, 30 Mar 2022 09:54:51 -0400
Message-ID: <CAGB+Vh59mbuLpAAXU2vikcF+3H9t_DY9N8GNHEkWv7bzP0hXGQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use calloc when initializing bool_val_to_struct array
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 14, 2022 at 2:24 PM James Carter <jwcart2@gmail.com> wrote:
>
> Use calloc() instead of mallocarray() so that everything is
> initialized to zero to prevent the use of unitialized memory when
> validating malformed binary policies.
>
> Found by oss-fuzz (#45493)
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/conditional.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> index f78b38a2..a620451d 100644
> --- a/libsepol/src/conditional.c
> +++ b/libsepol/src/conditional.c
> @@ -522,7 +522,7 @@ int cond_init_bool_indexes(policydb_t * p)
>         if (p->bool_val_to_struct)
>                 free(p->bool_val_to_struct);
>         p->bool_val_to_struct = (cond_bool_datum_t **)
> -           mallocarray(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> +           calloc(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
>         if (!p->bool_val_to_struct)
>                 return -1;
>         return 0;
> --
> 2.34.1

Why not change the mallocarray macro to use calloc? I see a number of
mallocarray calls that should be audited if this approach is taken.
