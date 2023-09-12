Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E543CA0ECF
	for <selinux@archiver.kernel.org>; Tue, 12 Sep 2023 13:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjILNNY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbjILNNX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Sep 2023 09:13:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14410D7
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 06:13:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50079d148aeso9567742e87.3
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694524398; x=1695129198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpPW82mrrMwbN4OVgqq/e6BPFeOYe/IdNS1349CNTco=;
        b=JLXiuFmR1AmH35T3H0Q5xo5p5it1j0NZ9LLz6ZPQPLnkBwrgEpIT/RTZP8idZ48f5z
         x2YVhzphCJdQ4wvTDS7076YKG89NJPkCErCd0aLN8d8CCnufa4rt7Mmn8DCGJlyKB6ci
         YXWzPwT6YxYu53DeQOO5poLrj4YcIdIgHO4SwbJm0fz2qgQoFOqPbQ/kJgeB/nWHl58J
         ccbouNii7em38gxHz2BlFwhNksqprnsZK2eCLw381NFLD3zgIYtKJWKRu21L4joDO0VB
         8eFKZTChDTXJo2BJMxWA/2EGcU2zASKOt2vxvrK5r1NuJezzqImPwa2mW9oQTVaUqhnf
         L3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524398; x=1695129198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpPW82mrrMwbN4OVgqq/e6BPFeOYe/IdNS1349CNTco=;
        b=OjrWR0MBg8VjAE+SOEBuzIDfvXlmGDsTLbk5YUCoMsstFMKAPguhukMGZbe41qb+uL
         6fIxv9J0ptAoXTdmUDHTB9FiIQmE//jqYDT4Fk5S76I+Zg5I0VqgQQHVN1fHjD7P7luR
         jk2BJA0Ys8KmAkuIBHVuqpuAuxRxRzLJB8S6fJhLR3LpWVvq0N28pNhsosp3bBP7TMlm
         pE2UR52CcwPBh8CpfRzfzzMMgMwn977vFVhPOH4DMNY0oydHNAwNRPBQSL2veE3FQeNk
         jsc4V8Ifsj0cXA3ybB626H17fq1DmVt4ln4JZUmgkYT2X6go5P7BtX7iuJC8NGt0g0b5
         WXWQ==
X-Gm-Message-State: AOJu0YwJHjf7yorhTfYtSqAHTnTwI2pc9URHsBIsKvOkKOkiLkAJd+FS
        gx3CUyaD90r2yvE5Q+W9cwYo0q+ET/Wih3tDyaCKGYNR
X-Google-Smtp-Source: AGHT+IEKj1Ri+KTyHvXK3o8NueN6Byxh12dG2OGNnR9Ft4D0pVO7ZsdpvKfT38q75tc4jdaHsl4CnZqGOKmN+O+f/fQ=
X-Received: by 2002:a19:4f11:0:b0:500:bf56:cca6 with SMTP id
 d17-20020a194f11000000b00500bf56cca6mr8632751lfb.53.1694524397385; Tue, 12
 Sep 2023 06:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <324bb6b0-3d6c-707d-c0d1-1fdc1f43e845@redhat.com> <87pm2ouk0s.fsf@defensec.nl>
In-Reply-To: <87pm2ouk0s.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Sep 2023 09:13:06 -0400
Message-ID: <CAP+JOzR7d7RfKWPaTt_BwEbEyWxGQhdnfAQ3fx5itL+xqshTLA@mail.gmail.com>
Subject: Re: generating new type name using CIL macro
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 12, 2023 at 1:19=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Vit Mojzis <vmojzis@redhat.com> writes:
>
> > Hello all,
> > while trying to recreate some selinux-policy templates using CIL
> > macros I got stuck on creating new type/role/attribute names.
> > For example consider ssh_role_template [1], which uses its first
> > parameter to create a new type $1_ssh_agent_t.
> >
> > Is there a way to recreate such functionality in a CIL macro (or
> > another CIL feature)?
>

In CIL we wanted to get away from the m4 string mangling. The thought
was that a higher-level language could do this if desired.

CIL is very restrictive in that all the arguments in a call have to be
already defined. You cannot even pass a string that will be used to
declare a type--the type must already be defined.

As Dominick says below, we thought that blocks and inheritance would
replace the string mangling, but, as you note, this does change how
the type looks.

Jim

> CIL uses blocks for it implementation of templating. If you want to lever=
age
> native CIL then look into blocks.
>
> Example:
>
> cat > mytest.cil <<EOF
> (typeattribute foo)
>
> (block t
> (blockabstract t)
> (type t)
> (typeattributeset .foo t))
>
> (block bar
> (blockinherit t))
>
> (block baz
> (blockinherit t))
>
> (allow .foo .foo (process (signal)))
> EOF
>
> sudo semodule -i mytest.cil
>
> seinfo -xafoo
>
> Type Attributes: 1
>    attribute foo;
>         bar.t
>         baz.t
>
> sesearch -A -s foo -ds
> allow foo foo:process signal;
>
> >
> > Something along the lines of:
> > (macro new_type_macro ((string type_prefix))
> >   (type (type_prefix)_t)
> > )
> > which when called (call new_type_macro ("yolo")) would produce
> > (type yolo_t)
> >
> > I searched through CIL reference guide [2] and SELinuxProject CIL wiki
> > on github, but didn't find anything close (maybe there is a better
> > resource I don't know about).
> > I'd appreciate any hints or links to other resources related to CIL mac=
ros.
> >
> > Thank you,
> > Vit
> >
> > [1] -
> > https://github.com/TresysTechnology/refpolicy/blob/master/policy/module=
s/services/ssh.if#L301
> > [2] -
> > https://raw.githubusercontent.com/SELinuxProject/selinux-notebook/main/=
src/notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf
> > [3] - https://github.com/SELinuxProject/cil/wiki#macros
> >
>
> --
> gpg --locate-keys dominick.grift@defensec.nl (wkd)
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
> Mastodon: @kcinimod@defensec.nl
