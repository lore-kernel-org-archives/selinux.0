Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51205C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 19:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1916E2192B
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lAj71G10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfBOTLz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:11:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39200 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBOTLz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 14:11:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id g80so9277266ljg.6
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVegKOJmiQ+G5siObjguE7QpT6XQoyBEV6hfM7pQ7e0=;
        b=lAj71G10L2hZGwIpODHhxCn0qGgAq6CsJAVUZiwT6tUFJlOBZZcYyGlXXHZjk6dmww
         wBo6aIibC/cNX8CiCtUS1ygVERAE+lFSxy9usZ4R+IgRXnp7Vw6eiIlNudnQrGbwKQHn
         diqOvHRJ18mh4yTjeMtMrgFPLf21xS6RcOiTsDTMkEnsdtKZ+Rih4R93VNstmvnqJ+7K
         JYOfvPdEcYO5xMnFGlgd2xtt0JFJtgX3KT17IGsc2M5RBVTl3OIhDLnl+bBdsAx3jPfJ
         +NakEbK//j2rwJJBA6zh9oPxbukbhpUAg8Cg4Dcqhu7BdrlpIjAr4uTvqzOYEX53zZek
         4F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVegKOJmiQ+G5siObjguE7QpT6XQoyBEV6hfM7pQ7e0=;
        b=a0l++OayzWV9G6Rx1LK+HMEnXcTIG/Vtw5N7RuEO3QX1SHOhCotuD3LkZaich1kGy3
         tywTa6jdK9TqKpQMYM4r+tDsBpyqwEXGUxusTdyIDy8bsVZPXi/lnhaKdJ1JGmY7eCEw
         phYc/W1f2BDSZE53LOwIZvhrwdO2gWBD0e6DxKhReoTpwDTyCUnTlh2f5rO4iE+ixblf
         bC0SgleUWh17b7NnRfbjXA0rkjJquDf8dPl5HdPYu2xFsWXCOHKtHQE2xMvwt1LRaLQS
         5E+xw4S0MFqFEYYQAuNiKBP4CE5/JcGN/4+hyNhgUPOG9eLn1IJr5SrLbTs/cUGXsroF
         2OnQ==
X-Gm-Message-State: AHQUAubGyANiUdvkxfaA3/nYrFTdYZRhDDZUUOHO0LXn1ZoxnKCsJZtX
        MlpAak7VBX5EUWmAzRnr+Bni3qQ+sbwMR1Vz4DnIoyE=
X-Google-Smtp-Source: AHgI3IZDHAGImcMXcfVh1NRmUe2fmdcvpFJxrMkBQ4rq2owpaXqsd5z9/yiuNs+9OfLu5cdipmmUeMa4rt/bDIwyJFo=
X-Received: by 2002:a2e:413:: with SMTP id 19mr3096319lje.196.1550257912084;
 Fri, 15 Feb 2019 11:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20190215145045.31945-1-sds@tycho.nsa.gov> <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
 <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov> <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
 <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov> <0e556b37-90fa-7f3a-f60f-fa77acce6f5b@tycho.nsa.gov>
 <87zhqxkn8a.fsf@gmail.com> <87r2c9klrh.fsf@gmail.com>
In-Reply-To: <87r2c9klrh.fsf@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Feb 2019 14:11:40 -0500
Message-ID: <CAHC9VhR9b8udyh7WWAw0-G64DuaLBN59QXByteBdVbtZKnUj-A@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
To:     Dominick Grift <dac.override@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 15, 2019 at 12:24 PM Dominick Grift <dac.override@gmail.com> wrote:
> Dominick Grift <dac.override@gmail.com> writes:
> > Stephen Smalley <sds@tycho.nsa.gov> writes:
> >
> >> On 2/15/19 10:25 AM, Stephen Smalley wrote:
> >>> On 2/15/19 10:05 AM, Stephen Smalley wrote:
> >>>> On 2/15/19 10:03 AM, Stephen Smalley wrote:
> >>>>> On 2/15/19 10:00 AM, Paul Moore wrote:
> >>>>>> On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley
> >>>>>> <sds@tycho.nsa.gov> wrote:
> >>>>>>> Add basic MLS policy support to mdp.  Declares
> >>>>>>> two sensitivities and two categories, defines
> >>>>>>> mls constraints for all permissions requiring
> >>>>>>> dominance (ala MCS), assigns the system-high
> >>>>>>> level to initial SID contexts and the default user
> >>>>>>> level, and assigns system-low level to filesystems.
> >>>>>>>
> >>>>>>> Also reworks the fs_use and genfscon rules to only
> >>>>>>> generate rules for filesystems that are configured
> >>>>>>> in the kernel.  In some cases this depends on a specific
> >>>>>>> config option for security xattrs, in other cases security
> >>>>>>> xattrs are unconditionally supported by a given filesystem
> >>>>>>> if the filesystem is enabled, and in some cases the filesystem
> >>>>>>> is always enabled in the kernel.  Dropped obsolete pseudo
> >>>>>>> filesystems.
> >>>>>>>
> >>>>>>> NB The list of fs_use_* and genfscon rules emitted by mdp
> >>>>>>> is very incomplete compared to refpolicy or Android sepolicy.
> >>>>>>> We should probably expand it.
> >>>>>>>
> >>>>>>> Usage:
> >>>>>>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
> >>>>>>> checkpolicy -M -o policy policy.conf
> >>>>>>>
> >>>>>>> Then install the resulting policy and file_contexts as usual.
> >>>>>>>
> >>>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >>>>>>> ---
> >>>>>>> v3 fixes up the file contexts generation code to also use
> >>>>>>> SYSTEMLOW and
> >>>>>>> collapse down to a single fprintf call per line.
> >>>>>>>   scripts/selinux/mdp/mdp.c | 131
> >>>>>>> ++++++++++++++++++++++++++++++--------
> >>>>>>>   1 file changed, 103 insertions(+), 28 deletions(-)
> >>>>>>
> >>>>>> This is great Stephen, thanks for working on this - and rather quickly
> >>>>>> too!  For those who don't follow the GitHub issues, I just opened an
> >>>>>> issue yesterday mentioning it would be nice to add MLS support to the
> >>>>>> mdp tool.
> >>>>>>
> >>>>>> Are you planning to keep playing with this?  I'm asking not because I
> >>>>>> think it needs more work to be worthwhile, but rather I don't want to
> >>>>>> merge something that you want to continue working on.  If you are
> >>>>>> happy with this latest patch I think it is okay to merge this into
> >>>>>> selinux/next, even at this late stage, simply because it is not part
> >>>>>> of a built kernel, but rather a developer's tool.
> >>>>>
> >>>>> No, I think I'm done for now unless you find a problem with
> >>>>> it. Absent some compelling use case for mdp it is hard to justify
> >>>>> spending any more time on it.
> >>>>
> >>>> Note however that the instructions in
> >>>> Documentation/admin-guide/LSM/SELinux.rst just say to run
> >>>> scripts/selinux/install_policy.sh and since that doesn't pass -m to
> >>>> mdp or -M to checkpolicy, no one will use this support unless they
> >>>> do it all by hand.
> >>>
> >>> FWIW, a Fedora system wouldn't come up cleanly with this policy.
> >>> Partly appears to be due to systemd having embedded security
> >>> contexts specific to Fedora/refpolicy into its own configurations
> >>> and partly due to MLS denials.  I don't even know if it would work
> >>> before this change though...
> >>
> >> Couldn't seem to get a mdp-generated policy to boot on Fedora even in
> >> permissive, before or after this change.  I assume it has to do with
> >> leaking of contexts outside of the policy and/or missing config files
> >> from the dummy policy (e.g. /etc/selinux/targeted/contexts/ has
> >> systemd_contexts and other userspace config files that don't exist in
> >> the mdp policy).  More evidence of the irrelevance of mdp...
> >
> > Oh, right you need a "dbus_contexts" file probably. DBUS refuses to
> > start without it, and these day's without dbus no system
>
> My dssp2-minimal [1] policy is my alternative to mdp.
>
> https://github.com/DefenSec/dssp2-minimal
>
> It is not quite as simple as mpd but it think it is decent balance
> between having something useful and still easy to read.

While dssp2-minimal is much smaller than reference policy, it's still
an order of magnitude larger than the mdp generated policy.  I'm not
sure if this is something you care about, but if you wanted to work on
getting mdp to the point where it would allow a Fedora system (or any
modern SELinux based system for that matter) to boot, that could be
useful, even if I'm not convinced it needs to be a priority at the
moment.

Besides, haven't you always wanted to get a patch accepted into the
kernel Dominick? ;)

-- 
paul moore
www.paul-moore.com
