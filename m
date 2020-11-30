Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC335C64E7B
	for <selinux@archiver.kernel.org>; Mon, 30 Nov 2020 12:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384472074A
	for <selinux@archiver.kernel.org>; Mon, 30 Nov 2020 12:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8Z1rnRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgK3M0R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Nov 2020 07:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgK3M0R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Nov 2020 07:26:17 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A51C0613CF
        for <selinux@vger.kernel.org>; Mon, 30 Nov 2020 04:25:37 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so11513868ioo.7
        for <selinux@vger.kernel.org>; Mon, 30 Nov 2020 04:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYhm9guBN2TU4Xeb2iWFbRcGPTgh9SdxAU/L06o4W6A=;
        b=F8Z1rnRzvj8rrRRVc7cr4Sj6cW7yOXZ+u+AqrqNrMl4yjcI1bghbnJVTMEOGIfn19W
         NBZZyHjiyKRWQKwCStPMsK0MzCW79iEgvAUO12L3UU1jUi+9wt3z4BgTdxuUqq0ecHbr
         sAyyXUSQlzSHtr0VRD3rE2UPrnJjslCQNvyIHeB2w+7d9m7uRon9bZmhaMZF9hHe8pzK
         otgcY0buKqjWxnQCkNHIAX6glUxyDDXxYTinN/X+ek8j6yd1v2okPVbnJJSYc8Rcq73G
         SotAPf5LTuzihYOynJWb74pYvADkJOtcc0GrTalQyAdnRSSKgjMu6WbPdrluMXCKjSB/
         6AeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYhm9guBN2TU4Xeb2iWFbRcGPTgh9SdxAU/L06o4W6A=;
        b=forAQ8tUb/3DpRG2htaYmef/ZyqjeKqzHcUbKrjoTf+9wC+r1SY/8FRLM9+tDds7Df
         y2B9AZDDvIMaXVTouCVc8r4AUJBOkFp2JDYqh0JFtyDDRlh55KeYP/SjrKy9ox2iBkAs
         rFW+gxFrChUWX2cI6q8Quh34zG57klHJEPEnKNdyotpOgIZNFpNPxzcuiQxZNvkiVvFi
         94DsdwfVCmQZRS+Euar0NjZmFUwrYAopA5M4IRsNpF603+MPvkPbTHQUAlNqTsE/wyMj
         VKBkrTFIg9NcepvI3h3FwfF1DIYzWgKsihyvLntr2Hmwwd9yE8UsCuSbrTlqkoK+HkRE
         xO7A==
X-Gm-Message-State: AOAM533R2nTwcNIvd69Rt70BkTFrHJUOVacLQ+5hiOBqDM5N8d+9D9tb
        wFOiUG39qWdRWEmcGyFPTmQZH3FyMYKTc6JBN53KnXgtF5E=
X-Google-Smtp-Source: ABdhPJz09mKk6qxm8pcEuYQeZTSssHkCtk9wchn7sU+bIzRH5UHNwRxVhTkWymonMcUJP7TEIVRDjQl8XfmSbn+yj/w=
X-Received: by 2002:a6b:5018:: with SMTP id e24mr3239182iob.184.1606739136544;
 Mon, 30 Nov 2020 04:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20201127141745.1579498-1-omosnace@redhat.com> <CAFqZXNvK5SBo2dw6_OctuLJqcEv8=Ynd8BajOLCdgTa-PNO1xg@mail.gmail.com>
 <CAFftDdp7_dcebjje6+pX1RNQiaBRbgFZSfjxk55DD8-MXJ=MjQ@mail.gmail.com>
 <CAFqZXNv2jv6WGiW5T6Xb-31Gp90ZJPpVEJVzJwi-iC3ZfPzV9g@mail.gmail.com> <CAJfZ7=mwLCL-pZSi+OO_C1TjuXZkaWm+8sOLmRcV62NX6XHwpw@mail.gmail.com>
In-Reply-To: <CAJfZ7=mwLCL-pZSi+OO_C1TjuXZkaWm+8sOLmRcV62NX6XHwpw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 30 Nov 2020 06:25:25 -0600
Message-ID: <CAFftDdrghq89vF2dXYDQsJpDrcO51165tGLGn0OiKyujpzZwCw@mail.gmail.com>
Subject: Re: [PATCH userspace] travis: run only selinux-testsuite
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Nov 29, 2020 at 12:26 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Nov 27, 2020 at 3:56 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, Nov 27, 2020 at 3:25 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > > On Fri, Nov 27, 2020 at 8:22 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > On Fri, Nov 27, 2020 at 3:17 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > Now that the standard testing is run on GitHub Actions, we can remove it
> > > > > from .travis.yml, leaving only the selinux-testsuite sanity check, which
> > > > > can't be migrated. Hopefully this will save some precious minutesfrom
> > > > > the limited "plan" Travis gave us...
> > > > >
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > ---
> > > > >  .travis.yml                    | 161 +--------------------------------
> > > > >  scripts/ci/travis-kvm-setup.sh |   1 +
> > > > >  2 files changed, 2 insertions(+), 160 deletions(-)
> > > >
> > >
> > > Oh awesome you got them migrated. I am in the middle of this for my
> > > other projects and was going to check
> > > back on SE Linux, glad you took care of it.
> > >
> > > > My intent is to apply this patch along with Nicholas's GH actions
> > > > patch. In case some issues pop up with GH actions, we can simply
> > > > revert it.
> > > >
> > > > Thoughts?
> > >
> > > I'm going to assume actions are working, I didn't check that patch.
> > > But it all LGTM.
> > > Ack from me.
> >
> > Thanks! I staged both patches in a PR:
> > https://github.com/SELinuxProject/selinux/pull/272
> >
> > It seems that GH actions didn't trigger on the PR. I've seen it in
> > another project as well, but that PR is not merged yet, so I don't
> > know if it just happens on the first PR or if there is some problem...
>
> Hi,
> When I pushed these commits to my repository, it triggered the actions
> (https://github.com/fishilico/selinux/actions/runs/390210020), so I
> merged the Pull Request, which triggered
> https://github.com/SELinuxProject/selinux/actions/runs/390222348 . So
> this "just works" :)
>
> Thanks,
> Nicolas

Awesome, glad y'all sorted it out, I was going to look today. All my
other projects
the triggering for github actions builds just worked. Thanks!
