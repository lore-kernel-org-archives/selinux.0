Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD095C433DF
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 19:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896102072F
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 19:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/KQ/afh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbgFITt0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbgFITtZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 15:49:25 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D548C05BD1E
        for <selinux@vger.kernel.org>; Tue,  9 Jun 2020 12:49:25 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id e8so4424119ooi.11
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2020 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bikc+X4UDLkfUNBTDfOGVrbGTiIxxavR1LeXBzJW3jw=;
        b=E/KQ/afhEZGWTm266o8q8U6JaP1Mu5L+Oxn6xUm6r0B271pEDz2RN3xW6owCLwd+YE
         k+BuEyizA2aEVXyqqohJQ8OpZTBEQfCI0cW2CJqprv3dA+7QN/GN8DWIFODSfBJ/PUqY
         a6g6MgMX/l/hJvidjwiZIEjYYwLMn1emYtFovRpgN0RtAfafU6zpT+5U2Dkr6sOj8Tox
         Z4qp8kNXR4XalJNj5egjBwgXp+liqHYRYryw9bcOLGGfgT2Ua+dW2EqO6oS50sgGEINr
         5KkW4SEfrK6q9BbSLQ8+4nDxfqNHKTWbBDnFYgazj9XO9fjZmuMvtz4dnVrTbB0Eklkw
         Lf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bikc+X4UDLkfUNBTDfOGVrbGTiIxxavR1LeXBzJW3jw=;
        b=Bfjv56D1zrJuuFTZOUFp8Oh6943q4ZrYVjrweSw+JueAQf8iZ9KPilzfGS8ePLB1ud
         i+LMX6c9sevGd3QER99yO0AM28JgyhxQc8ZqD0YQdBUd14WUGvzm8Vhy0aJLstx32aDY
         VGFHApOOUsNJCUqcb6tgUp8LZ0CDbQHX0eilCZKSQugrItm4159R8qN3L5b7UXtoGhc5
         3BNDchxXSbJR2Z6DBhTJRKXzoHztxu5HChIu7TeezWvrUJRSmkdWL4ue6umrtmmowK/P
         rf0MOsLSz8VFY568rg5kBqktUwIXVc/9fLXic4ZXI2yzr1cjZIvCvwbUMaPUmh6+cini
         eDIA==
X-Gm-Message-State: AOAM533wmw+b8QyGY5woK4aia8e2K/IHScPt4QUXk5cMHmM0GonCgZJD
        or/uAi9z1qlY2jSMRIFjBJdsvUo8LxXiN4L0EHI=
X-Google-Smtp-Source: ABdhPJyqcFt/mmzGER5nONTB1/Jhzdf2Y9JGjEr7jXjJfs6IEU0FIE4mDvDxz+lChtlTDJCONRtWY+ShZhRceIWLS5c=
X-Received: by 2002:a4a:e74a:: with SMTP id n10mr22380870oov.71.1591732164232;
 Tue, 09 Jun 2020 12:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200531201834.4295-1-toiwoton@gmail.com> <CAEjxPJ4c5kgnvD-wNXiTGDr=EcZXJGqJKS2n89_ht9T=8oyB_g@mail.gmail.com>
In-Reply-To: <CAEjxPJ4c5kgnvD-wNXiTGDr=EcZXJGqJKS2n89_ht9T=8oyB_g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 9 Jun 2020 15:49:13 -0400
Message-ID: <CAEjxPJ5tZCUGXeTe6U2JujWdGc-PkjvP6FUDLgKyUdPJYkxDWQ@mail.gmail.com>
Subject: Re: [PATCH v2] semanage bash completion: handle semanage module
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 4, 2020 at 3:00 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sun, May 31, 2020 at 4:25 PM Topi Miettinen <toiwoton@gmail.com> wrote:
> >
> > List modules for bash completion of `semanage module`.
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Only caveat is that this can only work if running as root, e.g. sudo
> semanage module -d <TAB> will produce an error message from the shell
> but I guess that is true in general.

Applied.
