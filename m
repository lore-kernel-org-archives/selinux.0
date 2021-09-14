Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD04C433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 19:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501C360F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 19:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhINTq5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbhINTq4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 15:46:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E3BC061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 12:45:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w19so754114oik.10
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LYvtm4EcpP5lbl0jlkPLx1l1wKiz5iNuQRo5sW4+u64=;
        b=S2qn84d2ePWLjTrF6YNvTXrcurWRsb6/ELgipVWKxPpoyvX4uKThOQvEyv0hGMKj4c
         25XT5Zf90cOBUITfiGN5Mdu0fRcIE8rs2LGk/LVRo2dsciP/jUQ1Z2bu0tvfN5tXTTbT
         CH4clNhi8KUg44lyytZHCSJALAclOG3kIBjgQPhHV0NEVcW3gTNtghq+Bo3LO1t+HEqQ
         NF71yntQxnOzT/3ZQGOtkxAElVuoxLX0qd7PC3yXTYaic/XRGwCty6g46EH8lyAgchkR
         CVc6ozwbAZkaIGXTQYEHp5nbbztZKn34qwRU/TLxmV5eF+0agZ9BStcm/9713JccfzPO
         kWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LYvtm4EcpP5lbl0jlkPLx1l1wKiz5iNuQRo5sW4+u64=;
        b=uC5q2FbNhzhCjkysNUaNeDxyB0OLR9OdgRFeV9WjYKSx2MrrGfXwUfGNjXHIkFULfK
         rY7Jij33lDtDeFFdoIvJ+Ucx7NP3x9o5FOrXDYr33/uIhHsXtPNo3ojm7bgIvGg2XHf2
         cuu7ewFN8saMNiEK3zhhz93QwzSpp06guSjndAzRV5gIBvmSrRiTv7CpvTDGw5sykWGU
         9mzAkH93z6TXWMpMCjboG6btb6ZXVfxRLtnGWTEF0uEZecesCsoKx1Je+jsDemy1H/mJ
         XhGr8aqQXMcjlgt7LxjGOcbUyxgyEFOXRpSrnHntZP7sABOsI6J1ZRtJb6BEQsXg2pIJ
         LNdw==
X-Gm-Message-State: AOAM533y39ia3yoLHyjCyyWg8AZ9Nih4qRX9De5UtWGyA2KcshofZTI3
        ONmb2yUlekGPRsFB0ibwkkWVNN05JFREB6EDhmA=
X-Google-Smtp-Source: ABdhPJyZZlR/+shhBhvF6EgiMOA7HGw46i8SSstJlUW+t1W33sjMSTWtF/hsRVGRg8HvHpUBvJzRMwieIcgl9pYW/ok=
X-Received: by 2002:aca:f189:: with SMTP id p131mr2816748oih.128.1631648738230;
 Tue, 14 Sep 2021 12:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210914124828.19488-1-cgzones@googlemail.com> <20210914124828.19488-10-cgzones@googlemail.com>
In-Reply-To: <20210914124828.19488-10-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 14 Sep 2021 15:45:27 -0400
Message-ID: <CAP+JOzTVpNXsTMvMC2bY9x9M54VzCYYD+vLLRA83s=xp4B=6hg@mail.gmail.com>
Subject: Re: [PATCH 09/13] checkpolicy: resolve dismod memory leaks
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 14, 2021 at 8:51 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Example leak:
>
>     Indirect leak of 4 byte(s) in 1 object(s) allocated from:
>         #0 0x49bacd in __interceptor_malloc (./checkpolicy/test/dismod+0x=
49bacd)
>         #1 0x58ae54 in add_i_to_a ./libsepol/src/util.c:55:21
>         #2 0x53ea8e in symtab_insert ./libsepol/src/policydb.c:1729:6
>         #3 0x536252 in roles_init ./libsepol/src/policydb.c:772:7
>         #4 0x536252 in policydb_init ./libsepol/src/policydb.c:892:7
>         #5 0x562ff1 in sepol_policydb_create ./libsepol/src/policydb_publ=
ic.c:69:6
>         #6 0x521a7c in module_package_init ./libsepol/src/module.c:96:6
>         #7 0x521a7c in sepol_module_package_create ./libsepol/src/module.=
c:126:7
>         #8 0x4cfb80 in read_policy ./checkpolicy/test/dismod.c:750:7
>         #9 0x4cda10 in main ./checkpolicy/test/dismod.c:878:6
>         #10 0x7f8538d01e49 in __libc_start_main csu/../csu/libc-start.c:3=
14:16
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/test/dismod.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index 90c29318..9550b999 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -751,12 +751,15 @@ static int read_policy(char *filename, policydb_t *=
 policy)
>                         fprintf(stderr, "%s:  Out of memory!\n", __FUNCTI=
ON__);
>                         exit(1);
>                 }
> +               policydb_destroy((policydb_t *) package->policy);
> +               free(package->policy);

Should use "sepol_policydb_free(package->policy)" here. It does both
of these lines.
Jim


>                 package->policy =3D (sepol_policydb_t *) policy;
>                 package->file_contexts =3D NULL;
>                 retval =3D
>                     sepol_module_package_read(package,
>                                               (sepol_policy_file_t *) & f=
, 1);
> -               free(package->file_contexts);
> +               package->policy =3D NULL;
> +               sepol_module_package_free(package);
>         } else {
>                 if (policydb_init(policy)) {
>                         fprintf(stderr, "%s:  Out of memory!\n", __FUNCTI=
ON__);
> --
> 2.33.0
>
