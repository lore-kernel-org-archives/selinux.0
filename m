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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA0C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAB76108E
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhFUVAf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFUVAd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 17:00:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FF6C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:58:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w1so8164195oie.13
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tifbOKd1/s/DwcqUH+MiNJWkNp6quA5S6Ijb256r1ho=;
        b=IBxvk2AGip5OYnc9qyreMrd/wm9fDJchx14HrW/bAzCYvyT+MFPgr3Um5drBvteLtX
         Oinuyu8dhl7iL9nZVgNZSkE6a3GKAqnlZBZskokSbAHwi1ViYwaFedRDOYacuIMUl3j5
         qNeZ+Gf4esri3uY58WlmFvfv8q9Ue3RZjMU2VQrqivuHGHpmXE45EsnUqnFr33iF4kg2
         O1LRvf3r1tvxjhDA7Wg5zQO+d9b3ybXnJY87P3Ir6A31DoUD7+HMKrKXpMndA0yIYmeO
         aQQgBqpvp+G1/mk/BZShgXNpURsKLfk9ztgyoZGkbq1/+fx+mAvCxubCBSJBDfyqsPmg
         rDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tifbOKd1/s/DwcqUH+MiNJWkNp6quA5S6Ijb256r1ho=;
        b=Y4t7XghpxjdA3JDppivpdQGBIpHeBugnhN5QuxLGZOAgFpmuNax0MTFZsKycQuL4uT
         mVdw1oxhw3cAcFasAMR8dLqfdI5M3aLqXyKFNmgYRf22kj2pKwUt9PSar3OPGbau4jf3
         INxZVaMCCNfKRDbDlYdvyUC7vZgEPSH6VuHV3jkL2m+7usiHnj9VVu3RnyjDHquBjWgu
         nHypcODSBdQ7pi7RbolXOiRdAAjAJvzLd1n6d6UoI+W3ORgrsebdJHRPyFmI16vq3bhV
         FW3PLoKODvscViKYARWkCGQrU+RrAuzZ8zC5UoYiD1PL/NSFj3FyYY1EOlR7BlsQCW+V
         mXkw==
X-Gm-Message-State: AOAM53074E48uO34GJMfxH0FefTtyAxocwNKTZio18HXIrInHl5Iyurz
        ImgquKqRfd3XWa0yzSAS+qER7GA77Tp7nSmH72Q=
X-Google-Smtp-Source: ABdhPJyiepwYvbkuIdUi1LmKUrrt7hY1YNxVPabKFWrEwS1NN0g+ImzZMVeUTOt+SyoW0LshrM2lhgISfN5Xkwk1hK4=
X-Received: by 2002:aca:30d1:: with SMTP id w200mr456763oiw.16.1624309098013;
 Mon, 21 Jun 2021 13:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-7-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-7-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:58:07 -0400
Message-ID: <CAP+JOzSEXJ16NOwVqz-S0xaJUqmki4M8hH=-W_FtE+B87tvy=w@mail.gmail.com>
Subject: Re: [PATCH 06/23] libsepol: avoid unsigned integer overflow
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Unsigned integer overflow is well-defined and not undefined behavior.
> But it is still useful to enable undefined behavior sanitizer checks on
> unsigned arithmetic to detect possible issues on counters or variables
> with similar purpose.
>
> Use a spaceship operator like comparison instead of subtraction.
>
> Modern compilers will generate a single comparison instruction instead
> of actually perform the subtraction.
>
> policydb.c:826:17: runtime error: unsigned integer overflow: 24 - 1699 ca=
nnot be represented in type 'unsigned int'
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index cbe0c432..3389a943 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -823,11 +823,11 @@ static int filenametr_cmp(hashtab_t h __attribute__=
 ((unused)),
>         const filename_trans_key_t *ft2 =3D (const filename_trans_key_t *=
)k2;
>         int v;
>
> -       v =3D ft1->ttype - ft2->ttype;
> +       v =3D (ft1->ttype > ft2->ttype) - (ft1->ttype < ft2->ttype);
>         if (v)
>                 return v;
>
> -       v =3D ft1->tclass - ft2->tclass;
> +       v =3D (ft1->tclass > ft2->tclass) - (ft1->tclass < ft2->tclass);
>         if (v)
>                 return v;
>
> --
> 2.32.0
>
