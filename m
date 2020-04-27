Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CEC54FCB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 13:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68E9206B9
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 13:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaTccGl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgD0Nch (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:32:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21458 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726651AbgD0Nch (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 09:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587994356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2LT51u9otw+gs5DgyXsOGVkP616YYrBH99RtvAZlWeU=;
        b=HaTccGl0Mz8KLfRB2NyPU8RZtlaFqATVTcto8TSpxB/vdVV/BYXaa7kmwrMvXZAF15HhAa
        FScracOPX6f8OuwxS/5C8YteK+6MOsoaefQAUtlLES/4y4fnz3qJ1Xww2GmgWEg5Y1ouR4
        PpQEZ5c81f6EOrptZk/VqY875WeuAAE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-siGIzcK5P5miHNHYRQQJwQ-1; Mon, 27 Apr 2020 09:32:34 -0400
X-MC-Unique: siGIzcK5P5miHNHYRQQJwQ-1
Received: by mail-ot1-f69.google.com with SMTP id x89so15203396otb.12
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 06:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LT51u9otw+gs5DgyXsOGVkP616YYrBH99RtvAZlWeU=;
        b=UjshhX5ypfv3hm565drSNk8OlIeiM4ruIx9Usu+8FPBG/6GHYso7yBhz8mRPZn06U/
         EBMf32wFcIPB2Hmq2gtY4DqFaG1kFtKZKMKqNjdktIyRUtaTsVztyf3OZ5heUAwKGtPA
         pa8sBOu89LmlY53WJvVE+ZhvOAaqAQ2A7n7QTcKbdL/147mbQETGyf6eUbdNSg8dBp4l
         0gYsGmScTpdAusGEZ94MfU+U9niPKPorICeBjmLdYaBAgCkfC4ByU2/Px9bnAuOkWiDJ
         ekwMH/QSSlsLblqCdTT6ntvrP5CUgRRQKhW4abep6PRPZNIDofCcgqQYyrW5Ry01LPca
         gO2g==
X-Gm-Message-State: AGi0PuYKKKdmscuuxFJl+DxtBgkALig9otBxfk0KiPdiw4pgpluleErR
        ShYZwrFHkAk0eglks+6UiHUfUaqhFEWOo+8mrGr59/jBJUr9WYy834drbfXuHp6oA/KpTRuaY31
        8Cs4075Fh64lCnkbEEWPOSOA2nTURoD3D1g==
X-Received: by 2002:aca:488a:: with SMTP id v132mr16161723oia.166.1587994353354;
        Mon, 27 Apr 2020 06:32:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypK/7DWfUR4RvdmdpQLIe9SKGRJdi3fjHddkMBu5dJ706WHTX/xNlJyrtNePEnp8012Ky/1J1Gb10kQ1VCgiMEY=
X-Received: by 2002:aca:488a:: with SMTP id v132mr16161704oia.166.1587994353145;
 Mon, 27 Apr 2020 06:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200427124935.130432-1-weiyongjun1@huawei.com>
In-Reply-To: <20200427124935.130432-1-weiyongjun1@huawei.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 27 Apr 2020 15:32:22 +0200
Message-ID: <CAFqZXNvWYK4pdcYTH3Zp-4c3K6oeP2D+K2AMRH3jFcN8XgOFoQ@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: fix error return code in cond_read_list()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        SElinux list <selinux@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 27, 2020 at 2:48 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
> Fix to return negative error code -ENOMEM from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Fixes: 60abd3181db2 ("selinux: convert cond_list to array")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  security/selinux/ss/conditional.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 939a74fd8fb4..da94a1b4bfda 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -429,7 +429,7 @@ int cond_read_list(struct policydb *p, void *fp)
>
>         p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
>         if (!p->cond_list)
> -               return rc;
> +               return -ENOMEM;
>
>         rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
>         if (rc)
>
>
>

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

