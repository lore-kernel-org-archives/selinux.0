Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57980C433FE
	for <selinux@archiver.kernel.org>; Tue,  8 Nov 2022 19:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKHTPO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKHTPK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Nov 2022 14:15:10 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4955E9DF
        for <selinux@vger.kernel.org>; Tue,  8 Nov 2022 11:15:08 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r12so22582883lfp.1
        for <selinux@vger.kernel.org>; Tue, 08 Nov 2022 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFZEot0nGNkb5ofYpSsxr4/l0l3nLoiUYIGsJUGdJPk=;
        b=atDNc+u0v7LyxvhvO4L9xyRfINDY8UYcyQFfY0iYHgB1eYuZ1iYPVYz10qVtNO85s+
         ecLczBVDGV7fHUOxZ2xdYwT48zFnl1a5MOYPOEqLaht7I5688fep30hMoWAduwOuoNI8
         JjBWzMSndLd2kjL0B2cRVSRf1qzflPHhBFZXm96P2x5UxuSumzUJ3rWs3wBQay1YKRGx
         ettSFqLBUt6fhik06Wfr5S2rv1IS4FcE1GPmp/p1EmmVnbPo7ti0GGqmfpubwIbZz5wS
         Q/lorstMlhkI72pBssqKa8VSPjb1Vgw0eKAyXZbGJCrk9YrO1Q9m79zj6T1h9nrI1W9A
         dR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFZEot0nGNkb5ofYpSsxr4/l0l3nLoiUYIGsJUGdJPk=;
        b=Q5UE1HKDNQiHrX0Zx9NIL1XkuDcjwBooPK0GOw0f8xSRaJtUP4SXWGG7CxCf2mIG0y
         zgXoDogJsfsXB5hEgg5xlyRDHLN0UyzMhAaV6GnJm+0Qv6tyNhOoKAo/ZmYTDC4eXQAg
         hClEswxNMocL8s6KVhuY/GuS3x5y3A5veqeOc37DetOknm6d+y9FdLqArCgUY3/YmSkn
         jxENi1+1kCzBKkwUKton7vxuULrh/PMo7qOK1e5uDFJN6WjqasD2CrKp7W0u+XBdNa9H
         boyCzqVboH6MHSMY3Gp12P7aKost4pzHCVW5CUvw9K+hfBSzpmJ55DHy3Jp4/wT8y0q/
         TSBA==
X-Gm-Message-State: ACrzQf1DD43barPdN+IS+7OakgVBYvTLhB6TF1EC62C4wJygi7Hg8EXI
        E9hKGG4Evy05OTi5MTpAuA9jU0aG29RtXUbFoz0=
X-Google-Smtp-Source: AMsMyM6P2Kzd9a8aUSdKmqTna7wo/vkDXn7E7/hqq0hNeQpkgdQAVdAP5nZWEJxYJK9R90SKxNRDNwO7hRit/2pq7NQ=
X-Received: by 2002:a19:791b:0:b0:4b0:ab95:f07 with SMTP id
 u27-20020a19791b000000b004b0ab950f07mr18310199lfc.30.1667934907135; Tue, 08
 Nov 2022 11:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20221024091354.2253669-1-tweek@google.com>
In-Reply-To: <20221024091354.2253669-1-tweek@google.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 8 Nov 2022 14:14:55 -0500
Message-ID: <CAP+JOzR6Y-emY+WUZN=wB2QLG_=CdMgO2EjY=9iHCqZmy+wHfA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: ignore invalid class name lookup
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 24, 2022 at 5:14 AM Thi=C3=A9baud Weksteen <tweek@google.com> w=
rote:
>
> selinux_check_access relies on string_to_security_class to resolve the
> class index from its char* argument. There is no input validation done
> on the string provided. It is possible to supply an argument containing
> trailing backslashes (i.e., "sock_file//////") so that the paths built
> in discover_class get truncated. The processing will then reference the
> same permission file multiple time (e.g., perms/watch_reads will be
> truncated to perms/watch). This will leak the memory allocated when
> strdup'ing the permission name. The discover_class_cache will end up in
> an invalid state (but not corrupted).
>
> Ensure that the class provided does not contain any path separator.
>
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/stringrep.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> index 2fe69f43..592410e5 100644
> --- a/libselinux/src/stringrep.c
> +++ b/libselinux/src/stringrep.c
> @@ -63,6 +63,9 @@ static struct discover_class_node * discover_class(cons=
t char *s)
>                 return NULL;
>         }
>
> +       if (strchr(s, '/') !=3D NULL)
> +               return NULL;
> +
>         /* allocate a node */
>         node =3D malloc(sizeof(struct discover_class_node));
>         if (node =3D=3D NULL)
> --
> 2.38.0.135.g90850a2211-goog
>
