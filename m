Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94371C43334
	for <selinux@archiver.kernel.org>; Wed,  6 Jul 2022 20:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiGFUMv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jul 2022 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiGFUMu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jul 2022 16:12:50 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39B020F51
        for <selinux@vger.kernel.org>; Wed,  6 Jul 2022 13:12:49 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10bec750eedso15058544fac.8
        for <selinux@vger.kernel.org>; Wed, 06 Jul 2022 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R3BhSPBd2y9rV2zBWcqUZyzJ5I4VF76ooqPvwIRey/o=;
        b=dPk1IycwK9FJClyfrK+6UMt0MOC1iBUDm+acr7932HbP/5unZwQgoGI2c3aLOrtP/+
         +VpYZGq69W+P8YXIlmdM/M6drbatYhadG3rfQybGVUdBAbL2DnrKc1UHxFEoLNzrgIHU
         KaK6DzqUR4w7OMGaPwWGC0u24gxK3Kb6eHzpcgWt0cahmN5gkbrS41omDjE426On7t3E
         RLU4KRQztAATU9aI4hQUjf2PSTU9KRr43MTSURyxqNddz0uUd5/O5ZZzrGoBsCyKUK9u
         Am0DRjq3FJ4mN7k1D6HkfO7By/39tO+AU3epErpPLwXhTquvg078cz1HxC/zjCHV2Yvt
         M/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R3BhSPBd2y9rV2zBWcqUZyzJ5I4VF76ooqPvwIRey/o=;
        b=VJzCBC39d5PoInsYZHxjGRBUxhqkIIr8IWp5YtqswxYGZnbMrBxDMHBdvbIDdljrBr
         yTGqWA1MZomrW9XMpkXbnwP4Vy0FsukT2Rh9l/cXNcCPyWIInZKUoq176u8MHWDEpxQN
         RpnjpjTLQDjBygLV1dU68GuKSj2jbs5PQIvNU6N34TXhgSfGE2dbO26mToiTIMHgjoXw
         CfEoBJ1wjU+TBVlI5anWp0uQqIYQZ9CxUnAegR2k3cstMScH3I9MI+ydtk1s0AMjsO6N
         DU3ZVYtn4AQcPLv4/ahhVuaAW/yEFvipJK76lUPzGaAZKABpQPAJayZEDUyfsMjYwXxE
         OheQ==
X-Gm-Message-State: AJIora/KuoeKfSitu6yUNOJQzudxwZGPSOiIN1WAyUOZFeO4rlYjqUel
        K1d+SrR2hJ+ePKYCFFPf97/a1k8sLZR75dtYXk1VpvNc
X-Google-Smtp-Source: AGRyM1vDZeWHZ+tvjqY85xccDhLRPvQYthZjbnmo3CHCenMb2QMPIqGih55weyBFqFazjaHA/1ufRCe2uANC5XH0C1E=
X-Received: by 2002:a05:6870:4604:b0:f2:5b64:fad9 with SMTP id
 z4-20020a056870460400b000f25b64fad9mr268849oao.182.1657138369253; Wed, 06 Jul
 2022 13:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220630170301.4431-1-cgzones@googlemail.com> <CAP+JOzR=h5BhpztbZ-z3P_vq5kk3=9gvPaDhO_Uf7KrRuAyCSw@mail.gmail.com>
In-Reply-To: <CAP+JOzR=h5BhpztbZ-z3P_vq5kk3=9gvPaDhO_Uf7KrRuAyCSw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 6 Jul 2022 16:12:38 -0400
Message-ID: <CAP+JOzR2VNwnWa-vHni-F6zww8EG=4pR74hu0tP4ky5SXoPeQw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: do not modify policy during write
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 30, 2022 at 2:45 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 1:04 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Do not modify the in memory default_range value of a class datum while
> > writing a policy.
> >
> > While on it fix indentation.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/write.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index 48ed21ea..a9fdf93a 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -1097,16 +1097,18 @@ static int class_write(hashtab_key_t key, hasht=
ab_datum_t datum, void *ptr)
> >              p->policyvers >=3D POLICYDB_VERSION_NEW_OBJECT_DEFAULTS) |=
|
> >             (p->policy_type =3D=3D POLICY_BASE &&
> >              p->policyvers >=3D MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULT=
S)) {
> > +               char default_range =3D cladatum->default_range;
> > +
> >                 buf[0] =3D cpu_to_le32(cladatum->default_user);
> >                 buf[1] =3D cpu_to_le32(cladatum->default_role);
> > -               if (!glblub_version && cladatum->default_range =3D=3D D=
EFAULT_GLBLUB) {
> > +               if (!glblub_version && default_range =3D=3D DEFAULT_GLB=
LUB) {
> >                         WARN(fp->handle,
> > -                             "class %s default_range set to GLBLUB but=
 policy version is %d (%d required), discarding",
> > -                             p->p_class_val_to_name[cladatum->s.value =
- 1], p->policyvers,
> > -                             p->policy_type =3D=3D POLICY_KERN? POLICY=
DB_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
> > -                        cladatum->default_range =3D 0;
> > -                }
> > -               buf[2] =3D cpu_to_le32(cladatum->default_range);
> > +                            "class %s default_range set to GLBLUB but =
policy version is %d (%d required), discarding",
> > +                            p->p_class_val_to_name[cladatum->s.value -=
 1], p->policyvers,
> > +                            p->policy_type =3D=3D POLICY_KERN? POLICYD=
B_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
> > +                       default_range =3D 0;
> > +               }
> > +               buf[2] =3D cpu_to_le32(default_range);
> >                 items =3D put_entry(buf, sizeof(uint32_t), 3, fp);
> >                 if (items !=3D 3)
> >                         return POLICYDB_ERROR;
> > --
> > 2.36.1
> >
