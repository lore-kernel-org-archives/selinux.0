Return-Path: <SRS0=axcH=7H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D38C433E0
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E552068D
	for <selinux@archiver.kernel.org>; Mon, 25 May 2020 18:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="byD1PAKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389671AbgEYSz2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 May 2020 14:55:28 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:42634
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389649AbgEYSz2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 May 2020 14:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590432923; bh=rIZwYNBEVPYdf7In4v7fGrvpNtxcsxeBWT/oII+aleU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=byD1PAKHcTjuTwu7tEXnhv1GyfW1eVpFDO9ibGprDjOBrL1eomFRUnrgGl2Eqs7RMa93Yi31cPzY3OI6bELnjHi3i0/2W00+MrWLjS8kPLtiJ4cnt8p5+vCcy4coxqQvs1F3t9GbyODCEEmHM8wqszXRWUYqH49YLsgEx1SpyHrHMqxf9YQG41huqrb8Z5nn7lEgFshmCV7nhVZ3pyHzJp+Ht3SMS6F6TCGcVmMAV3D/Ebf6mZAPOhihnKuv3Up3dyt2p5Bbe0TeYrLx1I8Wdl5lPT+1pc5L3a/pHOCcWWgukdv9NpxuxqlBBO1duU3jtEJf7BGrJhDLejUmmIIAcA==
X-YMail-OSG: YOhWGGQVM1kja2z4p2PZAyE5up9mu3McLWF5JYRL247KBco_3csIkQzSFdKJc8B
 dvnB0bNW7YoBhOb_7N3utJkFcz772rRDwJnVSnSrp55vBJG03nX_dz7F3YTWnzPX7AcgHls06yjw
 Eu_1eYpRBL22.D5J99rIUsOfYnk4AueZgbvhpx9a0gnJGNOp2yMbiXxfgSYNfLSqBqX96MY4.Pfz
 l49m89771FE1jRHIr2xkENQ_lHJ9DDrF.c1RWmK6kiWVOk9Rb7_EsYI4fgvSHqtMDsHtjky14zvI
 2JdlLgGiATaQdSddRJZB1rb81bzDRTDwL5McYqOKv.uqEFCYqlzWKLtiySKGZMERH_WqoIa53gdM
 UsqS3JZ4s4XsA3kjB9T2KWPtHW0dxrRRadnfA_6L5Np0X69JR5_Mgj4QGEgkigb.6q3_n7TxgdaT
 4nhm_hxIPdrGvDzPeW6JaThuttOfK4Hh7BeAInyqwE776LQ0gEeJ_882lUJ4YuLENdtTXRLnkZzK
 IzVoMykXsYSyvxslYwlfWozST97R0Q.Pxu4ybI54_0F6fkeszuBW0G1_X7g9apWj6Y2TXRNinzzA
 wf7SRhgIYepR.iNV40isjN5MOGmH7DI3BGZzvRUK0Q2PyVCSrf5kGIqEFMc54vQXtWWcU4ggj1Pa
 j8Ve_dJt0gfdrOjXw64eVUy7_.aPZDjrqIt58I8UV6edg7uO3Dihc3jycAe.kaWR8RGoVL1EwNHS
 5vAkUFn643MofgbeMPNPOt5IxkW5zbFg1m59hdb.PYZn.o0.7HA1fHJ8AJzI7ErMTR6CkV54jWJf
 04XNMT0skRFax_oYdFUncL1qCIS7vzECWK4fzDwe.HMvYalpjy9YC4D42_cFtTf3AZ4ZbMvRgmOC
 tkKvoIMHj0xFlfNWAwC_kHvhW0WHAPAH4fLFuEba0u8EVrykbHkmRPVmaXEs7ai9mKic7ZCAcpze
 a8z0_EQlG5njgRdtyu0mIwPfb3EV9Rq2xkh3WJjM1JmA.VTMSDyqujNxwON7KWZapZUL9UlUlv6S
 7vlBk1pAgEr82Gx88DK4Smp3_RRb3JidhI.Gs0TnDJf6Qh3wnPlyr4fApSahLpna.w0K6FvfQetQ
 9dnDZG.IeBKKhUdIbScMF9iAk0DigI2_Ak0amCc086L0_GyZ0j.cyg_Jwu.HNX5jmoxV3MjfhpB.
 CxfQ.ieVHUd1lnvYBAJy3rccs6OQo4u9UNfbaoAb9BruQNAALWhOkk7j5yn3FbqWH0lKt2B8bKd2
 BUFDc1pIw5Et3.7M9mIJAss3Mx55zCYG.D_VfXvqxjDQAWfy22bIJ00BNQqzf0Szhv3.JqV0.ssd
 YPRL0QcQSeRQYSrpjT7jL4j52qidZK9VQ1HoYeo5e7HzYQdG58ewLkX3Z5neT2713xh6t.zBb1Ti
 HqA8_jjd2InoHUPgEGm2imx8xPfzvVGX4KLDqdIBWcZZKJqwGFY8fbSF8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 May 2020 18:55:23 +0000
Received: by smtp401.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7162f71db2ddca18bb72ea8172004e45;
          Mon, 25 May 2020 18:55:22 +0000 (UTC)
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
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
        Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200522055350.806609-1-areber@redhat.com>
 <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
 <20200525080541.GF104922@dcbz.redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a75f3f71-66cf-e615-2cd5-86ac65a3bbdc@schaufler-ca.com>
Date:   Mon, 25 May 2020 11:55:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525080541.GF104922@dcbz.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15960 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/14)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/25/2020 1:05 AM, Adrian Reber wrote:
> On Fri, May 22, 2020 at 09:40:37AM -0700, Casey Schaufler wrote:
>> On 5/21/2020 10:53 PM, Adrian Reber wrote:
>>> This enables CRIU to checkpoint and restore a process as non-root.
>> I know it sounds pedantic, but could you spell out CRIU once?
>> While I know that everyone who cares either knows or can guess
>> what you're talking about, it may be a mystery to some of the
>> newer kernel developers.
> Sure. CRIU - Checkpoint/Restore In Userspace.

Thanks. I blew out my acronym processor in the 1990's while
working on trusted Unix system security evaluations.

>>> Over the last years CRIU upstream has been asked a couple of time if =
it
>>> is possible to checkpoint and restore a process as non-root. The answ=
er
>>> usually was: 'almost'.
>>>
>>> The main blocker to restore a process was that selecting the PID of t=
he
>>> restored process, which is necessary for CRIU, is guarded by CAP_SYS_=
ADMIN.
>> What are the other blockers? Are you going to suggest additional new
>> capabilities to clear them?
> As mentioned somewhere else access to /proc/<pid>/map_files/ would be
> helpful. Right now I am testing with a JVM and it works without root
> just with the attached patch. Without access to /proc/<pid>/map_files/
> not everything CRIU can do will actually work, but we are a lot closer
> to what our users have been asking for.

Are you talking about read access to map_files owned by other users
or write access to map_files for the current user?
=C2=A0

>>> In the last two years the questions about checkpoint/restore as non-r=
oot
>>> have increased and especially in the last few months we have seen
>>> multiple people inventing workarounds.
>> Giving a process CAP_SYS_ADMIN is a non-root solution.
> Yes, but like mentioned somewhere else not a solution that actually
> works,

It's a solution that will execute and do what you're asking of it ...

>  because CAP_SYS_ADMIN allows too much.

=2E.. but apparently not one that your users find satisfactory.

>  Especially for the
> checkpoint/restore case, we really need one (setting the PID of a new
> process) and to make it complete a second (reading map_files).
>
> Reading the comments in include/uapi/linux/capability.h concerning
> CAP_SYS_ADMIN it allows the binary to do at least 35 things. The two
> (three) I mentioned above (ns_last_pid (clone3) map_files) are not
> mentioned in that list, so CAP_SYS_ADMIN allows probably much more.
>
> To allow checkpoint/restore as non-root nobody will give CRIU
> CAP_SYS_ADMIN because it is too wide.

CAP_SYS_ADMIN exists for system behaviors that are not policy enforcement=
,
but important to the system nonetheless. If you argue that checkpoint/res=
tart
is system policy enforcement rather then an administrative task it would
be easier to sell.

Nobody likes CAP_SYS_ADMIN, but usually a process that does one of the
things it covers will do more (sometimes many more) of the things it
covers. The longstanding problem with breaking up CAP_SYS_ADMIN is that
most breakouts result in programs that still need CAP_SYS_ADMIN anyway.

>>> The use-cases so far and their workarounds:
>>>
>>>  * Checkpoint/Restore in an HPC environment in combination with
>>>    a resource manager distributing jobs. Users are always running
>>>    as non root, but there was the desire to provide a way to
>>>    checkpoint and restore long running jobs.
>>>    Workaround: setuid wrapper to start CRIU as root as non-root
>>>    https://github.com/FredHutch/slurm-examples/blob/master/checkpoint=
er/lib/checkpointer/checkpointer-suid.c
>> This is a classic and well understood mechanism for dealing with
>> this kind of situation. You could have checkpointer-filecap-sys_admin.=
c
>> instead, if you want to reduce use of the super-user.
>>
>>> * Another use case to checkpoint/restore processes as non-root
>>>    uses as workaround a non privileged process which cycles through
>>>    PIDs by calling fork() as fast as possible with a rate of
>>>    100,000 pids/s instead of writing to ns_last_pid
>>>    https://github.com/twosigma/set_ns_last_pid
>> Oh dear.
>>
>>>  * Fast Java startup using checkpoint/restore.
>>>    We have been in contact with JVM developers who are integrating
>>>    CRIU into a JVM to decrease the startup time.
>>>    Workaround so far: patch out CAP_SYS_ADMIN checks in the kernel
>> That's not a workaround, it's a policy violation.
>> Bad JVM! No biscuit!
> This was used as a proof of concept to see if we can checkpoint and
> restore a JVM without root. Only the ns_last_pid check was removed to
> see if it works and it does.
>
>>>  * Container migration as non root. There are people already
>>>    using CRIU to migrate containers as non-root. The solution
>>>    there is to run it in a user namespace. So if you are able
>>>    to carefully setup your environment with the namespaces
>>>    it is already possible to restore a container/process as non-root.=

>> This is exactly the kind of situation that user namespaces are
>> supposed to address.
>>
>>>    Unfortunately it is not always possible to setup an environment
>>>    in such a way and for easier access to non-root based container
>>>    migration this patch is also required.
>> If a user namespace solution is impossible or (more likely) too
>> expensive, there's always the checkpointer-filecap-sys_admin option.
> But then again we open up all of CAP_SYS_ADMIN, which is not necessary.=


Right, I understand that.

>>> There are probably a few more things guarded by CAP_SYS_ADMIN require=
d
>>> to run checkpoint/restore as non-root,
>> If you need CAP_SYS_ADMIN anyway you're not gaining anything by
>> separating out CAP_RESTORE.
> No, as described we can checkpoint and restore a JVM with this patch an=
d
> it also solves the problem the set_ns_last_pid fork() loop daemon tries=

> to solve. It is not enough to support the full functionality of CRIU as=

> map_files is also important, but we do not need CAP_SYS_ADMIN and
> CAP_RESTORE. Only CAP_RESTORE would be necessary.

Excellent!

Now, is there any reason other than your program that a process would
use CAP_RESTORE? If a process has this capability what damage could it
do to the system?

>
> With a new capability users can enable checkpoint/restore as non-root
> without giving CRIU access to any of the other possibilities offered by=

> CAP_SYS_ADMIN. Setting a PID and map_files have been introduced for CRI=
U
> and used to live behind CONFIG_CHECKPOINT_RESTORE. Having a capability
> for checkpoint/restore would make it easier for CRIU users to run it as=

> non-root and make it very clear what is possible when giving CRIU the
> new capability. No other things would be allowed than necessary for
> checkpoint/restore. Setting a PID is most important for the restore par=
t
> and reading map_files would be helpful during checkpoint. So it actuall=
y
> should be called CAP_CHECKPOINT_RESTORE as Christian mentioned in
> another email.
>
>>>  but by applying this patch I can
>>> already checkpoint and restore processes as non-root. As there are
>>> already multiple workarounds I would prefer to do it correctly in the=

>>> kernel to avoid that CRIU users are starting to invent more workaroun=
ds.
>> You've presented a couple of really inappropriate implementations
>> that would qualify as workarounds. But the other two are completely
>> appropriate within the system security policy. They don't "get around"=

>> the problem, they use existing mechanisms as they are intended.
> I agree with the user namespace approach to be appropriate, but not the=

> CAP_SYS_ADMIN approach as CRIU only needs a tiny subset (2 things) of
> what CAP_SYS_ADMIN allows.
>
>>> I have used the following tests to verify that this change works as
>>> expected by setting the new capability CAP_RESTORE on the two resulti=
ng
>>> test binaries:
>>>
>>> $ cat ns_last_pid.c
>>>  // http://efiop-notes.blogspot.com/2014/06/how-to-set-pid-using-nsla=
stpid.html
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <string.h>
>>>  #include <sys/file.h>
>>>  #include <sys/types.h>
>>>  #include <unistd.h>
>>>
>>> int main(int argc, char *argv[])
>>> {
>>> 	pid_t pid, new_pid;
>>> 	char buf[32];
>>> 	int fd;
>>>
>>> 	if (argc !=3D 2)
>>> 		return 1;
>>>
>>> 	printf("Opening ns_last_pid...\n");
>>> 	fd =3D open("/proc/sys/kernel/ns_last_pid", O_RDWR | O_CREAT, 0644);=

>>> 	if (fd < 0) {
>>> 		perror("Cannot open ns_last_pid");
>>> 		return 1;
>>> 	}
>>>
>>> 	printf("Locking ns_last_pid...\n");
>>> 	if (flock(fd, LOCK_EX)) {
>>> 		close(fd);
>>> 		printf("Cannot lock ns_last_pid\n");
>>> 		return 1;
>>> 	}
>>>
>>> 	pid =3D atoi(argv[1]);
>>> 	snprintf(buf, sizeof(buf), "%d", pid - 1);
>>> 	printf("Writing pid-1 to ns_last_pid...\n");
>>> 	if (write(fd, buf, strlen(buf)) !=3D strlen(buf)) {
>>> 		printf("Cannot write to buf\n");
>>> 		return 1;
>>> 	}
>>>
>>> 	printf("Forking...\n");
>>> 	new_pid =3D fork();
>>> 	if (new_pid =3D=3D 0) {
>>> 		printf("I am the child!\n");
>>> 		exit(0);
>>> 	} else if (new_pid =3D=3D pid)
>>> 		printf("I am the parent. My child got the pid %d!\n", new_pid);
>>> 	else
>>> 		printf("pid (%d) does not match expected pid (%d)\n", new_pid, pid)=
;
>>>
>>> 	printf("Cleaning up...\n");
>>> 	if (flock(fd, LOCK_UN))
>>> 		printf("Cannot unlock\n");
>>> 	close(fd);
>>> 	return 0;
>>> }
>>> $ id -u; /home/libcap/ns_last_pid 300000
>>> 1001
>>> Opening ns_last_pid...
>>> Locking ns_last_pid...
>>> Writing pid-1 to ns_last_pid...
>>> Forking...
>>> I am the parent. My child got the pid 300000!
>>> I am the child!
>>> Cleaning up...
>>>
>>> For the clone3() based approach:
>>> $ cat clone3_set_tid.c
>>>  #define _GNU_SOURCE
>>>  #include <linux/sched.h>
>>>  #include <stdint.h>
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <string.h>
>>>  #include <sys/types.h>
>>>  #include <sys/stat.h>
>>>  #include <sys/syscall.h>
>>>  #include <unistd.h>
>>>
>>>  #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
>>>
>>> int main(int argc, char *argv[])
>>> {
>>> 	struct clone_args c_args =3D { };
>>> 	pid_t pid, new_pid;
>>>
>>> 	if (argc !=3D 2)
>>> 		return 1;
>>>
>>> 	pid =3D atoi(argv[1]);
>>> 	c_args.set_tid =3D ptr_to_u64(&pid);
>>> 	c_args.set_tid_size =3D 1;
>>>
>>> 	printf("Forking...\n");
>>> 	new_pid =3D syscall(__NR_clone3, &c_args, sizeof(c_args));
>>> 	if (new_pid =3D=3D 0) {
>>> 		printf("I am the child!\n");
>>> 		exit(0);
>>> 	} else if (new_pid =3D=3D pid)
>>> 		printf("I am the parent. My child got the pid %d!\n", new_pid);
>>> 	else
>>> 		printf("pid (%d) does not match expected pid (%d)\n", new_pid, pid)=
;
>>> 	printf("Done\n");
>>>
>>> 	return 0;
>>> }
>>> $ id -u; /home/libcap/clone3_set_tid 300000
>>> 1001
>>> Forking...
>>> I am the parent. My child got the pid 300000!
>>> Done
>>> I am the child!
>>>
>>> Signed-off-by: Adrian Reber <areber@redhat.com>
>>> ---
>>>  include/linux/capability.h          | 5 +++++
>>>  include/uapi/linux/capability.h     | 9 ++++++++-
>>>  kernel/pid.c                        | 2 +-
>>>  kernel/pid_namespace.c              | 2 +-
>>>  security/selinux/include/classmap.h | 5 +++--
>>>  5 files changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/capability.h b/include/linux/capability.h
>>> index b4345b38a6be..1278313cb2bc 100644
>>> --- a/include/linux/capability.h
>>> +++ b/include/linux/capability.h
>>> @@ -261,6 +261,11 @@ static inline bool bpf_capable(void)
>>>  	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
>>>  }
>>> =20
>>> +static inline bool restore_ns_capable(struct user_namespace *ns)
>>> +{
>>> +	return ns_capable(ns, CAP_RESTORE) || ns_capable(ns, CAP_SYS_ADMIN)=
;
>>> +}
>>> +
>>>  /* audit system wants to get cap info from files as well */
>>>  extern int get_vfs_caps_from_disk(const struct dentry *dentry, struc=
t cpu_vfs_cap_data *cpu_caps);
>>> =20
>>> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/cap=
ability.h
>>> index c7372180a0a9..4bcc4e3d41ff 100644
>>> --- a/include/uapi/linux/capability.h
>>> +++ b/include/uapi/linux/capability.h
>>> @@ -406,7 +406,14 @@ struct vfs_ns_cap_data {
>>>   */
>>>  #define CAP_BPF			39
>>> =20
>>> -#define CAP_LAST_CAP         CAP_BPF
>>> +
>>> +/* Allow checkpoint/restore related operations */
>>> +/* Allow PID selection during clone3() */
>>> +/* Allow writing to ns_last_pid */
>>> +
>>> +#define CAP_RESTORE		40
>>> +
>>> +#define CAP_LAST_CAP         CAP_RESTORE
>>> =20
>>>  #define cap_valid(x) ((x) >=3D 0 && (x) <=3D CAP_LAST_CAP)
>>> =20
>>> diff --git a/kernel/pid.c b/kernel/pid.c
>>> index 3122043fe364..bbc26f2bcff6 100644
>>> --- a/kernel/pid.c
>>> +++ b/kernel/pid.c
>>> @@ -198,7 +198,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, p=
id_t *set_tid,
>>>  			if (tid !=3D 1 && !tmp->child_reaper)
>>>  				goto out_free;
>>>  			retval =3D -EPERM;
>>> -			if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
>>> +			if (!restore_ns_capable(tmp->user_ns))
>>>  				goto out_free;
>>>  			set_tid_size--;
>>>  		}
>>> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
>>> index 0e5ac162c3a8..f58186b31ce6 100644
>>> --- a/kernel/pid_namespace.c
>>> +++ b/kernel/pid_namespace.c
>>> @@ -269,7 +269,7 @@ static int pid_ns_ctl_handler(struct ctl_table *t=
able, int write,
>>>  	struct ctl_table tmp =3D *table;
>>>  	int ret, next;
>>> =20
>>> -	if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
>>> +	if (write && !restore_ns_capable(pid_ns->user_ns))
>>>  		return -EPERM;
>>> =20
>>>  	/*
>>> diff --git a/security/selinux/include/classmap.h b/security/selinux/i=
nclude/classmap.h
>>> index 98e1513b608a..f8b8f12a6ebd 100644
>>> --- a/security/selinux/include/classmap.h
>>> +++ b/security/selinux/include/classmap.h
>>> @@ -27,9 +27,10 @@
>>>  	    "audit_control", "setfcap"
>>> =20
>>>  #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
>>> -		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf"
>>> +		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
>>> +		"restore"
>>> =20
>>> -#if CAP_LAST_CAP > CAP_BPF
>>> +#if CAP_LAST_CAP > CAP_RESTORE
>>>  #error New capability defined, please update COMMON_CAP2_PERMS.
>>>  #endif
>>> =20
>>>
>>> base-commit: e8f3274774b45b5f4e9e3d5cad7ff9f43ae3add5

