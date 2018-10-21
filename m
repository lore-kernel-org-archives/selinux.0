Return-Path: <SRS0=UzCa=NB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7F9ECDE3D
	for <selinux@archiver.kernel.org>; Sun, 21 Oct 2018 09:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7BF2083E
	for <selinux@archiver.kernel.org>; Sun, 21 Oct 2018 09:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7BF2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJUReG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:34:06 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:49415 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeJUReF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Oct 2018 13:34:05 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D388C56128A
        for <selinux@vger.kernel.org>; Sun, 21 Oct 2018 11:20:23 +0200 (CEST)
Received: by mail-oi1-f181.google.com with SMTP id y81-v6so29929890oia.6
        for <selinux@vger.kernel.org>; Sun, 21 Oct 2018 02:20:23 -0700 (PDT)
X-Gm-Message-State: ABuFfogPHZpqQSMbtCecbpcEaxPX59uHnuuT/Ej0+UL/4c7sV3OQb0nm
        AjaqWmXFYPiyZkKCXqq2YKT2s4u5xRhpEL+naiQ=
X-Google-Smtp-Source: ACcGV61WmULTHvxPO3cn/cR/+2nyhEvnwP/Q+V2o04jXnPnAOVQhI5083CSKwb4EtNDMS/RwFy1Y1hr4FAlIlDTYjdo=
X-Received: by 2002:aca:590b:: with SMTP id n11-v6mr20635818oib.232.1540113622816;
 Sun, 21 Oct 2018 02:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181016100533.12249-1-vmojzis@redhat.com> <20181016100533.12249-3-vmojzis@redhat.com>
 <CAJfZ7=nTojoSkL8Eg84ZX429+tETXOVDJ7m0rC3R3dHqK93VSQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=nTojoSkL8Eg84ZX429+tETXOVDJ7m0rC3R3dHqK93VSQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 21 Oct 2018 11:20:11 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nSsAKJ=MB6HiZ3mDE3kVa4Yx8imkVDsq-ngC-2O8Vfpg@mail.gmail.com>
Message-ID: <CAJfZ7=nSsAKJ=MB6HiZ3mDE3kVa4Yx8imkVDsq-ngC-2O8Vfpg@mail.gmail.com>
Subject: Re: [PATCH 2/3] python/sepolicy: Stop rejecting aliases in sepolicy commands
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Oct 21 11:20:24 2018 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Oct 21, 2018 at 11:10 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Oct 16, 2018 at 12:05 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Fix CheckDomain and CheckPortType classes to properly deal with aliases.
> >
> > Resolves:
> >    https://bugzilla.redhat.com/show_bug.cgi?id=1600009
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> >  python/sepolicy/sepolicy.py          |  8 +++-----
> >  python/sepolicy/sepolicy/__init__.py | 10 +++++++++-
> >  2 files changed, 12 insertions(+), 6 deletions(-)
> >
> [...]
> > diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> > index 8484b28c..0da3917b 100644
> > --- a/python/sepolicy/sepolicy/__init__.py
> > +++ b/python/sepolicy/sepolicy/__init__.py
> > @@ -447,6 +447,14 @@ def get_file_types(setype):
> >      return mpaths
> >
> >
> > +# determine if entered type is an alias
> > +# and return corresponding type name
> > +def get_real_type_name(name):
> > +    try:
> > +        return next(info(TYPE, name))["name"]
> > +    except (RuntimeError, StopIteration):
> > +        return None
> > +
>
> When I first read the function comment, I did not understand whether
> the returned value was a kind of SELinux type (like something which
> would say "a file type", "a port type") or the SELinux type which is
> aliased. It is the second interpretation which is implemented.
> Moreover, this comment seems to be better in a function docstring. I
> suggest changing this into the following:
>
> def get_real_type_name(name):
>     """Return the real name of a type:
>
>     * If 'name' refers to a type, return the same name.
>     * If 'name' refers to a type alias, return the corresponding name.
>     * Otherwise return None.
>     """
>
> What do you think of this suggestion?
>
> Moreover, when is RuntimeError triggered, in the exception that are caught?

Also, if name is empty, sepolicy.info(TYPE, name) returns all
available types, so get_real_type_name("") returns the first type in
the list of types defined in the policy. I saw that your patches use
"if setype and sepolicy.get_real_type_name(setype) not in
self.valid_types" in many places (which looks good). To increase the
robustness of the Python code, I would also add a test in
get_real_type_name as well, like:

    if not name:
        return None

Nicolas

