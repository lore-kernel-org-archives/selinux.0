Return-Path: <SRS0=OcM+=VG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26A1C73C53
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E5920651
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 17:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mR4h9yfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfGIRNa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jul 2019 13:13:30 -0400
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:14867 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfGIRN3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jul 2019 13:13:29 -0400
X-EEMSG-check-017: 426845260|UHIL19PA10_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Jul 2019 17:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562692407; x=1594228407;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PUvr8sfCqTT3Pv3mTW7CWHi7CcHdALWxosYrwjd6A20=;
  b=mR4h9yfh+LkD6rIxdhyqAsmtzAY7UO84fSNUfXkBJA9XFWDv8KJVqemx
   lDnw7Q4N1lLHfXlqodgXiZeMxZ45dobGPBOrONHIA16BaVKAhXjR7eX3n
   rUouwaZshGqen5TblKt5d+5Ugg6E0BAMri9OL5dkd6LnM92k6iQ0i6TTk
   PGQ5HIpu89CzcDMSmStR68t+pPz3oOmYhq+xtSxFoxP/DpWGF32GRLunO
   EHwTQVz5NitDA47LaA/rQ5M6nn0BWAzUGke8XEDs4DwH5xF2vtSiiZIMH
   WrKhUuW5bEwrp6rzRZnelxzqwsyQGAJIlyr6/WhFOiZhWS6V7KVW+N+1A
   w==;
X-IronPort-AV: E=Sophos;i="5.63,470,1557187200"; 
   d="scan'208";a="25515165"
IronPort-PHdr: =?us-ascii?q?9a23=3ACA6gxRGtjcE2vRDJ9pyfzJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76o8SzbnLW6fgltlLVR4KTs6sC17OM9fy6EjVZuN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6twrcutcZjYd/N6o91w?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRegAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9mvyY6z6cJuZ?=
 =?us-ascii?q?+9fCUSzpQo2wXfZOCdf4iN4xLjUOCcKip7inJ9YL+zmhm//Ee6xuD8S8W4yk?=
 =?us-ascii?q?hGoyVbntXWq3wA0QHY5NKdRftn5Eih3C6C1wXU6u5ZP085jbHbK5s9wr4okZ?=
 =?us-ascii?q?oTrFjDEjf2mEroiK+WcV0p+vSy5OT9Y7Xmu4ScO5VoigD+Lqsumsu/Df4+Mg?=
 =?us-ascii?q?cSRGiU5f6w1Lji/U39WLlKj/s2nbfFsJ3COMgWqaG0DxVV34o+8RqzETir3M?=
 =?us-ascii?q?oCkXUaNF5FfQiIj4ntO1HAOvD4CvK/jky3kDh23PDLJaHhA5XRIXjDl7ftZ7?=
 =?us-ascii?q?B961VGxwYpwtBf4IxUBqkbIP3vQk/xqMDYDhghPgOo2ennE8ty14MFVGKUHq?=
 =?us-ascii?q?CZMLndsUKG5uIrPeaMfpYZtyrnJPQ/+/Huino5k0cHfaa1xZsXdGy4HvN+Lk?=
 =?us-ascii?q?qFe3XsmckOEGcQsgolUOPqiEeNUSNdZ3a2Qa08/Co2CIOgDYffWI+thKaN0z?=
 =?us-ascii?q?u8Hp1TfmpGEEyDEW/0d4WYXPcBcCCSIspmkjweT7ihSpQh2AqotADgzrpoMO?=
 =?us-ascii?q?vU9jcftZL529h///fTmg0q9TxoE8Sd1HmAT2V1nmMOWj8307lzoVdjxVifzK?=
 =?us-ascii?q?h4mf1YFcBT5v9QVwc6MoPTz/F+C9/sQQ/BYNiJR0i8Qtm8AjE+UMgxw9kQbE?=
 =?us-ascii?q?Z5AdmiiQrD3yWyCb8Pi7OLHIA08r7b33XpPMZy1XLG1Kgnj1k7TcpCLnOmhq?=
 =?us-ascii?q?Fh+AjJHYLJkFuWl7ysdasC2C7B7mCDzXCBvEtASg5/Tb3FXWwDZkvRtdn55V?=
 =?us-ascii?q?3NQKG1Cbs7NQtBzs2CJ7BWZd3pl1VGQ/LjONXDY2K0gWuwAgyIxryUZorwZ2?=
 =?us-ascii?q?odxDndCFQDkw0L/3aGMgg+BiG7r2LcCzxuFUjgY0X38eZgrnO2VVM7wBuMb0?=
 =?us-ascii?q?1m0bq1+wIaiuaYS/8Jwr0EvyIhoS1uHFmhx9LWF8aApw15caVEf9w95lhH1X?=
 =?us-ascii?q?/Ytwx7J5CgLL5thkQYcwtpu0PjzBR3BpxEkcgtsnMl0hB+KbmC31NCajOYx4?=
 =?us-ascii?q?r/NqfRKmbs5hyvabbW0EnE0NmK4qcP9Og4q1L7sQGxDEUi7nFn3sJN03SG+5?=
 =?us-ascii?q?XKCBMeUZf2UkYw7Rh1uavWbTU654PRhjVQNvyfuyTPypoSD+ss1xikcs0XZK?=
 =?us-ascii?q?iNDwLjO9YRB8GzJugngR2iZ1QPO+UEsOY/NtirZr2d066iIehkkSiOjGJb7Y?=
 =?us-ascii?q?Q72UWJs2J+T+nSxZce6/eR2waGETDmgxPptsHxhJABfjwZA3C+1TmhAYlde6?=
 =?us-ascii?q?l/VZgEBH3oIMCtwNh6wZn3VDoQ71OnBlUbyOe3dheIKV/wxwtd0QIQu3P0tz?=
 =?us-ascii?q?G/ymlPjzwxrqeZlBfLyuDmeQtPbnVHX0F+nFzsJs6ylNlcU0+2OVt63CC57F?=
 =?us-ascii?q?r3kvAI7J90KHPeFAIRJXn7?=
X-IPAS-Result: =?us-ascii?q?A2DmAAAJyiRd/wHyM5BmGwEBAQEDAQEBBwMBAQGBZ4FoB?=
 =?us-ascii?q?SpqUjIohByTLQEBAQEBAQaBNn6IXZEUCQEBAQEBAQEBASsJAQIBAYRAAoJDI?=
 =?us-ascii?q?zgTAQMBAQEEAQEBAQQBAWyFPAyCOikBgmYBAQEBAgEjBBFBEAsYAgIUDAYCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/AYF2BQ8PrAZ/M4NEggODJ4FHgQwoi18XeIEHgREngjY1P?=
 =?us-ascii?q?oUTgjuCWASMBQuHfFqBLpQ+CYIZgh+EN40pBhuCLIstiieNMJlNIYFYKwgCG?=
 =?us-ascii?q?AghDzuCbAmCRBeHaIZVIwMwAQGBBAEBjCKCLgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 09 Jul 2019 17:13:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x69HDNtf013363;
        Tue, 9 Jul 2019 13:13:24 -0400
Subject: Re: [PATCH v5 15/23] LSM: Specify which LSM to display
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20190703212538.7383-1-casey@schaufler-ca.com>
 <20190703212538.7383-16-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6f593ae9-4c79-7a04-41a3-c04ebd689658@tycho.nsa.gov>
Date:   Tue, 9 Jul 2019 13:13:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703212538.7383-16-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/3/19 5:25 PM, Casey Schaufler wrote:
> Create a new entry "display" in /proc/.../attr for controlling
> which LSM security information is displayed for a process.
> The name of an active LSM that supplies hooks for human readable
> data may be written to "display" to set the value. The name of
> the LSM currently in use can be read from "display".
> At this point there can only be one LSM capable of display
> active. A helper function lsm_task_display() to get the display
> slot for a task_struct.

As I explained previously, this is a security hole waiting to happen. 
It still permits a process to affect the output of audit, alter the 
result of reading or writing /proc/self/attr nodes even by 
setuid/setgid/file-caps/context-changing programs, alter the contexts 
generated in netlink messages delivered to other processes (I think?), 
and possibly other effects beyond affecting the process' own view of things.

Before:
$ id
uid=1002(sds2) gid=1002(sds2) groups=1002(sds2) 
context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
$ su
Password:
su: Authentication failure

syscall audit record:
type=SYSCALL msg=audit(07/09/2019 11:52:49.784:365) : arch=x86_64 
syscall=openat
  success=no exit=EACCES(Permission denied) a0=0xffffff9c 
a1=0x560897e58e00 a2=O_
WRONLY a3=0x0 items=1 ppid=3258 pid=3781 auid=sds2 uid=sds2 gid=sds2 
euid=root s
uid=root fsuid=root egid=sds2 sgid=sds2 fsgid=sds2 tty=pts2 ses=6 
comm=su exe=/usr/bin/su subj=staff_u:staff_r:staff_t:s0-s0:c0.c1023 
key=(null)

After:
$ id
uid=1002(sds2) gid=1002(sds2) groups=1002(sds2) 
context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
$ echo apparmor > /proc/self/attr/display
$ su
Password:
su: Authentication failure

audit record:
type=SYSCALL msg=audit(07/09/2019 12:05:32.402:406) : arch=x86_64 
syscall=openat success=no exit=EACCES(Permission denied) a0=0xffffff9c 
a1=0x556b41e1ae00 a2=O_WRONLY a3=0x0 items=1 ppid=3258 pid=9426 
auid=sds2 uid=sds2 gid=sds2 euid=root suid=root fsuid=root egid=sds2 
sgid=sds2 fsgid=sds2 tty=pts2 ses=6 comm=su exe=/usr/bin/su 
subj==unconfined key=(null)

NB The subj= field of the SYSCALL audit record is longer accurate and is 
potentially under the control of a process that would not be authorized 
to set its subject label to that value by SELinux.

Now, let's play with userspace.

Before:
# id
uid=0(root) gid=0(root) groups=0(root) 
context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
# passwd root
passwd: SELinux deny access due to security policy.

audit record:
type=USER_AVC msg=audit(07/09/2019 12:24:35.135:812) : pid=12693 
uid=root auid=sds2 ses=7 subj=staff_u:staff_r:passwd_t:s0-s0:c0.c1023 
msg='avc:  denied  { passwd } for 
scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 
tcontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023 tclass=passwd 
permissive=0  exe=/usr/bin/passwd sauid=root hostname=? addr=? 
terminal=pts/2'
type=USER_CHAUTHTOK msg=audit(07/09/2019 12:24:35.135:813) : pid=12693 
uid=root auid=sds2 ses=7 subj=staff_u:staff_r:passwd_t:s0-s0:c0.c1023 
msg='op=attempted-to-change-password id=root exe=/usr/bin/passwd 
hostname=moss-pluto.infosec.tycho.ncsc.mil addr=? terminal=pts/2 res=failed'

After:
# id
uid=0(root) gid=0(root) groups=0(root) 
context=staff_u:staff_r:staff_t:s0-s0:c0.c1023
# echo apparmor > /proc/self/attr/display
# passwd root
passwd: SELinux deny access due to security policy.

audit record:
type=USER_CHAUTHTOK msg=audit(07/09/2019 12:28:41.349:832) : pid=13083 
uid=root auid=sds2 ses=7 subj==unconfined 
msg='op=attempted-to-change-password id=root exe=/usr/bin/passwd 
hostname=moss-pluto.infosec.tycho.ncsc.mil addr=? terminal=pts/2 
res=failed'

Here we again get the wrong value for subj= in the USER_CHAUTHTOK audit 
record, and we further lose the USER_AVC record entirely because it 
didn't even reach the point of the permission check due to not being 
able to get the caller context.

The situation gets worse if the caller can set things up such that it 
can set an attribute value for one security module that is valid and 
privileged with respect to another security module.  This isn't a 
far-fetched scenario; AppArmor will default to running everything 
unconfined, so as soon as you enable it, any root process can 
potentially load a policy that defines contexts that look exactly like 
SELinux contexts. Smack is even simpler; you can set any arbitrary 
string you want as long as you are root (by default); no policy 
required.  So a root process that is confined by SELinux (or by AppAmor) 
can suddenly forge arbitrary contexts in audit records or reads of 
/proc/self/attr nodes or netlink messages or ..., just by virtue of 
applying these patches and enabling another security module like Smack. 
Or consider if ptags were ever made real and merged - by design, that's 
all about setting arbitrary tags from userspace.  Then there is the 
separate issue of switching display to prevent attempts by a more 
privileged program to set one of its attributes from taking effect. 
Where have we seen that before - sendmail capabilities bug anyone?  And 
it is actually worse than that bug, because with the assistance of a 
friendly security module, the write may actually succeed; it just won't 
alter the SELinux context of the program or anything it creates!

This gets a NAK from me so long as it has these issues and setting the 
display remains outside the control of any security module.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   fs/proc/base.c            |   1 +
>   include/linux/lsm_hooks.h |  13 ++++
>   security/security.c       | 129 +++++++++++++++++++++++++++++++++-----
>   3 files changed, 126 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ddef482f1334..7bf70e041315 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>   	ATTR(NULL, "fscreate",		0666),
>   	ATTR(NULL, "keycreate",		0666),
>   	ATTR(NULL, "sockcreate",	0666),
> +	ATTR(NULL, "display",		0666),
>   #ifdef CONFIG_SECURITY_SMACK
>   	DIR("smack",			0555,
>   	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index fe1fb7a69ee5..88ec3f3487ae 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2134,4 +2134,17 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>   
>   extern int lsm_inode_alloc(struct inode *inode);
>   
> +/**
> + * lsm_task_display - the "display LSM for this task
> + * @task: The task to report on
> + *
> + * Returns the task's display LSM slot.
> + */
> +static inline int lsm_task_display(struct task_struct *task)
> +{
> +	int *display = task->security;
> +
> +	return *display;
> +}
> +
>   #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index 8927508b2142..f3a293e6ef5a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
>   static struct kmem_cache *lsm_inode_cache;
>   
>   char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
> +	.lbs_task = sizeof(int),	/* slot number for the "display" LSM */
> +};
>   
>   /* Boot-time LSM user choice */
>   static __initdata const char *chosen_lsm_order;
> @@ -423,8 +425,10 @@ static int lsm_append(const char *new, char **result)
>   
>   /*
>    * Current index to use while initializing the lsmblob secid list.
> + * Pointers to the LSM id structures for local use.
>    */
>   static int lsm_slot __lsm_ro_after_init;
> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
>   
>   /**
>    * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -444,6 +448,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   	if (lsmid->slot == LSMBLOB_NEEDED) {
>   		if (lsm_slot >= LSMBLOB_ENTRIES)
>   			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_slotlist[lsm_slot] = lsmid;
>   		lsmid->slot = lsm_slot++;
>   		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>   			   lsmid->slot);
> @@ -564,6 +569,8 @@ int lsm_inode_alloc(struct inode *inode)
>    */
>   static int lsm_task_alloc(struct task_struct *task)
>   {
> +	int *display;
> +
>   	if (blob_sizes.lbs_task == 0) {
>   		task->security = NULL;
>   		return 0;
> @@ -572,6 +579,15 @@ static int lsm_task_alloc(struct task_struct *task)
>   	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>   	if (task->security == NULL)
>   		return -ENOMEM;
> +
> +	/*
> +	 * The start of the task blob contains the "display" LSM slot number.
> +	 * Start with it set to the invalid slot number, indicating that the
> +	 * default first registered LSM be displayed.
> +	 */
> +	display = task->security;
> +	*display = LSMBLOB_INVALID;
> +
>   	return 0;
>   }
>   
> @@ -1563,14 +1579,24 @@ int security_file_open(struct file *file)
>   
>   int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>   {
> +	int *odisplay = current->security;
> +	int *ndisplay;
>   	int rc = lsm_task_alloc(task);
>   
> -	if (rc)
> +	if (unlikely(rc))
>   		return rc;
> +
>   	rc = call_int_hook(task_alloc, 0, task, clone_flags);
> -	if (unlikely(rc))
> +	if (unlikely(rc)) {
>   		security_task_free(task);
> -	return rc;
> +		return rc;
> +	}
> +
> +	ndisplay = task->security;
> +	if (ndisplay && odisplay)
> +		*ndisplay = *odisplay;
> +
> +	return 0;
>   }
>   
>   void security_task_free(struct task_struct *task)
> @@ -1967,10 +1993,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   				char **value)
>   {
>   	struct security_hook_list *hp;
> +	int display = lsm_task_display(current);
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0)
> +			return -EINVAL;
> +		if (display != LSMBLOB_INVALID)
> +			slot = display;
> +		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
> +		if (*value)
> +			return strlen(*value);
> +		return -ENOMEM;
> +	}
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> +		if (lsm == NULL && display != LSMBLOB_INVALID &&
> +		    display != hp->lsmid->slot)
> +			continue;
>   		return hp->hook.getprocattr(p, name, value);
>   	}
>   	return -EINVAL;
> @@ -1980,10 +2025,46 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   			 size_t size)
>   {
>   	struct security_hook_list *hp;
> +	char *term;
> +	char *cp;
> +	int *display = current->security;
> +	int rc = -EINVAL;
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0 || size == 0)
> +			return -EINVAL;
> +		cp = kzalloc(size + 1, GFP_KERNEL);
> +		if (cp == NULL)
> +			return -ENOMEM;
> +		memcpy(cp, value, size);
> +
> +		term = strchr(cp, ' ');
> +		if (term == NULL)
> +			term = strchr(cp, '\n');
> +		if (term != NULL)
> +			*term = '\0';
> +
> +		for (slot = 0; slot < lsm_slot; slot++)
> +			if (!strcmp(cp, lsm_slotlist[slot]->lsm)) {
> +				*display = lsm_slotlist[slot]->slot;
> +				rc = size;
> +				break;
> +			}
> +
> +		kfree(cp);
> +		return rc;
> +	}
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->lsmid->slot)
> +			continue;
>   		return hp->hook.setprocattr(name, value, size);
>   	}
>   	return -EINVAL;
> @@ -2003,15 +2084,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>   int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>   {
>   	struct security_hook_list *hp;
> -	int rc;
> +	int display = lsm_task_display(current);
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>   		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>   			continue;
> -		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
> -					      secdata, seclen);
> -		if (rc != 0)
> -			return rc;
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.secid_to_secctx(
> +					blob->secid[hp->lsmid->slot],
> +					secdata, seclen);
>   	}
>   	return 0;
>   }
> @@ -2021,16 +2102,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>   			     struct lsmblob *blob)
>   {
>   	struct security_hook_list *hp;
> -	int rc;
> +	int display = lsm_task_display(current);
>   
>   	lsmblob_init(blob, 0);
>   	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
>   		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>   			continue;
> -		rc = hp->hook.secctx_to_secid(secdata, seclen,
> -					      &blob->secid[hp->lsmid->slot]);
> -		if (rc != 0)
> -			return rc;
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.secctx_to_secid(secdata, seclen,
> +						&blob->secid[hp->lsmid->slot]);
>   	}
>   	return 0;
>   }
> @@ -2038,7 +2118,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>   
>   void security_release_secctx(char *secdata, u32 seclen)
>   {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	struct security_hook_list *hp;
> +	int *display = current->security;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> +		if (*display == LSMBLOB_INVALID ||
> +		    *display == hp->lsmid->slot) {
> +			hp->hook.release_secctx(secdata, seclen);
> +			return;
> +		}
>   }
>   EXPORT_SYMBOL(security_release_secctx);
>   
> @@ -2163,8 +2251,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>   int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>   				      int __user *optlen, unsigned len)
>   {
> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
> -				optval, optlen, len);
> +	int display = lsm_task_display(current);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
> +			     list)
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.socket_getpeersec_stream(sock, optval,
> +								 optlen, len);
> +	return -ENOPROTOOPT;
>   }
>   
>   int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> 

