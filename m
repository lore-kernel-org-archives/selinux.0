Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF1AC282C8
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 17:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D77220989
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 17:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Kvp+gDYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfA1QE3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:04:29 -0500
Received: from upbd19pa09.eemsg.mail.mil ([214.24.27.84]:48250 "EHLO
        UPBD19PA09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfA1QE3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 11:04:29 -0500
X-EEMSG-check-017: 165584465|UPBD19PA09_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPBD19PA09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Jan 2019 16:03:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548691436; x=1580227436;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=cQ3crCy21US8T6DKsJo9yi4FBXpA309H0JKD6ESXKWA=;
  b=Kvp+gDYShPFEx7BA+97g0mRv90123zln8tsOeVanG4HhTwzliqPoluab
   pKXeO3BTKwMSrC//XZQt8JFDCX9DFYd55Ef7PQW6ZXK65N5DSV645293I
   bK+THhSF3O0EwaxMs5+seBZxupeAAcr5KRbOlScqTwwwNL43Z0ijCv1eF
   63ktwLX9JcJNSKU37SpSjRnZ3UEmIJS41QkIvsUOMY8AaJiIr4s4DWlUY
   tTiXmMV0c8ZIkVFLBNgUhUfrb26LU2b3guDxs1sJlbjDRsiwIfuDbC1jP
   6iT1+XFsz5wZKhEaXConnq1igv0vP16B/kz+riWaYM0AMPWyqGtQ67wHX
   A==;
X-IronPort-AV: E=Sophos;i="5.56,534,1539648000"; 
   d="scan'208";a="23155742"
IronPort-PHdr: =?us-ascii?q?9a23=3AaIESihPKZadx0JTY66Il6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/r+rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cRE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXbOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0lzdrwvfGPqbnAprXMnfMjqzsfa?=
 =?us-ascii?q?xj5EFByAo818xf64hIBbEGJfL5QlXxu8DADh8lLwy0xP7qCM5j2YMaWGKPBL?=
 =?us-ascii?q?KZMazJvF+W6eIgPfOMaJUWuDnjMfgl4eDhjXsjlV8aZ6mp0oMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88ZEWgQowo+SPfniEWYXj5OY3a+Rqc85jY8CIK8E4jPXJyigLuE3H?=
 =?us-ascii?q?TzIpoDQWZKEF2OWVLvbIONUPoPIHaVJ8h6lDUPWJC7RoMh3A3ovwj/nf4vNe?=
 =?us-ascii?q?fQ+ysFpbr929Vvoe7ejxc/8XpzFcvZm1mEUmU8u2QPXTJ+iLh2vEhV0l6e1e?=
 =?us-ascii?q?19hPtCGJpY4PYfASkgMpuJ9PB3E9D/XEr6e96NTFu3CoG9DSoZUsM6w9hIZV?=
 =?us-ascii?q?10XdqlkEaQjGKRH7YJmunTV9QP+aXG0i20fpwlxg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DaAgCDJ09c/wHyM5BlHAEBAQQBAQcEAQGBZYFbKYE4M?=
 =?us-ascii?q?ieEApRZAQEBAQEBBoEILYk1kE44AYRAAoMfIjgSAQMBAQEBAQECAWwogjopA?=
 =?us-ascii?q?YJnAQUjFVELDgoCAiYCAlcGAQwGAgEBgl8/gXUNqluBL4VDhF6BC4s2F3iBB?=
 =?us-ascii?q?4E4gmuICoJXAolZEoZ4OVaQVQmSKAYYkiwtiWiTFCGBVisIAhgIIQ+DJ5B6I?=
 =?us-ascii?q?QMwgQUBAY44AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Jan 2019 16:03:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0SG3gFA026407;
        Mon, 28 Jan 2019 11:03:47 -0500
Subject: Re: [PATCH v2] selinux: replace BUG_ONs with WARN_ONs in avc.c
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20190128154333.31279-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <84f36c6a-f267-95eb-fd66-81592ecf1875@tycho.nsa.gov>
Date:   Mon, 28 Jan 2019 11:06:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128154333.31279-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/28/19 10:43 AM, Ondrej Mosnacek wrote:
> These checks are only guarding against programming errors that could
> silently grant too many permissions. These cases are better handled with
> WARN_ON(), since it doesn't really help much to crash the machine in
> this case.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/avc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 3a27418b20d7..33863298a9b5 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1059,7 +1059,8 @@ int avc_has_extended_perms(struct selinux_state *state,
>   	int rc = 0, rc2;
>   
>   	xp_node = &local_xp_node;
> -	BUG_ON(!requested);
> +	if (WARN_ON(!requested))
> +		return -EACCES;
>   
>   	rcu_read_lock();
>   
> @@ -1149,7 +1150,8 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
>   	int rc = 0;
>   	u32 denied;
>   
> -	BUG_ON(!requested);
> +	if (WARN_ON(!requested))
> +		return -EACCES;
>   
>   	rcu_read_lock();
>   
> 

