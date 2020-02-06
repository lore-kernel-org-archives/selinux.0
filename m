Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97507C33CAC
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EF821775
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 16:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oDhqkKbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBFQCR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:02:17 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:27557 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgBFQCR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 11:02:17 -0500
X-EEMSG-check-017: 55573217|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="55573217"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Feb 2020 16:02:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581004934; x=1612540934;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZcdZ9KSJAn/9jMb5pUPX7B+YzH+iLEM0BGs9IQdLh3A=;
  b=oDhqkKbZY3AXwJ45S5B0CrArDfYy4EUsMSrTH4pN+dXto3AzbmN4yRYP
   xj6K/oJdWKMyWfJPO+fGo3493DYXB5kXfc71ZO4S4Wl89fbylce2eDO5A
   MquNzo1IwpM9uuIJX/HTig3RvO8DhE7v6OrYNgHuEr8vXZEDHbjEnQZKk
   jFvKgR5IvFK+crsdclMGa7Pf8zjEisxFvG3Sx4jY2aHHTxFQPDiX4r4Y0
   vHQOVGsdiVSdNz1ObQBh8D9YdMbsd4ybTzVlVwsjg+QkCYZgkpJEbcMgx
   LbkLYUDngeJK5FzE+/n9cQQ1vXKz8mgUww4plXvJdL9H9QHggEezRRXXt
   w==;
X-IronPort-AV: E=Sophos;i="5.70,410,1574121600"; 
   d="scan'208";a="38761376"
IronPort-PHdr: =?us-ascii?q?9a23=3ALND8ExfFAbo7DPmf0gA6Q0JglGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc27YBSN2/xhgRfzUJnB7Loc0qyK6vymBDdLsc/J8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HJr3ZGdOhbxn5kLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsKqsfVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlinxlf7e/iAyz8Uim0uD8Vde70E?=
 =?us-ascii?q?xMriVbltnArHcN1wbc6sWBV/Bz/V+h1C6S2w3c5exIO0A5mbfBJ5I/zbM8iI?=
 =?us-ascii?q?AfvVnFEyTrgkv5lrWWeV8h+uWw7uTnZajpqYGEOo9vjwH+LrwumsuiAeQkKg?=
 =?us-ascii?q?QOX3aU+eC71LD74U32Wq9KjvwrkqnCqpzaJMIbpqC+Aw9OzIks9wyzDyum0d?=
 =?us-ascii?q?sEnXkHK0hJeBSbgIjyJ17COvX4Dfa7g1i0kTdrwe7JPqH5D5nQIXXOn63tcL?=
 =?us-ascii?q?Zg50JG1gY+ws5T64hJBr0ZJfL8QE7xtNjWDh8jNAy0xv7qCM5g2YMFQm+PHq?=
 =?us-ascii?q?+YP7/SsV+P/O4vJfKMa5UPtDbyLPgl+ebijWUlll8FYampwZwXZWiiHvRnP0?=
 =?us-ascii?q?qZYWDjgs0cHmgSogUxVOzqh0eDUT5VeXmyRLkx6SonCIKnC4fDWp6igKaH3C?=
 =?us-ascii?q?ilAp1afHxJCleJEX3wbYWLR+8MaD6OIs9mijEETqauS4sg1RGoqQ/7xKFqLv?=
 =?us-ascii?q?Tb+iIGr5Lvztt16PPJlRE06zN0C96R02aXT2F7hmkIXSM53LhjoUxhzVeOyb?=
 =?us-ascii?q?V3g/xfFd1d+fxJVgM6NYXHwuxgFd/9RwLBcc2VSFq8XtqmBjQxRMorw9ASe0?=
 =?us-ascii?q?Z9B8mijhfb0iqyGbAViriLCYcs8q3GwnjxI99xy3PB1KkmlVkpXNFDOnGhhq?=
 =?us-ascii?q?56pEDvANvzkk6ZnrymPYQV3SjA7y/X12uFvEhCXDl7ZqXMXHYSfWPcsdX/+k?=
 =?us-ascii?q?7YSbKyT78gN10FgdWPLqpMd83Bk1pLXrHgNc7Ybmb3nH2/QV6ExrSTYY7uYE?=
 =?us-ascii?q?0H0SndAVRCmAcWrlicMg1rPTusu2LTCnRVEFvrZ079ub1lpGiTUl4/zwbMaV?=
 =?us-ascii?q?ZokbWy5EhG1rSnV/oP0+dc628aoDJuEQP4hoiHBg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BXAADaNzxe/wHyM5BmGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gX2BGFQhEiqEFYkDhmQBAQEGgRIliXCPZIFnCQEBAQEBAQEBA?=
 =?us-ascii?q?S0KAQGEQAKCYTgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGDAQEBAQECASMEE?=
 =?us-ascii?q?UEQCxgCAiYCAlcGAQwGAgEBgmM/AYJKAwkFIA+rLHV/M4Q1AYEUg12BOAaBD?=
 =?us-ascii?q?iqMPXmBB4E4DAOCLy4+ghuBewESAYMxgl4Ell1hRpdngkSCToR8jnYGG4JIj?=
 =?us-ascii?q?FiLa45igUuHIZRIImdxKwgCGAghD4MnEz0YDY4pF4hkhV0jAzACAYwEERcCg?=
 =?us-ascii?q?hkBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Feb 2020 16:02:12 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 016G1LlZ121848;
        Thu, 6 Feb 2020 11:01:21 -0500
Subject: Re: security/selinux: Add support for new key permissions
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, dhowells@redhat.com
Cc:     paul@paul-moore.com
References: <20200203141343.29133-1-richard_c_haines@btinternet.com>
 <c6fcea12-53c5-35b3-5ccd-58c5c15e48c1@tycho.nsa.gov>
 <5da8163ffe9b96660740f4ec64abf4a7c47553de.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9663ec06-1b8a-3051-a942-131bd5eead3c@tycho.nsa.gov>
Date:   Thu, 6 Feb 2020 11:03:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5da8163ffe9b96660740f4ec64abf4a7c47553de.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/20 10:42 AM, Richard Haines wrote:
> On Mon, 2020-02-03 at 10:29 -0500, Stephen Smalley wrote:
>> On 2/3/20 9:13 AM, Richard Haines wrote:
>>> Add a new 'key_perms' policy capability and support for the
>>> additional
>>> key permissions: inval, revoke, join, clear
>>
>> For future reference, subject line should have [PATCH] prefix; git
>> send-email will do this for you automatically.  Also, the subsystem
>> prefix would conventionally be "keys,selinux:" to indicates that it
>> touches the keys and selinux subsystems, no need for "security/".
>>
>>> Also fixes JOIN -> LINK permission translation when policy
>>> capability 'keys_perms' = 0;
>>>
>>> The current "setattr" perm name remains and is used for
>>> KEY_NEED_SETSEC.
>>> This gives the following permissions for the 'key' class:
>>>
>>> create	Create a key or keyring.
>>> view	View attributes.
>>> read	Read contents.
>>> write	Update or modify.
>>> search	Search (keyring) or find (key).
>>> link	Link a key into the keyring.
>>> setattr	kernel < 5.X Change permissions on a keyring.
>>> 	kernel >= 5.X Set owner, group, ACL.
>>> inval	Invalidate key.
>>> revoke	Revoke key.
>>> join	Join keyring as session.
>>> clear	Clear a keyring.
>>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>> ---

>>> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
>>> index a0c97d4d8251..65e1c0c3feb1 100644
>>> --- a/security/keys/keyctl.c
>>> +++ b/security/keys/keyctl.c
>>> @@ -1592,7 +1592,8 @@ long keyctl_session_to_parent(void)
>>>    	struct cred *cred;
>>>    	int ret;
>>>    
>>> -	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0,
>>> KEY_NEED_JOIN);
>>> +	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0,
>>> +				    KEY_NEED_PARENT_JOIN);
>>
>> I'm unclear on how this works with the regular key permission
>> checking
>> (not SELinux).  There is no KEY_ACE_PARENT_JOIN permission AFAICT
>> and
>> the check would fail if the regular permissions were only
>> KEY_ACE_JOIN.
>> What we need is an additional flag that will get ignored by
>> key_permission() for its permission checking but signify to SELinux
>> that
>> different handling is required here.
> 
> David will need to answer this.

Until this gets resolved, this patch must not go into mainline. 
Otherwise we're looking at a potential userspace ABI issue when/if it 
gets resolved.

>>> diff --git a/security/selinux/include/security.h
>>> b/security/selinux/include/security.h
>>> index ae840634e3c7..6b264b6d9d31 100644
>>> --- a/security/selinux/include/security.h
>>> +++ b/security/selinux/include/security.h
>>> @@ -79,6 +79,7 @@ enum {
>>>    	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>>>    	POLICYDB_CAPABILITY_CGROUPSECLABEL,
>>>    	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>>> +	POLICYDB_CAPABILITY_KEYPERMS,
>>>    	__POLICYDB_CAPABILITY_MAX
>>>    };
>>>    #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>>> @@ -178,6 +179,13 @@ static inline bool
>>> selinux_policycap_nnp_nosuid_transition(void)
>>
>> This will collide with
>> https://lore.kernel.org/selinux/20200128191656.111902-1-cgzones@googlemail.com/
>> so we'll have to sort out which one goes first.

Already noted this elsewhere but for the sake of ensuring it is noted in 
this thread too: the key_perms capability will need to be added after 
the genfs_seclabel_symlinks capability since the latter is already 
queued on selinux/next and the corresponding libsepol patch has been 
merged upstream.
