Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CB1EB64DA
	for <selinux@archiver.kernel.org>; Thu, 20 Jul 2023 20:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGTUpl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGTUpk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jul 2023 16:45:40 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12184E6F
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:45:39 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b038d7a5faso968488fac.1
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689885938; x=1690490738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHsGXiGkuWqSHYjU2GwfA7kVibipd2+moLCxICYQn+M=;
        b=RAQqLxmaaibIjLwhM/v97UTdtbVYfL5AmCWq2OuYRj+1+VmyybvPFfcm7hJNUQuNdz
         tZicPp4xhB5BLqQhOiBE9eKi3VUBvUCfBjIgG7EV9388Us2wiKpvh8JWRO8LGMvavSGM
         3bFp52Upf9qB5HLrm2isbOu9rk+dFKTrKNO9x8riRUCXEdmq8tlOMBVDaVXtO9u/b9z7
         KVlMRNv6jUvDTejYV1gMj3lO0c7Os4DBZt+6cxiSliLYC+gdYHKdftzRqrpIPBYgX/U3
         TikK+DyHqiveGowqIQhNkvdxGgCQ69Mu3NJ+TehsoPfBqRe394G+f76B1kJXwswDjfRw
         caOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885938; x=1690490738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHsGXiGkuWqSHYjU2GwfA7kVibipd2+moLCxICYQn+M=;
        b=B9bbFH+LbxIn35ZzGMOM8RGsOV1lSpbfI/OdN/GJgui1BXjUToKExKz3wkk8GbKOgl
         JGEKOUQ0s++RJ+b8NrbyPjCg9UKQ++4B/parleGODte1uH1QMWZbfF7PwKXzdu+JGRZs
         uYaH6lUaL+JhzwR1Crtn3HkMcCCnUi4RVvZRW7MXVYnhfZu7owfxUlcumLCYrSZVhdjx
         899NtJANWjdIRZD8lqZRf07NmuzdV9blfmGmMfXZ402IpBnfDMP+gqqB6pLdoRjn4Kes
         Feiq+4vU2JY5Y3ksZj+7FAReksJT02wuFyDdpSvTrycomG/RCGEBjQheBGdZzdnZHzyr
         2LBA==
X-Gm-Message-State: ABy/qLajwymJxfOWbBEuNGm0ZcbhVc6Xdo3HcXqImkVgxHndWBCR54pf
        9e0OTjnmqw7qELFaqL9wCI+MEDjAA9E2qHn2qsYy
X-Google-Smtp-Source: APBJJlEzJ0xo9wTZEMRWe9dCX85QX06mllpofgOIqhs6sXC4hNlvtsTQPJx65w+viEjsYVUIa25+nRyTwbuiiMnSkio=
X-Received: by 2002:a05:6870:4712:b0:1ba:8307:9a14 with SMTP id
 b18-20020a056870471200b001ba83079a14mr649551oaq.11.1689885938363; Thu, 20 Jul
 2023 13:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230720103549.25255-1-cgzones@googlemail.com>
In-Reply-To: <20230720103549.25255-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 20 Jul 2023 16:45:27 -0400
Message-ID: <CAHC9VhQKMcU=Bmt=CBVywRFDg+=6YGd+UOkNQ1gKytTgAMOgGA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: log about VM being executable by default
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 20, 2023 at 6:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> In case virtual memory is being marked as executable by default, SELinux
> checks regarding explicit potential dangerous use are disabled.
>
> Inform the user about it.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6f53fa71fbdb..3a7ece84c2cc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7265,6 +7265,8 @@ static __init int selinux_init(void)
>         cred_init_security();
>
>         default_noexec =3D !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
> +       if (!default_noexec)
> +               pr_notice("SELinux:  virtual memory is executable by defa=
ult - related checks disabled\n");

Let's keep things concise and simply say that "virtual memory is
executable by default", dropping the last part about "related checks".

>
>         avc_init();
>
> --
> 2.40.1

--=20
paul-moore.com
