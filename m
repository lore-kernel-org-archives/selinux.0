Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED34CC2BC11
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 20:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A19204FD
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 20:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgYEZoU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgIHUHl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgIHPTy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 11:19:54 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE252C08C5EC
        for <selinux@vger.kernel.org>; Tue,  8 Sep 2020 08:15:41 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id y5so15150924otg.5
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2020 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uC/eNTlTKfyaWzaZeNBF2A15PQULgsd/OA/ost3xqaM=;
        b=ZgYEZoU7rpF8qKao4JtnGrTiMdV0qZPsDQLnoTST8MceQ2QsUKESY3EiyVHjuvSngc
         s+vQ/LBfLQNdBP8ltKRttwyNeDhebLO/x+8YbRzcN2D5y4sKO944ruTjKnAKRUZpLnX/
         alEsbk6flchWzYYvJC7jCAx7c5+dluDhFn4hwY/n+Y/PmNTbfB9NU+5I7bBE30wU11vv
         qzOUsIybq2Til+cmkyPS4n+AiIK9oo56g1moqq2STAphn1EwCPBpIdwt6pBKkYLsE3UQ
         Ybe3scZsVy8Ld97KuoILH4gsxhANBdJimhvS/taej7UVQ/jnrRu+J0TRtLuWioH97GC0
         PrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uC/eNTlTKfyaWzaZeNBF2A15PQULgsd/OA/ost3xqaM=;
        b=Nh4aBEERXTdKJgVKnzvem4P/WluBwBxnmWRD9mt+UErO3ipG2DwuUi9F9r9L10hhsc
         Bz/aYDeRKaPHTrQ6dv125zpIo1AGsLU577cdo7fcqhXZu4hz9mnujk46ZJAkyG2E6Sfh
         e/yyqcIm5acfiuOlpzN2qwXdnxml35k18m6Bn7ztlurfd2EPhvr7nona5BhPN6bVx0Jj
         jH/GBIuS3cWt2a7LTkZ0nLBKX7XnmxnyMbTg8qG1UI0fY61cRyEXWzAGWsRLpY4Y9QJQ
         J50WPaZW2I1zySuN5GHFDvp4H/vShozgSwcykYkAP8yTJzKWSRwGpfbcQl/r5oR3K8GZ
         fukQ==
X-Gm-Message-State: AOAM530C+hXxpiTDmXS7QhdnXu1bAw5zPAXCwtGIYsbiKWRAUAkYy2J6
        Bek+xkMZv22IPvn1lhAkAZj45bqD5kVRzUtL3SDrOwijDA8=
X-Google-Smtp-Source: ABdhPJwH9KEWC5QM/Lqs/YhYNYDiBef0QQ+DGTQKrMxu2M1FFreECLF4NZrBTw2lsBfiZU8K0sfejefdZCM0GylRMuc=
X-Received: by 2002:a9d:75d1:: with SMTP id c17mr4224129otl.59.1599578139806;
 Tue, 08 Sep 2020 08:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181900.81179-1-jwcart2@gmail.com> <CAEjxPJ53Z6z2VAw75QOHZdK-kFz1fnkEFth7acyUGh_2nzpGkQ@mail.gmail.com>
 <CAEjxPJ6EXg5B8pjCxs2SdqBGe91u7PZnBPEphWgvvQ_u1mZtYA@mail.gmail.com> <CAEjxPJ7fd62jYjhT18tNRhdMiRHt1Nt6QGexHDaDx4DcrBY42w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7fd62jYjhT18tNRhdMiRHt1Nt6QGexHDaDx4DcrBY42w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 8 Sep 2020 11:15:28 -0400
Message-ID: <CAP+JOzR7jrttWbjksnC6wh0BYWv+C5sJ9UJjq-BuhXK5Gs7Gng@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Give an error when constraint expressions
 exceed max depth
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 8, 2020 at 9:50 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 8, 2020 at 9:46 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Sep 4, 2020 at 8:49 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Thu, Sep 3, 2020 at 2:19 PM James Carter <jwcart2@gmail.com> wrote:
> > > >
> > > > CIL was not correctly determining the depth of constraint expressions
> > > > which prevented it from giving an error when the max depth was exceeded.
> > > > This allowed invalid policy binaries with constraint expressions exceeding
> > > > the max depth to be created.
> > > >
> > > > Correctly calculate the depth of constraint expressions when building
> > > > the AST and give an error when the max depth is exceeded.
> > > >
> > > > Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> > > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > >
> > > The fix for conditional boolean expression depth checking can be a
> > > separate patch.  For this one,
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Actually, this breaks selinux-testsuite. Will have to look into why.
> > /usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil
> > test_overlay_defaultrange.cil test_add_levels.cil test_glblub.cil
> > Max depth of 4 exceeded for constraint expression
> > Bad expression tree for constraint
> > Bad constrain declaration at
> > /var/lib/selinux/targeted/tmp/modules/100/base/cil:919
>
> Here is the failing cil module:
> $ cat policy/test_mlsconstrain.cil
> (mlsconstrain (peer (recv)) (or (dom l1 l2) (and (neq t1
> mcs_constrained_type) (neq t2 mcs_constrained_type))))
> (mlsconstrain (packet (recv)) (or (dom l1 l2) (and (neq t1
> mcs_constrained_type) (neq t2 mcs_constrained_type))))
>
> Maybe an off-by-one in your depth checking?

The following policy, which should be equivalent, works fine.

(class CLASS (PERM))
(class C1a (P1))
(class C1b (P1))
(classorder (CLASS C1a C1b))
(sid SID)
(sidorder (SID))
(user USER)
(role ROLE)
(type TYPE)
(category CAT)
(categoryorder (CAT))
(sensitivity SENS)
(sensitivityorder (SENS))
(sensitivitycategory SENS (CAT))
(allow TYPE self (CLASS (PERM)))
(roletype ROLE TYPE)
(userrole USER ROLE)
(userlevel USER (SENS))
(userrange USER ((SENS)(SENS (CAT))))
(sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))


(type T1a)
(type T1b)
(type T1c)
(type T1d)
(type T1e)
(type T1f)
(type T1g)
(type T1h)
(type T1i)
(type T1j)
(type T1k)
(type T1l)
(typeattribute A1a)
(typeattributeset A1a (T1a T1b T1c T1d T1e T1f T1g T1h T1i T1j T1k T1l))

(mlsconstrain (C1a (P1)) (or (dom l1 l2) (and (neq t1 A1a) (neq t2 A1a))))
(mlsconstrain (C1b (P1)) (or (dom l1 l2) (and (neq t1 A1a) (neq t2 A1a))))

I'll have to see what is going on in the testsuite.
Jim
