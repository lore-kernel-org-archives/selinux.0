Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D8C47255
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E45206F5
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 13:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huj/INkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgEKN0H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 09:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729382AbgEKN0G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 09:26:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF9C061A0C
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 06:26:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g14so7469682otg.10
        for <selinux@vger.kernel.org>; Mon, 11 May 2020 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xaQ0fOZJ1D6mu/ym9wKt8A9Qb75L+eOoxHnODzwGbtk=;
        b=huj/INkUriy0jQP7ZFzMRqDjNjNGIZAM2Y15f+VWcfYP0riBrb2Y8o8vVPYnW7rF0t
         V1yJt7BmYzCvVGFj9Hj5oos8G2oErTTtHCHR9bldHBm8IH9Mg5tqiHliIcg9B4Zja4+Y
         UWU9z3ESa+zSIJ/+dqDVBuCRswn49cmj3ws6+wDoe6uiqj0xYeRh5jgfRZqx+rLZ1Wvj
         NyQNJiiE9N6PPG48AWsxUHv9q56nlTrz3mz6NTZhFC1kL9F1HLGrcSQc0MNar3vR4NEX
         UptDn57zIm4H4CuQK8/DXCnKwC1dWWUNhVqz9BrGg37sjwfrit2geu/hJqUDaaGeQoFs
         dXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xaQ0fOZJ1D6mu/ym9wKt8A9Qb75L+eOoxHnODzwGbtk=;
        b=fb4dBTMVJkP0x9SlJ1YfWUBQEXqX9+t7I5Kqzieszr+qV0G91iXb0mA5x6ryiPS3FB
         RVfxLJpQeF8Zs/ySliHGKLu/Fl9f4QsryKKaW+unnimUQOCy0EucOiwL2sU1wEhbgZXC
         fYBwuNfghBvC0glsB2N8Hn/wpujvTgoO1M6u2sm9Zrgor1F250Ceg3eUy748qQtmGEI/
         f/LRMhfwBB+rVtJ3rSNMuuqNDIUjWFTRe+SqSUXYaSrKshX2p3vT2IDeEDTII4/moFTS
         1ZkRBEsvQar/cf0ZZVyeBsX7F9n/q253SvcbjEKbCYo54oxYTRKmgboUxaWHixt50p++
         qgIw==
X-Gm-Message-State: AGi0Pua94m/F1FgbdQ1EsL4mhRVF0buZ8hGsTQKpIgO+AIBGoPA1vEH8
        d3RzAxc+J9UOvdCNzuTIi9Jq+jQigcypimAbFvVXgiQ2
X-Google-Smtp-Source: APiQypLTmQotOK2ZnT3angMYcnHCIU+bf0rlUSCgXGqLTpBdbU2HybXTXbBGzIgXEouCP4BNJH3CxthMmrPLq7f/7/U=
X-Received: by 2002:a05:6830:1c2b:: with SMTP id f11mr13283822ote.196.1589203565336;
 Mon, 11 May 2020 06:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200305135337.113248-1-omosnace@redhat.com> <20200511122703.GA26404@workstation>
In-Reply-To: <20200511122703.GA26404@workstation>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 11 May 2020 09:25:52 -0400
Message-ID: <CAP+JOzSep5+YSZm68ru2NOOoPUhazE3dy9x6t1AqUJxfgDNrJQ@mail.gmail.com>
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

On Mon, May 11, 2020 at 8:27 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Thu, Mar 05, 2020 at 02:53:37PM +0100, Ondrej Mosnacek wrote:
> > The value attrs_expand_size == 1 removes all empty attributes, but it
> > also makes sense to expand all attributes that have only one type. This
> > removes some redundant rules (there is sometimes the same rule for the
> > type and the attribute) and reduces the number of attributes that the
> > kernel has to go through when looking up rules.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > v2: fix typos (Tne -> The; cointains -> contains)
> >
> >  libsepol/cil/src/cil.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index d222ad3a..c010ca2a 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
> >       (*db)->disable_dontaudit = CIL_FALSE;
> >       (*db)->disable_neverallow = CIL_FALSE;
> >       (*db)->attrs_expand_generated = CIL_FALSE;
> > -     (*db)->attrs_expand_size = 1;
> > +     /* 2 == remove attributes that contain none or just 1 type */
> > +     (*db)->attrs_expand_size = 2;
> >       (*db)->preserve_tunables = CIL_FALSE;
> >       (*db)->handle_unknown = -1;
> >       (*db)->mls = -1;
> > --
> > 2.24.1
> >
>
>
> This patch broke `semanage node -l` on Fedora [1]
>
> :: [ 21:25:25 ] :: [  BEGIN   ] :: Running 'make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 test'
> ...
> test_list (__main__.SemanageTests) ... Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 967, in <module>
>     do_parser()
>   File "/usr/sbin/semanage", line 946, in do_parser
>     args.func(args)
>   File "/usr/sbin/semanage", line 649, in handleNode
>     OBJECT = object_dict['node'](args)
>   File "/usr/lib/python3.8/site-packages/seobject.py", line 1849, in __init__
>     self.valid_types = list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_type"))[0]["types"])
> IndexError: list index out of range
>
> While the `IndexError: list index out of range` error can be simply fixed, it
> uncovered the problem that semanage uses attibutes to list certain records -
> node_type, port_type, file_type, device_node, ... and these attributes can disappear when
> there's only 1 type assigned.
>
> I guess it should be reverted as there's no other way how to find out that a
> type node_t is node_type.
>
> [1] https://jenkins-continuous-infra.apps.ci.centos.org/job/fedora-rawhide-pr-pipeline/3462/artifact/package-tests/logs/FAIL-upstream-err.log
>
> Petr

This suggests that there is a problem with how type attributes are
being expanded. This patch is just causing that problem to be exposed.
I'll have to investigate.

Thanks for the report.

Jim
