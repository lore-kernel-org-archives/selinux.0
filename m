Return-Path: <SRS0=v7Ke=42=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F6AC10F27
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 13:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D938721D7E
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 13:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGgNwVvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgCINPq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:15:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32980 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCINPq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 09:15:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id q81so10093125oig.0
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2020 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UC+8usVzqAv4MCQX3BaH38pS74LzmtsNIixG29J6ld0=;
        b=RGgNwVvoxi0//SFQ7lHbHJyw1Qrl0vsmJNFcQ8DXRPKakG9qcvSh5BTIywrFcb73hO
         PD2ovtzIOlGZoJGid+pJKNrqoOiNJJ4D+qxpbgYpcEod560BcBn/AkwQaznlZ8eBaiRh
         enDmDDMANlsU8RKMdqt5rtQVGDb4nnOF9KzbcihO6Y73rvSyjyrxcRJEm4vNYjPt5fvm
         csT10+n41f7wdtS8Fg1OU6xWS/FXGcigy1VoIofxiJcFXUrdTydFNllbcVTXOPcZuBJp
         n5cjCC+zaVij6HpJzTAc3r1IVcndj2coZDRIfJJ9KK+Jg1lMPEKjB1h5JaYYW1Xuv9Nb
         /T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UC+8usVzqAv4MCQX3BaH38pS74LzmtsNIixG29J6ld0=;
        b=OzY8qQx69bQducS1NJOLOOG4gnSct3L5Xr8c7y8bGTJHXZZPp019hZ3ZwHUIQjN63D
         p194zSPIGmJ8ZjPdavLr2xPzoRMGO6vz3p/1GHBxYBaXzvFeGRkzFHr6C0+d7S8fMtCR
         KpTMZqmhuGxSX8re1Du/o0yedkJ47NVv9LKWwuqceExAmAQjUpcGFBB3j2aMSesYZz/N
         dYwJGmiN2AK8RfAmX4Qepdhas79VdVTp9xy/booq35hPLhmRy7WsdteH4FN7Q8LB+LVF
         +xrIBvbxnVDdWrMzoJTU4Lwg3Xi+Ikn0ew0EUvrHpUWjCir2bIi6DJCQCiyMsKJycSCR
         QJGg==
X-Gm-Message-State: ANhLgQ24FogZsIY/gu1UzwLT9mQRVKizjdGUXCTQhODZ9IheZ0E1/LtG
        SA4a6yLgR4OeXys1SoVp7xR6Fwmv8909Wkr94tw=
X-Google-Smtp-Source: ADFU+vsWcp4B/cDuUw0NJREsxtTDfbhlTaDqLJqTEVXZJc3nFANbgubT7FEZsUHv7E26OMjiVv4ZR7mo21Mf16pzZnU=
X-Received: by 2002:aca:4b57:: with SMTP id y84mr11482975oia.16.1583759745677;
 Mon, 09 Mar 2020 06:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200305135337.113248-1-omosnace@redhat.com>
In-Reply-To: <20200305135337.113248-1-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 9 Mar 2020 09:17:11 -0400
Message-ID: <CAP+JOzT1_b+b_xMPag99239CZ5xF6wPvdt8VrNRyfsuMJYHuug@mail.gmail.com>
Subject: Re: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 5, 2020 at 8:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The value attrs_expand_size == 1 removes all empty attributes, but it
> also makes sense to expand all attributes that have only one type. This
> removes some redundant rules (there is sometimes the same rule for the
> type and the attribute) and reduces the number of attributes that the
> kernel has to go through when looking up rules.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> v2: fix typos (Tne -> The; cointains -> contains)
>
>  libsepol/cil/src/cil.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index d222ad3a..c010ca2a 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
>         (*db)->disable_dontaudit = CIL_FALSE;
>         (*db)->disable_neverallow = CIL_FALSE;
>         (*db)->attrs_expand_generated = CIL_FALSE;
> -       (*db)->attrs_expand_size = 1;
> +       /* 2 == remove attributes that contain none or just 1 type */
> +       (*db)->attrs_expand_size = 2;
>         (*db)->preserve_tunables = CIL_FALSE;
>         (*db)->handle_unknown = -1;
>         (*db)->mls = -1;
> --
> 2.24.1
>
