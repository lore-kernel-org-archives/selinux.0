Return-Path: <SRS0=qBB/=XL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F820C49ED7
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D97420830
	for <selinux@archiver.kernel.org>; Mon, 16 Sep 2019 19:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Es4Y2EkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbfIPTTC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:19:02 -0400
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:39791 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733190AbfIPTTC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Sep 2019 15:19:02 -0400
X-EEMSG-check-017: 28419199|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="28419199"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Sep 2019 19:12:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568661127; x=1600197127;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=I8w+Omb8NO2s9ssvYTHUjw22TpFZVaOucVm/6O0R73o=;
  b=Es4Y2EkRiEjDRi7gCWBt398Q/+d/Tb4gbUaQ3HIiEf52O+k2jv4L+UQC
   Gtiowg3TacrV8lGjeCiR9H+gkkg1EOQ90et8nnJLbj2FZcSw6uGjvC5vn
   FaMMIabezx7FxTZekavgHMEtWS9VsrS1mywR+K+gIrdUPW7JBtWc8zhqN
   plVj/wLq6MAH5gztf+9ef7Rwp+7SzxO7Lv0C6P//E3eLLOC+KIPkjMJ+g
   xLC/HBGgO1FDHTN7hIw5hSDIewOQpyiZ9ukTmiBgD73LHmsh7Us95G7nb
   IGgV18Hr0kh9ODKFF3H7BxBk0eynV2XiXyz5yQybaz4qW0XzK0TN9IDXe
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,513,1559520000"; 
   d="scan'208";a="32912158"
IronPort-PHdr: =?us-ascii?q?9a23=3A/poQex1iKiPWdjZHsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWLf/xwZ3uMQTl6Ol3ixeRBMOHsqkC0rGd6vu8ESxYuNDd6SpEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQYjId4N6o8xB?=
 =?us-ascii?q?TFrmZGdulZ2GhkIU6fkwvm6sq/4ZJv7T5ct+49+8JFTK73Y7k2QbtEATo8Lm?=
 =?us-ascii?q?s7/tfrtR7NTQuO4nsTTGAbmQdWDgbG8R/3QI7/vjP1ueRh1iaaO9b2Ta0vVj?=
 =?us-ascii?q?S586hrUh7ohzwZODM/7Wral9Z/jKNfoBKmuhx/34vZa5ybOfZiYq/Qe84RSH?=
 =?us-ascii?q?FfVchNSSNOHoK8b5MOD+UfO+ZYs5L9rEYKoRenGAWgGP/jxjpOi3D4x6061/?=
 =?us-ascii?q?kqHx/A0gIuAtkCtG3YoMvxOasXV+2+0avGwijZb/5OxDnz9obIfBAir/+CU7?=
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
 =?us-ascii?q?fGQq7mXa8rKSNd2MWCLe1McdSvglJYEqSwcO/Can68zj/jTS2DwamBOc+zIT?=
 =?us-ascii?q?QQ?=
X-IPAS-Result: =?us-ascii?q?A2B4AAA73n9d/wHyM5BmGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?gIBAQEBCwGBbSptTgQBMiqEIY8ITQEBAQEBAQaBESV+iHWPQIFnCQEBAQEBA?=
 =?us-ascii?q?QEBASYOAQIBAYN6RQKCbyM3Bg4CDAEBAQQBAQEBAQUDAQFshS4MgjopAYJmA?=
 =?us-ascii?q?QEBAQIBGgEIBBFGCwsYAgImAgJXBgEMBgIBAYJfPwGBagMJBQ8PrTZ/M4VMg?=
 =?us-ascii?q?zeBSYEMKAGLdxh4gQeBEScMgio1PoIaLhkEGIEQIBeDC4JYBIxdiRSBMpVHg?=
 =?us-ascii?q?iyCLoRXjXUGG4I1cYp7ingtjVyIDJMGIoFYKwgCGAghD4MnCYJFF4dXgQyFW?=
 =?us-ascii?q?yQDMAEJAnoBAY0aKIIsAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Sep 2019 19:11:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8GJBmtP016928;
        Mon, 16 Sep 2019 15:11:48 -0400
Subject: Re: [PATCH] selinux-testsuite: Add key and key_socket tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, paul@paul-moore.com
References: <20190909131701.29588-1-richard_c_haines@btinternet.com>
 <39c10e04-a7cc-bfbf-ae6d-9e27ea332ff2@tycho.nsa.gov>
 <416a31737aec3b57b929098b15c02636faa68d4e.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e31a9342-2970-7d06-fcaa-57af3d05399d@tycho.nsa.gov>
Date:   Mon, 16 Sep 2019 15:11:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <416a31737aec3b57b929098b15c02636faa68d4e.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/16/19 2:55 PM, Richard Haines wrote:
> On Mon, 2019-09-16 at 13:58 -0400, Stephen Smalley wrote:
>> On 9/9/19 9:17 AM, Richard Haines wrote:
>>> Test all permissions associated with the key and key_socket
>>> classes.
>>>
>>> Note that kernel 5.3 commit keys: Fix request_key() lack of Link
>>> perm
>>> check on found key ("504b69eb3c95180bc59f1ae9096ad4b10bbbf254")
>>> added an additional check for link perm on request_key(). The tests
>>> will support earlier kernels.
>>
>> I'm not sure why you coupled key and key_socket together; they don't
>> have anything to do with each other, and were introduced in very
>> different kernel and probably refpolicy releases.  I would recommend
>> splitting them.  SECCLASS_KEY and its permission checks were
>> introduced
>> in Linux v2.6.18; SECCLASS_KEY_SOCKET was part of the original
>> SELinux
>> merge for Linux 2.6.0.
> 
> I'll split them.
> 
>>
>> You only appear to be testing self access, not permission checks
>> between
>> a process and a keyring created by another process in a different
>> security context.
> 
> Okay I'll add these tests
>>
>> 1 test fails for me,
>> keys/test ................... Failed KEYCTL_SESSION_TO_PARENT:
>> Operation
>> not permitted
>> keys/test ................... 1/13
>> #   Failed test at keys/test line 38.
>> # Looks like you failed 1 test of 13.
>> keys/test ................... Dubious, test returned 1 (wstat 256,
>> 0x100)
> 
> You must have systems that don't like my patches - I can't get this
> fail. Using Fedora 30 and also Rawhide from a few weeks ago.

I'll have to look into it further, but it was on stock F30.

> I don't know if this is of any interest (It works on Rawhide with
> kernel from [1]):
> 
> I've been building 'key' tests to add the new permissions defined in
> kernel-next [1].
> To test these with new policy supporting the new perms + old policy
> that does not, I added the kernel test patch below.
> This patch handles security_key_permission() passing a single
> permission, as checking the current keys code I only see it passing a
> single permission at a time.
> 
> I've also an sepol patch + selinux-testsuite tests
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/security/selinux?h=next-20190904&id=1f96e0f129eb2bea15a00c154eee8b85aa181d1a

Yes, that's probably worth submitting for real.  Be sure to include 
David Howells on the distribution for it. I wouldn't assume that only a 
single permission can ever be passed unless key_permission() itself 
asserts that invariant.

> 
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 901cc052f..9c8f90648 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6502,7 +6502,7 @@ static int selinux_key_permission(key_ref_t
> key_ref,
>   {
>   	struct key *key;
>   	struct key_security_struct *ksec;
> -	unsigned oldstyle_perm;
> +	unsigned int key_perm = 0;
>   	u32 sid;
>   
>   	/* if no specific permissions are requested, we skip the
> @@ -6511,18 +6511,57 @@ static int selinux_key_permission(key_ref_t
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
> +	/* selinux_key_permission() is called with only one permission
> set. */
> +	switch (perm) {
> +	case KEY_NEED_VIEW:
> +		key_perm = KEY__VIEW;
> +		break;
> +	case KEY_NEED_READ:
> +		key_perm = KEY__READ;
> +		break;
> +	case KEY_NEED_WRITE:
> +		key_perm = KEY__WRITE;
> +		break;
> +	case KEY_NEED_SEARCH:
> +		key_perm = KEY__SEARCH;
> +		break;
> +	case KEY_NEED_LINK:
> +		key_perm = KEY__LINK;
> +		break;
> +	case KEY_NEED_SETSEC: /* Keep this as "setattr" in policy */
> +		key_perm = KEY__SETATTR;
> +		break;
> +	case KEY_NEED_INVAL:
> +		key_perm = KEY__INVAL;
> +		break;
> +	case KEY_NEED_REVOKE:
> +		key_perm = KEY__REVOKE;
> +		break;
> +	case KEY_NEED_JOIN:
> +		key_perm = KEY__JOIN;
> +		break;
> +	case KEY_NEED_CLEAR:
> +		key_perm = KEY__CLEAR;
> +		break;
> +	}
> +
> +	/* If old policy, then reset new perms to orig. */
> +	if (!selinux_policycap_key_perms()) {
> +		switch (perm) {
> +		case KEY_NEED_INVAL:
> +			key_perm = KEY__SEARCH;
> +			break;
> +		case KEY_NEED_REVOKE:
> +			key_perm = KEY__WRITE;
> +			break;
> +		case KEY_NEED_JOIN:
> +			key_perm = KEY__SEARCH;
> +			break;
> +		case KEY_NEED_CLEAR:
> +			key_perm = KEY__WRITE;
> +			break;
> +		}
> +	}
>   
>   	sid = cred_sid(cred);
>   
> @@ -6530,7 +6569,7 @@ static int selinux_key_permission(key_ref_t
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
> @@ -6555,7 +6594,7 @@ static int selinux_watch_key(struct key *key)
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
> 
>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>> ---
>>>    README.md                   |   3 +-
>>>    defconfig                   |   8 ++
>>>    policy/Makefile             |   4 +
>>>    policy/test_keys.te         | 161 ++++++++++++++++++++++++
>>>    tests/Makefile              |   4 +
>>>    tests/keys/.gitignore       |   3 +
>>>    tests/keys/Makefile         |   8 ++
>>>    tests/keys/key_sock.c       |  67 ++++++++++
>>>    tests/keys/keyctl.c         | 241
>>> ++++++++++++++++++++++++++++++++++++
>>>    tests/keys/keyctl_relabel.c |  93 ++++++++++++++
>>>    tests/keys/test             |  98 +++++++++++++++
>>>    11 files changed, 689 insertions(+), 1 deletion(-)
>>>    create mode 100644 policy/test_keys.te
>>>    create mode 100644 tests/keys/.gitignore
>>>    create mode 100644 tests/keys/Makefile
>>>    create mode 100644 tests/keys/key_sock.c
>>>    create mode 100644 tests/keys/keyctl.c
>>>    create mode 100644 tests/keys/keyctl_relabel.c
>>>    create mode 100755 tests/keys/test
>>>
>>> diff --git a/README.md b/README.md
>>> index 26784f8..fe72a91 100644
>>> --- a/README.md
>>> +++ b/README.md
>>> @@ -65,7 +65,8 @@ following command:
>>>    		netlabel_tools \
>>>    		iptables \
>>>    		lksctp-tools-devel \
>>> -		attr
>>> +		attr \
>>> +		keyutils-libs-devel
>>>    
>>>    The testsuite requires a pre-existing base policy configuration
>>> of SELinux,
>>>    using either the old example policy or the reference policy as
>>> the baseline.
>>> diff --git a/defconfig b/defconfig
>>> index d7f0ea5..c00e291 100644
>>> --- a/defconfig
>>> +++ b/defconfig
>>> @@ -62,3 +62,11 @@ CONFIG_ANDROID_BINDER_IPC=y
>>>    # This will configure the Dynamically Allocated Binder Devices
>>> added
>>>    # to 5.0+ kernels:
>>>    CONFIG_ANDROID_BINDERFS=y
>>> +
>>> +# Key implementations.
>>> +# These are enabled to test the key and key_socket controls in
>>> +# tests/keys; they are not required for SELinux operation itself.
>>> +CONFIG_KEYS=y
>>> +CONFIG_KEYS_COMPAT=y
>>> +CONFIG_KEY_DH_OPERATIONS=y
>>> +CONFIG_NET_KEY=m
>>> diff --git a/policy/Makefile b/policy/Makefile
>>> index 305b572..9258a93 100644
>>> --- a/policy/Makefile
>>> +++ b/policy/Makefile
>>> @@ -71,6 +71,10 @@ ifeq ($(shell grep -q
>>> corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/coren
>>>    TARGETS += test_sctp.te
>>>    endif
>>>    
>>> +ifeq ($(shell grep -q key_socket
>>> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>>> +TARGETS += test_keys.te
>>> +endif
>>> +
>>>    ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>>>    TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te,
>>> $(TARGETS))
>>>    endif
>>> diff --git a/policy/test_keys.te b/policy/test_keys.te
>>> new file mode 100644
>>> index 0000000..9c65ec8
>>> --- /dev/null
>>> +++ b/policy/test_keys.te
>>> @@ -0,0 +1,161 @@
>>> +#
>>> +################# KEY selinux-testsuite policy module
>>> ######################
>>> +#
>>> +attribute keydomain;
>>> +
>>> +#
>>> +############################## Define Macro
>>> ################################
>>> +#
>>> +# Do not use domain_type() macro as it has allow 'key { link
>>> search }'
>>> +# in base module so 'allow domain self:key ~{ link search };' will
>>> not work
>>> +# here. Add these instead to allow key perms to be controlled by
>>> this module:
>>> +#
>>> +define(`key_domain_type',`
>>> +	allow $1 proc_t:dir { search };
>>> +	allow $1 proc_t:lnk_file { read };
>>> +	allow $1 self:dir { search };
>>> +	allow $1 self:file { open read write };
>>> +')
>>> +
>>> +#
>>> +####################### Main key class tests #####################
>>> +#
>>> +type test_key_t;
>>> +key_domain_type(test_key_t)
>>> +unconfined_runs_test(test_key_t)
>>> +typeattribute test_key_t testdomain;
>>> +typeattribute test_key_t keydomain;
>>> +
>>> +allow test_key_t self:process { setkeycreate };
>>> +allow test_key_t self:key { create write search read view link
>>> setattr };
>>> +
>>> +# Set new context on a keyring:
>>> +type test_newcon_key_t;
>>> +key_domain_type(test_newcon_key_t)
>>> +unconfined_runs_test(test_newcon_key_t)
>>> +typeattribute test_newcon_key_t testdomain;
>>> +typeattribute test_newcon_key_t keydomain;
>>> +
>>> +allow test_key_t test_newcon_key_t:key { create write search view
>>> };
>>> +
>>> +################# Deny process { setkeycreate }
>>> #######################
>>> +type test_no_setkeycreate_t;
>>> +key_domain_type(test_no_setkeycreate_t)
>>> +unconfined_runs_test(test_no_setkeycreate_t)
>>> +typeattribute test_no_setkeycreate_t testdomain;
>>> +typeattribute test_no_setkeycreate_t keydomain;
>>> +
>>> +###################### Deny key { create }
>>> ###########################
>>> +type test_key_no_create_t;
>>> +key_domain_type(test_key_no_create_t)
>>> +unconfined_runs_test(test_key_no_create_t)
>>> +typeattribute test_key_no_create_t testdomain;
>>> +typeattribute test_key_no_create_t keydomain;
>>> +
>>> +allow test_key_no_create_t self:process { setkeycreate };
>>> +allow test_key_no_create_t self:key { write search read view link
>>> setattr };
>>> +
>>> +###################### Deny key { write }
>>> ###########################
>>> +type test_key_no_write_t;
>>> +key_domain_type(test_key_no_write_t)
>>> +unconfined_runs_test(test_key_no_write_t)
>>> +typeattribute test_key_no_write_t testdomain;
>>> +typeattribute test_key_no_write_t keydomain;
>>> +
>>> +allow test_key_no_write_t self:process { setkeycreate };
>>> +allow test_key_no_write_t self:key { create search read view link
>>> setattr };
>>> +
>>> +###################### Deny key { search }
>>> ###########################
>>> +type test_key_no_search_t;
>>> +key_domain_type(test_key_no_search_t)
>>> +unconfined_runs_test(test_key_no_search_t)
>>> +typeattribute test_key_no_search_t testdomain;
>>> +typeattribute test_key_no_search_t keydomain;
>>> +
>>> +allow test_key_no_search_t self:process { setkeycreate };
>>> +allow test_key_no_search_t self:key { create write read view link
>>> setattr };
>>> +
>>> +###################### Deny key { view }
>>> ###########################
>>> +type test_key_no_view_t;
>>> +key_domain_type(test_key_no_view_t)
>>> +unconfined_runs_test(test_key_no_view_t)
>>> +typeattribute test_key_no_view_t testdomain;
>>> +typeattribute test_key_no_view_t keydomain;
>>> +
>>> +allow test_key_no_view_t self:process { setkeycreate };
>>> +allow test_key_no_view_t self:key { create write search read link
>>> setattr };
>>> +
>>> +###################### Deny key { read }
>>> ###########################
>>> +type test_key_no_read_t;
>>> +key_domain_type(test_key_no_read_t)
>>> +unconfined_runs_test(test_key_no_read_t)
>>> +typeattribute test_key_no_read_t testdomain;
>>> +typeattribute test_key_no_read_t keydomain;
>>> +
>>> +allow test_key_no_read_t self:process { setkeycreate };
>>> +allow test_key_no_read_t self:key { create write search view link
>>> setattr };
>>> +
>>> +###################### Deny key { link }
>>> ###########################
>>> +type test_key_no_link_t;
>>> +key_domain_type(test_key_no_link_t)
>>> +unconfined_runs_test(test_key_no_link_t)
>>> +typeattribute test_key_no_link_t testdomain;
>>> +typeattribute test_key_no_link_t keydomain;
>>> +
>>> +allow test_key_no_link_t self:process { setkeycreate };
>>> +allow test_key_no_link_t self:key { create write search read view
>>> setattr };
>>> +
>>> +###################### Deny key { setattr }
>>> ###########################
>>> +type test_key_no_setattr_t;
>>> +key_domain_type(test_key_no_setattr_t)
>>> +unconfined_runs_test(test_key_no_setattr_t)
>>> +typeattribute test_key_no_setattr_t testdomain;
>>> +typeattribute test_key_no_setattr_t keydomain;
>>> +
>>> +allow test_key_no_setattr_t self:process { setkeycreate };
>>> +allow test_key_no_setattr_t self:key { create write search read
>>> view link };
>>> +
>>> +#
>>> +######################## Test key_socket class
>>> ###########################
>>> +#
>>> +type test_key_sock_t;
>>> +domain_type(test_key_sock_t)
>>> +unconfined_runs_test(test_key_sock_t)
>>> +typeattribute test_key_sock_t testdomain;
>>> +typeattribute test_key_sock_t keydomain;
>>> +
>>> +# key_socket rules:
>>> +allow test_key_sock_t self:rawip_socket { create };
>>> +allow test_key_sock_t self:capability { net_admin };
>>> +allow test_key_sock_t self:key_socket { create write };
>>> +# For CONFIG_NET_KEY=m
>>> +allow test_key_sock_t kernel_t:system { module_request };
>>> +
>>> +################## Deny capability { net_admin }
>>> ##########################
>>> +type test_key_sock_no_net_admin_t;
>>> +domain_type(test_key_sock_no_net_admin_t)
>>> +unconfined_runs_test(test_key_sock_no_net_admin_t)
>>> +typeattribute test_key_sock_no_net_admin_t testdomain;
>>> +typeattribute test_key_sock_no_net_admin_t keydomain;
>>> +
>>> +# key_socket rules:
>>> +allow test_key_sock_no_net_admin_t self:rawip_socket { create };
>>> +allow test_key_sock_no_net_admin_t self:key_socket { create write
>>> };
>>> +
>>> +####################### Deny key_socket { create }
>>> ##########################
>>> +type test_key_sock_no_create_t;
>>> +domain_type(test_key_sock_no_create_t)
>>> +unconfined_runs_test(test_key_sock_no_create_t)
>>> +typeattribute test_key_sock_no_create_t testdomain;
>>> +typeattribute test_key_sock_no_create_t keydomain;
>>> +
>>> +# key_socket rules:
>>> +allow test_key_sock_no_create_t self:rawip_socket { create };
>>> +allow test_key_sock_no_create_t self:capability { net_admin };
>>> +allow test_key_sock_no_create_t self:key_socket { write };
>>> +
>>> +#
>>> +########### Allow these domains to be entered from sysadm domain
>>> ############
>>> +#
>>> +miscfiles_domain_entry_test_files(keydomain)
>>> +userdom_sysadm_entry_spec_domtrans_to(keydomain)
>>> diff --git a/tests/Makefile b/tests/Makefile
>>> index 63aa325..d1dbf38 100644
>>> --- a/tests/Makefile
>>> +++ b/tests/Makefile
>>> @@ -42,6 +42,10 @@ ifeq ($(shell grep -q binder
>>> $(POLDEV)/include/support/all_perms.spt && test -e
>>>    SUBDIRS += binder
>>>    endif
>>>    
>>> +ifeq ($(shell grep -q key_socket
>>> $(POLDEV)/include/support/all_perms.spt && test -e
>>> $(INCLUDEDIR)/keyutils.h && echo true),true)
>>> +SUBDIRS += keys
>>> +endif
>>> +
>>>    ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST="
>>> infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
>>>    SUBDIRS += infiniband_endport
>>>    endif
>>> diff --git a/tests/keys/.gitignore b/tests/keys/.gitignore
>>> new file mode 100644
>>> index 0000000..4a0a48d
>>> --- /dev/null
>>> +++ b/tests/keys/.gitignore
>>> @@ -0,0 +1,3 @@
>>> +keyctl
>>> +keyctl_relabel
>>> +key_sock
>>> diff --git a/tests/keys/Makefile b/tests/keys/Makefile
>>> new file mode 100644
>>> index 0000000..3a00df5
>>> --- /dev/null
>>> +++ b/tests/keys/Makefile
>>> @@ -0,0 +1,8 @@
>>> +TARGETS = keyctl key_sock keyctl_relabel
>>> +
>>> +LDLIBS += -lselinux -lkeyutils
>>> +
>>> +all: $(TARGETS)
>>> +
>>> +clean:
>>> +	rm -f $(TARGETS)
>>> diff --git a/tests/keys/key_sock.c b/tests/keys/key_sock.c
>>> new file mode 100644
>>> index 0000000..8ac1f45
>>> --- /dev/null
>>> +++ b/tests/keys/key_sock.c
>>> @@ -0,0 +1,67 @@
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <unistd.h>
>>> +#include <errno.h>
>>> +#include <stdbool.h>
>>> +#include <sys/socket.h>
>>> +#include <linux/pfkeyv2.h>
>>> +#include <selinux/selinux.h>
>>> +
>>> +static void usage(char *progname)
>>> +{
>>> +	fprintf(stderr,
>>> +		"usage:  %s [-v]\n"
>>> +		"Where:\n\t"
>>> +		"-v  Print information.\n", progname);
>>> +	exit(-1);
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	char *context;
>>> +	int opt, sock, result;
>>> +	bool verbose = false;
>>> +
>>> +	while ((opt = getopt(argc, argv, "v")) != -1) {
>>> +		switch (opt) {
>>> +		case 'v':
>>> +			verbose = true;
>>> +			break;
>>> +		default:
>>> +			usage(argv[0]);
>>> +		}
>>> +	}
>>> +
>>> +	result = getcon(&context);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to obtain process context\n");
>>> +		exit(-1);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Process context: %s\n", context);
>>> +
>>> +	sock = socket(PF_KEY, SOCK_RAW, PF_KEY_V2);
>>> +	if (sock < 0) {
>>> +		fprintf(stderr, "Failed to open PF_KEY socket: %s\n",
>>> +			strerror(errno));
>>> +		exit(errno);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Opened PF_KEY socket\n");
>>> +
>>> +	/* Write nothing to socket for test, expect EMSGSIZE error */
>>> +	result = write(sock, NULL, 0);
>>> +	if (result < 0 && errno == EMSGSIZE) {
>>> +		result = 0;
>>> +		if (verbose)
>>> +			printf("Written to PF_KEY socket\n");
>>> +	} else if (result < 0 && errno != EMSGSIZE) {
>>> +		result = -1;
>>> +		fprintf(stderr, "Failed write to PF_KEY socket: %s\n",
>>> +			strerror(errno));
>>> +	}
>>> +
>>> +	close(sock);
>>> +	return result;
>>> +}
>>> diff --git a/tests/keys/keyctl.c b/tests/keys/keyctl.c
>>> new file mode 100644
>>> index 0000000..6d85be7
>>> --- /dev/null
>>> +++ b/tests/keys/keyctl.c
>>> @@ -0,0 +1,241 @@
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <unistd.h>
>>> +#include <errno.h>
>>> +#include <stdbool.h>
>>> +#include <keyutils.h>
>>> +#include <selinux/selinux.h>
>>> +
>>> +/* This is used as the payload for each add_key() */
>>> +static const char payload[] =
>>> +	" -----BEGIN PUBLIC KEY-----
>>> \nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDN4FHsPjlJf03r9KfNt1Ma9/D6\
>>> nQDEiR/cfhZrNUPgHRrC+E4dj52VJSonPFJ6HaLlUi5pZq2t1LqPNrMfFKCNn12m+\n
>>> Ww4aduBJM7u1RUPSNxrlfDAJZkdtNALOO/ds3U93hZrxOYNetzbnjILDu5JT1nbI\n4
>>> aC60SkdlCw1TxmvXwIDAQAB\n-----END PUBLIC KEY-----\n";
>>> +
>>> +static void usage(char *progname)
>>> +{
>>> +	fprintf(stderr,
>>> +		"usage:  %s [-v]\n"
>>> +		"Where:\n\t"
>>> +		"-v  Print information.\n", progname);
>>> +	exit(-1);
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	int opt, result;
>>> +	char *context, *keycreate_con;
>>> +	char r_con[256];
>>> +	bool verbose = false;
>>> +	key_serial_t retrieved, search, link, compute, newring,
>>> +		     private, prime, base, test_key;
>>> +	struct keyctl_dh_params params;
>>> +
>>> +	while ((opt = getopt(argc, argv, "v")) != -1) {
>>> +		switch (opt) {
>>> +		case 'v':
>>> +			verbose = true;
>>> +			break;
>>> +		default:
>>> +			usage(argv[0]);
>>> +		}
>>> +	}
>>> +
>>> +	result = getcon(&context);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to obtain process context\n");
>>> +		exit(1);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Process context: %s\n", context);
>>> +
>>> +	result = getkeycreatecon(&keycreate_con);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to obtain keycreate
>>> context\n");
>>> +		exit(2);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Current keycreate context: %s\n",
>>> keycreate_con);
>>> +	free(keycreate_con);
>>> +
>>> +	/* Set context requires process { setkeycreate } and key {
>>> create } */
>>> +	result = setkeycreatecon(context);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed setkeycreatecon(): %s\n",
>>> +			strerror(errno));
>>> +		exit(3);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Set keycreate context: %s\n", context);
>>> +	free(context);
>>> +
>>> +	result = getkeycreatecon(&keycreate_con);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to obtain keycreate
>>> context\n");
>>> +		exit(4);
>>> +	}
>>> +	if (verbose)
>>> +		printf("New keycreate context: %s\n", keycreate_con);
>>> +	free(keycreate_con);
>>> +
>>> +	/*
>>> +	 * Add three keys as these will be required by the
>>> +	 * keyctl(KEYCTL_DH_COMPUTE, ..) function.
>>> +	 * These require key { create write } permissions.
>>> +	 */
>>> +	private = add_key("user", "private", payload, strlen(payload),
>>> +			  KEY_SPEC_PROCESS_KEYRING);
>>> +	if (private < 0) {
>>> +		fprintf(stderr, "Failed add_key(private): %s\n",
>>> +			strerror(errno));
>>> +		exit(5);
>>> +	}
>>> +
>>> +	prime = add_key("user", "prime", payload, strlen(payload),
>>> +			KEY_SPEC_PROCESS_KEYRING);
>>> +	if (prime < 0) {
>>> +		fprintf(stderr, "Failed add_key(prime): %s\n",
>>> +			strerror(errno));
>>> +		exit(6);
>>> +	}
>>> +
>>> +	base = add_key("user", "base", payload, strlen(payload),
>>> +		       KEY_SPEC_PROCESS_KEYRING);
>>> +	if (base < 0) {
>>> +		fprintf(stderr, "Failed add_key(base): %s\n",
>>> +			strerror(errno));
>>> +		exit(7);
>>> +	}
>>> +
>>> +	if (verbose) {
>>> +		printf("Private key ID: 0x%x\n", private);
>>> +		printf("Prime key ID:   0x%x\n", prime);
>>> +		printf("Base key ID:    0x%x\n", base);
>>> +	}
>>> +
>>> +	/* Requires key { search }. From kernel 5.3 also requires {
>>> link } */
>>> +	retrieved = request_key("user", "private", NULL,
>>> +				KEY_SPEC_PROCESS_KEYRING);
>>> +	if (retrieved < 0) {
>>> +		fprintf(stderr, "Failed to request 'private' key:
>>> %s\n",
>>> +			strerror(errno));
>>> +		exit(8);
>>> +	}
>>> +
>>> +	/* Requires key { search } */
>>> +	search = keyctl(KEYCTL_SEARCH, KEY_SPEC_PROCESS_KEYRING,
>>> "user",
>>> +			"base", 0);
>>> +	if (search < 0) {
>>> +		fprintf(stderr, "Failed to find 'base' key: %s\n",
>>> +			strerror(errno));
>>> +		exit(9);
>>> +	}
>>> +
>>> +	/* Requires key { view } */
>>> +	result = keyctl(KEYCTL_GET_SECURITY, search, r_con,
>>> sizeof(r_con));
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to obtain key context: %s\n",
>>> +			strerror(errno));
>>> +		exit(10);
>>> +	}
>>> +
>>> +	if (verbose) {
>>> +		printf("Requested 'private' key ID: 0x%x\n",
>>> retrieved);
>>> +		printf("Searched 'base' key ID:     0x%x\n", search);
>>> +		printf("Searched 'base' key context:\n\t%s\n", r_con);
>>> +	}
>>> +
>>> +	/* Compute DH key, only obtain the length for test, not the
>>> key. */
>>> +	params.priv = private;
>>> +	params.prime = prime;
>>> +	params.base = base;
>>> +
>>> +	/* Requires key { create read write } */
>>> +	compute = keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
>>> +	if (compute < 0) {
>>> +		fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
>>> +			strerror(errno));
>>> +		exit(11);
>>> +	}
>>> +	if (verbose)
>>> +		printf("KEYCTL_DH_COMPUTE key ID size: %d\n", compute);
>>> +
>>> +	/* To test key { link }, need to generate a new keyring ID
>>> first */
>>> +	newring = add_key("keyring", "my-keyring", NULL, 0,
>>> +			  KEY_SPEC_THREAD_KEYRING);
>>> +	if (newring < 0) {
>>> +		fprintf(stderr, "Failed to add new keyring: %s\n",
>>> +			strerror(errno));
>>> +		exit(12);
>>> +	}
>>> +	if (verbose)
>>> +		printf("New keyring ID: 0x%x\n", newring);
>>> +
>>> +	/* Requires key { write link } */
>>> +	link = keyctl(KEYCTL_LINK, base, newring);
>>> +	if (link < 0) {
>>> +		fprintf(stderr, "Failed KEYCTL_LINK: %s\n",
>>> +			strerror(errno));
>>> +		exit(13);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Link key ID:    0x%x\n", newring);
>>> +
>>> +	/* Requires key { setattr } */
>>> +	link = keyctl(KEYCTL_RESTRICT_KEYRING, newring, NULL, NULL);
>>> +	if (link < 0) {
>>> +		fprintf(stderr, "Failed KEYCTL_RESTRICT_KEYRING: %s\n",
>>> +			strerror(errno));
>>> +		exit(14);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Restricted keyring\n");
>>> +
>>> +	/* Requires key { search } from 5.X key { inval } */
>>> +	test_key = keyctl(KEYCTL_INVALIDATE, private);
>>> +	if (test_key < 0) {
>>> +		fprintf(stderr, "Failed KEYCTL_INVALIDATE(private):
>>> %s\n",
>>> +			strerror(errno));
>>> +		exit(15);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Invalidated 'private' key\n");
>>> +
>>> +	/* Requires key { write setattr } from 5.X key { revoke } */
>>> +	test_key = keyctl(KEYCTL_REVOKE, prime);
>>> +	if (test_key < 0) {
>>> +		fprintf(stderr, "Failed KEYCTL_REVOKE(prime): %s\n",
>>> +			strerror(errno));
>>> +		exit(16);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Revoked 'prime' key\n");
>>> +
>>> +	/* Requires key { write } from 5.X key { clear } */
>>> +	test_key = keyctl(KEYCTL_CLEAR, newring);
>>> +	if (test_key < 0) {
>>> +		fprintf(stderr, "Failed KEYCTL_CLEAR(newring): %s\n",
>>> +			strerror(errno));
>>> +		exit(17);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Cleared 'newring' keyring\n");
>>> +
>>> +	/* To test key { join }, need to join session first */
>>> +	test_key = keyctl(KEYCTL_JOIN_SESSION_KEYRING, "user");
>>> +	if (test_key < 0) {
>>> +		fprintf(stderr, "Failed KEYCTL_JOIN_SESSION_KEYRING,:
>>> %s\n",
>>> +			strerror(errno));
>>> +		exit(18);
>>> +	}
>>> +	/* Requires key { link } from 5.X key { join } */
>>> +	test_key = keyctl(KEYCTL_SESSION_TO_PARENT);
>>> +	if (test_key < 0) {
>>> +		fprintf(stderr, "Failed KEYCTL_SESSION_TO_PARENT:
>>> %s\n",
>>> +			strerror(errno));
>>> +		exit(19);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Joined session to parent\n");
>>> +
>>> +	return 0;
>>> +}
>>> diff --git a/tests/keys/keyctl_relabel.c
>>> b/tests/keys/keyctl_relabel.c
>>> new file mode 100644
>>> index 0000000..0276c7a
>>> --- /dev/null
>>> +++ b/tests/keys/keyctl_relabel.c
>>> @@ -0,0 +1,93 @@
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <unistd.h>
>>> +#include <errno.h>
>>> +#include <stdbool.h>
>>> +#include <keyutils.h>
>>> +#include <selinux/selinux.h>
>>> +
>>> +static void usage(char *progname)
>>> +{
>>> +	fprintf(stderr,
>>> +		"usage:  %s [-v] newcon\n"
>>> +		"Where:\n\t"
>>> +		"-v      Print information.\n\t"
>>> +		"newcon  New keyring context.\n", progname);
>>> +	exit(-1);
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	int opt, result;
>>> +	char *context, *keycreate_con;
>>> +	char r_con[256];
>>> +	bool verbose = false;
>>> +	key_serial_t newring;
>>> +
>>> +	while ((opt = getopt(argc, argv, "v")) != -1) {
>>> +		switch (opt) {
>>> +		case 'v':
>>> +			verbose = true;
>>> +			break;
>>> +		default:
>>> +			usage(argv[0]);
>>> +		}
>>> +	}
>>> +
>>> +	if (optind >= argc)
>>> +		usage(argv[0]);
>>> +
>>> +	result = getcon(&context);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to obtain process context\n");
>>> +		exit(1);
>>> +	}
>>> +	if (verbose)
>>> +		printf("Process context: %s\n", context);
>>> +	free(context);
>>> +
>>> +	result = setkeycreatecon(argv[optind]);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed setkeycreatecon(): %s\n",
>>> +			strerror(errno));
>>> +		exit(2);
>>> +	}
>>> +
>>> +	result = getkeycreatecon(&keycreate_con);
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to obtain keycreate
>>> context\n");
>>> +		exit(3);
>>> +	}
>>> +	if (verbose)
>>> +		printf("New keycreate context: %s\n", keycreate_con);
>>> +	free(keycreate_con);
>>> +
>>> +	newring = add_key("keyring", "my-keyring", NULL, 0,
>>> +			  KEY_SPEC_THREAD_KEYRING);
>>> +	if (newring < 0) {
>>> +		fprintf(stderr, "Failed to add new keyring: %s\n",
>>> +			strerror(errno));
>>> +		exit(4);
>>> +	}
>>> +
>>> +	result = keyctl(KEYCTL_GET_SECURITY, newring, r_con,
>>> sizeof(r_con));
>>> +	if (result < 0) {
>>> +		fprintf(stderr, "Failed to obtain key context: %s\n",
>>> +			strerror(errno));
>>> +		exit(5);
>>> +	}
>>> +
>>> +	if (strcmp(argv[optind], r_con)) {
>>> +		fprintf(stderr, "Relabel error - expected: %s got:
>>> %s\n",
>>> +			argv[optind], r_con);
>>> +		exit(6);
>>> +	}
>>> +
>>> +	if (verbose) {
>>> +		printf("'my-keyring' key ID: 0x%x\n", newring);
>>> +		printf("'my-keyring' context:\n\t%s\n", r_con);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> diff --git a/tests/keys/test b/tests/keys/test
>>> new file mode 100755
>>> index 0000000..4916e7c
>>> --- /dev/null
>>> +++ b/tests/keys/test
>>> @@ -0,0 +1,98 @@
>>> +#!/usr/bin/perl
>>> +use Test::More;
>>> +
>>> +BEGIN {
>>> +    $basedir = $0;
>>> +    $basedir =~ s|(.*)/[^/]*|$1|;
>>> +
>>> +    $test_count = 13;
>>> +
>>> +    # allow info to be shown during tests
>>> +    $v = $ARGV[0];
>>> +    if ($v) {
>>> +        if ( $v ne "-v" ) {
>>> +            plan skip_all => "Invalid option (use -v)";
>>> +        }
>>> +    }
>>> +    else {
>>> +        $v = " ";
>>> +    }
>>> +
>>> +    # From kernel 5.3 request_key() requires additional check of
>>> key { link }
>>> +    $kvercur = `uname -r`;
>>> +    chomp($kvercur);
>>> +    $kverminstream = "5.3";
>>> +    $test_link_53  = 0;
>>> +
>>> +    $result = `$basedir/../kvercmp $kvercur $kverminstream`;
>>> +    if ( $result >= 0 ) {
>>> +        $test_link_53 = 1;
>>> +    }
>>> +
>>> +    plan tests => $test_count;
>>> +}
>>> +
>>> +############ Test keyctl #############
>>> +print "Test key class permissions\n";
>>> +$result = system "runcon -t test_key_t $basedir/keyctl $v";
>>> +ok( $result eq 0 );
>>> +
>>> +# Deny process { setkeycreate }
>>> +$result = system "runcon -t test_no_setkeycreate_t $basedir/keyctl
>>> $v 2>&1";
>>> +ok( $result >> 8 eq 3 );
>>> +
>>> +# Deny key { create }
>>> +$result = system "runcon -t test_key_no_create_t $basedir/keyctl
>>> $v 2>&1";
>>> +ok( $result >> 8 eq 3 );
>>> +
>>> +# Deny key { write }
>>> +$result = system "runcon -t test_key_no_write_t $basedir/keyctl $v
>>> 2>&1";
>>> +ok( $result >> 8 eq 5 );
>>> +
>>> +# Deny key { search }
>>> +$result = system "runcon -t test_key_no_search_t $basedir/keyctl
>>> $v 2>&1";
>>> +ok( $result >> 8 eq 8 );
>>> +
>>> +# Deny key { view }
>>> +$result = system "runcon -t test_key_no_view_t $basedir/keyctl $v
>>> 2>&1";
>>> +ok( $result >> 8 eq 10 );
>>> +
>>> +# Deny key { read }
>>> +$result = system "runcon -t test_key_no_read_t $basedir/keyctl $v
>>> 2>&1";
>>> +ok( $result >> 8 eq 11 );
>>> +
>>> +# Deny key { link }
>>> +$result = system "runcon -t test_key_no_link_t $basedir/keyctl $v
>>> 2>&1";
>>> +if ($test_link_53) {
>>> +    ok( $result >> 8 eq 8 );
>>> +}
>>> +else {
>>> +    ok( $result >> 8 eq 13 );
>>> +}
>>> +
>>> +# Deny key { setattr }
>>> +$result = system "runcon -t test_key_no_setattr_t $basedir/keyctl
>>> $v 2>&1";
>>> +ok( $result >> 8 eq 14 );
>>> +
>>> +########### Change keyring context ##############
>>> +print "Change keyring context\n";
>>> +$result = system
>>> +"runcon -t test_key_t $basedir/keyctl_relabel $v
>>> system_u:system_r:test_newcon_key_t:s0";
>>> +ok( $result eq 0 );
>>> +
>>> +############ Test key_socket #############
>>> +print "Test key_socket class\n";
>>> +$result = system "runcon -t test_key_sock_t $basedir/key_sock $v";
>>> +ok( $result eq 0 );
>>> +
>>> +# Deny capability { net_admin } - EPERM
>>> +$result =
>>> +  system "runcon -t test_key_sock_no_net_admin_t $basedir/key_sock
>>> $v 2>&1";
>>> +ok( $result >> 8 eq 1 );
>>> +
>>> +# Deny key_socket { create } - EACCES
>>> +$result =
>>> +  system "runcon -t test_key_sock_no_create_t $basedir/key_sock $v
>>> 2>&1";
>>> +ok( $result >> 8 eq 13 );
>>> +
>>> +exit;
>>>
> 

