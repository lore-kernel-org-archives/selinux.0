Return-Path: <SRS0=Yf2H=7W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01066C433E1
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 16:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D655120760
	for <selinux@archiver.kernel.org>; Tue,  9 Jun 2020 16:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgFIQOx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:14:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53541 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731021AbgFIQOx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jun 2020 12:14:53 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jigtQ-0007qO-Cr; Tue, 09 Jun 2020 16:14:28 +0000
Date:   Tue, 9 Jun 2020 18:14:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200609161427.4eoozs3kkgablmaa@wittgenstein>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
 <20200609034221.GA150921@gmail.com>
 <20200609074422.burwzfgwgqqysrzh@wittgenstein>
 <20200609160627.GA163855@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200609160627.GA163855@gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 09, 2020 at 09:06:27AM -0700, Andrei Vagin wrote:
> On Tue, Jun 09, 2020 at 09:44:22AM +0200, Christian Brauner wrote:
> > On Mon, Jun 08, 2020 at 08:42:21PM -0700, Andrei Vagin wrote:
> > > On Wed, Jun 03, 2020 at 06:23:26PM +0200, Adrian Reber wrote:
> > > > This patch introduces CAP_CHECKPOINT_RESTORE, a new capability facilitating
> > > > checkpoint/restore for non-root users.
> > > > 
> > > > Over the last years, The CRIU (Checkpoint/Restore In Userspace) team has been
> > > > asked numerous times if it is possible to checkpoint/restore a process as
> > > > non-root. The answer usually was: 'almost'.
> > > > 
> > > > The main blocker to restore a process as non-root was to control the PID of the
> > > > restored process. This feature available via the clone3 system call, or via
> > > > /proc/sys/kernel/ns_last_pid is unfortunately guarded by CAP_SYS_ADMIN.
> > > > 
> > > > In the past two years, requests for non-root checkpoint/restore have increased
> > > > due to the following use cases:
> > > > * Checkpoint/Restore in an HPC environment in combination with a resource
> > > >   manager distributing jobs where users are always running as non-root.
> > > >   There is a desire to provide a way to checkpoint and restore long running
> > > >   jobs.
> > > > * Container migration as non-root
> > > > * We have been in contact with JVM developers who are integrating
> > > >   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
> > > >   applications are not meant to be running with CAP_SYS_ADMIN.
> > > > 
> > > ...
> > > > 
> > > > The introduced capability allows to:
> > > > * Control PIDs when the current user is CAP_CHECKPOINT_RESTORE capable
> > > >   for the corresponding PID namespace via ns_last_pid/clone3.
> > > > * Open files in /proc/pid/map_files when the current user is
> > > >   CAP_CHECKPOINT_RESTORE capable in the root namespace, useful for recovering
> > > >   files that are unreachable via the file system such as deleted files, or memfd
> > > >   files.
> > > 
> > > PTRACE_O_SUSPEND_SECCOMP is needed for C/R and it is protected by
> > > CAP_SYS_ADMIN too.
> > 
> > This is currently capable(CAP_SYS_ADMIN) (init_ns capable) why is it
> > safe to allow unprivileged users to suspend security policies? That
> > sounds like a bad idea.
> 
> Why do you think so bad about me;). I don't suggest to remove or

Andrei, nothing could be further from me than to think bad about you!
You've done way too much excellent work. ;)

> downgrade this capability check. The patch allows all c/r related
> operations if the current has CAP_CHECKPOINT_RESTORE.
> 
> So in this case the check:
>      if (!capable(CAP_SYS_ADMIN))
>              return -EPERM;
> 
> will be converted in:
>      if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))
>              return -EPERM;

Yeah, I got that but what's the goal here? Isn't it that you want to
make it safe to install the criu binary with the CAP_CHECKPOINT_RESTORE
fscap set so that unprivileged users can restore their own processes
without creating a new user namespace or am I missing something? The
use-cases in the cover-letter make it sound like that's what this is
leading up to:

> > > > * Checkpoint/Restore in an HPC environment in combination with a resource
> > > >   manager distributing jobs where users are always running as non-root.
> > > >   There is a desire to provide a way to checkpoint and restore long running
> > > >   jobs.
> > > > * Container migration as non-root
> > > > * We have been in contact with JVM developers who are integrating
> > > >   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
> > > >   applications are not meant to be running with CAP_SYS_ADMIN.

But maybe I'm just misunderstanding crucial bits (likely (TM)).

Christian
