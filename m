Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D447C433DF
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 14:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289A3206A4
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 14:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFLOkL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:40:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38269 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgFLOkL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 10:40:11 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jjkq7-0002Hn-Tq; Fri, 12 Jun 2020 14:39:28 +0000
Date:   Fri, 12 Jun 2020 16:39:26 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
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
Message-ID: <20200612143926.ingimdxctgpffkm6@wittgenstein>
References: <20200522055350.806609-1-areber@redhat.com>
 <20200612001709.GA25598@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200612001709.GA25598@rlwimi.vmware.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 05:17:09PM -0700, Matt Helsley wrote:
> On Fri, May 22, 2020 at 07:53:50AM +0200, Adrian Reber wrote:
> > This enables CRIU to checkpoint and restore a process as non-root.
> > 
> > Over the last years CRIU upstream has been asked a couple of time if it
> > is possible to checkpoint and restore a process as non-root. The answer
> > usually was: 'almost'.
> > 
> > The main blocker to restore a process was that selecting the PID of the
> > restored process, which is necessary for CRIU, is guarded by CAP_SYS_ADMIN.
> > 
> > In the last two years the questions about checkpoint/restore as non-root
> > have increased and especially in the last few months we have seen
> > multiple people inventing workarounds.
> > 
> > The use-cases so far and their workarounds:
> > 
> >  * Checkpoint/Restore in an HPC environment in combination with
> >    a resource manager distributing jobs. Users are always running
> >    as non root, but there was the desire to provide a way to
> >    checkpoint and restore long running jobs.
> >    Workaround: setuid wrapper to start CRIU as root as non-root
> >    https://github.com/FredHutch/slurm-examples/blob/master/checkpointer/lib/checkpointer/checkpointer-suid.c
> >  * Another use case to checkpoint/restore processes as non-root
> >    uses as workaround a non privileged process which cycles through
> >    PIDs by calling fork() as fast as possible with a rate of
> >    100,000 pids/s instead of writing to ns_last_pid
> >    https://github.com/twosigma/set_ns_last_pid
> >  * Fast Java startup using checkpoint/restore.
> >    We have been in contact with JVM developers who are integrating
> >    CRIU into a JVM to decrease the startup time.
> >    Workaround so far: patch out CAP_SYS_ADMIN checks in the kernel
> >  * Container migration as non root. There are people already
> >    using CRIU to migrate containers as non-root. The solution
> >    there is to run it in a user namespace. So if you are able
> >    to carefully setup your environment with the namespaces
> >    it is already possible to restore a container/process as non-root.
> >    Unfortunately it is not always possible to setup an environment
> >    in such a way and for easier access to non-root based container
> >    migration this patch is also required.
> > 
> > There are probably a few more things guarded by CAP_SYS_ADMIN required
> > to run checkpoint/restore as non-root, but by applying this patch I can
> > already checkpoint and restore processes as non-root. As there are
> > already multiple workarounds I would prefer to do it correctly in the
> > kernel to avoid that CRIU users are starting to invent more workarounds.
> > 
> > I have used the following tests to verify that this change works as
> > expected by setting the new capability CAP_RESTORE on the two resulting
> > test binaries:
> > 
> > $ cat ns_last_pid.c
> >  // http://efiop-notes.blogspot.com/2014/06/how-to-set-pid-using-nslastpid.html
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <sys/file.h>
> >  #include <sys/types.h>
> >  #include <unistd.h>
> > 
> > int main(int argc, char *argv[])
> > {
> > 	pid_t pid, new_pid;
> > 	char buf[32];
> > 	int fd;
> > 
> > 	if (argc != 2)
> > 		return 1;
> > 
> > 	printf("Opening ns_last_pid...\n");
> > 	fd = open("/proc/sys/kernel/ns_last_pid", O_RDWR | O_CREAT, 0644);
> > 	if (fd < 0) {
> > 		perror("Cannot open ns_last_pid");
> > 		return 1;
> > 	}
> > 
> > 	printf("Locking ns_last_pid...\n");
> > 	if (flock(fd, LOCK_EX)) {
> > 		close(fd);
> > 		printf("Cannot lock ns_last_pid\n");
> > 		return 1;
> > 	}
> > 
> > 	pid = atoi(argv[1]);
> > 	snprintf(buf, sizeof(buf), "%d", pid - 1);
> > 	printf("Writing pid-1 to ns_last_pid...\n");
> > 	if (write(fd, buf, strlen(buf)) != strlen(buf)) {
> > 		printf("Cannot write to buf\n");
> > 		return 1;
> > 	}
> > 
> > 	printf("Forking...\n");
> > 	new_pid = fork();
> > 	if (new_pid == 0) {
> > 		printf("I am the child!\n");
> > 		exit(0);
> > 	} else if (new_pid == pid)
> > 		printf("I am the parent. My child got the pid %d!\n", new_pid);
> > 	else
> > 		printf("pid (%d) does not match expected pid (%d)\n", new_pid, pid);
> > 
> > 	printf("Cleaning up...\n");
> > 	if (flock(fd, LOCK_UN))
> > 		printf("Cannot unlock\n");
> > 	close(fd);
> > 	return 0;
> > }
> > $ id -u; /home/libcap/ns_last_pid 300000
> > 1001
> > Opening ns_last_pid...
> > Locking ns_last_pid...
> > Writing pid-1 to ns_last_pid...
> > Forking...
> > I am the parent. My child got the pid 300000!
> > I am the child!
> > Cleaning up...
> > 
> > For the clone3() based approach:
> > $ cat clone3_set_tid.c
> >  #define _GNU_SOURCE
> >  #include <linux/sched.h>
> >  #include <stdint.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> >  #include <sys/syscall.h>
> >  #include <unistd.h>
> > 
> >  #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
> > 
> > int main(int argc, char *argv[])
> > {
> > 	struct clone_args c_args = { };
> > 	pid_t pid, new_pid;
> > 
> > 	if (argc != 2)
> > 		return 1;
> > 
> > 	pid = atoi(argv[1]);
> > 	c_args.set_tid = ptr_to_u64(&pid);
> > 	c_args.set_tid_size = 1;
> > 
> > 	printf("Forking...\n");
> > 	new_pid = syscall(__NR_clone3, &c_args, sizeof(c_args));
> 
> (Note: I'm going to call the capability CAP_RESTORE but I think this
> applies regardless of whether the permissions stay with CAP_SYS_ADMIN..)
> 
> I haven't fully reviewed the discussion of the security consequences but
> my sense is this would require retaining CAP_RESTORE down the entire tree
> of processes being restored so each parent could call clone3() with the
> correct pid value for its child(ren).

If criu restores a process tree you need to have the required capability
in the starting user namespace and by design this means you also have it
automatically in all child user namespaces. Let alone that if you/criu
created the user namespace you have full privileges over it anway.
While criu restores a process tree it needs to retain its privilege
level. The individual tasks in the process tree that criu restores will
obviously be restored with the creds they were checkpointed with so it's
not like any of them inherit any capabilities they didn't already have
after criu finishes. So I don't see why any of this would be a problem.
Restoring into a (pre-existing) pid namespace hierarchy is another
problem but how this can be solved using the set_tid array was outlined
during Plumbers last year; one of the reasons this is an array.

> 
> Ideally you would drop CAP_RESTORE sooner -- preferrably only one
> process would need it. I think you could do that by changing what you pass
> down; instead of passing down a capability and a pid number, pass down a
> special "reservation" pidfd:

I'm sorry, but nack.
We're not going to do shenaningans like that with pidfds and clone3()
just to cater to this specific use-case that is solvable in less hacky
ways.

Thanks!
Christian
