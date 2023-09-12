Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65364EE3F29
	for <selinux@archiver.kernel.org>; Tue, 12 Sep 2023 20:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjILU4q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Sep 2023 16:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjILU4p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Sep 2023 16:56:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4F0199
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 13:56:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502a4f33440so6888505e87.1
        for <selinux@vger.kernel.org>; Tue, 12 Sep 2023 13:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694552200; x=1695157000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFMJyjgd02TuKDFYe+Btib/vqSDagYWUUPz8Lml1IKE=;
        b=HJoPGEzveliFr0tfMhY1pAtCwUpiwN54QF745WMD0+yLk71GTnWvGhe6+tgL0krI3g
         Z+ec8mHgziljN2nS17JDj1/f/RVuQMPc27XL93FhGnFostZbtLP5vXs5NExeCN1qfNXa
         BuagFhzzruZJCeNhYu427CFfaj+8Vjl7IRqRBISAfAXduVa8wV4qallWZAq3L1CHm+e9
         Wpe+K2pgs76i6XUeXtHiVGJPlYxBfxBpSkDbLhqfkrk1MwZejgsSCmKrGZaCzrv3WXkp
         pKM0ONLo/Cs1nQTZNr1TGHIl0eK8EIHWzpTwAWQ2IztUqhT8zR5KHztx0piakeujGPIH
         LtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552200; x=1695157000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFMJyjgd02TuKDFYe+Btib/vqSDagYWUUPz8Lml1IKE=;
        b=E3zMvm9+Ml9Prmvfraj79fb132qZzMVYnvYonwQCEVRVFZCOeHFPGDJp5hGkeApuim
         50vmnr4cbvf87+hEy6RrpQAwasUK7IXCupSL5GCh3s8Z042F2jH0Cl0JDs7FYfTuPl2s
         YH5QE04k3KXOQjvL1D1vQ22N616sPZSl3oVWghCe2cpExlxwmbbRUFke93S9kbloBydw
         W/R6O6GfhaP8rAOKMv2VoBqjCcS2gTFRro1Y66TYYLupKFRLMtufss5M+EbqT1UNBzvd
         37FAOrMXIUV4n/hV3p+mdBJvl/fVGoDgGc0wGgwyfs1xBqvLU5bTJamwdq5rxGMNywUj
         FMiw==
X-Gm-Message-State: AOJu0Yx3lizeH0GjkpL8hFk2VveDMnGJHW2W0vuDny2bZLzFXav2vl/R
        wv+zpQioG9yDCh1nOMhXHBqwIKa2sOv5X5+oX3W9PnVt
X-Google-Smtp-Source: AGHT+IH8arFIIGhXKLREtTOJCn3KDRLGxn4Gz75lUP36BQvTeaRvWVf0ReDuRwVhlzuOjlfuu99IxSFuzZtPGpAM8E8=
X-Received: by 2002:ac2:5e77:0:b0:4fe:62f:35eb with SMTP id
 a23-20020ac25e77000000b004fe062f35ebmr589212lfr.20.1694552199725; Tue, 12 Sep
 2023 13:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <324bb6b0-3d6c-707d-c0d1-1fdc1f43e845@redhat.com>
 <87pm2ouk0s.fsf@defensec.nl> <CAP+JOzR7d7RfKWPaTt_BwEbEyWxGQhdnfAQ3fx5itL+xqshTLA@mail.gmail.com>
 <e26ceee7-3c67-7cf9-1333-2650d1d2734d@redhat.com>
In-Reply-To: <e26ceee7-3c67-7cf9-1333-2650d1d2734d@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 12 Sep 2023 16:56:28 -0400
Message-ID: <CAP+JOzRESAiNbhETQPMzOpK1Vo0yqp9C=pasu+MdwX5y3guzYQ@mail.gmail.com>
Subject: Re: generating new type name using CIL macro
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 12, 2023 at 2:29=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
>
>
> On 9/12/23 15:13, James Carter wrote:
> > On Tue, Sep 12, 2023 at 1:19=E2=80=AFAM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >> Vit Mojzis <vmojzis@redhat.com> writes:
> >>
> >>> Hello all,
> >>> while trying to recreate some selinux-policy templates using CIL
> >>> macros I got stuck on creating new type/role/attribute names.
> >>> For example consider ssh_role_template [1], which uses its first
> >>> parameter to create a new type $1_ssh_agent_t.
> >>>
> >>> Is there a way to recreate such functionality in a CIL macro (or
> >>> another CIL feature)?
> > In CIL we wanted to get away from the m4 string mangling. The thought
> > was that a higher-level language could do this if desired.
> > CIL is very restrictive in that all the arguments in a call have to be
> > already defined. You cannot even pass a string that will be used to
> > declare a type--the type must already be defined.
>
> Right, this complicates replicating interfaces even further.
>
> BTW there is no error or warning when passing a string in an attempt to
> define a new entity inside the macro.
> (macro define_type ((string t))
>      (type t)
>      (allow t t (process (setcap)))
> )
> (call define_type (yolo))
>
> This installs without any complaints, but the type does not get defined
> and the rule gets silently ignored as well.
>

That is interesting. I'll have to take a look at that.
Thanks for the report.
Jim

> >
> > As Dominick says below, we thought that blocks and inheritance would
> > replace the string mangling, but, as you note, this does change how
> > the type looks.
>
> Yes, and since that is something I cannot ignore, I'll have to create
> some kind of simple abstraction as Dominick suggested.
>
> Thank you both for the suggestions and explanations, you helped me a
> great deal.
> Vit
>
> >
> > Jim
> >
> >> CIL uses blocks for it implementation of templating. If you want to le=
verage
> >> native CIL then look into blocks.
> >>
> >> Example:
> >>
> >> cat > mytest.cil <<EOF
> >> (typeattribute foo)
> >>
> >> (block t
> >> (blockabstract t)
> >> (type t)
> >> (typeattributeset .foo t))
> >>
> >> (block bar
> >> (blockinherit t))
> >>
> >> (block baz
> >> (blockinherit t))
> >>
> >> (allow .foo .foo (process (signal)))
> >> EOF
> >>
> >> sudo semodule -i mytest.cil
> >>
> >> seinfo -xafoo
> >>
> >> Type Attributes: 1
> >>     attribute foo;
> >>          bar.t
> >>          baz.t
> >>
> >> sesearch -A -s foo -ds
> >> allow foo foo:process signal;
> >>
> >>> Something along the lines of:
> >>> (macro new_type_macro ((string type_prefix))
> >>>    (type (type_prefix)_t)
> >>> )
> >>> which when called (call new_type_macro ("yolo")) would produce
> >>> (type yolo_t)
> >>>
> >>> I searched through CIL reference guide [2] and SELinuxProject CIL wik=
i
> >>> on github, but didn't find anything close (maybe there is a better
> >>> resource I don't know about).
> >>> I'd appreciate any hints or links to other resources related to CIL m=
acros.
> >>>
> >>> Thank you,
> >>> Vit
> >>>
> >>> [1] -
> >>> https://github.com/TresysTechnology/refpolicy/blob/master/policy/modu=
les/services/ssh.if#L301
> >>> [2] -
> >>> https://raw.githubusercontent.com/SELinuxProject/selinux-notebook/mai=
n/src/notebook-examples/selinux-policy/cil/CIL_Reference_Guide.pdf
> >>> [3] - https://github.com/SELinuxProject/cil/wiki#macros
> >>>
> >> --
> >> gpg --locate-keys dominick.grift@defensec.nl (wkd)
> >> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> >> Dominick Grift
> >> Mastodon: @kcinimod@defensec.nl
>
