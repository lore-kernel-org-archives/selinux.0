Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537BC433DB
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 18:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA1364E20
	for <selinux@archiver.kernel.org>; Wed, 10 Mar 2021 18:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhCJSI2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhCJSIW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Mar 2021 13:08:22 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8114AC061760
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 10:08:21 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 75so14020180otn.4
        for <selinux@vger.kernel.org>; Wed, 10 Mar 2021 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5890n/vQqAcWk9tPe8gxlTA+ZgBvfHc6yOPj4ZCwfs8=;
        b=AJyOdhEk0bMfs9xSI/5cf3YyJrOYXC9K01/lphWxUB/xE8OJkHYEcwUnoBvCfa88tx
         f7CjQ0I687xQ7A/yxsW01mhVFyx7qnwoWzR3GsI03xBt3D0H2DXgYyQkl2G3Kgv1etVG
         85Kh21lCH0qpRN5CIwAAL0xxlZc17OhupEHDjywnndXLzba/rjleqgrivyW2RfmPaUkq
         FqlGLw/ExQxkOVQMDcqB/Ih4pWGaovfVvbucdWpCyMUXbbFtF8A7M/dvvOf6fWmPpMkD
         4XUmTxugRkxK6dZaO0kGL8D7KQDK39lUNMBJQ94xKueeeDGvlEUVv3H2vvmz1Co2uokE
         ie7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5890n/vQqAcWk9tPe8gxlTA+ZgBvfHc6yOPj4ZCwfs8=;
        b=Q8cd5CzvMxIYVPwqinhl3DtofX1ADhEuMs2CE7DSrlo2NtLYWv9/qpaVtqBxU1oEsE
         0eTfQyPlucdnfntofBQYY++QkmdYunvjQLZ68oy7Cu4mMnDN/tPSofIV2xcVAkhyuit2
         ppEuz3KHiqH5KPF6u2dwllJS9SFtQYX2wCpXlQqOhACtocOuRH97h+owMw1U7B0qBdKs
         J/Ee7fbk7e5rWwD+UOVDWttylQRB8kpx3FLzCjnWr4A3fw19KkkQi25nrpRv8HOdwEKF
         uRo3YxP/Y8cc2aj/av6qN9N30jrZwv4YouN8rkAL/d/ao0c9szgT2Gk6Y13DZaoSiJsi
         RX4g==
X-Gm-Message-State: AOAM531pfT30cn+EU6o6sybp2HXVauNuXImXDnTzRDgxl4wgqNK8aMwF
        sUlwMBHdkWHS+km6Ik/CYvtQ0zwa8jTYqkv2y+ld1gSi4zw=
X-Google-Smtp-Source: ABdhPJy7QcGrjjfYOQki6X76cQhRYQltSzlcepc70yF+mPPcjc0ORRHWTFcNW8b1W/KOGZhxyBBvQDrmUZANiT/OQ6s=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr3556546otr.59.1615399700954;
 Wed, 10 Mar 2021 10:08:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_Dd_tccbWwA_S8nnRvpAVJW8EcrU3t3R7e=McThsx0L13w@mail.gmail.com>
In-Reply-To: <CAJ2a_Dd_tccbWwA_S8nnRvpAVJW8EcrU3t3R7e=McThsx0L13w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 10 Mar 2021 13:08:10 -0500
Message-ID: <CAP+JOzRjB15G-0f7pczkji2Z=NVD7DmWehWE=dcb_jnPLYyshQ@mail.gmail.com>
Subject: Re: Role attributes in traditional language constraints
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 10, 2021 at 12:10 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Hi list,
>
> I am using in my RefPolicy based policy constraints containing role-attri=
butes:
>
>     attribute_role unpriv_roles;
>     ...
>     constrain ...
>         r1 !=3D unpriv_role
>

Role attributes in constraint expressions are not currently expanded.
I was already working on a patch to expand them. I will probably get
that patch out before the end of the day.

> This worked fine so far and the language specification [1][2] permits
> the usage of type attributes (by using them in the examples) and
> states not differences between `t1 op names` and `r1 op names`.
>
> Today I debugged a crash of seinfo(1) on generated binary policies of min=
e.
> `seinfo path/to/build/policy --constrain` segfaults at [3], when run
> on a build binary policy.
> These binary policies are generated by the RefPolicy target `make
> validate`, running either semodule_link(8) and semodule_expand(8)
> (modular build) or checkpolicy(8) (monolithic build).
>
> Running `seinfo --constrain`, using the currently loaded kernel
> policy, works fine and shows the expanded roles in the according
> constrain (e.g. `r1 !=3D { user_r guest_r ... }`).
>

I don't know how that works. Something else must be going on.

With the following policy, using the Fedora 32 versions of checkpolicy
and seinfo leads to a segfault of seinfo.
class CLASS1
sid kernel
class CLASS1 { PERM1 }
type TYPE1;
allow TYPE1 self : CLASS1 PERM1;
attribute_role ROLE_ATTR1;
role ROLE1;
roleattribute ROLE1 ROLE_ATTR1;
role ROLE1 types TYPE1;
user USER1 roles ROLE1;
constrain CLASS1 { PERM1 } ( r1 =3D=3D ROLE_ATTR1 );
sid kernel USER1:ROLE1:TYPE1

With the following CIL policy, using the Fedora 32 versions of secilc
and seinfo leads to a segfault of seinfo.
(class CLASS1 (PERM1))
(classorder (CLASS1))
(sid kernel)
(sidorder (kernel))
(category CAT)
(categoryorder (CAT))
(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (CAT))
(type TYPE1)
(allow TYPE1 self (CLASS1 (PERM1)))
(roleattribute ROLE_ATTR1)
(roleattributeset ROLE_ATTR1 (ROLE1))
(role ROLE1)
(roletype ROLE1 TYPE1)
(user USER1)
(userrole USER1 ROLE1)
(userlevel USER1 (SENS))
(userrange USER1 ((SENS)(SENS (CAT))))
(constrain (CLASS1 (PERM1)) (eq r1 ROLE_ATTR1))
(sidcontext kernel (USER1 ROLE1 TYPE1 ((SENS)(SENS))))

> On further testing I noticed that on Fedora 34 with libsepol 3.2
> building such policies fails entirely:
>
>     ...
>     Validating policy file contexts.
>     libsepol.validate_constraint_nodes: Invalid constraint expr
>     libsepol.validate_class_datum: Invalid class datum
>     libsepol.validate_datum_arrays: Invalid datum arrays
>     libsepol.validate_policydb: Invalid policydb
>     libsepol.sepol_set_policydb_from_file: can't read binary policy: Succ=
ess
>     Error reading policy tmp/policy.bin: Success
>     make: *** [Rules.modular:215: validate] Error 255
>
> This seems to be caused by [4].
>

This is correctly finding that the role ebitmap in the constraint
expression is referencing a non-existent role which is what happens
now when a role attribute is used in a constraint. As far as I can
tell, it was not working before the policydb validation patch.

> From my point of view this is a regression:
> Role-attributes in constraints worked prior libsepol 3.2, work in CIL
> and are not explicitly disallowed by the language specification.
> `validate_constraint_nodes()`[5] should accept attribute_role identifiers=
.
>
> To fix the original seinfo crash, I'd like to ask whether setools
> should accept role-attribute identifiers in compiled binary policies,
> or if semodule_expand(8) and checkpolicy(8) should expand them at
> build-time (currently they are expanded at load-time (load_policy(8)).
>

That role attributes don't work in a constraint expression is a bug
and I am working on a fix.

Thanks for the report,
Jim


> Best regards,
>     Christian G=C3=B6ttsche
>
>
> [1]: https://selinuxproject.org/page/ConstraintStatements
> [2]: https://github.com/SELinuxProject/selinux-notebook/blob/main/src/con=
straint_statements.md#constraint-statements
> [3]: https://github.com/SELinuxProject/setools/blob/master/setools/policy=
rep/role.pxi#L34
> [4]: https://github.com/SELinuxProject/selinux/commit/0861c659b59cb106bad=
1b1d0c9f511a7140a1023
> [5]: https://github.com/SELinuxProject/selinux/blob/master/libsepol/src/p=
olicydb_validate.c#L170
