Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE03C6FD1D
	for <selinux@archiver.kernel.org>; Fri, 17 Mar 2023 23:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjCQXPW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Mar 2023 19:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCQXPV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Mar 2023 19:15:21 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9751B320
        for <selinux@vger.kernel.org>; Fri, 17 Mar 2023 16:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1679094917; bh=r3aiX50RcpEk9uDEfimDDZ9TY/xdJNl4wTw1AXWiSKM=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=ChyK8WC9+B6/SmX/jVruq19oCdpJUIG1Q/82ophS/NG8L6voHgxI845gwIGDItepH1HOsWsD4Cqc5hxROgCDHwB+cWCc174SkYemNXJI8Rc4sxruMQwh014fqr8IIhxF5hkDgNyhXEWwukfys2SynkDzB65ZsFXjXoHGwynQz8Ofy+jlxXK7nfeRMCSGH6tS9A4fPAyId6vS6rvtjPeSjhP7p4iGqlGCkwvgVibo+5qD1arHGyr+3Ucc7KkA1P0/u9q+1GvaUGTOJhViwztH/7f3u5r99aUE8+PMihKpyYz0Nm88eZ51Sg1/VQLDAB5C+uIDkeqxEwI1Q7nuqa+yDQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1679094917; bh=k/lQH0OaNCIYUsJdkM9HoBU6UgaWfjoityjGp4ppjQi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RXWbX9hdw7cXPT1arXqxBVjoLD8n1TY3mlSvHjNgKbGmUdv7Njf236b59YUWycjoXdSzz3nnqqDJAu+a8usGQqLdiJegi2JhD5MdPSVjI22DBPyyB7Mo93Xu1AABELRK5jdbTWw2odb82DRXz7mEammZuAmQSsNgO+A6yrxhMr9QAXAcs3YCdUjCh3ebFWWeNNDaYjDqRgIw3cHGghVJfKEqiuVML7nlPsD7wkWrW7LAXATS0C3rOHFgDKhe9xwQWHt4VFoGKCuBd1GoOsounLhF7+hQ1KmZnvepuGiZrCQz/1BcCrp+IsTFj3db8gNQwRsYC2d/D/JPpgl55ukThA==
X-YMail-OSG: SiGWebYVM1mkdedeb.h1qCazmZZpHcpP9GqeinkoMA.wgZpptJUKFOOELscDssh
 ThIL8m6fSJH4NHXheju_8uTJIA44nuGqPth80755yEh15uIKCeq74h1lqUG9ENgM1ej2R5GhhS3u
 fCNA6Pd03_YyEPqzPz_R7JDHDOFAbcuk_ql3wSzWs_SL76tUjPmyQxeD1db42OqHvheoyOgCh309
 Q5KZIKQTV83jnSL4qP5d0Lplr2F8ob7rfX9ka46dxTX9cQDv_TUHNPTCjMPH.zPH_V7H0AVF.JjC
 GukGoH.bhKEO0nlRk1HkBWVqupI8ikDpF8KvzqyE1Prghk.DzeggyXtwMr_ozuL1QrqMW9dAUJgO
 XHXFdq7wPu.j_RgGRv3SEdW0Q83dqAAp0Jztltki0g3JMpfuxLhR69nJ12xNCVwLdo8_m0g63BRP
 iA0io8UOz_0dtxiI3B92ltVIE50ezSqOy3H5xjPAEHvlpDKapRn302I.vauu3MAV_k_6Tuw7DWfr
 krCKRRWDTBUdzINGx0IOGfy05SWvDp43pv.ELV64MbbEkauIXVYGyCKSf6epfebPNEFgitSDdgzs
 ECC2uGahQ14WYreUxce.kLL4qdsPqrvRm3BkslymHMSO5D0E7D6cF6jVB18D1Ya9A7ciVMTGGylX
 _pRaBz6qxdkFE6VOm9ibFRR6TsIy1mYSjXJY5BMvRvdoo0JrztZKuLK23sdBkO8BJwFBCDy8u1cA
 xtB6CDF1ty1XDQ1mWOOmjj_RVRTxcM159XAD4ZWyCEB4tc8geL12cnOlO8cDpxr0NqJenGVbPwez
 C0ses1T.686pfNobZaa9drFVGyxTs7g8zOCX1BmHNf38MjYi55lAJbKlw34_lKc7nagjGj7b1rDv
 ekBa7aTHFTMvqaAteBgtivRFX0PHnAnZ362uJbbc18qh5Q73qmbc7VPtrH5BEIdDKu2aYYhm4.BS
 7KU63uMNyo4OcDFgCSpxB0wGIxKVYt_uL4urrBOqQOdkztEHQnIJ0WQF.ihC428nPq.V72tUIuf2
 MciB_8qV5RadZBUzL0Uv5s9bgI.pIz47svODl2tRRIberEn9xfLjatw30txgPeknI4a5RpS1D3Z7
 YQwupzHrueKdXXSxmQi02RPYUeEtnIRpoADfXkbVtJc4HQtVqCzCf8Xl8clzafSV0i89A5_DM1n0
 aML9G28qrptmGjw.bUoaSAhgbhw8wE5vpi0sojbczTKN3DnU0bE1xNlrXrCLOpaGEzVsKNFtH7Br
 mbssKdv2J.IMyGVQB_Z.o60qNHGFiPhoNRIjZKwgCuozHm7QVGKZ.C9qbyt_.I5lIeUw.gqLkFZQ
 dluh2QhZSg_5raFcx9SQ_upPAvbHqNw3KIKzZQUQnb997Vcfw8NXyEWri2HEL3K_lT5FbafIePIJ
 pSLygAXjDmFOkyzj0dg0e31_ROyLOwJy91qinUv16XNrIRlnQqFrtqhgyn27OJo1DiID2NtMYK40
 bzYXoOgSwH5QTHGqK8EkJ1iJkJZ6EddJ.vleKcLs169eC0Q5oZkf.Mtzu7PgwjeIppfbTdb0W_lE
 vwi1r1VICu0jGUgZKnkJ_9ln3i3ft.Ho4i4CceLpPLofGLmwdKVT8K1oratmiZd86tHxPxCIjd2O
 _De1g9KCApc1pKU6LM34aZ8NYuPt5upB84q3JR1OT0wgqhZMA.qaPERx2XkODGXAf68LCRA0Tmhy
 3Yl4LqiGQaCNlOJquYUK88Xp3yIicGXJwbRRQkOjocc05BeMcEElcBZUDfPj2akv1UcKSgwf4ifr
 Xw2b1w9N207ecNoac82b.c.LP2gnp0FPDBBS_LqFzPa_ndL6yyOylKUz2QwcfRn1FH0RGdlkgNNy
 IHCpUjbxSLHDXLs_M3QabuEFPHXfGjQdDbGLGuVpGOmQGjCZULHgfOqN4JIb84CrhnS10iubCBoZ
 raB4ZymxbtX9iaOHpF77LUO.zdfZ50CtQZ93rUhVLZruDFBxrX8IVNo0oZyUHcyf9NMDWESy2gcR
 FasEaVeNEaeHH01PioVRwWKAgj0fXdBw5_xoS3wX_UIseFYDDeEN2j3mmT792Nyt4QbLGmMeF4qE
 jH1V8iecz2vctOWZI4xhxeXDalyQVgRPLr2PdID5ppcmY96IRf.mrxvjrf6NBL4QrCLwyei4qyhN
 PK0nMIK09Ivh4cX.W6F3oXsx6CA7Y2ey0ttu4hSDpmtpIdWrQEbBPkt6PRi4IC6Z1UZ.IgM0LcMv
 TWumQhpjrHNEaPahO0M9GuKHgyuIdI4Z9GmPJh9E-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 38a97d6a-be44-4112-b257-b3e95ffde5a7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 17 Mar 2023 23:15:17 +0000
Received: by hermes--production-bf1-777648578f-75chz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e2087e038d5c0d457a2403774578b4b2;
          Fri, 17 Mar 2023 23:15:11 +0000 (UTC)
Message-ID: <da4e7d33-29ab-2dd0-ef46-20f60998bae9@schaufler-ca.com>
Date:   Fri, 17 Mar 2023 16:15:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selinux: remove the runtime disable functionality
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20230317195615.281810-1-paul@paul-moore.com>
Content-Language: en-US
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230317195615.281810-1-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21311 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/17/2023 12:56 PM, Paul Moore wrote:
> After working with the larger SELinux-based distros for several
> years, we're finally at a place where we can disable the SELinux
> runtime disable functionality.  The existing kernel deprecation
> notice explains the functionality and why we want to remove it:
>
>   The selinuxfs "disable" node allows SELinux to be disabled at
>   runtime prior to a policy being loaded into the kernel.  If
>   disabled via this mechanism, SELinux will remain disabled until
>   the system is rebooted.
>
>   The preferred method of disabling SELinux is via the "selinux=0"
>   boot parameter, but the selinuxfs "disable" node was created to
>   make it easier for systems with primitive bootloaders that did not
>   allow for easy modification of the kernel command line.
>   Unfortunately, allowing for SELinux to be disabled at runtime makes
>   it difficult to secure the kernel's LSM hooks using the
>   "__ro_after_init" feature.
>
> It is that last sentence, mentioning the '__ro_after_init' hardening,
> which is the real motivation for this change, and if you look at the
> diffstat you'll see that the impact of this patch reaches across all
> the different LSMs, helping prevent tampering at the LSM hook level.
>
> >From a SELinux perspective, it is important to note that if you
> continue to disable SELinux via "/etc/selinux/config" it may appear
> that SELinux is disabled, but it is simply in an uninitialized state.
> If you load a policy with `load_policy -i`, you will see SELinux
> come alive just as if you had loaded the policy during early-boot.
>
> It is also worth noting that the "/sys/fs/selinux/disable" file is
> always writable now, regardless of the Kconfig settings, but writing
> to the file has no effect on the system, other than to display an
> error on the console if a non-zero/true value is written.
>
> Finally, in the several years where we have been working on
> deprecating this functionality, there has only been one instance of
> someone mentioning any user visible breakage.  In this particular
> case it was an individual's kernel test system, and the workaround
> documented in the deprecation notice ("selinux=0" on the kernel
> command line) resolved the issue without problem.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Except for the Documentation fumble noted below, enthusiastically ...
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
or, if you'd prefer ...
Acked-by: Casey Schaufler <casey@schaufler-ca.com>



> ---
>  .../sysfs-selinux-disable                     |  3 +
>  include/linux/lsm_hooks.h                     |  7 ---
>  security/Kconfig                              |  5 --
>  security/apparmor/lsm.c                       |  6 +-
>  security/bpf/hooks.c                          |  4 +-
>  security/commoncap.c                          |  2 +-
>  security/landlock/cred.c                      |  2 +-
>  security/landlock/fs.c                        |  2 +-
>  security/landlock/ptrace.c                    |  2 +-
>  security/landlock/setup.c                     |  4 +-
>  security/loadpin/loadpin.c                    |  2 +-
>  security/lockdown/lockdown.c                  |  2 +-
>  security/security.c                           |  4 +-
>  security/selinux/Kconfig                      | 24 --------
>  security/selinux/hooks.c                      | 57 +------------------
>  security/selinux/include/security.h           | 21 -------
>  security/selinux/selinuxfs.c                  | 43 ++------------
>  security/smack/smack_lsm.c                    |  4 +-
>  security/tomoyo/tomoyo.c                      |  6 +-
>  security/yama/yama_lsm.c                      |  2 +-
>  20 files changed, 32 insertions(+), 170 deletions(-)
>  rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-disable (90%)
>
> diff --git a/Documentation/ABI/obsolete/sysfs-selinux-disable b/Documentation/ABI/removed/sysfs-selinux-disable
> similarity index 90%
> rename from Documentation/ABI/obsolete/sysfs-selinux-disable
> rename to Documentation/ABI/removed/sysfs-selinux-disable
> index c340278e3cf8..dc1433bec23a 100644
> --- a/Documentation/ABI/obsolete/sysfs-selinux-disable
> +++ b/Documentation/ABI/removed/sysfs-selinux-disable
> @@ -4,6 +4,9 @@ KernelVersion:	2.6.12-rc2 (predates git)
>  Contact:	selinux@vger.kernel.org
>  Description:
>  
> +	REMOVAL UPDATE: The SELinux checkreqprot functionality was removed in
> +	March 2023, the original deprecation notice is shown below.
> +

This needs to be corrected to reflect this change.

>  	The selinuxfs "disable" node allows SELinux to be disabled at runtime
>  	prior to a policy being loaded into the kernel.  If disabled via this
>  	mechanism, SELinux will remain disabled until the system is rebooted.
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 6e156d2acffc..af87b962f5f7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1763,13 +1763,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>  }
>  #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
>  
> -/* Currently required to handle SELinux runtime hook disable. */
> -#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> -#define __lsm_ro_after_init
> -#else
> -#define __lsm_ro_after_init	__ro_after_init
> -#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
> -
>  extern int lsm_inode_alloc(struct inode *inode);
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/Kconfig b/security/Kconfig
> index e6db09a779b7..9009893fb3f5 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,11 +32,6 @@ config SECURITY
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> -config SECURITY_WRITABLE_HOOKS
> -	depends on SECURITY
> -	bool
> -	default n
> -
>  config SECURITYFS
>  	bool "Enable the securityfs filesystem"
>  	help
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index d6cc4812ca53..cebba4824e60 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1209,13 +1209,13 @@ static int apparmor_inet_conn_request(const struct sock *sk, struct sk_buff *skb
>  /*
>   * The cred blob is a pointer to, not an instance of, an aa_label.
>   */
> -struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
>  	.lbs_cred = sizeof(struct aa_label *),
>  	.lbs_file = sizeof(struct aa_file_ctx),
>  	.lbs_task = sizeof(struct aa_task_ctx),
>  };
>  
> -static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list apparmor_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
>  	LSM_HOOK_INIT(capget, apparmor_capget),
> @@ -1427,7 +1427,7 @@ static const struct kernel_param_ops param_ops_aaintbool = {
>  	.get = param_get_aaintbool
>  };
>  /* Boot time disable flag */
> -static int apparmor_enabled __lsm_ro_after_init = 1;
> +static int apparmor_enabled __ro_after_init = 1;
>  module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
>  
>  static int __init apparmor_enabled_setup(char *str)
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index e5971fa74fd7..cfaf1d0e6a5f 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -6,7 +6,7 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/bpf_lsm.h>
>  
> -static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>  	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
>  	#include <linux/lsm_hook_defs.h>
> @@ -22,7 +22,7 @@ static int __init bpf_lsm_init(void)
>  	return 0;
>  }
>  
> -struct lsm_blob_sizes bpf_lsm_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
>  	.lbs_inode = sizeof(struct bpf_storage_blob),
>  	.lbs_task = sizeof(struct bpf_storage_blob),
>  };
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 5bb7d1e96277..0b3fc2f3afe7 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1440,7 +1440,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
>  
>  #ifdef CONFIG_SECURITY
>  
> -static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list capability_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(capable, cap_capable),
>  	LSM_HOOK_INIT(settime, cap_settime),
>  	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
> diff --git a/security/landlock/cred.c b/security/landlock/cred.c
> index ec6c37f04a19..13dff2a31545 100644
> --- a/security/landlock/cred.c
> +++ b/security/landlock/cred.c
> @@ -34,7 +34,7 @@ static void hook_cred_free(struct cred *const cred)
>  		landlock_put_ruleset_deferred(dom);
>  }
>  
> -static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
>  	LSM_HOOK_INIT(cred_free, hook_cred_free),
>  };
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index adcea0fe7e68..1c0c198f6fdb 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1280,7 +1280,7 @@ static int hook_file_truncate(struct file *const file)
>  	return -EACCES;
>  }
>  
> -static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>  
>  	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
> diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
> index 4c5b9cd71286..8a06d6c492bf 100644
> --- a/security/landlock/ptrace.c
> +++ b/security/landlock/ptrace.c
> @@ -108,7 +108,7 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
>  	return task_ptrace(parent, current);
>  }
>  
> -static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
>  };
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index 3f196d2ce4f9..0f6113528fa4 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -15,9 +15,9 @@
>  #include "ptrace.h"
>  #include "setup.h"
>  
> -bool landlock_initialized __lsm_ro_after_init = false;
> +bool landlock_initialized __ro_after_init = false;
>  
> -struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
>  	.lbs_cred = sizeof(struct landlock_cred_security),
>  	.lbs_file = sizeof(struct landlock_file_security),
>  	.lbs_inode = sizeof(struct landlock_inode_security),
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index d73a281adf86..b9d773f11232 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -214,7 +214,7 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
>  	return loadpin_check(NULL, (enum kernel_read_file_id) id);
>  }
>  
> -static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list loadpin_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>  	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
>  	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index a79b985e917e..68d19632aeb7 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -71,7 +71,7 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
>  	return 0;
>  }
>  
> -static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list lockdown_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
>  };
>  
> diff --git a/security/security.c b/security/security.c
> index cf6cc576736f..f4e45992472e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -74,14 +74,14 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> +struct security_hook_heads security_hook_heads __ro_after_init;
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>  
>  static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
>  
>  char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +static struct lsm_blob_sizes blob_sizes __ro_after_init;
>  
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_lsm_order;
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 4ea946123255..95a186ec0fcb 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -23,30 +23,6 @@ config SECURITY_SELINUX_BOOTPARAM
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> -config SECURITY_SELINUX_DISABLE
> -	bool "NSA SELinux runtime disable"
> -	depends on SECURITY_SELINUX
> -	select SECURITY_WRITABLE_HOOKS
> -	default n
> -	help
> -	  This option enables writing to a selinuxfs node 'disable', which
> -	  allows SELinux to be disabled at runtime prior to the policy load.
> -	  SELinux will then remain disabled until the next boot.
> -	  This option is similar to the selinux=0 boot parameter, but is to
> -	  support runtime disabling of SELinux, e.g. from /sbin/init, for
> -	  portability across platforms where boot parameters are difficult
> -	  to employ.
> -
> -	  NOTE: selecting this option will disable the '__ro_after_init'
> -	  kernel hardening feature for security hooks.   Please consider
> -	  using the selinux=0 boot parameter instead of enabling this
> -	  option.
> -
> -	  WARNING: this option is deprecated and will be removed in a future
> -	  kernel release.
> -
> -	  If you are unsure how to answer this question, answer N.
> -
>  config SECURITY_SELINUX_DEVELOP
>  	bool "NSA SELinux Development Support"
>  	depends on SECURITY_SELINUX
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9a58971f9a16..79b4890e9936 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6769,7 +6769,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  }
>  #endif
>  
> -struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>  	.lbs_cred = sizeof(struct task_security_struct),
>  	.lbs_file = sizeof(struct file_security_struct),
>  	.lbs_inode = sizeof(struct inode_security_struct),
> @@ -6905,7 +6905,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>   * safely. Breaking the ordering rules above might lead to NULL pointer derefs
>   * when disabling SELinux at runtime.
>   */
> -static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>  	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
> @@ -7253,7 +7253,6 @@ DEFINE_LSM(selinux) = {
>  };
>  
>  #if defined(CONFIG_NETFILTER)
> -
>  static const struct nf_hook_ops selinux_nf_ops[] = {
>  	{
>  		.hook =		selinux_ip_postroute,
> @@ -7328,56 +7327,4 @@ static int __init selinux_nf_ip_init(void)
>  	return 0;
>  }
>  __initcall(selinux_nf_ip_init);
> -
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -static void selinux_nf_ip_exit(void)
> -{
> -	pr_debug("SELinux:  Unregistering netfilter hooks\n");
> -
> -	unregister_pernet_subsys(&selinux_net_ops);
> -}
> -#endif
> -
> -#else /* CONFIG_NETFILTER */
> -
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -#define selinux_nf_ip_exit()
> -#endif
> -
>  #endif /* CONFIG_NETFILTER */
> -
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -int selinux_disable(void)
> -{
> -	if (selinux_initialized()) {
> -		/* Not permitted after initial policy load. */
> -		return -EINVAL;
> -	}
> -
> -	if (selinux_disabled()) {
> -		/* Only do this once. */
> -		return -EINVAL;
> -	}
> -
> -	selinux_mark_disabled();
> -
> -	pr_info("SELinux:  Disabled at runtime.\n");
> -
> -	/*
> -	 * Unregister netfilter hooks.
> -	 * Must be done before security_delete_hooks() to avoid breaking
> -	 * runtime disable.
> -	 */
> -	selinux_nf_ip_exit();
> -
> -	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
> -
> -	/* Try to destroy the avc node cache */
> -	avc_disable();
> -
> -	/* Unregister selinuxfs. */
> -	exit_sel_fs();
> -
> -	return 0;
> -}
> -#endif
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 312112d214bb..8746fafeb778 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -89,9 +89,6 @@ extern int selinux_enabled_boot;
>  struct selinux_policy;
>  
>  struct selinux_state {
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -	bool disabled;
> -#endif
>  #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
>  	bool enforcing;
>  #endif
> @@ -148,23 +145,6 @@ static inline bool checkreqprot_get(void)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -static inline bool selinux_disabled(void)
> -{
> -	return READ_ONCE(selinux_state.disabled);
> -}
> -
> -static inline void selinux_mark_disabled(void)
> -{
> -	WRITE_ONCE(selinux_state.disabled, true);
> -}
> -#else
> -static inline bool selinux_disabled(void)
> -{
> -	return false;
> -}
> -#endif
> -
>  static inline bool selinux_policycap_netpeer(void)
>  {
>  	struct selinux_state *state = &selinux_state;
> @@ -404,7 +384,6 @@ struct selinux_kernel_status {
>  extern void selinux_status_update_setenforce(int enforcing);
>  extern void selinux_status_update_policyload(int seqno);
>  extern void selinux_complete_init(void);
> -extern int selinux_disable(void);
>  extern void exit_sel_fs(void);
>  extern struct path selinux_null;
>  extern void selnl_notify_setenforce(int val);
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 68688bc84912..69a583b91fc5 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -267,7 +267,6 @@ static const struct file_operations sel_handle_status_ops = {
>  	.llseek		= generic_file_llseek,
>  };
>  
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>  				 size_t count, loff_t *ppos)
>  
> @@ -275,16 +274,6 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>  	char *page;
>  	ssize_t length;
>  	int new_value;
> -	int enforcing;
> -
> -	/* NOTE: we are now officially considering runtime disable as
> -	 *       deprecated, and using it will become increasingly painful
> -	 *       (e.g. sleeping/blocking) as we progress through future
> -	 *       kernel releases until eventually it is removed
> -	 */
> -	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
> -	pr_err("SELinux:  https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
> -	ssleep(15);
>  
>  	if (count >= PAGE_SIZE)
>  		return -ENOMEM;
> @@ -297,31 +286,21 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>  	if (IS_ERR(page))
>  		return PTR_ERR(page);
>  
> -	length = -EINVAL;
> -	if (sscanf(page, "%d", &new_value) != 1)
> +	if (sscanf(page, "%d", &new_value) != 1) {
> +		length = -EINVAL;
>  		goto out;
> +	}
> +	length = count;
>  
>  	if (new_value) {
> -		enforcing = enforcing_enabled();
> -		length = selinux_disable();
> -		if (length)
> -			goto out;
> -		audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
> -			"enforcing=%d old_enforcing=%d auid=%u ses=%u"
> -			" enabled=0 old-enabled=1 lsm=selinux res=1",
> -			enforcing, enforcing,
> -			from_kuid(&init_user_ns, audit_get_loginuid(current)),
> -			audit_get_sessionid(current));
> +		pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
> +		pr_err("SELinux: Runtime disable is not supported, use selinux=0 on the kernel cmdline.\n");
>  	}
>  
> -	length = count;
>  out:
>  	kfree(page);
>  	return length;
>  }
> -#else
> -#define sel_write_disable NULL
> -#endif
>  
>  static const struct file_operations sel_disable_ops = {
>  	.write		= sel_write_disable,
> @@ -2194,13 +2173,3 @@ static int __init init_sel_fs(void)
>  }
>  
>  __initcall(init_sel_fs);
> -
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -void exit_sel_fs(void)
> -{
> -	sysfs_remove_mount_point(fs_kobj, "selinux");
> -	dput(selinux_null.dentry);
> -	kern_unmount(selinuxfs_mount);
> -	unregister_filesystem(&sel_fs_type);
> -}
> -#endif
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index cfcbb748da25..bc3c3e553133 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4847,7 +4847,7 @@ static int smack_uring_cmd(struct io_uring_cmd *ioucmd)
>  
>  #endif /* CONFIG_IO_URING */
>  
> -struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
>  	.lbs_cred = sizeof(struct task_smack),
>  	.lbs_file = sizeof(struct smack_known *),
>  	.lbs_inode = sizeof(struct inode_smack),
> @@ -4856,7 +4856,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>  	.lbs_superblock = sizeof(struct superblock_smack),
>  };
>  
> -static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list smack_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>  	LSM_HOOK_INIT(syslog, smack_syslog),
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index af04a7b7eb28..25006fddc964 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -499,7 +499,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>  	return tomoyo_socket_sendmsg_permission(sock, msg, size);
>  }
>  
> -struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init = {
>  	.lbs_task = sizeof(struct tomoyo_task),
>  };
>  
> @@ -546,7 +546,7 @@ static void tomoyo_task_free(struct task_struct *task)
>   * tomoyo_security_ops is a "struct security_operations" which is used for
>   * registering TOMOYO.
>   */
> -static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
>  	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
>  	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
> @@ -583,7 +583,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
>  /* Lock for GC. */
>  DEFINE_SRCU(tomoyo_ss);
>  
> -int tomoyo_enabled __lsm_ro_after_init = 1;
> +int tomoyo_enabled __ro_after_init = 1;
>  
>  /**
>   * tomoyo_init - Register TOMOYO Linux as a LSM module.
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 06e226166aab..478be269571a 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -421,7 +421,7 @@ static int yama_ptrace_traceme(struct task_struct *parent)
>  	return rc;
>  }
>  
> -static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list yama_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
>  	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
