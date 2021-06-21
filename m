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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0FAC4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6CB61245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUU4z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUU4x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:56:53 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACEBC061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:54:38 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w1so8153342oie.13
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZErYDP6uPxQ6rvbQB9FLXR/ik8X8PwoRR3TwUPq/By8=;
        b=c4feIiteqlaA6SnHOq4Vj8FAO3hdfrzvyPBxW3oSgDwbo7VEHj1AMOmAPTb4eNasg0
         gRGwvitcPhL2QGciZ294ytdaKRIlWNAHwxBsPI0Iq7Yrwve5D7TuDDNPcHVpZH+hQLSA
         ajWAPH9LuPSkhGLw3/w65u9zU+OBdlwEiokZe8i0rIGZAsszJvs8uleO6OiCKF759DbE
         K9IKZTjdz17+TJO2CXMvzoLEI1nLI9QA7p+Co8zVxI4x+dIzvr/LCaJiP32WqAHgGPEx
         cyecOfB31O3ZzZ59QQhtgXzA6nZcVVw0rVhXmcy0AYOU44KiEdGYcHa+y+2IcB4GhtjJ
         yi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZErYDP6uPxQ6rvbQB9FLXR/ik8X8PwoRR3TwUPq/By8=;
        b=YZgT5D6g0IAxr4Hg6K8Kd+cgVSUTGYyEmTLxcIULJdo9PpErY582F1pAqQZ9pIPGE6
         2V4oXUZ2A78rBXI2lfEmAujG5eTsyqFbF6bT4ZUCv/166IqwDAYzh0b6ntsV8uaqvVpV
         0Wb4oGJSzezr/DNDa/ehZkfNw7od+KHh4ni7eZv+t1sWL15zzeK94WjTghXu7q5UrRBe
         MkUxggqHl2flzmH8vUZ043dHCu6HbtziWAkU27PaaxtUydZRCa7bcTJAz3q7avm0nJxu
         RgNtVM1pR4dNqjkPRc2zjL0LjFzL4CApHcMNkTNcLBkO1opZQ1GH83fwib/4cyay5Aaj
         117g==
X-Gm-Message-State: AOAM530AY9/j2e+9gENhMD8nasknvHIBP/k4ekpEbnCzq5QSGxE+H8Mj
        0Z1tyW3JIDdaR0o8HzEMJat9hk0r2P2os7vEQnI=
X-Google-Smtp-Source: ABdhPJw1azHEJw36gPkvR0ph7hgkHkpotIsyjQZ3SpP3eOm1ppNmF1RD62M6eBxJtQFItJSHrQFWKhm6aRw50Q4UjcE=
X-Received: by 2002:aca:d5cd:: with SMTP id m196mr277498oig.138.1624308878177;
 Mon, 21 Jun 2021 13:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-2-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:54:27 -0400
Message-ID: <CAP+JOzSLAJ0YUC7XjX8TXKpVp==J9CVz+JL0_nQVQGBa8f9c4Q@mail.gmail.com>
Subject: Re: [PATCH 01/23] libsepol: fix typos
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:00 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_build_ast.c   | 2 +-
>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>  libsepol/src/module_to_cil.c       | 2 +-
>  libsepol/src/policydb_validate.c   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 71f14e20..42d10c87 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -3692,7 +3692,7 @@ int cil_gen_sensitivityorder(struct cil_db *db, str=
uct cil_tree_node *parse_curr
>
>         cil_list_for_each(curr, sensorder->sens_list_str) {
>                 if (curr->data =3D=3D CIL_KEY_UNORDERED) {
> -                       cil_log(CIL_ERR, "Sensitivy order cannot be unord=
ered.\n");
> +                       cil_log(CIL_ERR, "Sensitivity order cannot be uno=
rdered.\n");
>                         rc =3D SEPOL_ERR;
>                         goto exit;
>                 }
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index 77ffe0ff..d8481002 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -1619,7 +1619,7 @@ int cil_resolve_sensitivityorder(struct cil_tree_no=
de *current, void *extra_args
>         cil_list_for_each(curr, sensorder->sens_list_str) {
>                 rc =3D cil_resolve_name(current, (char *)curr->data, CIL_=
SYM_SENS, extra_args, &datum);
>                 if (rc !=3D SEPOL_OK) {
> -                       cil_log(CIL_ERR, "Failed to resolve sensitivty %s=
 in sensitivityorder\n", (char *)curr->data);
> +                       cil_log(CIL_ERR, "Failed to resolve sensitivity %=
s in sensitivityorder\n", (char *)curr->data);
>                         goto exit;
>                 }
>                 if (FLAVOR(datum) !=3D CIL_SENS) {
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 496693f4..41605eb8 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -3972,7 +3972,7 @@ int sepol_module_policydb_to_cil(FILE *fp, struct p=
olicydb *pdb, int linked)
>
>         if (pdb->policy_type !=3D SEPOL_POLICY_BASE &&
>                 pdb->policy_type !=3D SEPOL_POLICY_MOD) {
> -               log_err("Policy pakcage is not a base or module");
> +               log_err("Policy package is not a base or module");
>                 rc =3D -1;
>                 goto exit;
>         }
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index b2891ddd..246aa6e3 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -641,7 +641,7 @@ static int validate_scope_index(sepol_handle_t *handl=
e, scope_index_t *scope_ind
>         return 0;
>
>  bad:
> -       ERR(handle, "Invalide scope");
> +       ERR(handle, "Invalid scope");
>         return -1;
>  }
>
> --
> 2.32.0
>
