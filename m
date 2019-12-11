Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EF0C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 18:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F8F22B48
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 18:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Zt62Jhcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfLKSfs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:35:48 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:35537
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729512AbfLKSfs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 13:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576089342; bh=CBLfHlnE4awAKAo5ZSI+GFnHcC4Tfas76y/USCXfa9c=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Zt62Jhcnys0NbmhpHnEOt/W0WitAQASK4ozrB/U2IFp5wiDRurxWnuAESzs/b5QeC9AYv1xUXbsUhhaGDyEkvEg0WtVCT/JIOB5x8UxOSyJ1nimjY+m+Yh/81c0i3+bTq8Vq+qurrpFjN3OlJmEIzcH4fb7mEoN/owtdgh64uX1Q1oV/mq3++UP5yXzhyfifWG6k3J/xjk75SJF5e4nNMigiijXCB1eQcZFDJ6bXNsLDJSJ7416Y9E1m4d0fUspZQFuia8E1xaPr2CWvP6UX7QX9llLghOad9YuRKMo8euG6fu1v0R+ee2O8T/4dvmvzmb2B9sA8VeELU1dsSn/sJw==
X-YMail-OSG: dG9DR.cVM1nVlfY8eU59a6WMGpubUApKYjn.ZwG3xFNL8ByEq_NWNtmYsy2dfJD
 JgCSDZ2Hhgyjc2EpPSM4WHXXHMYJIDbvzM80FBILV_yHp1pSNOCNlTNytcZZ6DAnr3LQzeMccONt
 KTjEU.F4Oe.uLv2DZ2x5KmOAygDhN1XOcy1eLpLK6tVd2uzlhWGFOo_nuAKmBataBNuT9mXkWq5W
 ZcAV7BnlOlDLCDY5AnHHMvGCe.5N8DGbx.rlrGmjgvcvofqYyTld9nBlviQ9PfmQbsFoCV53lruk
 Hgf3HbL8NeREQg73aRrMxzF1gJWmBr9ernVCHpalUoBQtOFGmmFBjVpw7TlRD_CFRzeokBzWA3Rf
 nGxY0YPCEjrergVvpQmHu0AI2i0TiEpV5tbHSDs3Uz0Qtz3TQXdtXElqHSvMjdgNjFeVdwjeDb8b
 prXt8lj03bz2nCHIoaSxH5t4a1WKQxSy32oU9E5qWk6N9VdLOaTtYKiNfceXL21DMt6Qx7orKS3F
 gXsrxHiB.FA9GT7TxPECGpFDxAnuD8XSPBuc9xeQ21s.TzqD_DSWYNjLka5RBzlqt8VkMAEoqpg2
 ZWCr05m8gPK5D2TBNr_UKKWK.MoymBEl0UD9ep1MVCCCFAw5L4MfIZLWWIIauGQWnuLl.uipHbR7
 MYFiDGcMmocK506S2H0wUEoJCUIg.OgHbkRNpa2ke3cRGiFKrXht0.V.t4Mtxj1rdCb.PZ4R9s3L
 W4h.EElYldkP8laWf7p3MBpiw816WVebuX4IR6MxY4dNTZtoO0p2QcT9QpQ2whg7gLO7FfG3xdL2
 .wXK5fRTtAOwEMpiIJmaB5vKKE3RzMicul01bvREM4V6C7R1.T0e7XM_qhjMC9ZSRdACsQsvpq5x
 bIrCCesT9UVRTGTPu7hsoVKoQmR6RJxF4bhfPD5m9_M79B17FZXIcivj4aAdpeMRllINuG6e5fLo
 FPhbLRL3mtxDz8X24kxrxLA_2h9SQLRoWfHc802PiZB8MmFpvRRVBRRDtD2KHKX7LUORKa0IW.if
 0Y9cbsN9AhVIJI3QvChxJtUddUqGf_88Pq.AvRNkfgn2CFj5vJey9.WJuPm9hOFS_qj7CkoLWS4O
 P7I.xXWx6alZ9WF0qOuKJLBkHOyndmbXR.lN1gTURz.DVkFMBapFdcLm2JbqOR942Rt_1kwUgtFY
 5obX8O1peu3uHUoovri0apVtNiJQ81Qd4_OrLo8edjYANvn9.xFmqKU6opSyP5HPyqYWKrN9OkEr
 _iU.Ikj4w.LqM1Ed4JFmR6jOHS6bEAmvDgQiKpTeyBsDY802775Ev0owlpYwXVAzaB6FvC9oOlwY
 11qXBjALb1WBOh4YxCssdXDu5V8ZPk94WzL4qw2up74hdt.n8IGFBo9fyEA8zmPaMZa6xvEyV3mt
 WdzH2A3addoIebt464gkd01X5XwxF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 11 Dec 2019 18:35:42 +0000
Received: by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 716c3593ac5527553ef3ff7c00b27fe7;
          Wed, 11 Dec 2019 18:35:38 +0000 (UTC)
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Kees Cook <keescook@chromium.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191211140833.939845-1-omosnace@redhat.com>
 <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
Date:   Wed, 11 Dec 2019 10:35:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <201912110840.62A4E64BA@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/11/2019 8:42 AM, Kees Cook wrote:
> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
>>> Instead of deleting the hooks from each list one-by-one (which create=
s
>>> some bad race conditions), allow an LSM to provide a reference to its=

>>> "enabled" variable and check this variable before calling the hook.
>>>
>>> As a nice side effect, this allows marking the hooks (and other stuff=
)
>>> __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no lon=
ger
>>> makes sense, remove it and instead use SECURITY_SELINUX_DISABLE direc=
tly
>>> for turning on the runtime disable functionality, to emphasize that t=
his
>>> is only used by SELinux and is meant to be removed in the future.
>> Is this fundamentally different/better than adding if (!selinux_enable=
d)
>> return 0; to the beginning of every SELinux hook function?  And as I n=
oted
>> to Casey in the earlier thread, that provides an additional easy targe=
t to
>> kernel exploit writers for neutering SELinux with a single kernel writ=
e
>> vulnerability. OTOH, they already have selinux_state.enforcing and fri=
ends,
>> and this new one would only be if SECURITY_SELINUX_DISABLE=3Dy.
> Yeah, I agree here -- we specifically do not want there to be a trivial=

> way to disable LSMs at runtime. CONFIG_SECURITY_SELINUX_DISABLE should
> be considered deprecated IMO, and we don't want to widen its features.

In /etc/selinux/config SELINUX=3Ddisabled is documented as "No SELinux
policy is loaded". How about if instead of blocking policy load and
removing the hooks it just blocked policy load? It may be appropriate
to tweak the code a bit to perform better in the no-policy loaded
case, but my understanding is that the system should work. That would
address backward compatibility concerns and allow removal of
security_delete_hooks(). I don't think this would have the same
exposure of resetting selinux_enabled.


> -Kees
>
>>> Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>
>>> This is an alternative to [1]. It turned out to be less simple than I=

>>> had hoped, but OTOH the hook arrays can now be unconditionally made
>>> __ro_after_init so may be still worth it.
>>>
>>> Compile- and boot- tested with SECURITY_SELINUX_DISABLE set to =3Dy a=
nd
>>> =3Dn; SELinux enabled. Changes to other LSMs only compile-tested (but=

>>> those are trivial).
>>>
>>> [1] https://lore.kernel.org/selinux/20191209075756.123157-1-omosnace@=
redhat.com/T/
>>>
>>>   include/linux/lsm_hooks.h    | 46 +++++++++----------------------
>>>   security/Kconfig             |  5 ----
>>>   security/apparmor/lsm.c      | 14 ++++++----
>>>   security/commoncap.c         | 11 +++++---
>>>   security/loadpin/loadpin.c   | 10 +++++--
>>>   security/lockdown/lockdown.c | 11 +++++---
>>>   security/safesetid/lsm.c     |  9 +++++--
>>>   security/security.c          | 52 +++++++++++++++++++++------------=
---
>>>   security/selinux/Kconfig     |  5 ++--
>>>   security/selinux/hooks.c     | 28 ++++++++++++++-----
>>>   security/smack/smack_lsm.c   | 11 +++++---
>>>   security/tomoyo/tomoyo.c     | 13 ++++++---
>>>   security/yama/yama_lsm.c     | 10 +++++--
>>>   13 files changed, 133 insertions(+), 92 deletions(-)
>>>
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index 20d8cf194fb7..91b77ebcb822 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -27,7 +27,6 @@
>>>   #include <linux/security.h>
>>>   #include <linux/init.h>
>>> -#include <linux/rculist.h>
>>>   /**
>>>    * union security_list_options - Linux Security Module hook functio=
n list
>>> @@ -2086,6 +2085,9 @@ struct security_hook_list {
>>>   	struct hlist_head		*head;
>>>   	union security_list_options	hook;
>>>   	char				*lsm;
>>> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>>> +	const int			*enabled;
>>> +#endif
>>>   } __randomize_layout;
>>>   /*
>>> @@ -2112,8 +2114,16 @@ struct lsm_blob_sizes {
>>>   extern struct security_hook_heads security_hook_heads;
>>>   extern char *lsm_names;
>>> -extern void security_add_hooks(struct security_hook_list *hooks, int=
 count,
>>> -				char *lsm);
>>> +struct security_hook_array {
>>> +	struct security_hook_list *hooks;
>>> +	int count;
>>> +	char *lsm;
>>> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>>> +	const int *enabled;
>>> +#endif
>>> +};
>>> +
>>> +extern void security_add_hook_array(const struct security_hook_array=
 *array);
>>>   #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>>>   #define LSM_FLAG_EXCLUSIVE	BIT(1)
>>> @@ -2145,36 +2155,6 @@ extern struct lsm_info __start_early_lsm_info[=
], __end_early_lsm_info[];
>>>   		__used __section(.early_lsm_info.init)			\
>>>   		__aligned(sizeof(unsigned long))
>>> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>>> -/*
>>> - * Assuring the safety of deleting a security module is up to
>>> - * the security module involved. This may entail ordering the
>>> - * module's hook list in a particular way, refusing to disable
>>> - * the module once a policy is loaded or any number of other
>>> - * actions better imagined than described.
>>> - *
>>> - * The name of the configuration option reflects the only module
>>> - * that currently uses the mechanism. Any developer who thinks
>>> - * disabling their module is a good idea needs to be at least as
>>> - * careful as the SELinux team.
>>> - */
>>> -static inline void security_delete_hooks(struct security_hook_list *=
hooks,
>>> -						int count)
>>> -{
>>> -	int i;
>>> -
>>> -	for (i =3D 0; i < count; i++)
>>> -		hlist_del_rcu(&hooks[i].list);
>>> -}
>>> -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
>>> -
>>> -/* Currently required to handle SELinux runtime hook disable. */
>>> -#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
>>> -#define __lsm_ro_after_init
>>> -#else
>>> -#define __lsm_ro_after_init	__ro_after_init
>>> -#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
>>> -
>>>   extern int lsm_inode_alloc(struct inode *inode);
>>>   #endif /* ! __LINUX_LSM_HOOKS_H */
>>> diff --git a/security/Kconfig b/security/Kconfig
>>> index 2a1a2d396228..456764990a13 100644
>>> --- a/security/Kconfig
>>> +++ b/security/Kconfig
>>> @@ -32,11 +32,6 @@ config SECURITY
>>>   	  If you are unsure how to answer this question, answer N.
>>> -config SECURITY_WRITABLE_HOOKS
>>> -	depends on SECURITY
>>> -	bool
>>> -	default n
>>> -
>>>   config SECURITYFS
>>>   	bool "Enable the securityfs filesystem"
>>>   	help
>>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>>> index b621ad74f54a..a27f48670b37 100644
>>> --- a/security/apparmor/lsm.c
>>> +++ b/security/apparmor/lsm.c
>>> @@ -1158,13 +1158,13 @@ static int apparmor_inet_conn_request(struct =
sock *sk, struct sk_buff *skb,
>>>   /*
>>>    * The cred blob is a pointer to, not an instance of, an aa_task_ct=
x.
>>>    */
>>> -struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init =3D {
>>> +struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init =3D {
>>>   	.lbs_cred =3D sizeof(struct aa_task_ctx *),
>>>   	.lbs_file =3D sizeof(struct aa_file_ctx),
>>>   	.lbs_task =3D sizeof(struct aa_task_ctx),
>>>   };
>>> -static struct security_hook_list apparmor_hooks[] __lsm_ro_after_ini=
t =3D {
>>> +static struct security_hook_list apparmor_hooks[] __ro_after_init =3D=
 {
>>>   	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>>>   	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
>>>   	LSM_HOOK_INIT(capget, apparmor_capget),
>>> @@ -1368,7 +1368,7 @@ static const struct kernel_param_ops param_ops_=
aaintbool =3D {
>>>   	.get =3D param_get_aaintbool
>>>   };
>>>   /* Boot time disable flag */
>>> -static int apparmor_enabled __lsm_ro_after_init =3D 1;
>>> +static int apparmor_enabled __ro_after_init =3D 1;
>>>   module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
>>>   static int __init apparmor_enabled_setup(char *str)
>>> @@ -1829,6 +1829,11 @@ __initcall(apparmor_nf_ip_init);
>>>   static int __init apparmor_init(void)
>>>   {
>>> +	struct security_hook_array hook_array =3D {
>>> +		.hooks =3D apparmor_hooks,
>>> +		.count =3D ARRAY_SIZE(apparmor_hooks),
>>> +		.lsm =3D "apparmor",
>>> +	};
>>>   	int error;
>>>   	aa_secids_init();
>>> @@ -1864,8 +1869,7 @@ static int __init apparmor_init(void)
>>>   		aa_free_root_ns();
>>>   		goto buffers_out;
>>>   	}
>>> -	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
>>> -				"apparmor");
>>> +	security_add_hook_array(&hook_array);
>>>   	/* Report that AppArmor successfully initialized */
>>>   	apparmor_initialized =3D 1;
>>> diff --git a/security/commoncap.c b/security/commoncap.c
>>> index f4ee0ae106b2..6e9f4b6b6b1d 100644
>>> --- a/security/commoncap.c
>>> +++ b/security/commoncap.c
>>> @@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned l=
ong reqprot,
>>>   #ifdef CONFIG_SECURITY
>>> -static struct security_hook_list capability_hooks[] __lsm_ro_after_i=
nit =3D {
>>> +static struct security_hook_list capability_hooks[] __ro_after_init =
=3D {
>>>   	LSM_HOOK_INIT(capable, cap_capable),
>>>   	LSM_HOOK_INIT(settime, cap_settime),
>>>   	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
>>> @@ -1362,8 +1362,13 @@ static struct security_hook_list capability_ho=
oks[] __lsm_ro_after_init =3D {
>>>   static int __init capability_init(void)
>>>   {
>>> -	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
>>> -				"capability");
>>> +	struct security_hook_array hook_array =3D {
>>> +		.hooks =3D capability_hooks,
>>> +		.count =3D ARRAY_SIZE(capability_hooks),
>>> +		.lsm =3D "capability",
>>> +	};
>>> +
>>> +	security_add_hook_array(&hook_array);
>>>   	return 0;
>>>   }
>>> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
>>> index ee5cb944f4ad..5fadd4969d90 100644
>>> --- a/security/loadpin/loadpin.c
>>> +++ b/security/loadpin/loadpin.c
>>> @@ -180,7 +180,7 @@ static int loadpin_load_data(enum kernel_load_dat=
a_id id)
>>>   	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
>>>   }
>>> -static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init=
 =3D {
>>> +static struct security_hook_list loadpin_hooks[] __ro_after_init =3D=
 {
>>>   	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>>>   	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
>>>   	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
>>> @@ -224,10 +224,16 @@ static void __init parse_exclude(void)
>>>   static int __init loadpin_init(void)
>>>   {
>>> +	struct security_hook_array hook_array =3D {
>>> +		.hooks =3D loadpin_hooks,
>>> +		.count =3D ARRAY_SIZE(loadpin_hooks),
>>> +		.lsm =3D "loadpin",
>>> +	};
>>> +
>>>   	pr_info("ready to pin (currently %senforcing)\n",
>>>   		enforce ? "" : "not ");
>>>   	parse_exclude();
>>> -	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadp=
in");
>>> +	security_add_hook_array(&hook_array);
>>>   	return 0;
>>>   }
>>> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdow=
n.c
>>> index 5a952617a0eb..bcfa0ff4ee63 100644
>>> --- a/security/lockdown/lockdown.c
>>> +++ b/security/lockdown/lockdown.c
>>> @@ -71,19 +71,24 @@ static int lockdown_is_locked_down(enum lockdown_=
reason what)
>>>   	return 0;
>>>   }
>>> -static struct security_hook_list lockdown_hooks[] __lsm_ro_after_ini=
t =3D {
>>> +static struct security_hook_list lockdown_hooks[] __ro_after_init =3D=
 {
>>>   	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
>>>   };
>>>   static int __init lockdown_lsm_init(void)
>>>   {
>>> +	struct security_hook_array hook_array =3D {
>>> +		.hooks =3D lockdown_hooks,
>>> +		.count =3D ARRAY_SIZE(lockdown_hooks),
>>> +		.lsm =3D "lockdown",
>>> +	};
>>> +
>>>   #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
>>>   	lock_kernel_down("Kernel configuration", LOCKDOWN_INTEGRITY_MAX);
>>>   #elif defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY)
>>>   	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_=
MAX);
>>>   #endif
>>> -	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
>>> -			   "lockdown");
>>> +	security_add_hook_array(&hook_array);
>>>   	return 0;
>>>   }
>>> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
>>> index 7760019ad35d..4e36e53f033d 100644
>>> --- a/security/safesetid/lsm.c
>>> +++ b/security/safesetid/lsm.c
>>> @@ -156,8 +156,13 @@ static struct security_hook_list safesetid_secur=
ity_hooks[] =3D {
>>>   static int __init safesetid_security_init(void)
>>>   {
>>> -	security_add_hooks(safesetid_security_hooks,
>>> -			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
>>> +	struct security_hook_array hook_array =3D {
>>> +		.hooks =3D safesetid_security_hooks,
>>> +		.count =3D ARRAY_SIZE(safesetid_security_hooks),
>>> +		.lsm =3D "safesetid",
>>> +	};
>>> +
>>> +	security_add_hook_array(&hook_array);
>>>   	/* Report that SafeSetID successfully initialized */
>>>   	safesetid_initialized =3D 1;
>>> diff --git a/security/security.c b/security/security.c
>>> index 2b5473d92416..a5dd348bd37e 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -68,14 +68,14 @@ const char *const lockdown_reasons[LOCKDOWN_CONFI=
DENTIALITY_MAX+1] =3D {
>>>   	[LOCKDOWN_CONFIDENTIALITY_MAX] =3D "confidentiality",
>>>   };
>>> -struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>>> +struct security_hook_heads security_hook_heads __ro_after_init;
>>>   static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>>>   static struct kmem_cache *lsm_file_cache;
>>>   static struct kmem_cache *lsm_inode_cache;
>>>   char *lsm_names;
>>> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
>>> +static struct lsm_blob_sizes blob_sizes __ro_after_init;
>>>   /* Boot-time LSM user choice */
>>>   static __initdata const char *chosen_lsm_order;
>>> @@ -467,20 +467,20 @@ static int lsm_append(const char *new, char **r=
esult)
>>>   /**
>>>    * security_add_hooks - Add a modules hooks to the hook lists.
>>> - * @hooks: the hooks to add
>>> - * @count: the number of hooks to add
>>> - * @lsm: the name of the security module
>>> + * @array: the struct describing hooks to add
>>>    *
>>>    * Each LSM has to register its hooks with the infrastructure.
>>>    */
>>> -void __init security_add_hooks(struct security_hook_list *hooks, int=
 count,
>>> -				char *lsm)
>>> +void __init security_add_hook_array(const struct security_hook_array=
 *array)
>>>   {
>>>   	int i;
>>> -	for (i =3D 0; i < count; i++) {
>>> -		hooks[i].lsm =3D lsm;
>>> -		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>>> +	for (i =3D 0; i < array->count; i++) {
>>> +		array->hooks[i].lsm =3D array->lsm;
>>> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>>> +		array->hooks[i].enabled =3D array->enabled;
>>> +#endif
>>> +		hlist_add_tail_rcu(&array->hooks[i].list, array->hooks[i].head);
>>>   	}
>>>   	/*
>>> @@ -488,7 +488,7 @@ void __init security_add_hooks(struct security_ho=
ok_list *hooks, int count,
>>>   	 * and fix this up afterwards.
>>>   	 */
>>>   	if (slab_is_available()) {
>>> -		if (lsm_append(lsm, &lsm_names) < 0)
>>> +		if (lsm_append(array->lsm, &lsm_names) < 0)
>>>   			panic("%s - Cannot get early memory.\n", __func__);
>>>   	}
>>>   }
>>> @@ -679,11 +679,22 @@ static void __init lsm_early_task(struct task_s=
truct *task)
>>>    *	This is a hook that returns a value.
>>>    */
>>> +#define for_each_hook(p, func) \
>>> +	hlist_for_each_entry(p, &security_hook_heads.func, list)
>>> +
>>> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>>> +#define for_each_enabled_hook(p, func) \
>>> +	for_each_hook(p, func) \
>>> +		if (!(p)->enabled || READ_ONCE(*(p)->enabled))
>>> +#else
>>> +#define for_each_enabled_hook for_each_hook
>>> +#endif
>>> +
>>>   #define call_void_hook(FUNC, ...)				\
>>>   	do {							\
>>>   		struct security_hook_list *P;			\
>>>   								\
>>> -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
>>> +		for_each_enabled_hook(P, FUNC)			\
>>>   			P->hook.FUNC(__VA_ARGS__);		\
>>>   	} while (0)
>>> @@ -692,7 +703,7 @@ static void __init lsm_early_task(struct task_str=
uct *task)
>>>   	do {							\
>>>   		struct security_hook_list *P;			\
>>>   								\
>>> -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
>>> +		for_each_enabled_hook(P, FUNC) {		\
>>>   			RC =3D P->hook.FUNC(__VA_ARGS__);		\
>>>   			if (RC !=3D 0)				\
>>>   				break;				\
>>> @@ -795,7 +806,7 @@ int security_vm_enough_memory_mm(struct mm_struct=
 *mm, long pages)
>>>   	 * agree that it should be set it will. If any module
>>>   	 * thinks it should not be set it won't.
>>>   	 */
>>> -	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, lis=
t) {
>>> +	for_each_enabled_hook(hp, vm_enough_memory) {
>>>   		rc =3D hp->hook.vm_enough_memory(mm, pages);
>>>   		if (rc <=3D 0) {
>>>   			cap_sys_admin =3D 0;
>>> @@ -1343,7 +1354,7 @@ int security_inode_getsecurity(struct inode *in=
ode, const char *name, void **buf
>>>   	/*
>>>   	 * Only one module will provide an attribute with a given name.
>>>   	 */
>>> -	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, li=
st) {
>>> +	for_each_enabled_hook(hp, inode_getsecurity) {
>>>   		rc =3D hp->hook.inode_getsecurity(inode, name, buffer, alloc);
>>>   		if (rc !=3D -EOPNOTSUPP)
>>>   			return rc;
>>> @@ -1361,7 +1372,7 @@ int security_inode_setsecurity(struct inode *in=
ode, const char *name, const void
>>>   	/*
>>>   	 * Only one module will provide an attribute with a given name.
>>>   	 */
>>> -	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, li=
st) {
>>> +	for_each_enabled_hook(hp, inode_setsecurity) {
>>>   		rc =3D hp->hook.inode_setsecurity(inode, name, value, size,
>>>   								flags);
>>>   		if (rc !=3D -EOPNOTSUPP)
>>> @@ -1744,7 +1755,7 @@ int security_task_prctl(int option, unsigned lo=
ng arg2, unsigned long arg3,
>>>   	int rc =3D -ENOSYS;
>>>   	struct security_hook_list *hp;
>>> -	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
>>> +	for_each_enabled_hook(hp, task_prctl) {
>>>   		thisrc =3D hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
>>>   		if (thisrc !=3D -ENOSYS) {
>>>   			rc =3D thisrc;
>>> @@ -1913,7 +1924,7 @@ int security_getprocattr(struct task_struct *p,=
 const char *lsm, char *name,
>>>   {
>>>   	struct security_hook_list *hp;
>>> -	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>>> +	for_each_enabled_hook(hp, getprocattr) {
>>>   		if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
>>>   			continue;
>>>   		return hp->hook.getprocattr(p, name, value);
>>> @@ -1926,7 +1937,7 @@ int security_setprocattr(const char *lsm, const=
 char *name, void *value,
>>>   {
>>>   	struct security_hook_list *hp;
>>> -	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>>> +	for_each_enabled_hook(hp, setprocattr) {
>>>   		if (lsm !=3D NULL && strcmp(lsm, hp->lsm))
>>>   			continue;
>>>   		return hp->hook.setprocattr(name, value, size);
>>> @@ -2327,8 +2338,7 @@ int security_xfrm_state_pol_flow_match(struct x=
frm_state *x,
>>>   	 * For speed optimization, we explicitly break the loop rather tha=
n
>>>   	 * using the macro
>>>   	 */
>>> -	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_m=
atch,
>>> -				list) {
>>> +	for_each_enabled_hook(hp, xfrm_state_pol_flow_match) {
>>>   		rc =3D hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
>>>   		break;
>>>   	}
>>> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
>>> index 996d35d950f7..f64290de1f8a 100644
>>> --- a/security/selinux/Kconfig
>>> +++ b/security/selinux/Kconfig
>>> @@ -26,7 +26,6 @@ config SECURITY_SELINUX_BOOTPARAM
>>>   config SECURITY_SELINUX_DISABLE
>>>   	bool "NSA SELinux runtime disable"
>>>   	depends on SECURITY_SELINUX
>>> -	select SECURITY_WRITABLE_HOOKS
>>>   	default n
>>>   	help
>>>   	  This option enables writing to a selinuxfs node 'disable', which=

>>> @@ -37,8 +36,8 @@ config SECURITY_SELINUX_DISABLE
>>>   	  portability across platforms where boot parameters are difficult=

>>>   	  to employ.
>>> -	  NOTE: selecting this option will disable the '__ro_after_init'
>>> -	  kernel hardening feature for security hooks.   Please consider
>>> +	  NOTE: Selecting this option might cause memory leaks and random
>>> +	  crashes when the runtime disable is used. Please consider
>>>   	  using the selinux=3D0 boot parameter instead of enabling this
>>>   	  option.
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 47626342b6e5..b76acd98dda5 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -123,7 +123,13 @@ __setup("enforcing=3D", enforcing_setup);
>>>   #define selinux_enforcing_boot 1
>>>   #endif
>>> -int selinux_enabled __lsm_ro_after_init =3D 1;
>>> +/* Currently required to handle SELinux runtime hook disable. */
>>> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>>> +int selinux_enabled =3D 1;
>>> +#else
>>> +int selinux_enabled __ro_after_init =3D 1;
>>> +#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
>>> +
>>>   #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
>>>   static int __init selinux_enabled_setup(char *str)
>>>   {
>>> @@ -6827,7 +6833,7 @@ static int selinux_lockdown(enum lockdown_reaso=
n what)
>>>   				    LOCKDOWN__CONFIDENTIALITY, &ad);
>>>   }
>>> -struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init =3D {
>>> +struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
>>>   	.lbs_cred =3D sizeof(struct task_security_struct),
>>>   	.lbs_file =3D sizeof(struct file_security_struct),
>>>   	.lbs_inode =3D sizeof(struct inode_security_struct),
>>> @@ -6896,7 +6902,7 @@ static int selinux_perf_event_write(struct perf=
_event *event)
>>>   }
>>>   #endif
>>> -static struct security_hook_list selinux_hooks[] __lsm_ro_after_init=
 =3D {
>>> +static struct security_hook_list selinux_hooks[] __ro_after_init =3D=
 {
>>>   	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_m=
gr),
>>>   	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>>>   	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_bind=
er),
>>> @@ -7145,6 +7151,15 @@ static struct security_hook_list selinux_hooks=
[] __lsm_ro_after_init =3D {
>>>   static __init int selinux_init(void)
>>>   {
>>> +	struct security_hook_array hook_array =3D {
>>> +		.hooks =3D selinux_hooks,
>>> +		.count =3D ARRAY_SIZE(selinux_hooks),
>>> +		.lsm =3D "selinux",
>>> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>>> +		.enabled =3D &selinux_enabled,
>>> +#endif
>>> +	};
>>> +
>>>   	pr_info("SELinux:  Initializing.\n");
>>>   	memset(&selinux_state, 0, sizeof(selinux_state));
>>> @@ -7166,7 +7181,7 @@ static __init int selinux_init(void)
>>>   	hashtab_cache_init();
>>> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selin=
ux");
>>> +	security_add_hook_array(&hook_array);
>>>   	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_R=
ESET))
>>>   		panic("SELinux: Unable to register AVC netcache callback\n");
>>> @@ -7319,9 +7334,10 @@ int selinux_disable(struct selinux_state *stat=
e)
>>>   	pr_info("SELinux:  Disabled at runtime.\n");
>>> -	selinux_enabled =3D 0;
>>> +	/* Unregister netfilter hooks. */
>>> +	selinux_nf_ip_exit();
>>> -	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
>>> +	WRITE_ONCE(selinux_enabled, 0);
>>>   	/* Try to destroy the avc node cache */
>>>   	avc_disable();
>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>> index ecea41ce919b..c21dda12bc4b 100644
>>> --- a/security/smack/smack_lsm.c
>>> +++ b/security/smack/smack_lsm.c
>>> @@ -4583,7 +4583,7 @@ static int smack_dentry_create_files_as(struct =
dentry *dentry, int mode,
>>>   	return 0;
>>>   }
>>> -struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init =3D {
>>> +struct lsm_blob_sizes smack_blob_sizes __ro_after_init =3D {
>>>   	.lbs_cred =3D sizeof(struct task_smack),
>>>   	.lbs_file =3D sizeof(struct smack_known *),
>>>   	.lbs_inode =3D sizeof(struct inode_smack),
>>> @@ -4591,7 +4591,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro=
_after_init =3D {
>>>   	.lbs_msg_msg =3D sizeof(struct smack_known *),
>>>   };
>>> -static struct security_hook_list smack_hooks[] __lsm_ro_after_init =3D=
 {
>>> +static struct security_hook_list smack_hooks[] __ro_after_init =3D {=

>>>   	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>>>   	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>>>   	LSM_HOOK_INIT(syslog, smack_syslog),
>>> @@ -4765,6 +4765,11 @@ static __init void init_smack_known_list(void)=

>>>    */
>>>   static __init int smack_init(void)
>>>   {
>>> +	struct security_hook_array hook_array =3D {
>>> +		.hooks =3D smack_hooks,
>>> +		.count =3D ARRAY_SIZE(smack_hooks),
>>> +		.lsm =3D "smack",
>>> +	};
>>>   	struct cred *cred =3D (struct cred *) current->cred;
>>>   	struct task_smack *tsp;
>>> @@ -4787,7 +4792,7 @@ static __init int smack_init(void)
>>>   	/*
>>>   	 * Register with LSM
>>>   	 */
>>> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
>>> +	security_add_hook_array(&hook_array);
>>>   	smack_enabled =3D 1;
>>>   	pr_info("Smack:  Initializing.\n");
>>> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
>>> index 716c92ec941a..a4075379246d 100644
>>> --- a/security/tomoyo/tomoyo.c
>>> +++ b/security/tomoyo/tomoyo.c
>>> @@ -486,7 +486,7 @@ static int tomoyo_socket_sendmsg(struct socket *s=
ock, struct msghdr *msg,
>>>   	return tomoyo_socket_sendmsg_permission(sock, msg, size);
>>>   }
>>> -struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init =3D {
>>> +struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init =3D {
>>>   	.lbs_task =3D sizeof(struct tomoyo_task),
>>>   };
>>> @@ -533,7 +533,7 @@ static void tomoyo_task_free(struct task_struct *=
task)
>>>    * tomoyo_security_ops is a "struct security_operations" which is u=
sed for
>>>    * registering TOMOYO.
>>>    */
>>> -static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init =
=3D {
>>> +static struct security_hook_list tomoyo_hooks[] __ro_after_init =3D =
{
>>>   	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
>>>   	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
>>>   	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
>>> @@ -569,7 +569,7 @@ static struct security_hook_list tomoyo_hooks[] _=
_lsm_ro_after_init =3D {
>>>   /* Lock for GC. */
>>>   DEFINE_SRCU(tomoyo_ss);
>>> -int tomoyo_enabled __lsm_ro_after_init =3D 1;
>>> +int tomoyo_enabled __ro_after_init =3D 1;
>>>   /**
>>>    * tomoyo_init - Register TOMOYO Linux as a LSM module.
>>> @@ -578,10 +578,15 @@ int tomoyo_enabled __lsm_ro_after_init =3D 1;
>>>    */
>>>   static int __init tomoyo_init(void)
>>>   {
>>> +	struct security_hook_array hook_array =3D {
>>> +		.hooks =3D tomoyo_hooks,
>>> +		.count =3D ARRAY_SIZE(tomoyo_hooks),
>>> +		.lsm =3D "tomoyo",
>>> +	};
>>>   	struct tomoyo_task *s =3D tomoyo_task(current);
>>>   	/* register ourselves with the security framework */
>>> -	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo"=
);
>>> +	security_add_hook_array(&hook_array);
>>>   	pr_info("TOMOYO Linux initialized\n");
>>>   	s->domain_info =3D &tomoyo_kernel_domain;
>>>   	atomic_inc(&tomoyo_kernel_domain.users);
>>> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
>>> index 94dc346370b1..ed752f6eafcf 100644
>>> --- a/security/yama/yama_lsm.c
>>> +++ b/security/yama/yama_lsm.c
>>> @@ -421,7 +421,7 @@ static int yama_ptrace_traceme(struct task_struct=
 *parent)
>>>   	return rc;
>>>   }
>>> -static struct security_hook_list yama_hooks[] __lsm_ro_after_init =3D=
 {
>>> +static struct security_hook_list yama_hooks[] __ro_after_init =3D {
>>>   	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>>>   	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
>>>   	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
>>> @@ -476,8 +476,14 @@ static inline void yama_init_sysctl(void) { }
>>>   static int __init yama_init(void)
>>>   {
>>> +	struct security_hook_array hook_array =3D {
>>> +		.hooks =3D yama_hooks,
>>> +		.count =3D ARRAY_SIZE(yama_hooks),
>>> +		.lsm =3D "yama",
>>> +	};
>>> +
>>>   	pr_info("Yama: becoming mindful.\n");
>>> -	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
>>> +	security_add_hook_array(&hook_array);
>>>   	yama_init_sysctl();
>>>   	return 0;
>>>   }
>>>

