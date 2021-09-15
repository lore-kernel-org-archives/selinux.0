Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92B6C433F5
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 18:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DC461056
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 18:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhIOS31 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIOS30 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Sep 2021 14:29:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D464C061574
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 11:28:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i6so7019758edu.1
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9HAZ4btVwSoLcVMdutXRisWqFHtXadG67XOBgInatXw=;
        b=YlDEbqhEjN+KogHwIitdZLcywFmaMCW5fo8updGWGGm3HfluIhnnj1blIz44aV/NON
         IiJWP1lGD41uDwQEpeUVeg1I03q+27+4yejTzcj5ikdDrVFGyedjUJ2yw9Z5+hNuWav0
         7aq99t6Ry78LKTgHD63oq8t92YMjlEvemyyAFm8D6EuFm8gutKG9Satn+S/evTN2MI/g
         dFsgk0KH3mgmFuKzu3TtXmE3cf70whTOCIQxl3Vq2ukhGS/35y/XiBKpPikPWiWgYSpB
         02CiSBsJwoL6A3o29pWiLhrxA1OQNQSZXEnUEhNtop3NSjXrfJgAJYg5pHtjUjMfiLIx
         WqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9HAZ4btVwSoLcVMdutXRisWqFHtXadG67XOBgInatXw=;
        b=LfUEcvBdOr37adlCabp/ZmcVXnHL7Iy8OmxvmK27UhTDrMn+R5zLPdw+lCrY5XtCx1
         xaXRDJVRxspr8Eq3cbCxmruDtUFnYRPoFYmfhwjQHFgwL0q5U9Y9L7TjFR9T1zIriF6o
         u/PsIcYrLl2qVvIG0lyktfzImBnf2CKyvpfaHkS0jB8WIVCCjVx0YJA+fXDaXxwjgVny
         25CF2NvCxQlLpYXR1kEJhtLJTcvkmpaATLivnVUZNIRJ6CzSM9rmBh6cgvYzZJC6N7tm
         jszosMwy7ftxCHXulMfX+NjvIXBmw5HuNqLwO3KaqJobNxDvI0bCzkykDrOBGUYKpRqa
         42lw==
X-Gm-Message-State: AOAM5301EJtfqP+89kIyxsNxyKbDolvzEOnq5WyQuHbaU43AYEl8UPcY
        Xa7HyUeWMTQglfP8a1O1aDFeF3Lk6gJmuAoXxrjc1c94YU/Y
X-Google-Smtp-Source: ABdhPJzy2fDWDUV7y6Z2RJCh77SxOjaGBz91KUxmxaJoVIxq/4m+8UVoZvvpO1yUUL4CrcHcd66KL7jsUO0Q0vD3cqU=
X-Received: by 2002:a05:6402:1607:: with SMTP id f7mr1508701edv.187.1631730486059;
 Wed, 15 Sep 2021 11:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162326.392808-1-cgzones@googlemail.com>
In-Reply-To: <20210915162326.392808-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Sep 2021 14:27:55 -0400
Message-ID: <CAHC9VhTcyz5i7jRiz1iAg7U_Ru1cJi6APv0GyMw408d+2aJmqw@mail.gmail.com>
Subject: Re: [PATCH] selinux: enable genfscon labeling for securityfs
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 15, 2021 at 12:24 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add support for genfscon per-file labeling of securityfs files. This allo=
ws
> for separate labels and therby permissions for different files, e.g.
> /sys/kernel/security/integrity/ima/policy.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Hi Christian,

It would be nice if you could add some additional notes on how this
was tested to the description above.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6517f221d52c..a18626424731 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -760,7 +760,8 @@ static int selinux_set_mnt_opts(struct super_block *s=
b,
>             !strcmp(sb->s_type->name, "tracefs") ||
>             !strcmp(sb->s_type->name, "binder") ||
>             !strcmp(sb->s_type->name, "bpf") ||
> -           !strcmp(sb->s_type->name, "pstore"))
> +           !strcmp(sb->s_type->name, "pstore") ||
> +           !strcmp(sb->s_type->name, "securityfs"))
>                 sbsec->flags |=3D SE_SBGENFS;
>
>         if (!strcmp(sb->s_type->name, "sysfs") ||
> --
> 2.33.0

--=20
paul moore
www.paul-moore.com
