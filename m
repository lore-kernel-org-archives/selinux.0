Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C89EC001DB
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 21:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjHHVAH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjHHU7w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 16:59:52 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD12100
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 13:57:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bcac140aaaso4766572a34.2
        for <selinux@vger.kernel.org>; Tue, 08 Aug 2023 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691528234; x=1692133034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS5jj+LJIlaFmebXscgv7ALonGJ5hEAqrVobn+h6tkY=;
        b=Y9hnaF54b9OdWRu8Mgo3/Um7XsJJt1IeTsHVaRqVcf1uJTYzuVx8plDvnbGPQQj30O
         nuYIxW1noSDzKhQn1bQvSQjWSQiphGrfkmDI07IJvzTyThMAKGpcSqKUnJEXOZIy4UfX
         kXhFh2CXld2Se0q0gmX+7ubme4nz6vRkqdHfLaSNTcgpkdiCs2y3lAwXmLZFgAKvIYhL
         tdmIKD6prK1gA2c3AyFva39ZjOX8CAU9OsRde34oHqg4rDAv7Z8snLfK96+XkNaGF3Gy
         KXOAdkwWxfBvmL9pFbiIERAOmX3yVhxYD3nsKV0Ml3S+yxxPlRvZ2OxG5MQgQmsS/j3a
         ewuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528234; x=1692133034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS5jj+LJIlaFmebXscgv7ALonGJ5hEAqrVobn+h6tkY=;
        b=KpxTA0gJ2qJFBWEnDhhnYRXOQNr4GfyVWhBtcu8VZiznowuPeUjk4gfS9haSYnTFBy
         a9FgdDfUGcILUsG4O2Udp2PXiLKFaKfym7w6SzBJFO+JeUIGFTJO6h0IWICtx5jqi64i
         FbC9mfkgZwAMrPG+dCI6GkCYGDWmb/8WUGIytfcDfOKFfCaB/GNPX8o/EPJ/5ThoTQlj
         jcLf0f7ph4mopHYVeQmlPKHjyjsnqS7rd2biMvEhv+kKXfUL/trn1HtWuuHT9WbZs/NN
         CbaCifjqHU8J2uGabu+dliroSD7dV6lxnNb2+oHbjIWevmhA0VBgwGz6V5rqMLy47hHj
         AFwA==
X-Gm-Message-State: AOJu0Yxq44iFbqvQCjvt2R4xos71+1qik35tgfSY7wkBolJpJMKiKiyX
        jGA84JM+Tryp5rl6UDK/tvDMToPoUhh3FTf0xlWV
X-Google-Smtp-Source: AGHT+IF6at6g2JHJkuRBhYYtMLf3GXfKz3mwW2gLejTNbDRqI3v7TYVl5ylxtV0uehKkfpThdRY8EvckgK0r71MA1+k=
X-Received: by 2002:a05:6358:8820:b0:139:a866:4155 with SMTP id
 hv32-20020a056358882000b00139a8664155mr503973rwb.5.1691528234358; Tue, 08 Aug
 2023 13:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <ZNCWUQXKrZnCeB/5@gmail.com> <CAHC9VhT+DPRrSnmh_2PCAf05jPCE-EPaMU_TLB=jJ+mJ+NALsw@mail.gmail.com>
 <ZNHTuHFDVdCNPXj+@gmail.com>
In-Reply-To: <ZNHTuHFDVdCNPXj+@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Aug 2023 16:57:03 -0400
Message-ID: <CAHC9VhTUZe0khZCy7oow4RZYgk-9wh18_78gQY1+ikSqECNq6A@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: constify the 'target' parameter in security_capget()
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        john.johansen@canonical.com, ztarkhani@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 8, 2023 at 1:33=E2=80=AFAM Khadija Kamran <kamrankhadijadj@gmai=
l.com> wrote:
>
> On Mon, Aug 07, 2023 at 07:09:33PM -0400, Paul Moore wrote:
> > On Mon, Aug 7, 2023 at 2:59=E2=80=AFAM Khadija Kamran <kamrankhadijadj@=
gmail.com> wrote:
> > >
> > >
> > >
> > > cap_capget() LSM hook declaration exceeds the 80 characters per line
> > > limit. Split the function declaration to multple lines to decrease th=
e
> >
> > "multiple" :)
> >
> > Don't worry, I'll fix that in the merge.
> >
>
> Hey Paul,
> Thank you. :)

... and now it's merged :)

--=20
paul-moore.com
