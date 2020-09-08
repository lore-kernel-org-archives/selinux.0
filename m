Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F134DC43461
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 20:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9F72080A
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 20:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DejnxeIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIHUcK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgIHUcE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 16:32:04 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1080C061573
        for <selinux@vger.kernel.org>; Tue,  8 Sep 2020 13:32:03 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g96so332925otb.12
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2020 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8z6tPL1dXiw/92gPfqExBXMx71KHbRXw9gn7R966kaE=;
        b=DejnxeIgnEWIXD+FLgj4RuPja9FFMBPSUaIxxlHoQnBG8ZHl7fB6wGKBa7kls+hfZZ
         gwjuRFX/X5gzgHw0Xkoq/kVjI/PFQuLicf7Wbi/HKD0f0wrJk0v9A1q2bAlLxnRFQNdq
         O1aGq3pNninvky5vx2KDI5Ke+JG6TaiJ5l1QAvzlUgDmipG+KwQqUAweSZumhXkc1YTK
         JtUClr+5KscTfcuLlQ5PoxVyaPmOmeWDXhBHQOYbEmPwuX9bRH8hHqbxZnGWwLiclUcX
         GCE9T9D0LOW9ddZKM1LExkiyTcXYHi+IjhqeY//8SR2+FspTHwyFKdkVffYA6nhSaQpK
         InBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8z6tPL1dXiw/92gPfqExBXMx71KHbRXw9gn7R966kaE=;
        b=UlHw2m3nDEaCTGFWebGvFnTcevKbmPoFk+zcva7+3GqQmoSU2u4jbi4P+x9WSod+PM
         rK1CLnc9EUM/XUfHjWmQ9kQD4nLmVXKhunccgHJeDAYW4SYSu/x2Lfr27ZtSwLdGKb6d
         pAHgc6IVjfp7JO5p9eirXeIweaRN6z70nMge+gVvT1bfOBvNoem5ECc7Lc/05EVOfazv
         9Ws9OsrF1MiHCAw3cKKRpWgCq2sqbqXUruDfd5ofcV0qULCZN/We3LlVfuJN+/Ot/j2w
         vMaNcINaI6dTzV0vvfAG6NsoQ091glZ+l7fvovxiub29hs5Gx/ttMU2wfuPkF2r8+gRS
         3iag==
X-Gm-Message-State: AOAM533Yf/SaXcCz2Q8uWhhXrY3P1JlttgmveYeBMHZk59snUfxtlL8M
        fFBJ+LxYZ5ohj4zCcRAvxwH4KquTnWYlSRSwS1g=
X-Google-Smtp-Source: ABdhPJxwbSm1ze4zFfpDXABuHq6dXl/KMdhBUe7ROuJ19rfDZaBiSuqTgD9epC91SrNLEHRk2hrf6TsTn2JcD7mtHlM=
X-Received: by 2002:a9d:75d1:: with SMTP id c17mr590531otl.59.1599597123239;
 Tue, 08 Sep 2020 13:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200903181900.81179-1-jwcart2@gmail.com> <CAEjxPJ53Z6z2VAw75QOHZdK-kFz1fnkEFth7acyUGh_2nzpGkQ@mail.gmail.com>
 <CAEjxPJ6EXg5B8pjCxs2SdqBGe91u7PZnBPEphWgvvQ_u1mZtYA@mail.gmail.com>
 <CAEjxPJ7fd62jYjhT18tNRhdMiRHt1Nt6QGexHDaDx4DcrBY42w@mail.gmail.com> <CAEjxPJ5GmedEWv_7=nAh+ete8gaeRgRmdyrfpwxifC26KRbGjA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5GmedEWv_7=nAh+ete8gaeRgRmdyrfpwxifC26KRbGjA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 8 Sep 2020 16:31:52 -0400
Message-ID: <CAP+JOzQzuEo2VShco3UjDCE5wU8iJBksq3ShLNYH4ASXVGzdfQ@mail.gmail.com>
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

On Tue, Sep 8, 2020 at 11:27 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 8, 2020 at 9:50 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Sep 8, 2020 at 9:46 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, Sep 4, 2020 at 8:49 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 3, 2020 at 2:19 PM James Carter <jwcart2@gmail.com> wrote:
> > > > >
> > > > > CIL was not correctly determining the depth of constraint expressions
> > > > > which prevented it from giving an error when the max depth was exceeded.
> > > > > This allowed invalid policy binaries with constraint expressions exceeding
> > > > > the max depth to be created.
> > > > >
> > > > > Correctly calculate the depth of constraint expressions when building
> > > > > the AST and give an error when the max depth is exceeded.
> > > > >
> > > > > Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> > > > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > >
> > > > The fix for conditional boolean expression depth checking can be a
> > > > separate patch.  For this one,
> > > >
> > > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > Actually, this breaks selinux-testsuite. Will have to look into why.
> > > /usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil
> > > test_overlay_defaultrange.cil test_add_levels.cil test_glblub.cil
> > > Max depth of 4 exceeded for constraint expression
> > > Bad expression tree for constraint
> > > Bad constrain declaration at
> > > /var/lib/selinux/targeted/tmp/modules/100/base/cil:919
> >
> > Here is the failing cil module:
> > $ cat policy/test_mlsconstrain.cil
> > (mlsconstrain (peer (recv)) (or (dom l1 l2) (and (neq t1
> > mcs_constrained_type) (neq t2 mcs_constrained_type))))
> > (mlsconstrain (packet (recv)) (or (dom l1 l2) (and (neq t1
> > mcs_constrained_type) (neq t2 mcs_constrained_type))))
> >
> > Maybe an off-by-one in your depth checking?
>
> Actually, the depth computation logic doesn't seem consistent with
> checkpolicy's define_constraint().

I don't really understand what checkpolicy is doing. I guess keeping
track of the postfix stack size?

The one difference that would be easy to fix is that checkpolicy ignores "not".

CIL has a max depth = 4, but checkpolicy has a max depth = 0 for these:
(constrain (C5 (P5)) (not (not (not (not (eq t1 T5a))))))
constrain C5 { P5 } not (not (not (not (t1 == T5a))));

Here is one pair of examples that would be hard for me to make CIL
agree with checkpolicy. These are essentially the same constraint:

Both see max depth = 2 for this one
(constrain (C6 (P6)) (or (eq t1 T6g) (and (neq t1 A6a) (neq t2 T6f))))
constrain C6 { P6 } (t1 == T6g or (t1 != A6a and t2 != T6f));

CIL sees max depth = 2 for this one, but checkpolicy has max depth = 1
(constrain (C7 (P7)) (or (and (neq t1 A7a) (neq t2 T7f)) (eq t1 T7g)))
constrain C7 { P7 } ((t1 != A7a and t2 != T7f) or t1 == T7g);

In most other examples that I have created, they had the same max depth.

Both have max depth = 2 for these:
(constrain (C1 (P1)) (or (eq t1 T1a) (and (eq t1 T1b) (eq t1 T1c))))
constrain C1 { P1 } (t1 == T1a or (t1 == T1b and t1 == T1c));

Both have max depth = 4 for these:
(constrain (C2 (P2)) (or (eq t1 T2a) (or (eq t1 T2b) (or (eq t1 T2c)
(and (eq t1 T2d) (eq t1 T2e))))))
constrain C2 { P2 } (t1 == T2a or (t1 == T2b or (t1 == T2c or (t1 ==
T2d and t1 == T2e))));

Both have max depth = 3 for these:
(constrain (C4 (P4)) (or (or (eq t1 T4a) (or (eq t1 T4b) (eq t1 T4c)))
(or (eq t1 T4d) (and (eq t1 T4e) (eq t1 T4f)))))
constrain C4 { P4 } ((t1 == T4a or (t1 == T4b or t1 == T4c)) or (t1 ==
T4d or (t1 == T4e and t1 == T4f)));

Both have max depth = 4 for these:
(constrain (C8 (P8)) (or (or (or (and (neq t1 T8a) (neq t1 T8b)) (and
(neq t1 T8c) (neq t1 T8d))) (or (and (neq t1 T8e) (neq t1 T8f)) (and
(neq t1 T8g) (neq t1 T8h)))) (or (or (and (neq t1 T8i) (neq t1 T8j))
(and (neq t1 T8k) (neq t1 T8l))) (or (and (neq t1 T8m) (neq t1 T8n))
(and (neq t1 T8o) (neq t1 T8p))))))
constrain C8 { P8 } ((((t1 != T8a and t1 != T8b) or (t1 != T8c and t1
!= T8d)) or ((t1 != T8e and t1 != T8f) or (t1 != T8g and t1 != T8h)))
or (((t1 != T8i and t1 != T8j) or (t1 != T8k and t1 != T8l)) or ((t1
!= T8m and t1 != T8n) or (t1 != T8o and t1 != T8p))));

I guess I can convert the expressions to postfix and then follow the
logic of checkpolicy, but that seems to be a lot of work. Instead, I
could add a second check when the binary is being created and the
constraint expression has been turned into postfix already.

Jim
