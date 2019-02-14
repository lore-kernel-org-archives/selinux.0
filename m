Return-Path: <SRS0=aI9x=QV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69017C43381
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 19:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2462E21B1C
	for <selinux@archiver.kernel.org>; Thu, 14 Feb 2019 19:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Pe/0vm2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfBNTfv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:35:51 -0500
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:58015 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726321AbfBNTfv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Feb 2019 14:35:51 -0500
X-EEMSG-check-017: 183247629|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2019 19:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550172928; x=1581708928;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=T7QfZyVhSPeNho2fEtvCI86U0+n5rtdiraJPd66sE0Q=;
  b=Pe/0vm2C20vcBTXA65Wzduaq51cR2g6LwIeSkehv1B4femrRZ8ci6y9L
   9iwf8knZZGSk0KYq+5OwyS+xta8nX1MYjkLO80lt4c+r5HVtJ4G2/53Xe
   6Qz8U5Us547Vpm9KL1y+r3sYB04HUOXU04otHuhNmJ7BWRlfJLGGcCPzr
   S7qFWJ3NkFaCNbxKScw1KlPb5fTGTqj35/L4FPzjp/ALDuuutIm5ChVLi
   cIJrirXq6kv4YyogQYNfrqG2sbyB5OIXg1fGBZvKOwz6xiUaQppIQE9/H
   KfbsbmlnBuAIwrPWTSpPg158jqItPwFSJgeqYfzSpSz7PuxvVtXthtoiy
   A==;
X-IronPort-AV: E=Sophos;i="5.58,369,1544486400"; 
   d="scan'208";a="23949127"
IronPort-PHdr: =?us-ascii?q?9a23=3ATqwVCxMZStPpyhtYXH8l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfX4rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr86Qz?=
 =?us-ascii?q?Si67pgRgHuhikJKjU19HjbhtJsgK5eph+quh5xzJPOYIyNKfRwYK3dc9MZS2?=
 =?us-ascii?q?RPUMleWC5ODZ+zYYYUE+oMP/xVo5Xhq1YArxazAxSnCuP1yj9Pg3/7xbA00/?=
 =?us-ascii?q?g/HgHe3AwvAdQOu2nJotXwLqgSVeS1w7fIzD7eaP5Wwiry6JPTfxA9ofCDQb?=
 =?us-ascii?q?Jwcc3LxUkpDAPKlE+cqYPiPzOLz+kAtXWQ4el4Ve+3lmIqpA58riKvy8sxkI?=
 =?us-ascii?q?XFmI0Yxk7e+Slkxos+OMe2R1RhYdG+FZtdrySaN4xrTcw8W2xooyM6yqEeuZ?=
 =?us-ascii?q?68YSgK1Iwrxx7BZPyDdIiF+g7jW/yLITd5mXJlY6izhwqy8Ee8yu38UdO40F?=
 =?us-ascii?q?BWoSpejtbArHUN1x3X6sSfS/t9+Fmu2SqX2gzO5exJLlo4mKrGJ5I73LI9mY?=
 =?us-ascii?q?QfvV7eEiPunUX5lq6WdkEq+uiy7OTnZ63rpoSBOI9vkQz+LqQvldC/AeQ/KA?=
 =?us-ascii?q?QOWXOb9v6m2L3s+k35Xq1GjucqnanBrJDaOcMbq7ahAwBPz4Yj7w2yDy+839?=
 =?us-ascii?q?QFmXkLNVdFeBWAj4jzJV7COuz3DfC6g160ijdk2+jGPqH9ApXKNnXDi6nufb?=
 =?us-ascii?q?J8605a1QoywstS54xbCr4fOvL/QEzxu8LCDh8/LQO0x/zrCNJn1oMRCiqzBf?=
 =?us-ascii?q?qBOb7WmUeB++ZqJu6LfoJTszH4eNY/4Pu7tmM0gV8Qe+GS2JITbH2pVqB9L1?=
 =?us-ascii?q?6xfWvngtBHF3wD+AU5Urq52xW5TTdPaiPqDOoH7TYhBdfjV9/O?=
X-IPAS-Result: =?us-ascii?q?A2CrAADEwWVc/wHyM5BkHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?VkpgWonhAaUC00BAQEBAQaBCC2JOI5bgXs4AYRAAoNjIjYHDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII6KYJoAQUjBBE6BxALGAICJgICVxMGAgEBgl89gWYNqwt8M4VEhHSBC?=
 =?us-ascii?q?4s5F3iBB4E4gmuICoJXApBASzuRDFwJiyiHJgYZgW6JEodznh8HKoFWKwgCG?=
 =?us-ascii?q?AghD4MngigXjjwhAzCBBQEBj1UBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2019 19:35:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1EJZQ9r031925;
        Thu, 14 Feb 2019 14:35:26 -0500
Subject: Re: [PATCH] scripts/selinux: add basic mls support to mdp
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org
References: <20190214191417.1469-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <89b6edf0-b912-de7e-9ebe-dd2bd81004a6@tycho.nsa.gov>
Date:   Thu, 14 Feb 2019 14:35:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214191417.1469-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/19 2:14 PM, Stephen Smalley wrote:
> Add basic MLS support to mdp.  Usage:
> scripts/selinux/mdp/mdp -m policy.conf file_contexts
> checkpolicy -M -o policy policy.conf
> 
> Then install the resulting policy and file_contexts as usual.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   scripts/selinux/mdp/mdp.c | 131 ++++++++++++++++++++++++++++++--------
>   1 file changed, 103 insertions(+), 28 deletions(-)
> 
> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
> index 073fe7537f6c..4672ee5cc1bd 100644
> --- a/scripts/selinux/mdp/mdp.c
> +++ b/scripts/selinux/mdp/mdp.c
> @@ -97,8 +97,19 @@ int main(int argc, char *argv[])
>   
>   	/* NOW PRINT OUT MLS STUFF */
>   	if (mls) {
> -		printf("MLS not yet implemented\n");
> -		exit(1);
> +		fprintf(fout, "sensitivity s0;\n");

Do we want more than one sensitivity for this example?

> +		fprintf(fout, "dominance { s0 }\n"); > +		fprintf(fout, "category c0;\n");
> +		fprintf(fout, "category c1;\n");
> +		fprintf(fout, "level s0:c0.c1;\n\n");
> +		for (i = 0; secclass_map[i].name; i++) {
> +			struct security_class_mapping *map = &secclass_map[i];
> +
> +			fprintf(fout, "mlsconstrain %s {\n", map->name);
> +			for (j = 0; map->perms[j]; j++)
> +				fprintf(fout, "\t%s\n", map->perms[j]);
> +			fprintf(fout, "} (l1 eq l2 and h1 eq h2);\n\n");

This constraint prohibits all permissions between s0:c0.c1 and s0:c0 
(and vice versa) or between s0:c0 and s0 (or vice versa), for example. 
It requires both low and high levels to be identical for any access to 
be granted.  Not very useful.

Alternatively, we could require dominance (dom), in which case s0:c0.c1 
would have all permissions to s0:c0, s0:c1, or just s0, while s0:c0 
would no permissions to s0:c0.c1 or to s0:c1.  A little more interesting 
but still probably not usable for anything.

Or we could split up the constraints into separate constraints on the 
"read" operations versus the "write" operations like MCS or MLS.  But 
that requires manually writing the constraints; we can't auto-generate 
them for all classes/permissions that way without a separate 
specification of which ones are reads and which ones are writes.  And we 
would also likely need/want separate constraints on "create", 
"transition", etc in order to ensure properly handling of the low/high 
relationships.

Also, since there is only one domain/type defined by mdp, we can't have 
some domains/types exempted and others not, so it is all or nothing.

Kind of hard to create a useful mls policy example without a richer TE 
policy for mdp.

> +		}
>   	}
>   
>   	/* types, roles, and allows */
> @@ -108,34 +119,92 @@ int main(int argc, char *argv[])
>   	for (i = 0; secclass_map[i].name; i++)
>   		fprintf(fout, "allow base_t base_t:%s *;\n",
>   			secclass_map[i].name);
> -	fprintf(fout, "user user_u roles { base_r };\n");
> -	fprintf(fout, "\n");
> +	fprintf(fout, "user user_u roles { base_r }");
> +	if (mls)
> +		fprintf(fout, " level s0 range s0 - s0:c0.c1");
> +	fprintf(fout, ";\n");
>   
>   	/* default sids */
> -	for (i = 1; i < initial_sid_to_string_len; i++)
> -		fprintf(fout, "sid %s user_u:base_r:base_t\n", initial_sid_to_string[i]);
> +	for (i = 1; i < initial_sid_to_string_len; i++) {
> +		fprintf(fout, "sid %s user_u:base_r:base_t",
> +			initial_sid_to_string[i]);
> +		if (mls)
> +			fprintf(fout, ":s0");
> +		fprintf(fout, "\n");
> +	}
>   	fprintf(fout, "\n");
>   
> -	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t;\n");
> -
> -	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t;\n");
> -
> -	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t;\n");
> -	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t;\n");
> -
> -	fprintf(fout, "genfscon proc / user_u:base_r:base_t\n");
> +	fprintf(fout, "fs_use_xattr ext2 user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_xattr ext3 user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_xattr ext4 user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_xattr jfs user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_xattr xfs user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_xattr reiserfs user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_xattr jffs2 user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_xattr gfs2 user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +
> +	fprintf(fout, "fs_use_task eventpollfs user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_task pipefs user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_task sockfs user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +
> +	fprintf(fout, "fs_use_trans mqueue user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_trans devpts user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_trans hugetlbfs user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_trans tmpfs user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +	fprintf(fout, "fs_use_trans shm user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, ";\n");
> +
> +	fprintf(fout, "genfscon proc / user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, "\n");
>   
>   	fclose(fout);
>   
> @@ -144,8 +213,14 @@ int main(int argc, char *argv[])
>   		printf("Wrote policy, but cannot open %s for writing\n", ctxout);
>   		usage(argv[0]);
>   	}
> -	fprintf(fout, "/ user_u:base_r:base_t\n");
> -	fprintf(fout, "/.* user_u:base_r:base_t\n");
> +	fprintf(fout, "/ user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, "\n");
> +	fprintf(fout, "/.* user_u:base_r:base_t");
> +	if (mls)
> +		fprintf(fout, ":s0");
> +	fprintf(fout, "\n");
>   	fclose(fout);
>   
>   	return 0;
> 

