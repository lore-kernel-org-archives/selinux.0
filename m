Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09266C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 13:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22AF2078C
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 13:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEQnGAaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbgE0NtI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 09:49:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42877 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388330AbgE0NtH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 09:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590587344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C2XgrbWyeWmhTBon4jlf+BK2ICy50pSS6UZPrSr4h+g=;
        b=KEQnGAaZqVGF2/+a+miHqBTBIjc246MmF5cYhCGuXauoU6YskQ6eGjZeS/qvNZVx9HC8Xv
        rXL1jRNCKEevN0PHt6QjnXM+Yh3mDPqHLCSRLW+F2/m5Z/lbyzqd35lwoi5YTm6F8vbs/X
        PylwgaSuzVWBguvVygjldt6A2DGPVwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-TlVowUmZO2WDMzGhOeIIxA-1; Wed, 27 May 2020 09:48:59 -0400
X-MC-Unique: TlVowUmZO2WDMzGhOeIIxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D00C8014D4;
        Wed, 27 May 2020 13:48:55 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-113-73.ams2.redhat.com [10.36.113.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 058345C1C5;
        Wed, 27 May 2020 13:48:44 +0000 (UTC)
Date:   Wed, 27 May 2020 15:48:42 +0200
From:   Adrian Reber <areber@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
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
Message-ID: <20200527134842.GA250149@dcbz.redhat.com>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com>
 <a75f3f71-66cf-e615-2cd5-86ac65a3bbdc@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a75f3f71-66cf-e615-2cd5-86ac65a3bbdc@schaufler-ca.com>
X-Operating-System: Linux (5.6.11-300.fc32.x86_64)
X-Load-Average: 0.69 0.92 0.86
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 25, 2020 at 11:55:20AM -0700, Casey Schaufler wrote:
> On 5/25/2020 1:05 AM, Adrian Reber wrote:
> > On Fri, May 22, 2020 at 09:40:37AM -0700, Casey Schaufler wrote:
> >> On 5/21/2020 10:53 PM, Adrian Reber wrote:
> >>> This enables CRIU to checkpoint and restore a process as non-root.
> >> I know it sounds pedantic, but could you spell out CRIU once?
> >> While I know that everyone who cares either knows or can guess
> >> what you're talking about, it may be a mystery to some of the
> >> newer kernel developers.
> > Sure. CRIU - Checkpoint/Restore In Userspace.
> 
> Thanks. I blew out my acronym processor in the 1990's while
> working on trusted Unix system security evaluations.
> 
> >>> Over the last years CRIU upstream has been asked a couple of time if it
> >>> is possible to checkpoint and restore a process as non-root. The answer
> >>> usually was: 'almost'.
> >>>
> >>> The main blocker to restore a process was that selecting the PID of the
> >>> restored process, which is necessary for CRIU, is guarded by CAP_SYS_ADMIN.
> >> What are the other blockers? Are you going to suggest additional new
> >> capabilities to clear them?
> > As mentioned somewhere else access to /proc/<pid>/map_files/ would be
> > helpful. Right now I am testing with a JVM and it works without root
> > just with the attached patch. Without access to /proc/<pid>/map_files/
> > not everything CRIU can do will actually work, but we are a lot closer
> > to what our users have been asking for.
> 
> Are you talking about read access to map_files owned by other users
> or write access to map_files for the current user?

If I understand part of CRIU correctly, then we only need read-access
for the current user. I am sure Andrei, Pavel or Cyrill will correct me
if I am wrong concerning map_files.

> >>> In the last two years the questions about checkpoint/restore as non-root
> >>> have increased and especially in the last few months we have seen
> >>> multiple people inventing workarounds.
> >> Giving a process CAP_SYS_ADMIN is a non-root solution.
> > Yes, but like mentioned somewhere else not a solution that actually
> > works,
> 
> It's a solution that will execute and do what you're asking of it ...
> 
> >  because CAP_SYS_ADMIN allows too much.
> 
> ... but apparently not one that your users find satisfactory.
> 
> >  Especially for the
> > checkpoint/restore case, we really need one (setting the PID of a new
> > process) and to make it complete a second (reading map_files).
> >
> > Reading the comments in include/uapi/linux/capability.h concerning
> > CAP_SYS_ADMIN it allows the binary to do at least 35 things. The two
> > (three) I mentioned above (ns_last_pid (clone3) map_files) are not
> > mentioned in that list, so CAP_SYS_ADMIN allows probably much more.
> >
> > To allow checkpoint/restore as non-root nobody will give CRIU
> > CAP_SYS_ADMIN because it is too wide.
> 
> CAP_SYS_ADMIN exists for system behaviors that are not policy enforcement,
> but important to the system nonetheless. If you argue that checkpoint/restart
> is system policy enforcement rather then an administrative task it would
> be easier to sell.
> 
> Nobody likes CAP_SYS_ADMIN, but usually a process that does one of the
> things it covers will do more (sometimes many more) of the things it
> covers. The longstanding problem with breaking up CAP_SYS_ADMIN is that
> most breakouts result in programs that still need CAP_SYS_ADMIN anyway.
> 
> >>> The use-cases so far and their workarounds:
> >>>
> >>>  * Checkpoint/Restore in an HPC environment in combination with
> >>>    a resource manager distributing jobs. Users are always running
> >>>    as non root, but there was the desire to provide a way to
> >>>    checkpoint and restore long running jobs.
> >>>    Workaround: setuid wrapper to start CRIU as root as non-root
> >>>    https://github.com/FredHutch/slurm-examples/blob/master/checkpointer/lib/checkpointer/checkpointer-suid.c
> >> This is a classic and well understood mechanism for dealing with
> >> this kind of situation. You could have checkpointer-filecap-sys_admin.c
> >> instead, if you want to reduce use of the super-user.
> >>
> >>> * Another use case to checkpoint/restore processes as non-root
> >>>    uses as workaround a non privileged process which cycles through
> >>>    PIDs by calling fork() as fast as possible with a rate of
> >>>    100,000 pids/s instead of writing to ns_last_pid
> >>>    https://github.com/twosigma/set_ns_last_pid
> >> Oh dear.
> >>
> >>>  * Fast Java startup using checkpoint/restore.
> >>>    We have been in contact with JVM developers who are integrating
> >>>    CRIU into a JVM to decrease the startup time.
> >>>    Workaround so far: patch out CAP_SYS_ADMIN checks in the kernel
> >> That's not a workaround, it's a policy violation.
> >> Bad JVM! No biscuit!
> > This was used as a proof of concept to see if we can checkpoint and
> > restore a JVM without root. Only the ns_last_pid check was removed to
> > see if it works and it does.
> >
> >>>  * Container migration as non root. There are people already
> >>>    using CRIU to migrate containers as non-root. The solution
> >>>    there is to run it in a user namespace. So if you are able
> >>>    to carefully setup your environment with the namespaces
> >>>    it is already possible to restore a container/process as non-root.
> >> This is exactly the kind of situation that user namespaces are
> >> supposed to address.
> >>
> >>>    Unfortunately it is not always possible to setup an environment
> >>>    in such a way and for easier access to non-root based container
> >>>    migration this patch is also required.
> >> If a user namespace solution is impossible or (more likely) too
> >> expensive, there's always the checkpointer-filecap-sys_admin option.
> > But then again we open up all of CAP_SYS_ADMIN, which is not necessary.
> 
> Right, I understand that.
> 
> >>> There are probably a few more things guarded by CAP_SYS_ADMIN required
> >>> to run checkpoint/restore as non-root,
> >> If you need CAP_SYS_ADMIN anyway you're not gaining anything by
> >> separating out CAP_RESTORE.
> > No, as described we can checkpoint and restore a JVM with this patch and
> > it also solves the problem the set_ns_last_pid fork() loop daemon tries
> > to solve. It is not enough to support the full functionality of CRIU as
> > map_files is also important, but we do not need CAP_SYS_ADMIN and
> > CAP_RESTORE. Only CAP_RESTORE would be necessary.
> 
> Excellent!
> 
> Now, is there any reason other than your program that a process would
> use CAP_RESTORE? If a process has this capability what damage could it
> do to the system?

When I introduced clone3() with sett_tid to create process with a
certain PID I first did it without the CAP_SYS_ADMIN check and there
were concerns that this would make it too easy to re-use PIDs. If I
understood it correctly. So if you are only asking about the damage that
could be done to the system if any user can create a process with any
PID via ns_last_pid or clone3(), then the damage could be easy re-use of
PIDs and probably easier re-creation of re-use PID problems.

I cannot comment on what damage could be done by allowing read-access to
map_files. Eric commented in another part of the thread that he thinks
that it might not be necessary at all.

> > With a new capability users can enable checkpoint/restore as non-root
> > without giving CRIU access to any of the other possibilities offered by
> > CAP_SYS_ADMIN. Setting a PID and map_files have been introduced for CRIU
> > and used to live behind CONFIG_CHECKPOINT_RESTORE. Having a capability
> > for checkpoint/restore would make it easier for CRIU users to run it as
> > non-root and make it very clear what is possible when giving CRIU the
> > new capability. No other things would be allowed than necessary for
> > checkpoint/restore. Setting a PID is most important for the restore part
> > and reading map_files would be helpful during checkpoint. So it actually
> > should be called CAP_CHECKPOINT_RESTORE as Christian mentioned in
> > another email.
> >
> >>>  but by applying this patch I can
> >>> already checkpoint and restore processes as non-root. As there are
> >>> already multiple workarounds I would prefer to do it correctly in the
> >>> kernel to avoid that CRIU users are starting to invent more workarounds.
> >> You've presented a couple of really inappropriate implementations
> >> that would qualify as workarounds. But the other two are completely
> >> appropriate within the system security policy. They don't "get around"
> >> the problem, they use existing mechanisms as they are intended.
> > I agree with the user namespace approach to be appropriate, but not the
> > CAP_SYS_ADMIN approach as CRIU only needs a tiny subset (2 things) of
> > what CAP_SYS_ADMIN allows.
> >
> >>> I have used the following tests to verify that this change works as
> >>> expected by setting the new capability CAP_RESTORE on the two resulting
> >>> test binaries:
> >>>
> >>> $ cat ns_last_pid.c
> >>>  // http://efiop-notes.blogspot.com/2014/06/how-to-set-pid-using-nslastpid.html
> >>>  #include <stdio.h>
> >>>  #include <stdlib.h>
> >>>  #include <string.h>
> >>>  #include <sys/file.h>
> >>>  #include <sys/types.h>
> >>>  #include <unistd.h>
> >>>
> >>> int main(int argc, char *argv[])
> >>> {
> >>> 	pid_t pid, new_pid;
> >>> 	char buf[32];
> >>> 	int fd;
> >>>
> >>> 	if (argc != 2)
> >>> 		return 1;
> >>>
> >>> 	printf("Opening ns_last_pid...\n");
> >>> 	fd = open("/proc/sys/kernel/ns_last_pid", O_RDWR | O_CREAT, 0644);
> >>> 	if (fd < 0) {
> >>> 		perror("Cannot open ns_last_pid");
> >>> 		return 1;
> >>> 	}
> >>>
> >>> 	printf("Locking ns_last_pid...\n");
> >>> 	if (flock(fd, LOCK_EX)) {
> >>> 		close(fd);
> >>> 		printf("Cannot lock ns_last_pid\n");
> >>> 		return 1;
> >>> 	}
> >>>
> >>> 	pid = atoi(argv[1]);
> >>> 	snprintf(buf, sizeof(buf), "%d", pid - 1);
> >>> 	printf("Writing pid-1 to ns_last_pid...\n");
> >>> 	if (write(fd, buf, strlen(buf)) != strlen(buf)) {
> >>> 		printf("Cannot write to buf\n");
> >>> 		return 1;
> >>> 	}
> >>>
> >>> 	printf("Forking...\n");
> >>> 	new_pid = fork();
> >>> 	if (new_pid == 0) {
> >>> 		printf("I am the child!\n");
> >>> 		exit(0);
> >>> 	} else if (new_pid == pid)
> >>> 		printf("I am the parent. My child got the pid %d!\n", new_pid);
> >>> 	else
> >>> 		printf("pid (%d) does not match expected pid (%d)\n", new_pid, pid);
> >>>
> >>> 	printf("Cleaning up...\n");
> >>> 	if (flock(fd, LOCK_UN))
> >>> 		printf("Cannot unlock\n");
> >>> 	close(fd);
> >>> 	return 0;
> >>> }
> >>> $ id -u; /home/libcap/ns_last_pid 300000
> >>> 1001
> >>> Opening ns_last_pid...
> >>> Locking ns_last_pid...
> >>> Writing pid-1 to ns_last_pid...
> >>> Forking...
> >>> I am the parent. My child got the pid 300000!
> >>> I am the child!
> >>> Cleaning up...
> >>>
> >>> For the clone3() based approach:
> >>> $ cat clone3_set_tid.c
> >>>  #define _GNU_SOURCE
> >>>  #include <linux/sched.h>
> >>>  #include <stdint.h>
> >>>  #include <stdio.h>
> >>>  #include <stdlib.h>
> >>>  #include <string.h>
> >>>  #include <sys/types.h>
> >>>  #include <sys/stat.h>
> >>>  #include <sys/syscall.h>
> >>>  #include <unistd.h>
> >>>
> >>>  #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
> >>>
> >>> int main(int argc, char *argv[])
> >>> {
> >>> 	struct clone_args c_args = { };
> >>> 	pid_t pid, new_pid;
> >>>
> >>> 	if (argc != 2)
> >>> 		return 1;
> >>>
> >>> 	pid = atoi(argv[1]);
> >>> 	c_args.set_tid = ptr_to_u64(&pid);
> >>> 	c_args.set_tid_size = 1;
> >>>
> >>> 	printf("Forking...\n");
> >>> 	new_pid = syscall(__NR_clone3, &c_args, sizeof(c_args));
> >>> 	if (new_pid == 0) {
> >>> 		printf("I am the child!\n");
> >>> 		exit(0);
> >>> 	} else if (new_pid == pid)
> >>> 		printf("I am the parent. My child got the pid %d!\n", new_pid);
> >>> 	else
> >>> 		printf("pid (%d) does not match expected pid (%d)\n", new_pid, pid);
> >>> 	printf("Done\n");
> >>>
> >>> 	return 0;
> >>> }
> >>> $ id -u; /home/libcap/clone3_set_tid 300000
> >>> 1001
> >>> Forking...
> >>> I am the parent. My child got the pid 300000!
> >>> Done
> >>> I am the child!
> >>>
> >>> Signed-off-by: Adrian Reber <areber@redhat.com>
> >>> ---
> >>>  include/linux/capability.h          | 5 +++++
> >>>  include/uapi/linux/capability.h     | 9 ++++++++-
> >>>  kernel/pid.c                        | 2 +-
> >>>  kernel/pid_namespace.c              | 2 +-
> >>>  security/selinux/include/classmap.h | 5 +++--
> >>>  5 files changed, 18 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/include/linux/capability.h b/include/linux/capability.h
> >>> index b4345b38a6be..1278313cb2bc 100644
> >>> --- a/include/linux/capability.h
> >>> +++ b/include/linux/capability.h
> >>> @@ -261,6 +261,11 @@ static inline bool bpf_capable(void)
> >>>  	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
> >>>  }
> >>>  
> >>> +static inline bool restore_ns_capable(struct user_namespace *ns)
> >>> +{
> >>> +	return ns_capable(ns, CAP_RESTORE) || ns_capable(ns, CAP_SYS_ADMIN);
> >>> +}
> >>> +
> >>>  /* audit system wants to get cap info from files as well */
> >>>  extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
> >>>  
> >>> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> >>> index c7372180a0a9..4bcc4e3d41ff 100644
> >>> --- a/include/uapi/linux/capability.h
> >>> +++ b/include/uapi/linux/capability.h
> >>> @@ -406,7 +406,14 @@ struct vfs_ns_cap_data {
> >>>   */
> >>>  #define CAP_BPF			39
> >>>  
> >>> -#define CAP_LAST_CAP         CAP_BPF
> >>> +
> >>> +/* Allow checkpoint/restore related operations */
> >>> +/* Allow PID selection during clone3() */
> >>> +/* Allow writing to ns_last_pid */
> >>> +
> >>> +#define CAP_RESTORE		40
> >>> +
> >>> +#define CAP_LAST_CAP         CAP_RESTORE
> >>>  
> >>>  #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
> >>>  
> >>> diff --git a/kernel/pid.c b/kernel/pid.c
> >>> index 3122043fe364..bbc26f2bcff6 100644
> >>> --- a/kernel/pid.c
> >>> +++ b/kernel/pid.c
> >>> @@ -198,7 +198,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
> >>>  			if (tid != 1 && !tmp->child_reaper)
> >>>  				goto out_free;
> >>>  			retval = -EPERM;
> >>> -			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> >>> +			if (!restore_ns_capable(tmp->user_ns))
> >>>  				goto out_free;
> >>>  			set_tid_size--;
> >>>  		}
> >>> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> >>> index 0e5ac162c3a8..f58186b31ce6 100644
> >>> --- a/kernel/pid_namespace.c
> >>> +++ b/kernel/pid_namespace.c
> >>> @@ -269,7 +269,7 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
> >>>  	struct ctl_table tmp = *table;
> >>>  	int ret, next;
> >>>  
> >>> -	if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> >>> +	if (write && !restore_ns_capable(pid_ns->user_ns))
> >>>  		return -EPERM;
> >>>  
> >>>  	/*
> >>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> >>> index 98e1513b608a..f8b8f12a6ebd 100644
> >>> --- a/security/selinux/include/classmap.h
> >>> +++ b/security/selinux/include/classmap.h
> >>> @@ -27,9 +27,10 @@
> >>>  	    "audit_control", "setfcap"
> >>>  
> >>>  #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
> >>> -		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf"
> >>> +		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
> >>> +		"restore"
> >>>  
> >>> -#if CAP_LAST_CAP > CAP_BPF
> >>> +#if CAP_LAST_CAP > CAP_RESTORE
> >>>  #error New capability defined, please update COMMON_CAP2_PERMS.
> >>>  #endif
> >>>  
> >>>
> >>> base-commit: e8f3274774b45b5f4e9e3d5cad7ff9f43ae3add5
> 

