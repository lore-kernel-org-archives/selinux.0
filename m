Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1341C33CAD
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 13:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFB82080D
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 13:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="obvoQL36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgAMNqE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:46:04 -0500
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:11828 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMNqD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 08:46:03 -0500
X-EEMSG-check-017: 68680305|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="68680305"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 13:46:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578923162; x=1610459162;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VB1Gg0QpB3xQjqLIw9BZCseVcnO03GV8AR2FwXWgoSY=;
  b=obvoQL36c6FglQ7b5ycxjAQrbt+v64O2BH6AB3CuItwgZMqvEQrFAyGz
   TgvhyuNhDZAHt93nf+5hrFzA1GnNk9AoRDyKWT3z3bGG2ayPrbX1OrLG2
   wstVTerCPqhEWImOFUo27bFqX/8UhRRmG4kTtmO8wu6aOWRNUMJHjImdo
   2HRMng/baSIdTAqS6oIve7F0CWbCO45KQpB2EGLSYJRoJ+E6vpIkOoqIv
   kipeB+iWK04+LluPkxWDStD4ZTWm5YnG/K7yrRsDmaKHiHKV28eWR0Lch
   s0LuPbFMWxUbI5xIUHK3YqrUrsGnCXDiewf7Op+FlEl1iCz57Cgz5WfEB
   w==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="37677237"
IronPort-PHdr: =?us-ascii?q?9a23=3AwpjDYRZELjrGaYtlT4EAoY7/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps+9Yx7h7PlgxGXEQZ/co6odzbaP6Oa6BjRLvMzJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusQUnYduJaY8xg?=
 =?us-ascii?q?XUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU2/nvXishth6xFphyvqQF0z4rNbIybMPdye6XQds4YS2?=
 =?us-ascii?q?VcRMZcTzFPDJ2yb4UPDOQPM+hXoIb/qFQSohWzHhWsCeH1xzNUmnP706833u?=
 =?us-ascii?q?I8Gg/GxgwgGNcOvWzJotXpKqgSSeC1w7fOzT7ecv1W3C3y6IzMch8/ofCHQL?=
 =?us-ascii?q?V9cdHMxkk0DA7FklWRppDlPzOSzOgNtXOb4PB6WeKgjG4ntRh8rz6yzckvko?=
 =?us-ascii?q?nEnp8Zx1/L+CljwIs5OMe0RFB0bNK6CpdcqieXPJZsTMw4WWFnoiM6x6UDuZ?=
 =?us-ascii?q?68YScF1owqxwXaa/yba4iI5Q/jVPqJLTd4mn1lfLW/ig6u8Ue60O38V9S00E?=
 =?us-ascii?q?1QoipElNnMuHcN1wfN5cebUPd94keg1iqP1wDU8O1EJ1w7lbHHJJI7x74wl5?=
 =?us-ascii?q?4TvVzCHi/whkr2kLebelgr9+Wn8ejqYqjqqoWCO4J7lA3yKLkiltS6AesiMw?=
 =?us-ascii?q?gOW2ab+f671L3m5UD5W6hFjuYtn6nFsJHVOcQbpqmjDw9TyYYs8QyzDzih0N?=
 =?us-ascii?q?QGhXUHNk5KeAqbj4j1PFHDOPD5Aum/g1S3jjtn2+zKM7/6D5TMKXjDkLDhca?=
 =?us-ascii?q?xh5E5bzQo51cpf6I5MCrEdPPLzXVf8tMTCAR8kNwy52P7nB89g1oMaQG6PB6?=
 =?us-ascii?q?iZMKTIsVCW/O4gP+6MZIoNsjbnN/cl/+LujWM+mVIFY6apxYEYaGq5HvR9OE?=
 =?us-ascii?q?iZeWDjgs0AEWcRpgo+SPblh0GcXjJJYHayRa087CkhCI26FYfDWpytgLuZ0S?=
 =?us-ascii?q?e5G51WYXpGCkqNEXfzbIiEXe0DaCeMLc9giDAEUqKhS4A53xG0qAD606ZnLv?=
 =?us-ascii?q?bT+iAArpLsysJ15+LNmhwp9Tx7FcCd02WNTmFyhG8HWzg23KVnq0xn1liDyb?=
 =?us-ascii?q?R4g+BfFdFL+/NIUho6OYPHwux+Fd/yXAXBfsmOSFq8XtqmBjQxRMorw9ASe0?=
 =?us-ascii?q?Z9B8mijhfb0iquAr8VkaGLBZMt/qLHwXf+O9t9y2zH1Kk9j1gqW85PNWq7ia?=
 =?us-ascii?q?5i8wjcGZXEk1uWl6m0b6QQxi3N+3mZzWqIok5YVBR8UaLfXXAQfkHWt8j25l?=
 =?us-ascii?q?veT7+yDrQqKhBBxtCGKqtLbN3pkFpHSez9ONTRfW2xgX28BRWWybOWaorlZW?=
 =?us-ascii?q?Ed0D/aCEgenAAZ5WyGOhQmBie9v2LeCyRjFVbuY0Pq7Ol/p2q3TkwqwAGQaU?=
 =?us-ascii?q?1uyb619wULhfyTVfwTxKgIuCQ/pDVuGlaywdbWB8CHpwp7c6VWeck970tf1W?=
 =?us-ascii?q?LFqwx9OYStLqB8iV4eaAR7oljj1xFpBYVGlsgqsnQqwBBuJqKf1VMSPw+fiL?=
 =?us-ascii?q?DtM7zMKmT081ieZuaCy1zey4zOovgn+vM4rBPouwT/UgI6+mhj+8Fczn/Z45?=
 =?us-ascii?q?LNFgdUWpX0Fg467xFgpqryeiAn5pjM0XRnPO+zqDCGk9AsA/E/yw2Ied5aPa?=
 =?us-ascii?q?LCExX9V4UBCtKhJcQqklytfxRCN+dXp4AuOMbzTOeLwK6mOq5bmTuiiWlWqN?=
 =?us-ascii?q?Rm3lmk6zt3SumO2Y0Mhf6fwF3UBH/HkF69v5Wvysh/bjYIEz/6knnp?=
X-IPAS-Result: =?us-ascii?q?A2BuAABqcxxe/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gX2BbAEgEiqEDIkDhmsGgTeJbookhyQJAQEBAQEBAQEBNwEBh?=
 =?us-ascii?q?EACghw4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KYJ6AQEBAQMjBBFBEAsVAwICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCYz+CVyWoF3V/M4VJg0+BPYEOKIwzeYEHgTgPgl0+h1mCX?=
 =?us-ascii?q?gSNVIhwYUaXUYJBgkiTXwYbmmwtji6dByKBWCsIAhgIIQ+DJ1AYDYgNF45BI?=
 =?us-ascii?q?wMwjR4BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 13 Jan 2020 13:46:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DDjLDp229665;
        Mon, 13 Jan 2020 08:45:22 -0500
Subject: Re: [PATCH] selinux: remove redundant selinux_nlmsg_perm
To:     Huaisheng Ye <yehs2007@zoho.com>, paul@paul-moore.com,
        eparis@parisplace.org, jmorris@namei.org, serge@hallyn.com
Cc:     tyu1@lenovo.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
References: <20200112154216.46992-1-yehs2007@zoho.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e7ec908e-01c1-b76d-f797-545b70a49075@tycho.nsa.gov>
Date:   Mon, 13 Jan 2020 08:47:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200112154216.46992-1-yehs2007@zoho.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/12/20 10:42 AM, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> selinux_nlmsg_perm is used for only by selinux_netlink_send. Remove
> the redundant function to simplify the code.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

The patch itself seems fine but it looks like someone accidentally put 
pig= in the log message when they meant pid=; that can be fixed via a 
separate patch.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 73 ++++++++++++++++++++++--------------------------
>   1 file changed, 34 insertions(+), 39 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index fb1b9da..9f3f966 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5507,44 +5507,6 @@ static int selinux_tun_dev_open(void *security)
>   	return 0;
>   }
>   
> -static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
> -{
> -	int err = 0;
> -	u32 perm;
> -	struct nlmsghdr *nlh;
> -	struct sk_security_struct *sksec = sk->sk_security;
> -
> -	if (skb->len < NLMSG_HDRLEN) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> -	nlh = nlmsg_hdr(skb);
> -
> -	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
> -	if (err) {
> -		if (err == -EINVAL) {
> -			pr_warn_ratelimited("SELinux: unrecognized netlink"
> -			       " message: protocol=%hu nlmsg_type=%hu sclass=%s"
> -			       " pig=%d comm=%s\n",
> -			       sk->sk_protocol, nlh->nlmsg_type,
> -			       secclass_map[sksec->sclass - 1].name,
> -			       task_pid_nr(current), current->comm);
> -			if (!enforcing_enabled(&selinux_state) ||
> -			    security_get_allow_unknown(&selinux_state))
> -				err = 0;
> -		}
> -
> -		/* Ignore */
> -		if (err == -ENOENT)
> -			err = 0;
> -		goto out;
> -	}
> -
> -	err = sock_has_perm(sk, perm);
> -out:
> -	return err;
> -}
> -
>   #ifdef CONFIG_NETFILTER
>   
>   static unsigned int selinux_ip_forward(struct sk_buff *skb,
> @@ -5873,7 +5835,40 @@ static unsigned int selinux_ipv6_postroute(void *priv,
>   
>   static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
>   {
> -	return selinux_nlmsg_perm(sk, skb);
> +	int err = 0;
> +	u32 perm;
> +	struct nlmsghdr *nlh;
> +	struct sk_security_struct *sksec = sk->sk_security;
> +
> +	if (skb->len < NLMSG_HDRLEN) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +	nlh = nlmsg_hdr(skb);
> +
> +	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
> +	if (err) {
> +		if (err == -EINVAL) {
> +			pr_warn_ratelimited("SELinux: unrecognized netlink"
> +			       " message: protocol=%hu nlmsg_type=%hu sclass=%s"
> +			       " pig=%d comm=%s\n",
> +			       sk->sk_protocol, nlh->nlmsg_type,
> +			       secclass_map[sksec->sclass - 1].name,
> +			       task_pid_nr(current), current->comm);
> +			if (!enforcing_enabled(&selinux_state) ||
> +			    security_get_allow_unknown(&selinux_state))
> +				err = 0;
> +		}
> +
> +		/* Ignore */
> +		if (err == -ENOENT)
> +			err = 0;
> +		goto out;
> +	}
> +
> +	err = sock_has_perm(sk, perm);
> +out:
> +	return err;
>   }
>   
>   static void ipc_init_security(struct ipc_security_struct *isec, u16 sclass)
> 

