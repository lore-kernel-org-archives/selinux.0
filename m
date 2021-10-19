Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19269C433F5
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 20:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD1460E0C
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 20:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJSUxv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 16:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230454AbhJSUxu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 16:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634676697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2phsEaXgjaE8oBL/TwtDuajLetX9YDuRZ6lJrrONWUA=;
        b=J4JT7w+i6a6okWnqsr5VF7njocuoWsjU6pGRkC6FWcQRzzIQqByItmUGE+npucMo5ByVxT
        Zogb5coOIFDZh/3ekD6LzPBN48bem8RkIzSC+vWOcc92mzzszvWGeHMP44a/+Y41JDxgNK
        CbGNvfkfmxG2pD433kmT1cGCoEeYy+s=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-5pmfh5O7OES0Av4nDfPcNg-1; Tue, 19 Oct 2021 16:51:36 -0400
X-MC-Unique: 5pmfh5O7OES0Av4nDfPcNg-1
Received: by mail-yb1-f197.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so26862230ybb.4
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 13:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2phsEaXgjaE8oBL/TwtDuajLetX9YDuRZ6lJrrONWUA=;
        b=ZctUcm7Jcv+NI0nCPZq3WKCG9kk8IOV+9KLGCAhW7nf/0ILKh4RzBpXiGHpbRt37Sv
         w4UsykMrNIg1UjXoB4fWdLAoyUpD7ZBNoKVwauhxStydJ3NabC1k0Yd5PEa+Vikyz4a7
         rLjsLbUgqxGhxlvwa6FegFRRzphLF1/H/IGDE5kn9OIggXfcy+/phLaasBGGxaXAJQYw
         w0FMcbZOXlAhqi7MOySFsqLnvD5LUP2DfycH63Auo7pfqD5GYnx4AmFJWEeibXsj0xKj
         Kh+8bwbzt/RnOmFW4puPl8Of/nIGwUA6O2JuonWWlu7mOOXsFDr8pu4ba03HU4vnJhHA
         qY0Q==
X-Gm-Message-State: AOAM532S/cfxo46FMczL0hUS1p8v8xzzWZ+7/SaFwWf7j8UHnhb7TUoi
        3DiBefxP/YcNMUTogrfArbYyClXgsZRYs5KFwwV1/WZi/BSFOa0NvZV7j9NebANZjzdHkMS/iU8
        Ide2TBTbwTmbyL0loWqz9Qgm0kRxnM9IUfQ==
X-Received: by 2002:a25:c0d2:: with SMTP id c201mr21167153ybf.467.1634676695269;
        Tue, 19 Oct 2021 13:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx0NhUbyr279eyt974z42BcFLHazX5e6kBBfVHUHm554SSf8O1hEI841GUdsKexrN/FyI9OLdSFtk7ll7hTco=
X-Received: by 2002:a25:c0d2:: with SMTP id c201mr21167128ybf.467.1634676694973;
 Tue, 19 Oct 2021 13:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <163466736648.20044.16531188246866586566.stgit@olly>
In-Reply-To: <163466736648.20044.16531188246866586566.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 19 Oct 2021 22:51:23 +0200
Message-ID: <CAFqZXNtT0utx5qpcZ9KpvtTsVx5sfiXCQxdHCo1Dy5ue1MQ6gQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix a sock regression in selinux_ip_postroute_compat()
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 19, 2021 at 8:16 PM Paul Moore <paul@paul-moore.com> wrote:
> Unfortunately we can't rely on nf_hook_state->sk being the proper
> originating socket so revert to using skb_to_full_sk(skb).
>
> Fixes: 1d1e1ded1356 ("1d1e1ded13568be81a0e19d228e310a48997bec8")

This doesn't seem right :)

> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b4a1bde20261..6f08cd2fc6a8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5778,9 +5778,9 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
>         struct lsm_network_audit net = {0,};
>         u8 proto;
>
> -       if (state->sk == NULL)
> -               return NF_ACCEPT;
>         sk = skb_to_full_sk(skb);
> +       if (sk == NULL)
> +               return NF_ACCEPT;
>         sksec = sk->sk_security;
>
>         ad.type = LSM_AUDIT_DATA_NET;
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

