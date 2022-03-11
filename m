Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27101C433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiCKWri (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiCKWra (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 17:47:30 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A918E10709A
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 14:22:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g20so12566426edw.6
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 14:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BQM5s6KARQo6xsMTrgtyjfqQgxp9yGfc0ghCKKcQtf8=;
        b=rW/V0Cqhy9qbkUdJ08Dw1HwcmmSatPyby1AlVx9WHUmj9YQZXnZI6RRhui0BKniegl
         Bp4L5KkXUZfWD6SlN1Mvrh1Lvk3p0ITMLPhbZQCXgqS7Yq+2PZ6lA8nNYPL0qHRDFzT6
         5FrpxfTqET6rhn/cJiLvzXJ0XafMN+n1STTLYYqei2QcB891AuBOiL0LtdufoxoieDmv
         VhrwqolLTex1i3JOkNgCh/2wmS9XMMwGcMlZYG7X2l49KbEfZ6DjIIfZw62E5a+gVdTv
         OwHdtrKmna54ohmVYQnBKcHjgaGCKQFMWyxt7uCVl4q0dm/OyD+28lS8CyPG2PRdOSWf
         /nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BQM5s6KARQo6xsMTrgtyjfqQgxp9yGfc0ghCKKcQtf8=;
        b=vZLzS0DN/z9hBd0hEku0pOlAUgo+lN7DM0LnPSHanLlGhF8h+0cWNFLd96EUW8r5ds
         7QS4mdBCNiObb5yD7ET1ZrYu3g1Re+uGpDCE1LZTrt1RRK0z0zEXflaSukwU6kGaLE1X
         Hz08ymnIb2caUvhN7aP/vHi4DYxi/mbqE3WAAGmAKO30bR+rvUdNtbzxVsTAgT6Zy1RQ
         OMxwHryYAYIsEYIk/TU85G+xvEF8jK6A3H1ICdcwEXgx+mwL4mE8kONJAWZXFfSlv+qP
         blCY94yb3pAHdUe+yJH2XSRZPDAaQSsI9qVn5jL7Geh6aI4pmkKw1NJDHkYtvp82UbVx
         VLYQ==
X-Gm-Message-State: AOAM531+5wo56F3/7KL2Rcuvps8kGoShkzYU15be1h/Ezi3+/8z9ahJB
        oth6gGryNlNbiI6pY16QgNBHmprgawShKRlnm0J9wysHzg==
X-Google-Smtp-Source: ABdhPJyYYX7Wm53Pi2h5di1/gf7hL0sQSYVXL0VPvZQ90klkGVBoawKXG5YHabI6/+DnOGW87KYt9/tNYbHqYtRdtZw=
X-Received: by 2002:a05:6402:d2:b0:413:2e50:d6fd with SMTP id
 i18-20020a05640200d200b004132e50d6fdmr10938615edu.171.1647036912117; Fri, 11
 Mar 2022 14:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20220228215935.748017-1-mic@digikod.net> <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
 <f6b63133-d555-a77c-0847-de15a9302283@digikod.net> <CAHC9VhQd3rL-13k0u39Krkdjp2_dtPfgEPxr=kawWUM9FjjOsw@mail.gmail.com>
 <8d520529-4d3e-4874-f359-0ead9207cead@canonical.com>
In-Reply-To: <8d520529-4d3e-4874-f359-0ead9207cead@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Mar 2022 17:15:01 -0500
Message-ID: <CAHC9VhRrjqe1AdZYtjpzLJyBF6FTeQ4EcEwsOd2YMimA5_tzEA@mail.gmail.com>
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
To:     John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 9, 2022 at 7:36 PM John Johansen
<john.johansen@canonical.com> wrote:
> On 3/9/22 13:31, Paul Moore wrote:
> > On Tue, Mar 1, 2022 at 5:15 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.ne=
t> wrote:
> >> On 01/03/2022 10:22, Christian Brauner wrote:
> >>> On Mon, Feb 28, 2022 at 10:59:35PM +0100, Micka=C3=ABl Sala=C3=BCn wr=
ote:
> >>>> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>>>
> >>>> While transitionning to ACC_MODE() with commit 5300990c0370 ("Saniti=
ze
> >>>> f_flags helpers") and then fixing it with commit 6d125529c6cb ("Fix
> >>>> ACC_MODE() for real"), we lost an open flags consistency check.  Ope=
ning
> >>>> a file with O_WRONLY | O_RDWR leads to an f_flags containing MAY_REA=
D |
> >>>> MAY_WRITE (thanks to the ACC_MODE() helper) and an empty f_mode.
> >>>> Indeed, the OPEN_FMODE() helper transforms 3 (an incorrect value) to=
 0.
> >>>>
> >>>> Fortunately, vfs_read() and vfs_write() both check for FMODE_READ, o=
r
> >>>> respectively FMODE_WRITE, and return an EBADF error if it is absent.
> >>>> Before commit 5300990c0370 ("Sanitize f_flags helpers"), opening a f=
ile
> >>>> with O_WRONLY | O_RDWR returned an EINVAL error.  Let's restore this=
 safe
> >>>> behavior.
> >>>
> >>> That specific part seems a bit risky at first glance. Given that the
> >>> patch referenced is from 2009 this means we've been allowing O_WRONLY=
 |
> >>> O_RDWR to succeed for almost 13 years now.
> >>
> >> Yeah, it's an old bug, but we should keep in mind that a file descript=
or
> >> created with such flags cannot be used to read nor write. However,
> >> unfortunately, it can be used for things like ioctl, fstat, chdir=E2=
=80=A6 I
> >> don't know if there is any user of this trick.
> >>
> >> Either way, there is an inconsistency between those using ACC_MODE() a=
nd
> >> those using OPEN_FMODE(). If we decide to take a side for the behavior
> >> of one or the other, without denying to create such FD, it could also
> >> break security policies. We have to choose what to potentially break=
=E2=80=A6
> >
> > I'm not really liking the idea that the empty/0 f_mode field leads to
> > SELinux doing an ioctl access check as opposed to the expected
> > read|write check.  Yes, other parts of the code catch the problem, but
> > this is bad from a SELinux perspective.  Looking quickly at the other
> > LSMs, it would appear that other LSMs are affected as well.
> >
> > If we're not going to fix file::f_mode, the LSMs probably need to
> > consider using file::f_flags directly in conjunction with a correct
> > OPEN_FMODE() macro (or better yet a small inline function that isn't
> > as ugly).
> >
> yeah, I have to agree

The silence on this has been deafening :/  No thoughts on fixing, or
not fixing OPEN_FMODE(), Al?

At this point I have to assume OPEN_FMODE() isn't changing so I'm
going to go ahead with moving SELinux over to file::f_flags.  Once
I've got something working I'll CC the LSM list on the patches in case
the other LSMs want to do something similar.  Full disclosure, that
might not happen until early-to-mid next week due to the weekend, new
kernel expected on Sunday, etc.

--=20
paul-moore.com
