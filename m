Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE37EC433F5
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiA0ROH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238738AbiA0ROH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 12:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643303646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYxsBUepidasXIfFepgzR20DJc3Qltovvcg19SwyAn4=;
        b=MIzqQITKUKELWy3AcsdJ/LJUPKJYhiZKwL1YM2IvIhp91wuXtqA5OSwF5QzC404mOl2dPC
        jKFzH5rXq9G6ZII8BNIIM+8/VIl6mvUJdhL2Ni4ovJJSdd/jK5OxE7b5GpX1nKCnMZqPO3
        N5EwKGVNrkQnOU/1810orsP0peN1JLo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-jaAXEpcYNBGT37KKzJKDPA-1; Thu, 27 Jan 2022 12:14:05 -0500
X-MC-Unique: jaAXEpcYNBGT37KKzJKDPA-1
Received: by mail-yb1-f199.google.com with SMTP id g67-20020a25db46000000b0061437d5e4b3so7024630ybf.10
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 09:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYxsBUepidasXIfFepgzR20DJc3Qltovvcg19SwyAn4=;
        b=xUZx4LuKKqbBnlKEs98v28EKzhSPPfIe8VMy8F0T/VTK1xaRBH1unuOLrm5iJDPvDf
         DFCqQfilqZKm8Qi9jAUut+ghauLmhwaSNf/XJ0fb4qXdQxVMpA2mP+LZhhd7iGm8kWu0
         +4j8lkAD876h0yxwW0OP3svH4Pp7KFFitcZMgTpovDuP/knZwXeJUx4PgVgnueklJ0UU
         4pgew3e2QGkbQId/MTTQ+c+UI7Zh6feTAUaGrieLIeyF/zygF1t6c3DoR+mgC36S/BsG
         6egvpZHAoMrqi50g/xqDHqzWQswouUu5jxrdrFnb3JGbWrWqI1ybdgSH0engJ9pm5yxa
         achA==
X-Gm-Message-State: AOAM532BJ+YmX8Ux5XpWzVrRH+CEhCHfZVMegTiLINEm54pKtRsWwEc7
        EUNjDjTJ/fnLNApP/1MMaZmnkLeaMYxSececHYLhoGnxdwCRMcmcm1q29TUVhU+X6oH5DbzvVpC
        xbmuS+pNNZhOOcmJCgk/ksFkggpmGkmzgRA==
X-Received: by 2002:a25:b003:: with SMTP id q3mr6248505ybf.767.1643303644545;
        Thu, 27 Jan 2022 09:14:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZGQvPqgFdGEL3bL8azZkXyXgPTvpl0xUCaDGyxUSQjUiV4Is40Y8wqTEcT0NqvaTtPITGbIyc/nafqppfUaw=
X-Received: by 2002:a25:b003:: with SMTP id q3mr6248481ybf.767.1643303644349;
 Thu, 27 Jan 2022 09:14:04 -0800 (PST)
MIME-Version: 1.0
References: <164329905457.31174.9220154812163631144.stgit@olly>
In-Reply-To: <164329905457.31174.9220154812163631144.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Jan 2022 18:13:48 +0100
Message-ID: <CAFqZXNsKDLyz7E20uc7=1NaABcf8Gu8fhHExkttMN_5e59tY7g@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a type cast problem in cred_init_security()
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 4:57 PM Paul Moore <paul@paul-moore.com> wrote:
> In the process of removing an explicit type cast to preserve a cred
> const qualifier in cred_init_security() we ran into a problem where
> the task_struct::real_cred field is defined with the "__rcu"
> attribute but the selinux_cred() function parameter is not, leading
> to a sparse warning:
>
>   security/selinux/hooks.c:216:36: sparse: sparse:
>     incorrect type in argument 1 (different address spaces)
>     @@     expected struct cred const *cred
>     @@     got struct cred const [noderef] __rcu *real_cred
>
> As we don't want to add the "__rcu" attribute to the selinux_cred()
> parameter, we're going to add an explicit cast back to
> cred_init_security().
>
> Fixes: b084e189b01a ("selinux: simplify cred_init_security")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index eae7dbd62df1..c057896e7dcd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -213,7 +213,7 @@ static void cred_init_security(void)
>  {
>         struct task_security_struct *tsec;
>
> -       tsec = selinux_cred(current->real_cred);
> +       tsec = selinux_cred((__force const struct cred *)current->real_cred);
>         tsec->osid = tsec->sid = SECINITSID_KERNEL;
>  }

How about using unrcu_pointer() instead of the cast? It seems to do
effectively the same while looking less ugly :)

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

