Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B2C433E0
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 00:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC19C20801
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 00:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFLARK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:17:10 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:53937 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbgFLARK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 20:17:10 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 11 Jun 2020 17:17:05 -0700
Received: from localhost (unknown [10.200.193.92])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 7A01A40CBD;
        Thu, 11 Jun 2020 17:17:09 -0700 (PDT)
Date:   Thu, 11 Jun 2020 17:17:09 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Adrian Reber <areber@redhat.com>
CC:     Christian Brauner <christian.brauner@ubuntu.com>,
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
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
Message-ID: <20200612001709.GA25598@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>, Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>, Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
References: <20200522055350.806609-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200522055350.806609-1-areber@redhat.com>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
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
> 
> I have used the following tests to verify that this change works as
> expected by setting the new capability CAP_RESTORE on the two resulting
> test binaries:
> 
> $ cat ns_last_pid.c
>  // http://efiop-notes.blogspot.com/2014/06/how-to-set-pid-using-nslastpid.html
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/file.h>
>  #include <sys/types.h>
>  #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
> 	pid_t pid, new_pid;
> 	char buf[32];
> 	int fd;
> 
> 	if (argc != 2)
> 		return 1;
> 
> 	printf("Opening ns_last_pid...\n");
> 	fd = open("/proc/sys/kernel/ns_last_pid", O_RDWR | O_CREAT, 0644);
> 	if (fd < 0) {
> 		perror("Cannot open ns_last_pid");
> 		return 1;
> 	}
> 
> 	printf("Locking ns_last_pid...\n");
> 	if (flock(fd, LOCK_EX)) {
> 		close(fd);
> 		printf("Cannot lock ns_last_pid\n");
> 		return 1;
> 	}
> 
> 	pid = atoi(argv[1]);
> 	snprintf(buf, sizeof(buf), "%d", pid - 1);
> 	printf("Writing pid-1 to ns_last_pid...\n");
> 	if (write(fd, buf, strlen(buf)) != strlen(buf)) {
> 		printf("Cannot write to buf\n");
> 		return 1;
> 	}
> 
> 	printf("Forking...\n");
> 	new_pid = fork();
> 	if (new_pid == 0) {
> 		printf("I am the child!\n");
> 		exit(0);
> 	} else if (new_pid == pid)
> 		printf("I am the parent. My child got the pid %d!\n", new_pid);
> 	else
> 		printf("pid (%d) does not match expected pid (%d)\n", new_pid, pid);
> 
> 	printf("Cleaning up...\n");
> 	if (flock(fd, LOCK_UN))
> 		printf("Cannot unlock\n");
> 	close(fd);
> 	return 0;
> }
> $ id -u; /home/libcap/ns_last_pid 300000
> 1001
> Opening ns_last_pid...
> Locking ns_last_pid...
> Writing pid-1 to ns_last_pid...
> Forking...
> I am the parent. My child got the pid 300000!
> I am the child!
> Cleaning up...
> 
> For the clone3() based approach:
> $ cat clone3_set_tid.c
>  #define _GNU_SOURCE
>  #include <linux/sched.h>
>  #include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/syscall.h>
>  #include <unistd.h>
> 
>  #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
> 
> int main(int argc, char *argv[])
> {
> 	struct clone_args c_args = { };
> 	pid_t pid, new_pid;
> 
> 	if (argc != 2)
> 		return 1;
> 
> 	pid = atoi(argv[1]);
> 	c_args.set_tid = ptr_to_u64(&pid);
> 	c_args.set_tid_size = 1;
> 
> 	printf("Forking...\n");
> 	new_pid = syscall(__NR_clone3, &c_args, sizeof(c_args));

(Note: I'm going to call the capability CAP_RESTORE but I think this
applies regardless of whether the permissions stay with CAP_SYS_ADMIN..)

I haven't fully reviewed the discussion of the security consequences but
my sense is this would require retaining CAP_RESTORE down the entire tree
of processes being restored so each parent could call clone3() with the
correct pid value for its child(ren).

Ideally you would drop CAP_RESTORE sooner -- preferrably only one
process would need it. I think you could do that by changing what you pass
down; instead of passing down a capability and a pid number, pass down a
special "reservation" pidfd:

1. Have CAP_RESTORE enable opening a pidfd with the desired pid as a
   reservation for the pid (i.e. can't use it to signal, wait, ...
   perhaps these return -EBUSY, -EAGAIN or something...).

2. Only one process needs CAP_RESTORE -- it can drop CAP_RESTORE after
   reserving all of the pids but before kicking off the clone3() calls
   to recreate all of the tasks.

3. Pass the pidfd down the tree of restoring processes. Note how the
   set of specific pids to be created is limited at this point --
   the software cannot be tricked into recreating processes other pids
   using a capability, CAP_RESTORE, it doesn't have. You might even set a
   flag on the pidfd which closes the pidfd in the sender when it's passed
   over a socket so that only the appropriate processes retain the pidfd.

4. The parent can then pass the *reserved* pidfd into clone3(). The
   reserved pidfd seamlessly turns into a pidfd reference to the child if
   clone3() succeeds. If it fails the eservation is still consumed -- a
   given pidfd reserved for clone3() can only be passed to clone3() and
   succeed once.

Perhaps this scheme could concentrate the need for CAP_SYS_ADMIN
to one process so maybe it would obviate the need for CAP_RESTORE.
That said, perhaps there's something that prevents implementing such
a pidfd or perhaps I have misunderstood what CRIU is doing and this
pidfd idea isn't workable.

Cheers,
    -Matt Helsley
