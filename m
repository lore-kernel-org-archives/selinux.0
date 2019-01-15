Return-Path: <SRS0=jgNJ=PX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39493C43387
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 17:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A4420675
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 17:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BR8q8Xpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfAORz1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:55:27 -0500
Received: from sonic304-28.consmr.mail.gq1.yahoo.com ([98.137.68.209]:46816
        "EHLO sonic304-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729782AbfAORz1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jan 2019 12:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547574924; bh=NXExawMpIvsIXkCLNqXtDk6tIpkOfQd2tV9ORn/8Apk=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=BR8q8Xpuls5G/wJg6ANc2sxlZ3GiyTCVJ7+WRc3DsqWCegf+eH/b5CImU1J9M0T6OHkb+IKOXp5sLNC2g/+iCnH95jGpZEEcLz839BqZO1/O4NwTfwV0X2FIp12VOlOPXZgSgJa8tm2iiDa1sRTxgtzAaz6egHBNkTcyTB9znr5rKKq/DROPQXlkIhTkQU9VyFVjfL+iyrZTqGvSNt8Q9znqY2Ggg5wRnkOKxamoji7ZjexBXdYWe8L7NSBO/m0VMdMRnA6363NSjUJERv/hx0qGytaOOU/eG+rGSkUnDo/LrNWbg8If2p1anJnOl7H0f2w/UpoKmw6eeXBDyRZQIw==
X-YMail-OSG: 73C8rTgVM1kfrN4se41RHdA8Aj5dB0r5WfV8CR4hR2Wr.q0Uy08HFJiNGXCZN3f
 PR65SlIfZXa0yzFPGR1lptRTVRRlHmybuYTmejwE_YyWpohtIgf8KJeUBWGgnWnP19jmFAf8wKOP
 HmZO2blP9JVSgVMygKQKr043ZlIFwjl49s4CV_1pOsKyz7M_WZP31Pww6Oj.3P7pw2u_xZS2I8UH
 oC4cgTGra_cQGWJxcTZukZxTh9Q_UWSjwskKgughEM_L8b21Kosv2zCf5ZYcXkL8RzgMrFeZCboz
 Zez4amHicpgqnb.6r7I64ZnCyI_0.6BvGwkZSZL97PIQVnkEs5gLfUAi93tO1LsVdj9HDfkFx3Ym
 YRR1lcrT33lSU1uSizjr9_u.J7X8d6XEofvcLvjg391WNUmeUqWKgKQWiyFa5.CY57Si6wZtUPk7
 IHXa_WYPQypt3nyTgXIhtJ8KRb0WCb7wcNKb5MOpucz.VzlAiqFiMODlC0lZ3xg0OI6kZNXWKwei
 dTLZi8evg3cBGFcG8ngVx5.rPm9FUpP3J6W8ykQAIi66_Go0_Pp3aH24c.tQjLAI_QLLNhjmfN1V
 z6JfcmiQEIDb9UsETVlbQZa499gL6d.M8oBXNMHRY6GN2B5wQUTO3WCG7wHSs7z1piVeX7U0K2Zw
 dWfPLVweDeS_bkB7WAQT91uTyZ8Bem4gpxT.Cy2OgmWssTgWOkNKzg2QzdVYiy29gahUY9ZmTFmP
 pNb6sObJQhUrJHL1Vihc43pprISmIkHcaTB2u2ofSXRGCu6Xf_u3ijYqf898NDzz6pSzhnpnwU9j
 PSegTY0fDAAOMMgEwFrGXp.jrpNOpi.uLCgPQEOzqc3E4mRLrnSBi5pgsw3.ac8PgXtXmtNW8k9c
 y.LehedCmxQWRWXpfsxGD2Od3B6D4M__RZcrhZUORYZnyevQ2rxVRwRU2xtoNr858m6r2Xn6qZMN
 VQlivaexTryunpbTMDeTnV2offixJYNyi8nw5vco25Dun071dz_VJrnBXG_TDvOv6jWnP2aBIoec
 WghIejoc1hej9QYSSh0CB5y5b6LfoT28wpl716z7In5q95BNKknS96lRQzqTr2f1FwR1Qw.CVYNH
 oFQiJ.P0UNyctOvY9IQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Tue, 15 Jan 2019 17:55:24 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5a44982ba947d9cf88a497ad0d039bb3;
          Tue, 15 Jan 2019 17:55:21 +0000 (UTC)
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Nazarov Sergey <s-nazarov@yandex.ru>,
        linux-security-module@vger.kernel.org
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com>
Date:   Tue, 15 Jan 2019 09:55:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/2019 9:06 AM, Nazarov Sergey wrote:
> Hello!
> Security modules (selinux, smack) use icmp_send for discarded incorrectly labeled network packets.
> This could be on TCP level too (security_sock_rcv_skb -> cipso_v4_error for INET stream connection, for example).
> icmp_send calls ip_option_echo, which uses IPCB to take compiled IP options.
> After moving IP header data to the end of the struct tcp_skb_cb (since 3.18 kernel), this could lead to
> kernel memory corruption when IP options copying.

Can you explain how that corruption might occur?
Do you have a test case?

> This patch fix a bug, but I'm not sure, that this is a best solution. Perhaps someone more familiar with the
> linux TCP/IP stack will offer a better one.
> Thanks.
>
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -679,7 +679,8 @@ void icmp_send(struct sk_buff *skb_in, i
>  					  iph->tos;
>  	mark = IP4_REPLY_MARK(net, skb_in->mark);
>  
> -	if (ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in))
> +	if (__ip_options_echo(&icmp_param->replyopts.opt.opt, skb_in,
> +			ip_hdr(skb_in)->protocol == IPPROTO_TCP ? &TCP_SKB_CB(skb_in)->header.h4.opt : &IPCB(skb_in)->opt))
>  		goto out_unlock;
>
>
