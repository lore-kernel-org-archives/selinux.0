Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB6AC43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAE52177B
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ky5bTvYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfBOPSY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:18:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37363 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfBOPSX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 10:18:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id r10-v6so8682685ljj.4
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 07:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+aWnjnQepUTezl1dO9PtHMN+bYbOgrHMOH6sbUwP/E=;
        b=ky5bTvYJttokOAtAh9Gfwemzwy9sFbDn2itN+fxUnlK08xq1AOWebD16yaK/3qessW
         42heThq75C9tkdUssdxraauUcfO+sodaOTmyBSm7KAHmx6mMAQhyTyI+BakVsCPgdseN
         E4POD/9TvvN8HLN1Ow4v6sSLjtxTJLm07FPqWezgJ8lu4e98VP+hT03kpxT6/r90WPNM
         S6d9RvLxzBuQoBKRS+JZxSAIkImF7cdqHDN7F98i3T4wYhA4BRfuKzm+R3ymZeo6KDHj
         uzoC9cwpi1jUN1G4RCZJNItsyE/EXmOMM3DsyfoxGArdcClzRHnOUhOFjC37mOZmnDDP
         BlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+aWnjnQepUTezl1dO9PtHMN+bYbOgrHMOH6sbUwP/E=;
        b=f5yW1cpTUSCzWSMkSzjaD2WTF/FO7fIPEsaNsoas62gUyGRf9+oryCoMlEwTCmU/BD
         CbU5rqI5Qod8Yyt0hYqxI/9AGxn4PGZG21XEzfabkbR96iHe0rKQy5WHqiUHQ2MxsOj7
         G18lXPCnEvdilaSRv1iww+6yqVFy0nC45RqJfs+sG4NpqLzqnHtF07RqNUs+j9nDDHoh
         QmF2c2xoRXdyJRoKKjyn4UW2TdGoUw4shNb68LkoyyXRwSu/fkCNtD3lti7vbFUV2SRj
         Hcus8eQrLDLMoDUz1/BqXVhHb5zNAuLsSGzr4FAVxP6HTqhhYWwk33zQDFuaxnnG9pj6
         dPfA==
X-Gm-Message-State: AHQUAua8nZ4PfhggZiBWh8ziu4s3o2XdAdoXav9xcg4KVyqn6GNO4vpK
        h+tTn/4XtGpHTrMPpvU0tuNauLARxkEC5G+DEg5kdHo=
X-Google-Smtp-Source: AHgI3Ia8+RCR95ADfWLbje7sMFx+/9CIlKj9FL5l5+m8CWWxz+QBdLfJ0UM5yOC/tnM1jsn6hEV/V1mVx+1G6fkg9Os=
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr6026700ljj.95.1550243901254;
 Fri, 15 Feb 2019 07:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20190215145045.31945-1-sds@tycho.nsa.gov> <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
 <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov> <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
In-Reply-To: <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Feb 2019 10:18:09 -0500
Message-ID: <CAHC9VhTUG3byVrfUTh5tEwEatZn+mmk0crZCSiZAkmL68UW+=Q@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 15, 2019 at 10:05 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/15/19 10:03 AM, Stephen Smalley wrote:
> > On 2/15/19 10:00 AM, Paul Moore wrote:
> >> On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley <sds@tycho.nsa.gov>
> >> wrote:
> >>> Add basic MLS policy support to mdp.  Declares
> >>> two sensitivities and two categories, defines
> >>> mls constraints for all permissions requiring
> >>> dominance (ala MCS), assigns the system-high
> >>> level to initial SID contexts and the default user
> >>> level, and assigns system-low level to filesystems.
> >>>
> >>> Also reworks the fs_use and genfscon rules to only
> >>> generate rules for filesystems that are configured
> >>> in the kernel.  In some cases this depends on a specific
> >>> config option for security xattrs, in other cases security
> >>> xattrs are unconditionally supported by a given filesystem
> >>> if the filesystem is enabled, and in some cases the filesystem
> >>> is always enabled in the kernel.  Dropped obsolete pseudo
> >>> filesystems.
> >>>
> >>> NB The list of fs_use_* and genfscon rules emitted by mdp
> >>> is very incomplete compared to refpolicy or Android sepolicy.
> >>> We should probably expand it.
> >>>
> >>> Usage:
> >>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
> >>> checkpolicy -M -o policy policy.conf
> >>>
> >>> Then install the resulting policy and file_contexts as usual.
> >>>
> >>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >>> ---
> >>> v3 fixes up the file contexts generation code to also use SYSTEMLOW and
> >>> collapse down to a single fprintf call per line.
> >>>   scripts/selinux/mdp/mdp.c | 131 ++++++++++++++++++++++++++++++--------
> >>>   1 file changed, 103 insertions(+), 28 deletions(-)
> >>
> >> This is great Stephen, thanks for working on this - and rather quickly
> >> too!  For those who don't follow the GitHub issues, I just opened an
> >> issue yesterday mentioning it would be nice to add MLS support to the
> >> mdp tool.
> >>
> >> Are you planning to keep playing with this?  I'm asking not because I
> >> think it needs more work to be worthwhile, but rather I don't want to
> >> merge something that you want to continue working on.  If you are
> >> happy with this latest patch I think it is okay to merge this into
> >> selinux/next, even at this late stage, simply because it is not part
> >> of a built kernel, but rather a developer's tool.
> >
> > No, I think I'm done for now unless you find a problem with it.  Absent
> > some compelling use case for mdp it is hard to justify spending any more
> > time on it.
>
> Note however that the instructions in
> Documentation/admin-guide/LSM/SELinux.rst just say to run
> scripts/selinux/install_policy.sh and since that doesn't pass -m to mdp
> or -M to checkpolicy, no one will use this support unless they do it all
> by hand.

Good point.

I tend to think that modifying the script to build MLS support by
default is probably a good thing, after all why go to the trouble of
adding MLS support to mdp?  Anyone have a strong opinion against this?

Stephen, please feel free to submit a second patch adding support to
the install_policy.sh script, but if you don't have time I'll get to
that over the weekend.

-- 
paul moore
www.paul-moore.com
