Return-Path: <SRS0=26Hx=W2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782C6C3A59B
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 13:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDC922CE9
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 13:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pfN0d3qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfH3Now (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:44:52 -0400
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:17904 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfH3Nov (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Aug 2019 09:44:51 -0400
X-EEMSG-check-017: 16799825|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,447,1559520000"; 
   d="scan'208";a="16799825"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Aug 2019 13:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567172664; x=1598708664;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XUBHxWU1Z7Jm0bL4OinM71Tbd9LjL3nrkYVjh7bFyfU=;
  b=pfN0d3qk7ux7jOtJGqCdayNFIqNluYMKzZUGobHBYtgx/1Ukxz9EZnim
   vMuLeYrGnm1UJ/j7RZniw61P0GsSLz/VvNdXXuK3o9oPCjDHvp7RjKbfF
   TJs0BUj8ETFas0vorOoNWHI6gIhVokG9QeukiJG5c+pOcM7OaHR/Xjw96
   wKI9G+OpQULXaqO0/m2UasZmThDND3iwCQmsJwvg6aQmFwmoO6+CN6VwH
   9t6rPbIYaFj4gYGE+9q+Fwb5qLkDwoagaS+T3BoMCWJsyMt0oo3Q0s8h7
   Yiqp9LhIx67I0i/3oWiSDcJJkzoe47FDcKmSDkF7NMb0ZJMj5rEjnD5cw
   A==;
X-IronPort-AV: E=Sophos;i="5.64,447,1559520000"; 
   d="scan'208";a="27376410"
IronPort-PHdr: =?us-ascii?q?9a23=3A+yffLBDuSOF2vPeouInuUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP35rsiwAkXT6L1XgUPTWs2DsrQY0rCQ6v68EjJdqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5sIBmssAnct8YbjYRjJ6sx1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBu6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwqIwl5?=
 =?us-ascii?q?UPsUTDGTX6mEPqg6+Nakoo4O2o6+XjYrn+p5+cMZF7ih3mP6gzlcGyDv40Pw?=
 =?us-ascii?q?gTU2SB5+ix26Pv8VfkTLlSi/05iKjZsJTUJcQBoa65BhdY0p0+5BakFDqmzN?=
 =?us-ascii?q?QZkmUHLFJCYh6HiZPpNEvULPD3Cve/nUygkC13yPDeIr3hHpLNI2DbkLj7YL?=
 =?us-ascii?q?Z971VRyBIpwtBC45JYE7QBIPX0Wk/rqtPUFAM2Mwuxw+z/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7Ss1qI5uU1I+mWZY8Voy3wK/4/6P7rk3A5mEURfa6z3ZsYcHq4BOhpI1?=
 =?us-ascii?q?2FYXrwhdcMCXwKsRQkTOzlllKPSj5TaGy2X6I45jA7DpiqApvERoComLaBxj?=
 =?us-ascii?q?u0HoVKZmBaDVCBCXToeJuaVPcXdC2SJchhkj8fWLe9S48hzxautAr7y7p6K+?=
 =?us-ascii?q?rY4CoYtYjs1NJt/e3ciQky9SBoD8Say2yCU3t7nngWSD42x61/ulByyleZ3q?=
 =?us-ascii?q?hljfxYEcJc5+lQXggmL5HQ1fB1C9f3WgjZZNeGVE6mQsm6ATE2Vt8x2dAObF?=
 =?us-ascii?q?1mFtW4kB/MwiqqDKUJl7CRGJM09afc1WDrJ8lh03bGyLUhj14+T8tLNG2mgL?=
 =?us-ascii?q?N/9gfKC4HTjkWWiqeqdbgH0S7X6miM0GqOs1tEUAJqTarFWnUfbFPMrdvl/k?=
 =?us-ascii?q?PCU6OuCbM/PwtFyM6CLLZKa9LwgVVdWvjsJMneY3iwm2esBReE37aMbI33dG?=
 =?us-ascii?q?UA2CXSFlMJkx4c/XmYLwgyHCShrHzEDDxoC13vZ1ng8e5kqHO0VkU01R2Fb1?=
 =?us-ascii?q?V917qp/R4YneecRO0X3rIFvichtjp1EU2j39LZFdWAvRBtfKZCbtMn5ldIy2?=
 =?us-ascii?q?bZuxZ6Ppy6IKAxzmIZJi1+pUTonzpwC4lNlYB+pXglywt+JIqEwVhBcHWexp?=
 =?us-ascii?q?m2NbrJfC265Bmyb4bO00zaldOR/b0Crv8/rgbNpgasQ3E+/m1n3t8d6H6V4p?=
 =?us-ascii?q?HHHUJGSp7qelom/Bh94bfBa28y4J2Chi4kCrW9rjKXg4FhP+Ai0Bv1Oo4CYa?=
 =?us-ascii?q?4=3D?=
X-IPAS-Result: =?us-ascii?q?A2AAAQDfJmld/wHyM5BmGwEBAQEDAQEBBwMBAQGBZ4FuK?=
 =?us-ascii?q?oFAMhYUhCGQdSV+iHGRJgkBAQEBAQEBAQE0AQIBAYQ/AoJgIzgTAgsBAQEEA?=
 =?us-ascii?q?QEBAQEGAwEBbIU6gjopAYJmAQEBAQIBIwQRQRALDgoCAiYCAlcGAQwGAgEBg?=
 =?us-ascii?q?l8/JwGBTwUPrFN/M4VKgz6BSYEMKIgFg3MYgX+BEScMgio1PodPglgElUKWT?=
 =?us-ascii?q?YIpgieSKgYbmGKNcpRrhWghgVgrCAIYCCEPgyeCThcVjikjAzCBBgEBixklg?=
 =?us-ascii?q?i0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Aug 2019 13:44:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7UDiJtA007015;
        Fri, 30 Aug 2019 09:44:19 -0400
Subject: Re: [RFC PATCH] audit, security: allow LSMs to selectively enable
 audit collection
To:     Aaron Goidel <acgoide@tycho.nsa.gov>, paul@paul-moore.com
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        casey@schaufler-ca.com, rgb@redhat.com, linux-audit@redhat.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <20190815174111.6309-1-acgoide@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <edfe85bc-108a-f0cb-8678-67dc143284d5@tycho.nsa.gov>
Date:   Fri, 30 Aug 2019 09:44:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190815174111.6309-1-acgoide@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/15/19 1:41 PM, Aaron Goidel wrote:
> Presently, there is no way for LSMs to enable collection of supplemental
> audit records such as path and inode information when a permission denial
> occurs. Provide a LSM hook to allow LSMs to selectively enable collection
> on a per-task basis, even if the audit configuration would otherwise
> disable auditing of a task and/or contains no audit filter rules. If the
> hook returns a non-zero result, collect all available audit information. If
> the hook generates its own audit record, then supplemental audit
> information will be emitted at syscall exit.
> 
> In SELinux, we implement this hook by returning the result of a permission
> check on the process. If the new process2:audit_enable permission is
> allowed by the policy, then audit collection will be enabled for that
> process. Otherwise, SELinux will defer to the audit configuration.

Any feedback on this RFC patch?  I know Paul provided some thoughts on 
the general topic of LSM/audit enablement in the other patch thread but 
I haven't seen any response to this patch.

> 
> Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> ---
>   include/linux/lsm_hooks.h           |  7 +++++++
>   include/linux/security.h            |  7 ++++++-
>   kernel/auditsc.c                    | 10 +++++++---
>   security/security.c                 |  5 +++++
>   security/selinux/hooks.c            | 11 +++++++++++
>   security/selinux/include/classmap.h |  2 +-
>   6 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index ead98af9c602..7d70a6759621 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1380,6 +1380,11 @@
>    *	audit_rule_init.
>    *	@lsmrule contains the allocated rule
>    *
> + * @audit_enable:
> + *	Allow the security module to selectively enable audit collection
> + *	on permission denials based on whether or not @tsk has the
> + *	process2:audit_enable permission.
> + *
>    * @inode_invalidate_secctx:
>    *	Notify the security module that it must revalidate the security context
>    *	of an inode.
> @@ -1800,6 +1805,7 @@ union security_list_options {
>   	int (*audit_rule_known)(struct audit_krule *krule);
>   	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule);
>   	void (*audit_rule_free)(void *lsmrule);
> +	int (*audit_enable)(struct task_struct *tsk);
>   #endif /* CONFIG_AUDIT */
>   
>   #ifdef CONFIG_BPF_SYSCALL
> @@ -2043,6 +2049,7 @@ struct security_hook_heads {
>   	struct hlist_head audit_rule_known;
>   	struct hlist_head audit_rule_match;
>   	struct hlist_head audit_rule_free;
> +	struct hlist_head audit_enable;
>   #endif /* CONFIG_AUDIT */
>   #ifdef CONFIG_BPF_SYSCALL
>   	struct hlist_head bpf;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7d9c1da1f659..7be66db8de4e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1719,7 +1719,7 @@ int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>   int security_audit_rule_known(struct audit_krule *krule);
>   int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
>   void security_audit_rule_free(void *lsmrule);
> -
> +int security_audit_enable(struct task_struct *tsk);
>   #else
>   
>   static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
> @@ -1742,6 +1742,11 @@ static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
>   static inline void security_audit_rule_free(void *lsmrule)
>   { }
>   
> +static inline int security_audit_enable(struct task_struct *tsk)
> +{
> +	return 0;
> +}
> +
>   #endif /* CONFIG_SECURITY */
>   #endif /* CONFIG_AUDIT */
>   
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 95ae27edd417..7e052b71bc42 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -906,8 +906,12 @@ int audit_alloc(struct task_struct *tsk)
>   
>   	state = audit_filter_task(tsk, &key);
>   	if (state == AUDIT_DISABLED) {
> -		clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
> -		return 0;
> +		if (security_audit_enable(tsk)) {
> +			state = AUDIT_BUILD_CONTEXT;
> +		} else {
> +			clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
> +			return 0;
> +		}
>   	}
>   
>   	if (!(context = audit_alloc_context(state))) {
> @@ -1623,7 +1627,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
>   	if (state == AUDIT_DISABLED)
>   		return;
>   
> -	context->dummy = !audit_n_rules;
> +	context->dummy = !audit_n_rules && !security_audit_enable(current);
>   	if (!context->dummy && state == AUDIT_BUILD_CONTEXT) {
>   		context->prio = 0;
>   		if (auditd_test_task(current))
> diff --git a/security/security.c b/security/security.c
> index 30687e1366b7..04e160e5d4ab 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2333,6 +2333,11 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>   {
>   	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
>   }
> +
> +int security_audit_enable(struct task_struct *tsk)
> +{
> +	return call_int_hook(audit_enable, 0, tsk);
> +}
>   #endif /* CONFIG_AUDIT */
>   
>   #ifdef CONFIG_BPF_SYSCALL
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d55571c585ff..88764aa0ab43 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6628,6 +6628,16 @@ static void selinux_ib_free_security(void *ib_sec)
>   }
>   #endif
>   
> +#ifdef CONFIG_AUDIT
> +static int selinux_audit_enable(struct task_struct *tsk)
> +{
> +	u32 sid = current_sid();
> +
> +	return !avc_has_perm(&selinux_state, sid, sid, SECCLASS_PROCESS2,
> +			PROCESS2__AUDIT_ENABLE, NULL);
> +}
> +#endif
> +
>   #ifdef CONFIG_BPF_SYSCALL
>   static int selinux_bpf(int cmd, union bpf_attr *attr,
>   				     unsigned int size)
> @@ -6999,6 +7009,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(audit_rule_known, selinux_audit_rule_known),
>   	LSM_HOOK_INIT(audit_rule_match, selinux_audit_rule_match),
>   	LSM_HOOK_INIT(audit_rule_free, selinux_audit_rule_free),
> +	LSM_HOOK_INIT(audit_enable, selinux_audit_enable),
>   #endif
>   
>   #ifdef CONFIG_BPF_SYSCALL
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 32e9b03be3dd..d7d856cbd486 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -52,7 +52,7 @@ struct security_class_mapping secclass_map[] = {
>   	    "execmem", "execstack", "execheap", "setkeycreate",
>   	    "setsockcreate", "getrlimit", NULL } },
>   	{ "process2",
> -	  { "nnp_transition", "nosuid_transition", NULL } },
> +	  { "nnp_transition", "nosuid_transition", "audit_enable", NULL } },
>   	{ "system",
>   	  { "ipc_info", "syslog_read", "syslog_mod",
>   	    "syslog_console", "module_request", "module_load", NULL } },
> 

