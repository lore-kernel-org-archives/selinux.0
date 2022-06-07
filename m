Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A8FC43334
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 14:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbiFGORp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiFGORn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 10:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6082A4E387
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654611460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Xvw9zM8tcEvE1WoBgoY8ZX/lW3NrMqoIBLsn907tUs=;
        b=VfbzqFjVXEv4qxOBpZEZmRAs2/7rkdoePpfEy4Y+j4+b8uygtcRcv3BugOAQ3JzYsvO7Ou
        vGg0pvGEpQgNqtM9oDHADl93fVsKZXG3QAwvXd9OgkKBO1SilRwB0wdSlBTENHLHjZJI1t
        r+Dp+7g8TsEaGj46Eoz7RC7N2h/bPZs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-MeARbYAfNDm2ufEIM-Y2Og-1; Tue, 07 Jun 2022 10:17:38 -0400
X-MC-Unique: MeARbYAfNDm2ufEIM-Y2Og-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-30974094b5cso149360997b3.20
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 07:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Xvw9zM8tcEvE1WoBgoY8ZX/lW3NrMqoIBLsn907tUs=;
        b=2MeIx8W5jJ9e5+xuGz3URsoXKINRe+GGdO+Ten1+MDBAV7x3J/XMVzDElCqRlp+9oM
         mN2DVrIR1AGpoU9+l/QMfiKVN+2fj8W9+mj5bBWDmoksn2pd7Dxfe5Yv+SWPwfmcrZEB
         sfbZmv2S/VjyZMs5xiAHM/L5rPgfoH53R/Pmf90Gv09T/te77fqXA3YGkfBEO73meBwu
         cQFNE47DFKkIrn14VnUcDslcWCzcbmHzAQJxAqLaloe+NERVG5P71mMDWMc+waVkbE46
         H1yjPT1/iBf2rl8lN6R9ZQfdtDWF25Lop7td3Otb6VntIcxqX/yoHIj1GFbfG4kl0BVA
         dIzA==
X-Gm-Message-State: AOAM533TSLkc9BrxXB9CdA6CIv8ezZHgFYlnneIq3S3b8fCJqEC8CGOM
        ElUSrDMqJAmaT4LN+HNN2Vfkxs+WLVf4/iI6NENbBoTjVNYEM7efNO78hjSHKvqyvnRO331PHYa
        Gu8B+vP+nb79o3UEPkcwsmKp4L8haoIBb2w==
X-Received: by 2002:a81:a50c:0:b0:30c:1f68:a375 with SMTP id u12-20020a81a50c000000b0030c1f68a375mr30797091ywg.106.1654611451602;
        Tue, 07 Jun 2022 07:17:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2+2FPvcX7rYJi7jsZI+iJ23F5aWSwZUu5vjgtqKkcp+fy/ypTgMaAq5yeNnQgQpGuPLzfzOv+Vwpdr+hskAw=
X-Received: by 2002:a81:a50c:0:b0:30c:1f68:a375 with SMTP id
 u12-20020a81a50c000000b0030c1f68a375mr30797074ywg.106.1654611451419; Tue, 07
 Jun 2022 07:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220602145312.888125-1-omosnace@redhat.com>
In-Reply-To: <20220602145312.888125-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 7 Jun 2022 16:17:21 +0200
Message-ID: <CAFqZXNtYPm86gcY23ixAhQxVqNUm+TYtpU65JaA6Ea_TLMpp+g@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/sctp: temporarily disable ASCONF tests
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 2, 2022 at 4:53 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The implementation is buggy and can't be reliably tested right now, so
> disable the tests until the kernel is fixed and tests updated.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/sctp/test | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tests/sctp/test b/tests/sctp/test
> index 7e84ab0..e28d214 100755
> --- a/tests/sctp/test
> +++ b/tests/sctp/test
> @@ -57,8 +57,11 @@ BEGIN {
>          }
>
>          if ( $ipaddress[1] ne 0 and $ipaddress[0] ne $ipaddress[1] ) {
> -            $test_count += 3;
> -            $test_asconf = 1;
> +
> +# Disable ASCONF tests for now due to a known issue:
> +# https://lore.kernel.org/selinux/CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com/T/
> +#$test_count += 3;
> +#$test_asconf = 1;
>          }
>
>          # SCTP client peeloff has been fixed in kernel 5.18+
> --
> 2.36.1

Merged as:
https://github.com/SELinuxProject/selinux-testsuite/commit/3e93ece73da162fe58f9ec7d16b01915a4568c11

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

