Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D3CE79A1
	for <selinux@archiver.kernel.org>; Mon, 25 Sep 2023 21:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjIYVD3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Sep 2023 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIYVD2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Sep 2023 17:03:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91CD103
        for <selinux@vger.kernel.org>; Mon, 25 Sep 2023 14:03:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-503f39d3236so11928889e87.0
        for <selinux@vger.kernel.org>; Mon, 25 Sep 2023 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695675800; x=1696280600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5LmKh0zH5XQgOefex67gJjj413XN3ZcWIB6g8SbNtQ=;
        b=cnGZMww3EAYiz4JFDYJdlQxrr6KrjQXkzz68wSEQY8foFqlDhsBxBTBvF1sR9bs0bI
         K1ST2qK/hQ2gZBa+tPKGv9UQE3veuzKGM2QeGe5b+jto9dLSrn7tnhaC60DUfg0Q5RyZ
         WYzztgpoJ9CjOVPV5lkOLxspQlZFUV6oG5z2u0+pZW+rr63FA8oTZVCgAXb5kxc5P0XB
         y82SGgsXsNsh9SBDoZkHdIxro91/3qfKzDlRgIbqFeOs7Ks/8QN6eFvYlSxZuaFx5QQF
         1c8TYZSsncXyWAhbZ3IBGgl3sohJbXVsvwBhtl1ZULyhq1XFGyQMgJyLaibqMsnyVbyn
         S3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695675800; x=1696280600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5LmKh0zH5XQgOefex67gJjj413XN3ZcWIB6g8SbNtQ=;
        b=G7FyuZLtxVUx0dSNHAtb1b3WCBC41dRDE+nZh+83LqV+NU/zCoes000qBM25yd83LE
         1QAYr0IEQNpRT/awCiE8lSvA8mJ/vDjK6Cfg52dwvn93APVg8+9HsUSUwPvtvNoCnrNJ
         rPDaW/IOCXyu8rPAGViS2WJGz/oRK5Hjr7u/5krIqGZNXSse2EWvusEvj1rgx+6haxQ4
         vORTVeM7J+86/uaTo5AYXtiL2FSASGKhZJVrWKk/4M9u9H/eMZM4NZGO3HrWedYfI3pi
         9RNoa0zWzA/MjginSiugTTeenwITI9zxXDmfwdd5Z7wKffN7ZgJ+x+JkncYF65+3Un2e
         QMxg==
X-Gm-Message-State: AOJu0YwK3s9p8/XM5lOR8AlljzWiS6fNipgNF6APv45M0sQ9QGaRMcrK
        8gyZsEfuIKhvIhMelI7gyZQTwupyemlTio27XOU=
X-Google-Smtp-Source: AGHT+IF7JkNJOljy/LOrO04YOg27NOnXc9ZI87mMSIPKd7GIG5PWoirwVop1ku6vm2uyA0lCouRHwt/tfVoJyMqryaM=
X-Received: by 2002:ac2:5e3a:0:b0:503:446:c7b0 with SMTP id
 o26-20020ac25e3a000000b005030446c7b0mr5557950lfg.32.1695675799645; Mon, 25
 Sep 2023 14:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <324bb6b0-3d6c-707d-c0d1-1fdc1f43e845@redhat.com>
 <87pm2ouk0s.fsf@defensec.nl> <CAP+JOzR7d7RfKWPaTt_BwEbEyWxGQhdnfAQ3fx5itL+xqshTLA@mail.gmail.com>
 <e26ceee7-3c67-7cf9-1333-2650d1d2734d@redhat.com>
In-Reply-To: <e26ceee7-3c67-7cf9-1333-2650d1d2734d@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 25 Sep 2023 17:03:08 -0400
Message-ID: <CAP+JOzQDFiX+gzVpe4t1dxry5rYGqsN5TPsEYw5mi61gJT8Xhg@mail.gmail.com>
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

So what is going on here is that type t is being declared and that is
completely different from the string t that is a macro parameter.
The allow rule resolves because t is a valid type. As the macro is
written, the "yolo" being passed in is not used. But if you would make
a named type transition rule that takes t as the filename, it would
end up with "yolo".

An error would be produced if you had used (type t) instead of (string
t) in the macro.
There probably should be a warning in the case above.
Jim

> This installs without any complaints, but the type does not get defined
> and the rule gets silently ignored as well.
>
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
