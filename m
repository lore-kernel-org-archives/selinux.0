Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF99BCCA47C
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 02:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiFHCRJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446259AbiFHCOL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 22:14:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2F2533F2
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 14:22:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id a10so7409151wmj.5
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I0TYj0aY/TkdqOtA53I+eFE0LIyvHOAIiCLx8hJBREw=;
        b=e40+dm/Z0W0bIfob5pTvP0J2RyA4XpxF11pWtEW7puVHQEiUnWvd2CVD5XctVds9Bn
         PShLixF5Z4+GFBxqf2YR+q4TKyj0YAyTh8B08UoCUcVGBEeXJw3LB3TDHcgY0OphiaBw
         BeuKOWXH2i+K+No4ln5jeT/AJUK5T9VEOcG8dUQckKV3KbXWODCdTYeGYur0rCBwOLoT
         rKutET82TgGy2BgoaxPWUnW8sGs6P4YskJacxjyO7dDtvzcbFv1zJoPmg+MuHPjFSbt/
         RweF/zHNN6q+a6d0MWPovexRLYenU/ASh1h0PWKSbW10Qc96jNP5Nk2Ls3O4zqDzQnL6
         fOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I0TYj0aY/TkdqOtA53I+eFE0LIyvHOAIiCLx8hJBREw=;
        b=bkWZi4aVPSgRs0dHiQg8wzRNC4yXEbq5hCJ81MiXRHk1x2uHwaxmCE0hQ55N9+CP5J
         YrbDnukGoiMFSC4zCev/QmYHihx+fKLMfUOJ4dBgX1gKNzMSuyuwUXZFSctS8kcZ69rJ
         4i+YPJE/8c29CKMJtvfR3jqBTs7KvdClsQVgvr9exLpdRdfhNDXXhtEzP21o7fokzoc0
         wQr42ts1/grLbbk7wX6+Fd/pbOVKymTI7TAZYgQrZQgsycut0+Z5Y55F7DGI3BR21gvC
         zc2hxmOzMLA7S10G3aV25EZHyDBrWoQPyCc1MUL9zREGU5jscHvLwhbQD9gGwcrUgJTT
         YMXQ==
X-Gm-Message-State: AOAM532rhFmjCyRO55Gp0PpenkX/Rk3VH8VtmmpDG/BMYY8b55Q0YS2v
        2YpLJqwRg839se8wmYEmenu0J4qHkQPVWDEUV5mg
X-Google-Smtp-Source: ABdhPJyYw/U5+gWoypUqkMl2O59z0OyPFHm7PAW4ahOWZ6+WyOnqtBiiwAIn75Yllh4b0x6DATOkqoiYJsazfLTYCeU=
X-Received: by 2002:a05:600c:414e:b0:397:55aa:ccc0 with SMTP id
 h14-20020a05600c414e00b0039755aaccc0mr61566727wmm.51.1654636964669; Tue, 07
 Jun 2022 14:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com> <20220217142133.72205-4-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-4-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jun 2022 17:22:34 -0400
Message-ID: <CAHC9VhRatc13ZsBSsjZeGtBfz0ouUGL9n0LTjbQtuZtYv2M43w@mail.gmail.com>
Subject: Re: [PATCH 5/5] selinux: drop unnecessary NULL check
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Thu, Feb 17, 2022 at 9:22 AM Christian G=C3=B6ttsche
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
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I was waiting for Nick to reply, but he never did, and this looks good
to me so I just merged it into selinux/next.  Thanks for your patience
Christian.

--=20
paul-moore.com
