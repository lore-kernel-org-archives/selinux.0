Return-Path: <SRS0=1V8V=AA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A78C433E0
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 13:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A147A20DD4
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 13:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gacZzedm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbgFSNL6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgFSNL4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Jun 2020 09:11:56 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E96C06174E
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 06:11:54 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a13so9175171ilh.3
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdoMTKo7fLyVO5ej5a8o3iSlBUEQBl3iJRAUQhXxdjA=;
        b=gacZzedm+u7oqjk+OMerP4v/rluYWwSO9CouhJtMRS/jVH2BSi7ArjZ4ARKEs4Zv0r
         5bX7Npmb5THqsZKznc/DxaObUUUYbQBDSHkivBdu4d8O1t5vOn2m1tlOWrYARxGw41a3
         ZAMYX4ZFGqW3qJmjvxaaXAyrfFHWZW2CklL+Y7aoNaZdsg3/66D1Mig3kPUSqQ7mH+Hr
         zDLbha0UMY2jz1zKBWAItk+I3bZahcrm8XTTAPM5EDnZvcgdFSMEYxH+W6QF2Z4b5RiZ
         6TVqkD4hW4+hBSu4RUB5p+xVxERzhMXEjQ1nJv2uNM+R/Shf1nxKRvlWOQSpXFYjK65o
         nxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdoMTKo7fLyVO5ej5a8o3iSlBUEQBl3iJRAUQhXxdjA=;
        b=uDHIP0bKXVa2NDY9b36pEMJBY0KvW+Z+9bHLtmkkWJXfDUy8dTDoYrDypqZSDq6UCF
         HtCA23bkuxCoitZa/3IH/BndZtY+j9qgDFXAE9CIWTKze+4aODsArFjwZytsS6C0LKPt
         IFVtNlPLgFuQ2+C8fKfI9M0BpuzcjwWU2jP/l39Vpv/i8WTvT2ZZb5BSx39WF+cZtpzT
         S016ODYtexerZRIo26XmEvygRQ5k1mNKU/VCNqB0U8pOsA59a8XOG7Ba2Le72XEo+8CV
         HuA5yc0GGxFZHQrdPsG/Pq7sjMZ+Q9Cp7GwzepCAuRG8pxLOUcSCYsPQ3OI4q8O5AE5Z
         Bq5w==
X-Gm-Message-State: AOAM531H2Qy/e3dq2aZ/yHnoswFBuwNMO6pfnHST3LVrcgY1ClUiKTI0
        jKV6b2UmLCpsfa90CmXrWQFh5HI04dVKBp9F2ww=
X-Google-Smtp-Source: ABdhPJwNOa6NIDKsbb5e9RlgElNuURICLrKz4+6y4r1Ci2oitihmoBmYDN/6zsxp6c0TJF6Z8at1VqTieH2QD3OQXpM=
X-Received: by 2002:a92:5b15:: with SMTP id p21mr3619598ilb.22.1592572313755;
 Fri, 19 Jun 2020 06:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <SELinuxProject/selinux+700041658+stillfailing@travis-ci.org>
 <5eeca9a6c6c3f_13f81db917afc6197f@travis-tasks-8545cf558d-gwbmp.mail>
 <20200619124723.GD785659@localhost.localdomain> <CAFqZXNtnPU++Foy+SdeVwMFqJ14tEsNnqOFHZEsbUHmYs_-0rw@mail.gmail.com>
 <CAFftDdpjYOZ+rm5ZM-sB093+TYpdd-tnbR9-PR-R5P+Un9QXkg@mail.gmail.com>
In-Reply-To: <CAFftDdpjYOZ+rm5ZM-sB093+TYpdd-tnbR9-PR-R5P+Un9QXkg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 19 Jun 2020 08:11:42 -0500
Message-ID: <CAFftDdp72qVSZ5-ahuP55OZpNw5TPd6bcVrYcNyFHOLe5ceZDg@mail.gmail.com>
Subject: Re: Still Failing: SELinuxProject/selinux#444 (master - b3d8b99)
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 19, 2020 at 8:10 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, Jun 19, 2020 at 8:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Fri, Jun 19, 2020 at 2:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > On Fri, Jun 19, 2020 at 12:03:51PM +0000, Travis CI wrote:
> > > > Build Update for SELinuxProject/selinux
> > > > -------------------------------------
> > > >
> > > > Build: #444
> > > > Status: Still Failing
> > > >
> > > > Duration: 17 mins and 45 secs
> > > > Commit: b3d8b99 (master)
> > > > Author: Petr Lautrbach
> > > > Message: Update VERSIONs to 3.1-rc2 for release.
> > > >
> > > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > > >
> > > > View the changeset: https://github.com/SELinuxProject/selinux/compare/08f5e3017721...b3d8b99f0cb0
> > > >
> > > > View the full build log and details: https://travis-ci.org/github/SELinuxProject/selinux/builds/700041658?utm_medium=notification&utm_source=email
> > > >
> > >
> > > Seems to be related to outage in Fedora infrastructure -
> > > https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/MAGJJTVR777ARZ4TVMBQQ3YK6RC7ODE6/
> > >
> > > There's also ongoing datacentre move -
> > > https://lists.fedoraproject.org/archives/list/devel-announce@lists.fedoraproject.org/thread/5DNRZ4OUUNGSUJONQLEXXP3CKME43SCE/
> >
> > Have you tried just restarting the build? Looking at the logs, it
> > successfully connected to 152.19.134.145 when downloading the image,
> > but then failed to connect to the same IP when downloading the
> > checksum file, which would suggest the connection is just flaky and
> > not completely down.
>
> Just re-toggle the build, you will see intermittent travis failures
> occasionally from issues on their end. It's happened in other
> build configs as well.

FYI You don't have to re-toggle the "whole build" you can just
re-toggle the particular sub-build that failed.
It's much more convenient to just re-toggle the individual build.
