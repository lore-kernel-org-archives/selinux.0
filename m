Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9EEC17440
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B587620679
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 16:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oxnwzgSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKLQSa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:18:30 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:37903 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKLQSa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 11:18:30 -0500
X-EEMSG-check-017: 26197498|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,297,1569283200"; 
   d="scan'208";a="26197498"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Nov 2019 16:18:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573575508; x=1605111508;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=BnCLM5YSG2ouBha4JiJFaiAzXH21viAtAuO03iwnCpg=;
  b=oxnwzgSO9DU8PIHmbQuRXUnCSD5QxqDWdLMnplip+lwM/HmWOeHWK0f+
   s0HR7eo3LJvCpNuCnoitarrqcPhlTCVkfv3BvTEYzFn6fmEAbBHGTQGfD
   kNcwbwe2TI9DR4rfml+g8Eci5oSu3IWDiMAXPQF6iPZDKZe201kpIPRKE
   vwRpV1M32O5yWavxzz616C5eAVTqAZttaa1SZKwGetADERzepJHI8TeW8
   eZ40baBEqYSqCv+spTRoCyF/jptPg9aA8y57MIvIBy9m4zCIsvd9VkCP9
   1+d+5tgkE7RAuIvKMM9QYQeofY0AtBfCVO4O57RyT1Nnz9k7lN9RHx++V
   Q==;
X-IronPort-AV: E=Sophos;i="5.68,297,1569283200"; 
   d="scan'208";a="29998137"
IronPort-PHdr: =?us-ascii?q?9a23=3ACHE2oBBoiY1eyWXSfmbRUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPTzrsbcNUDSrc9gkEXOFd2Cra4d0KyP6fGrCTFIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQnPssQajohvJ6YswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDox+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIh3r4xmY?=
 =?us-ascii?q?YTsUTEBCP2nln5jLSKeUk+/+io6uDnbq3npp+aKYB0lhnzPrkhl8GwG+g1Mh?=
 =?us-ascii?q?UCU3KF9emzyrHv51D1TK1PjvIsk6nZtJ7aJd4cpq68GwJVyZss6w2kAje60N?=
 =?us-ascii?q?UXgXkHLFVfdBKBlIjmIUvCIP//Dfehm1isiitkx+jaPr39BZXANn/DkLLmfb?=
 =?us-ascii?q?Zm7U5T0hY8ws5E6pJOFL4OPfLzVVXttNDCEhA5NAm0yf79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPaPJr1CI4uMvI++RZI4aozv9Nfcl6OD0jXMjml8SY7Op3Z0JZ3C8BPhmJF?=
 =?us-ascii?q?+ZYXW/yusGREAMshAzTqTPj0aEWDVeZD7mWKc7/TcyA4+OF4rPRomxxreG2X?=
 =?us-ascii?q?H/VoZbYmFAF0CkD3jlbcOHVu0KZSbUJdVuwRIeUr30cJMszRGjskfBzrNjKu?=
 =?us-ascii?q?fFsnkDuYnLyMl+5+qVkwo7szNzEZLOgCm2U2hokzZQFHcN16dlrBk4kwzS3A?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2A7BgBR2spd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CyBQTIqhCmPBFQGgTaJZpFDCQEBAQEBAQEBATQBAgEBhEACgh0kOBMCDgEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgm0BBSMVUQsOCgICJgICVwYBDAYCAQGCXz+CU?=
 =?us-ascii?q?yWvSIEyhU6DMIFIgQ4ojBQYeIEHgTiCaz6EL4Mmgl4EllBFlnuCL4I2kwgGG?=
 =?us-ascii?q?5l5jkecByKBWCsIAhgIIQ+DJ1ARFJ8aIwMwgQUBAZBXAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 12 Nov 2019 16:18:22 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xACGILCX018071;
        Tue, 12 Nov 2019 11:18:21 -0500
Subject: Re: [PATCH testsuite] tests/sctp: initialize addrlen for accept(2)
 properly
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191112154929.24292-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0e5ee09e-a780-ec3a-8e75-4762f1dd247f@tycho.nsa.gov>
Date:   Tue, 12 Nov 2019 11:18:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191112154929.24292-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/12/19 10:49 AM, Ondrej Mosnacek wrote:
> The 'addrlen' argument of accept(2) must point to a variable containing
> the size of the structure pointed to by 'addr'. In some cases it was
> being left unitialized. Fix this.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   tests/sctp/sctp_asconf_params_server.c | 1 +
>   tests/sctp/sctp_set_peer_addr.c        | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/tests/sctp/sctp_asconf_params_server.c b/tests/sctp/sctp_asconf_params_server.c
> index 3333ba0..ff7473b 100644
> --- a/tests/sctp/sctp_asconf_params_server.c
> +++ b/tests/sctp/sctp_asconf_params_server.c
> @@ -112,6 +112,7 @@ int main(int argc, char **argv)
>   		fclose(f);
>   	}
>   
> +	sinlen = sizeof(sin);
>   	new_sock = accept(srv_sock, (struct sockaddr *)&sin, &sinlen);
>   	if (new_sock < 0) {
>   		perror("accept");
> diff --git a/tests/sctp/sctp_set_peer_addr.c b/tests/sctp/sctp_set_peer_addr.c
> index 61a3a44..c35b518 100644
> --- a/tests/sctp/sctp_set_peer_addr.c
> +++ b/tests/sctp/sctp_set_peer_addr.c
> @@ -277,6 +277,7 @@ int main(int argc, char **argv)
>   		printf("Client peer address count: %d\n", peer_count);
>   
>   	/* Client and server now set so accept new socket on server side. */
> +	sinlen = sizeof(sin);
>   	new_sock = accept(srv_sock, (struct sockaddr *)&sin, &sinlen);
>   	if (new_sock < 0) {
>   		perror("accept");
> 

