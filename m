Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA048EB64DA
	for <selinux@archiver.kernel.org>; Wed, 12 Jul 2023 19:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGLTto (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGLTtn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jul 2023 15:49:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F91989
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 12:49:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b708e49059so117914901fa.3
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689191379; x=1691783379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3UQB6jZvLY1OvA2/n30ICF0n8Rb7qI8kFxf3oP8P6c=;
        b=a/mpLqaO6BRODbwuJjydNHzAOFN67Shm7souX35uef5VZP47BnqS3sEYdhEHoYw0wE
         K+TFenpsMXgVWMG7trnf/mHtKtGSLBh5nLCXFopk082r8KNHFx5qS9tIboQLWQj5P8yV
         +Yo919omfEKznmKwz4ehJP4RZyowuxJKpeiNFra/ddaHu1lih1OJuytQ2d/ynIu+UpYR
         plq+/6ae5oQsQORDW4O3ndr+j1QXPn7NADgYcMBAATwdqvAHbchPh2s0HPFuMUkdD6Ag
         x3qDw827NGIB+nGr/kUcyBCPU6GbYH36W8jHnAx82yLzfz6rPZqqbyaPyXZrVDlGKuhN
         ohaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689191379; x=1691783379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3UQB6jZvLY1OvA2/n30ICF0n8Rb7qI8kFxf3oP8P6c=;
        b=RTwsLV45KmUTDzTzfRIf4P7qU5f9r3V9Q/qD7DyIhoTpmHDxrmz2sLHbwrxtWHvPM6
         XDK97MxeJ2yAElgJPd2e/We7n4tBKSENaco0LCB1Y6qaIeCofgHZX/jbbd1c0H6Ef3em
         WhQLJSNeQMFvBp+FGC2RKD43eRD669UFi9sMZ7UBL4nsfFXagQrC41q8LVFNhAtWGa10
         HSJo/BCWjF310z8Cwu//Xdj3BPGQaQbgMqTPCe2kj5715XdsHJsEBmDRTdC6v/exN39r
         XyK2sJqt0/dfbqId5yDfIFXOiIuER/V8rv/QLHZfeUCGoP6bSoMOuiX+9qzc5Rga0Tit
         Cu9A==
X-Gm-Message-State: ABy/qLZI/D3RA3ZOh0nTxSQFPk5kVLCzy3hB3oRExYNegV3zVF2LwopX
        /XGBKkQnUE7j8LRB6d3dFFMQnCE1Vxh41gU3RDjK+8lM
X-Google-Smtp-Source: APBJJlHwLyPlbPVgVn6OnX9/IM4D288lfopXpZGmJ4vxSCEba+arA4h613ncz97718LTbHhaejHxM8AOwUwu/pueLzg=
X-Received: by 2002:a2e:b0ca:0:b0:2b6:e105:6174 with SMTP id
 g10-20020a2eb0ca000000b002b6e1056174mr16688972ljl.47.1689191378518; Wed, 12
 Jul 2023 12:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687251081.git.juraj@jurajmarcin.com> <cc615a87b1025866d6332bce787dece49766ca52.1687251081.git.juraj@jurajmarcin.com>
 <CAP+JOzS4PSk_iupHQY=Lj=TOow_AQ5x2w+jFNX9Qin24O0s-yw@mail.gmail.com>
 <CAP+JOzSPTvkVomJsU9+GN7TWbHeRjWJW3qQqVLbSesfT=VR-Lw@mail.gmail.com> <CAJ2a_De6enDgX6tQz8n5ShyisEqDyxco5DyqTu9vUzxMWzJ-FQ@mail.gmail.com>
In-Reply-To: <CAJ2a_De6enDgX6tQz8n5ShyisEqDyxco5DyqTu9vUzxMWzJ-FQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Jul 2023 15:49:26 -0400
Message-ID: <CAP+JOzTN=8xXemvARYUFqk+KNVeB0QAgDgEp9z=mxfh-3aZYog@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] checkpolicy,libsepol: move transition to separate
 structure in avtab
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Juraj Marcin <juraj@jurajmarcin.com>, selinux@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 12, 2023 at 3:17=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 12 Jul 2023 at 19:34, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Fri, Jul 7, 2023 at 2:12=E2=80=AFPM James Carter <jwcart2@gmail.com>=
 wrote:
> > >
> > > On Tue, Jun 20, 2023 at 5:11=E2=80=AFAM Juraj Marcin <juraj@jurajmarc=
in.com> wrote:
> > > >
> > > > To move filename transitions to be part of avtab, we need to create
> > > > space for it in the avtab_datum structure which holds the rule for
> > > > a certain combination of stype, ttype and tclass.
> > > >
> > > > As only type transitions have a special variant that uses a filenam=
e, it
> > > > would be suboptimal to add a (mostly empty) pointer to some structu=
re to
> > > > all avtab rules.
> > > >
> > > > Therefore, this patch adds a new structure to the avtab_datum and m=
oves
> > > > the otype of the transition to this structure. In the next patch, t=
his
> > > > structure will also hold filename transitions for the combination o=
f
> > > > stype, ttype and tclass.
> > > >
> > > > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> > >
> > > I have this fear that I missed something, but I have tested
> > > compatibility as much as I can and everything seems to work fine. Eve=
n
> > > building older policy versions doesn't break anything that I can find=
.
> > >
> > > Patch 3 no longer applies cleanly with some of the recent dismod, but
> > > it is minor and I can handle it when I merge this series.
> > >
> > > If at some point we allow named type transitions in conditional
> > > policy, then CIL can handle all type transitions like named type
> > > transitions. But that is for another day.
> > >
> > > For this series of eight patches:
> > > Acked-by: James Carter <jwcart2@gmail.com>
> > >
> >
> > These eight patches have been merged.
> > Thanks,
> > Jim
>
> If I remember correctly the kernel patches have not been ack'ed yet.
>
Yeah, you're right. I was thinking of the initial sid patches. I might
have jumped the gun a bit here.
Thanks,
Jim

> >
> >
> > >
> > > > ---
> > > >  checkpolicy/test/dispol.c               |  2 +-
> > > >  libsepol/cil/src/cil_binary.c           | 26 +++++++++++++++-----
> > > >  libsepol/include/sepol/policydb/avtab.h |  7 +++++-
> > > >  libsepol/src/avtab.c                    | 32 +++++++++++++++++++++=
+++-
> > > >  libsepol/src/expand.c                   |  8 +++++--
> > > >  libsepol/src/kernel_to_cil.c            |  3 ++-
> > > >  libsepol/src/kernel_to_conf.c           |  3 ++-
> > > >  libsepol/src/optimize.c                 |  4 ++++
> > > >  libsepol/src/policydb_validate.c        |  4 +++-
> > > >  libsepol/src/services.c                 |  5 +++-
> > > >  libsepol/src/write.c                    | 17 ++++++++++---
> > > >  11 files changed, 93 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> > > > index bee1a660..de1a5d11 100644
> > > > --- a/checkpolicy/test/dispol.c
> > > > +++ b/checkpolicy/test/dispol.c
> > > > @@ -180,7 +180,7 @@ static int render_av_rule(avtab_key_t * key, av=
tab_datum_t * datum, uint32_t wha
> > > >                 if (key->specified & AVTAB_TRANSITION) {
> > > >                         fprintf(fp, "type_transition ");
> > > >                         render_key(key, p, fp);
> > > > -                       render_type(datum->data, p, fp);
> > > > +                       render_type(datum->trans->otype, p, fp);
> > > >                         fprintf(fp, ";\n");
> > > >                 }
> > > >                 if (key->specified & AVTAB_MEMBER) {
> > > > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_b=
inary.c
> > > > index c4ee2380..3f264594 100644
> > > > --- a/libsepol/cil/src/cil_binary.c
> > > > +++ b/libsepol/cil/src/cil_binary.c
> > > > @@ -975,28 +975,34 @@ static int __cil_insert_type_rule(policydb_t =
*pdb, uint32_t kind, uint32_t src,
> > > >         int rc =3D SEPOL_OK;
> > > >         avtab_key_t avtab_key;
> > > >         avtab_datum_t avtab_datum;
> > > > +       avtab_trans_t trans;
> > > >         avtab_ptr_t existing;
> > > >
> > > >         avtab_key.source_type =3D src;
> > > >         avtab_key.target_type =3D tgt;
> > > >         avtab_key.target_class =3D obj;
> > > >
> > > > +       memset(&avtab_datum, 0, sizeof(avtab_datum_t));
> > > > +       memset(&trans, 0, sizeof(avtab_trans_t));
> > > > +
> > > >         switch (kind) {
> > > >         case CIL_TYPE_TRANSITION:
> > > >                 avtab_key.specified =3D AVTAB_TRANSITION;
> > > > +               trans.otype =3D res;
> > > > +               avtab_datum.trans =3D &trans;
> > > >                 break;
> > > >         case CIL_TYPE_CHANGE:
> > > >                 avtab_key.specified =3D AVTAB_CHANGE;
> > > > +               avtab_datum.data =3D res;
> > > >                 break;
> > > >         case CIL_TYPE_MEMBER:
> > > >                 avtab_key.specified =3D AVTAB_MEMBER;
> > > > +               avtab_datum.data =3D res;
> > > >                 break;
> > > >         default:
> > > >                 rc =3D SEPOL_ERR;
> > > >                 goto exit;
> > > >         }
> > > > -
> > > > -       avtab_datum.data =3D res;
> > > >
> > > >         existing =3D avtab_search_node(&pdb->te_avtab, &avtab_key);
> > > >         if (existing) {
> > > > @@ -1004,13 +1010,17 @@ static int __cil_insert_type_rule(policydb_=
t *pdb, uint32_t kind, uint32_t src,
> > > >                  * A warning should have been previously given if t=
here is a
> > > >                  * non-duplicate rule using the same key.
> > > >                  */
> > > > -               if (existing->datum.data !=3D res) {
> > > > +               uint32_t existing_otype =3D
> > > > +                       existing->key.specified & AVTAB_TRANSITION
> > > > +                       ? existing->datum.trans->otype
> > > > +                       : existing->datum.data;
> > > > +               if (existing_otype !=3D res) {
> > > >                         cil_log(CIL_ERR, "Conflicting type rules (s=
context=3D%s tcontext=3D%s tclass=3D%s result=3D%s), existing=3D%s\n",
> > > >                                 pdb->p_type_val_to_name[src - 1],
> > > >                                 pdb->p_type_val_to_name[tgt - 1],
> > > >                                 pdb->p_class_val_to_name[obj - 1],
> > > >                                 pdb->p_type_val_to_name[res - 1],
> > > > -                               pdb->p_type_val_to_name[existing->d=
atum.data - 1]);
> > > > +                               pdb->p_type_val_to_name[existing_ot=
ype - 1]);
> > > >                         cil_log(CIL_ERR, "Expanded from type rule (=
scontext=3D%s tcontext=3D%s tclass=3D%s result=3D%s)\n",
> > > >                                 cil_rule->src_str, cil_rule->tgt_st=
r, cil_rule->obj_str, cil_rule->result_str);
> > > >                         rc =3D SEPOL_ERR;
> > > > @@ -1037,13 +1047,17 @@ static int __cil_insert_type_rule(policydb_=
t *pdb, uint32_t kind, uint32_t src,
> > > >
> > > >                         search_datum =3D cil_cond_av_list_search(&a=
vtab_key, other_list);
> > > >                         if (search_datum =3D=3D NULL) {
> > > > -                               if (existing->datum.data !=3D res) =
{
> > > > +                               uint32_t existing_otype =3D
> > > > +                                       existing->key.specified & A=
VTAB_TRANSITION
> > > > +                                       ? existing->datum.trans->ot=
ype
> > > > +                                       : existing->datum.data;
> > > > +                               if (existing_otype !=3D res) {
> > > >                                         cil_log(CIL_ERR, "Conflicti=
ng type rules (scontext=3D%s tcontext=3D%s tclass=3D%s result=3D%s), existi=
ng=3D%s\n",
> > > >                                                 pdb->p_type_val_to_=
name[src - 1],
> > > >                                                 pdb->p_type_val_to_=
name[tgt - 1],
> > > >                                                 pdb->p_class_val_to=
_name[obj - 1],
> > > >                                                 pdb->p_type_val_to_=
name[res - 1],
> > > > -                                               pdb->p_type_val_to_=
name[existing->datum.data - 1]);
> > > > +                                               pdb->p_type_val_to_=
name[existing_otype - 1]);
> > > >                                         cil_log(CIL_ERR, "Expanded =
from type rule (scontext=3D%s tcontext=3D%s tclass=3D%s result=3D%s)\n",
> > > >                                                 cil_rule->src_str, =
cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
> > > >                                         rc =3D SEPOL_ERR;
> > > > diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/inc=
lude/sepol/policydb/avtab.h
> > > > index e4c48576..ca009c16 100644
> > > > --- a/libsepol/include/sepol/policydb/avtab.h
> > > > +++ b/libsepol/include/sepol/policydb/avtab.h
> > > > @@ -70,6 +70,10 @@ typedef struct avtab_key {
> > > >         uint16_t specified;     /* what fields are specified */
> > > >  } avtab_key_t;
> > > >
> > > > +typedef struct avtab_trans {
> > > > +       uint32_t otype;         /* resulting type of the new object=
 */
> > > > +} avtab_trans_t;
> > > > +
> > > >  typedef struct avtab_extended_perms {
> > > >
> > > >  #define AVTAB_XPERMS_IOCTLFUNCTION     0x01
> > > > @@ -81,7 +85,8 @@ typedef struct avtab_extended_perms {
> > > >  } avtab_extended_perms_t;
> > > >
> > > >  typedef struct avtab_datum {
> > > > -       uint32_t data;          /* access vector or type */
> > > > +       uint32_t data;          /* access vector, member or change =
value */
> > > > +       avtab_trans_t *trans;   /* transition value */
> > > >         avtab_extended_perms_t *xperms;
> > > >  } avtab_datum_t;
> > > >
> > > > diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> > > > index 82fec783..4c292e8b 100644
> > > > --- a/libsepol/src/avtab.c
> > > > +++ b/libsepol/src/avtab.c
> > > > @@ -94,6 +94,7 @@ avtab_insert_node(avtab_t * h, int hvalue, avtab_=
ptr_t prev, avtab_key_t * key,
> > > >                   avtab_datum_t * datum)
> > > >  {
> > > >         avtab_ptr_t newnode;
> > > > +       avtab_trans_t *trans;
> > > >         avtab_extended_perms_t *xperms;
> > > >
> > > >         newnode =3D (avtab_ptr_t) malloc(sizeof(struct avtab_node))=
;
> > > > @@ -117,6 +118,16 @@ avtab_insert_node(avtab_t * h, int hvalue, avt=
ab_ptr_t prev, avtab_key_t * key,
> > > >                  * So copy data so it is set in the avtab
> > > >                  */
> > > >                 newnode->datum.data =3D datum->data;
> > > > +       } else if (key->specified & AVTAB_TRANSITION) {
> > > > +               trans =3D calloc(1, sizeof(*trans));
> > > > +               if (trans =3D=3D NULL) {
> > > > +                       free(newnode);
> > > > +                       return NULL;
> > > > +               }
> > > > +               if (datum->trans) /* else caller populates transiti=
on */
> > > > +                       *trans =3D *(datum->trans);
> > > > +
> > > > +               newnode->datum.trans =3D trans;
> > > >         } else {
> > > >                 newnode->datum =3D *datum;
> > > >         }
> > > > @@ -317,6 +328,8 @@ void avtab_destroy(avtab_t * h)
> > > >                 while (cur !=3D NULL) {
> > > >                         if (cur->key.specified & AVTAB_XPERMS) {
> > > >                                 free(cur->datum.xperms);
> > > > +                       } else if (cur->key.specified & AVTAB_TRANS=
ITION) {
> > > > +                               free(cur->datum.trans);
> > > >                         }
> > > >                         temp =3D cur;
> > > >                         cur =3D cur->next;
> > > > @@ -440,6 +453,7 @@ int avtab_read_item(struct policy_file *fp, uin=
t32_t vers, avtab_t * a,
> > > >         uint32_t buf32[8], items, items2, val;
> > > >         avtab_key_t key;
> > > >         avtab_datum_t datum;
> > > > +       avtab_trans_t trans;
> > > >         avtab_extended_perms_t xperms;
> > > >         unsigned set;
> > > >         unsigned int i;
> > > > @@ -447,6 +461,7 @@ int avtab_read_item(struct policy_file *fp, uin=
t32_t vers, avtab_t * a,
> > > >
> > > >         memset(&key, 0, sizeof(avtab_key_t));
> > > >         memset(&datum, 0, sizeof(avtab_datum_t));
> > > > +       memset(&trans, 0, sizeof(avtab_trans_t));
> > > >         memset(&xperms, 0, sizeof(avtab_extended_perms_t));
> > > >
> > > >         if (vers < POLICYDB_VERSION_AVTAB) {
> > > > @@ -509,7 +524,14 @@ int avtab_read_item(struct policy_file *fp, ui=
nt32_t vers, avtab_t * a,
> > > >                                         return -1;
> > > >                                 }
> > > >                                 key.specified =3D spec_order[i] | e=
nabled;
> > > > -                               datum.data =3D le32_to_cpu(buf32[it=
ems++]);
> > > > +                               if (key.specified & AVTAB_TRANSITIO=
N) {
> > > > +                                       trans.otype =3D
> > > > +                                               le32_to_cpu(buf32[i=
tems++]);
> > > > +                                       datum.trans =3D &trans;
> > > > +                               } else {
> > > > +                                       datum.data =3D
> > > > +                                               le32_to_cpu(buf32[i=
tems++]);
> > > > +                               }
> > > >                                 rc =3D insertf(a, &key, &datum, p);
> > > >                                 if (rc)
> > > >                                         return rc;
> > > > @@ -571,6 +593,14 @@ int avtab_read_item(struct policy_file *fp, ui=
nt32_t vers, avtab_t * a,
> > > >                 for (i =3D 0; i < ARRAY_SIZE(xperms.perms); i++)
> > > >                         xperms.perms[i] =3D le32_to_cpu(buf32[i]);
> > > >                 datum.xperms =3D &xperms;
> > > > +       } else if (key.specified & AVTAB_TRANSITION) {
> > > > +               rc =3D next_entry(buf32, fp, sizeof(uint32_t));
> > > > +               if (rc < 0) {
> > > > +                       ERR(fp->handle, "truncated entry");
> > > > +                       return -1;
> > > > +               }
> > > > +               trans.otype =3D le32_to_cpu(*buf32);
> > > > +               datum.trans =3D &trans;
> > > >         } else {
> > > >                 rc =3D next_entry(buf32, fp, sizeof(uint32_t));
> > > >                 if (rc < 0) {
> > > > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > > > index 8795229a..6793a27d 100644
> > > > --- a/libsepol/src/expand.c
> > > > +++ b/libsepol/src/expand.c
> > > > @@ -1746,7 +1746,7 @@ static int expand_terule_helper(sepol_handle_=
t * handle,
> > > >                 if (conflict) {
> > > >                         avdatump =3D &node->datum;
> > > >                         if (specified & AVRULE_TRANSITION) {
> > > > -                               oldtype =3D avdatump->data;
> > > > +                               oldtype =3D avdatump->trans->otype;
> > > >                         } else if (specified & AVRULE_MEMBER) {
> > > >                                 oldtype =3D avdatump->data;
> > > >                         } else if (specified & AVRULE_CHANGE) {
> > > > @@ -1789,7 +1789,11 @@ static int expand_terule_helper(sepol_handle=
_t * handle,
> > > >                 }
> > > >
> > > >                 avdatump =3D &node->datum;
> > > > -               avdatump->data =3D remapped_data;
> > > > +               if (specified & AVRULE_TRANSITION) {
> > > > +                       avdatump->trans->otype =3D remapped_data;
> > > > +               } else {
> > > > +                       avdatump->data =3D remapped_data;
> > > > +               }
> > > >
> > > >                 cur =3D cur->next;
> > > >         }
> > > > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_=
cil.c
> > > > index f2b0d902..b1fd1bf7 100644
> > > > --- a/libsepol/src/kernel_to_cil.c
> > > > +++ b/libsepol/src/kernel_to_cil.c
> > > > @@ -1704,7 +1704,8 @@ static char *xperms_to_str(avtab_extended_per=
ms_t *xperms)
> > > >
> > > >  static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *=
key, avtab_datum_t *datum)
> > > >  {
> > > > -       uint32_t data =3D datum->data;
> > > > +       uint32_t data =3D key->specified & AVTAB_TRANSITION
> > > > +               ? datum->trans->otype : datum->data;
> > > >         type_datum_t *type;
> > > >         const char *flavor, *tgt;
> > > >         char *src, *class, *perms, *new;
> > > > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to=
_conf.c
> > > > index 15161caa..7e1e1b49 100644
> > > > --- a/libsepol/src/kernel_to_conf.c
> > > > +++ b/libsepol/src/kernel_to_conf.c
> > > > @@ -1682,7 +1682,8 @@ exit:
> > > >
> > > >  static char *avtab_node_to_str(struct policydb *pdb, avtab_key_t *=
key, avtab_datum_t *datum)
> > > >  {
> > > > -       uint32_t data =3D datum->data;
> > > > +       uint32_t data =3D key->specified & AVTAB_TRANSITION
> > > > +               ? datum->trans->otype : datum->data;
> > > >         type_datum_t *type;
> > > >         const char *flavor, *src, *tgt, *class, *perms, *new;
> > > >         char *rule =3D NULL;
> > > > diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> > > > index a38025ec..2d4a2d7a 100644
> > > > --- a/libsepol/src/optimize.c
> > > > +++ b/libsepol/src/optimize.c
> > > > @@ -308,6 +308,8 @@ static void optimize_avtab(policydb_t *p, const=
 struct type_vec *type_map)
> > > >                                 *cur =3D tmp->next;
> > > >                                 if (tmp->key.specified & AVTAB_XPER=
MS)
> > > >                                         free(tmp->datum.xperms);
> > > > +                               if (tmp->key.specified & AVTAB_TRAN=
SITION)
> > > > +                                       free(tmp->datum.trans);
> > > >                                 free(tmp);
> > > >
> > > >                                 tab->nel--;
> > > > @@ -427,6 +429,8 @@ static void optimize_cond_avtab(policydb_t *p, =
const struct type_vec *type_map)
> > > >                                 *cur =3D tmp->next;
> > > >                                 if (tmp->key.specified & AVTAB_XPER=
MS)
> > > >                                         free(tmp->datum.xperms);
> > > > +                               if (tmp->key.specified & AVTAB_TRAN=
SITION)
> > > > +                                       free(tmp->datum.trans);
> > > >                                 free(tmp);
> > > >
> > > >                                 tab->nel--;
> > > > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policy=
db_validate.c
> > > > index 3540f34a..f402b506 100644
> > > > --- a/libsepol/src/policydb_validate.c
> > > > +++ b/libsepol/src/policydb_validate.c
> > > > @@ -836,7 +836,9 @@ static int validate_avtab_key_and_datum(avtab_k=
ey_t *k, avtab_datum_t *d, void *
> > > >         if (validate_avtab_key(k, 0, margs->policy, margs->flavors)=
)
> > > >                 return -1;
> > > >
> > > > -       if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->d=
ata, margs->policy, margs->flavors))
> > > > +       uint32_t otype =3D k->specified & AVTAB_TRANSITION
> > > > +               ? d->trans->otype : d->data;
> > > > +       if ((k->specified & AVTAB_TYPE) && validate_simpletype(otyp=
e, margs->policy, margs->flavors))
> > > >                 return -1;
> > > >
> > > >         if ((k->specified & AVTAB_XPERMS) && validate_xperms(d->xpe=
rms))
> > > > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > > > index 062510ab..72772dbd 100644
> > > > --- a/libsepol/src/services.c
> > > > +++ b/libsepol/src/services.c
> > > > @@ -1423,7 +1423,10 @@ static int sepol_compute_sid(sepol_security_=
id_t ssid,
> > > >
> > > >         if (avdatum) {
> > > >                 /* Use the type from the type transition/member/cha=
nge rule. */
> > > > -               newcontext.type =3D avdatum->data;
> > > > +               if (specified & AVTAB_TRANSITION)
> > > > +                       newcontext.type =3D avdatum->trans->otype;
> > > > +               else
> > > > +                       newcontext.type =3D avdatum->data;
> > > >         }
> > > >
> > > >         /* Check for class-specific changes. */
> > > > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > > > index 024fe628..0d3d5f14 100644
> > > > --- a/libsepol/src/write.c
> > > > +++ b/libsepol/src/write.c
> > > > @@ -190,14 +190,20 @@ static int avtab_write_item(policydb_t * p,
> > > >                                                 ERR(fp->handle, "mi=
ssing node");
> > > >                                                 return POLICYDB_ERR=
OR;
> > > >                                         }
> > > > -                                       buf32[items++] =3D
> > > > -                                           cpu_to_le32(node->datum=
.data);
> > > > +                                       uint32_t data =3D
> > > > +                                               node->key.specified=
 & AVTAB_TRANSITION
> > > > +                                               ? node->datum.trans=
->otype
> > > > +                                               : node->datum.data;
> > > > +                                       buf32[items++] =3D cpu_to_l=
e32(data);
> > > >                                         set--;
> > > >                                         node->merged =3D 1;
> > > >                                 }
> > > >                         }
> > > >                 } else {
> > > > -                       buf32[items++] =3D cpu_to_le32(cur->datum.d=
ata);
> > > > +                       uint32_t data =3D cur->key.specified & AVTA=
B_TRANSITION
> > > > +                               ? cur->datum.trans->otype
> > > > +                               : cur->datum.data;
> > > > +                       buf32[items++] =3D cpu_to_le32(data);
> > > >                         cur->merged =3D 1;
> > > >                         set--;
> > > >                 }
> > > > @@ -256,6 +262,11 @@ static int avtab_write_item(policydb_t * p,
> > > >                 items =3D put_entry(buf32, sizeof(uint32_t),8,fp);
> > > >                 if (items !=3D 8)
> > > >                         return POLICYDB_ERROR;
> > > > +       } else if (cur->key.specified & AVTAB_TRANSITION) {
> > > > +               buf32[0] =3D cpu_to_le32(cur->datum.trans->otype);
> > > > +               items =3D put_entry(buf32, sizeof(uint32_t), 1, fp)=
;
> > > > +               if (items !=3D 1)
> > > > +                       return POLICYDB_ERROR;
> > > >         } else {
> > > >                 buf32[0] =3D cpu_to_le32(cur->datum.data);
> > > >                 items =3D put_entry(buf32, sizeof(uint32_t), 1, fp)=
;
> > > > --
> > > > 2.40.0
> > > >
