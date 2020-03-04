Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50008C3F2CE
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 20:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173D62146E
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 20:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYzO2Mjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgCDUcX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:32:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39351 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgCDUcX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 15:32:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id x97so3393464ota.6
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 12:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3O9u2x2RKfyjcsWcGklK7PEND6aQwUMW5baIVQwqjHI=;
        b=UYzO2MjnHqcPUi7P8Hq0r7n3jH5p19itWT+tlwYcxpxNJ+VEJYmSOh2hBVTA/JTXno
         j8kSZwM3JT4UvdxgzVH5ixOwK0UzQtRUGbYETjwIsMzzZvzCSuGutUGT3FX6YAiM+fjO
         WZ4KyRsqL8KisKnArPeH5dZo/hKAZbRxWnOjL63zxr4Q4Ps31C7zWtbQ27JEQD6XYdQk
         cp6MSgQimUzqbm+nOkz7++fB5+zsljM9Ek8AvMp0/2deaKlj/lbK+48gThZ0rmn0vAlP
         osJyZh78o92/bHBv5Nx9Rv75NEtB+Y41z9CvPjfVd0vCgQuiR9f9rzBx6R1HQnVbkEl8
         60Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3O9u2x2RKfyjcsWcGklK7PEND6aQwUMW5baIVQwqjHI=;
        b=ZCa32P6E/ov790wLPZ2D34AsSIK+M8EKwBpo5VAc9T1p7s3rU2XpTcaao0DJnEt3zk
         Vo/MHkQhtr+ldpuRMet3sNyAQlQ7Bx8OSQ8bUAQ0Ix9s0m6v/NbsUVOxZPkswDWUk3oD
         vkIivRIYPsSfpXRhx1y6h0i0NtkWwCZbWwr0quvj4QlpZK2AB7iz0fUj7sZZkvSjci0O
         yv0uY3TTdu6YBo24DklVOB4mmfrblAGy2lggkDAxXpmtuqgHcGUXkdovZ/DUoTv2DU3x
         Toy6Or5YXxy7tzvD0NUZ2VvGiCCYdr2Ve9svtieKJZ/4CKjckA2UWt+xrtWyCDRRLR1V
         PdVQ==
X-Gm-Message-State: ANhLgQ2GRZNMh2sTIZtap/KVbvuNtR3Bgx8TjOSzNnjKWA1QnV92ijBw
        YM0OcHYgWNumCgGudATmr8v1tOYzSFiZ4WkGsOw=
X-Google-Smtp-Source: ADFU+vsvG8BPfhoVfewvShI8MNMzXJ/i0MXkFqrdQCkiIMLR3WYdMCF8hbE5z+K1UNrwiZHqK8Bex1pOc/Q5hpGGP+E=
X-Received: by 2002:a9d:6289:: with SMTP id x9mr3825059otk.340.1583353942804;
 Wed, 04 Mar 2020 12:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20200303085233.137371-1-omosnace@redhat.com> <CAEjxPJ5XHa2JLMf_BmhHV=LNBUe7qgM8Le6_PMX=jYjGb2OXvA@mail.gmail.com>
 <CAGB+Vh4RVwSraAGn1caEXOvHySkmgzgAfV7aZ-pwWKeUVyV_ag@mail.gmail.com>
In-Reply-To: <CAGB+Vh4RVwSraAGn1caEXOvHySkmgzgAfV7aZ-pwWKeUVyV_ag@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Mar 2020 15:33:29 -0500
Message-ID: <CAEjxPJ6_X=ceyf+Hy0qtY8L1ZgcJhwxnMBRQ1rwKZV9eFYJ8Yw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: add test for default_range glblub support
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 12:11 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
>
> On Wed, Mar 4, 2020 at 11:54 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Mar 3, 2020 at 3:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Adds a basic test for the "glblub" default_range mode introduced in
> > > kernel commit [1] and userspace commit [2]. The test vectors are taken
> > > from the original commit messages.
>
> I'm confused, I submitted tests at Paul's request. The patch is here
> but says superceded:
> https://patchwork.kernel.org/patch/11119909/

Hmm...not sure whose fault that was; could be mine. Probably got
marked as superseded by accident
along with the earlier versions of the kernel and userspace patches.
