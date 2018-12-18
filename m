Return-Path: <SRS0=zZcK=O3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50A2C43387
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 15:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C053F21852
	for <selinux@archiver.kernel.org>; Tue, 18 Dec 2018 15:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLRPi7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:38:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40351 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRPi7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Dec 2018 10:38:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so2270665oie.7
        for <selinux@vger.kernel.org>; Tue, 18 Dec 2018 07:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5TtIAob1CN0usF4XnB3yZ1kiF4OdG1lTcjK9GNlp2g=;
        b=FH5+/evfV8Uc2K+rHcpwLc+tmf3/WAkjbojjG8d3cGcTRV20zUXGO0+M1zgeVKTHdr
         vPfXP/OnQoWxt6/2IWcaNHsO7M1e7bL9AJgDs6iLzpl+Sam10P3rYSRpSIDKaR03yyg4
         DV1dLxheeHAW65yRIK6ZWOBiS4L3+MqgFKt5x1F7AGV7u6Ko1tYlUlLOvi6tIA+Ka+Bl
         r7pdhzrsq2IqZhcD7ocenU/6sP0T9j/gyTkI9XdzRMO/vq2BB3EZ09ap34foBMS6KkTZ
         w+nUedSCp1r2n5vizLL2dvhWTz65JFNP+NqQa+bgF2EANSErnKDFR8A8HuBPMZXxO34n
         9JaA==
X-Gm-Message-State: AA+aEWaJpy5wqa5oRqHSwsygUGsFXwwV2odSXIXrIZeEtWp7ef3gDXl3
        UtvibTUqKl3etzhczQ9DRlMrBuWg/GYISowpabsmv+m9
X-Google-Smtp-Source: AFSGD/VYnw/4aStvd5Y4JQE82SADwcWnMtCuplifaozwpeaq8m4IE+107MzGDSLaK9zEyFNozLkMNt0OywUDsg016nQ=
X-Received: by 2002:aca:c003:: with SMTP id q3mr7475001oif.119.1545147537966;
 Tue, 18 Dec 2018 07:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20181213141739.8534-1-omosnace@redhat.com> <20181213141739.8534-3-omosnace@redhat.com>
 <282f3f4c-6d0a-985e-76d7-6472efabf09b@tycho.nsa.gov>
In-Reply-To: <282f3f4c-6d0a-985e-76d7-6472efabf09b@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 18 Dec 2018 16:38:46 +0100
Message-ID: <CAFqZXNtg9O3RZ37F1AhOR6qCSswFoRcddJxrLw=+Vyqw1XLe5Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] selinux: never allow relabeling on context mounts
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 13, 2018 at 5:16 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/13/18 9:17 AM, Ondrej Mosnacek wrote:
> > In the SECURITY_FS_USE_MNTPOINT case we never want to allow relabeling
> > files/directories, so we should never set the SBLABEL_MNT flag in this
> > case. The 'special handling' in selinux_is_sblabel_mnt() is only
> > intended for SECURITY_FS_USE_GENFS.
> >
> > While there, make the logic in selinux_is_sblabel_mnt() more explicit
> > and add a BUILD_BUG_ON() to make sure that introducing a new
> > SECURITY_FS_USE_* forces a review of the logic.
> >
> > Note that checkpatch.pl produces some false positives here, likely
> > having problems recognizing the monstrous return statement...
> >
> > Fixes: d5f3a5f6e7e7 ("selinux: add security in-core xattr support for pstore and debugfs")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   security/selinux/hooks.c | 41 ++++++++++++++++++++++++++++------------
> >   1 file changed, 29 insertions(+), 12 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7ce012d9ec51..d6d29ec54eab 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -501,19 +501,36 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
> >   {
> >       struct superblock_security_struct *sbsec = sb->s_security;
> >
> > -     return sbsec->behavior == SECURITY_FS_USE_XATTR ||
> > -             sbsec->behavior == SECURITY_FS_USE_TRANS ||
> > -             sbsec->behavior == SECURITY_FS_USE_TASK ||
> > -             sbsec->behavior == SECURITY_FS_USE_NATIVE ||
> > +     /*
> > +      * IMPORTANT: Double-check logic in this function when adding a new
> > +      * SECURITY_FS_USE_* definition!
> > +      */
> > +     BUILD_BUG_ON(SECURITY_FS_USE_MAX != 7);
> > +
> > +     switch (sbsec->behavior) {
> > +     case SECURITY_FS_USE_XATTR:
> > +     case SECURITY_FS_USE_TRANS:
> > +     case SECURITY_FS_USE_TASK:
> > +     case SECURITY_FS_USE_NATIVE:
> > +             return 1;
> > +
> > +     case SECURITY_FS_USE_GENFS:
> >               /* Special handling. Genfs but also in-core setxattr handler */
> > -             !strcmp(sb->s_type->name, "sysfs") ||
> > -             !strcmp(sb->s_type->name, "pstore") ||
> > -             !strcmp(sb->s_type->name, "debugfs") ||
> > -             !strcmp(sb->s_type->name, "tracefs") ||
> > -             !strcmp(sb->s_type->name, "rootfs") ||
> > -             (selinux_policycap_cgroupseclabel() &&
> > -              (!strcmp(sb->s_type->name, "cgroup") ||
> > -               !strcmp(sb->s_type->name, "cgroup2")));
> > +             return  !strcmp(sb->s_type->name, "sysfs") ||
> > +                     !strcmp(sb->s_type->name, "pstore") ||
> > +                     !strcmp(sb->s_type->name, "debugfs") ||
> > +                     !strcmp(sb->s_type->name, "tracefs") ||
> > +                     !strcmp(sb->s_type->name, "rootfs") ||
> > +                     (selinux_policycap_cgroupseclabel() &&
> > +                      (!strcmp(sb->s_type->name, "cgroup") ||
> > +                       !strcmp(sb->s_type->name, "cgroup2")));
> > +
> > +     /* Never allow relabeling on context mounts */
> > +     case SECURITY_FS_USE_MNTPOINT:
> > +     case SECURITY_FS_USE_NONE:
> > +     default:
> > +             return 0;
> > +     }
> >   }
>
> This looks sane to me. Note that
> https://github.com/SELinuxProject/selinux-kernel/issues/2 calls for
> replacing the use of hardcoded lists of filesystem types above with
> something more general.  Maybe you could at least abstract that part
> into its own function.

Agreed, that's a good idea. It should also allow checkpatch.pl to
correctly parse the control flow and not throw an error.

>
> >
> >   static int sb_finish_set_opts(struct super_block *sb)
> >
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
