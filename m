Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199EDC433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 20:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhLIUew (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhLIUev (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 15:34:51 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1442FC061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 12:31:18 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so7478119otj.7
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 12:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BBk9bJ4tZ6Q2cj+trV6cJACDNU3cf3hi5f4jsKPyY+s=;
        b=EfpyY97Rhp+JnCiO0ASyRB9zvRGC3sxIUtgqi6rvAVX2WnK27QglLJf/rtWnKcogUk
         /kitQ1h2HI3fcPMW252dZ432sTIF2viQliN7qKA1Br1jf8KSsojQ0vXJNLnqg28Li2Zi
         rXn/DgrruU5zCE5BZGfvkUhmTJ8s/DJ0w+WmWlY381e4smSSTeRwislGT1MD07KDpSrM
         6k41JerK+UUC10KyPBLvKU+l7W8hjgKVdu/YxiKM94XrQVvchoe61o+z4vMuAQIK7a+O
         NlHrQMIq+RmJFPdXj/6SYlnioWKxwXxhW7UB9wUdlc6m1g2pZsZFMMuUZ0GWwmyuMXXX
         QX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BBk9bJ4tZ6Q2cj+trV6cJACDNU3cf3hi5f4jsKPyY+s=;
        b=SN1mOPMrvWMIFL+/h9sbc2UiYq4LzeEuHq0A3/maSQ8Pbz3TSn5E4i9CC4MU5EPBZK
         RzyRk6yknC/vLlfME/meswB9C6q8oc5gKW8aFE+RJyYNQXw5up8aXzfwmDLtDxVtbDZv
         vhDaq1wIQgrcdj5M3Q6MVcLjBGjt4Ovw0XCm04hTUTIeAJ00It4s+Vo5icae2zH/GZjW
         XqcGiVPMPZv2HOMaiN05ouNCNYqyoPyXSo/zFjxuWKhhNNH5dqjfEJrD8Yt1aqtLor/N
         nlpC/z5RDLPDvnH5tyoPjyn9ECINtXTb6u3j0XA1oUNGBqs1RkBV2ZnzOqz1gSdkzhh/
         8PiA==
X-Gm-Message-State: AOAM533LMMR9fncRKpjhrQBXFLNTu5OrOOTbP1mIYrlNEY/qtoABOQKn
        4FOcQvgXJZosibsRWngpU+g719044eyoDXpDVxu1IQGShlI=
X-Google-Smtp-Source: ABdhPJzM4wtM0sO0HRH7WoRtKekrZE44P1M26LdKvsvzlNs4p9OMX0qpEyReYBEbzFC2egExB4oHAMdjBAcbqQH7PwI=
X-Received: by 2002:a9d:685:: with SMTP id 5mr7569086otx.53.1639081877467;
 Thu, 09 Dec 2021 12:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20211130110034.12920-1-cgzones@googlemail.com> <20211130110034.12920-2-cgzones@googlemail.com>
In-Reply-To: <20211130110034.12920-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Dec 2021 15:31:06 -0500
Message-ID: <CAP+JOzTzU6gV0pP66URtnnoEURvpwdYA8BvqwqW8jfMfQAs-4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpolicy: warn on bogus IP address or netmask in
 nodecon statement
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 30, 2021 at 4:50 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Warn if the netmask is not contiguous or the address has host bits set,
> e.g.:
>
>     127.0.0.0 255.255.245.0
>     127.0.0.1 255.255.255.0
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 50 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index d3eb6111..b2ae3263 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5290,6 +5290,14 @@ int define_ipv4_node_context()
>                 goto out;
>         }
>
> +       if (mask.s_addr !=3D 0 && ((~mask.s_addr + 1) & ~mask.s_addr) !=
=3D 0) {
> +               yywarn("ipv4 mask is not contiguous");
> +       }
> +
> +       if ((~mask.s_addr & addr.s_addr) !=3D 0) {
> +               yywarn("host bits in ipv4 address set");
> +       }
> +
>         newc =3D malloc(sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
> @@ -5325,6 +5333,40 @@ out:
>         return rc;
>  }
>
> +static int ipv6_is_mask_contiguous(const struct in6_addr *mask)
> +{
> +       int filled =3D 1;
> +       unsigned i;
> +
> +       for (i =3D 0; i < 16; i++) {
> +               if ((((~mask->s6_addr[i] & 0xFF) + 1) & (~mask->s6_addr[i=
] & 0xFF)) !=3D 0) {
> +                       return 0;
> +               }
> +               if (!filled && mask->s6_addr[i] !=3D 0) {
> +                       return 0;
> +               }
> +
> +               if (filled && mask->s6_addr[i] !=3D 0xFF) {
> +                       filled =3D 0;
> +               }
> +       }
> +
> +       return 1;
> +}
> +
> +static int ipv6_has_host_bits_set(const struct in6_addr *addr, const str=
uct in6_addr *mask)
> +{
> +       unsigned i;
> +
> +       for (i =3D 0; i < 16; i++) {
> +               if ((addr->s6_addr[i] & ~mask->s6_addr[i]) !=3D 0) {
> +                       return 1;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  int define_ipv6_node_context(void)
>  {
>         char *id;
> @@ -5376,6 +5418,14 @@ int define_ipv6_node_context(void)
>                 goto out;
>         }
>
> +       if (!ipv6_is_mask_contiguous(&mask)) {
> +               yywarn("ipv6 mask is not contiguous");
> +       }
> +
> +       if (ipv6_has_host_bits_set(&addr, &mask)) {
> +               yywarn("host bits in ipv6 address set");
> +       }
> +
>         newc =3D malloc(sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
> --
> 2.34.1
>
