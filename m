Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A83DC433F5
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 01:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiERBj0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 21:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiERBj0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 21:39:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435631DF6
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 18:39:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6so602401wra.4
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 18:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LL3H9bOTckY/7Xan2LfhWnx0Z1oLcqou2P+lDaiBNmc=;
        b=wGdLgb5HKF8h+/La5xopKVe/+HHHx44vtw/quDkURe706W/Tm0OnV4EPbPSFPFro9N
         ARXfvQTktGgFXp3Zg16RxKUOy65t4vUSSHvyByx4wUTVlHey9WjWvDVoCcvhmli+lq0Q
         lFmTiwR9m51fiQ0ut4PUu1aDMiq+lsLNpm2/rDteANJaU7nndDgWDHkg51Y1IIqHJOse
         3TFdWbV1R58HlUTGaIREY3ACno3b53g+g3xpmGrhJOtsWGTtRz50VscoqBH8cMRbGjeH
         hf4Fyi4D3j0wCNU1DdY4xS9zexsEndNxP8+DaemXYxB3noWGcwCDOOqqSd0TaOoa0Iyh
         mozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LL3H9bOTckY/7Xan2LfhWnx0Z1oLcqou2P+lDaiBNmc=;
        b=OMq1oyt1gJzPhxFxphDAAFY/jwytZ/Wi3TSSqEmPgYBddQq8aqYXc/bfSoTaqe8+yO
         WBFIiA1moy2mdMoaxk53pzDuW3voAkC2mQDMaJNPUFdUof2HsXJBYHks06ii9KGee+Ns
         EIJaA4XKbsbHnaieCs8UHugpcg/NnCwfm4gqyNcCRvjWI4Ja+5j+5mXrG67jYVVVMq0a
         sO9J4onJrec0EVT+9w55p8p1kFs/Am007Y+dMhFM/rC3F+GrG2ygO90dKCDc2ThhDmu3
         d6l4VlD+D1ndJHptOA6M3qj+VvskXunEDWdT3TgrLU6dLPeVt1frBmwIneK9FuqsstS1
         rgvQ==
X-Gm-Message-State: AOAM533tjNIexWQBUWAjLSScFNlPodRjrfNVXyT6YAUfN6XBNgYw2P32
        PfZTJyVBLEuojiviZqohOON2i8+mA2lNqqCxDRx5
X-Google-Smtp-Source: ABdhPJwgXzcQqp+qsCuXhI1T3kSRnpn/dMCr16+89NV1ksE5peSM9ZTQq4LNSlAI++MFvQsW5IRrYEehMJLIHjmaUt0=
X-Received: by 2002:a05:6000:3c2:b0:20c:584b:6a3 with SMTP id
 b2-20020a05600003c200b0020c584b06a3mr20295590wrg.260.1652837963605; Tue, 17
 May 2022 18:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092137.141626-1-gongruiqi1@huawei.com>
In-Reply-To: <20220518092137.141626-1-gongruiqi1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 May 2022 21:39:13 -0400
Message-ID: <CAHC9VhTj365p3SJvX+8eBqRO3wddnj0sXtRDp=jEhSdADwiGrg@mail.gmail.com>
Subject: Re: [PATCH] selinux: add __randomize_layout to selinux_audit_data
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 17, 2022 at 9:21 PM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
>
> Randomize the layout of struct selinux_audit_data as suggested in [1],
> since it contains a pointer to struct selinux_state, an already
> randomized strucure.
>
> [1]: https://github.com/KSPP/linux/issues/188
>
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>  security/selinux/include/avc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index 2b372f98f2d7..5525b94fd266 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -53,7 +53,7 @@ struct selinux_audit_data {
>         u32 denied;
>         int result;
>         struct selinux_state *state;
> -};
> +} __randomize_layout;

I'll apologize in advance for the stupid question, but does
__randomize_layout result in any problems when the struct is used in a
trace event?  (see include/trace/events/avc.h)

-- 
paul-moore.com
