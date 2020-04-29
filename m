Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1FCC83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 16:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292DB20B1F
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 16:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR6eMVb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2Qrf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Qrf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 12:47:35 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D932C03C1AE
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 09:47:34 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 19so2381900oiy.8
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggoFBkRn1Me/wWqoA42ygeTeyuGmCG11wCSynyWMims=;
        b=LR6eMVb9em7rhC1wg50SbJRAkp9txmpkH7YA1AqpbL+VqFrgjZUCggw+cHE/KYt0xh
         /Tc2VPKGpqWllpu/cb6IQKISuUCDSLQ1XA9AxLejwMxQMY1QM9pjPlNoAWf49XRqByrm
         wKXZKYoHyMDPWvEFivx/VcGepvCQmdm7eYvp8BS/IYDkB+5HVfpF4ehHxWHmjGOdqvtn
         uxXnBC/3tCZOtvWlgNyWLalD0ZyeZSZKCS762qLmEaieENn5AG55oKN1bq+TkT8n1aKO
         RjBnWxSFTxiwBsL2kf/6jmdjgtaZ0d0KBAjTTsmf+qt+4mqeAxBipV5KwkO28Q3mApwP
         LhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggoFBkRn1Me/wWqoA42ygeTeyuGmCG11wCSynyWMims=;
        b=ubDzsMjyxFvnVe6DeWlH8MGXNUmA/oeSfFZXEF/s2gbUJCAin7HBTTfzIrW5xFyHr8
         gA41rv2d1ZSx6kgypK7Ytlrn0JvKs+pQz3eTa36pCKHuuS/eAj8G9VbueFeuf7ttwC+3
         DBm0dZFpTmPdeCGjhcpbwg9PzRcHPYGfR9ZVbnW8BP2RVZiC407JtHjqMQFYFRTpM5c0
         2a7+5W/3k3qdNGfxMDVIjoNf7l3wg3FkQbe4xEL5bDBc9V6AaOVIp6si0kOCozPVApsg
         7FeojvOExqJ3kwJGVI/11c68TyRFuDb4BTLjqGDXJL8u/Z/gIl1Gcc7FDOueJOJwpxtG
         6OVQ==
X-Gm-Message-State: AGi0PuZcV82vT7uu8XlA4ssJPL6USYM+rsrqnedS0hChL1WGi97jDdTw
        84/k6Q889scxspkOF1M/VXZZNSWAqLm05KAjSmZrCeedUN0=
X-Google-Smtp-Source: APiQypLMyvHszZuQvQItmceCEct+GLwhLg2R/CORY+NPQVoFaFa8siScHiZzIz68y3eC2bq7XpDi29t1Riwrx8EyHCY=
X-Received: by 2002:aca:4c0b:: with SMTP id z11mr2265454oia.92.1588178853637;
 Wed, 29 Apr 2020 09:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <53c7aec9-e132-315e-be42-d7bdc9060eed@gmail.com>
In-Reply-To: <53c7aec9-e132-315e-be42-d7bdc9060eed@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 29 Apr 2020 12:47:21 -0400
Message-ID: <CAEjxPJ5ZSuxxbKfBKfgadEHk=R0APaYtGgstTMcPMU2fYaSk4w@mail.gmail.com>
Subject: Re: Daemon cannot execute python
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 12:01 PM Ian Pilcher <arequipeno@gmail.com> wrote:
>
> Over the years, I've written several Python-based daemons for my home
> network.  I've also written SELinux policies for these daemons.
>
> After a recent CentOS 7 update, which includes
> selinux-policy-targeted-3.13.1-266.el7.noarch, these daemons are failing
> to start:
>
>    type=AVC msg=audit(1588171416.424:157): avc:  denied  { execute } for
>    pid=3359 comm="denatc" path="/usr/bin/python2.7" dev="dm-0"
>    ino=12679476 scontext=system_u:system_r:denatc_t:s0
>    tcontext=system_u:object_r:bin_t:s0 tclass=file permissive=0
>
> For some reason, these policies worked in the past without including
> specific permission to execute bin_t files (something that I'd prefer to
> avoid, as it's awfully broad).
>
> Does anyone have any idea what changed (i.e. why did this work before)?
>
> Is there any way to make things work other than giving any Python-based
> daemon permission to execute *any* bin_t file?

Sounds similar to
https://lore.kernel.org/selinux/23A084A9-66A1-4E02-A766-F9214E63A628@nall.com/,
which may be due to a kernel change outside SELinux as per that thread.

It is logically correct since the new domain is executing from the interpreter.
Note that it cannot execve() arbitrary bin_t files without
execute_no_trans permission,
although it can open/mmap PROT_EXEC them with execute permission.

You can reduce the scope by defining and assigning a specific type to
/usr/bin/python2.7
but obviously that will have a rippling impact on the rest of the policy.
