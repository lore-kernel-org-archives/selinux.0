Return-Path: <SRS0=pcBM=ZG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7EBC432C3
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668A5206E1
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 13:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IV9azdrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNNjm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:39:42 -0500
Received: from UHIL19PA39.eemsg.mail.mil ([214.24.21.198]:7200 "EHLO
        UHIL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKNNjl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Nov 2019 08:39:41 -0500
X-EEMSG-check-017: 48335229|UHIL19PA39_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,304,1569283200"; 
   d="scan'208";a="48335229"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Nov 2019 13:39:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573738749; x=1605274749;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=VACjVEgPRryRVDtPI/W4AGPBM9NPkXWrJmoRSM47XEs=;
  b=IV9azdrAq5R/EYv8QVhhhpwX3yvG1qkoBpZrnj1QME3oawEYEQHozipt
   XN0axai/chKQ5PSzHUZZjV5Goma9nBlyNX5A7qjLyLvZsyxQ3vu44zxjW
   TbXla4GXrGNJ20TOOtg0AtndpOOdrlnNgZZOGtbzcZTdXZfH+bUuZ2Mrj
   4pqaDIKnqAkqJt5pnsaFfN3rr1iiR3sQ/j0PBhWYVnDMZoLg3XWPV6G2N
   HGyKXgdqPkbV0PLcyKpUoOlrRb+R9iBd9ujjqqpWbVdKADbJQPcGpzxIo
   sNnIjH5zOaOYD3hG3cQGuM3ng1/5YuzrDpPBQZAyRvdF2PXCvXWhWtOEG
   w==;
X-IronPort-AV: E=Sophos;i="5.68,304,1569283200"; 
   d="scan'208";a="30098744"
IronPort-PHdr: =?us-ascii?q?9a23=3A4I459B+KVLqpLP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B32+McTK2v8tzYMVDF4r011RmVBN6dsqkfwLeM+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanfL9/Ihu7oQrRu8UInIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?VPRMZRUzFKDJ26YYUBEuENOf9Uoof5qlcLqxa1GAuiC/71yjJQm3H4w6M63e?=
 =?us-ascii?q?QiHw/I0gMvENABv2jbotjuKKcfU/q4wLXUwTjNbf5b3yr25ojSchAmpPGBRa?=
 =?us-ascii?q?9+cdbPxkk3FwPKkFOQopH4MTOQzOsNt2yb4PRgVOmyjGMnsBx+oiO0y8cwio?=
 =?us-ascii?q?jGmoIVylfe+SV/24Y6P8e0SEF8Yd66CZZdsTyROYhuQs46Xm1ltyk3xqcGtJ?=
 =?us-ascii?q?KmZiQG1psqywDFZ/CadYWD/wjtW/yLIThigXJoYLe/hxGv/ke+0uD8Tcy00E?=
 =?us-ascii?q?pSripCj9nMqmgB1xzN5ciDTftw5luh1iyV1wDS9+FEOlo4lbbbKpE9wr4wkY?=
 =?us-ascii?q?AfsULfES/thEr6lqqWdkQg+uSw6uTnZKvppoOEOoNphQzzPb4il8yiDegiLA?=
 =?us-ascii?q?QDUHaX9f6h2LH7+E32WrRKjvk4kqnDt5DaINwWprWkDA9OyYsj9xa+ACum0N?=
 =?us-ascii?q?Qfh3UHKklFdwidg4jmPFHOPuj0De2jjFS0jDdr2/fGM6XmApXIKXjDi7Hhcq?=
 =?us-ascii?q?xh5EFC0wcz185Q6I9UCr4bPPL/QFP+tNvdDhUhKQy73/7nCMlh1oMZQW+PGb?=
 =?us-ascii?q?GWMKfTsV+O++IuLPKBZJEauDnjMfgp/f3ugmEjmV8bY6ap2YEbaHeiHvRpcA?=
 =?us-ascii?q?2lZi/LhNsbHGVCmw0lSuXhhV7KBTlWYG20Vqkxzis2BIKvEcHIQYX7xPSa0S?=
 =?us-ascii?q?O6GIBGTn5JB0rKEnrycYiAHfAWZ3G8OMhkxwcYWKChRolp7hSnsAv32vIzNe?=
 =?us-ascii?q?bP0jEJvpLkkt5u7qvckg9kpm88NNiUz2zYFzI8pWgPXTJjmfkk8EE=3D?=
X-IPAS-Result: =?us-ascii?q?A2AnBwAxV81d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CyBQTIqhCmPCVQGgREliWaRQwkBAQEBAQEBAQE0AQIBAYRAAoIgJDgTAg4BA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJtAQUjFVELDgoCAiYCAlcGAQwGAgEBgl8/g?=
 =?us-ascii?q?lMlslSBMoVOgz+BSIEOKIwVGHiBB4E4DIJfPoQvgyaCXgSWVkWXA4I0gjaTE?=
 =?us-ascii?q?AYbmgSOR5wVIoFYKwgCGAghD4MnUBEUn34jAzCBBQEBkREBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Nov 2019 13:39:08 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAEDd8GA017826;
        Thu, 14 Nov 2019 08:39:08 -0500
Subject: Re: [PATCH testsuite] tests/sctp: initialize addrlen for accept(2)
 properly
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191112154929.24292-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e5094f42-bb42-46ac-1747-d89482a64428@tycho.nsa.gov>
Date:   Thu, 14 Nov 2019 08:39:08 -0500
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

Thanks, applied.

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

