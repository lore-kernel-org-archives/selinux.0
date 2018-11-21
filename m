Return-Path: <SRS0=ZtKf=OA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38900C43441
	for <selinux@archiver.kernel.org>; Wed, 21 Nov 2018 08:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058E32146F
	for <selinux@archiver.kernel.org>; Wed, 21 Nov 2018 08:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058E32146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeKUSmf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:42:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38040 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeKUSmf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Nov 2018 13:42:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id u3so4188395ota.5
        for <selinux@vger.kernel.org>; Wed, 21 Nov 2018 00:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tE57NF94bAgKAdepnTircJl7tO9e53z1QvxfNT2gC0w=;
        b=l4SOF2tYreb74qWhQUYEbpqfIK6Flk4tlOV9dY/H9ptmzvO6z+H5HBzgUp+fjMw7Av
         z/WYvNzNs1lbswlxMniUW+Cs+aT+0plf8zUTgG5H6zR0mlg6HuzYG8eE0VxiAxGNXTxY
         +AmLPjTTO4WU9o9x199Hb2E6fu7AAcWrs0188DvGrzTMu4mTu/Uv/xL2nhYkbG0YpTlR
         qeri3P61UO2XfFOG/Ag12DklZ5KZAU/fiYQ+MGwMnbewWO9gxVxRTjoKZhvDE1XXP7+f
         bzMRumjyHqrsdD/8XBbCnCMe+5ffk3VT+Uo5dI0GdFhG94xA8kSgSwyoZH0e8rBtnqA/
         15Lg==
X-Gm-Message-State: AA+aEWbqNuOOe+i9+Li6UqYJPwitI0BlJwJ1wj4z6E9yPp4rHNXLye2m
        /GWy8/NLRpUM6O/3HQYHdgrXoxdEyDiqQnOz0ivQiZ5rU8Y=
X-Google-Smtp-Source: AFSGD/V3yQsQtWdm4j5tw9BjanZGET0CbWfIw85B/9r4Ox3z4tYHbBGh0cyiy1uiUUoPfHvgcOVqyLG9YKyhfQl4Ucw=
X-Received: by 2002:a9d:582e:: with SMTP id r46mr3284833oth.238.1542787744410;
 Wed, 21 Nov 2018 00:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20181113135255.26045-1-omosnace@redhat.com> <20181113135255.26045-2-omosnace@redhat.com>
 <CAHC9VhQoJk0KF2B+SEsVO4Av1qT8dTaOPDPkFV=R1J6W49qSYw@mail.gmail.com>
In-Reply-To: <CAHC9VhQoJk0KF2B+SEsVO4Av1qT8dTaOPDPkFV=R1J6W49qSYw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 21 Nov 2018 09:08:53 +0100
Message-ID: <CAFqZXNtamgSLJBLriKo2Ny_VabbimZEP2WV3RRCaXhHWVCCwug@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] selinux: refactor sidtab conversion
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 20, 2018 at 10:47 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Nov 13, 2018 at 8:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > This is a purely cosmetic change that encapsulates the three-step sidtab
> > conversion logic (shutdown -> clone -> map) into a single function
> > defined in sidtab.c (as opposed to services.c).
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/services.c | 22 +--------------
> >  security/selinux/ss/sidtab.c   | 50 ++++++++++++++++++++++++----------
> >  security/selinux/ss/sidtab.h   | 11 ++++----
> >  3 files changed, 42 insertions(+), 41 deletions(-)
>
> Merged into selinux/next with some whitespace fixes (inherited from
> code you cut n' pasted).  Please remember to run your patches through
> scripts/checkpatch.pl before submission.

Damn, I still haven't set up that commit hook... Done now, seems to
work fine. Sorry for not having done that sooner and thanks for
nagging me about it :)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
