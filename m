Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162BDC433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF43C20721
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 15:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbgE0Pa0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 11:30:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39185 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388145AbgE0Pa0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 11:30:26 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jdy0C-00055J-VY; Wed, 27 May 2020 15:29:57 +0000
Date:   Wed, 27 May 2020 17:29:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
Message-ID: <20200527152955.jbbipgb6icb4nwgv@wittgenstein>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com>
 <877dwybxvi.fsf@x220.int.ebiederm.org>
 <20200527141403.GC250149@dcbz.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527141403.GC250149@dcbz.redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 04:14:03PM +0200, Adrian Reber wrote:
> On Tue, May 26, 2020 at 08:59:29AM -0500, Eric W. Biederman wrote:
> > Adrian Reber <areber@redhat.com> writes:
> > 
> > > On Fri, May 22, 2020 at 09:40:37AM -0700, Casey Schaufler wrote:
> > 
> > >> What are the other blockers? Are you going to suggest additional new
> > >> capabilities to clear them?
> > >
> > > As mentioned somewhere else access to /proc/<pid>/map_files/ would be
> > > helpful. Right now I am testing with a JVM and it works without root
> > > just with the attached patch. Without access to /proc/<pid>/map_files/
> > > not everything CRIU can do will actually work, but we are a lot closer
> > > to what our users have been asking for.
> > 
> > The current permission checks on /proc/<pid>/map_files/ are simply
> > someone being over-cautious.
> > 
> > Someone needs to think through the threat landscape and figure out what
> > permission checks are actually needed.
> > 
> > Making the permission check ns_capable instead of capable is a
> > no-brainer.  Figuring out which user_ns to test against might be a
> > we bit harder.
> > 
> > We could probably even allow the owner of the process to open the files
> > but that requires someone doing the work of thinking through how
> > being able to opening files that you have mmaped might be a problem.
> 
> As mentioned in the other thread, CRIU can work with read access to
> map_files.
> 
> > >> > There are probably a few more things guarded by CAP_SYS_ADMIN required
> > >> > to run checkpoint/restore as non-root,
> > >> 
> > >> If you need CAP_SYS_ADMIN anyway you're not gaining anything by
> > >> separating out CAP_RESTORE.
> > >
> > > No, as described we can checkpoint and restore a JVM with this patch and
> > > it also solves the problem the set_ns_last_pid fork() loop daemon tries
> > > to solve. It is not enough to support the full functionality of CRIU as
> > > map_files is also important, but we do not need CAP_SYS_ADMIN and
> > > CAP_RESTORE. Only CAP_RESTORE would be necessary.
> > >
> > > With a new capability users can enable checkpoint/restore as non-root
> > > without giving CRIU access to any of the other possibilities offered by
> > > CAP_SYS_ADMIN. Setting a PID and map_files have been introduced for CRIU
> > > and used to live behind CONFIG_CHECKPOINT_RESTORE. Having a capability
> > > for checkpoint/restore would make it easier for CRIU users to run it as
> > > non-root and make it very clear what is possible when giving CRIU the
> > > new capability. No other things would be allowed than necessary for
> > > checkpoint/restore. Setting a PID is most important for the restore part
> > > and reading map_files would be helpful during checkpoint. So it actually
> > > should be called CAP_CHECKPOINT_RESTORE as Christian mentioned in
> > > another email.
> > 
> > Please if one is for checkpoint and one is for restore asking for a pair
> > of capabilities is probably more appropriate.
> 
> I will send out a v2 with a renamed capability soon and also include
> map_files to be readable with that capability.
> 
> > >> >  but by applying this patch I can
> > >> > already checkpoint and restore processes as non-root. As there are
> > >> > already multiple workarounds I would prefer to do it correctly in the
> > >> > kernel to avoid that CRIU users are starting to invent more workarounds.
> > >> 
> > >> You've presented a couple of really inappropriate implementations
> > >> that would qualify as workarounds. But the other two are completely
> > >> appropriate within the system security policy. They don't "get around"
> > >> the problem, they use existing mechanisms as they are intended.
> > >
> > > I agree with the user namespace approach to be appropriate, but not the
> > > CAP_SYS_ADMIN approach as CRIU only needs a tiny subset (2 things) of
> > > what CAP_SYS_ADMIN allows.
> > 
> > 
> > If we are only talking 2 things can you please include in your patchset
> > a patch enabling those 2 things?
> 
> The two things are setting a PID via ns_last_pid/clone3() and reading
> map_files.
> 
> > But even more than this we need a request that asks not for the least
> > you can possibly ask for but asks for what you need to do a good job.
> 
> Also in this thread Kamil mentioned that they also need calling prctl
> with PR_SET_MM during restore in their production setup.

We're using that as well but it really feels like this:

	prctl_map = (struct prctl_mm_map){
	    .start_code = start_code,
	    .end_code = end_code,
	    .start_stack = start_stack,
	    .start_data = start_data,
	    .end_data = end_data,
	    .start_brk = start_brk,
	    .brk = brk_val,
	    .arg_start = arg_start,
	    .arg_end = arg_end,
	    .env_start = env_start,
	    .env_end = env_end,
	    .auxv = NULL,
	    .auxv_size = 0,
	    .exe_fd = -1,
	};

should belong under ns_capable(CAP_SYS_ADMIN). Why is that necessary to
relax?

> 
> > I am having visions of a recurring discussion that says can we add one
> > more permission check to CAP_RESTORE or CAP_CHECKPOINT when they are
> > things we could know today.
> 
> I will prepare a new version of this patch using CAP_CHECKPOINT_RESTORE
> for ns_last_pid/clone3(), map_files, and prctl with PR_SET_MM.
> 
> 		Adrian
> 
