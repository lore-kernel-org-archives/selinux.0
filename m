Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3820AC433DF
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 09:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18595208DB
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 09:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbgE1JtI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 05:49:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46125 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgE1JtI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 05:49:08 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jeF9V-0002NQ-9d; Thu, 28 May 2020 09:48:41 +0000
Date:   Thu, 28 May 2020 11:48:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Cc:     Adrian Reber <areber@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
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
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
Message-ID: <20200528094839.gw7aqd3xs3kix273@wittgenstein>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com>
 <877dwybxvi.fsf@x220.int.ebiederm.org>
 <20200527141403.GC250149@dcbz.redhat.com>
 <20200527152955.jbbipgb6icb4nwgv@wittgenstein>
 <d5ecde0c94014a4fad090e44377e9852@EXMBDFT11.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5ecde0c94014a4fad090e44377e9852@EXMBDFT11.ad.twosigma.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 06:05:55PM +0000, Nicolas Viennot wrote:
> > > Also in this thread Kamil mentioned that they also need calling prctl 
> > > with PR_SET_MM during restore in their production setup.
> >
> > We're using that as well but it really feels like this:
> >
> >	prctl_map = (struct prctl_mm_map){
> >	    .start_code = start_code,
> >	    .end_code = end_code,
> >	    .start_stack = start_stack,
> >	    .start_data = start_data,
> >	    .end_data = end_data,
> >	    .start_brk = start_brk,
> >	    .brk = brk_val,
> >	    .arg_start = arg_start,
> >	    .arg_end = arg_end,
> >	    .env_start = env_start,
> >	    .env_end = env_end,
> >	    .auxv = NULL,
> >	    .auxv_size = 0,
> >	    .exe_fd = -1,
> >	};
> >
> > should belong under ns_capable(CAP_SYS_ADMIN). Why is that necessary to relax?
> 
> When the prctl(PR_SET_MM_MAP...), the only privileged operation is to change the symlink of /proc/self/exe via set_mm_exe_file().
> See https://github.com/torvalds/linux/blob/444fc5cde64330661bf59944c43844e7d4c2ccd8/kernel/sys.c#L2001-L2004
> It needs CAP_SYS_ADMIN of the current namespace.

This already has been relaxed before (see commit below) and why I'm at
least symbolically pushing back is that I'm getting worried that we're
just removing restrictions left and right and making kernel interfaces
available to fully unprivileged user that very much seem to belong into
the realm of local cap_sys_admin.

    prctl: Allow local CAP_SYS_ADMIN changing exe_file

    During checkpointing and restore of userspace tasks
    we bumped into the situation, that it's not possible
    to restore the tasks, which user namespace does not
    have uid 0 or gid 0 mapped.

    People create user namespace mappings like they want,
    and there is no a limitation on obligatory uid and gid
    "must be mapped". So, if there is no uid 0 or gid 0
    in the mapping, it's impossible to restore mm->exe_file
    of the processes belonging to this user namespace.

    Also, there is no a workaround. It's impossible
    to create a temporary uid/gid mapping, because
    only one write to /proc/[pid]/uid_map and gid_map
    is allowed during a namespace lifetime.
    If there is an entry, then no more mapings can't be
    written. If there isn't an entry, we can't write
    there too, otherwise user task won't be able
    to do that in the future.

    The patch changes the check, and looks for CAP_SYS_ADMIN
    instead of zero uid and gid. This allows to restore
    a task independently of its user namespace mappings.

> 
> I would argue that setting the current process exe file check should just be reduced to a "can you ptrace a children" check.
> Here's why: any process can masquerade into another executable with ptrace.
> One can fork a child, ptrace it, have the child execve("target_exe"), then replace its memory content with an arbitrary program.

Then it should probably be relaxed to CAP_SYS_PTRACE in the user
namespace and not CAP_CHECKPOINT_RESTORE. (But apparently you also have
a way of achieving what you want anyway. Imho, it's not necessarily
wrong to require a bit more work when you want something like fully
unprivileged c/r that's a rather special interest group.)

> With CRIU's libcompel parasite mechanism (https://criu.org/Compel) this is fairly easy to implement.
> In fact, we could modify CRIU to do just that (but with a fair amount of efforts due to the way CRIU is written),
> and not rely on being able to SET_MM_EXE_FILE via prctl(). In turn, that would give an easy way to masquerade any process
> into another one, provided that one can ptrace a child.
> 
> When not using PR_SET_MM_MAP, but using SET_MM_EXE_FILE, the CAP_RESOURCES at the root namespace level is required:
> https://github.com/torvalds/linux/blob/444fc5cde64330661bf59944c43844e7d4c2ccd8/kernel/sys.c#L2109
> This seems inconsistent. Also for some reason changing auxv is not privileged if using prctl via the MM_MAP mechanism, but is privileged otherwise.

Fwiw, it always helps if people take the time to dig through the history
of specifc changes. That usually helps explain why things ended up as
confusing as they are now:

	commit f606b77f1a9e362451aca8f81d8f36a3a112139e
	Author: Cyrill Gorcunov <gorcunov@openvz.org>
	Date:   Thu Oct 9 15:27:37 2014 -0700
	
	    prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation
	
	    During development of c/r we've noticed that in case if we need to support
	    user namespaces we face a problem with capabilities in prctl(PR_SET_MM,
	    ...) call, in particular once new user namespace is created
	    capable(CAP_SYS_RESOURCE) no longer passes.
	
	    A approach is to eliminate CAP_SYS_RESOURCE check but pass all new values
	    in one bundle, which would allow the kernel to make more intensive test

[snip]

	Still note that updating exe-file link now doesn't require sys-resource
    	capability anymore, after all there is no much profit in preventing setup
    	own file link (there are a number of ways to execute own code -- ptrace,
    	ld-preload, so that the only reliable way to find which exactly code is
    	executed is to inspect running program memory).  Still we require the
    	caller to be at least user-namespace root user.

    	I believe the old interface should be deprecated and ripped off in a
    	couple of kernel releases if no one against.

Sine you already have an interface that works and the argument for the
new interface is that it let's the kernel do better validation if all
arguments be passed at once I don't see the point in removing the
CAP_SYS_RESOURCE restricting from the old interface possible introducing
more maintenance burden or bugs when changing this. It would also
encourage users to use an interface that even c/r people seemed to have
viewed as being deprecated.

Christian
