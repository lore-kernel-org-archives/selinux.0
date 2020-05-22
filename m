Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E57FC433DF
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41ED2065F
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uDcA3Vkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgEVQko (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 12:40:44 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:43841
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730554AbgEVQkn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 12:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590165641; bh=Xw2P96rbQmAqG8GIuE4yFQtlbdSIZBZeNFLXzZSCBcw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uDcA3VkmHU2RcpLVBsa1nhTYXrzIFdQV7WpmBDP/2d7KW27x08aw8+2dqO3xsBtuw/of3VkHl1gU1HN7bvDxsn6/PwSeDReKBWXibjqW/hxBUU5mN5jbjmLUh53AjW/pONn+jIaA25ZG2aQFE8jZA8g0VQ+6hQB2doC39omXMI+7oSwfvo4SoIuqD28uNBSCQ5RuLyXl4WvzZ4mDsYKWDKzeFWqU6XUg172vmYrVzxDjgClLNq+1eq5tMCwT85DrtFpsSSQgV0kdWTr6Oor8ardsVyNsFbL7rLrAUH0OFjrYJFKcHqXLDyiBfpJg3UFHVKIkAcKjmNwgLnhl5Bua0Q==
X-YMail-OSG: U9L4NVYVM1mJSzo7UIzbVo4tn_yiEy_VbX9SRPiBjtce2m0B6tsr401hETX8ycx
 9sEFSDQmOoVdu4bziFtA3c306Ttx9WWfzWUf00asb.AolixC5P6ivWdAs50lz.VHsvE3E5ykce5c
 .CukD7xSWBgNGW.CwSKqCfQhOfBB6qQ1tht7Sxf01gVWUzCXhdFbx.uJaF1b8J3YnNXgYnyI1rK2
 vpExQmwSwLteFCyXM1bFAOhBS3oBg2CD2cshQ9AEINlFVm6ek5QDPwkNcWr379wQkZ3RMy0OeU1x
 Y9vD8xEKosdAkQL3RNo1L20Eu6mZerhMqKvBrxJ0U0YT.PVixZdffeSFjK9Ef8ba0Zmthy2cx.SQ
 RsXij8RaSxpq1h3GCrVRawhiXuE85DdeGtqOkfDds.cjA6Ce88k4U6RKGSXl2i4mCkCdH2xKfyn5
 ZSkPnaI9WuacwnPHw3X8Fv4nV4_n4y8w95FtfAng27Hxbw5YZWlxlq8B9.JzwAXPjYf53BHhUlfk
 7vvvuOIgw6QrxDHOtw1E8.Wshv9zrFOd6axVe3S0cQkH1AqvYcqF33MUL6KjK7ZmjkhU1lER0tBi
 buLjXGO4AL0xkFRSrIOlXa0eV2ryLDl5Dc6dkYHpeL.xVpBbr5E3pMeq0D7jfzhN9Q6UUd9tE7PM
 4VlrTIKoUz7t2NZtGuUr4s.ZJMtxYPd2HzxnWaeSMXK3d523aJHp2xi16lsN7vpHpw1uGpyEdE0Q
 njHa.MiXNX8JuVe.7v6S10yaUxO58m.2iAKgs72OJjQZjwLMHg7jLhA85QwGsl60fHuInw4x2Y3G
 nUeRGO6ZQFUyd_TWW9Cx7uSuLLN_6v78zQbwlAYFpR99OBhCU49EGbbzT2Z96z_CpqYqUSrOTK11
 6iv6t_hSAxVeyzYqNcf5MyptJuEW_cKJ83lvliE0hG.r43pPGy2M4EYtMHa3dWWfExMrR5X.YDlX
 xV0Eb66FvUXF91um0itvklHMa2q8bz_sDSAexZh9Ue.NOEJksuLP7v_1aJMssBteUJPRSk7KQVSQ
 _ZbxH4X2BE6Kia2DTRgmMLa0dTmiibgY42k1YVjbrFNzGa2_Z4wn6c7WRqIj5XMVY7UWNuCSbOp8
 Cm9UsA7XFUVXoAFrtkqXmXwAQev1B617hxdBxWIlKg.fpKp9YU9xOYlWTk9RTLuW.B7fFbFHM.Fr
 vKz75jpPhBkctE22nsDUcIaEO6sn4ZrZqiV2rcZZW0yMS0T8Dxe2w6uWyQd0_8vL2AhayKHmKWby
 iprntwBAmnr3RgN7f84560q9yZBH9y7GKxNi_Y9ZgJvSipXeernp1Tj9zxJ.8Mz6XBTApt2msfXk
 nH6jhsY_x_l4rHzjGyUjKr1toWHtfObj6FCsDhJNsP3qV_tYaeC9dw1Srwj9T8zwesk0Tu1a7HRb
 bfBMCnVy0VCQwkg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 22 May 2020 16:40:41 +0000
Received: by smtp431.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ff81859f5f285fa76c3e01bf86f1dffa;
          Fri, 22 May 2020 16:40:39 +0000 (UTC)
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
To:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
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
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200522055350.806609-1-areber@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
Date:   Fri, 22 May 2020 09:40:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522055350.806609-1-areber@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15959 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/21/2020 10:53 PM, Adrian Reber wrote:
> This enables CRIU to checkpoint and restore a process as non-root.

I know it sounds pedantic, but could you spell out CRIU once?
While I know that everyone who cares either knows or can guess
what you're talking about, it may be a mystery to some of the
newer kernel developers.

> Over the last years CRIU upstream has been asked a couple of time if it=

> is possible to checkpoint and restore a process as non-root. The answer=

> usually was: 'almost'.
>
> The main blocker to restore a process was that selecting the PID of the=

> restored process, which is necessary for CRIU, is guarded by CAP_SYS_AD=
MIN.

What are the other blockers? Are you going to suggest additional new
capabilities to clear them?

> In the last two years the questions about checkpoint/restore as non-roo=
t
> have increased and especially in the last few months we have seen
> multiple people inventing workarounds.

Giving a process CAP_SYS_ADMIN is a non-root solution.

> The use-cases so far and their workarounds:
>
>  * Checkpoint/Restore in an HPC environment in combination with
>    a resource manager distributing jobs. Users are always running
>    as non root, but there was the desire to provide a way to
>    checkpoint and restore long running jobs.
>    Workaround: setuid wrapper to start CRIU as root as non-root
>    https://github.com/FredHutch/slurm-examples/blob/master/checkpointer=
/lib/checkpointer/checkpointer-suid.c

This is a classic and well understood mechanism for dealing with
this kind of situation. You could have checkpointer-filecap-sys_admin.c
instead, if you want to reduce use of the super-user.

> * Another use case to checkpoint/restore processes as non-root
>    uses as workaround a non privileged process which cycles through
>    PIDs by calling fork() as fast as possible with a rate of
>    100,000 pids/s instead of writing to ns_last_pid
>    https://github.com/twosigma/set_ns_last_pid

Oh dear.

>  * Fast Java startup using checkpoint/restore.
>    We have been in contact with JVM developers who are integrating
>    CRIU into a JVM to decrease the startup time.
>    Workaround so far: patch out CAP_SYS_ADMIN checks in the kernel

That's not a workaround, it's a policy violation.
Bad JVM! No biscuit!

>  * Container migration as non root. There are people already
>    using CRIU to migrate containers as non-root. The solution
>    there is to run it in a user namespace. So if you are able
>    to carefully setup your environment with the namespaces
>    it is already possible to restore a container/process as non-root.

This is exactly the kind of situation that user namespaces are
supposed to address.

>    Unfortunately it is not always possible to setup an environment
>    in such a way and for easier access to non-root based container
>    migration this patch is also required.

If a user namespace solution is impossible or (more likely) too
expensive, there's always the checkpointer-filecap-sys_admin option.

> There are probably a few more things guarded by CAP_SYS_ADMIN required
> to run checkpoint/restore as non-root,

If you need CAP_SYS_ADMIN anyway you're not gaining anything by
separating out CAP_RESTORE.

>  but by applying this patch I can
> already checkpoint and restore processes as non-root. As there are
> already multiple workarounds I would prefer to do it correctly in the
> kernel to avoid that CRIU users are starting to invent more workarounds=
=2E

You've presented a couple of really inappropriate implementations
that would qualify as workarounds. But the other two are completely
appropriate within the system security policy. They don't "get around"
the problem, they use existing mechanisms as they are intended.



> I have used the following tests to verify that this change works as
> expected by setting the new capability CAP_RESTORE on the two resulting=

> test binaries:
>
> $ cat ns_last_pid.c
>  // http://efiop-notes.blogspot.com/2014/06/how-to-set-pid-using-nslast=
pid.html
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
> 	if (argc !=3D 2)
> 		return 1;
>
> 	printf("Opening ns_last_pid...\n");
> 	fd =3D open("/proc/sys/kernel/ns_last_pid", O_RDWR | O_CREAT, 0644);
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
> 	pid =3D atoi(argv[1]);
> 	snprintf(buf, sizeof(buf), "%d", pid - 1);
> 	printf("Writing pid-1 to ns_last_pid...\n");
> 	if (write(fd, buf, strlen(buf)) !=3D strlen(buf)) {
> 		printf("Cannot write to buf\n");
> 		return 1;
> 	}
>
> 	printf("Forking...\n");
> 	new_pid =3D fork();
> 	if (new_pid =3D=3D 0) {
> 		printf("I am the child!\n");
> 		exit(0);
> 	} else if (new_pid =3D=3D pid)
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
> 	struct clone_args c_args =3D { };
> 	pid_t pid, new_pid;
>
> 	if (argc !=3D 2)
> 		return 1;
>
> 	pid =3D atoi(argv[1]);
> 	c_args.set_tid =3D ptr_to_u64(&pid);
> 	c_args.set_tid_size =3D 1;
>
> 	printf("Forking...\n");
> 	new_pid =3D syscall(__NR_clone3, &c_args, sizeof(c_args));
> 	if (new_pid =3D=3D 0) {
> 		printf("I am the child!\n");
> 		exit(0);
> 	} else if (new_pid =3D=3D pid)
> 		printf("I am the parent. My child got the pid %d!\n", new_pid);
> 	else
> 		printf("pid (%d) does not match expected pid (%d)\n", new_pid, pid);
> 	printf("Done\n");
>
> 	return 0;
> }
> $ id -u; /home/libcap/clone3_set_tid 300000
> 1001
> Forking...
> I am the parent. My child got the pid 300000!
> Done
> I am the child!
>
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
>  include/linux/capability.h          | 5 +++++
>  include/uapi/linux/capability.h     | 9 ++++++++-
>  kernel/pid.c                        | 2 +-
>  kernel/pid_namespace.c              | 2 +-
>  security/selinux/include/classmap.h | 5 +++--
>  5 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index b4345b38a6be..1278313cb2bc 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -261,6 +261,11 @@ static inline bool bpf_capable(void)
>  	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
>  }
> =20
> +static inline bool restore_ns_capable(struct user_namespace *ns)
> +{
> +	return ns_capable(ns, CAP_RESTORE) || ns_capable(ns, CAP_SYS_ADMIN);
> +}
> +
>  /* audit system wants to get cap info from files as well */
>  extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct =
cpu_vfs_cap_data *cpu_caps);
> =20
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capab=
ility.h
> index c7372180a0a9..4bcc4e3d41ff 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -406,7 +406,14 @@ struct vfs_ns_cap_data {
>   */
>  #define CAP_BPF			39
> =20
> -#define CAP_LAST_CAP         CAP_BPF
> +
> +/* Allow checkpoint/restore related operations */
> +/* Allow PID selection during clone3() */
> +/* Allow writing to ns_last_pid */
> +
> +#define CAP_RESTORE		40
> +
> +#define CAP_LAST_CAP         CAP_RESTORE
> =20
>  #define cap_valid(x) ((x) >=3D 0 && (x) <=3D CAP_LAST_CAP)
> =20
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 3122043fe364..bbc26f2bcff6 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -198,7 +198,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid=
_t *set_tid,
>  			if (tid !=3D 1 && !tmp->child_reaper)
>  				goto out_free;
>  			retval =3D -EPERM;
> -			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> +			if (!restore_ns_capable(tmp->user_ns))
>  				goto out_free;
>  			set_tid_size--;
>  		}
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 0e5ac162c3a8..f58186b31ce6 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -269,7 +269,7 @@ static int pid_ns_ctl_handler(struct ctl_table *tab=
le, int write,
>  	struct ctl_table tmp =3D *table;
>  	int ret, next;
> =20
> -	if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> +	if (write && !restore_ns_capable(pid_ns->user_ns))
>  		return -EPERM;
> =20
>  	/*
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> index 98e1513b608a..f8b8f12a6ebd 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -27,9 +27,10 @@
>  	    "audit_control", "setfcap"
> =20
>  #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
> -		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf"
> +		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
> +		"restore"
> =20
> -#if CAP_LAST_CAP > CAP_BPF
> +#if CAP_LAST_CAP > CAP_RESTORE
>  #error New capability defined, please update COMMON_CAP2_PERMS.
>  #endif
> =20
>
> base-commit: e8f3274774b45b5f4e9e3d5cad7ff9f43ae3add5

