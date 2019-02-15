Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C19C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C718E2177B
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="d3bbizNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfBOPPr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:15:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46969 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbfBOPPr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 10:15:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id f5so7419442lfc.13
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 07:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLeRJa5skZgTee8Q0nEAR8WgawWIrpxT1YZP5AHBaTY=;
        b=d3bbizNx3tm/obDn2lqV5y/Tbva5XY/G52uSoHWjFnWrDWJ46otKLYs+JrlAs33nu0
         qL0EzE0UfI0z+qv24xnBz8gT5zmZRT2uH7Bxm0xpkhEp0ACYsaPNPvnh7el29cSFfehc
         eiXwlPwuRSC1lNIgT1fMDk/aidftF/q8Bz4yde877ibo6hdIgpPrmQhxmYu4ppJGFW/x
         s0Cis9+ls07ksBA4iXXxS5eUJa64kSFKWKiWIRTaTlIMl1LOmn4PjNf5JJiH+JJT8GBH
         uibrZgUo9Ogsqj31XQj7pyYxuV0p/yw/rSPxK/wA9Dfo0wNyi6DUb7VJsWfb77F1/qzE
         3X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLeRJa5skZgTee8Q0nEAR8WgawWIrpxT1YZP5AHBaTY=;
        b=E0G8YCkFGB/A5pKPGRrRB2d8knzkmmMDp/BqJi6kIs62XwMC3jzlnA/ASChka4YMj5
         44UePGTuJs0aA+u92l3LdsaC9B+1P2KPuHEQ+SKpmsd/rgQmayXaGzh33EYwYJYD2BSd
         3ZNM2EMyBsfpF8II2EAVbJpFaJZxlo7ES4ylqf/qkYtu1Rr9mB2q+EdON91hsCAbX0p2
         T+h+Y8gR+9W3FO3L+bfcY9zeLG2ARy2A8ZaLEAfbmpxgjbuB7NaN29EPPJWCNFrOiJq7
         FxYTotYyLXQ7UROUxxHSLnwmopOAUYJjmfHtc6uVnfNt6Yw1k699ailqxEhXF7XjsGtG
         sH/w==
X-Gm-Message-State: AHQUAuZLXJN9TuQR75/A4UsS8F3n+zogoDH0KmB4HGB0e7E+hELaWMWg
        3Kapo6Nr5Ri+1iF51sa6urjalysHaiTLej6hO+5X24A=
X-Google-Smtp-Source: AHgI3IYcv3vBPieL4r2kUtANMa44Wx/CFaH0qPniZAcEoLSSslRKqZ0D+7e2UQYVadyUUTMxQdUGfdRYR1fQ3wU+FIQ=
X-Received: by 2002:ac2:5205:: with SMTP id a5mr5974332lfl.135.1550243744309;
 Fri, 15 Feb 2019 07:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20190215145045.31945-1-sds@tycho.nsa.gov> <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
 <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov>
In-Reply-To: <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Feb 2019 10:15:33 -0500
Message-ID: <CAHC9VhQ2ZL1nNOVunAEzR+HPJrDpabcuDnJdeVdyKZeyCnPnww@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 15, 2019 at 10:03 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/15/19 10:00 AM, Paul Moore wrote:
> > On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> Add basic MLS policy support to mdp.  Declares
> >> two sensitivities and two categories, defines
> >> mls constraints for all permissions requiring
> >> dominance (ala MCS), assigns the system-high
> >> level to initial SID contexts and the default user
> >> level, and assigns system-low level to filesystems.
> >>
> >> Also reworks the fs_use and genfscon rules to only
> >> generate rules for filesystems that are configured
> >> in the kernel.  In some cases this depends on a specific
> >> config option for security xattrs, in other cases security
> >> xattrs are unconditionally supported by a given filesystem
> >> if the filesystem is enabled, and in some cases the filesystem
> >> is always enabled in the kernel.  Dropped obsolete pseudo
> >> filesystems.
> >>
> >> NB The list of fs_use_* and genfscon rules emitted by mdp
> >> is very incomplete compared to refpolicy or Android sepolicy.
> >> We should probably expand it.
> >>
> >> Usage:
> >> scripts/selinux/mdp/mdp -m policy.conf file_contexts
> >> checkpolicy -M -o policy policy.conf
> >>
> >> Then install the resulting policy and file_contexts as usual.
> >>
> >> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> ---
> >> v3 fixes up the file contexts generation code to also use SYSTEMLOW and
> >> collapse down to a single fprintf call per line.
> >>   scripts/selinux/mdp/mdp.c | 131 ++++++++++++++++++++++++++++++--------
> >>   1 file changed, 103 insertions(+), 28 deletions(-)
> >
> > This is great Stephen, thanks for working on this - and rather quickly
> > too!  For those who don't follow the GitHub issues, I just opened an
> > issue yesterday mentioning it would be nice to add MLS support to the
> > mdp tool.
> >
> > Are you planning to keep playing with this?  I'm asking not because I
> > think it needs more work to be worthwhile, but rather I don't want to
> > merge something that you want to continue working on.  If you are
> > happy with this latest patch I think it is okay to merge this into
> > selinux/next, even at this late stage, simply because it is not part
> > of a built kernel, but rather a developer's tool.
>
> No, I think I'm done for now unless you find a problem with it.  Absent
> some compelling use case for mdp it is hard to justify spending any more
> time on it.

For the record, I think having something like mdp is important as a
simple, quick to parse (by human eyes) demonstration of a "complete"
SELinux policy.  I recognize we could have a lot of good arguments
about what constitutes a "complete" SELinux policy, but for mdp let's
try to keep it as simple as possible for now.

-- 
paul moore
www.paul-moore.com
