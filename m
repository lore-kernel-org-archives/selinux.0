Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C67EE14B9
	for <selinux@archiver.kernel.org>; Wed,  6 Sep 2023 17:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbjIFRSp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Sep 2023 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbjIFRSo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Sep 2023 13:18:44 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7EC10F6
        for <selinux@vger.kernel.org>; Wed,  6 Sep 2023 10:18:41 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6befdad890eso85328a34.3
        for <selinux@vger.kernel.org>; Wed, 06 Sep 2023 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694020720; x=1694625520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMcHqIcaqJ1ueWcchKt99zGSC/qbCR3zDhNPQ6bIGps=;
        b=g/+BifaykG9zZaVBnP6JnllHafL+OMWmYQHJuApfrnOfbE6+9FIH31meWzmSj6n0Aa
         9JA0TArfQBlYYIEj4avvnGpLZsrALbcrfyMLcU1sDXNtM0hQdigHKL0kxKz+BRaoSb6s
         S0ZDtYwBPetqNc5/nvN3Pz5p9q41u1tCw7u8epWZ6K9UD2HMrJbCMw+UvGiayTYCR/O/
         IC1W3VBw5smMJ4aEfmriC/xNSh72vmnx4LokU3FzmTFCy92Ac7TGzExsTnA0anAN8LGs
         b2uGEbkLjFJeHlX/+ThRhIB5Uwds/dGLl1k3CQSWys4P2mNy2+pocqmf+4fegBDFSmdU
         8fzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694020720; x=1694625520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMcHqIcaqJ1ueWcchKt99zGSC/qbCR3zDhNPQ6bIGps=;
        b=H1WvaO1iCbIvaQ5phjHXVYuzHkRAg839d/2D1qPJS5UObjKr1abT4y4u83nNe6g4tM
         u4I7wPlEPHIizr6yhIMECUWVm3UOWRC0wXR+saiW5SyWcEzKtShBJhTqB4lYde0CMAXa
         0aTeg7mXCdQAlQGoc9Cdx55IVeiwnlmlLz1qJfsHIxLpo0DWx28BI4aBThti+f265T/d
         n8IXT7kuSwm8KHLG6WUkSsfL18G7N1sJfa/vVu6AxiDSNTZNzUoWXt12BsDKr58kdxkq
         8PSPowbpeKxkJ8xmsC1NxJKBeWnXNy9LVdcs5P23Zfppl6QD0EtT1vuiqKZBPe3L4EzX
         5AAg==
X-Gm-Message-State: AOJu0YzeJ5eGpPJX3Dm3e/t/WPNbPyxqH2yyF3Kr7iIuCOaIA6vNhwQ1
        CLHRJDAK/CuwDgnBFccPvdjfSk0FYDXX04phcwOEu1zgRJA=
X-Google-Smtp-Source: AGHT+IFqRHzVxhMYdX44Z0z6yfzPQsQ1C0TbKhWRwRTx8v4X5DljBktbWJxJHX+JjYJv2acylBHvSU2mQBjIkzlVDBg=
X-Received: by 2002:a9d:7d04:0:b0:6b9:6aee:32b2 with SMTP id
 v4-20020a9d7d04000000b006b96aee32b2mr18905802otn.6.1694020720676; Wed, 06 Sep
 2023 10:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230906154611.31762-1-jsatterfield.linux@gmail.com> <20230906154611.31762-4-jsatterfield.linux@gmail.com>
In-Reply-To: <20230906154611.31762-4-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 6 Sep 2023 13:18:29 -0400
Message-ID: <CAEjxPJ5EP4bC4KN+kfOuZedi+CQsLX_MUpSx5EEFS2J2OO9o3A@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: hweight optimization in avtab_read_item
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 6, 2023 at 11:47=E2=80=AFAM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> avtab_read_item() is a hot function called when reading each rule in a
> binary policydb. With the current Fedora policy and refpolicy, this
> function is called nearly 100,000 times per policy load.
>
> A single avtab node is only permitted to have a single specifier to
> describe the data it holds. As such, a check is performed to make sure
> only one specifier is set. Previously this was done via a for-loop.
> However, there is already an optimal function for finding the number of
> bits set (hamming weight) and on some architectures, dedicated
> instructions (popcount) which can be executed much more efficiently.
>
> Even when using -mcpu=3Dgeneric on a x86-64 Fedora 38 VM, this commit
> results in a modest 2-4% speedup for policy loading due to a substantial
> reduction in the number of instructions executed.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/avtab.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
