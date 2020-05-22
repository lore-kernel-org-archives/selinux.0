Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77524C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 07:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5C92072C
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 07:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgEVHyH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 03:54:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52941 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVHyG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 03:54:06 -0400
Received: from [95.90.241.131] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jc2Um-0002AH-Ab; Fri, 22 May 2020 07:53:32 +0000
Date:   Fri, 22 May 2020 09:53:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
Message-ID: <20200522075331.ef7zcz3hbke7qvem@wittgenstein>
References: <20200522055350.806609-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200522055350.806609-1-areber@redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 07:53:50AM +0200, Adrian Reber wrote:
> This enables CRIU to checkpoint and restore a process as non-root.
> 
> Over the last years CRIU upstream has been asked a couple of time if it
> is possible to checkpoint and restore a process as non-root. The answer
> usually was: 'almost'.
> 
> The main blocker to restore a process was that selecting the PID of the
> restored process, which is necessary for CRIU, is guarded by CAP_SYS_ADMIN.
> 
> In the last two years the questions about checkpoint/restore as non-root
> have increased and especially in the last few months we have seen
> multiple people inventing workarounds.
> 
> The use-cases so far and their workarounds:
> 
>  * Checkpoint/Restore in an HPC environment in combination with
>    a resource manager distributing jobs. Users are always running
>    as non root, but there was the desire to provide a way to
>    checkpoint and restore long running jobs.
>    Workaround: setuid wrapper to start CRIU as root as non-root
>    https://github.com/FredHutch/slurm-examples/blob/master/checkpointer/lib/checkpointer/checkpointer-suid.c
>  * Another use case to checkpoint/restore processes as non-root
>    uses as workaround a non privileged process which cycles through
>    PIDs by calling fork() as fast as possible with a rate of
>    100,000 pids/s instead of writing to ns_last_pid
>    https://github.com/twosigma/set_ns_last_pid
>  * Fast Java startup using checkpoint/restore.
>    We have been in contact with JVM developers who are integrating
>    CRIU into a JVM to decrease the startup time.
>    Workaround so far: patch out CAP_SYS_ADMIN checks in the kernel
>  * Container migration as non root. There are people already
>    using CRIU to migrate containers as non-root. The solution
>    there is to run it in a user namespace. So if you are able
>    to carefully setup your environment with the namespaces
>    it is already possible to restore a container/process as non-root.
>    Unfortunately it is not always possible to setup an environment
>    in such a way and for easier access to non-root based container
>    migration this patch is also required.
> 
> There are probably a few more things guarded by CAP_SYS_ADMIN required
> to run checkpoint/restore as non-root, but by applying this patch I can
> already checkpoint and restore processes as non-root. As there are
> already multiple workarounds I would prefer to do it correctly in the
> kernel to avoid that CRIU users are starting to invent more workarounds.

It sounds ok to me as long as this feature is guarded by any sensible
capability. I don't want users to be able to randomly choose their pid
without any capability required.

We've heard the plea for unprivileged checkpoint/restore through the
grapevine and a few times about CAP_RESTORE at plumbers but it's one of
those cases where nobody pushed for it so it's urgency was questionable.
This is 5.9 material though and could you please add selftests?

It also seems you have future changes planned that would make certain
things accessible via CAP_RESTORE that are currently guarded by other
capabilities. Any specific things in mind? It might be worth knowing
what we'd be getting ourselves into if you're planning on flipping
switches in other places.

Christian
