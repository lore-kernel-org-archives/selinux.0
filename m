Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2338EC433EF
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 20:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiECUVt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiECUVr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 16:21:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8FD2BB3C
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 13:18:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so2942251pjm.1
        for <selinux@vger.kernel.org>; Tue, 03 May 2022 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h+anUim6N8kPhedaRXqtOLw9+/rgUrHm7QzUFJPNxuM=;
        b=2hWm19ckEKWfsMbIjsekIVatx68j91DvHaRPoS0oToKiAtQkyaNB09ti8snB7nohNF
         Rces+wM3fsi8aNPXfMa3adr9mWjqtwcYDefEp6weeIn8ldSfAw481Nv1cj1bS9WnPztm
         46sFYb9MDoU/K4MQPBcaKWoVNUGI84f4CtqcZDDEoPKm4n88jtp/5QZdON8wp5I+lvfx
         4rMxaYdy35MBFaxOKaDCBV06psf7kGaTwE979BBf1e66t9j1g6eVhYkmWxa8+8/KMLEN
         EZd510MBpgJb+tem3lnYEXSYfROuOkHk3f89z9jfydZj3mSC8irtIz5hatG1CP8bdwdV
         bU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h+anUim6N8kPhedaRXqtOLw9+/rgUrHm7QzUFJPNxuM=;
        b=kDGjoUS/YRdkj9NtUJqHpZr53j55qF+soM9nbzOAL0wjcVAp6rbT06Uo1OEOGv/0rU
         ODxEEwJui7VEskzUbQq8OVM/cp3jfaH8emPytAtf3XTKCB9UBgbglcQHYTbP0TJ8Yyhy
         J+eGkReZCQKmnSaJA9NkZkYahhCmBBwFDjCZQAtAzaD963xxVqdSpPxf/sqmXOvPHiX8
         5HP+xUAym/LpLJkUFah86HpnZREsw9wQi1Ujr5F0LuE+pSez+cFx5J9UvZesTfSqT2F5
         94k1EmZYh/jnp2b1yA3MQEiJEwuTKlPtyVRWHYoniBKNMiqbiA7Qij4E0nWVIP34eSfq
         dF6g==
X-Gm-Message-State: AOAM533yrUICob9YUh+ayyWYpcef/EpN/TLLvlVHTmDAw6EhF0EVO3lN
        AMdNBiGOGPvdJEVrxJoWVAneVwfN/vpeMcmtj1q8
X-Google-Smtp-Source: ABdhPJzNQ1Ikl3OEEhw7PvSoDXi42stUzXvXKxep3deRkG07vGxBwIa9Rpr8pNvCKqjomXJ6kaWa27JatI5y/a+aD+8=
X-Received: by 2002:a17:90a:9294:b0:1b9:48e9:a030 with SMTP id
 n20-20020a17090a929400b001b948e9a030mr6559960pjo.200.1651609093031; Tue, 03
 May 2022 13:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220502135907.31035-1-cgzones@googlemail.com>
In-Reply-To: <20220502135907.31035-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 16:18:02 -0400
Message-ID: <CAHC9VhRVTMegCwVCVBmp8E9uHawYhpRkXicvOQL-djuTV7dAkg@mail.gmail.com>
Subject: Re: [PATCH] selinux: use unsigned char for boolean values
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Austin Kim <austin.kim@lge.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 2, 2022 at 9:59 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Reported by sparse:
>
>     security/selinux/selinuxfs.c:1483:30: warning: incorrect type in assi=
gnment (different signedness)
>     security/selinux/selinuxfs.c:1483:30:    expected unsigned int *
>     security/selinux/selinuxfs.c:1483:30:    got int *[addressable] value=
s
>     security/selinux/selinuxfs.c:1400:48: warning: incorrect type in argu=
ment 3 (different signedness)
>     security/selinux/selinuxfs.c:1400:48:    expected int *values
>     security/selinux/selinuxfs.c:1400:48:    got unsigned int *bool_pendi=
ng_values
>
> Also mark the read-only boolean array parameter of security_set_bools()
> const.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/conditional.h |  4 ++--
>  security/selinux/selinuxfs.c           | 12 ++++++------
>  security/selinux/ss/policydb.h         |  2 +-
>  security/selinux/ss/services.c         | 13 +++++++------
>  4 files changed, 16 insertions(+), 15 deletions(-)

I could understand fixing the signed/unsigned type mismatch, but I
don't quite understand the move from an int type to a char; is it
simply to save space, i.e. 32-bits vs 8-bits?  I think I would prefer
either simply fixing the signed/unsigned mismatch and leaving the
booleans as ints, or moving completely to a bool type, although that
is likely to be much more involved.

--=20
paul-moore.com
