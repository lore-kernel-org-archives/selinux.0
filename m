Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFE2C35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 15:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503202086A
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 15:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IHmQG0vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBCP3D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:29:03 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:38749 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgBCP3D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 10:29:03 -0500
X-EEMSG-check-017: 53370452|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="53370452"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Feb 2020 15:29:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580743740; x=1612279740;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3PgeWrx+dYLnj7hK81HwgHiPxMQOKhqueX9J3WP+jbo=;
  b=IHmQG0vmtz3h85mAwrhMio7QxYOvzOdkkjQDdyc1zKsjTyc72J8eeIoI
   KlLFYlcxEHYKuDOel9c6DE3k1R6RUqOXVeMp1T3FEfSVOqGnBLzoJAoaP
   VOfuandCa8c+Nl8RA4OgKOeX02xAP2Sm046PAGxWbVdaKathkV0Bj4uR+
   P1FRRhVEDWUK09lo65VefnxRFlsJzoNu3BnA6mAjuj8rLC+OLnCTW7Jw8
   OnS8y4aEy9oWxjaCsEKWGlds1vq61LqdjVJDxnm6fvJUYMKGFhJQk9BdI
   b9PJyCeybi9BSiJkQ/ARc9s8E4Wm3C/DhQYjYDz9OoPOmgORrwEIKWpOV
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="38588709"
IronPort-PHdr: =?us-ascii?q?9a23=3AP6PUmBNfqIhdBK+bNxIl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/36rsbcNUDSrc9gkEXOFd2Cra4d16yK7Ou/AyRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMKk8xx?=
 =?us-ascii?q?nGrnZKZehd2GdkKU6Okxrm6cq84ZBu/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSG?=
 =?us-ascii?q?FfQsheSTBOAoKkb4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3KoNjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkledpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8rCWzxsgyko?=
 =?us-ascii?q?nJhpwaylbZ/itkxYY6P9m4SEplbt+kDZBdsDqaOJZtQs45X2FpuDo1yr0BuZ?=
 =?us-ascii?q?KheigK044oywTQa/yAbYiF+xTuX/ufLzd/gXJqYrO/hxCq/Eij1OL8TM+030?=
 =?us-ascii?q?hOriZfldnMrH8N2hrO4caEUvtw5lqt1DmA2gzJ6uxIPFo4mbTUJpI/2LI8i5?=
 =?us-ascii?q?weulnZECDsgkX5lqqWe10h+uiv9uvofK3rpoSZN49okgH+NbkumtCnDeQ4LA?=
 =?us-ascii?q?cOW2+b9Pyg1LL55035QahKjuYsnqnYtpDaK8MbprWnDABJyIoj9xa+ACum0N?=
 =?us-ascii?q?Qfh3UHKk5KeAmbgITzPlHOIfT4Ae++g1Sqjjhr2+jLMqDuD5jCNHTOkKrtca?=
 =?us-ascii?q?xj50NT1gY/181T64pRCr4bIfLzXkHxtMbfDh88KwG02PvoCM5m24MCWWOAHq?=
 =?us-ascii?q?+ZMKTIvV+O/eIgOfOAZIASuDbjM/Ql/eLhjWclmV8BeqmkxYEXaHGkEfRmOU?=
 =?us-ascii?q?qZe2fjjc8dHmgSvgoxVu3qiFucXj5IfHu9RL485jA9CIK6E4jDXIatj6Kd3C?=
 =?us-ascii?q?uhApJWYWVGAEiWEXj0b4WER+sMaCWKL896jDMEUbmhS4k81RChrwL61bVnIf?=
 =?us-ascii?q?TO+iECtpLsysJ15+vNmhE27zB0CN6d026VRWFugmwIXyM23Lx4oUFl0leMy7?=
 =?us-ascii?q?V4g/hDGNxL/fxJTwM6OYfZz+x9DNDyQBzOcs2VR1ahR9WsGSsxQc4pw98Sf0?=
 =?us-ascii?q?Z9HM2vgQ3D3yqtDb4aibiLBJgv8q/HxXj+Odtyy3bc26k9lVUpXsxPNWj1zp?=
 =?us-ascii?q?J4ojLSDI7AiUnRt6+rc6kHlHrX9WyDxHCCi0pvUAdxV6jedXoDZ03KoM7/61?=
 =?us-ascii?q?+ERLirX/BvKQZFyMifOoNUZdDzy1ZLXvHuPJLZeW3itX23AEOz2r6UbIfsM1?=
 =?us-ascii?q?4Y1SHZBVlMxxsf5l6aJAM+AWGnuGuYAztwQwG8K3jw+PVz/SvoBnQ/yBuHOg?=
 =?us-ascii?q?g4jeu4?=
X-IPAS-Result: =?us-ascii?q?A2D8AADrOzhe/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gRhVIBIqhBSJA4ZbAQEGgTeJb49igWcJAQEBAQEBAQEBLQoBAYRAA?=
 =?us-ascii?q?oJYOBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYMBAQEBAQIBIwQRQQULCxgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgmM/AYJKAwkFIA+rCHV/M4Q1AYEUgz+BOAaBDiqMOnmBB?=
 =?us-ascii?q?4E4D4IvLj6CG4F7AQwGAYMxgl4ElldhRpdkgkWCToR4jnQGG4JIjFaLao5hg?=
 =?us-ascii?q?UuHHJREImdxKwgCGAghD4MnEz0YDY4pF4hkhV0jAzACAYxDARAXAoIZAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Feb 2020 15:28:40 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 013FRjVf216537;
        Mon, 3 Feb 2020 10:27:48 -0500
Subject: Re: security/selinux: Add support for new key permissions
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com, dhowells@redhat.com
References: <20200203141343.29133-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c6fcea12-53c5-35b3-5ccd-58c5c15e48c1@tycho.nsa.gov>
Date:   Mon, 3 Feb 2020 10:29:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203141343.29133-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/20 9:13 AM, Richard Haines wrote:
> Add a new 'key_perms' policy capability and support for the additional
> key permissions: inval, revoke, join, clear

For future reference, subject line should have [PATCH] prefix; git 
send-email will do this for you automatically.  Also, the subsystem 
prefix would conventionally be "keys,selinux:" to indicates that it 
touches the keys and selinux subsystems, no need for "security/".

> 
> Also fixes JOIN -> LINK permission translation when policy
> capability 'keys_perms' = 0;
> 
> The current "setattr" perm name remains and is used for KEY_NEED_SETSEC.
> This gives the following permissions for the 'key' class:
> 
> create	Create a key or keyring.
> view	View attributes.
> read	Read contents.
> write	Update or modify.
> search	Search (keyring) or find (key).
> link	Link a key into the keyring.
> setattr	kernel < 5.X Change permissions on a keyring.
> 	kernel >= 5.X Set owner, group, ACL.
> inval	Invalidate key.
> revoke	Revoke key.
> join	Join keyring as session.
> clear	Clear a keyring.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>   include/linux/key.h                 |  3 +-
>   security/keys/keyctl.c              |  3 +-
>   security/selinux/hooks.c            | 73 ++++++++++++++++++++++++++++++-------
>   security/selinux/include/classmap.h |  2 +-
>   security/selinux/include/security.h |  8 ++++
>   security/selinux/ss/services.c      |  3 +-
>   6 files changed, 74 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 24c69457783f..ddfc0709569b 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -435,7 +435,8 @@ extern void key_free_user_ns(struct user_namespace *);
>   #define	KEY_NEED_REVOKE	0x080	/* Require permission to revoke key */
>   #define	KEY_NEED_JOIN	0x100	/* Require permission to join keyring as session */
>   #define	KEY_NEED_CLEAR	0x200	/* Require permission to clear a keyring */
> -#define KEY_NEED_ALL	0x3ff
> +#define KEY_NEED_PARENT_JOIN 0x400 /* Require permission to impose keyring on parent */
> +#define KEY_NEED_ALL	0x7ff
>   
>   #define OLD_KEY_NEED_SETATTR 0x20 /* Used to be Require permission to change attributes */
>   
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index a0c97d4d8251..65e1c0c3feb1 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1592,7 +1592,8 @@ long keyctl_session_to_parent(void)
>   	struct cred *cred;
>   	int ret;
>   
> -	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0, KEY_NEED_JOIN);
> +	keyring_r = lookup_user_key(KEY_SPEC_SESSION_KEYRING, 0,
> +				    KEY_NEED_PARENT_JOIN);

I'm unclear on how this works with the regular key permission checking 
(not SELinux).  There is no KEY_ACE_PARENT_JOIN permission AFAICT and 
the check would fail if the regular permissions were only KEY_ACE_JOIN. 
What we need is an additional flag that will get ignored by 
key_permission() for its permission checking but signify to SELinux that 
different handling is required here.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c8db5235b01f..a499bd7d9777 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6565,18 +6566,62 @@ static int selinux_key_permission(key_ref_t key_ref,
>   	if (perm == 0)
>   		return 0;
>   
> -	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ | KEY_NEED_WRITE |
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
> +	if (selinux_policycap_key_perms()) {
> +		while (count) {
> +			switch_perm = bit & perm;
> +			switch (switch_perm) {
> +			case KEY_NEED_VIEW:
> +				key_perm |= KEY__VIEW;
> +				break;
> +			case KEY_NEED_READ:
> +				key_perm |= KEY__READ;
> +				break;
> +			case KEY_NEED_WRITE:
> +				key_perm |= KEY__WRITE;
> +				break;
> +			case KEY_NEED_SEARCH:
> +				key_perm |= KEY__SEARCH;
> +				break;
> +			case KEY_NEED_LINK:
> +				key_perm |= KEY__LINK;
> +				break;
> +			case KEY_NEED_SETSEC:
> +				key_perm |= KEY__SETATTR;
> +				break;
> +			case KEY_NEED_INVAL:
> +				key_perm |= KEY__INVAL;
> +				break;
> +			case KEY_NEED_REVOKE:
> +				key_perm |= KEY__REVOKE;
> +				break;
> +			case KEY_NEED_JOIN:
> +			case KEY_NEED_PARENT_JOIN:
> +				key_perm |= KEY__JOIN;
> +				break;
> +			case KEY_NEED_CLEAR:
> +				key_perm |= KEY__CLEAR;
> +				break;
> +			}
> +			bit <<= 1;
> +			count >>= 1;
> +		}

So I assume then that it is unreasonable to have key_permission() limit 
its inputs to single-permission-at-a-time checks and therefore we have 
to permit multiple permissions?  David? If not, is there any concern 
about the performance overhead of this loop and if so should we optimize 
for the common case of a single permission?

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ae840634e3c7..6b264b6d9d31 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -79,6 +79,7 @@ enum {
>   	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>   	POLICYDB_CAPABILITY_CGROUPSECLABEL,
>   	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> +	POLICYDB_CAPABILITY_KEYPERMS,
>   	__POLICYDB_CAPABILITY_MAX
>   };
>   #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> @@ -178,6 +179,13 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)

This will collide with 
https://lore.kernel.org/selinux/20200128191656.111902-1-cgzones@googlemail.com/ 
so we'll have to sort out which one goes first.
