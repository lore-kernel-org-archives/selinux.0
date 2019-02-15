Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF90C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41E221924
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iGVRJOYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfBOPh5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:37:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34373 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfBOPh5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 10:37:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so5309214lje.1
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lb95KmNCj/O7735AjbeRaxtwxqatuKE9J1bAbJhKJQ=;
        b=iGVRJOYEQc6rPltEyxangnYct7UG5zrkujUFXcanexKZHGSGQsqURrpXWLXRlISgmj
         n6TGbBFfJIJ9A5L/FMTOokSFjyhP5fkkswCwl6Jpg9/wEm2ixIAiea8uFeobvqQqKbwf
         VqjLkNBLSyHo/YucZldnu4KANBw6JjbLAuJBislb/GpYrVvT4O/jJQfIkJ3xZWH/z7BV
         uq/ZYE8aBo5Va1H5eZP+ME52i5gn+dKucxp2mvxa3dJVtw0VL6gs0dlEMJPBqHe93hAK
         4sB0VZ17iUD7/q27WnH38Ebe0PHkmxo4hDu1YIbahOng0HTyNqJKqfqa2ypg+87uRpqp
         YI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lb95KmNCj/O7735AjbeRaxtwxqatuKE9J1bAbJhKJQ=;
        b=JhLEOA2kxrBGHqOP/ZLn3wh3pqR72e8hOrvP1s9c17+DkGs2e8dTmefThDyvc7p+6l
         2XO7Xq+dahgmivLElY6xt5bxPIHafdWiM8QPZrc78QCx8rzZVQ08c2H9z51jWspra2nb
         Z9M18yBlhBHcikBY5eYt2ZV1FXVp0bwHAZqREOYtqEbU1bjzWfp6zEI3aSJI7TUkz87i
         QKynl/pIMR0VbPROQfyIuSVWixS3ihcy8BmdpM5jkUIbVmCASJZ7Psg++nItHT6a0FH9
         XhFPrpqGwVfEUMzyZN+dZIt8rZR8FBgIYLGplaunYXNfdwXmkA7YatfI4vdFz6vjUE41
         6Wsg==
X-Gm-Message-State: AHQUAuboFD5J1jBsVpW7SLbDLzP5li8A+lkblsRa4JG8mpeA4GZmrz6w
        F6SWrWWevlY0oBVx/SAAMhauHHrnC/hG9uWBOKfZwiA=
X-Google-Smtp-Source: AHgI3IY6rFFfDgnrKQDETrVaMJrDsBwM1vy2Uzc0W2EcAn1FjrT22GoobUAPmj0LWgpIR07iBOg2RsICh3zPGmP7krA=
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr6077964ljj.95.1550245074601;
 Fri, 15 Feb 2019 07:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20190215145045.31945-1-sds@tycho.nsa.gov> <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
 <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov> <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
 <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
In-Reply-To: <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Feb 2019 10:37:43 -0500
Message-ID: <CAHC9VhTtmF4FhwN9XcUs1Ra8iwAw=RqxCeHSU3uzwJ5-mXxu3w@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 15, 2019 at 10:25 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/15/19 10:05 AM, Stephen Smalley wrote:
> > On 2/15/19 10:03 AM, Stephen Smalley wrote:
> >> On 2/15/19 10:00 AM, Paul Moore wrote:
> >>> On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley <sds@tycho.nsa.gov>
> >>> wrote:
> >>>> Add basic MLS policy support to mdp.  Declares
> >>>> two sensitivities and two categories, defines
> >>>> mls constraints for all permissions requiring
> >>>> dominance (ala MCS), assigns the system-high
> >>>> level to initial SID contexts and the default user
> >>>> level, and assigns system-low level to filesystems.
> >>>>
> >>>> Also reworks the fs_use and genfscon rules to only
> >>>> generate rules for filesystems that are configured
> >>>> in the kernel.  In some cases this depends on a specific
> >>>> config option for security xattrs, in other cases security
> >>>> xattrs are unconditionally supported by a given filesystem
> >>>> if the filesystem is enabled, and in some cases the filesystem
> >>>> is always enabled in the kernel.  Dropped obsolete pseudo
> >>>> filesystems.
> >>>>
> >>>> NB The list of fs_use_* and genfscon rules emitted by mdp
> >>>> is very incomplete compared to refpolicy or Android sepolicy.
> >>>> We should probably expand it.
> >>>>
> >>>> Usage:
> >>>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
> >>>> checkpolicy -M -o policy policy.conf
> >>>>
> >>>> Then install the resulting policy and file_contexts as usual.
> >>>>
> >>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >>>> ---
> >>>> v3 fixes up the file contexts generation code to also use SYSTEMLOW and
> >>>> collapse down to a single fprintf call per line.
> >>>>   scripts/selinux/mdp/mdp.c | 131
> >>>> ++++++++++++++++++++++++++++++--------
> >>>>   1 file changed, 103 insertions(+), 28 deletions(-)
> >>>
> >>> This is great Stephen, thanks for working on this - and rather quickly
> >>> too!  For those who don't follow the GitHub issues, I just opened an
> >>> issue yesterday mentioning it would be nice to add MLS support to the
> >>> mdp tool.
> >>>
> >>> Are you planning to keep playing with this?  I'm asking not because I
> >>> think it needs more work to be worthwhile, but rather I don't want to
> >>> merge something that you want to continue working on.  If you are
> >>> happy with this latest patch I think it is okay to merge this into
> >>> selinux/next, even at this late stage, simply because it is not part
> >>> of a built kernel, but rather a developer's tool.
> >>
> >> No, I think I'm done for now unless you find a problem with it.
> >> Absent some compelling use case for mdp it is hard to justify spending
> >> any more time on it.
> >
> > Note however that the instructions in
> > Documentation/admin-guide/LSM/SELinux.rst just say to run
> > scripts/selinux/install_policy.sh and since that doesn't pass -m to mdp
> > or -M to checkpolicy, no one will use this support unless they do it all
> > by hand.
>
> FWIW, a Fedora system wouldn't come up cleanly with this policy.  Partly
> appears to be due to systemd having embedded security contexts specific
> to Fedora/refpolicy into its own configurations and partly due to MLS
> denials.  I don't even know if it would work before this change though...

Providing a usable policy for Fedora via mdp, while nice, isn't really
the main goal with mdp as far as I'm concerned (see my other
response).  As you pointed out, I'd be surprised if the current,
unpatched mdp policy would work on Fedora.

Regardless, it might be nice to add a warning about that in the
SELinux.rst file, along with changes to the install_policy.sh script
to enable MLS.

-- 
paul moore
www.paul-moore.com
