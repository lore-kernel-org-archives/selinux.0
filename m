Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4DCC64E7B
	for <selinux@archiver.kernel.org>; Sun, 29 Nov 2020 18:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C21F20825
	for <selinux@archiver.kernel.org>; Sun, 29 Nov 2020 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgK2S1X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 Nov 2020 13:27:23 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:60775 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2S1X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 Nov 2020 13:27:23 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 78681564C36
        for <selinux@vger.kernel.org>; Sun, 29 Nov 2020 19:26:40 +0100 (CET)
Received: by mail-oi1-f178.google.com with SMTP id f11so11834217oij.6
        for <selinux@vger.kernel.org>; Sun, 29 Nov 2020 10:26:40 -0800 (PST)
X-Gm-Message-State: AOAM530b6gVvIZDEPRuI74JNOYB0chHc7mfNeCpxtrZk/HKhs1YnGgLP
        giawr2S537/WO8uVrtLkW7H7lUHXPvdqN65lWxc=
X-Google-Smtp-Source: ABdhPJxt0fXHJw9AiTUQ3wrer04azzqzVa0QuAp1XOf31QxPdULHq8Ifrt+FPITxvgfSngQhDeF7R7CNW84XCWtIPrw=
X-Received: by 2002:aca:4bc3:: with SMTP id y186mr12017198oia.153.1606674399389;
 Sun, 29 Nov 2020 10:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20201127141745.1579498-1-omosnace@redhat.com> <CAFqZXNvK5SBo2dw6_OctuLJqcEv8=Ynd8BajOLCdgTa-PNO1xg@mail.gmail.com>
 <CAFftDdp7_dcebjje6+pX1RNQiaBRbgFZSfjxk55DD8-MXJ=MjQ@mail.gmail.com> <CAFqZXNv2jv6WGiW5T6Xb-31Gp90ZJPpVEJVzJwi-iC3ZfPzV9g@mail.gmail.com>
In-Reply-To: <CAFqZXNv2jv6WGiW5T6Xb-31Gp90ZJPpVEJVzJwi-iC3ZfPzV9g@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 29 Nov 2020 19:26:28 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mwLCL-pZSi+OO_C1TjuXZkaWm+8sOLmRcV62NX6XHwpw@mail.gmail.com>
Message-ID: <CAJfZ7=mwLCL-pZSi+OO_C1TjuXZkaWm+8sOLmRcV62NX6XHwpw@mail.gmail.com>
Subject: Re: [PATCH userspace] travis: run only selinux-testsuite
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Nov 29 19:26:40 2020 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 27, 2020 at 3:56 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Nov 27, 2020 at 3:25 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Fri, Nov 27, 2020 at 8:22 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Fri, Nov 27, 2020 at 3:17 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > Now that the standard testing is run on GitHub Actions, we can remove it
> > > > from .travis.yml, leaving only the selinux-testsuite sanity check, which
> > > > can't be migrated. Hopefully this will save some precious minutesfrom
> > > > the limited "plan" Travis gave us...
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  .travis.yml                    | 161 +--------------------------------
> > > >  scripts/ci/travis-kvm-setup.sh |   1 +
> > > >  2 files changed, 2 insertions(+), 160 deletions(-)
> > >
> >
> > Oh awesome you got them migrated. I am in the middle of this for my
> > other projects and was going to check
> > back on SE Linux, glad you took care of it.
> >
> > > My intent is to apply this patch along with Nicholas's GH actions
> > > patch. In case some issues pop up with GH actions, we can simply
> > > revert it.
> > >
> > > Thoughts?
> >
> > I'm going to assume actions are working, I didn't check that patch.
> > But it all LGTM.
> > Ack from me.
>
> Thanks! I staged both patches in a PR:
> https://github.com/SELinuxProject/selinux/pull/272
>
> It seems that GH actions didn't trigger on the PR. I've seen it in
> another project as well, but that PR is not merged yet, so I don't
> know if it just happens on the first PR or if there is some problem...

Hi,
When I pushed these commits to my repository, it triggered the actions
(https://github.com/fishilico/selinux/actions/runs/390210020), so I
merged the Pull Request, which triggered
https://github.com/SELinuxProject/selinux/actions/runs/390222348 . So
this "just works" :)

Thanks,
Nicolas

