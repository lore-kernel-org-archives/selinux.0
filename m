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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA0BC48BC2
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B257861245
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 20:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFUU6D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhFUU6D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 16:58:03 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DEEC061756
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:55:48 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id q10so21338206oij.5
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 13:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mjSc4BOTtxhGshdGgujPPgHRyx9VQ4G0u29eCSqO/dY=;
        b=hAk3F9D3mT6XVotAMPAW8ski0ksphgXlc4jaf6/NqIrxF9ekcWphKCXAtkWCGquCHL
         OJv/h6rPo3jFw/j7NYgJ+6lUEQ61WAfPW1VvEWqulo6O6L2ceLw32cTrE26BcXD0k0oB
         pu5yCaGv1v++aM7BOC6uRnxfNhq9jlmHEXNI8qIpkTp/hNFVE0+b1UATteUL7qMCENEy
         t7JWhXAjpZ3KS9CCeJCQURt0esqjmfPZY9aMAC9CLqOubEnEyKeTjwtW7UaiXf5Sfs2o
         8NK6LgDJ+7L9SldBtREnnrTIHPUdAxxpgwN1lO0YbZKvb1fQvAc671PssD6n6fC0J3vt
         dccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mjSc4BOTtxhGshdGgujPPgHRyx9VQ4G0u29eCSqO/dY=;
        b=pE8h19kt+OxZ9PKjHxKxnbZvI6wJaxhpauUmls6eWC3GtsKde6ygze2Mk78XwTv2Lb
         Gf3BngTV02Spi4XolntTgoMZSSBMBtFlxR5sqbIIdSWnZwJMKPbyfa2cj5EU8B66fW9k
         U8S3IgDP/8GSZG9lOkBxqTCqbiZFYw9d0kmY8y82DAf0q7SLvQdM7ZzPF7+iveL8ckav
         qlXHw/0wVMgl7Y1LknhpiHnIPWdO0GItyVMHLoGNH0z/WQ/QSljpiQxq6z9++GTpza+9
         vY+oPt2az0Cq+I91TKv45b7dKMyvQSsIAv11RUI75rjU6lMgRslN9TQSOrhDMIjD6X8x
         H0Mg==
X-Gm-Message-State: AOAM533sbTURuSOe69QJygISn+ZVexrlWTKg0MG9bCHCog9W5KR6gW75
        +jC4S9xX2XcQebwzPmqV7TDM56z6d68vPD+DO/4=
X-Google-Smtp-Source: ABdhPJzL4A/LoOefcyn8MuWbW2qUBu5ZC07ylESMSDei5mMMhfSvjWNXtFsQy1oFp0Mz+Img2s09likHCLPfodzRjyU=
X-Received: by 2002:aca:30d1:: with SMTP id w200mr449701oiw.16.1624308948301;
 Mon, 21 Jun 2021 13:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-3-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 16:55:37 -0400
Message-ID: <CAP+JOzQU=r6c23e9-6WivjzSV3uKweo5NVdiU88F-awfL=+d3w@mail.gmail.com>
Subject: Re: [PATCH 02/23] libsepol: resolve missing prototypes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:01 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Declare the functions as static or include the corresponding header
> file.
>
> assertion.c:294:5: error: no previous prototype for function 'report_asse=
rtion_failures' [-Werror,-Wmissing-prototypes]
> int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avru=
le_t *avrule)
>     ^
>
> context.c:23:5: error: no previous prototype for function 'sepol_check_co=
ntext' [-Werror,-Wmissing-prototypes]
> int sepol_check_context(const char *context)
>     ^
>
> expand.c:3377:5: error: no previous prototype for function 'expand_cond_a=
v_node' [-Werror,-Wmissing-prototypes]
> int expand_cond_av_node(policydb_t * p,
>     ^
>
> policydb.c:638:6: error: no previous prototype for function 'role_trans_r=
ule_destroy' [-Werror,-Wmissing-prototypes]
> void role_trans_rule_destroy(role_trans_rule_t * x)
>      ^
>
> policydb.c:1169:5: error: no previous prototype for function 'policydb_in=
dex_decls' [-Werror,-Wmissing-prototypes]
> int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
>     ^
>
> policydb.c:1429:6: error: no previous prototype for function 'ocontext_se=
linux_free' [-Werror,-Wmissing-prototypes]
> void ocontext_selinux_free(ocontext_t **ocontexts)
>      ^
>
> policydb.c:1451:6: error: no previous prototype for function 'ocontext_xe=
n_free' [-Werror,-Wmissing-prototypes]
> void ocontext_xen_free(ocontext_t **ocontexts)
>      ^
>
> policydb.c:1750:5: error: no previous prototype for function 'type_set_or=
' [-Werror,-Wmissing-prototypes]
> int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
>     ^
>
> policydb.c:2524:5: error: no previous prototype for function 'role_trans_=
read' [-Werror,-Wmissing-prototypes]
> int role_trans_read(policydb_t *p, struct policy_file *fp)
>     ^
>
> policydb.c:2567:5: error: no previous prototype for function 'role_allow_=
read' [-Werror,-Wmissing-prototypes]
> int role_allow_read(role_allow_t ** r, struct policy_file *fp)
>     ^
>
> policydb.c:2842:5: error: no previous prototype for function 'filename_tr=
ans_read' [-Werror,-Wmissing-prototypes]
> int filename_trans_read(policydb_t *p, struct policy_file *fp)
>     ^
>
> services.c:1027:5: error: no previous prototype for function 'sepol_valid=
ate_transition' [-Werror,-Wmissing-prototypes]
> int sepol_validate_transition(sepol_security_id_t oldsid,
>     ^
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/assertion.c        |  2 +-
>  libsepol/src/context_internal.h |  1 +
>  libsepol/src/expand.c           |  6 +++---
>  libsepol/src/policydb.c         | 16 ++++++++--------
>  libsepol/src/services.c         |  2 +-
>  5 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> index 266f67d7..dd2749a0 100644
> --- a/libsepol/src/assertion.c
> +++ b/libsepol/src/assertion.c
> @@ -291,7 +291,7 @@ exit:
>         return rc;
>  }
>
> -int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avr=
ule_t *avrule)
> +static int report_assertion_failures(sepol_handle_t *handle, policydb_t =
*p, avrule_t *avrule)
>  {
>         int rc;
>         struct avtab_match_args args;
> diff --git a/libsepol/src/context_internal.h b/libsepol/src/context_inter=
nal.h
> index 3cae28cc..3dc9cd15 100644
> --- a/libsepol/src/context_internal.h
> +++ b/libsepol/src/context_internal.h
> @@ -1,6 +1,7 @@
>  #ifndef _SEPOL_CONTEXT_INTERNAL_H_
>  #define _SEPOL_CONTEXT_INTERNAL_H_
>
> +#include <sepol/context.h>
>  #include <sepol/context_record.h>
>
>  #endif
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index a656ffad..84bfcfa3 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -3374,9 +3374,9 @@ static int expand_cond_insert(cond_av_list_t ** l,
>         return 0;
>  }
>
> -int expand_cond_av_node(policydb_t * p,
> -                       avtab_ptr_t node,
> -                       cond_av_list_t ** newl, avtab_t * expa)
> +static int expand_cond_av_node(policydb_t * p,
> +                              avtab_ptr_t node,
> +                              cond_av_list_t ** newl, avtab_t * expa)
>  {
>         avtab_key_t *k =3D &node->key;
>         avtab_datum_t *d =3D &node->datum;
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index ffa27971..3f7ddb11 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -635,7 +635,7 @@ void role_trans_rule_init(role_trans_rule_t * x)
>         ebitmap_init(&x->classes);
>  }
>
> -void role_trans_rule_destroy(role_trans_rule_t * x)
> +static void role_trans_rule_destroy(role_trans_rule_t * x)
>  {
>         if (x !=3D NULL) {
>                 role_set_destroy(&x->roles);
> @@ -1166,7 +1166,7 @@ int policydb_index_bools(policydb_t * p)
>         return 0;
>  }
>
> -int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
> +static int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
>  {
>         avrule_block_t *curblock;
>         avrule_decl_t *decl;
> @@ -1426,7 +1426,7 @@ static int range_tr_destroy(hashtab_key_t key, hash=
tab_datum_t datum,
>         return 0;
>  }
>
> -void ocontext_selinux_free(ocontext_t **ocontexts)
> +static void ocontext_selinux_free(ocontext_t **ocontexts)
>  {
>         ocontext_t *c, *ctmp;
>         int i;
> @@ -1448,7 +1448,7 @@ void ocontext_selinux_free(ocontext_t **ocontexts)
>         }
>  }
>
> -void ocontext_xen_free(ocontext_t **ocontexts)
> +static void ocontext_xen_free(ocontext_t **ocontexts)
>  {
>         ocontext_t *c, *ctmp;
>         int i;
> @@ -1747,7 +1747,7 @@ int symtab_insert(policydb_t * pol, uint32_t sym,
>         return retval;
>  }
>
> -int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
> +static int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
>  {
>         type_set_init(dst);
>
> @@ -2521,7 +2521,7 @@ static int type_read(policydb_t * p, hashtab_t h, s=
truct policy_file *fp)
>         return -1;
>  }
>
> -int role_trans_read(policydb_t *p, struct policy_file *fp)
> +static int role_trans_read(policydb_t *p, struct policy_file *fp)
>  {
>         role_trans_t **t =3D &p->role_tr;
>         unsigned int i;
> @@ -2564,7 +2564,7 @@ int role_trans_read(policydb_t *p, struct policy_fi=
le *fp)
>         return 0;
>  }
>
> -int role_allow_read(role_allow_t ** r, struct policy_file *fp)
> +static int role_allow_read(role_allow_t ** r, struct policy_file *fp)
>  {
>         unsigned int i;
>         uint32_t buf[2], nel;
> @@ -2839,7 +2839,7 @@ err:
>         return -1;
>  }
>
> -int filename_trans_read(policydb_t *p, struct policy_file *fp)
> +static int filename_trans_read(policydb_t *p, struct policy_file *fp)
>  {
>         unsigned int i;
>         uint32_t buf[1], nel;
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 6596431c..39fbd979 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1024,7 +1024,7 @@ static int context_struct_compute_av(context_struct=
_t * scontext,
>         return 0;
>  }
>
> -int sepol_validate_transition(sepol_security_id_t oldsid,
> +static int sepol_validate_transition(sepol_security_id_t oldsid,
>                                      sepol_security_id_t newsid,
>                                      sepol_security_id_t tasksid,
>                                      sepol_security_class_t tclass)
> --
> 2.32.0
>
