Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E110C3F2D2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4AE20684
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzGXFFBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgB1Pkp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:40:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36147 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgB1Pkp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 10:40:45 -0500
Received: by mail-io1-f65.google.com with SMTP id d15so3865858iog.3
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 07:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ya1ARH/f4VmeZhb5NxBNLhCwQEFzIXi13gmxAgUsLdI=;
        b=lzGXFFBh5o5K5UZDvR3iuAaujRvtoUSs/Aiqp/xRUnh/UmXVLhNWcSoJTWvQzX60LK
         6pyzTRhAhVPXxaa/Xz4F9Be2XO0edEeOeKO+JnyXg6UucpDZubMJWACIBeR+q6gyX35x
         CI9DC2lycka4ukseZjJ5lYIQfDSbn/248Dtc3JBqsfa6ARkXXBmQfULDg7sanQchcp/e
         R8E8mbC8kMEU8JMH76/i3ywQ9eVLPajCeF/Fpt7CMAmHn3RjGVFVOEx2oLHsfQC4LSXw
         y0pLjDwkJAcKnziRqtEMi4V4uqyZewGM78v+dG5dY1R218u4ZFdSXM+8pzp49XMGxiwL
         /RrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ya1ARH/f4VmeZhb5NxBNLhCwQEFzIXi13gmxAgUsLdI=;
        b=l9QbJuWs/pMMBl3L3abm7ckAhUhLNbH86Bt1qNJtLeKRZP1nWbGtz30hPIVXTRUEsb
         IYobgbLoZCPK6skM2399e7RxPNABehev7VUb4DfcUNkX0S24/8WKH+C7EC9bljFwvwRi
         a3w4krj9Md/apDdwYWOnelRd5ThbCt3wNGpYPxIjMtnjnk8XgS82mOPrqLUbbSPD3uuR
         39ilRgc9DKRBQgIxqyhmrNKfXch66mvbynt3dgT08Z8ax1e5P1i/cYQ7TOadJ8JrzR3K
         Ibwp9LkKmQJOdKqvPPbCVPpeKM657ojnJwG6z0cNG+I6sB3+R0OH/R2c781L0nXGbceS
         mEIg==
X-Gm-Message-State: APjAAAXE10oxNtQ8gwPqh4iS2ukBddBiQ80S8DyKYW1bSI37Ugh2gQ3n
        vQUSmu+2Bh+A+E5DFlmbjBCaUZYTkFfPFYTFHOjctA==
X-Google-Smtp-Source: APXvYqxMITCqfqrkI0+mAVp6ROf//VNWQAMaDYOJ66P1vq1bFuQm0mZMFAcVUpfNWFIjZnUNTI8daI2b3Xv4dNmqO1w=
X-Received: by 2002:a05:6638:24f:: with SMTP id w15mr3970860jaq.130.1582904444737;
 Fri, 28 Feb 2020 07:40:44 -0800 (PST)
MIME-Version: 1.0
References: <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
 <20200228140524.2404-1-william.c.roberts@intel.com> <20200228140524.2404-5-william.c.roberts@intel.com>
 <CAEjxPJ52jwNh+TGnUkgGur=3hpdLPiT5cRZ6_Fzhy5aOOYGPjg@mail.gmail.com>
In-Reply-To: <CAEjxPJ52jwNh+TGnUkgGur=3hpdLPiT5cRZ6_Fzhy5aOOYGPjg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 28 Feb 2020 09:40:33 -0600
Message-ID: <CAFftDdpP4GUQJTJBN+LS8JwYcUNb+ZMChQUFCssHXLip_GLbaQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] libselinux: drop symbols from map
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 9:38 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Feb 28, 2020 at 9:05 AM <bill.c.roberts@gmail.com> wrote:
> >
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Previously, libselinux was exporting the following symbols:
> >   - dir_xattr_list;
> >   - myprintf_compat;
> >   - unmap_class;
> >   - unmap_perm;
>
> I had also suggested removing map_class, map_decision, map_perm.

Yes you did, I can't believe I skipped over them.
