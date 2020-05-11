Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B8AC47255
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536D620720
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 18:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2zQsnuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgEKSDP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 14:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEKSDO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 14:03:14 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897A6C061A0C
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 11:03:14 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v17so347502ote.0
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rcDaOQytWJr2eNcsaKHFLs/QqO47Cquzh+pFyVHk26c=;
        b=r2zQsnuQCtSz4Eqp/Th7QNe8zOu/A4Sep68Nahiht0po4HP3+/u1+/O7r6jCU4HiT6
         VKcCJ49SN7gebOGtS8NS5o18R0kS+W2XnE3MF4QHPbrOIUMP9gN08CuSTx/8UFEsmzkX
         63dpV+e84fBj3WiMdlVg1dS8s88jobD83RQXaFCw4CEQ3vO5oX490Lw+25MYVJidERLc
         roO0kQUFaeneLmLfr6gcXjlOg1AtTTDCmIx/22YToSCUtdMoQBGhJAvH4v3OutjNNQbn
         XsGzQiGAXrQnvAlAY+G234onse/zPiCak+yy9OR7vWuaKXAPo5xhfjgeK5pwIK2yb1fB
         jX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rcDaOQytWJr2eNcsaKHFLs/QqO47Cquzh+pFyVHk26c=;
        b=uYQJrUa9buoJWNjCNM6jqh98W/wM0hNWi3hhaWv8vBDg8WKy4AMyNCZT9wZS0lQOMN
         HzYUlFXBikcyWCyTSVy87QpC3dCreKTmcYKCtfaOW6DkssXIG6OvyAFfyYvrz7scyDmR
         hivWhS0hbSMbHtVrrSx86vMLliAssppvlpgjZLlO+1nMNjhDJStgn3xPDKOWMDNS8uVq
         OVZwgOGPwJCpoiSiwm+lNUadDdZl5O4iGFRPPcMCKHtuQbiGXnO0RRNSuXZivyP9qizD
         tEShQZYFwrUUO7ndbNkBuGC8gQNmdWKCl2ReyaX7+p/3Wu5C61lQ6zZwe7lBVS41483V
         MX2Q==
X-Gm-Message-State: AGi0PubmIUgHvkZDL/cFr3CPJXrLEuFUeYemPOrNaNzmetdWDVmEgmDP
        +j/HkclUcenALcx6w+wXpaw0f4BsS87KM7wh2wE=
X-Google-Smtp-Source: APiQypL5pykrjFhA7K6zUEUdSPLkyWeanA9fu3qlEzGJMe4/5gaXHftRRxKHLBF7OLb4oTuTFUT1XP2qHXD3HWAYnYw=
X-Received: by 2002:a9d:310:: with SMTP id 16mr226007otv.59.1589220193850;
 Mon, 11 May 2020 11:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200305135337.113248-1-omosnace@redhat.com> <20200511122703.GA26404@workstation>
 <CAP+JOzSep5+YSZm68ru2NOOoPUhazE3dy9x6t1AqUJxfgDNrJQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSep5+YSZm68ru2NOOoPUhazE3dy9x6t1AqUJxfgDNrJQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 11 May 2020 14:03:02 -0400
Message-ID: <CAP+JOzTUiNhyPPVOm-cFqNzPUGmQKmGvR9n_yNbTatQ8tYnJng@mail.gmail.com>
Subject: Re: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 11, 2020 at 9:25 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, May 11, 2020 at 8:27 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > On Thu, Mar 05, 2020 at 02:53:37PM +0100, Ondrej Mosnacek wrote:
> > > The value attrs_expand_size == 1 removes all empty attributes, but it
> > > also makes sense to expand all attributes that have only one type. This
> > > removes some redundant rules (there is sometimes the same rule for the
> > > type and the attribute) and reduces the number of attributes that the
> > > kernel has to go through when looking up rules.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >
> > > v2: fix typos (Tne -> The; cointains -> contains)
> > >
> > >  libsepol/cil/src/cil.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > index d222ad3a..c010ca2a 100644
> > > --- a/libsepol/cil/src/cil.c
> > > +++ b/libsepol/cil/src/cil.c
> > > @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
> > >       (*db)->disable_dontaudit = CIL_FALSE;
> > >       (*db)->disable_neverallow = CIL_FALSE;
> > >       (*db)->attrs_expand_generated = CIL_FALSE;
> > > -     (*db)->attrs_expand_size = 1;
> > > +     /* 2 == remove attributes that contain none or just 1 type */
> > > +     (*db)->attrs_expand_size = 2;
> > >       (*db)->preserve_tunables = CIL_FALSE;
> > >       (*db)->handle_unknown = -1;
> > >       (*db)->mls = -1;
> > > --
> > > 2.24.1
> > >
> >
> >
> > This patch broke `semanage node -l` on Fedora [1]
> >
> > :: [ 21:25:25 ] :: [  BEGIN   ] :: Running 'make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 test'
> > ...
> > test_list (__main__.SemanageTests) ... Traceback (most recent call last):
> >   File "/usr/sbin/semanage", line 967, in <module>
> >     do_parser()
> >   File "/usr/sbin/semanage", line 946, in do_parser
> >     args.func(args)
> >   File "/usr/sbin/semanage", line 649, in handleNode
> >     OBJECT = object_dict['node'](args)
> >   File "/usr/lib/python3.8/site-packages/seobject.py", line 1849, in __init__
> >     self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
> > IndexError: list index out of range
> >
> > While the `IndexError: list index out of range` error can be simply fixed, it
> > uncovered the problem that semanage uses attibutes to list certain records -
> > node_type, port_type, file_type, device_node, ... and these attributes can disappear when
> > there's only 1 type assigned.
> >
> > I guess it should be reverted as there's no other way how to find out that a
> > type node_t is node_type.
> >
> > [1] https://jenkins-continuous-infra.apps.ci.centos.org/job/fedora-rawhide-pr-pipeline/3462/artifact/package-tests/logs/FAIL-upstream-err.log
> >

I see now.  python/semanage/seobject.py and
python/semanage/semanage-bash-completion.sh both assume that node_type
is always defined as an attribute in a policy. There seems to be quite
a lot that is assumed about policy in the python directory.

This is not a bug in CIL or libsepol. Ideally the tests should have
their own policy and the python code should gracefully handle the
situation when its assumptions are wrong. If we need to revert this
patch in the short-term than I am ok with that.

Jim

> > Petr
>
> This suggests that there is a problem with how type attributes are
> being expanded. This patch is just causing that problem to be exposed.
> I'll have to investigate.
>
> Thanks for the report.
>
> Jim
