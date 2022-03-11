Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9CBC433EF
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 16:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiCKQFs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiCKQFs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 11:05:48 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF831CE9AF
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:04:44 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so10934598oof.12
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qTO5mX1FM/+6W5xSP4KQdwOBfrUT+BXjg0gmMk7CFoo=;
        b=KTWVX5AuKj55KTri0WiEk24WyihrIRy9hRTHyR7vbjIae3DlOSJxhJmrlpRQXbN3Ec
         ypG1//EA9K6Wfc3GurJacmLucDTs23j619RniZahVGEn7JitiN5q0NTH4ZPa/LWKfs/S
         BFTVkgUWYH/qZQrv26NG+8T0skhTEXoTNvR8UQBc6IrtLIpOigCHEjUzCJ6emBb2N/Yu
         8+bO1LxFAtSr0H/ajeI7xYtgvBokXYa0lF933398Wdt6gtmHB2WrTc4hSKEDEHG/50RZ
         PTYu5PxhxyVTWaCBtyQdy2xiIMPaS/5or5exkxQm76qf59/AvMheGysJOizw1d6xk+A4
         H2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qTO5mX1FM/+6W5xSP4KQdwOBfrUT+BXjg0gmMk7CFoo=;
        b=1m/y1LS1LUxN6hm6+kyVN1Kj+pYvQyNWVQUJDICmb+oVHBC2xOQqdzfcDJrk9L/nDT
         4eP8v3I8nzQdCHQFSAZ9GU4BVdhPzDdonA6cnZxI6fw45LxHKO30jHJYV6TQpx3rEeML
         ZBlETpl+BonyCbgzjLMcAKhJrev2QVs+cm7vLT+IyC1BYKYmM+YlO9usBSqKwC/8ZhCd
         aKUEsV/DBs03Cc5Gs30datifXf4uhgUrceKyyeRiqbnfYxzsn4my62UYPR79CAA4zVo6
         UyhbtOnUgr3EnJ+ris7e7mHigkjSLkQV3RvhmfCZHf57272CXAsVvHexO2kjTHyNMBe0
         NPrQ==
X-Gm-Message-State: AOAM533jLjIdeFOwBAIpRdaMUiJdaNBXJsr6DIqthghl4zTme2gjNX76
        dn5XSFDYG8qwQ2Aq14+602G6YVSSmDJiEohXzwnU96jy
X-Google-Smtp-Source: ABdhPJw1C6WDjevOjWarJEtmJrkzzOUb2CpPNQ23vroshHnAEmLh00WZBhCrjolmWs5hdncICPXpBx+4f5d5/zwda8I=
X-Received: by 2002:a05:6870:46ab:b0:d9:cbf6:855c with SMTP id
 a43-20020a05687046ab00b000d9cbf6855cmr10949173oap.156.1647014683901; Fri, 11
 Mar 2022 08:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20220308185811.72407-1-cgzones@googlemail.com> <CAP+JOzQzJHNgxdOFj1LA6BKNpcxmVmA=vnF=EzsQoAeip+KqEw@mail.gmail.com>
In-Reply-To: <CAP+JOzQzJHNgxdOFj1LA6BKNpcxmVmA=vnF=EzsQoAeip+KqEw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Mar 2022 11:04:33 -0500
Message-ID: <CAP+JOzQRGPX4aY8srGbs72QQsQEe5uq8uOgo9f1n1W4pT0etHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: reject xperm av rules in conditional statements
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 11, 2022 at 9:57 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Mar 8, 2022 at 2:35 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Extended permission and neverallow rules are not permitted in
> > conditional statements.
> >
> > This causes issues on policy optimization where avtab_search() might
> > return a non extended permission rule when searching for one.
> >
> > Found by oss-fuzz (#45327)
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For both patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These patches have been merged.
Thanks,
Jim


> > ---
> >  libsepol/src/policydb_validate.c | 28 +++++++++++++++++-----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 735c7a33..72063351 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -658,7 +658,7 @@ bad:
> >   * Functions to validate a kernel policydb
> >   */
> >
> > -static int validate_avtab_key(avtab_key_t *key, validate_t flavors[])
> > +static int validate_avtab_key(avtab_key_t *key, int conditional, valid=
ate_t flavors[])
> >  {
> >         if (validate_value(key->source_type, &flavors[SYM_TYPES]))
> >                 goto bad;
> > @@ -670,13 +670,16 @@ static int validate_avtab_key(avtab_key_t *key, v=
alidate_t flavors[])
> >         case AVTAB_ALLOWED:
> >         case AVTAB_AUDITALLOW:
> >         case AVTAB_AUDITDENY:
> > -       case AVTAB_XPERMS_ALLOWED:
> > -       case AVTAB_XPERMS_AUDITALLOW:
> > -       case AVTAB_XPERMS_DONTAUDIT:
> >         case AVTAB_TRANSITION:
> >         case AVTAB_MEMBER:
> >         case AVTAB_CHANGE:
> >                 break;
> > +       case AVTAB_XPERMS_ALLOWED:
> > +       case AVTAB_XPERMS_AUDITALLOW:
> > +       case AVTAB_XPERMS_DONTAUDIT:
> > +               if (conditional)
> > +                       goto bad;
> > +               break;
> >         default:
> >                 goto bad;
> >         }
> > @@ -691,7 +694,7 @@ static int validate_avtab_key_and_datum(avtab_key_t=
 *k, avtab_datum_t *d, void *
> >  {
> >         validate_t *flavors =3D (validate_t *)args;
> >
> > -       if (validate_avtab_key(k, flavors))
> > +       if (validate_avtab_key(k, 0, flavors))
> >                 return -1;
> >
> >         if ((k->specified & AVTAB_TYPE) && validate_value(d->data, &fla=
vors[SYM_TYPES]))
> > @@ -716,7 +719,7 @@ static int validate_cond_av_list(sepol_handle_t *ha=
ndle, cond_av_list_t *cond_av
> >
> >         for (; cond_av; cond_av =3D cond_av->next) {
> >                 for (avtab_ptr =3D cond_av->node; avtab_ptr; avtab_ptr =
=3D avtab_ptr->next) {
> > -                       if (validate_avtab_key(&avtab_ptr->key, flavors=
)) {
> > +                       if (validate_avtab_key(&avtab_ptr->key, 1, flav=
ors)) {
> >                                 ERR(handle, "Invalid cond av list");
> >                                 return -1;
> >                         }
> > @@ -726,7 +729,7 @@ static int validate_cond_av_list(sepol_handle_t *ha=
ndle, cond_av_list_t *cond_av
> >         return 0;
> >  }
> >
> > -static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, =
validate_t flavors[])
> > +static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, =
int conditional, validate_t flavors[])
> >  {
> >         class_perm_node_t *class;
> >
> > @@ -746,14 +749,17 @@ static int validate_avrules(sepol_handle_t *handl=
e, avrule_t *avrule, validate_t
> >                 case AVRULE_AUDITALLOW:
> >                 case AVRULE_AUDITDENY:
> >                 case AVRULE_DONTAUDIT:
> > -               case AVRULE_NEVERALLOW:
> >                 case AVRULE_TRANSITION:
> >                 case AVRULE_MEMBER:
> >                 case AVRULE_CHANGE:
> > +                       break;
> > +               case AVRULE_NEVERALLOW:
> >                 case AVRULE_XPERMS_ALLOWED:
> >                 case AVRULE_XPERMS_AUDITALLOW:
> >                 case AVRULE_XPERMS_DONTAUDIT:
> >                 case AVRULE_XPERMS_NEVERALLOW:
> > +                       if (conditional)
> > +                               goto bad;
> >                         break;
> >                 default:
> >                         goto bad;
> > @@ -814,9 +820,9 @@ static int validate_cond_list(sepol_handle_t *handl=
e, cond_list_t *cond, validat
> >                         goto bad;
> >                 if (validate_cond_av_list(handle, cond->false_list, fla=
vors))
> >                         goto bad;
> > -               if (validate_avrules(handle, cond->avtrue_list, flavors=
))
> > +               if (validate_avrules(handle, cond->avtrue_list, 1, flav=
ors))
> >                         goto bad;
> > -               if (validate_avrules(handle, cond->avfalse_list, flavor=
s))
> > +               if (validate_avrules(handle, cond->avfalse_list, 1, fla=
vors))
> >                         goto bad;
> >                 if (validate_bool_id_array(handle, cond->bool_ids, cond=
->nbools, &flavors[SYM_BOOLS]))
> >                         goto bad;
> > @@ -1098,7 +1104,7 @@ static int validate_avrule_blocks(sepol_handle_t =
*handle, avrule_block_t *avrule
> >                 for (decl =3D avrule_block->branch_list; decl !=3D NULL=
; decl =3D decl->next) {
> >                         if (validate_cond_list(handle, decl->cond_list,=
 flavors))
> >                                 goto bad;
> > -                       if (validate_avrules(handle, decl->avrules, fla=
vors))
> > +                       if (validate_avrules(handle, decl->avrules, 0, =
flavors))
> >                                 goto bad;
> >                         if (validate_role_trans_rules(handle, decl->rol=
e_tr_rules, flavors))
> >                                 goto bad;
> > --
> > 2.35.1
> >
