Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51721C35254
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 18:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1990E20656
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 18:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cYxDEnKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBJSjU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:39:20 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:32953 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBJSjU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 13:39:20 -0500
X-EEMSG-check-017: 57740793|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="57740793"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Feb 2020 18:39:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581359957; x=1612895957;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=M2CM1ECSB1YoFoLruvBDWXjPuKVbY3UvyLrr7QGAKh0=;
  b=cYxDEnKoMXF7osVvF7OdB5nKkiZZ7Q850b2Qm59ImqsZ+6GJ/tU10CQD
   iAjYPSd1CZb3swtrs5y2m1wBXhVYlCBhWUUzXXfogSJbrzzT4YbQdukrw
   CbNY4WFspSEQNcLwJ61/OcmXQRZ3fZnUF2B8FZyELpapuiWH9FwEfN7B6
   fRembA7Jyp1M/vEAmy79HtOpRtBTGXsRB9X/G9NU6lSgguKRhUNS5bTaW
   YYLwrjO8qLgHlVl2LJqlAYfHuTnixaifgP2sSPjIppy3SgMQg55VBfamO
   WwF2+uHLunkVe8aG0P3uwPyQxwSAqXKlItRa+N4ZcVm1CUNsfpnAGNDKC
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="32887070"
IronPort-PHdr: =?us-ascii?q?9a23=3AAtnLnBfyA/IAO7SDwtXnQOSJlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW9bB7h7PlgxGXEQZ/co6odzbaP7+a+ACdZucvJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HIr3dVdOha2H9kKFKOlBr4+su84YRv/itNt/8v7cJMTbn2c6ElRrFEEToqNH?=
 =?us-ascii?q?w46tf2vhfZVwuP4XUcUmQSkhVWBgXO8Q/3UJTsvCbkr+RxwCaVM9H4QrAyQj?=
 =?us-ascii?q?Si8rxkSAT0hycdNj4263/Yh8pth69Guh2hphh/w4nJYIGJMfd1Y63Qcc8GSW?=
 =?us-ascii?q?dHQ81cTDJKDJ+iYIQTDuoBJedYoJf7p1sSthu1GA2gCPryxjNUmnP62Ks33O?=
 =?us-ascii?q?o7EQHCwQcuAdQAvnrJp9nxLasfX+S4wKzOwD7ebf1ZxC395ZDVfB4/r/GCXb?=
 =?us-ascii?q?F+f8TfxkYgFQzKklqepJf5Pz6XzOkBr3SX4uRiWO+plmUpqxtxoj+qxso0l4?=
 =?us-ascii?q?fJmpwaykjE9SpnxoY+OMC2SEthbt6gFJtfqSGbPJZxT8M5Xm5ooz03yqEGuJ?=
 =?us-ascii?q?GnfCgKz44rxxjEa/OdaYSI7RXjVPiILDp+mXlrdrW/hxOo/kihzO3xTsa00F?=
 =?us-ascii?q?dWripFj9nDrWoB2ADU6siCTPZ240Sv2S6X2gzO5exJLlo4mKrGJ5I73LI9mY?=
 =?us-ascii?q?QfvV7eEiLwhU74lrWZdl8+9eit8+nnZ7LmqYKCOIJskQH+N7gumtS4AeQlLg?=
 =?us-ascii?q?gCR2ib9vq41L3k5UD5XK9Fjuc3kqnEq5DWP8Ubpqi3Aw9SyYYs9QqwAy260N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4f1IFHBPOr0DfK+g1SoiDtrxvbGMaP9ApjVM3TOn7jsca?=
 =?us-ascii?q?x95kJB0gY/099S64xOBr0cOP7zX1X+tN3cDh83KQy0xOPnBc1m1owDQmKCGb?=
 =?us-ascii?q?OZMaPOvl+I4eIjOe+MZJQPtzrnJPgl4ODugWcjmVABZampwYcXaHegE/R+J0?=
 =?us-ascii?q?WWe2fsgssbEWgRpAUzV/bqh0OfXj5TfXmyQ7gw6S08CIKjFY3DXJyigKSd3C?=
 =?us-ascii?q?enGZ1bfntGBU6IEXfpcYWERvgNZTmMIs9ujDMET6KtS4w/2hG0sg/11b5nIv?=
 =?us-ascii?q?DT+i0CupKwnORystXeiQt60TVpE96X2mqNBzVsmmoVWyU81YhlrEB9w0vF2q?=
 =?us-ascii?q?991bgQDtFX5vVUQi8kOpPGie93Edb/XkTGZNjaZkyhR4CdHTwpTt83i+QLak?=
 =?us-ascii?q?J5FsTq2gvPxAK2ErQVkPqNH5Vy/aXCiSuib/1hwmrLgfFyx2ItRdFCYCj/3f?=
 =?us-ascii?q?9y?=
X-IPAS-Result: =?us-ascii?q?A2D+AgDaokFe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQViQOGZgEBAQaBEiWJcIonhyQJAQEBAQEBAQEBKwwBAYN7RQKCa?=
 =?us-ascii?q?jgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGDAQEBAQECASMVRgsLDgoCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgmM/AYJWBSAPp3R1gTKFSoMrgTgGgQ4qjD15gQeBEScMA4JdP?=
 =?us-ascii?q?oJkAoR1gl4EjT6KBEaXaoJEgk6EfoVIiTIGG5sPLY43iGyUSiKBWCsIAhgII?=
 =?us-ascii?q?Q87gmxQGA2PRAECgkmKcSMDMI5oAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Feb 2020 18:39:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01AIcLTe116796;
        Mon, 10 Feb 2020 13:38:22 -0500
Subject: Re: [PATCH v4] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20200210182302.352398-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5e88f99a-555c-9467-4cb4-6949b7cfdc98@tycho.nsa.gov>
Date:   Mon, 10 Feb 2020 13:40:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210182302.352398-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/10/20 1:23 PM, Petr Lautrbach wrote:
> get_ordered_context_list() code used to ask the kernel to compute the complete
> set of reachable contexts using /sys/fs/selinux/user aka
> security_compute_user(). This set can be so huge so that it doesn't fit into a
> kernel page and security_compute_user() fails. Even if it doesn't fail,
> get_ordered_context_list() throws away the vast majority of the returned
> contexts because they don't match anything in
> /etc/selinux/targeted/contexts/default_contexts or
> /etc/selinux/targeted/contexts/users/
> 
> get_ordered_context_list() is rewritten to compute set of contexts based on
> /etc/selinux/targeted/contexts/users/ and
> /etc/selinux/targeted/contexts/default_contexts files and to return only valid
> contexts, using security_check_context(), from this set.
> 
> Fixes: https://github.com/SELinuxProject/selinux/issues/28
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---

> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index 689e46589f30..fb53fd436650 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -243,23 +222,84 @@ static int get_context_order(FILE * fp,
>   		if (*end)
>   			*end++ = 0;
>   
> -		/* Check for a match in the reachable list. */
> -		rc = find_partialcon(reachable, nreach, start);
> -		if (rc < 0) {
> -			/* No match, skip it. */
> +		/* Check whether a new context is valid */
> +		if (SIZE_MAX - user_len < strlen(start) + 2) {
> +			fprintf(stderr, "%s: one of partial contexts is too big\n", __FUNCTION__);
> +			errno = EINVAL;
> +			rc = -1;
> +			goto out;
> +		}
> +		usercon_len = user_len + strlen(start) + 2;
> +		usercon_str = malloc(usercon_len);
> +		if (!usercon_str) {
> +			rc = -1;
> +			goto out;
> +		}
> +
> +		/* set range from fromcon in the new usercon */
> +		snprintf(usercon_str, usercon_len, "%s:%s", user, start);
> +		usercon = context_new(usercon_str);
> +		if (!usercon) {
> +			if (errno != EINVAL) {
> +				free(usercon_str);
> +				rc = -1;
> +				goto out;
> +			}
> +			fprintf(stderr,
> +				"%s: can't create a context from %s, skipping\n",
> +				__FUNCTION__, usercon_str);
> +			free(usercon_str);
>   			start = end;
>   			continue;

Feel free to make this a fatal error too; I can't see a valid scenario 
for it.  The only cases where context_new() can fail are a syntactically 
invalid context or out of memory.

>   		}

I think we could lift the free(usercon_str); to here or even immediately 
after the context_new() if we stopped including it in the error message 
above.  Then we don't have to repeat it below multiple times.

> +		if (context_range_set(usercon, fromlevel) != 0) {
> +			free(usercon_str);
> +			context_free(usercon);
> +			rc = -1;
> +			goto out;
> +		}
> +		free(usercon_str);
> +		usercon_str = context_str(usercon);
> +		if (!usercon_str) {
> +			context_free(usercon);
> +			rc = -1;
> +			goto out;
> +		}
>   
> -		/* If a match is found and the entry is not already ordered
> -		   (e.g. due to prior match in prior config file), then set
> -		   the ordering for it. */
> -		i = rc;
> -		if (ordering[i] == nreach)
> -			ordering[i] = (*nordered)++;
> +		/* check whether usercon is already in reachable */
> +		if (is_in_reachable(*reachable, usercon_str)) {
> +			start = end;

Still need a context_free(usercon); here in order to avoid leaking its 
memory.

> +			continue;

[...]
