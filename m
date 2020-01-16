Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E49AC33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F62D206D5
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="c/ugtlBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgAPQTx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:19:53 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:55954 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgAPQTx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 11:19:53 -0500
X-EEMSG-check-017: 46591831|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="46591831"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 16:19:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579191589; x=1610727589;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Dfzo22eWEKTYdI6P6p1bP1lAZFzlgCXCtbXPZgPBcsw=;
  b=c/ugtlBNuOg9T0wL4jIp7nBiTCEHE5NQRYMIattoP/Uraks4miLoTG7Y
   gxI9CJ/I3J4ziYDtcC3qEJWqzDNQrtUE9V1rgQYfFbnmiiLjSwgglQAsk
   kJCkdxry6mGoQtmtgA8tvk1djJN2x17VKH7JVJAYTcl3u3jUsfado6x9m
   JMu9VjfVbKBbufPQtggETcDzobiAzjdL+Mfnixt30oRWmxSfNZyfIIVHN
   udQz8NSuN+f6rpU7Jx1TKzaAeykK6M3lQu0cM4ckKWlWVHZ4Ly+nosOSy
   LuGCukBWLjymklMTHOAulOYw8RX5RjLTpWLm+0L/5xPOg7HG3/luCpLAQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="32033378"
IronPort-PHdr: =?us-ascii?q?9a23=3AvBzXWhJcDVidVXIg4dmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKv7yrarrMEGX3/hxlliBBdydt6sYzbKL+PC7ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4Nqo8yh?=
 =?us-ascii?q?TFr3hGdu9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXrZodHwOKoUTOu7zrTHzS/bYv1Lxzn95ojGfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjFids5DpMy+b2+kPtWWQ8upuVfioi24iswx/vySvydk0io?=
 =?us-ascii?q?nJmI0VzE3P+zh8wIkvId24TFB0YN65G5ZXrCGVKpB2T9g+Q2BopCk6yroGtY?=
 =?us-ascii?q?S9fCgR0psr3RHfa/uZc4WR5B/oSeifITB9hH1/ebK/gQ6//lK9xeLmU8m7zU?=
 =?us-ascii?q?xKoTBGktbSrHwCyxvT6s2BR/Bg/UmhwS6C2x3c5+xLO0w5lbfXJ4Q/zrM/iJ?=
 =?us-ascii?q?Yfq1nPEynrk0vslqCWbF8r+u2w5uTiZbXpu4GTOpdvigH7LqQugsu/AfkkMg?=
 =?us-ascii?q?QWX2iU5+C81Lr78E3lWrpKlPw2krTCsJzAJMQboKC5AwhO0ok99xmzFSum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHgJTyO17SOvz4CPa/g1C0nDdqwfDJIKHhD43QInXMn7rtZ7?=
 =?us-ascii?q?Zw51NGxAYtwt1T+YhYBqwZLPL2QEDxtdjYDhEjMwyzxubqEM592Z4FWW+UHq?=
 =?us-ascii?q?+YML/dsV+P5u41JemMf5UatCzyK/gi+f7ilWU5lkMFfam1wZsXb2i1HvZ4LE?=
 =?us-ascii?q?WXb3rsnMwMEWgNvgo5Q+zqjEONXSRPaHa1WqI2/is7B56+DYffWoCth6SM3D?=
 =?us-ascii?q?ylEZ1SZ2BGDE2MEHjzeoWaVPcDdjiSLtVikjMaT7ihTZEu1RW0uA/90bpnIf?=
 =?us-ascii?q?Le+jcEupL7yNh1++rTmAkq9TNuEsSd13qAT3lukWMVQz86xaV/oUt6yleZz6?=
 =?us-ascii?q?d0meBXFdtW56ABbgBvF5PSwaREAtb+VxiJRcuORU7uFterDz8vZt02xNAKbg?=
 =?us-ascii?q?B2HND0yljY0i6rBaIFv6KECYZy8a/G2XX1YcFnxCXozq4k2mI6T9NPOGvuva?=
 =?us-ascii?q?t28wzeFsadiEmCv7q7fqQbmijW/SGMynTY7xIQaxJ5TaiQBSNXXUDRt9msox?=
 =?us-ascii?q?qZHrI=3D?=
X-IPAS-Result: =?us-ascii?q?A2C5BAAsjCBe/wHyM5BbChwBAQEBAQcBAREBBAQBAYF7g?=
 =?us-ascii?q?X2BGFUgEiqEEIkDhl8BAQEGgTeJbpByA1QJAQEBAQEBAQEBKwwBAYRAAoImO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJ5AQEBAQIBIwQRQQULCxgCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgmM/AYJWBSAPqyB1fzOFSoNVgTgGgQ4ojDZ5gQeBOA+CKDU+g?=
 =?us-ascii?q?mQDgTeDO4JeBJcwRpdWgkOCSYR0jm0GG5pwLY4viGCUNSI3gQ0MCCsIAhgII?=
 =?us-ascii?q?Q+DJ1AYDYgNF4NQinEjAzCNbAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Jan 2020 16:19:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GGJ4lL014223;
        Thu, 16 Jan 2020 11:19:07 -0500
Subject: Re: [PATCH] selinux: map RTM_GETLINK to a privileged permission
To:     Jeff Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20200116142653.61738-1-jeffv@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a064ee53-d5d4-4c81-d861-963ae13ef1e4@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 11:20:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116142653.61738-1-jeffv@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/20 9:26 AM, Jeff Vander Stoep wrote:
> Persistent device identifiers like MAC addresses are sensitive
> because they are (usually) unique and can be used to
> identify/track a device or user [1]. The MAC address is
> accessible via the RTM_GETLINK request message type of a netlink
> route socket[2] which returns the RTM_NEWLINK message.
> Mapping RTM_GETLINK to a separate permission enables restricting
> access to the MAC address without changing the behavior for
> other RTM_GET* message types.
> 
> [1] https://adamdrake.com/mac-addresses-udids-and-privacy.html
> [2] Other access vectors like ioctl(SIOCGIFHWADDR) are already covered
> by existing LSM hooks.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
> diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
> index c97fdae8f71b..aa7064a629a0 100644
> --- a/security/selinux/nlmsgtab.c
> +++ b/security/selinux/nlmsgtab.c
> @@ -208,3 +208,27 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
>   
>   	return err;
>   }
> +
> +static void nlmsg_set_getlink_perm(u32 perm)
> +{
> +	int i;
> +
> +	for (i = 0; i < sizeof(nlmsg_route_perms)/sizeof(nlmsg_perm); i++) {

Usually we'd use ARRAY_SIZE(nlmsg_route_perms) here.

> +		if (nlmsg_route_perms[i].nlmsg_type == RTM_GETLINK) {
> +			nlmsg_route_perms[i].perm = perm;
> +			break;
> +		}
> +	}
> +}
> +
> +/**
> + * The value permission guarding RTM_GETLINK changes if nlroute_getlink

Doesn't quite parse, maybe "The value of the permission" or just "The 
permission".

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 0e8b94e8e156..910b924fa715 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
>   static struct selinux_ss selinux_ss;
> @@ -2223,6 +2224,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   
>   		state->ss->sidtab = newsidtab;
>   		security_load_policycaps(state);
> +		selinux_nlmsg_init();
>   		selinux_mark_initialized(state);
>   		seqno = ++state->ss->latest_granting;
>   		selinux_complete_init();
> 

You also need to call it after the other later call to 
security_load_policycaps() for the policy reload case.
