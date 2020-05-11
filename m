Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE87BC47255
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 18:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897FD206B9
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 18:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFwJUrTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgEKSJK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729564AbgEKSJK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 14:09:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE5EC061A0C
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 11:09:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 72so8344477otu.1
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BqeH8BNEH3a9V3e4hkVArItk671JLl3WqGIUw8onCk=;
        b=cFwJUrTwg3GQoInJ1+sr97eKEJzhTCmzy/KyeJppyxyBuWByOsoNB7Djdt0FLntUe3
         X0frzpG7XuMcb+v/EhOtcsb8T5MBrqk5Dl9W9Nl3Hadp1dM3SttHAzaYtJq4y1K19nue
         zyFBcTd8abA9ZMv98YomhIOdB8q2l/Y7wYZpghYeu1Tvvno1utYs591dYDWSnteu5e0t
         3HT+KIllhVQbdpk4QW0QgpPkPaMDnybD4N5IJ/5uEx9xHDl91BAXnsPBndJQbFboUvMS
         Uphf/VWf3pwrmFdq4pxbw2k1kzuzHqhoQrpGVolRpp+b52BtwTnbCX0V5yjq9JUG4x0P
         PeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BqeH8BNEH3a9V3e4hkVArItk671JLl3WqGIUw8onCk=;
        b=DMPAlBr6H0kZEfgfEJN8K1ZjBhLyUXJszaxIAX+cfobBFmNlQgcNYNUYQxW9cERRPl
         6npnS2qWr/54Tq0swDI9+5yjiUYZcpSJAbG4D2QCfniEaEhJZs1IdG7yWvqmhOSNpj1+
         knEyu7CVxOMM/HFgY9NETV90fLu9OYzcaURBB3zYyfS3WvM//uNczOdPmjbiXtBqC7SM
         tg+1wLkpaJagdUoWkO/FzQjBcmLfzAS6r3LzoWWMXetYA16GCyZ7KBpwcGwYxu/IxMWV
         ecjQfxnFaSsEgnaY6EiVmojPc6Y8pZUOIcaWEA5Yf0DBvDnm7nEE71phgFdV6UALwePl
         OPIw==
X-Gm-Message-State: AGi0PuZvw9IOcCEp3h7WQDbgjSQGZJuOjpjEnT+909Yg8rTiEvnhr3H/
        bpZE0EP+CtauIkYcAQXN0ZnAwbVlk4btY/z+oaI=
X-Google-Smtp-Source: APiQypKBdz++Waxb4vtPyrcNtKCxFECHl5NeR/4hKxoWTrBLa+Epvw2jx0a1hB1P3wjpcIUDqVv2e9VgAYVHD4jtgdc=
X-Received: by 2002:a9d:398b:: with SMTP id y11mr1569078otb.135.1589220549332;
 Mon, 11 May 2020 11:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200305135337.113248-1-omosnace@redhat.com> <20200511122703.GA26404@workstation>
 <CAP+JOzSep5+YSZm68ru2NOOoPUhazE3dy9x6t1AqUJxfgDNrJQ@mail.gmail.com> <CAP+JOzTUiNhyPPVOm-cFqNzPUGmQKmGvR9n_yNbTatQ8tYnJng@mail.gmail.com>
In-Reply-To: <CAP+JOzTUiNhyPPVOm-cFqNzPUGmQKmGvR9n_yNbTatQ8tYnJng@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 11 May 2020 14:08:58 -0400
Message-ID: <CAEjxPJ7Px-LkZPGk_Oe=G6HZP_Yu1a=nWDBPc6i=oNOMf0nG9A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
To:     James Carter <jwcart2@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 11, 2020 at 2:03 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, May 11, 2020 at 9:25 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Mon, May 11, 2020 at 8:27 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > > On Thu, Mar 05, 2020 at 02:53:37PM +0100, Ondrej Mosnacek wrote:
> > > > The value attrs_expand_size == 1 removes all empty attributes, but it
> > > > also makes sense to expand all attributes that have only one type. This
> > > > removes some redundant rules (there is sometimes the same rule for the
> > > > type and the attribute) and reduces the number of attributes that the
> > > > kernel has to go through when looking up rules.
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >
> > > > v2: fix typos (Tne -> The; cointains -> contains)
> > > >
> > > >  libsepol/cil/src/cil.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > > index d222ad3a..c010ca2a 100644
> > > > --- a/libsepol/cil/src/cil.c
> > > > +++ b/libsepol/cil/src/cil.c
> > > > @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
> > > >       (*db)->disable_dontaudit = CIL_FALSE;
> > > >       (*db)->disable_neverallow = CIL_FALSE;
> > > >       (*db)->attrs_expand_generated = CIL_FALSE;
> > > > -     (*db)->attrs_expand_size = 1;
> > > > +     /* 2 == remove attributes that contain none or just 1 type */
> > > > +     (*db)->attrs_expand_size = 2;
> > > >       (*db)->preserve_tunables = CIL_FALSE;
> > > >       (*db)->handle_unknown = -1;
> > > >       (*db)->mls = -1;
> > > > --
> > > > 2.24.1
> > > >
> > >
> > >
> > > This patch broke `semanage node -l` on Fedora [1]
> > >
> > > :: [ 21:25:25 ] :: [  BEGIN   ] :: Running 'make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 test'
> > > ...
> > > test_list (__main__.SemanageTests) ... Traceback (most recent call last):
> > >   File "/usr/sbin/semanage", line 967, in <module>
> > >     do_parser()
> > >   File "/usr/sbin/semanage", line 946, in do_parser
> > >     args.func(args)
> > >   File "/usr/sbin/semanage", line 649, in handleNode
> > >     OBJECT = object_dict['node'](args)
> > >   File "/usr/lib/python3.8/site-packages/seobject.py", line 1849, in __init__
> > >     self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
> > > IndexError: list index out of range
> > >
> > > While the `IndexError: list index out of range` error can be simply fixed, it
> > > uncovered the problem that semanage uses attibutes to list certain records -
> > > node_type, port_type, file_type, device_node, ... and these attributes can disappear when
> > > there's only 1 type assigned.
> > >
> > > I guess it should be reverted as there's no other way how to find out that a
> > > type node_t is node_type.
> > >
> > > [1] https://jenkins-continuous-infra.apps.ci.centos.org/job/fedora-rawhide-pr-pipeline/3462/artifact/package-tests/logs/FAIL-upstream-err.log
> > >
>
> I see now.  python/semanage/seobject.py and
> python/semanage/semanage-bash-completion.sh both assume that node_type
> is always defined as an attribute in a policy. There seems to be quite
> a lot that is assumed about policy in the python directory.
>
> This is not a bug in CIL or libsepol. Ideally the tests should have
> their own policy and the python code should gracefully handle the
> situation when its assumptions are wrong. If we need to revert this
> patch in the short-term than I am ok with that.

We can mark these attributes explicitly in policy to prevent their
expansion, right?  So while we cannot make this change right now
without breaking compatibility with selinux userspace tools (not just
tests), we could start marking these attributes on which the tools
depend in policy and then later we can re-apply this?
