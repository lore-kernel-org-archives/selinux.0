Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B49C54E4B
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 19:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEB62070B
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 19:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA2Uwwny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgEKTBW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 15:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728613AbgEKTBV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 15:01:21 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15230C061A0C
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 12:01:21 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j16so16031103oih.10
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u56/FiQ0mmBW+vHFeS8pc5DbwjgoYpOIhmUM2HTH73E=;
        b=eA2UwwnyxP4UPL8qsFnJd1EaeN95A4mUGxinuu0nkTHoD3eYTK4zxQ5ClC0reitsk9
         Il2W8U0gJ95JwV0N55Nk/DB5J+VeuT1vjMKuNZ4pVyQ2F0x3hOe+isLef43bfturB/15
         KxKgVdT4/vK9rfhNf187vBfgoRU58HiHgFBWNN5iowirFl2ZLPS74sV2uEIk3xJJ3Q79
         RvfrM5XTWiyNLPP9nwmhJsMmaB2IPlMD5QfVezBoy53HDSQcFQmDxhlee4A8bIQY8YeB
         kZ6xj6+esm3QnWryvphabdXgOr88JzQIe1yP3vngJly3z0l4HKW98z7yZrHrFdE/HWgw
         E7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u56/FiQ0mmBW+vHFeS8pc5DbwjgoYpOIhmUM2HTH73E=;
        b=FCNsfNnIpMbHD+040BntTl3PohKGjqN+An3xkcYXvyKKfIpK2zffV7g2yLgzfAN/bE
         /vZoiQVCOdrrhABKR8+L7YuPDyeKEFndw96dBbxz3uAhnwycfBCBHJHAI5la937L67Qn
         lfKuDHemJucxYqTMObGD93Rjg1Q1lJtO4/nUS7wvLw2Z4xoj6CByfBr7OHiFBw8+IFR/
         TFs8s8rFerh/9clfGYqWbSm9U5+mDQGJPYMCoUgiKvq1oX5fjPJz5O1Z+mZXKHjx/vHz
         x6gOLKF1Xis1UIr+x2RHunDkNxkaR4+jM09LSZk/wqMoryepwqZtWzbjQk5Ko/6LFB50
         +EzQ==
X-Gm-Message-State: AGi0PubVIXh1OdZn4HO0ERNr3PZpmD54ex0Ubnzar08VbbC8Yo5jCT1H
        WCWFxvEQPklwGrFEL0w8NyeYW+9RGmJsCxIS6jyLPRFPQ/c=
X-Google-Smtp-Source: APiQypLQkxUS0VGG4NjD+tPJfn9kzwTjy4ietlWbnjMNKQN2ap8NNCs7AsU8QuXMlBcwUOr0cV7b95rluGbkGGF0gdA=
X-Received: by 2002:aca:f454:: with SMTP id s81mr19562815oih.138.1589223680369;
 Mon, 11 May 2020 12:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200305135337.113248-1-omosnace@redhat.com> <20200511122703.GA26404@workstation>
 <CAP+JOzSep5+YSZm68ru2NOOoPUhazE3dy9x6t1AqUJxfgDNrJQ@mail.gmail.com>
 <CAP+JOzTUiNhyPPVOm-cFqNzPUGmQKmGvR9n_yNbTatQ8tYnJng@mail.gmail.com> <CAEjxPJ7Px-LkZPGk_Oe=G6HZP_Yu1a=nWDBPc6i=oNOMf0nG9A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Px-LkZPGk_Oe=G6HZP_Yu1a=nWDBPc6i=oNOMf0nG9A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 11 May 2020 15:01:06 -0400
Message-ID: <CAP+JOzTX3tFUAeheUUDB4br+nLhqCUP+EPY_XuTugDoqpwNGVg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 11, 2020 at 2:09 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, May 11, 2020 at 2:03 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Mon, May 11, 2020 at 9:25 AM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > On Mon, May 11, 2020 at 8:27 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > >
> > > > On Thu, Mar 05, 2020 at 02:53:37PM +0100, Ondrej Mosnacek wrote:
> > > > > The value attrs_expand_size == 1 removes all empty attributes, but it
> > > > > also makes sense to expand all attributes that have only one type. This
> > > > > removes some redundant rules (there is sometimes the same rule for the
> > > > > type and the attribute) and reduces the number of attributes that the
> > > > > kernel has to go through when looking up rules.
> > > > >
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > ---
> > > > >
> > > > > v2: fix typos (Tne -> The; cointains -> contains)
> > > > >
> > > > >  libsepol/cil/src/cil.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > > > index d222ad3a..c010ca2a 100644
> > > > > --- a/libsepol/cil/src/cil.c
> > > > > +++ b/libsepol/cil/src/cil.c
> > > > > @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
> > > > >       (*db)->disable_dontaudit = CIL_FALSE;
> > > > >       (*db)->disable_neverallow = CIL_FALSE;
> > > > >       (*db)->attrs_expand_generated = CIL_FALSE;
> > > > > -     (*db)->attrs_expand_size = 1;
> > > > > +     /* 2 == remove attributes that contain none or just 1 type */
> > > > > +     (*db)->attrs_expand_size = 2;
> > > > >       (*db)->preserve_tunables = CIL_FALSE;
> > > > >       (*db)->handle_unknown = -1;
> > > > >       (*db)->mls = -1;
> > > > > --
> > > > > 2.24.1
> > > > >
> > > >
> > > >
> > > > This patch broke `semanage node -l` on Fedora [1]
> > > >
> > > > :: [ 21:25:25 ] :: [  BEGIN   ] :: Running 'make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 test'
> > > > ...
> > > > test_list (__main__.SemanageTests) ... Traceback (most recent call last):
> > > >   File "/usr/sbin/semanage", line 967, in <module>
> > > >     do_parser()
> > > >   File "/usr/sbin/semanage", line 946, in do_parser
> > > >     args.func(args)
> > > >   File "/usr/sbin/semanage", line 649, in handleNode
> > > >     OBJECT = object_dict['node'](args)
> > > >   File "/usr/lib/python3.8/site-packages/seobject.py", line 1849, in __init__
> > > >     self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
> > > > IndexError: list index out of range
> > > >
> > > > While the `IndexError: list index out of range` error can be simply fixed, it
> > > > uncovered the problem that semanage uses attibutes to list certain records -
> > > > node_type, port_type, file_type, device_node, ... and these attributes can disappear when
> > > > there's only 1 type assigned.
> > > >
> > > > I guess it should be reverted as there's no other way how to find out that a
> > > > type node_t is node_type.
> > > >
> > > > [1] https://jenkins-continuous-infra.apps.ci.centos.org/job/fedora-rawhide-pr-pipeline/3462/artifact/package-tests/logs/FAIL-upstream-err.log
> > > >
> >
> > I see now.  python/semanage/seobject.py and
> > python/semanage/semanage-bash-completion.sh both assume that node_type
> > is always defined as an attribute in a policy. There seems to be quite
> > a lot that is assumed about policy in the python directory.
> >
> > This is not a bug in CIL or libsepol. Ideally the tests should have
> > their own policy and the python code should gracefully handle the
> > situation when its assumptions are wrong. If we need to revert this
> > patch in the short-term than I am ok with that.
>
> We can mark these attributes explicitly in policy to prevent their
> expansion, right?  So while we cannot make this change right now
> without breaking compatibility with selinux userspace tools (not just
> tests), we could start marking these attributes on which the tools
> depend in policy and then later we can re-apply this?

Yes, we can add the rule "expandattribute node_type false;" in policy
for node_type and any other attributes that are required to exist.

Jim
