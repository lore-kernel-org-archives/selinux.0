Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CC1C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 20:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiLPUXQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 15:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiLPUXP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 15:23:15 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA67D9C
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 12:23:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a16so5190469edb.9
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 12:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QAPw+7DIl/3FPUTAe1yzSVHmjDUtSqlpG4Dxe1iQbSc=;
        b=e3tXTLVlpEozpDRBFeYvLeLPIOIKKw28npRQV1fm+UAeN3gj+D6r9TD266ZlJy5otk
         ZH7dTQv3ZwM9x8gKeGCROp3hpiK9kz0SB9Kg2WJV0J3vykni3/ZgRN5lB4+ith3LNqfr
         R7yXK2It3TMiYw94ASN/AzWmgUqU575fQIuUEJrXYJSvu7j4YSkE0j2kdu4zbRjdS84r
         HgJEp47dyYdx/ds/NKDzmije1uFhiEX6q9cFHEi05NDEvYj0rklg/Uhx15AyrNfrX4la
         vyAsTrWC8ZeVhyTfzUQCZaPkZXEBApdLJ8cCQg6OL+GlDQKW9RL8VbeOYsANoeD+1QgB
         IrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAPw+7DIl/3FPUTAe1yzSVHmjDUtSqlpG4Dxe1iQbSc=;
        b=Q5fLJjzq6yEKlb//yLJYkk1Xg9MHnpVkMCYW5n4UOyRKuY5pQ716G8Wexuhf+D9l+i
         L+bCms+UJFohDGswfrJ4Kdca4wp/DE8QtP9ji2E+dO+30rVzMyGxqptvrjSLtYl02ZP0
         J4IicVQboF3jT3H7IUbN1tMY69f/tgK/chhlpt1OpN7lP+4WIU2jG3e0l1wGujgKvtLK
         C8DYBDabf8vBXi1rUbkB5cqyOKyq5enrv7qmQhvMaNi+3He3SGKVHRIPS55xRPSIn662
         jym/Tf+pgj13h8cmcn4m0BTOIPBhvJOvJWahg9uGzC6BW0KJ+TBhzwYTZ7m/AL1lr0sw
         QXNA==
X-Gm-Message-State: ANoB5pmnoNH3dzchCs1mM0/UnQjgHjLdd/AZitltMUbqtZVDa58AERCZ
        PsA1A1pYvBfl7uK+Y6kXmWdlUv13IwOoFHfNgVy/xVzO
X-Google-Smtp-Source: AA0mqf4XMYbkpqopBz796ejZvwzpY/msf4JdyAoSA5DiD6vtYJzjRzPVIe+VnFqzrrM+eRHmKQjwkotABKEvjVbWB1Q=
X-Received: by 2002:a05:6402:1246:b0:46d:a8f2:93e8 with SMTP id
 l6-20020a056402124600b0046da8f293e8mr4894578edw.423.1671222192701; Fri, 16
 Dec 2022 12:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20221215213429.998948-1-jwcart2@gmail.com> <f89d7d5e-2dce-e755-ead9-d575cd6513c2@linux.microsoft.com>
In-Reply-To: <f89d7d5e-2dce-e755-ead9-d575cd6513c2@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 15:23:01 -0500
Message-ID: <CAP+JOzSM668Q9BqtZHob+kiWVmRNnj=d=p484Fk+P0UVH4DBng@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add CIL Deny Rule
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 16, 2022 at 1:52 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 12/15/2022 4:34 PM, James Carter wrote:
> > I don't expect this to be part of the upcoming userspace release,
> > but I did want to see if this is going to be what Cascade needs.
>
> Thank you!  I've been playing with this series locally all morning and
> so far it mostly works as expected.  The only minor surprise so far is
> if I do something like:
>
> (type my_type1)
> (type my_type2)
> (type my_type3)
> (typeattributeset my_attr (my_type1 my_type2 my_type3))
> (allow my_attr my_attr (process (signal signull)))
> (deny my_type1 my_attr (process (signal)))
>
> I get rules like this:
>
> $ sesearch -A -s my_attr policy.33
> allow deny_rule_attr_11 my_attr:process { signal signull };
> allow my_attr my_attr:process signull;
>
> Since deny_rule_attr_11 is a subset of my_attr (specifically, my_type2
> and my_type3), both of those types get the "signull" permission from the
> second rule on the attribute, and only strictly need the "signal"
> permission (which my_type1 doesn't get)
>
> It's obviously not a real problem, since it's just redundant policy and
> both versions are functionally equivalent.  It's just a little weird
> browsing the rules using sesearch, particularly with large permission
> sets (My first attribute test involved using "all" on the file class and
> denying one permission from a type, and it was mildly challenging to
> manually verify the results looking at the allow rules in a large list.)
>

I knew that I was creating some redundancy in the rules, but I was
trying to eliminate the special cases. Now that I have something that
appears to be working, it will probably be worth it to go back and see
how messy it would be to remove some of the redundancy.

> Anyways, besides that minor issue everything I've tried so far has
> worked well and the overall concept seems sensible and helpful.
> Although, I still need to get my head around the specifics of the
> attribute handling, and I haven't looked thoroughly at the code yet.
>
> I intend to do more thorough testing and code review, but I don't expect
> I'll have time before the holidays, so that will likely come in January.
>   Since I don't have time for anything more thorough now, hopefully some
> first impressions are helpful in the interim.
>

I am going to be on vacation for the last two weeks of December, so I
won't be getting back to this until January anyway.

Thanks for the quick look and comments!
Jim


> -Daniel
>
> >
> > This series of patches implements a deny rule in CIL. A deny rule will remove
> > the stated permissions in it from the policy. CIL does this by searching for
> > allow rules that match the deny rule and then writing new allow rules that
> > correspond to the matched allow rule with the permissions from the deny rule
> > removed. The rule uses the same syntax as an allow rule, but with "deny"
> > instead of "allow".
> >
> >    (deny SRC TGT (CLASS (PERMS)))
> >
> > Deny rules are processed during post processing (after the AST is resolved,
> > but before the binary policy is written). This means that neverallow checking
> > is done after deny rules are resolved. Deny rules are complimentary to
> > neverallow checking. When an allow rule is found that matches, a deny rule
> > removes permissions while a neverallow rule reports an error.
> >
> > Patch 4 is biggest and most complex since it is the one doing the processing.
> >
> > James Carter (9):
> >    libsepol/cil: Parse and add deny rule to AST, but do not process
> >    libsepol/cil: Add cil_list_is_empty macro
> >    libsepol/cil: Add cil_tree_remove_node function
> >    libsepol/cil: Process deny rules
> >    libsepol/cil: Add cil_write_post_ast function
> >    libsepol: Export the cil_write_post_ast function
> >    secilc/secil2tree: Add option to write CIL AST after post processing
> >    secilc/test: Add a deny rule test
> >    secilc/docs: Add deny rule to CIL documentation
> >
> >   libsepol/cil/include/cil/cil.h         |   1 +
> >   libsepol/cil/src/cil.c                 |  68 ++
> >   libsepol/cil/src/cil_build_ast.c       |  56 ++
> >   libsepol/cil/src/cil_build_ast.h       |   2 +
> >   libsepol/cil/src/cil_copy_ast.c        |  19 +
> >   libsepol/cil/src/cil_copy_ast.h        |   1 +
> >   libsepol/cil/src/cil_deny.c            | 957 +++++++++++++++++++++++++
> >   libsepol/cil/src/cil_deny.h            |  34 +
> >   libsepol/cil/src/cil_flavor.h          |   1 +
> >   libsepol/cil/src/cil_internal.h        |  10 +
> >   libsepol/cil/src/cil_list.h            |   3 +
> >   libsepol/cil/src/cil_post.c            |   7 +
> >   libsepol/cil/src/cil_reset_ast.c       |   8 +
> >   libsepol/cil/src/cil_resolve_ast.c     |  44 ++
> >   libsepol/cil/src/cil_resolve_ast.h     |   1 +
> >   libsepol/cil/src/cil_tree.c            |  27 +
> >   libsepol/cil/src/cil_tree.h            |   1 +
> >   libsepol/cil/src/cil_verify.c          |   9 +
> >   libsepol/cil/src/cil_write_ast.c       |  10 +
> >   libsepol/cil/src/cil_write_ast.h       |   1 +
> >   libsepol/src/libsepol.map.in           |   5 +
> >   secilc/docs/cil_access_vector_rules.md |  68 ++
> >   secilc/secil2tree.c                    |   8 +-
> >   secilc/test/deny_rule_test.cil         | 384 ++++++++++
> >   24 files changed, 1724 insertions(+), 1 deletion(-)
> >   create mode 100644 libsepol/cil/src/cil_deny.c
> >   create mode 100644 libsepol/cil/src/cil_deny.h
> >   create mode 100644 secilc/test/deny_rule_test.cil
> >
>
