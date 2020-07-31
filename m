Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D754C433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2620221744
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 15:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6px9ZFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgGaPJz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgGaPJz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 11:09:55 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4A6C061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 08:09:55 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id f68so3718683ilh.12
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENL2wB66Vpm6QB0ccevQZG/I2eXHQ0tXgCsXWLNQ4I8=;
        b=k6px9ZFidS0roBn9Uw/nxZIp45zFGD8QGDXzxsCDEfVSw2uUhrBOucmNOc6HRfDZn7
         X8dstYRcS3v/Us91UQ3SPZ8Pvwul8mTwRr2DKG1qzgG7PlgkjxA82LfbAInz9yGwoOlG
         sCHOvGV02q5mcWsH+KneA5OguZJ4MxSOGa3YdXi7nJAEV80rySMgwku9a0l6GlXRuQ12
         dFQw01dXkXqrkpmv0a+5fMh/6/j4i0sV7iHH5H9P87a8oUHHJdB9u/37VAL6hlVXq0wP
         ifssCYgWKSxuCvkqDxucVylmaDrLAgDqGYtqzJmZDrcqvHFrkWRZ9N33Wz22DcjS/4qQ
         B7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENL2wB66Vpm6QB0ccevQZG/I2eXHQ0tXgCsXWLNQ4I8=;
        b=LvY2K+IEjj9Xk9SVPN4d3b7d8tZeD8PockCaSWvcOusWFCX/fvOJQs2dfwctsYJQJD
         pKe46b/o3KY95sVCsAicLML1AHWTnHX/O/vt/stmwYsB13kqUgVGYeJJtkFyQSH8YlgV
         5AFUnQlEp+pcj3B4r2DakGYeZN4O4/GtKuC8NGGD1W+4LgR3Amdpn1Rp6gr/qpvCBWZw
         BkzNCs/MHC3o1uXdu8y/JmjO3q+K5z/1hF/GoIdav6b76qR5l22hH2+tp4riC/McPazi
         kPONf5mSHCaExHR7OMYAYQJhOj67Y3QKuOa8/g/Zb7Oc9l6la+14jomw0F9i8uC7LJDz
         dsQQ==
X-Gm-Message-State: AOAM530Ro5LfSvoL0kKsYyIRxf/OQZmZ4wGqVxJWOyLIiQe+nKqhujO1
        vKg/M9f6Wl5KgEB3yvgpup0s1YE7eDRnPU4dsbg=
X-Google-Smtp-Source: ABdhPJxn7YK/nJwZh6x8KM8KPW8SzQHBrHllrw8mQFCXAID6XkelcUG26JGO+DYDD23OGwGhJN03rZDFEoLkiw2+v3c=
X-Received: by 2002:a92:aa4b:: with SMTP id j72mr4270340ili.141.1596208194605;
 Fri, 31 Jul 2020 08:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNv2zwKc7XPuDM-L8NkNB=DUAcuhVktRPsOp+K0j-wvQtA@mail.gmail.com>
In-Reply-To: <CAFqZXNv2zwKc7XPuDM-L8NkNB=DUAcuhVktRPsOp+K0j-wvQtA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 31 Jul 2020 10:09:43 -0500
Message-ID: <CAFftDdo2XOU1iH1Gn1bf8UF7VLHVXF9wuop9SOHj44P4pet-kQ@mail.gmail.com>
Subject: Re: License of userspace CI scripts?
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ah, I thought those were under the libselinux license, but I see each
sub-dir project has its own LICENSE terms.

I would be amenable to Apache 2.0 or BSD-3, and can just drop spdx
identifiers on them if that works?

Bill


On Fri, Jul 31, 2020 at 9:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Hi all,
>
> I started working on converting the selinux-testsuite Travis CI to run
> the testsuite in a Fedora VM as is currently being done for SELinux
> userspace thanks to William. In my current working version I basically
> just copy-pasted William's scripts from scripts/ci/... and made minor
> adjustments, so I have a slight concern over licensing - the scripts
> currently don't have any license headers and there is no
> LICENSE/COPYING file in a parent directory that could implicitly apply
> to them. William, would you mind adding some explicit GPLv2-compatible
> license headers there so I can legally copy the code over to
> selinux-testsuite? :)
>
> Thanks,
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
