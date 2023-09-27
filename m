Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85D6E82CD6
	for <selinux@archiver.kernel.org>; Wed, 27 Sep 2023 20:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjI0UlT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Sep 2023 16:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0UlS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Sep 2023 16:41:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0EAD6
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 13:41:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so200414491fa.3
        for <selinux@vger.kernel.org>; Wed, 27 Sep 2023 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695847275; x=1696452075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JycaPRRcA9bhOeF5D9yuC5QUda242/mS4b0c4dZFUsY=;
        b=Ymaz7Hvd15N5vG90rvvsu6xWMz2fYJF/kvlC89kve/paroCa0A696xQZJ0oqH+pEi9
         AG1x2a23z4ZoCErWAdjIfjW9wDLygK01k5He0g3tRwKISiTgO/q35zEbODV7ojO9U9Dk
         JDqZSXHpKa9ApoFNMzyoOTcfIoWG3/T2G4MOW0lI2DYvedZzPVe36w33kTVjnVm80dD5
         LEahHm0XwTv5/9MnlJqoaPpPHPzbCoq2FeDU5Kl9IEyDQ9svAo/40DxViYJvhFmwgXTF
         hPDAb3WBPRs7Nemw5NTEDpoC3isvAslg4VF3/lk/VPA+CssrIhkGBaxK2q1Q5UXpD0aV
         +aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695847275; x=1696452075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JycaPRRcA9bhOeF5D9yuC5QUda242/mS4b0c4dZFUsY=;
        b=FghMcC0xxKlNZBYDT2sirVXLbu+RfcchzDK/zWk2LFhviNC6O7l/uGDoQ+GbzU8lxL
         U1EOWfHMIBupVxP8mEBcjObFT9qiQUF2BxLAl+5JeFX5du0d/E8BHc/cNwPrNoYSlfdY
         uZe2gy81Ozf88NHVz8wbt3qfsZrhsLeNrUFeTQ04yWAmbSsDP615I4ej86Nf8oSYyhkj
         fs3KHafmmzw3M8nY8af1cd5nHShRsZo9gTfASEprA/1p+FSh8iFk7q1YJgikj3j1D6J2
         qrhrIUZ0bmZA7nvAkK2OoJuV2orZWTgya/W2RqP7YKaPe9UrMH/A+QtAWzXpe0fJhcPG
         6PGQ==
X-Gm-Message-State: AOJu0Yyk51mAWPRaFyx579FwYrG+mQEwfjJOwllB9MCu0sHhi1CL7WFV
        BPYtw1f0OWsEUA8UFkKniqYv34QTr3b72P87lQM6Dwqs
X-Google-Smtp-Source: AGHT+IGqu+jtMMHRbXdPKHSkoEQq4TN8evWiLFz3TonazRz9RfggCl8X2oI5g78/BTdWPsgtnjO17fstIs0SLHxXW9c=
X-Received: by 2002:a05:6512:3ba2:b0:503:655:12e0 with SMTP id
 g34-20020a0565123ba200b00503065512e0mr3390453lfv.50.1695847274641; Wed, 27
 Sep 2023 13:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230927190021.1164278-1-jwcart2@gmail.com> <20230927190021.1164278-2-jwcart2@gmail.com>
 <4b23ff1b-6b93-f21b-26f4-193efcd9db93@linux.microsoft.com>
In-Reply-To: <4b23ff1b-6b93-f21b-26f4-193efcd9db93@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 27 Sep 2023 16:41:03 -0400
Message-ID: <CAP+JOzQA64fXdpow02ZDy9rcDx48v3jq2VGiSuG4akNVDn3xvQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] libsepol/cil: Use struct cil_db * instead of void *
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 27, 2023 at 3:27=E2=80=AFPM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> > @@ -3661,21 +3615,17 @@ static int cil_check_for_bad_inheritance(struct=
 cil_tree_node *node)
> >       return rc;
> >   }
> >
> > -static int __cil_resolve_ast_node(struct cil_tree_node *node, void *ex=
tra_args)
> > +static int __cil_resolve_ast_node(struct cil_tree_node *node, struct c=
il_args_resolve *args)
> >   {
> >       int rc =3D SEPOL_OK;
> > -     struct cil_args_resolve *args =3D extra_args;
> > +     struct cil_db *db =3D args->db;
> >       enum cil_pass pass =3D 0;
> >
> > -     if (node =3D=3D NULL || args =3D=3D NULL) {
> > -             goto exit;
> > -     }
> > -
>
> Is deleting the "node =3D=3D NULL" part of this check intended here?  It
> seems unrelated to the rest of the commit, and it's not locally obvious
> that it's safe.

You are right. It is not related to the rest of the commit. There are
a bunch of these sorts of checks that are useless and really annoy me.
The function __cil_resolve_ast_node() is called once from
__cil_resolve_ast_node_helper() and neither node nor args can be NULL.
Since I was changing something nearby, I guess I couldn't resist. I
can leave it in, if people prefer. It doesn't cause any harm, other
than annoying me.

Jim

>
>
