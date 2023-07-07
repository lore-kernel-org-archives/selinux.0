Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499A3EB64DA
	for <selinux@archiver.kernel.org>; Fri,  7 Jul 2023 18:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGGSMi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Jul 2023 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjGGSMh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Jul 2023 14:12:37 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F00F2121
        for <selinux@vger.kernel.org>; Fri,  7 Jul 2023 11:12:35 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so34242541fa.3
        for <selinux@vger.kernel.org>; Fri, 07 Jul 2023 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688753554; x=1691345554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbL0+ZsgXQ8e2WEPUS+kWAo3wqGkSgTqQbUATrkDv2w=;
        b=nroX+KHQ8aiv0leO6HT65GiGfTzROTz79qqvM3Lg6QWhLPTEEQzeBNEQyXPpdMbRuM
         r6oaG9W5od5xM8tCcIIDndRcaReBk75eoT7I92erWD0dNav1wQxDtQuxOtuWA9TwNWWG
         OKUdQI6DbZ3A4UHUSGNNFxL/GQtv+hdelzcjOKK0/Dk7E86kKUnrbJbZ61TkuUpFrvS+
         GpTzwR/C9ObeYvtiIyeXojRfD2cHRybIKZPnPVyCOqU+zfHB+8Y/8tjwSzsc4p/UpFOh
         1eKu3VYU8Q9+n7hKgUdoJOO/pR648yrg33FfdB2Ko9Z+rJGHkO1lVy38GmScb29b3QlS
         ScKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688753554; x=1691345554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbL0+ZsgXQ8e2WEPUS+kWAo3wqGkSgTqQbUATrkDv2w=;
        b=Jg1kOQ50hO+jsWq7zVFMGGpjZ57ezIMBqS2hm0bfR9FaWOOdkuZQLqRSfsKlRxS2gm
         /agYXPDTqmDEm9q7KIS8BSTtDZyyCHKJ26t/kIWSnbyTRiFvkHAku6Auy4N9b20qonMY
         se+ZPouK19ckrBIC/CC/bHaRgcZ1wtsbw9dncZEelLwggbRXLrV1jhhRPrMwcIzicKZf
         b9w40AntCSRGuTR9CXBUtriXw3oHw9YTNa520HOfE7CYz8Bo8DYcVhw7FfUUatF5+Pn9
         RE0G7IctHjZxwIuLTGKa0eg69nMxg9HX0Mw09qdFC3cgrrU3QYDvHhX95jqPzL0TH499
         OUUQ==
X-Gm-Message-State: ABy/qLb6moOBfI5CHIIVGpaeWN01vypTITxdgwsVPV+2k+S4U7dhiye8
        pEXC9QGifIH0BPTF3Z6I2T9WGbk8TN9dBtuOYMYLYEVx+XQ=
X-Google-Smtp-Source: APBJJlEtrWm/7ICNq7UF+dz6LM5jsFbDz/YxrcsYylgYCBuSUWWbkctqmPR5OL1IrGPPicxe30PKi7QhWlS53hMLWtg=
X-Received: by 2002:a2e:3507:0:b0:2b6:b611:64e9 with SMTP id
 z7-20020a2e3507000000b002b6b61164e9mr3553775ljz.52.1688753553287; Fri, 07 Jul
 2023 11:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687251081.git.juraj@jurajmarcin.com> <cc615a87b1025866d6332bce787dece49766ca52.1687251081.git.juraj@jurajmarcin.com>
In-Reply-To: <cc615a87b1025866d6332bce787dece49766ca52.1687251081.git.juraj@jurajmarcin.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 7 Jul 2023 14:12:21 -0400
Message-ID: <CAP+JOzS4PSk_iupHQY=Lj=TOow_AQ5x2w+jFNX9Qin24O0s-yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] checkpolicy,libsepol: move transition to separate
 structure in avtab
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 20, 2023 at 5:11=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin.com=
> wrote:
>
> To move filename transitions to be part of avtab, we need to create
> space for it in the avtab_datum structure which holds the rule for
> a certain combination of stype, ttype and tclass.
>
> As only type transitions have a special variant that uses a filename, it
> would be suboptimal to add a (mostly empty) pointer to some structure to
> all avtab rules.
>
> Therefore, this patch adds a new structure to the avtab_datum and moves
> the otype of the transition to this structure. In the next patch, this
> structure will also hold filename transitions for the combination of
> stype, ttype and tclass.
>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>

I have this fear that I missed something, but I have tested
compatibility as much as I can and everything seems to work fine. Even
building older policy versions doesn't break anything that I can find.

Patch 3 no longer applies cleanly with some of the recent dismod, but
it is minor and I can handle it when I merge this series.

If at some point we allow named type transitions in conditional
policy, then CIL can handle all type transitions like named type
transitions. But that is for another day.

For this series of eight patches:
Acked-by: James Carter <jwcart2@gmail.com>


> ---
>  checkpolicy/test/dispol.c               |  2 +-
>  libsepol/cil/src/cil_binary.c           | 26 +++++++++++++++-----
>  libsepol/include/sepol/policydb/avtab.h |  7 +++++-
>  libsepol/src/avtab.c                    | 32 ++++++++++++++++++++++++-
>  libsepol/src/expand.c                   |  8 +++++--
>  libsepol/src/kernel_to_cil.c            |  3 ++-
>  libsepol/src/kernel_to_conf.c           |  3 ++-
>  libsepol/src/optimize.c                 |  4 ++++
>  libsepol/src/policydb_validate.c        |  4 +++-
>  libsepol/src/services.c                 |  5 +++-
>  libsepol/src/write.c                    | 17 ++++++++++---
>  11 files changed, 93 insertions(+), 18 deletions(-)
>
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index bee1a660..de1a5d11 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -180,7 +180,7 @@ static int render_av_rule(avtab_key_t * key, avtab_da=
tum_t * datum, uint32_t wha
>                 if (key->specified & AVTAB_TRANSITION) {
>                         fprintf(fp, "type_transition ");
>                         render_key(key, p, fp);
> -                       render_type(datum->data, p, fp);
> +                       render_type(datum->trans->otype, p, fp);
>                         fprintf(fp, ";\n");
>                 }
>                 if (key->specified & AVTAB_MEMBER) {
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index c4ee2380..3f264594 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -975,28 +975,34 @@ static int __cil_insert_type_rule(policydb_t *pdb, =
uint32_t kind, uint32_t src,
>         int rc =3D SEPOL_OK;
>         avtab_key_t avtab_key;
>         avtab_datum_t avtab_datum;
> +       avtab_trans_t trans;
>         avtab_ptr_t existing;
>
>         avtab_key.source_type =3D src;
>         avtab_key.target_type =3D tgt;
>         avtab_key.target_class =3D obj;
>
> +       memset(&avtab_datum, 0, sizeof(avtab_datum_t));
> +       memset(&trans, 0, sizeof(avtab_trans_t));
> +
>         switch (kind) {
>         case CIL_TYPE_TRANSITION:
>                 avtab_key.specified =3D AVTAB_TRANSITION;
> +               trans.otype =3D res;
> +               avtab_datum.trans =3D &trans;
>                 break;
>         case CIL_TYPE_CHANGE:
>                 avtab_key.specified =3D AVTAB_CHANGE;
> +               avtab_datum.data =3D res;
>                 break;
>         case CIL_TYPE_MEMBER:
>                 avtab_key.specified =3D AVTAB_MEMBER;
> +               avtab_datum.data =3D res;
>                 break;
>         default:
>                 rc =3D SEPOL_ERR;
>                 goto exit;
>         }
> -
> -       avtab_datum.data =3D res;
>
>         existing =3D avtab_search_node(&pdb->te_avtab, &avtab_key);
>         if (existing) {
> @@ -1004,13 +1010,17 @@ static int __cil_insert_type_rule(policydb_t *pdb=
, uint32_t kind, uint32_t src,
>                  * A warning should have been previously given if there i=
s a
>                  * non-duplicate rule using the same key.
>                  */
> -               if (existing->datum.data !=3D res) {
> +               uint32_t existing_otype =3D
> +                       existing->key.specified & AVTAB_TRANSITION
> +                       ? existing->datum.trans->otype
> +                       : existing->datum.data;
> +               if (existing_otype !=3D res) {
>                         cil_log(CIL_ERR, "Conflicting type rules (scontex=
t=3D%s tcontext=3D%s tclass=3D%s result=3D%s), existing=3D%s\n",
>                                 pdb->p_type_val_to_name[src - 1],
>                                 pdb->p_type_val_to_name[tgt - 1],
>                                 pdb->p_class_val_to_name[obj - 1],
>                                 pdb->p_type_val_to_name[res - 1],
> -                               pdb->p_type_val_to_name[existing->datum.d=
ata - 1]);
> +                               pdb->p_type_val_to_name[existing_otype - =
1]);
>                         cil_log(CIL_ERR, "Expanded from type rule (sconte=
xt=3D%s tcontext=3D%s tclass=3D%s result=3D%s)\n",
>                                 cil_rule->src_str, cil_rule->tgt_str, cil=
_rule->obj_str, cil_rule->result_str);
>                         rc =3D SEPOL_ERR;
> @@ -1037,13 +1047,17 @@ static int __cil_insert_type_rule(policydb_t *pdb=
, uint32_t kind, uint32_t src,
>
>                         search_datum =3D cil_cond_av_list_search(&avtab_k=
ey, other_list);
>                         if (search_datum =3D=3D NULL) {
> -                               if (existing->datum.data !=3D res) {
> +                               uint32_t existing_otype =3D
> +                                       existing->key.specified & AVTAB_T=
RANSITION
> +                                       ? existing->datum.trans->otype
> +                                       : existing->datum.data;
> +                               if (existing_otype !=3D res) {
>                                         cil_log(CIL_ERR, "Conflicting typ=
e rules (scontext=3D%s tcontext=3D%s tclass=3D%s result=3D%s), existing=3D%=
s\n",
>                                                 pdb->p_type_val_to_name[s=
rc - 1],
>                                                 pdb->p_type_val_to_name[t=
gt - 1],
>                                                 pdb->p_class_val_to_name[=
obj - 1],
>                                                 pdb->p_type_val_to_name[r=
es - 1],
> -                                               pdb->p_type_val_to_name[e=
xisting->datum.data - 1]);
> +                                               pdb->p_type_val_to_name[e=
xisting_otype - 1]);
>                                         cil_log(CIL_ERR, "Expanded from t=
ype rule (scontext=3D%s tcontext=3D%s tclass=3D%s result=3D%s)\n",
>                                                 cil_rule->src_str, cil_ru=
le->tgt_str, cil_rule->obj_str, cil_rule->result_str);
>                                         rc =3D SEPOL_ERR;
> diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/s=
epol/policydb/avtab.h
> index e4c48576..ca009c16 100644
> --- a/libsepol/include/sepol/policydb/avtab.h
> +++ b/libsepol/include/sepol/policydb/avtab.h
> @@ -70,6 +70,10 @@ typedef struct avtab_key {
>         uint16_t specified;     /* what fields are specified */
>  } avtab_key_t;
>
> +typedef struct avtab_trans {
> +       uint32_t otype;         /* resulting type of the new object */
> +} avtab_trans_t;
> +
>  typedef struct avtab_extended_perms {
>
>  #define AVTAB_XPERMS_IOCTLFUNCTION     0x01
> @@ -81,7 +85,8 @@ typedef struct avtab_extended_perms {
>  } avtab_extended_perms_t;
>
>  typedef struct avtab_datum {
> -       uint32_t data;          /* access vector or type */
> +       uint32_t data;          /* access vector, member or change value =
*/
> +       avtab_trans_t *trans;   /* transition value */
>         avtab_extended_perms_t *xperms;
>  } avtab_datum_t;
>
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 82fec783..4c292e8b 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -94,6 +94,7 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr_t =
prev, avtab_key_t * key,
>                   avtab_datum_t * datum)
>  {
>         avtab_ptr_t newnode;
> +       avtab_trans_t *trans;
>         avtab_extended_perms_t *xperms;
>
>         newnode =3D (avtab_ptr_t) malloc(sizeof(struct avtab_node));
> @@ -117,6 +118,16 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_ptr=
_t prev, avtab_key_t * key,
>                  * So copy data so it is set in the avtab
>                  */
>                 newnode->datum.data =3D datum->data;
> +       } else if (key->specified & AVTAB_TRANSITION) {
> +               trans =3D calloc(1, sizeof(*trans));
> +               if (trans =3D=3D NULL) {
> +                       free(newnode);
> +                       return NULL;
> +               }
> +               if (datum->trans) /* else caller populates transition */
> +                       *trans =3D *(datum->trans);
> +
> +               newnode->datum.trans =3D trans;
>         } else {
>                 newnode->datum =3D *datum;
>         }
> @@ -317,6 +328,8 @@ void avtab_destroy(avtab_t * h)
>                 while (cur !=3D NULL) {
>                         if (cur->key.specified & AVTAB_XPERMS) {
>                                 free(cur->datum.xperms);
> +                       } else if (cur->key.specified & AVTAB_TRANSITION)=
 {
> +                               free(cur->datum.trans);
>                         }
>                         temp =3D cur;
>                         cur =3D cur->next;
> @@ -440,6 +453,7 @@ int avtab_read_item(struct policy_file *fp, uint32_t =
vers, avtab_t * a,
>         uint32_t buf32[8], items, items2, val;
>         avtab_key_t key;
>         avtab_datum_t datum;
> +       avtab_trans_t trans;
>         avtab_extended_perms_t xperms;
>         unsigned set;
>         unsigned int i;
> @@ -447,6 +461,7 @@ int avtab_read_item(struct policy_file *fp, uint32_t =
vers, avtab_t * a,
>
>         memset(&key, 0, sizeof(avtab_key_t));
>         memset(&datum, 0, sizeof(avtab_datum_t));
> +       memset(&trans, 0, sizeof(avtab_trans_t));
>         memset(&xperms, 0, sizeof(avtab_extended_perms_t));
>
>         if (vers < POLICYDB_VERSION_AVTAB) {
> @@ -509,7 +524,14 @@ int avtab_read_item(struct policy_file *fp, uint32_t=
 vers, avtab_t * a,
>                                         return -1;
>                                 }
>                                 key.specified =3D spec_order[i] | enabled=
;
> -                               datum.data =3D le32_to_cpu(buf32[items++]=
);
> +                               if (key.specified & AVTAB_TRANSITION) {
> +                                       trans.otype =3D
> +                                               le32_to_cpu(buf32[items++=
]);
> +                                       datum.trans =3D &trans;
> +                               } else {
> +                                       datum.data =3D
> +                                               le32_to_cpu(buf32[items++=
]);
> +                               }
>                                 rc =3D insertf(a, &key, &datum, p);
>                                 if (rc)
>                                         return rc;
> @@ -571,6 +593,14 @@ int avtab_read_item(struct policy_file *fp, uint32_t=
 vers, avtab_t * a,
>                 for (i =3D 0; i < ARRAY_SIZE(xperms.perms); i++)
>                         xperms.perms[i] =3D le32_to_cpu(buf32[i]);
>                 datum.xperms =3D &xperms;
> +       } else if (key.specified & AVTAB_TRANSITION) {
> +               rc =3D next_entry(buf32, fp, sizeof(uint32_t));
> +               if (rc < 0) {
> +                       ERR(fp->handle, "truncated entry");
> +                       return -1;
> +               }
> +               trans.otype =3D le32_to_cpu(*buf32);
> +               datum.trans =3D &trans;
>         } else {
>                 rc =3D next_entry(buf32, fp, sizeof(uint32_t));
>                 if (rc < 0) {
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 8795229a..6793a27d 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1746,7 +1746,7 @@ static int expand_terule_helper(sepol_handle_t * ha=
ndle,
>                 if (conflict) {
>                         avdatump =3D &node->datum;
>                         if (specified & AVRULE_TRANSITION) {
> -                               oldtype =3D avdatump->data;
> +                               oldtype =3D avdatump->trans->otype;
>                         } else if (specified & AVRULE_MEMBER) {
>                                 oldtype =3D avdatump->data;
>                         } else if (specified & AVRULE_CHANGE) {
> @@ -1789,7 +1789,11 @@ static int expand_terule_helper(sepol_handle_t * h=
andle,
>                 }
>
>                 avdatump =3D &node->datum;
> -               avdatump->data =3D remapped_data;
> +               if (specified & AVRULE_TRANSITION) {
> +                       avdatump->trans->otype =3D remapped_data;
> +               } else {
> +                       avdatump->data =3D remapped_data;
> +               }
>
>                 cur =3D cur->next;
>         }
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index f2b0d902..b1fd1bf7 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1704,7 +1704,8 @@ static char *xperms_to_str(avtab_extended_perms_t *=
xperms)
>
>  static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, a=
vtab_datum_t *datum)
>  {
> -       uint32_t data =3D datum->data;
> +       uint32_t data =3D key->specified & AVTAB_TRANSITION
> +               ? datum->trans->otype : datum->data;
>         type_datum_t *type;
>         const char *flavor, *tgt;
>         char *src, *class, *perms, *new;
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 15161caa..7e1e1b49 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -1682,7 +1682,8 @@ exit:
>
>  static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *key, a=
vtab_datum_t *datum)
>  {
> -       uint32_t data =3D datum->data;
> +       uint32_t data =3D key->specified & AVTAB_TRANSITION
> +               ? datum->trans->otype : datum->data;
>         type_datum_t *type;
>         const char *flavor, *src, *tgt, *class, *perms, *new;
>         char *rule =3D NULL;
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index a38025ec..2d4a2d7a 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -308,6 +308,8 @@ static void optimize_avtab(policydb_t *p, const struc=
t type_vec *type_map)
>                                 *cur =3D tmp->next;
>                                 if (tmp->key.specified & AVTAB_XPERMS)
>                                         free(tmp->datum.xperms);
> +                               if (tmp->key.specified & AVTAB_TRANSITION=
)
> +                                       free(tmp->datum.trans);
>                                 free(tmp);
>
>                                 tab->nel--;
> @@ -427,6 +429,8 @@ static void optimize_cond_avtab(policydb_t *p, const =
struct type_vec *type_map)
>                                 *cur =3D tmp->next;
>                                 if (tmp->key.specified & AVTAB_XPERMS)
>                                         free(tmp->datum.xperms);
> +                               if (tmp->key.specified & AVTAB_TRANSITION=
)
> +                                       free(tmp->datum.trans);
>                                 free(tmp);
>
>                                 tab->nel--;
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 3540f34a..f402b506 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -836,7 +836,9 @@ static int validate_avtab_key_and_datum(avtab_key_t *=
k, avtab_datum_t *d, void *
>         if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
>                 return -1;
>
> -       if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, m=
args->policy, margs->flavors))
> +       uint32_t otype =3D k->specified & AVTAB_TRANSITION
> +               ? d->trans->otype : d->data;
> +       if ((k->specified & AVTAB_TYPE) && validate_simpletype(otype, mar=
gs->policy, margs->flavors))
>                 return -1;
>
>         if ((k->specified & AVTAB_XPERMS) && validate_xperms(d->xperms))
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 062510ab..72772dbd 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1423,7 +1423,10 @@ static int sepol_compute_sid(sepol_security_id_t s=
sid,
>
>         if (avdatum) {
>                 /* Use the type from the type transition/member/change ru=
le. */
> -               newcontext.type =3D avdatum->data;
> +               if (specified & AVTAB_TRANSITION)
> +                       newcontext.type =3D avdatum->trans->otype;
> +               else
> +                       newcontext.type =3D avdatum->data;
>         }
>
>         /* Check for class-specific changes. */
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 024fe628..0d3d5f14 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -190,14 +190,20 @@ static int avtab_write_item(policydb_t * p,
>                                                 ERR(fp->handle, "missing =
node");
>                                                 return POLICYDB_ERROR;
>                                         }
> -                                       buf32[items++] =3D
> -                                           cpu_to_le32(node->datum.data)=
;
> +                                       uint32_t data =3D
> +                                               node->key.specified & AVT=
AB_TRANSITION
> +                                               ? node->datum.trans->otyp=
e
> +                                               : node->datum.data;
> +                                       buf32[items++] =3D cpu_to_le32(da=
ta);
>                                         set--;
>                                         node->merged =3D 1;
>                                 }
>                         }
>                 } else {
> -                       buf32[items++] =3D cpu_to_le32(cur->datum.data);
> +                       uint32_t data =3D cur->key.specified & AVTAB_TRAN=
SITION
> +                               ? cur->datum.trans->otype
> +                               : cur->datum.data;
> +                       buf32[items++] =3D cpu_to_le32(data);
>                         cur->merged =3D 1;
>                         set--;
>                 }
> @@ -256,6 +262,11 @@ static int avtab_write_item(policydb_t * p,
>                 items =3D put_entry(buf32, sizeof(uint32_t),8,fp);
>                 if (items !=3D 8)
>                         return POLICYDB_ERROR;
> +       } else if (cur->key.specified & AVTAB_TRANSITION) {
> +               buf32[0] =3D cpu_to_le32(cur->datum.trans->otype);
> +               items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
> +               if (items !=3D 1)
> +                       return POLICYDB_ERROR;
>         } else {
>                 buf32[0] =3D cpu_to_le32(cur->datum.data);
>                 items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
> --
> 2.40.0
>
