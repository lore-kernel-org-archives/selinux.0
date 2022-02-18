Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B852AC433EF
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 16:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiBRQB6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 11:01:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbiBRQBr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 11:01:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4712B521E
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 08:01:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so12717285pjv.5
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XFjNobaT2htcA4k2+rACGDlyXr0w1b0IEeXMGWoU+GQ=;
        b=EPaXCh+QRxSRoSgsWxmJwRg6tqGCP82QzcP53X8m2d27haBnyVeGZM/TmoF1kloVEv
         7uQ7xQGri+04tUGGioLH9mW/QWzlVs+zX7RZTBaQOhJJwwzqnHwshwpwJ6HUuR1cM/sN
         jIEDk5XztFcGgigk325bNCeR1Ru4VN9kqMAvfG6ip18Rjx3zzJ3oKs4CEcrfw7ByvDt2
         B1XNj1b9UPfOQEqnwvGeyQQ9Cr0MFD+oF5AaJlW4klqELqyMnDOo9UBdgnu6QmXprStY
         4Kp5UNnyQlMzncVujkp9F47AvHEfza+1X5MHABFWaCkzNpUMMPQomJCv57ZgHaXhwpSb
         YjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XFjNobaT2htcA4k2+rACGDlyXr0w1b0IEeXMGWoU+GQ=;
        b=NnXZU081Sxf/PgU9bYkXc06kH/EKi2fs5XBjTTOGnqU8M9RRd8d+9oTZNUKHx37mqr
         1FhSvRNhWjHO/1mXnV5ugAgbcmS72iIvmjrh/DhE2iwJ9oIEYYYQwO7bt7AmHLeSNFcy
         XXam4eVw6BB/heve8/A9zwxPjOdSQx1ZXm+xX4Q0bhRcA01t/4MayJOqkA8Gqp412qRM
         1sYIw5ELwU8TU3ZJckDCpNrPtzum7KXi+8sTNnRfNbLk8ShttDCVFyWcQLqgNQ5raRv4
         tIHhDinUzDrtEfdnmrrFvzfCUd8hT1uJ8l9ZsaLL5j0O1G74O6SD0uFvveRWX+NC7oeL
         H7Qw==
X-Gm-Message-State: AOAM533Tnf1erTSPStAw1143zsehVV/GgQkovR2uK0U90rOvGK0nlSMe
        vllUjn+H6YM3rNwcTNs2rquUCHZAlYp4rcjK56y5
X-Google-Smtp-Source: ABdhPJwLt+s8aeYwD2rdVVWp7ivVPPj6qTMkm8CczLA4ox6HcF14gZmFwHu1ScwIEJ2iHUDfWyR9MXBzmMJA0gyJ1CA=
X-Received: by 2002:a17:90a:9294:b0:1b9:48e9:a030 with SMTP id
 n20-20020a17090a929400b001b948e9a030mr13317434pjo.200.1645200081628; Fri, 18
 Feb 2022 08:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com> <20220217142133.72205-2-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-2-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Feb 2022 11:01:10 -0500
Message-ID: <CAHC9VhQPZ3_dXvM9eqwsxZ2c+2mcdvNNJbtUNs_-9Md5F3P8vA@mail.gmail.com>
Subject: Re: [PATCH 3/5] selinux: use consistent pointer types for boolean arrays
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Austin Kim <austin.kim@lge.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use a consistent type of unsigned int* for boolean arrays, instead of
> using implicit casts to and from int*.
>
> Reported by sparse:
>
>     security/selinux/selinuxfs.c:1481:30: warning: incorrect type in assi=
gnment (different signedness)
>     security/selinux/selinuxfs.c:1481:30:    expected unsigned int *
>     security/selinux/selinuxfs.c:1481:30:    got int *[addressable] value=
s
>     security/selinux/selinuxfs.c:1398:48: warning: incorrect type in argu=
ment 3 (different signedness)
>     security/selinux/selinuxfs.c:1398:48:    expected int *values
>     security/selinux/selinuxfs.c:1398:48:    got unsigned int *bool_pendi=
ng_values
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> ---
> A more invasive change would be to change all boolean arrays to bool*.

I think that might be a worthwhile change, although that can happen at
a later date.

A quick general comment: please try to stick to 80-char long lines.  I
realize Linus/checkpatch.pl has started to allow longer lines but I
would still like SELinux to try and keep to 80-chars or under.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 6901dc07680d..7865926962ab 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3175,7 +3175,8 @@ int security_get_bool_value(struct selinux_state *s=
tate,
>  static int security_preserve_bools(struct selinux_policy *oldpolicy,
>                                 struct selinux_policy *newpolicy)
>  {
> -       int rc, *bvalues =3D NULL;
> +       int rc;
> +       unsigned int *bvalues =3D NULL;

Doesn't this cause a type mismatch (unsigned int vs int) when an entry
from bvalues[] is assigned to cond_bool_datum::state later in the
security_preserve_bools() function?

--=20
paul-moore.com
