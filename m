Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08669C43461
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 11:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8D5208FE
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 11:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQGUrvbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgIHLaA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:30:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24624 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730064AbgIHL3n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 07:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599564550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SJToen5De/FMO5Uvn6WpRdklNdA0QrVJ+xmLiUK7iQ=;
        b=GQGUrvbqpyn5i8EIEt9WwBf3dRIE2h4UlnG6/hS6nswxUsr/SeVWUanWB/uPfRbtS72Xtj
        jc7kYvUBQIu0r2CxkX5SFKIa+QxM2w++NVn40A9yLD1tm1u3XthPyvaGnZ6vZzOX5CPjih
        alYnAbNpM1xix+KUuXScPFWfDowwaXQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-1k8zHCxnMVympDJR5yJB8g-1; Tue, 08 Sep 2020 07:29:08 -0400
X-MC-Unique: 1k8zHCxnMVympDJR5yJB8g-1
Received: by mail-lj1-f198.google.com with SMTP id l1so5127916ljj.2
        for <selinux@vger.kernel.org>; Tue, 08 Sep 2020 04:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8SJToen5De/FMO5Uvn6WpRdklNdA0QrVJ+xmLiUK7iQ=;
        b=JeJa/+ciYSx9KCbMU8iICFuJgPCdaCQhKlGOuQFpWlGTKcDtXlyFVT6t6zPT9ZOkqB
         5IYtWLX3D2kZXfNPcpcuuD2csyfsGA7+4phZyFDBIc5vDfAdWWar/L5QB/pVIulv9R6O
         bqVPKFlZcSSkwiRyjcwMDTrdpY4elHVFHtk6m7MelYh2KZBC9YmZniqaUnQljsoOBGRP
         taxIvgyBlRgEM2699qdMFk2Hzlh3pa/Pp4L7SB4I2atyEQt3xv97msd/Xjll7KQoQoZm
         lnDr/CCxOhFjcuyQPb/c+iu1zti5ewnnp1wWzrN0iKIDqnRxmo1y4bOREJ0faEpI5cnv
         VECQ==
X-Gm-Message-State: AOAM532fRiJm0Ny9ep98ZCEDNCFSGeZ+ruyS8+YZfnn829Gi13kpENA9
        CKyGh/GiC9aAiMfa82h0r8XxBOhP2KiV0aaOPbF/nfIxxXvnitIU/cQCLpUyeVRbwrr5r3bc3kd
        0w86fcpMbOB4Z40N8QjcuTX0uhuJE/JYsRg==
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr13042324ljh.311.1599564546509;
        Tue, 08 Sep 2020 04:29:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzAkVnfY3RS8jLmTTPylLLgZwYimBUxyg65KS1GNPlqmB6hBjIWbaP1koimAnXDD5XhM3jLRXYLRHBdxEEogQ=
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr13042309ljh.311.1599564546218;
 Tue, 08 Sep 2020 04:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200904160031.6444-1-cgzones@googlemail.com> <20200908102537.GU2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200908102537.GU2674@hirez.programming.kicks-ass.net>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 8 Sep 2020 13:28:55 +0200
Message-ID: <CAFqZXNuD3SRQtE9OUC5NX0XepThg0MJ0b8TJ5TF7YRgS93+TOg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: only issue an audit on privileged operation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 8, 2020 at 12:26 PM <peterz@infradead.org> wrote:
> On Fri, Sep 04, 2020 at 06:00:31PM +0200, Christian G=C3=83=C2=B6ttsche w=
rote:
> > sched_setattr(2) does via kernel/sched/core.c:__sched_setscheduler()
> > issue a CAP_SYS_NICE audit event unconditionally, even when the request=
ed
> > operation does not require that capability / is un-privileged.
> >
> > Perform privilged/unprivileged catigorization first and perform a
> > capable test only if needed.
> >
> > Signed-off-by: Christian G=C3=83=C2=B6ttsche <cgzones@googlemail.com>
> > ---
> >  kernel/sched/core.c | 65 ++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 47 insertions(+), 18 deletions(-)
>
> So who sodding cares about audit, and why is that a reason to make a
> trainwreck of code?

The commit message should be more specific. I believe Christian is
talking about the case where SELinux or other LSM denies the
capability, in which case the denial is usually logged to the audit
log. Obviously, we don't want to get a denial logged when the
capability wasn't actually required for the operation to be allowed.

Unfortunately, the capability interface doesn't provide a way to first
get the decision value and only trigger the auditing when it was
actually used in the decision, so in complex scenarios like this the
caller needs to jump through some hoops to avoid such false-positive
denial records.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

