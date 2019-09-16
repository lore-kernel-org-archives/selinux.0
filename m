Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B944C49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B24E20830
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="kX6OMO5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfIPTjX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:39:23 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:5694 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPTjX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 15:39:23 -0400
X-EEMSG-check-017: 28360887|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="28360887"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 19:39:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568662760; x=1600198760;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=bD38ql2lTXr7Gu4fwHN/dJmDB+kScpFoFpcY3teQ1YU=;
  b=kX6OMO5rt/KPkK8PoBXD5HmZFtExH15xVxSgzEShs7UdfOHm0P4LNk5k
   i+0KYhDCJEoqhBEzQElxkHHOXBThQ6B4cItKeH/7wh96hcFJVuSw+z7ZK
   Sxogqu01PHWd2f4hLyOD7njNKvL2SpaVqPvNJB9a7AdMVswTX31mi1PzK
   3sOj23L9pfSY9Ed+Bq8yFXduE3VKc7RMNWbWiMAnQK9zjqqeCbg/aC+9g
   ltxqODFhROlq+a4bIeMHwvmV+lxJkCHl+qgbgKCWJMP+ZCaByb0XX1JY9
   +NWEZj1ecAjXHL1Zwo8j99Cb3frysDy+tSqk6SuRSps8JEe6VzwUQgkrR
   A==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="27969958"
IronPort-PHdr: =?us-ascii?q?9a23=3A8hoUFh2H1uF+ICUWsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWLf/xwZ3uMQTl6Ol3ixeRBMOHsqkC0rGd6vy4ESxYuNDd6SpEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQYjId4N6o8xB?=
 =?us-ascii?q?TFrmZHduhK2GhkIU6fkwvm6sq/4ZJv7T5ct+49+8JFTK73Y7k2QbtEATo8Lm?=
 =?us-ascii?q?s7/tfrtR7NTQuO4nsTTGAbmQdWDgbG8R/3QI7/vjP1ueRh1iaaO9b2Ta0vVj?=
 =?us-ascii?q?S586hrUh7ohzwZODM/7Wral9Z/jKNfoBKmuhx/34vZa5ybOfZiYq/Qe84RSH?=
 =?us-ascii?q?FfVchNSSNOHoK8b5MOD+UfO+ZYs5L9rEYKoRenGAWgGP/jxjpOi3D4x6061/?=
 =?us-ascii?q?kqHx/A0gIuAtkCtG3YodvxOasXV+2+0avGwijZb/5OxDnz9obIfBAir/+CU7?=
 =?us-ascii?q?1/fsjexlUgGQ7eklWdq5boMy+J2ukDsWWW6fdrW+K1i24grgF8uiWhxtsyhY?=
 =?us-ascii?q?nRhoIa1FbE/jhkzoYwP9K4TEp7bsCkEZBNsCyaLJZ5Qtg5TmF0uCc11r0GuZ?=
 =?us-ascii?q?mhcCgM05Qo3QTTa/OAc4iW+x/uUvuaLzl/hHJgYr2/hhCy/FCjyuLiTMm01k?=
 =?us-ascii?q?hFri5fntnLrHAN2Bre4dWERPtl5kqtxDmC2g/J5uxEPEw4j7TXJpE/zrIqi5?=
 =?us-ascii?q?Yet1nIEDXsl0XslqCWc10p+u2v6+v6fLrrvoScN4poigHmNaQuh9C/Dfw4Mg?=
 =?us-ascii?q?cQW2ib/vyx1KH58k3jQbVKk+Y2nrPFsJHaOcsbpqm5DxVT0ok/8BawEy2q0N?=
 =?us-ascii?q?EZnXkDNF5FeRSHgJb1O1zWPfz1Aviyj06snTt23fzKILLsDovXInTeiLvheK?=
 =?us-ascii?q?xy609YyAo919Bf4JdUB6kaIP3uQU/8r8DYDx8lPAy0xObrEtN91pgEVm6VDa?=
 =?us-ascii?q?+ZN73SvUeS5u0zO+mMeJMVuDHlJvg/5v7hkX85lkUHfaa0xZQYdGi3HvR8LE?=
 =?us-ascii?q?WYZ3rjnMwBHHwRsQoiTezqjkGCXiBJZ3a0Qa08+is3B56hDYfGXoqtmqCO3D?=
 =?us-ascii?q?+nHp1KYWBLEkuMHmnsd4WFXfcMdS2TL9R/kjwLS7ehUZUt1RKwuw/gzbpoMO?=
 =?us-ascii?q?7U9jcftZL529h///fTmg0q9TxoE8Sd1HmAT3lukWMVQz87x7h/rlZgyleHyK?=
 =?us-ascii?q?R4hvtYFdtJ5/xXSAs1KZncz+kpQ+z1DzjAddeAUlruYtynBzwqBoYrwtQOal?=
 =?us-ascii?q?xxLN6VjhnC2SexK7UJlrqXCYYy/76a1H/0cYI10HvC1a88n3E4TcZVc26rnK?=
 =?us-ascii?q?hy807UHYGN212QiqKCba0B2GvI82CZwCyFu0QLfhR3VPD+QX0HZkbQ5e/870?=
 =?us-ascii?q?fGQq7mXa8rKSNd2MWCLe1McdSvglJYEqSwcO/Can68zj/jTS2DwamBOc+zID?=
 =?us-ascii?q?QQ?=
X-IPAS-Result: =?us-ascii?q?A2DLBADY439d/wHyM5BmGwEBAQEDAQEBBwMBAQGBZ4FuK?=
 =?us-ascii?q?m1OBAEyKoQhjwlNAQEBAQEBBoE2foh1j0CBZwkBAQEBAQEBAQEmDgECAQGDe?=
 =?us-ascii?q?kUCgm8jOBMCDAEBAQQBAQEBAQUDAQFshS4MgjopAYJmAQEBAQIBIwQRRgsLG?=
 =?us-ascii?q?AICJgICVwYBDAgBAYJfPwGBdgUPD60/fzOFTIM3gUMGgQwoi3gYeIEHgREng?=
 =?us-ascii?q?jY1PoJIGQQYgTCDIoJYBIxdBokOgTKVR4Isgi6EV411BhuCNYtsingtjVyID?=
 =?us-ascii?q?JMHIYFYKwgCGAghD4Mogk0XiGOFWyQDMQkCegEBjRoogiwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Sep 2019 19:39:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GJdIJo027601;
        Mon, 16 Sep 2019 15:39:18 -0400
Subject: Re: [PATCH] selinux-testsuite: Add key and key_socket tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, paul@paul-moore.com
References: <20190909131701.29588-1-richard_c_haines@btinternet.com>
 <39c10e04-a7cc-bfbf-ae6d-9e27ea332ff2@tycho.nsa.gov>
 <416a31737aec3b57b929098b15c02636faa68d4e.camel@btinternet.com>
 <e31a9342-2970-7d06-fcaa-57af3d05399d@tycho.nsa.gov>
 <35455b30b5185780628e92c98ec8191c70f39bde.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fbd77088-47a4-b4be-73a9-0bac691cee96@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 15:39:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <35455b30b5185780628e92c98ec8191c70f39bde.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/16/19 3:23 PM, Richard Haines wrote:
> On Mon, 2019-09-16 at 15:11 -0400, Stephen Smalley wrote:
>> On 9/16/19 2:55 PM, Richard Haines wrote:
>>> On Mon, 2019-09-16 at 13:58 -0400, Stephen Smalley wrote:
>>>> On 9/9/19 9:17 AM, Richard Haines wrote:
>>>>> Test all permissions associated with the key and key_socket
>>>>> classes.
>>>>>
>>>>> Note that kernel 5.3 commit keys: Fix request_key() lack of
>>>>> Link
>>>>> perm
>>>>> check on found key ("504b69eb3c95180bc59f1ae9096ad4b10bbbf254")
>>>>> added an additional check for link perm on request_key(). The
>>>>> tests
>>>>> will support earlier kernels.
>>>>
>>>> I'm not sure why you coupled key and key_socket together; they
>>>> don't
>>>> have anything to do with each other, and were introduced in very
>>>> different kernel and probably refpolicy releases.  I would
>>>> recommend
>>>> splitting them.  SECCLASS_KEY and its permission checks were
>>>> introduced
>>>> in Linux v2.6.18; SECCLASS_KEY_SOCKET was part of the original
>>>> SELinux
>>>> merge for Linux 2.6.0.
>>>
>>> I'll split them.
>>>
>>>> You only appear to be testing self access, not permission checks
>>>> between
>>>> a process and a keyring created by another process in a different
>>>> security context.
>>>
>>> Okay I'll add these tests
>>>> 1 test fails for me,
>>>> keys/test ................... Failed KEYCTL_SESSION_TO_PARENT:
>>>> Operation
>>>> not permitted
>>>> keys/test ................... 1/13
>>>> #   Failed test at keys/test line 38.
>>>> # Looks like you failed 1 test of 13.
>>>> keys/test ................... Dubious, test returned 1 (wstat
>>>> 256,
>>>> 0x100)
>>>
>>> You must have systems that don't like my patches - I can't get this
>>> fail. Using Fedora 30 and also Rawhide from a few weeks ago.
>>
>> I'll have to look into it further, but it was on stock F30.
>>
>>> I don't know if this is of any interest (It works on Rawhide with
>>> kernel from [1]):
>>>
>>> I've been building 'key' tests to add the new permissions defined
>>> in
>>> kernel-next [1].
>>> To test these with new policy supporting the new perms + old policy
>>> that does not, I added the kernel test patch below.
>>> This patch handles security_key_permission() passing a single
>>> permission, as checking the current keys code I only see it passing
>>> a
>>> single permission at a time.
>>>
>>> I've also an sepol patch + selinux-testsuite tests
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/security/selinux?h=next-20190904&id=1f96e0f129eb2bea15a00c154eee8b85aa181d1a
>>
>> Yes, that's probably worth submitting for real.  Be sure to include
>> David Howells on the distribution for it. I wouldn't assume that only
>> a
>> single permission can ever be passed unless key_permission() itself
>> asserts that invariant.
>>
> That's okay as I've also tested the patch below that handles multiple
> permissions from keys:
> Any view on what is best !!

Unless key_task_permission() prohibits passing multiple permissions or 
David Howells tells you it will never happen, I'd support it in the 
security hook.  selinux_inode_permission() and selinux_ipc_permission() 
support it for their checks.  I don't think I'd do the work of mapping 
to the new permissions unless the policycap is set.

> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 901cc052f..78413277c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6502,7 +6502,8 @@ static int selinux_key_permission(key_ref_t
> key_ref,
>   {
>   	struct key *key;
>   	struct key_security_struct *ksec;
> -	unsigned oldstyle_perm;
> +	unsigned int key_perm = 0, switch_perm = 0;
> +	int x = KEY_NEED_ALL, bit = 1;
>   	u32 sid;
>   
>   	/* if no specific permissions are requested, we skip the
> @@ -6511,18 +6512,67 @@ static int selinux_key_permission(key_ref_t
> key_ref,
>   	if (perm == 0)
>   		return 0;
>   
> -	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ |
> KEY_NEED_WRITE |
> -				KEY_NEED_SEARCH | KEY_NEED_LINK);
> -	if (perm & KEY_NEED_SETSEC)
> -		oldstyle_perm |= OLD_KEY_NEED_SETATTR;
> -	if (perm & KEY_NEED_INVAL)
> -		oldstyle_perm |= KEY_NEED_SEARCH;
> -	if (perm & KEY_NEED_REVOKE && !(perm & OLD_KEY_NEED_SETATTR))
> -		oldstyle_perm |= KEY_NEED_WRITE;
> -	if (perm & KEY_NEED_JOIN)
> -		oldstyle_perm |= KEY_NEED_SEARCH;
> -	if (perm & KEY_NEED_CLEAR)
> -		oldstyle_perm |= KEY_NEED_WRITE;
> +	/*
> +	 * selinux_key_permission() is called with only one permission
> set.
> +	 * However this will handle multiple bits set.
> +	 */
> +	while (x) {
> +		switch_perm = bit & perm;
> +		switch (switch_perm) {
> +		case KEY_NEED_VIEW:
> +			key_perm |= KEY__VIEW;
> +			break;
> +		case KEY_NEED_READ:
> +			key_perm |= KEY__READ;
> +			break;
> +		case KEY_NEED_WRITE:
> +			key_perm |= KEY__WRITE;
> +			break;
> +		case KEY_NEED_SEARCH:
> +			key_perm |= KEY__SEARCH;
> +			break;
> +		case KEY_NEED_LINK:
> +			key_perm |= KEY__LINK;
> +			break;
> +		case KEY_NEED_SETSEC: /* Keep this as "setattr" in
> policy */
> +			key_perm |= KEY__SETATTR;
> +			break;
> +		case KEY_NEED_INVAL:
> +			key_perm |= KEY__INVAL;
> +			break;
> +		case KEY_NEED_REVOKE:
> +			key_perm |= KEY__REVOKE;
> +			break;
> +		case KEY_NEED_JOIN:
> +			key_perm |= KEY__JOIN;
> +			break;
> +		case KEY_NEED_CLEAR:
> +			key_perm |= KEY__CLEAR;
> +			break;
> +		}
> +		bit <<= 1;
> +		x >>= 1;
> +	}
> +
> +	/* If old policy, then reset new perms to orig. */
> +	if (!selinux_policycap_key_perms()) {
> +		if (perm & KEY_NEED_INVAL) {
> +			key_perm &= ~KEY__INVAL;
> +			key_perm |= KEY__SEARCH;
> +		}
> +		if (perm & KEY_NEED_REVOKE && !(perm &
> OLD_KEY_NEED_SETATTR)) {
> +			key_perm &= ~KEY__REVOKE;
> +			key_perm |= KEY__WRITE;
> +		}
> +		if (perm & KEY_NEED_JOIN) {
> +			key_perm &= ~KEY__JOIN;
> +			key_perm |= KEY__SEARCH;
> +		}
> +		if (perm & KEY_NEED_CLEAR) {
> +			key_perm &= ~KEY__CLEAR;
> +			key_perm |= KEY__WRITE;
> +		}
> +	}
>   
>   	sid = cred_sid(cred);
>   
> @@ -6530,7 +6580,7 @@ static int selinux_key_permission(key_ref_t
> key_ref,
>   	ksec = key->security;
>   
>   	return avc_has_perm(&selinux_state,
> -			    sid, ksec->sid, SECCLASS_KEY,
> oldstyle_perm, NULL);
> +			    sid, ksec->sid, SECCLASS_KEY, key_perm,
> NULL);
>   }
>   
>   static int selinux_key_getsecurity(struct key *key, char **_buffer)
> @@ -6555,7 +6605,7 @@ static int selinux_watch_key(struct key *key)
>   	u32 sid = current_sid();
>   
>   	return avc_has_perm(&selinux_state,
> -			    sid, ksec->sid, SECCLASS_KEY,
> KEY_NEED_VIEW, NULL);
> +			    sid, ksec->sid, SECCLASS_KEY, KEY__VIEW,
> NULL);
>   }
>   #endif
>   #endif
> diff --git a/security/selinux/include/classmap.h
> b/security/selinux/include/classmap.h
> index 201f7e588..a51ab9bd9 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -158,7 +158,7 @@ struct security_class_mapping secclass_map[] = {
>   	  { "send", "recv", "relabelto", "forward_in", "forward_out",
> NULL } },
>   	{ "key",
>   	  { "view", "read", "write", "search", "link", "setattr",
> "create",
> -	    NULL } },
> +	    "inval", "revoke", "join", "clear", NULL } },
>   	{ "dccp_socket",
>   	  { COMMON_SOCK_PERMS,
>   	    "node_bind", "name_connect", NULL } },
> diff --git a/security/selinux/include/security.h
> b/security/selinux/include/security.h
> index 111121281..a248eef75 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -78,6 +78,7 @@ enum {
>   	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>   	POLICYDB_CAPABILITY_CGROUPSECLABEL,
>   	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> +	POLICYDB_CAPABILITY_KEYPERMS,
>   	__POLICYDB_CAPABILITY_MAX
>   };
>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> @@ -177,6 +178,13 @@ static inline bool
> selinux_policycap_nnp_nosuid_transition(void)
>   	return state-
>> policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
>   }
>   
> +static inline bool selinux_policycap_key_perms(void)
> +{
> +	struct selinux_state *state = &selinux_state;
> +
> +	return state->policycap[POLICYDB_CAPABILITY_KEYPERMS];
> +}
> +
>   int security_mls_enabled(struct selinux_state *state);
>   int security_load_policy(struct selinux_state *state,
>   			 void *data, size_t len);
> diff --git a/security/selinux/ss/services.c
> b/security/selinux/ss/services.c
> index d61563a36..eb3949fc8 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -73,7 +73,8 @@ const char
> *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>   	"extended_socket_class",
>   	"always_check_network",
>   	"cgroup_seclabel",
> -	"nnp_nosuid_transition"
> +	"nnp_nosuid_transition",
> +	"key_perms"
>   };
>   
>   static struct selinux_ss selinux_ss;
> 
> 

