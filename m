Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F6C433FE
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhKWLcc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:32:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233958AbhKWLcb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 06:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637666963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TzL3TGSI1TUQobUrptdDupqZeiYHsSRMg9nk/6Q7AY=;
        b=Rg3MfEZF5TeO6RFrgxIYkIM/yT30cy0lbnK8Nlh9Tfs/uWM+oR3XODF4FnvTPCY36igalC
        4WuacA1s8knzOU8PyjnmB2yF58C4jCeCS5aNVByStEfh2E53q9KP8rXn44ldsTNreKYOOE
        Xog6kc4gcksi4tqcyl0PYMgDX3ZmIEg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-7WfVrrWYPGuobkk9zFmIVw-1; Tue, 23 Nov 2021 06:29:22 -0500
X-MC-Unique: 7WfVrrWYPGuobkk9zFmIVw-1
Received: by mail-yb1-f200.google.com with SMTP id q198-20020a25d9cf000000b005f7a6a84f9fso11707470ybg.6
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 03:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TzL3TGSI1TUQobUrptdDupqZeiYHsSRMg9nk/6Q7AY=;
        b=7/MHOVGLP6ceoAN6rXZDpOLxvSV9mLSX0tAYFZVZCzXuba0oYDb5NYBMa/WVgu1GbO
         PzMRjBicFSj7yXgFleK4s3UJohUhRA5SDThm0wiY7mDtryuZI7ZBct5DZlK7UuHICRTc
         +m/SS5vu2rMNTtAZy4Vw0N+995RZKiWS7wCjq+JoycOyF6TU/E0QrkxxgVRJeEuU3jyR
         uvagSfdjbRXFSQL76hukC9hAPlmrhwHgTv05MFIgvkjVwoZ5ZaCAkGXuLMgkppNKn8gI
         +AK+gnA4YmGU/FRbPW2xvvORdco7pKIYhKAWNs4EnjQjzyTbZmwoJFs+Fk2qgUJmi+aD
         GwWw==
X-Gm-Message-State: AOAM531fT41z0P1KR2hMtdZgo2ln1b8AcDMydxz4ehwpwTGwSp3Q7vp1
        jj4JgHIOSnb0c4KY/nTfNuDJJVZcCRJN/QTHoofXRi9qpRp8VU3wQl7dAHU882OP67eJniARwFK
        aLRW2lK+0gqVpeG5Xku3LS6oBWkHBoVADHg==
X-Received: by 2002:a25:6d7:: with SMTP id 206mr5201137ybg.384.1637666961822;
        Tue, 23 Nov 2021 03:29:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcCOy75TnyNb4Sc1RS7Jz/KcDBE75NoO500/9l5oaGXoX5PrlMUHpidgWrtcMUpbPHbfW3du9V9ZGr60XuLN8=
X-Received: by 2002:a25:6d7:: with SMTP id 206mr5201106ybg.384.1637666961636;
 Tue, 23 Nov 2021 03:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20211123103805.415558-1-plautrba@redhat.com>
In-Reply-To: <20211123103805.415558-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 23 Nov 2021 12:29:10 +0100
Message-ID: <CAFqZXNsm966va58Y-+cdVEPPJXvqz=tJPm_Q9bVpTT6q0qNf-w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix selinux_restorecon_parallel symbol version
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 23, 2021 at 11:38 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> selinux_restorecon_parallel was originally proposed before 3.3, but it
> was merged after release so it will be introduced in version 3.4.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libselinux/src/libselinux.map | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
> index d138e951ef0d..4acf1caacb55 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -241,7 +241,7 @@ LIBSELINUX_1.0 {
>      *;
>  };
>
> -LIBSELINUX_3.3 {
> +LIBSELINUX_3.4 {
>    global:
>      selinux_restorecon_parallel;
>  } LIBSELINUX_1.0;
> --
> 2.33.1
>

Thanks, I forgot to bump this when sending the v4.

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

