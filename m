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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5542AC433DF
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 13:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296A9206F1
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 13:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVPBBPH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgFSNZY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgFSNZY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Jun 2020 09:25:24 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BF5C06174E
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 06:25:23 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z2so9208248ilq.0
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 06:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wZvPlv1NxVJR2KMEqS99wdwJejGzc2RJkChNYh9aWA=;
        b=OVPBBPH4+yMIKE3xlSfv+jRSv7abyHMJANSihFN4mP7jkprPsAZotWiFornNe58HIS
         SzTexvr4Tvdv/VnJM0wEsfD9orT9ID9N/mo3RM8GKkeQOd3ZDJI+jMCsaUcvyzNf5TL5
         pD0Ezrn6zGHGOzChETmC4xv0kYskwjh6S6VfcstB6FWj6gL1P7gtkWogq+ggf42nisdH
         n+IEoccnKBnP5PLjhHCZEH5MGzkoO12B5IFPjBDxfpk4n+ZQ7Wpp+JIv5Qu82nXiUzhb
         5V30YvZktcYm0VJ14+m3rIHu15Xl0WNdD6FL+qRnPgIF2T7LMqraxAda6of/UwEh2642
         i3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wZvPlv1NxVJR2KMEqS99wdwJejGzc2RJkChNYh9aWA=;
        b=RbBMy582J8zyB3vAdgoeJc1DYeT8CCWijE0Rw/38H3+Vf66xv1BdAz9tDM6l1wXZO0
         Zg7LFxIJb3w6KntPAy6+NsR2yR47yIcyticN8B1uDowL/2LMEZq+rQq7ez+8tzD2aiDM
         RWudIia5ngkNLyRRTbA/MlpF+CF3sZ1SYNcfkecLG75V5h/zTyNSmvz2DoPYHGnCFPiD
         Wwybfh+K6+KRFFvk+IkPmLcB4OKHzCVE2VQHgslCpy3wdadq9xeiiof3Ogqq2KAFuxsp
         HVjvnAWRx9/eFeQd9vXlrWsgZFvD1IxVB+3H1WzBOHzsgUkCRYgzwcgeaFL6WSiBnr2Y
         yxdw==
X-Gm-Message-State: AOAM5324K8YM70wSOmO0fhobaNjICcA0vxh0nc4GbZFsnEya9C7P56qU
        FmN9j4/jzctd9Y2U9L2awBWJnRJWTOmU5O9e+0k=
X-Google-Smtp-Source: ABdhPJyQ/0paSov5cIpOOvmKvxSUCDUOCmZ60mccV3YeWC5yxDhZ1MoB6AZkctYAl+4UUWgmwEQdJTyeFu/rUc73xbk=
X-Received: by 2002:a92:b704:: with SMTP id k4mr3538157ili.129.1592573123259;
 Fri, 19 Jun 2020 06:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <SELinuxProject/selinux+700041658+stillfailing@travis-ci.org>
 <5eeca9a6c6c3f_13f81db917afc6197f@travis-tasks-8545cf558d-gwbmp.mail>
 <20200619124723.GD785659@localhost.localdomain> <CAFqZXNtnPU++Foy+SdeVwMFqJ14tEsNnqOFHZEsbUHmYs_-0rw@mail.gmail.com>
 <20200619131219.GF785659@localhost.localdomain>
In-Reply-To: <20200619131219.GF785659@localhost.localdomain>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 19 Jun 2020 08:25:12 -0500
Message-ID: <CAFftDdpHBEB6yRqiBaUp_Z5==yZD92TxPCwpNcxLx76eDh-02Q@mail.gmail.com>
Subject: Re: Still Failing: SELinuxProject/selinux#444 (master - b3d8b99)
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 19, 2020 at 8:13 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Fri, Jun 19, 2020 at 02:54:47PM +0200, Ondrej Mosnacek wrote:
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
> >
>
> https://travis-ci.org/github/SELinuxProject/selinux/jobs/700041681 restarted at
> your request

Build Passed
