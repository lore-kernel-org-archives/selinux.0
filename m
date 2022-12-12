Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC68C4332F
	for <selinux@archiver.kernel.org>; Mon, 12 Dec 2022 15:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiLLPF1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Dec 2022 10:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiLLPF0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Dec 2022 10:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E68F13CC3
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 07:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670857467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/OXOfeMVn+cRihijuoBqBAH7X0Oae2hVqmOGTx1G8bo=;
        b=cPq3ONwCGv9iJnbkP1G0FmTotFyM3n1VtQmr9ZvrLNPaQrnk8yrAmhq/DTi+uKCNJDXJ6a
        Ma2MBa08A0OU7v+itPq1zOZa5KLgvjZV/JV3p/DaSvCL4UNORK6wy92jViSPyJ0aBC4o3C
        twVpczZBK9Wc8dTSy4w4fEQhF+fL1As=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-96-Gs0-LGhtNL27OnywLeNCsA-1; Mon, 12 Dec 2022 10:04:26 -0500
X-MC-Unique: Gs0-LGhtNL27OnywLeNCsA-1
Received: by mail-pf1-f197.google.com with SMTP id g13-20020a056a000b8d00b0056e28b15757so38181pfj.1
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 07:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OXOfeMVn+cRihijuoBqBAH7X0Oae2hVqmOGTx1G8bo=;
        b=cEYHIMyWG26CB1JeXOlae8woDR0LyZy6Fy+QaTmbDe00kLKbYF6XcccNYrwwzOUuoO
         5bZY/2T5HtVHm0X8X6D/lV8Q3fOEq/8JMH9nbfnSpTxF9R3sgJcz0xghLkqp7KjfrRdj
         xPZngi4a0joCDeZPk5POM3f10sNuGuyj7oTS8F4ksh5A/TDabegHkuuqLBgE8xyN0HZA
         7VS+SpvSlV/Vs3W04N6fvYciMeliCKH0Q8Btx2swTzNdgyCIEWOu8FBof0aqrWt4l6Lm
         qgcGPR5u7sX6rdl19tcavWBt95C76+gNyADksDHpfnmvCO84GyJ8AsNtKQ9n+WyFjkgb
         tO2w==
X-Gm-Message-State: ANoB5pmdT4nbzxqgeEGyt2pUIv1ldZ9xXeNyHBlLfeBpl1stSHveCzHB
        wV2IKTevjsNVo2zzWaVbwpvRr/kEwhk6DkWW/doIZO53Pijn60UFPeROUWLS3emJ9ZXb138EuOw
        WDVkl94ZgBRxH3R43l5eDqjFbsGeBmMn6zw==
X-Received: by 2002:a17:902:8604:b0:188:d78e:16ec with SMTP id f4-20020a170902860400b00188d78e16ecmr92223359plo.154.1670857465053;
        Mon, 12 Dec 2022 07:04:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf606s/AF2YRMPGcOc4WxnsMzLt0JpF/V4cOMsgHa148FENOscV/B3tBPLcrgLiO5F+gcykHJfRlzP6Js6Qlqk0=
X-Received: by 2002:a17:902:8604:b0:188:d78e:16ec with SMTP id
 f4-20020a170902860400b00188d78e16ecmr92223357plo.154.1670857464737; Mon, 12
 Dec 2022 07:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20221209130220.451845-1-omosnace@redhat.com>
In-Reply-To: <20221209130220.451845-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 12 Dec 2022 16:04:13 +0100
Message-ID: <CAFqZXNvTi-VQkH1VmSuJG0bHttSoFToEbdUM7=CyvsSX8RGw1Q@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: allow user_namespace::create where appropriate
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 9, 2022 at 2:02 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The cap_userns test's helper program needs this new permission for its
> operation - detect the support of it and conditionally add the necessary
> rule.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policy/Makefile           | 4 ++++
>  policy/test_cap_userns.te | 1 +
>  policy/test_global.te     | 4 ++++
>  3 files changed, 9 insertions(+)
>
> diff --git a/policy/Makefile b/policy/Makefile
> index 403802b..f18e15d 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -166,6 +166,10 @@ ifeq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo
>  TARGETS += test_secretmem.te
>  endif
>
> +ifeq ($(shell grep -q user_namespace $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +export M4PARAM += -Duser_namespace_defined
> +endif
> +
>  all: build
>
>  expand_check:
> diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
> index 3e68feb..6f44487 100644
> --- a/policy/test_cap_userns.te
> +++ b/policy/test_cap_userns.te
> @@ -19,5 +19,6 @@ testsuite_domain_type(test_no_cap_userns_t)
>  typeattribute test_no_cap_userns_t capusernsdomain;
>
>  # Rules common to both domains.
> +allow_userns_create(capusernsdomain)
>  # linux >= v5.12 needs setfcap to map UID 0
>  allow capusernsdomain self:capability setfcap;
> diff --git a/policy/test_global.te b/policy/test_global.te
> index 1b20cbc..e95102a 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -171,3 +171,7 @@ ifdef(`lockdown_defined', `allow $1 self:lockdown integrity;')
>  define(`allow_lockdown_confidentiality',
>  ifdef(`lockdown_defined', `allow $1 self:lockdown confidentiality;')
>  )
> +
> +define(`allow_userns_create',
> +ifdef(`user_namespace_defined', `allow $1 self:user_namespace create;')
> +)
> --
> 2.38.1
>

This patch is now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/3389abeaa3bb6fdf23a0f2d8b1550fae69f9c52e

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

