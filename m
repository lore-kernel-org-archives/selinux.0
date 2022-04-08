Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB16AC433F5
	for <selinux@archiver.kernel.org>; Fri,  8 Apr 2022 14:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiDHOHP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiDHOHP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Apr 2022 10:07:15 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9481777E6
        for <selinux@vger.kernel.org>; Fri,  8 Apr 2022 07:05:12 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id y7-20020a4a9807000000b003296ea2104eso1485410ooi.13
        for <selinux@vger.kernel.org>; Fri, 08 Apr 2022 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ksq+UhoRtqlR+LvhOaletvBIpfQlf75LcjHO2AegTs4=;
        b=bGwLhZyGV7MtyhbfwLqnlplcCI6rax4iEvbakJLxDBD1PdhmQ+qV17Z0Se519GSr4A
         a7bASWm139GMV6KKQveq8QPoV/e6iyNHtUELDSfihgraYy5xW9CP+4a0HsFGWDKdvLV4
         qDbDsZM6/XxSswxn/ufKLEBTGscDCwd8+9z8Pn0GjnQJB1j+7SH8soKnyOrgPHhs3hKH
         yGu2AyY/iH8fLq0DDkAym/5z1Y2JrBXl0aj0emoar2pq8jHqK9QbpgzmQvv6MSUCxxGu
         GJ9ISOHJrIPgop9Ti9hoGjrb9YLbo7k/dgrCjZxsGGJgISDBAzhMKVoVqlUQ8XjtWrzU
         P46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Ksq+UhoRtqlR+LvhOaletvBIpfQlf75LcjHO2AegTs4=;
        b=umCP93TyFP9/nW+zdqwZpHpiShhJ7B18uKOvz4cS4EjEcgOffW1ais8Ac2GoINYNc+
         PglpaVwMpHJKwOn6xQgZOz22q/LydKCkK2yDuOXzbC15k3tYMblLShYga7XOEydTcwr2
         rZJ34qaCV0D84PvWyh/Z2VYoKrg2i4HPrmamFK/IWnjyvxQ3XsYWAwPtWCnhPNiq3B7b
         2O7f5znaixQCmx1mbbryscXqN04+JcElN0SUTtO/BZ/mnW3zAssG8C09Nt0DFr+yL4ez
         MDAgziwuOvD5fQBNYMw4nNcMRz0Dsxq2Zv/gdK2R+Hi/0vHJpH0DB6BlfWgRFyu/fe3I
         Y04w==
X-Gm-Message-State: AOAM533UDyDuK++ufP/RpZcD+QAtlmyuBBscIe+IgWPC4EhdjtGIQ442
        L/D/6SnDWyrj6Rsx8ou2x4KwhRQmNQA/90OxKgrLdfBOn+8=
X-Google-Smtp-Source: ABdhPJylAOq50VchJYpFZeQXGSObWgflCehmT9TLtvZey4SCAXXa1AuNrCJ1UvPPzqS6HBM39u5Eov7WGp4RTOLqkjY=
X-Received: by 2002:a4a:d254:0:b0:324:b1bf:da28 with SMTP id
 e20-20020a4ad254000000b00324b1bfda28mr6074989oos.49.1649426710701; Fri, 08
 Apr 2022 07:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220408131054.7957-1-cgzones@googlemail.com> <20220408131054.7957-4-cgzones@googlemail.com>
In-Reply-To: <20220408131054.7957-4-cgzones@googlemail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 8 Apr 2022 16:04:59 +0200
Message-ID: <CAJ2a_De0_jQw_aTnzNKmx+bLR=37t2tSAVuiMH1uLk+Q9oSXDQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] libselinux: limit has buffer size
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 8 Apr 2022 at 15:10, Christian G=C3=B6ttsche <cgzones@googlemail.co=
m> wrote:
>
> The `struct selabel_digest` member `hashbuf_size` is used to compute
> hashes via `Sha1Update()`, which takes uint32_t as length parameter
> type.  Use that same type for `hashbuf_size` to avoid potential value
> truncations, as the overflow check in `digest_add_specfile()` on
> `hashbuf_size` is based on it.
>
>     label_support.c: In function =E2=80=98digest_gen_hash=E2=80=99:
>     label_support.c:125:53: warning: conversion from =E2=80=98size_t=E2=
=80=99 {aka =E2=80=98long unsigned int=E2=80=99} to =E2=80=98uint32_t=E2=80=
=99 {aka =E2=80=98unsigned int=E2=80=99} may change value [-Wconversion]
>       125 |         Sha1Update(&context, digest->hashbuf, digest->hashbuf=
_size);
>           |                                               ~~~~~~^~~~~~~~~=
~~~~~

An alternative would be to split the `Sha1Update()` call[1] into
multiple, each for a maximum of UINT32_MAX bytes.

[1]: https://github.com/SELinuxProject/selinux/blob/73562de8fc70b21aeb6be86=
dfdfddb7502d236ea/libselinux/src/label_support.c#L125


> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/label_internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_inter=
nal.h
> index 782c6aa8..82a762f7 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -57,7 +57,7 @@ int selabel_service_init(struct selabel_handle *rec,
>  struct selabel_digest {
>         unsigned char *digest;  /* SHA1 digest of specfiles */
>         unsigned char *hashbuf; /* buffer to hold specfiles */
> -       size_t hashbuf_size;    /* buffer size */
> +       uint32_t hashbuf_size;  /* buffer size */
>         size_t specfile_cnt;    /* how many specfiles processed */
>         char **specfile_list;   /* and their names */
>  };
> --
> 2.35.1
>
