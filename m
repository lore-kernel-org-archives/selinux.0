Return-Path: <SRS0=HD60=QM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C5C282CB
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 07:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7A72083B
	for <selinux@archiver.kernel.org>; Tue,  5 Feb 2019 07:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfBEHTy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:19:54 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:42500 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfBEHTy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Feb 2019 02:19:54 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A32CA561207
        for <selinux@vger.kernel.org>; Tue,  5 Feb 2019 08:19:50 +0100 (CET)
Received: by mail-ot1-f50.google.com with SMTP id 81so4195329otj.2
        for <selinux@vger.kernel.org>; Mon, 04 Feb 2019 23:19:50 -0800 (PST)
X-Gm-Message-State: AHQUAub6L8y+c0NeMojwskV6VulUaR24EwEVf8IlDnL1Svd5sYO7zBvf
        E1/zeZjc/H3XadU/hTjlR5CPQX83SPKcueQMFJY=
X-Google-Smtp-Source: AHgI3IaYPoEjK3wc5TH3nQyqgjjYe1MXKfoWte5l6Agi67mbgULOYjQUkWae06FXr2w5ehlJttAQHKuYC4KzIV2lJAM=
X-Received: by 2002:a9d:6108:: with SMTP id i8mr1901804otj.278.1549351189754;
 Mon, 04 Feb 2019 23:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20190131194140.3785-1-plautrba@redhat.com> <CAJfZ7=nUFYY9QLaArWAfLksvjB-xvvPwz2TvxuKPsTysSG5K=w@mail.gmail.com>
In-Reply-To: <CAJfZ7=nUFYY9QLaArWAfLksvjB-xvvPwz2TvxuKPsTysSG5K=w@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 5 Feb 2019 08:19:38 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kWR-dMFu8djrOYRO_-Lc1rbk+29k5_v=P-R0eRwc==eg@mail.gmail.com>
Message-ID: <CAJfZ7=kWR-dMFu8djrOYRO_-Lc1rbk+29k5_v=P-R0eRwc==eg@mail.gmail.com>
Subject: Re: [PATCH] python/semanage: Examples are no longer in the main
 semanage man page
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Dan Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb  5 08:19:51 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 11:06 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jan 31, 2019 at 8:41 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > From: Dan Walsh <dwalsh@redhat.com>
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Indeed, commit 1925e1e91d99 ("Break the semanage man page into
> different man pages per category.") moved the examples in 2013.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged. Thanks
Nicolas

> > ---
> >  python/semanage/semanage.8 | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/python/semanage/semanage.8 b/python/semanage/semanage.8
> > index 0bdb90f4..0cdcfccd 100644
> > --- a/python/semanage/semanage.8
> > +++ b/python/semanage/semanage.8
> > @@ -57,9 +57,8 @@ to SELinux user identities (which controls the initial security context
> >  assigned to Linux users when they login and bounds their authorized role set)
> >  as well as security context mappings for various kinds of objects, such
> >  as network ports, interfaces, infiniband pkeys and endports, and nodes (hosts)
> > -as well as the file context mapping. See the EXAMPLES section below for some
> > -examples of common usage.  Note that the semanage login command deals with the
> > -mapping from Linux usernames (logins) to SELinux user identities,
> > +as well as the file context mapping. Note that the semanage login command deals
> > +with the mapping from Linux usernames (logins) to SELinux user identities,
> >  while the semanage user command deals with the mapping from SELinux
> >  user identities to authorized role sets.  In most cases, only the
> >  former mapping needs to be adjusted by the administrator; the latter
> > --
> > 2.20.1
> >

