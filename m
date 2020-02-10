Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC85C352A3
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CB32082F
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="AgUhkGPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgBJOV7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:21:59 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:39711 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBJOV6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 09:21:58 -0500
X-EEMSG-check-017: 54413112|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="54413112"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Feb 2020 14:21:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581344517; x=1612880517;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=s8uvl8CyWM97kp6WH57V0Gj/9FmNfR1w0+utmX/0SwA=;
  b=AgUhkGPhS88uL/efFI4ZtQy8bjapHBLH1vLvhgce14JRARGjHyiSUI1u
   ncRjvBZAtM0NqQnUiMmIVLZk8WHyT7gUSsgc2Pn9JHYrL6yopJNN0DIgH
   btJCwLbNfRr6Rtw4RGtEvLtddQO2fV5VadxYJJM8eu/i4lfptpaRAMmA+
   LzlXYGgnlJn7RChmd9jYHXPfwDSsmylMsdj2ltPstO8f9/LaUizFl74Ax
   0szCHLdFQ0cq9B923Jq2qtzRz9kYs8wn3i1vJxpYJcBtGlWzcQCp/cx9E
   0MZ3IZvf+TJWwAhmREpVHYJXf5U+BhdTs4HIpzXixsnGCK8OMwmOeMixu
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="38883105"
IronPort-PHdr: =?us-ascii?q?9a23=3AgrYVShEts5t3dfCNPTGgEJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yoMmwAkXT6L1XgUPTWs2DsrQY0raQ7fmrBzRIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrwwxx?=
 =?us-ascii?q?fUrXdFevhazn5sKV6Pghrw/Mi98INt/ihKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXm?=
 =?us-ascii?q?dKQNpfWDJdDYO9d4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgHH53bc+0+?=
 =?us-ascii?q?88Dw/I2gIuFM8KvHjNotj4MKIeXOaox6fK0DrDdetb1yrj5ojGch4vov+CUr?=
 =?us-ascii?q?x/fsXT1UYhGBjIjkmSpIH/Iz+ZyuoAvmqd4uF9VeyvkWknqwRprzay2scjlJ?=
 =?us-ascii?q?HJhoILxVDC6C533YM1Kse8SE5/f9GlEIZbuiaBN4RrWcMvWH1ouSYmxb0Gvp?=
 =?us-ascii?q?63Zi4KyI89yBLFZPyHdJaI7wvlWe2MLzl4g3dld6i+hxa06UWgxez8VtW00F?=
 =?us-ascii?q?ZXtSVJiMXDtncI1xHV98OJSeN981+81TuA2A3f8OFJLV0umabFJJMt3KQ8mo?=
 =?us-ascii?q?cVvE/eBCH5gl/2g7WTdkg8/+io7Pnobav+q5+HMo90lhn+MqMzmsyjGeg4Mh?=
 =?us-ascii?q?YBX2yc+emkyL3s51f5QLRXjv0tiKXZsZbaJcocpq6iHQBazpwv6wq/Dji60N?=
 =?us-ascii?q?QYmmMLLFRZdxKck4flIVTOIPH8DfunglSslilkx+zeM7H8DZjAIWLPnbf8cb?=
 =?us-ascii?q?pn9UJRxxQ/wcpC655MD7EOOvPzWkv/tNzCCR85NhS5w/36B9VmzY4eRWKODb?=
 =?us-ascii?q?OZMKPVq1OI4PkvLPOWaI8avzb9NeAp5+Tygn8hhV8dYa6p0IMPaHC8BPtmPl?=
 =?us-ascii?q?mZYWD3jdgbCmoKpBQxQ/HqiFKYTT5ffWq9X6U55jsjEoKpEZ/DRpyxgLyGxC?=
 =?us-ascii?q?q7BYNZZmRHClCKDHfpeJ6JW+kDaC2MOM9tiD8EWqa7S48nyx6usBX2y719Lu?=
 =?us-ascii?q?rbqWUkssfb2cRvr8naiA0o/zV/D4zJy2WEUn1ulGogXTI63Klj50d6zwHHmb?=
 =?us-ascii?q?N1h/1eCMx7+fxESEE5OITawug8DMr9CSzbedLcc0qrWtWrB3kKS9s1x9IfKx?=
 =?us-ascii?q?JmF86KkgHI3y3sBaQc0bOMGspnoernw3HtKpMlmD793647ggxjG5AeOA=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2DlAgCoZUFe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQViQOGYwEBAQaBN4lwiieHJAkBAQEBAQEBAQErDAEBg3tFAoJpO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYMBAQEBAQIBIxVGCwsOCgICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCYz8BglYFIA+mUHWBMoVKgySBOAaBDiqMPXmBB4ERJw+CXT6CZ?=
 =?us-ascii?q?AKEdYJeBJdCRogyjziCRIJOhH6OegYbmw8tjjeIbJRKIoFYKwgCGAghDzuCb?=
 =?us-ascii?q?FAYDZIQinEjAzCOaAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Feb 2020 14:21:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01AEKsAu262904;
        Mon, 10 Feb 2020 09:20:54 -0500
Subject: Re: [PATCH v3] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20200208073607.21229-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <19672e97-151e-ead0-0a1f-b3148e35344f@tycho.nsa.gov>
Date:   Mon, 10 Feb 2020 09:23:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200208073607.21229-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/8/20 2:36 AM, Petr Lautrbach wrote:
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
> index 689e46589f30..cc39f8c6a96c 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c

> @@ -243,23 +222,89 @@ static int get_context_order(FILE * fp,
>   		if (*end)
>   			*end++ = 0;
>   
> -		/* Check for a match in the reachable list. */
> -		rc = find_partialcon(reachable, nreach, start);
> -		if (rc < 0) {
> -			/* No match, skip it. */
> +		/* Check whether a new context is valid */
> +		if (SIZE_MAX - user_len < strlen(start) + 1) {
> +			fprintf(stderr, "%s: one of partial contexts is too big\n", __FUNCTION__);
> +			errno = EINVAL;
> +			rc = -1;
> +			goto out;
> +		}
> +		usercon_len = user_len + strlen(start) + 1;
> +		usercon_str = malloc(usercon_len);
> +		if (!usercon_str) {
> +			rc = -1;
> +			goto out;
> +		}
> +
> +		/* set range from fromcon in the new usercon */
> +		snprintf(usercon_str, usercon_len - 1, "%s:%s", user, start);
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
> +			start = end;
> +			continue;
> +		}
> +		if (context_range_set(usercon, fromlevel) != 0) {
> +			if (errno != EINVAL) {
> +				free(usercon_str);
> +				rc = -1;
> +				goto out;
> +			}
> +			fprintf(stderr,
> +			    "%s: can't set a new range %s for %s, skipping\n",
> +			    __FUNCTION__, fromlevel, usercon_str);
> +			free(usercon_str);

I'd think we could always treat this as a fatal error but up to you. 
Regardless, we need to also do a context_free(usercon); here or we will 
leak the memory.

>   			start = end;
>   			continue;
>   		}
> +		free(usercon_str);
> +		usercon_str = context_str(usercon);
> +		if (!usercon_str) {
> +			rc = -1;

context_free(usercon); needed here as well.

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

And again.

> +			continue;
> +		}
> +		if (security_check_context(usercon_str) == 0) {
> +			if (*nreachable == 0) {
> +				new_reachable = malloc(2 * sizeof(char *));
> +				if (!new_reachable) {
> +					context_free(usercon);
> +					rc = -1;
> +					goto out;
> +				}
> +			} else {
> +				new_reachable = realloc(*reachable, (*nreachable + 2) * sizeof(char *));
> +				if (!new_reachable) {
> +					context_free(usercon);
> +					rc = -1;
> +					goto out;
> +				}
> +			}
> +			new_reachable[*nreachable] = strdup(usercon_str);
> +			if (new_reachable[*nreachable] == NULL) {
> +				rc = -1;
> +				goto out;
> +			}
> +			new_reachable[*nreachable + 1] = 0;
> +			*reachable = new_reachable;
> +			*nreachable += 1;
> +		}
> +		context_free(usercon);
>   		start = end;
>   	}
> -
>   	rc = 0;
>   
>         out:
