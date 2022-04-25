Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7046C433EF
	for <selinux@archiver.kernel.org>; Mon, 25 Apr 2022 11:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiDYLfm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Apr 2022 07:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiDYLfl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Apr 2022 07:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38FF5FE5
        for <selinux@vger.kernel.org>; Mon, 25 Apr 2022 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650886355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chYrFMuJMrj2l45U81J/xVWg6taKyndownj0dsE1Yrg=;
        b=cv8zW5T78MzJ2clFvbQMFOosk6vFMLRS8a8aWqB8mYnQbHG6R/nLmVsU6bX5DMHbo1Pfa7
        uzIqIOo5obnGkf4DGd7LXjFi4VnzJPYGJdoYBVqmhZxdvUzWu+Y6b78ylUlgmiF3JVGO7H
        hu94QkFCi0k94oLvbCAHu60GnETMRXM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-euZSZqn6NwejsI52gjjiOw-1; Mon, 25 Apr 2022 07:32:34 -0400
X-MC-Unique: euZSZqn6NwejsI52gjjiOw-1
Received: by mail-yb1-f200.google.com with SMTP id a17-20020a258051000000b00648703d0c56so1789432ybn.22
        for <selinux@vger.kernel.org>; Mon, 25 Apr 2022 04:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=chYrFMuJMrj2l45U81J/xVWg6taKyndownj0dsE1Yrg=;
        b=PM/y8BQN4WCkSR8DfFz3691GG8zpD2TojnBQ67nQApxz8dS/DiNLR1D6y0lIoOSg7B
         CO8/RxLp/gRJnIx/K7vgTLycNO72cyhknI2VPjYmyhapdBJ+N/vFACQO3vFjUQ3jDbaA
         8wKklPn+5wVIu+GniIM9V4Msf7ixIzo2PpGA2Fy0uRSoD9+w7m0y7AXFbyNm/C2cZKy1
         fGfVSG5F4akzDPfOJYJZbH7rv224Whs0Ck3ORAglLLKi2qAlLFImJOpnmpRTD0pZ2Msc
         hHtWVIPlSkUhJpnPOWsTGuNrpfhTH9f7L6rG5hbyHj3ZPOnW+jTZ+mECtby8CG8bwKoc
         Vhhg==
X-Gm-Message-State: AOAM532OMoXG4R3dFx7egmvOrJFFlSr2zmWYYgq04Ag0XJyF/HQ77S9l
        mVO1Z//nEERF6+NCaB4KTMUWGXPlfZUISqO7Z0mOp4Zj5suYakM+1PYo36fzLAzjiaS6nG58wL6
        dSfmRkzbvzTYSUVdCp27HK4x/kTiL4POOWA==
X-Received: by 2002:a81:1796:0:b0:2f7:d7bc:5110 with SMTP id 144-20020a811796000000b002f7d7bc5110mr5940758ywx.12.1650886353483;
        Mon, 25 Apr 2022 04:32:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy88o5ynoM/A2V9yWf4hsDX/+sCB1Wolqpqfoyi6k3eEchF+alI7tcndaGx3XQV6BfsMiRFIxFKXwTPyLC8WL4=
X-Received: by 2002:a81:1796:0:b0:2f7:d7bc:5110 with SMTP id
 144-20020a811796000000b002f7d7bc5110mr5940744ywx.12.1650886353192; Mon, 25
 Apr 2022 04:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220422154307.968527-1-omosnace@redhat.com> <20220422154307.968527-3-omosnace@redhat.com>
 <CAJ2a_DcOi6QmRPYq1CtyP15STrnK6KgPKqJ-qpyOZ_QDWELvsQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DcOi6QmRPYq1CtyP15STrnK6KgPKqJ-qpyOZ_QDWELvsQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Apr 2022 13:32:20 +0200
Message-ID: <CAFqZXNsRR+e1gn2ktGRNXNy1inSfVZtMmp3Lhq13TmjNPVOfFg@mail.gmail.com>
Subject: Re: [PATCH userspace 2/2] libsepol,checkpolicy: add support for self
 keyword in type transitions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Apr 23, 2022 at 9:43 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Fri, 22 Apr 2022 at 17:44, Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> >
> > With the addition of the anon_inode class in the kernel, 'self'
> > transition rules became useful, but haven't been implemented.
> >
> > This patch implements the self keyword in all 'typetransition'
> > statements at the TE language level and adds the support to the module
> > policydb format. Note that changing the kernel policydb format is not
> > necessary at all, as type transitions are always expanded in the kernel
> > policydb.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  checkpolicy/policy_define.c                | 42 ++++++++++++-
> >  libsepol/include/sepol/policydb/policydb.h |  4 +-
> >  libsepol/src/expand.c                      | 69 ++++++++++++++--------
> >  libsepol/src/link.c                        |  1 +
> >  libsepol/src/module_to_cil.c               | 30 ++++++----
> >  libsepol/src/policydb.c                    | 33 +++++++++--
> >  libsepol/src/write.c                       | 19 +++---
> >  7 files changed, 148 insertions(+), 50 deletions(-)
> >
[...]
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index d7ac2b25..0b4f5d9a 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -1929,11 +1929,12 @@ static int role_allow_rule_write(role_allow_rul=
e_t * r, struct policy_file *fp)
> >         return POLICYDB_SUCCESS;
> >  }
> >
> > -static int filename_trans_rule_write(filename_trans_rule_t * t, struct=
 policy_file *fp)
> > +static int filename_trans_rule_write(policydb_t *p, filename_trans_rul=
e_t *t,
> > +                                    struct policy_file *fp)
> >  {
> >         int nel =3D 0;
> > -       size_t items;
> > -       uint32_t buf[2], len;
> > +       size_t items, entries;
> > +       uint32_t buf[3], len;
> >         filename_trans_rule_t *ftr;
> >
> >         for (ftr =3D t; ftr; ftr =3D ftr->next)
> > @@ -1962,10 +1963,14 @@ static int filename_trans_rule_write(filename_t=
rans_rule_t * t, struct policy_fi
> >
> >                 buf[0] =3D cpu_to_le32(ftr->tclass);
> >                 buf[1] =3D cpu_to_le32(ftr->otype);
> > +               buf[2] =3D cpu_to_le32(ftr->flags);
> >
> > -               items =3D put_entry(buf, sizeof(uint32_t), 2, fp);
> > -               if (items !=3D 2)
> > -                       return POLICYDB_ERROR;
> > +               if (p->policyvers >=3D MOD_POLICYDB_VERSION_SELF_TYPETR=
ANS)
> > +                       entries =3D 3;
> > +               else
> > +                       entries =3D 2;
> > +
> > +               items =3D put_entry(buf, sizeof(uint32_t), entries, fp)=
;
>
> + if (items !=3D entries)
> +     return POLICYDB_ERROR;
>
> >         }
> >         return POLICYDB_SUCCESS;
> >  }
> > @@ -2039,7 +2044,7 @@ static int avrule_decl_write(avrule_decl_t * decl=
, int num_scope_syms,
> >         }
> >
> >         if (p->policyvers >=3D MOD_POLICYDB_VERSION_FILENAME_TRANS &&
> > -           filename_trans_rule_write(decl->filename_trans_rules, fp))
> > +           filename_trans_rule_write(p, decl->filename_trans_rules, fp=
))
> >                 return POLICYDB_ERROR;
> >
> >         if (p->policyvers >=3D MOD_POLICYDB_VERSION_RANGETRANS &&
> > --
> > 2.35.1
> >
>
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1184,6 +1184,14 @@ static int
> validate_filename_trans_rules(sepol_handle_t *handle, filename_trans_
>                        goto bad;
>                if (validate_value(filename_trans->otype, &flavors[SYM_TYP=
ES]))
>                        goto bad;
> +
> +               switch (filename_trans->flags) {
> +               case 0:
> +               case RULE_SELF:
> +                       break;
> +               default:
> +                       goto bad;
> +               }
>        }
>
>        return 0;

Good catches, thanks! I will include these changes in the next respin.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

