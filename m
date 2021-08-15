Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21934C4338F
	for <selinux@archiver.kernel.org>; Sun, 15 Aug 2021 20:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A77660EE2
	for <selinux@archiver.kernel.org>; Sun, 15 Aug 2021 20:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhHOUWl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 15 Aug 2021 16:22:41 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59833 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHOUWk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 15 Aug 2021 16:22:40 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6B8B956479A
        for <selinux@vger.kernel.org>; Sun, 15 Aug 2021 22:22:08 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so24232890pjb.0
        for <selinux@vger.kernel.org>; Sun, 15 Aug 2021 13:22:08 -0700 (PDT)
X-Gm-Message-State: AOAM533zyfTi0q1DKSdQkVVBZX3bXrurIbB6J/xea+8R1S/et/l776cZ
        uFho+tjfBwBJ2DAlpU2fkqOzxJaTxvyn6V2wTsY=
X-Google-Smtp-Source: ABdhPJyzBCeXKkxCGCae8yFJ5eslqTM7QkNhBbv5tsmjEJJcfMEIumKQn5Jwr0WDkiRgiOzYCR2bcbnqwTfswdoFnLM=
X-Received: by 2002:a17:903:310e:b0:12d:c3e7:a8d9 with SMTP id
 w14-20020a170903310e00b0012dc3e7a8d9mr802724plc.35.1629058926913; Sun, 15 Aug
 2021 13:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <87fsvmu2xa.fsf@redhat.com> <CAP+JOzRb0vE94arDdF6SxB3Mn-82+ztRi0OjyGRzqjAd3=ck_A@mail.gmail.com>
 <87tujy4r1g.fsf@defensec.nl>
In-Reply-To: <87tujy4r1g.fsf@defensec.nl>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 15 Aug 2021 22:21:56 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=naeBBmUiS3YgcW+AttSzx-tDt56ShMJq56NKPqC_yKhA@mail.gmail.com>
Message-ID: <CAJfZ7=naeBBmUiS3YgcW+AttSzx-tDt56ShMJq56NKPqC_yKhA@mail.gmail.com>
Subject: Re: lets think about 3.3 release
To:     Dominick Grift <dominick.grift@defensec.nl>,
        Petr Lautrbach <plautrba@redhat.com>,
        James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Aug 15 22:22:08 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 9, 2021 at 4:44 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Fri, Aug 6, 2021 at 2:29 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>
> >> Hello,
> >>
> >> I's about 184 commits and 5 months since the last release so I think
> >> it's time to slowly stop the development and start with 3.3 release
> >> candidates.
> >>
> >> According to patchwork, there are few patches in queue which need to be
> >> reviewed, or which were reviewed and some change for requested:
> >>
> >> * https://patchwork.kernel.org/patch/11436955/ New [RFC]
> >> libsepol,secilc,policycoreutils: add unprivileged sandboxing
> >> capability
> >> * https://patchwork.kernel.org/patch/11668455/ New selinux: make use of variables when defining libdir and includedir
> >>
> >> old, without any activity for a long time
> >>
> >> * https://patchwork.kernel.org/patch/12291637/ New [v2] checkpolicy: fix the leak memory when uses xperms
> >>
> >> changes requested
> >>
> >> * https://patchwork.kernel.org/patch/12372487/ New [v2] libselinux: add lock callbacks
> >> * https://patchwork.kernel.org/patch/12377593/ New libselinux/utils: drop requirement to combine compiling and linking
> >>
> >> no response yet
> >>
> >> * https://patchwork.kernel.org/patch/12420657/ New [userspace]  libsepol/cil: remove obsolete comment
> >>
> >> acked, ready to be merged
> >>
> >> * https://patchwork.kernel.org/patch/12422971/ New mcstrans: Improve mlstrans-test output
> >>
> >> no response yet
> >>
> >>
> >> if I missed something please tell me.
> >>
> >>
> >> There's one issue opened on the mailing list
> >>
> >> https://lore.kernel.org/selinux/874kc57220.fsf@defensec.nl/T/#t -
> >> libsepol regressions
> >>
> >
> > I am working to address this and hope to have something out in the
> > next couple of days. I am also working on fixing some issues with the
> > line mark stuff in CIL. It would be nice to have both of these in the
> > next release, but I don't think they need to hold things up either.
> > Jim
>
> It's too soon for me to start worrying about this but:
>
> I don't care if my dssp5 policy breaks due to this regression (that is
> what it is) because other than me no one probably uses it, but I also
> maintain a policy for OpenWrt which relies on this functionality (or
> allowing duplicate blocks, macros) and I would not want to have this
> break there come 3.3.
>
> >
> >> If you agree and there's no obejction I can start with preparation and
> >> plan to release 3.3-rc1 on Wed Aug 18 2021

Hello,
For information I am currently on holidays with quite limited access
to my mails and will be fully "back with my test machines" on
2021-08-30. In the meantime I can participate in some reviews but I am
not willing to send patches myself. Nevertheless I will try to review
the "libsepol/cil: move the fuzz target and build script to the
selinux repository" patch properly before Wednesday.

For the release, I am currently aware of two possibly-minor issues and
I do not know whether they are tracked somewhere:

1. secil2tree can output wrongly indented blocks. For example
"secil2tree -A resolve secilc/test/policy.cil" currently outputs:

(block test_ba
    (blockinherit ba)
        (roletype test_ba.r test_ba.t)
        (blockabstract z.ba)
    )
    (role test_ba.r)
    (type test_ba.t)
)

The parenthesizing "(blockinherit ba) ... )" is wrong. The
"(blockinherit ba)" could be replaced with a comment indicating that a
blockinherit was expanded.

2. semanage's gettext setup is currently incompatible with Python
3.10. More precisely
https://docs.python.org/3.8/library/gettext.html#gettext.install
indicates: "Deprecated since version 3.8, will be removed in version
3.10: The codeset parameter.". When I stumbled upon this issue, it
occured to me that the whole try-except statement in
https://github.com/SELinuxProject/selinux/blob/libsemanage-3.2/python/semanage/semanage#L34-L49
could be replaced with "import gettext" (which is a built-in module in
Python 3) and "gettext.install(PROGNAME,
localedir="/usr/share/locale")". Nevertheless I did not find time to
properly test this change, which is why I have not sent patches for it
sooner.

In my opinion, the first issue is not a release-blocker because
"secil2tree -A resolve" is not expected to output a CIL policy which
can be compiled. The second one could be, if we want to support Python
3.10 (which will be released in October) with the 3.3 release.

Thanks,
Nicolas

