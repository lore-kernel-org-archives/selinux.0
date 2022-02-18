Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC4CC433FE
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 15:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiBRPtB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 10:49:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiBRPs1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 10:48:27 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF3B275AF5
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 07:47:56 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso12679093pjt.4
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 07:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R7TNHVy3VEleA7R3NGQqJ4zyGtuvT0iWporTmytRR1U=;
        b=KON7l6sZDqK4j+UT/SLLl9wF0aR06ZernKJUjbdRwbfCJF4h8uSdazOttrU1iG8NaU
         aDhQOQ0jYzLFylcXFA+taa/4jHZodaAoym1QARbYZmSzL/dtrbqDNyP1bH7glXmkRDNB
         FgykfB4u+o0F5Wf7FQZatjp2JwJiMs99Jds6X9y6FTpVYUQfDJmJw4lwcpv/Bke0AcGM
         I9KzBB297Tq9W0BEPf3DdlvRXIJTreFFHtgRJxEyLP/qthEggEsUGDqsx4vOGXTbMXQj
         6pfGH4+qTrnMgO7msiSZaQu4ZEWxJe8HvXUAiuDmXrGYvJCHe3iaponKD1TLutiDi3YY
         +hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R7TNHVy3VEleA7R3NGQqJ4zyGtuvT0iWporTmytRR1U=;
        b=UV2Gp/hRTIJVdDHhv2GkHUBN2eTKR+y773mSefWF/Z7T6JArlMnGjsT5W2lfim3syq
         Yndhuf94ziaijJCxrYwRoJ6aTEoK9ZSqK/+6dAZqOp73QPXrlJiA6w/xnJ5jCkYvnaXJ
         SfsNw/IQdWUdkSlsSvI+shPJ4HYvWqHVtynmqGV1oqnpdp+G7SfYMN64I7vmd6Fm3EHs
         pJdcdhCLUF/fnQ9ixG6y01UkzExKefzhJstCuPSkbG3PbKytmRfUhQFLMwgWIZ5QhzhN
         ePwLuYfEiHJL6QNN9ZN64BTw9cJzGreZbFd4V4AGjcA6NBS9iarb6fhWjLnZKz6Vq8qq
         188g==
X-Gm-Message-State: AOAM533x1nb4QbjKNdL2CPmrOtydrsMkdXZ8rDugY/mp1L260QlUp+iH
        Z+RTBoY4MVbgksx6PJq+ivOmFmOY0uZQ0f6k3XR0
X-Google-Smtp-Source: ABdhPJzodkaf8k/ZT66s8Hyu+Nb97VQ60hfUBvzEFWPT3b+9kE7PaFflndfYJBSvH3GRCP/p8PpArYs83Tx8ZDOUlPU=
X-Received: by 2002:a17:902:b94b:b0:14e:f1a8:9b99 with SMTP id
 h11-20020a170902b94b00b0014ef1a89b99mr8066539pls.28.1645199276295; Fri, 18
 Feb 2022 07:47:56 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Feb 2022 10:47:45 -0500
Message-ID: <CAHC9VhSuVr6NPVToScGQ=6Ugm1BFbijtzXxuTW3bs4ze57fn6g@mail.gmail.com>
Subject: Re: [PATCH 2/5] selinux: use correct type for context length
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Austin Kim <austin.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> security_sid_to_context() expects a pointer to an u32 as the address
> where to store the length of the computed context.
>
> Reported by sparse:
>
>     security/selinux/xfrm.c:359:39: warning: incorrect type in argument 4=
 (different signedness)
>     security/selinux/xfrm.c:359:39:    expected unsigned int [usertype] *=
scontext_len
>     security/selinux/xfrm.c:359:39:    got int *
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/xfrm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
