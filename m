Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2010CC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A4A20989
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 21:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq7Xq7CZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfEJVAq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 17:00:46 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45226 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfEJVAq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 17:00:46 -0400
Received: by mail-oi1-f170.google.com with SMTP id w144so1447oie.12
        for <selinux@vger.kernel.org>; Fri, 10 May 2019 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lsrVRqWfcosb7A0+U5s126NHybxex/1aAr3BeIs1vOo=;
        b=oq7Xq7CZFbXX673DJEzobkjX91jg58tHqXu+rY9jxtzMHFb+draRhas8HbngZ83o1x
         XYxnvF+tYnFN8QcNugqMBtZtg9jfT9+0QLrm9u8ejMl2t1Y/J8nVx+zl0lOcPszGW5Ip
         VZsQcSxrEkDtItQUnBe4egDeecSx9HWDNse1xsM3oZdOpyROfeJEY+vJ/5ix/BuIrxkF
         grLe+ourtshwt0vnbhn5dbIAh93LkKdXL9+CwYWL0i0wFIoq7O7ZZJ55lC4xG1kObu87
         7f1lt8lHm5yXPkpM+xJVxCS0Vn/Gc7/pSTLQZDeH0Y9KaAU5Q+yp7YM8rvLYxn5X+ABJ
         DOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lsrVRqWfcosb7A0+U5s126NHybxex/1aAr3BeIs1vOo=;
        b=p+W8DQMMkELv5AhYe0Y3cSrLRnzLAOgpDRuoWG7k2wvK+iVKKcEU5Xn6DW5y23CNSf
         YdyXBVkSpsSoWOD8SW5w36Pf4IFJ7Xl6EzGensS1fX/aHA5Zbn84WkK/ugKISIvVGD4P
         0a+zO14pDkhwFB0QSMj8fSEwB4eCLMazLz5357/CPoEovkSQ4dZ9jiuI+TFlQu4ye5d4
         dyNFspZg0G+/3VbzyJHXrpDSMu5nnq2IN0Yy9XU4IJ6JqYfYq9S+s9KfWnEoOAGDObYa
         6X3Zup+wibprMNzEPDY2zM5LS3B5in6C1YS/FpLMPqMoFuLg8VcHFDsK4PvDMARip49k
         0Bbg==
X-Gm-Message-State: APjAAAWy6T41jftW89ic/Iru63eEtFfY3SwRKv3x3rmmQddBhIWM7kkG
        WhOkRbWM9wWKH4YaRcGCBxaR6wmPNXFyExWla8Q=
X-Google-Smtp-Source: APXvYqwBlaJEAsrYxbRO0y20wCry/7uLRLNfwBmXxN4/5lL6ui1W7d3zKnAmrfcdi+An96TCRbVot4aPq0ZehATmbOY=
X-Received: by 2002:aca:bb88:: with SMTP id l130mr5963778oif.124.1557522045499;
 Fri, 10 May 2019 14:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1905102118010.16225@34-41-5D-CA-59-C7>
In-Reply-To: <alpine.LFD.2.21.1905102118010.16225@34-41-5D-CA-59-C7>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 10 May 2019 14:00:34 -0700
Message-ID: <CAFftDdrJKk9p-Watf2M7ptMo=1L0TiEKci=LitfjqsNmkyTUMQ@mail.gmail.com>
Subject: Re: [PATCH] Check strdup() failure
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 10, 2019 at 12:04 PM Jokke H=C3=A4m=C3=A4l=C3=A4inen
<jokke.hamalainen@kolttonen.fi> wrote:
>
>
>
> ---
>  libselinux/utils/getconlist.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.=
c
> index 5ac0ca85..29c16640 100644
> --- a/libselinux/utils/getconlist.c
> +++ b/libselinux/utils/getconlist.c
> @@ -27,6 +27,11 @@ int main(int argc, char **argv)
>                 switch (opt) {
>                 case 'l':
>                         level =3D strdup(optarg);
> +                       if (!level) {
> +                               fprintf(stderr, "memory allocation failur=
e: %d(%s)\n",
> +                                       errno, strerror(errno));
> +                               return 3;
> +                       }
>                         break;
>                 default:
>                         usage(argv[0], "invalid option", 1);
> --
> 2.21.0
>

ack
