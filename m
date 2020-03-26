Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF90C43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE3B20719
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQXc+m+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgCZQwD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:52:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40802 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgCZQwC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 12:52:02 -0400
Received: by mail-io1-f66.google.com with SMTP id k9so6786761iov.7
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EM+Q/J328NAs4AzvIifQrmUKadnCYUJWpax71BYKuKA=;
        b=YQXc+m+jsPX2BVLLhneaGq0LIBeuPUMnl/iaWyzp1/8BwvH0nFmRK2G5qwsA3iv/dK
         ZVcTGmIjp/S1Ka1rsjLehRZ5cqg92OTJHz6koglyG9mrBAr6pKU+oM6xsIjKKSPBhQGm
         JVPgrNhhIYbBWEJbAsQJoMN7SQu96sqDZlowUcyQ619W+9zu0qa6z2Xtqg1vAOYoH6yA
         yfKjSW+pjuzho5HsLY/cF8GkuxPHOlya6dKfpviyPmygPCgkaHXUvrhaOkIGmy3ooulV
         oir81uq/d7J7ILzHhxMMk9/XvEiLXN7+2gBPZK4uRM6B51GRuUc3JQNIvArNRLIqFbm3
         6Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EM+Q/J328NAs4AzvIifQrmUKadnCYUJWpax71BYKuKA=;
        b=Zz7JMCziMPVnt718QkFT5uQg+CnaGXCo6/WutMptDsca68SCdQ8DUUiCPLfGwKn07t
         rozqOmNUtT7jbrciLKWir8+Pumx6elHYM3BR5gS6Ga6lE+K3buA77jBojC9iy00d7woF
         9lnT9c8wu/tX0nS1avlUohtHPTszFdQOQKISm/8/AWMbEgfRS5G7qDHN04s395kEJhzs
         sdOKeQKZWFEMp952BbYy8NoUpAGpy4eHspO28aG0HNq/uGaRSXd3cNcK9ZUlPy/CTa5S
         CH45OxTIVZW845oWfL9M3OoOsRSFXxfbVpmLPqrVRQBtA/5/VGYAiqY7AUDeDIkfNweC
         2YKw==
X-Gm-Message-State: ANhLgQ1DPyNKPvAOV/VT2xQIYoRw/T5s3ESh4hEGbGOQJPiXQt/wEntk
        hVJrc+X0pr3oNqvaDvNUEpHR4xY7ThyYo6PjQD4=
X-Google-Smtp-Source: ADFU+vsD9FAGxoeu3eCdoWo4LWziL6OHTG9+aBtSii1eEaLWXRWMUnYe9AZ8KzvHE50s62FNH65Wp69qLFNNlNLwijk=
X-Received: by 2002:a5d:8b98:: with SMTP id p24mr8541445iol.139.1585241520508;
 Thu, 26 Mar 2020 09:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdqYnjyrXYRpUhaXere+jz-RXXWM9qPF5w1vzyi3SZOYKg@mail.gmail.com>
 <20200319194853.15709-1-william.c.roberts@intel.com> <CAFqZXNtZLpdtreN1D5=FU+L8Rm10OpUu=jD4nzEqor7g50f3qw@mail.gmail.com>
 <CAFftDdoizXnNMOsyPdSeU15VmOgjpeAEU80DLLGSLzgyUC5gpQ@mail.gmail.com>
 <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com> <CAEjxPJ4R_oxqTkVFcHRyWVC3_Sn9zVuPZbvJbcW1iuf7uskkqw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4R_oxqTkVFcHRyWVC3_Sn9zVuPZbvJbcW1iuf7uskkqw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 26 Mar 2020 11:51:49 -0500
Message-ID: <CAFftDdoxp1ARDubfAQ0jMZeeVHqjGzq0bP-mv91ry4xWMgXDUA@mail.gmail.com>
Subject: Re: [PATCH] cil: drop remaining dso.h include
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 26, 2020 at 11:49 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Mar 26, 2020 at 11:17 AM Joshua Brindle
> <joshua.brindle@crunchydata.com> wrote:
> > It looks like this change broke building on MacOS:
> >
> > <inline asm>:1:1: error: unknown directive
> > .symver cil_build_policydb_pdb,        cil_build_policydb@LIBSEPOL_1.0
> > ^
> >
> > (on all of them).
> >
> > Previously dso.h defined DISABLE_SYMVER for Android and Apple, is
> > support for those intended to go away?
>
> Maybe we should add an osx build to our .travis.yml file and just test
> building libsepol/checkpolicy/secilc?

Definitely, I didn't realize travis had osx target. I can try and
queue this up for next week.
