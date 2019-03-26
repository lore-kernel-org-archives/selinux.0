Return-Path: <SRS0=N/SO=R5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD8C4360F
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 12:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F6720823
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 12:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfCZMeG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:34:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44319 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZMeG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Mar 2019 08:34:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id d24so11216749otl.11
        for <selinux@vger.kernel.org>; Tue, 26 Mar 2019 05:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zo2kZaFXun4ur6wY2xnBnTG4h6yFnWUo8V5pDttjlIw=;
        b=r+gx5d2iEGKGm0Y/fnW05Ae9bnUTQpGOOaqaNC5DrViYVScHXmguQOa92mNO029j6V
         NY+PqThvr7/9+IO08srvxOtF2wtG8yZy6gf1Tq/wZotzyey4NzKpIgomQ98wMLa+YwKb
         EtsuEOigZFHL+bP9gIO6AV0zx/WIXoyfa1SMLzURfHAAYsyVn1waOiD3LEYPluZ/HQ5r
         N4VFU4acDbx58rG9bgNeFF7xFZd+U9oatQLy4gX2w7Sj7kkyZqcaVwirWyJMEDYk9Wz5
         LFzoYLSbXllJl4VrO7SkQQWhPkYQDnS/FptGCtcHDy3p/k0Svnt3Fz9x/NubdGjjUinV
         00UQ==
X-Gm-Message-State: APjAAAXEjkyA/kMmezrHIr5soZB5VqJ2Xo9Jbo4FQWs6xPJzQ0l1YPHb
        uX/IUpfgL6OcUB59MjMfz/VtjC+vVqpths3g+9uoWA==
X-Google-Smtp-Source: APXvYqytfmlPhKCfMz5dYKWqmfUc1uqr2mjGXWqJapB4AVtVXi26qRHFf/1V9w6QwMWNG2nNvLlJ2DqtXJHRC4y4Bh4=
X-Received: by 2002:a9d:3289:: with SMTP id u9mr11992007otb.52.1553603645845;
 Tue, 26 Mar 2019 05:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190325145032.GB21359@shao2-debian> <CAHC9VhQt6RMdOsVNAXHnPzTrVRpnfaq4PULzBCmMPg7SgdTpfw@mail.gmail.com>
 <CAFqZXNuJMJTjGL5qGoemy4O--Y3kGGwGb2TfwJ5xxFAz03uPqg@mail.gmail.com>
In-Reply-To: <CAFqZXNuJMJTjGL5qGoemy4O--Y3kGGwGb2TfwJ5xxFAz03uPqg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 26 Mar 2019 13:33:54 +0100
Message-ID: <CAFqZXNtazgAzoFDMiQWOdaVNcpAH3PEEXwwJ8D+njGoEX4+DvA@mail.gmail.com>
Subject: Re: [kernfs] e19dfdc83b: BUG:KASAN:global-out-of-bounds_in_s
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LKML <linux-kernel@vger.kernel.org>, selinux@vger.kernel.org,
        lkp@01.org, kernel test robot <rong.a.chen@intel.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 25, 2019 at 6:06 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Mar 25, 2019 at 4:17 PM Paul Moore <paul@paul-moore.com> wrote:
> > Ondrej, please look into this.
> >
> > You've looked at this code more recently than I have, but it looks
> > like there might be an issue with __kernfs_iattrs() returning a
> > pointer to a kernfs_iattrs object without taking a kernfs reference
> > (kernfs_get(kn)).  Although I would be a little surprised if this was
> > the problem as I think it would cause a number of issues beyond just
> > this one ... ?
>
> I think this is actually because of how xattr_full_name() reconstructs
> the full name from the xattr suffix. It assumes that the suffix was
> obtained from the full name by just taking a pointer inside it, but in
> kernfs_security_xattr_get/set() I pass the suffix directly... I'm
> surprised that this didn't fail spectacularly earlier during testing.
> Maybe the newer GCC does some clever merging of the string constants,
> so that XATTR_SELINUX_SUFFIX actually ends up as a substring of
> XATTR_NAME_SELINUX? (That would be one hell of a "lucky" coincidence
> :)
>
> I'll post a patch that converts kernfs_security_xattr_get/set() to
> take the full name and hopefully that will fix the problem. I'll see
> if I can run the reproducer locally tomorrow...

I managed to reproduce the KASAN warning in my kernel testing
environment by simply enabling CONFIG_KASAN and running the cgroupfs
issue reproducer from the original patchset. With the patch I posted I
no longer get the warning, so I believe it really fixes the problem.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
