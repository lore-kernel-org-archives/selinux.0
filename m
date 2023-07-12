Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14EBEB64DA
	for <selinux@archiver.kernel.org>; Wed, 12 Jul 2023 19:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGLTRc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjGLTRb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jul 2023 15:17:31 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB11994
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 12:17:29 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-48133dc9820so331031e0c.3
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689189449; x=1691781449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNmgJse+U7y1N5VA4uBkMKI/ZzyQHJzmgQC6v+lAq1o=;
        b=XG1LZTLkaREpSc6QuwStnzazKIeGcBWNFzrwavIiMIisC58kLjcjiSgp4xb0l3OfDn
         hdsmIk3WYnQ7VqNaIoM0vqLM2oCRBDyZB5gqBViD7P6m8BKxZo17YEl96KzYK5Wuu6zR
         SZu9ID8EJ9D9FO6SKtOHSHeAx7UyejGdJW4APprwqWOQpve7z+mK93KOu3tvh7XKBta4
         FqNNSa3DRPwPCmvc79WQpbP8zTIlr2Vfd3pNo5pjeHZgD2u6Oa+LC+r3BxnhowwxxcVN
         jtuT/IXCKBpZgwgqfA3uTzkOIq9c4s/ntFxJJNVtyFZUlxLZxske2BRrs4LjEoHLij58
         RbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689189449; x=1691781449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNmgJse+U7y1N5VA4uBkMKI/ZzyQHJzmgQC6v+lAq1o=;
        b=EjiMTuQzc52AVrVJ2zOjj5X2eSjvPPzzUji3PPXjrh/uEgRGO7F5v/18SAop+pbuiJ
         5GVhESxmG9/apR3OoIABx0Lpbnv1ozbKErM7xuOjo+vJfHKUiY0EydWfUI3KlJv691PN
         CGlYVGHaLqphbWhMLF9hvwFPVqtre4Dy0uXGuYe0D1UiTqRPVXB8Z9wiW73y03FcmZXL
         ligY+/csRdhSK7NtYLq4t6432W7NemjlcknYl8xK58Oa3E3xw/oMOcMpBz1Rl86YZarP
         aGzfsMB1KEkhHhGn79DhKdJZlgO8z9z6XxwrOQ3MiTL1Cdv2LOl+N96xbJj9VlZr5EaK
         Ss6w==
X-Gm-Message-State: ABy/qLaOFLFfWrjEpFsMlFs4lUi/FnpEv8uNERQummJeS0mzUrB1Z4YB
        oKFARbzhWCjrbOGRDanu5G/ufXvv7plxAHZVAoh9wHWt64i2sbSe
X-Google-Smtp-Source: APBJJlGcgATcaI/hQKvLXWowTuiL+F2AgSFqXJC2JSVS8sjVgwL5uX2c/+FLXlx98UIlS/SRVBhCBuNwPDDPFPxdWIc=
X-Received: by 2002:a05:6102:2fc:b0:443:7eba:e22c with SMTP id
 j28-20020a05610202fc00b004437ebae22cmr6365310vsj.8.1689189448550; Wed, 12 Jul
 2023 12:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687251081.git.juraj@jurajmarcin.com> <cc615a87b1025866d6332bce787dece49766ca52.1687251081.git.juraj@jurajmarcin.com>
 <CAP+JOzS4PSk_iupHQY=Lj=TOow_AQ5x2w+jFNX9Qin24O0s-yw@mail.gmail.com> <CAP+JOzSPTvkVomJsU9+GN7TWbHeRjWJW3qQqVLbSesfT=VR-Lw@mail.gmail.com>
In-Reply-To: <CAP+JOzSPTvkVomJsU9+GN7TWbHeRjWJW3qQqVLbSesfT=VR-Lw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 12 Jul 2023 21:17:17 +0200
Message-ID: <CAJ2a_De6enDgX6tQz8n5ShyisEqDyxco5DyqTu9vUzxMWzJ-FQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] checkpolicy,libsepol: move transition to separate
 structure in avtab
To:     James Carter <jwcart2@gmail.com>
Cc:     Juraj Marcin <juraj@jurajmarcin.com>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 12 Jul 2023 at 19:34, James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Jul 7, 2023 at 2:12=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
> >
> > On Tue, Jun 20, 2023 at 5:11=E2=80=AFAM Juraj Marcin <juraj@jurajmarcin=
.com> wrote:
> > >
> > > To move filename transitions to be part of avtab, we need to create
> > > space for it in the avtab_datum structure which holds the rule for
> > > a certain combination of stype, ttype and tclass.
> > >
> > > As only type transitions have a special variant that uses a filename,=
 it
> > > would be suboptimal to add a (mostly empty) pointer to some structure=
 to
> > > all avtab rules.
> > >
> > > Therefore, this patch adds a new structure to the avtab_datum and mov=
es
> > > the otype of the transition to this structure. In the next patch, thi=
s
> > > structure will also hold filename transitions for the combination of
> > > stype, ttype and tclass.
> > >
> > > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> >
> > I have this fear that I missed something, but I have tested
> > compatibility as much as I can and everything seems to work fine. Even
> > building older policy versions doesn't break anything that I can find.
> >
> > Patch 3 no longer applies cleanly with some of the recent dismod, but
> > it is minor and I can handle it when I merge this series.
> >
> > If at some point we allow named type transitions in conditional
> > policy, then CIL can handle all type transitions like named type
> > transitions. But that is for another day.
> >
> > For this series of eight patches:
> > Acked-by: James Carter <jwcart2@gmail.com>
> >
>
> These eight patches have been merged.
> Thanks,
> Jim

If I remember correctly the kernel patches have not been ack'ed yet.

>
>
> >
> > > ---
> > >  checkpolicy/test/dispol.c               |  2 +-
> > >  libsepol/cil/src/cil_binary.c           | 26 +++++++++++++++-----
> > >  libsepol/include/sepol/policydb/avtab.h |  7 +++++-
> > >  libsepol/src/avtab.c                    | 32 +++++++++++++++++++++++=
+-
> > >  libsepol/src/expand.c                   |  8 +++++--
> > >  libsepol/src/kernel_to_cil.c            |  3 ++-
> > >  libsepol/src/kernel_to_conf.c           |  3 ++-
> > >  libsepol/src/optimize.c                 |  4 ++++
> > >  libsepol/src/policydb_validate.c        |  4 +++-
> > >  libsepol/src/services.c                 |  5 +++-
> > >  libsepol/src/write.c                    | 17 ++++++++++---
> > >  11 files changed, 93 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> > > index bee1a660..de1a5d11 100644
> > > --- a/checkpolicy/test/dispol.c
> > > +++ b/checkpolicy/test/dispol.c
> > > @@ -180,7 +180,7 @@ static int render_av_rule(avtab_key_t * key, avta=
b_datum_t * datum, uint32_t wha
> > >                 if (key->specified & AVTAB_TRANSITION) {
> > >                         fprintf(fp, "type_transition ");
> > >                         render_key(key, p, fp);
> > > -                       render_type(datum->data, p, fp);
> > > +                       render_type(datum->trans->otype, p, fp);
> > >                         fprintf(fp, ";\n");
> > >                 }
> > >                 if (key->specified & AVTAB_MEMBER) {
> > > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_bin=
ary.c
> > > index c4ee2380..3f264594 100644
> > > --- a/libsepol/cil/src/cil_binary.c
> > > +++ b/libsepol/cil/src/cil_binary.c
> > > @@ -975,28 +975,34 @@ static int __cil_insert_type_rule(policydb_t *p=
db, uint32_t kind, uint32_t src,
> > >         int rc =3D SEPOL_OK;
> > >         avtab_key_t avtab_key;
> > >         avtab_datum_t avtab_datum;
> > > +       avtab_trans_t trans;
> > >         avtab_ptr_t existing;
> > >
> > >         avtab_key.source_type =3D src;
> > >         avtab_key.target_type =3D tgt;
> > >         avtab_key.target_class =3D obj;
> > >
> > > +       memset(&avtab_datum, 0, sizeof(avtab_datum_t));
> > > +       memset(&trans, 0, sizeof(avtab_trans_t));
> > > +
> > >         switch (kind) {
> > >         case CIL_TYPE_TRANSITION:
> > >                 avtab_key.specified =3D AVTAB_TRANSITION;
> > > +               trans.otype =3D res;
> > > +               avtab_datum.trans =3D &trans;
> > >                 break;
> > >         case CIL_TYPE_CHANGE:
> > >                 avtab_key.specified =3D AVTAB_CHANGE;
> > > +               avtab_datum.data =3D res;
> > >                 break;
> > >         case CIL_TYPE_MEMBER:
> > >                 avtab_key.specified =3D AVTAB_MEMBER;
> > > +               avtab_datum.data =3D res;
> > >                 break;
> > >         default:
> > >                 rc =3D SEPOL_ERR;
> > >                 goto exit;
> > >         }
> > > -
> > > -       avtab_datum.data =3D res;
> > >
> > >         existing =3D avtab_search_node(&pdb->te_avtab, &avtab_key);
> > >         if (existing) {
> > > @@ -1004,13 +1010,17 @@ static int __cil_insert_type_rule(policydb_t =
*pdb, uint32_t kind, uint32_t src,
> > >                  * A warning should have been previously given if the=
re is a
> > >                  * non-duplicate rule using the same key.
> > >                  */
> > > -               if (existing->datum.data !=3D res) {
> > > +               uint32_t existing_otype =3D
> > > +                       existing->key.specified & AVTAB_TRANSITION
> > > +                       ? existing->datum.trans->otype
> > > +                       : existing->datum.data;
> > > +               if (existing_otype !=3D res) {
> > >                         cil_log(CIL_ERR, "Conflicting type rules (sco=
ntext=3D%s tcontext=3D%s tclass=3D%s result=3D%s), existing=3D%s\n",
> > >                                 pdb->p_type_val_to_name[src - 1],
> > >                                 pdb->p_type_val_to_name[tgt - 1],
> > >                                 pdb->p_class_val_to_name[obj - 1],
> > >                                 pdb->p_type_val_to_name[res - 1],
> > > -                               pdb->p_type_val_to_name[existing->dat=
um.data - 1]);
> > > +                               pdb->p_type_val_to_name[existing_otyp=
e - 1]);
> > >                         cil_log(CIL_ERR, "Expanded from type rule (sc=
ontext=3D%s tcontext=3D%s tclass=3D%s result=3D%s)\n",
> > >                                 cil_rule->src_str, cil_rule->tgt_str,=
 cil_rule->obj_str, cil_rule->result_str);
> > >                         rc =3D SEPOL_ERR;
> > > @@ -1037,13 +1047,17 @@ static int __cil_insert_type_rule(policydb_t =
*pdb, uint32_t kind, uint32_t src,
> > >
> > >                         search_datum =3D cil_cond_av_list_search(&avt=
ab_key, other_list);
> > >                         if (search_datum =3D=3D NULL) {
> > > -                               if (existing->datum.data !=3D res) {
> > > +                               uint32_t existing_otype =3D
> > > +                                       existing->key.specified & AVT=
AB_TRANSITION
> > > +                                       ? existing->datum.trans->otyp=
e
> > > +                                       : existing->datum.data;
> > > +                               if (existing_otype !=3D res) {
> > >                                         cil_log(CIL_ERR, "Conflicting=
 type rules (scontext=3D%s tcontext=3D%s tclass=3D%s result=3D%s), existing=
=3D%s\n",
> > >                                                 pdb->p_type_val_to_na=
me[src - 1],
> > >                                                 pdb->p_type_val_to_na=
me[tgt - 1],
> > >                                                 pdb->p_class_val_to_n=
ame[obj - 1],
> > >                                                 pdb->p_type_val_to_na=
me[res - 1],
> > > -                                               pdb->p_type_val_to_na=
me[existing->datum.data - 1]);
> > > +                                               pdb->p_type_val_to_na=
me[existing_otype - 1]);
> > >                                         cil_log(CIL_ERR, "Expanded fr=
om type rule (scontext=3D%s tcontext=3D%s tclass=3D%s result=3D%s)\n",
> > >                                                 cil_rule->src_str, ci=
l_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
> > >                                         rc =3D SEPOL_ERR;
> > > diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/inclu=
de/sepol/policydb/avtab.h
> > > index e4c48576..ca009c16 100644
> > > --- a/libsepol/include/sepol/policydb/avtab.h
> > > +++ b/libsepol/include/sepol/policydb/avtab.h
> > > @@ -70,6 +70,10 @@ typedef struct avtab_key {
> > >         uint16_t specified;     /* what fields are specified */
> > >  } avtab_key_t;
> > >
> > > +typedef struct avtab_trans {
> > > +       uint32_t otype;         /* resulting type of the new object *=
/
> > > +} avtab_trans_t;
> > > +
> > >  typedef struct avtab_extended_perms {
> > >
> > >  #define AVTAB_XPERMS_IOCTLFUNCTION     0x01
> > > @@ -81,7 +85,8 @@ typedef struct avtab_extended_perms {
> > >  } avtab_extended_perms_t;
> > >
> > >  typedef struct avtab_datum {
> > > -       uint32_t data;          /* access vector or type */
> > > +       uint32_t data;          /* access vector, member or change va=
lue */
> > > +       avtab_trans_t *trans;   /* transition value */
> > >         avtab_extended_perms_t *xperms;
> > >  } avtab_datum_t;
> > >
> > > diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> > > index 82fec783..4c292e8b 100644
> > > --- a/libsepol/src/avtab.c
> > > +++ b/libsepol/src/avtab.c
> > > @@ -94,6 +94,7 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_pt=
r_t prev, avtab_key_t * key,
> > >                   avtab_datum_t * datum)
> > >  {
> > >         avtab_ptr_t newnode;
> > > +       avtab_trans_t *trans;
> > >         avtab_extended_perms_t *xperms;
> > >
> > >         newnode =3D (avtab_ptr_t) malloc(sizeof(struct avtab_node));
> > > @@ -117,6 +118,16 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab=
_ptr_t prev, avtab_key_t * key,
> > >                  * So copy data so it is set in the avtab
> > >                  */
> > >                 newnode->datum.data =3D datum->data;
> > > +       } else if (key->specified & AVTAB_TRANSITION) {
> > > +               trans =3D calloc(1, sizeof(*trans));
> > > +               if (trans =3D=3D NULL) {
> > > +                       free(newnode);
> > > +                       return NULL;
> > > +               }
> > > +               if (datum->trans) /* else caller populates transition=
 */
> > > +                       *trans =3D *(datum->trans);
> > > +
> > > +               newnode->datum.trans =3D trans;
> > >         } else {
> > >                 newnode->datum =3D *datum;
> > >         }
> > > @@ -317,6 +328,8 @@ void avtab_destroy(avtab_t * h)
> > >                 while (cur !=3D NULL) {
> > >                         if (cur->key.specified & AVTAB_XPERMS) {
> > >                                 free(cur->datum.xperms);
> > > +                       } else if (cur->key.specified & AVTAB_TRANSIT=
ION) {
> > > +                               free(cur->datum.trans);
> > >                         }
> > >                         temp =3D cur;
> > >                         cur =3D cur->next;
> > > @@ -440,6 +453,7 @@ int avtab_read_item(struct policy_file *fp, uint3=
2_t vers, avtab_t * a,
> > >         uint32_t buf32[8], items, items2, val;
> > >         avtab_key_t key;
> > >         avtab_datum_t datum;
> > > +       avtab_trans_t trans;
> > >         avtab_extended_perms_t xperms;
> > >         unsigned set;
> > >         unsigned int i;
> > > @@ -447,6 +461,7 @@ int avtab_read_item(struct policy_file *fp, uint3=
2_t vers, avtab_t * a,
> > >
> > >         memset(&key, 0, sizeof(avtab_key_t));
> > >         memset(&datum, 0, sizeof(avtab_datum_t));
> > > +       memset(&trans, 0, sizeof(avtab_trans_t));
> > >         memset(&xperms, 0, sizeof(avtab_extended_perms_t));
> > >
> > >         if (vers < POLICYDB_VERSION_AVTAB) {
> > > @@ -509,7 +524,14 @@ int avtab_read_item(struct policy_file *fp, uint=
32_t vers, avtab_t * a,
> > >                                         return -1;
> > >                                 }
> > >                                 key.specified =3D spec_order[i] | ena=
bled;
> > > -                               datum.data =3D le32_to_cpu(buf32[item=
s++]);
> > > +                               if (key.specified & AVTAB_TRANSITION)=
 {
> > > +                                       trans.otype =3D
> > > +                                               le32_to_cpu(buf32[ite=
ms++]);
> > > +                                       datum.trans =3D &trans;
> > > +                               } else {
> > > +                                       datum.data =3D
> > > +                                               le32_to_cpu(buf32[ite=
ms++]);
> > > +                               }
> > >                                 rc =3D insertf(a, &key, &datum, p);
> > >                                 if (rc)
> > >                                         return rc;
> > > @@ -571,6 +593,14 @@ int avtab_read_item(struct policy_file *fp, uint=
32_t vers, avtab_t * a,
> > >                 for (i =3D 0; i < ARRAY_SIZE(xperms.perms); i++)
> > >                         xperms.perms[i] =3D le32_to_cpu(buf32[i]);
> > >                 datum.xperms =3D &xperms;
> > > +       } else if (key.specified & AVTAB_TRANSITION) {
> > > +               rc =3D next_entry(buf32, fp, sizeof(uint32_t));
> > > +               if (rc < 0) {
> > > +                       ERR(fp->handle, "truncated entry");
> > > +                       return -1;
> > > +               }
> > > +               trans.otype =3D le32_to_cpu(*buf32);
> > > +               datum.trans =3D &trans;
> > >         } else {
> > >                 rc =3D next_entry(buf32, fp, sizeof(uint32_t));
> > >                 if (rc < 0) {
> > > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > > index 8795229a..6793a27d 100644
> > > --- a/libsepol/src/expand.c
> > > +++ b/libsepol/src/expand.c
> > > @@ -1746,7 +1746,7 @@ static int expand_terule_helper(sepol_handle_t =
* handle,
> > >                 if (conflict) {
> > >                         avdatump =3D &node->datum;
> > >                         if (specified & AVRULE_TRANSITION) {
> > > -                               oldtype =3D avdatump->data;
> > > +                               oldtype =3D avdatump->trans->otype;
> > >                         } else if (specified & AVRULE_MEMBER) {
> > >                                 oldtype =3D avdatump->data;
> > >                         } else if (specified & AVRULE_CHANGE) {
> > > @@ -1789,7 +1789,11 @@ static int expand_terule_helper(sepol_handle_t=
 * handle,
> > >                 }
> > >
> > >                 avdatump =3D &node->datum;
> > > -               avdatump->data =3D remapped_data;
> > > +               if (specified & AVRULE_TRANSITION) {
> > > +                       avdatump->trans->otype =3D remapped_data;
> > > +               } else {
> > > +                       avdatump->data =3D remapped_data;
> > > +               }
> > >
> > >                 cur =3D cur->next;
> > >         }
> > > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_ci=
l.c
> > > index f2b0d902..b1fd1bf7 100644
> > > --- a/libsepol/src/kernel_to_cil.c
> > > +++ b/libsepol/src/kernel_to_cil.c
> > > @@ -1704,7 +1704,8 @@ static char *xperms_to_str(avtab_extended_perms=
_t *xperms)
> > >
> > >  static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *ke=
y, avtab_datum_t *datum)
> > >  {
> > > -       uint32_t data =3D datum->data;
> > > +       uint32_t data =3D key->specified & AVTAB_TRANSITION
> > > +               ? datum->trans->otype : datum->data;
> > >         type_datum_t *type;
> > >         const char *flavor, *tgt;
> > >         char *src, *class, *perms, *new;
> > > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_c=
onf.c
> > > index 15161caa..7e1e1b49 100644
> > > --- a/libsepol/src/kernel_to_conf.c
> > > +++ b/libsepol/src/kernel_to_conf.c
> > > @@ -1682,7 +1682,8 @@ exit:
> > >
> > >  static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *ke=
y, avtab_datum_t *datum)
> > >  {
> > > -       uint32_t data =3D datum->data;
> > > +       uint32_t data =3D key->specified & AVTAB_TRANSITION
> > > +               ? datum->trans->otype : datum->data;
> > >         type_datum_t *type;
> > >         const char *flavor, *src, *tgt, *class, *perms, *new;
> > >         char *rule =3D NULL;
> > > diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> > > index a38025ec..2d4a2d7a 100644
> > > --- a/libsepol/src/optimize.c
> > > +++ b/libsepol/src/optimize.c
> > > @@ -308,6 +308,8 @@ static void optimize_avtab(policydb_t *p, const s=
truct type_vec *type_map)
> > >                                 *cur =3D tmp->next;
> > >                                 if (tmp->key.specified & AVTAB_XPERMS=
)
> > >                                         free(tmp->datum.xperms);
> > > +                               if (tmp->key.specified & AVTAB_TRANSI=
TION)
> > > +                                       free(tmp->datum.trans);
> > >                                 free(tmp);
> > >
> > >                                 tab->nel--;
> > > @@ -427,6 +429,8 @@ static void optimize_cond_avtab(policydb_t *p, co=
nst struct type_vec *type_map)
> > >                                 *cur =3D tmp->next;
> > >                                 if (tmp->key.specified & AVTAB_XPERMS=
)
> > >                                         free(tmp->datum.xperms);
> > > +                               if (tmp->key.specified & AVTAB_TRANSI=
TION)
> > > +                                       free(tmp->datum.trans);
> > >                                 free(tmp);
> > >
> > >                                 tab->nel--;
> > > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb=
_validate.c
> > > index 3540f34a..f402b506 100644
> > > --- a/libsepol/src/policydb_validate.c
> > > +++ b/libsepol/src/policydb_validate.c
> > > @@ -836,7 +836,9 @@ static int validate_avtab_key_and_datum(avtab_key=
_t *k, avtab_datum_t *d, void *
> > >         if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
> > >                 return -1;
> > >
> > > -       if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->dat=
a, margs->policy, margs->flavors))
> > > +       uint32_t otype =3D k->specified & AVTAB_TRANSITION
> > > +               ? d->trans->otype : d->data;
> > > +       if ((k->specified & AVTAB_TYPE) && validate_simpletype(otype,=
 margs->policy, margs->flavors))
> > >                 return -1;
> > >
> > >         if ((k->specified & AVTAB_XPERMS) && validate_xperms(d->xperm=
s))
> > > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > > index 062510ab..72772dbd 100644
> > > --- a/libsepol/src/services.c
> > > +++ b/libsepol/src/services.c
> > > @@ -1423,7 +1423,10 @@ static int sepol_compute_sid(sepol_security_id=
_t ssid,
> > >
> > >         if (avdatum) {
> > >                 /* Use the type from the type transition/member/chang=
e rule. */
> > > -               newcontext.type =3D avdatum->data;
> > > +               if (specified & AVTAB_TRANSITION)
> > > +                       newcontext.type =3D avdatum->trans->otype;
> > > +               else
> > > +                       newcontext.type =3D avdatum->data;
> > >         }
> > >
> > >         /* Check for class-specific changes. */
> > > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > > index 024fe628..0d3d5f14 100644
> > > --- a/libsepol/src/write.c
> > > +++ b/libsepol/src/write.c
> > > @@ -190,14 +190,20 @@ static int avtab_write_item(policydb_t * p,
> > >                                                 ERR(fp->handle, "miss=
ing node");
> > >                                                 return POLICYDB_ERROR=
;
> > >                                         }
> > > -                                       buf32[items++] =3D
> > > -                                           cpu_to_le32(node->datum.d=
ata);
> > > +                                       uint32_t data =3D
> > > +                                               node->key.specified &=
 AVTAB_TRANSITION
> > > +                                               ? node->datum.trans->=
otype
> > > +                                               : node->datum.data;
> > > +                                       buf32[items++] =3D cpu_to_le3=
2(data);
> > >                                         set--;
> > >                                         node->merged =3D 1;
> > >                                 }
> > >                         }
> > >                 } else {
> > > -                       buf32[items++] =3D cpu_to_le32(cur->datum.dat=
a);
> > > +                       uint32_t data =3D cur->key.specified & AVTAB_=
TRANSITION
> > > +                               ? cur->datum.trans->otype
> > > +                               : cur->datum.data;
> > > +                       buf32[items++] =3D cpu_to_le32(data);
> > >                         cur->merged =3D 1;
> > >                         set--;
> > >                 }
> > > @@ -256,6 +262,11 @@ static int avtab_write_item(policydb_t * p,
> > >                 items =3D put_entry(buf32, sizeof(uint32_t),8,fp);
> > >                 if (items !=3D 8)
> > >                         return POLICYDB_ERROR;
> > > +       } else if (cur->key.specified & AVTAB_TRANSITION) {
> > > +               buf32[0] =3D cpu_to_le32(cur->datum.trans->otype);
> > > +               items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
> > > +               if (items !=3D 1)
> > > +                       return POLICYDB_ERROR;
> > >         } else {
> > >                 buf32[0] =3D cpu_to_le32(cur->datum.data);
> > >                 items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
> > > --
> > > 2.40.0
> > >
