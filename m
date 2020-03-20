Return-Path: <SRS0=Veyl=5F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC3FC4332D
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C654820739
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="Sb40bqyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgCTQIS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:08:18 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34519 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgCTQIS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Mar 2020 12:08:18 -0400
Received: by mail-il1-f193.google.com with SMTP id c8so6105796ilm.1
        for <selinux@vger.kernel.org>; Fri, 20 Mar 2020 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRDDZazV1tjvflFDFhtuLRbGbpF/8ByenA+QYg908RI=;
        b=Sb40bqylBoyDOyZsDXbsj5fa3WwOvBQK7auTDLZGvoBliEm3FfRpsEAk0mPOf9G7G0
         MTa4QIypTWclhEoh6JDUZJUE79wweyMN10YaTLEBFmtBGwvhTijAA3C5CoBLoe6tcO2b
         qStajqI6E6eSgHQUybqcjkUXmh0R/+bW1D0ekkGwkktFstUH0g5Zy6vsDx9MeoXSPw2E
         6k5qfMGXCpYVmNBeYyWSZ273PQvmBdJfj08pG7GNRFQDOB0z2SkAJkl2T1rmDyt7W7C/
         v7fFhFcm2kwuMoG67SaGEYgY1aZUZcAEyVuOL3FJG1/d1Is1FFG20aGh+UGcgDQ972Mm
         4SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRDDZazV1tjvflFDFhtuLRbGbpF/8ByenA+QYg908RI=;
        b=PVNHGsRRUlRiCRTO16xhu7UBlqRfoSFENZBxWiluEkQ4lIXWkShwiZ+MKwakGYS1zU
         XB40kFN53b9eZNpJ+LV4AaKrbLRLQdoPVlfUkdr/m+skpHbd0mtfOwjZoxep2QKrzCjS
         YDryzib8WLEkFJfGFaYU0fVy5qX7j+/nP/+4qBSU7QG3w5l3ERrax/oXM17cSTiiMfRZ
         gONeMMG9AJuTdsT8t0BL0dU0LiWaiEKeKz/p58/al/EZBV59dVNkgyxcD4pn4Vz7uert
         qtgUqrpr0SL7s+9jRApm/iIK1buOGsL9Fp938uw6WcBE1ih3j5wGFaDEB5+xXxwwhfTz
         zJFg==
X-Gm-Message-State: ANhLgQ3rJKonfprl2wJ0aHjc02z12EWtqrYkP07oCWAUz8ASXq4tVbe1
        y8OEI1dOemIpWG75e2T7xACAFwXxAxed/yYSmzg4MtjR
X-Google-Smtp-Source: ADFU+vt1tIxl6NItMky6bT48+xM30zhBnv1NuawGCsD4VG6BtKDazj4HFkHzAbI2vV4ZjugMGiNAUdwQ+sBn2DpqsTI=
X-Received: by 2002:a92:96c6:: with SMTP id g189mr8724393ilh.276.1584720497212;
 Fri, 20 Mar 2020 09:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200319151948.15747-1-joshua.brindle@crunchydata.com> <CAFqZXNuF+i6L89BWQFxZTAgvJ68ifWmCXb1uS1hM37N5C+3+Ag@mail.gmail.com>
In-Reply-To: <CAFqZXNuF+i6L89BWQFxZTAgvJ68ifWmCXb1uS1hM37N5C+3+Ag@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Fri, 20 Mar 2020 12:08:06 -0400
Message-ID: <CAGB+Vh5_ktYQPshgPuRC_fEuAh7F087ZchKZDyP+_ij7QaWLvA@mail.gmail.com>
Subject: Re: [PATCH v4] Add tests for default_range glblub
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 20, 2020 at 5:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
<snip>
>
> # semodule -i test_add_levels.cil
> libsemanage.add_user: user system_u not in password file
>
> Should that first "sysadm_u" argument actually be "root"? And are
> these two lines really necessary? The test passes without them for me
> on a non-MLS system.
>

Interesting. I wouldn't have thought the contexts would be valid
without adding them to system_u... It seems to work so I removed them.

<snip>
> > +
>
> git am still complains about extra empty line at EOF here. I can fix
> that easily when merging, but if you're going to respin the patch
> because of the selinuxuser warning, then it would be nice to fix this,
> too :)
>
> [...]

I fixed all these and pushed. Thanks for the reviews.
