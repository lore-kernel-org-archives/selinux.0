Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE62BC433F5
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 17:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbiBRRcM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:32:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiBRRcJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 12:32:09 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCF5517DB
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 09:31:51 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso2436151oti.3
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nebMkmur+LCxBFBdQ4EXcYnlngkdDHM11vfdWfCglsQ=;
        b=qOv30FszpMXxedCYqw7Wlk3PgAiJh6cKSD3NQ7aJFQyHEdlXr13TAv3jxhrAWun9sO
         YKvcPV8jrrIF/QJEAYVnBOnyEdF1iCqU+rHIVvS4VFGPyAf3gDFsqsBU6+DZxonWYQcE
         6N0xBLSI5cD6TXX/dSD2bA3g7id7/dnJaTN4QkJGJZvTvL3WJ0beg+N8Tg+UcJPZ1b4E
         Vdy054NfIH5ql9x01R86PI3sjjb5Gf0u9uqo6E2keDLxW5SdFy+qrIB8Aft1WCxC+Zyr
         2BCpWFj3rQdi7WtkjEIGgKatb4JD5Jx8axCFz7I8+zyr0564OtCpQ+wIIvX9uy7nUq93
         0nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nebMkmur+LCxBFBdQ4EXcYnlngkdDHM11vfdWfCglsQ=;
        b=K2BN46FOKbyWAoW2rkCUtXr2BLy43BDPJFKKaxy5TpL74dXHHyyQG5prUFvr7imnGz
         BoioiqqJnfFqKu56h/e2GrqoFZNFnd2GCGXUuEArMVbWIDG62gXe5SMapLBvZeD8G4oe
         GI/HFPs3CIoZabj2QXCu5hE2/8JYKsKnn5D2b/kWun0agI4lXyEnrEdieefhNbOCrq6+
         GQjWEbRPQ6oEdCx4khqczCT12PDSIzy3UBgeeDMomRN1BfsNbBT5ogKaoc5I3EsES4UQ
         Df6xPxAcb1qsHtwjfP8o7pArrHUKy95pV+lhmuKoMzUiU+yQ9vFFo9f3FRGCenl2slEZ
         TQOw==
X-Gm-Message-State: AOAM531ewspMVbpSppevzN3w7sjreRAkQYY6xuuucpe19CfNrMP8S2HL
        GP07EOuwnCEa7oUzDpBxChDEWf8x8oO9I47ovOR8pg==
X-Google-Smtp-Source: ABdhPJwHuglG3+2+j2XRYDFvOYqQuaKHBnuw+/dO3Bw5z0CIdEYLx0tl4quY7Mc68D/E3dWCqQGvzAzwhhXj3decPis=
X-Received: by 2002:a9d:27e8:0:b0:599:976a:c873 with SMTP id
 c95-20020a9d27e8000000b00599976ac873mr2843690otb.305.1645205510543; Fri, 18
 Feb 2022 09:31:50 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com> <20220217142133.72205-4-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-4-cgzones@googlemail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Feb 2022 09:31:39 -0800
Message-ID: <CAKwvOdkNZ3W9amcQKHOEfQLbdWC=4VDtrBdbOVHtWruipQnyKg@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: drop unnecessary NULL check
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 17, 2022 at 6:22 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Commit e3489f8974e1 ("selinux: kill selinux_sb_get_mnt_opts()")
> introduced a NULL check on the context after a successful call to
> security_sid_to_context().  This is on the one hand redundant after
> checking for success and on the other hand insufficient on an actual
> NULL pointer, since the context is passed to seq_escape() leading to a
> call of strlen() on it.
>
> Reported by Clang analyzer:
>
>     In file included from security/selinux/hooks.c:28:
>     In file included from ./include/linux/tracehook.h:50:
>     In file included from ./include/linux/memcontrol.h:13:
>     In file included from ./include/linux/cgroup.h:18:
>     ./include/linux/seq_file.h:136:25: warning: Null pointer passed as 1s=
t argument to string length function [unix.cstring.NullArg]
>             seq_escape_mem(m, src, strlen(src), flags, esc);
>                                    ^~~~~~~~~~~

I'm guessing there was more to this trace for this instance of this warning=
?

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1e69f88eb326..ac802b99d36c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1020,7 +1020,7 @@ static int show_sid(struct seq_file *m, u32 sid)
>         rc =3D security_sid_to_context(&selinux_state, sid,
>                                              &context, &len);
>         if (!rc) {

^ perhaps changing this condition to:

if (!rc && context) {

It might be nice to retain the null ptr check should the semantics of
security_sid_to_context ever change.

> -               bool has_comma =3D context && strchr(context, ',');
> +               bool has_comma =3D strchr(context, ',');
>
>                 seq_putc(m, '=3D');
>                 if (has_comma)
> --
> 2.35.1
>


--=20
Thanks,
~Nick Desaulniers
