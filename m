Return-Path: <SRS0=lyW+=Z2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4629DC43603
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178952073B
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mX61iHlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfLDPld (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:41:33 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:48596 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfLDPld (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Dec 2019 10:41:33 -0500
X-EEMSG-check-017: 35648891|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="35648891"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2019 15:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575474090; x=1607010090;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=MSLdIIju/zwFR/n0VIW6BD7Q4f/o8z3Y12WTbJyTmRg=;
  b=mX61iHlYimmtjfvfqq+jh5ytNEBRyiQ/M57AvJlr6vak3sACuREx4xNs
   XfNqO8dBhGBZ9Ycb/M9nNG2L1Hs8WNn7WOQLfu3jNZN+yr/xMG6+02urU
   DkGfgdhJJZEduUDXYMAwfF4MSCuBVQkBmIyo9FKBE1+I8tJqYPCxGdbJk
   LHa5CJ4TE4X2a+oNxGMpErNM8njCl9G3q3jQvLcb7kAOndieP0j9tqD2Y
   zhWHPJm0osVyH1sw1J48kxyG670clBBtPZRkrgiLd2G3e6LhVLQ27kVZ9
   XveUExYvs1N6aJTLN0d1q3vXfunnikiUVrFZct5CoVhRyBHhStXGTm+97
   w==;
X-IronPort-AV: E=Sophos;i="5.69,277,1571702400"; 
   d="scan'208";a="30747788"
IronPort-PHdr: =?us-ascii?q?9a23=3Avecupxy6EPhVXxHXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2u4WIJqq85mqBkHD//Il1AaPAdyArasb2qGJ7ujJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe65+IReyoAnetMQbgZZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumaraLZ4hzLkwlo?=
 =?us-ascii?q?ENvkvfBCP2hEX3g7OWdkUj4OSo7fjoYq76qZOGMo90iwX+Prwvmsy5H+s4Lh?=
 =?us-ascii?q?ADU3WU9OmzzrHu/VD1TK9UgvA5jKXVqo3WKdwepqGjAg9V1ogj6wy4DzejyN?=
 =?us-ascii?q?kYhmQILEledRKbj4nmJ1HOIPfiAfe5mFSjii1nx//BPr3/GpnNNGTMkK/9fb?=
 =?us-ascii?q?Zh7E5R0BAzzdFD6JJUEL4BOu/8VVftu9PADh82KQ20w+D5B9VmzY4RQn6PAq?=
 =?us-ascii?q?6fMKPOr1CI/OQvLPeQZIMPpDn9LP0l7eb0jXAlgV8dYbWp3ZwPZXCjAPtmJ0?=
 =?us-ascii?q?SZYXzxgtYOCmoKoAU+Q/LwiFGYUj5ceWyyX6Qi6TE/Eo6mCp3DRo/+yICGiR?=
 =?us-ascii?q?26FZ1ffGwOKlmNF3rzP9GeWvwMYTieFcRWkjUFU7W6Y4U91BeyuRX8xqYhJe?=
 =?us-ascii?q?3RrGlQrp/n1d5o98XNmhwosz95FcKQ1yeKVW4nsHkPQmoNwK1noUF7gmyG2K?=
 =?us-ascii?q?x8ju0QQcdf/NtVQww6Mtja1OU8BNfsDFGSNuyVQUqrF431SQo6Scg8lppXOB?=
 =?us-ascii?q?dw?=
X-IPAS-Result: =?us-ascii?q?A2AWAABZ0udd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFtAgEBAQELAYFzgW0gEiqEK4kDhmEGgRIliWmKIIckCQEBAQEBA?=
 =?us-ascii?q?QEBATcBAYRAAoI0NwYOAhABAQEEAQEBAQEFAwEBbIVDgjspAYJtAQEBAQIBI?=
 =?us-ascii?q?xVGCwsYAgImAgJXBgEMBgIBAYJfP4JHAwkFILAFdYEyhU+DNIFIgQ4oAYwwe?=
 =?us-ascii?q?YEHgTgMA4JdPoEOgQ2CGIMmgl4ElnFGlxOCOII5kxsGG4JBjC2LOC2OHZwzI?=
 =?us-ascii?q?4FYKwgCGAghD4MnUBEUjG8DF45BIwMwkWgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Dec 2019 15:41:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB4FfI2m084879;
        Wed, 4 Dec 2019 10:41:18 -0500
Subject: Re: [PATCH] selinux_testsuite: Add socketpair test
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191204143248.17361-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5baf4b29-7964-5004-22e9-11c6679e0c57@tycho.nsa.gov>
Date:   Wed, 4 Dec 2019 10:41:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204143248.17361-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/19 9:32 AM, Richard Haines wrote:
> Test SO_PEERSEC for sockets created by socketpair(2) added in kernel 4.18
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---

> diff --git a/tests/unix_socket/Makefile b/tests/unix_socket/Makefile
> index 5266096..7770f0b 100644
> --- a/tests/unix_socket/Makefile
> +++ b/tests/unix_socket/Makefile
> @@ -2,6 +2,11 @@ TARGETS=client server
>   
>   LDLIBS+= -lselinux
>   
> +# Test SO_PEERSEC for sockets created by socketpair(2).
> +ifneq ($(shell ../kvercmp $$(uname -r) 4.18),-1)
> +	TARGETS += socketpair
> +endif
> +
>   all: $(TARGETS)
>   clean:
>   	rm -f $(TARGETS)

Wondering if we ought to unconditionally build all targets and only 
perform the kvercmp test in the test script itself, as we do in binder, 
inet_socket, keys, and sctp?  Only need to conditionalize the build if 
it won't build under older kernels.

> diff --git a/tests/unix_socket/socketpair.c b/tests/unix_socket/socketpair.c
> new file mode 100644
> index 0000000..50cd3fa
> --- /dev/null
> +++ b/tests/unix_socket/socketpair.c
> @@ -0,0 +1,190 @@
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stddef.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <selinux/selinux.h>
> +
> +#ifndef SO_PEERSEC
> +#define SO_PEERSEC 31
> +#endif
> +
> +#ifndef SCM_SECURITY
> +#define SCM_SECURITY 0x03
> +#endif
> +
> +void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s stream|dgram\n"
> +		"Where:\n\t"
> +		"stream     Use TCP protocol or:\n\t"
> +		"dgram      use UDP protocol.\n", progname);
> +	exit(-1);
> +}
> +
> +int run_parent(int sock, int type)
> +{
> +	int result, on = 1;
> +	char byte, peerlabel[256];
> +	socklen_t labellen = sizeof(peerlabel);
> +
> +	result = setsockopt(sock, SOL_SOCKET, SO_PASSSEC, &on, sizeof(on));
> +	if (result < 0) {
> +		perror("setsockopt: SO_PASSSEC");
> +		goto err;
> +	}
> +
> +	if (type == SOCK_STREAM) {
> +		result = read(sock, &byte, 1);
> +		if (result < 0) {
> +			perror("read");
> +			goto err;
> +		}
> +
> +		result = getsockopt(sock, SOL_SOCKET, SO_PEERSEC, peerlabel,
> +				    &labellen);
> +		if (result < 0) {
> +			perror("getsockopt: SO_PEERSEC");
> +			goto err;
> +		}
> +		printf("Parent got peer label=%s\n", peerlabel);
> +
> +		result = write(sock, peerlabel, sizeof(peerlabel));

You should be writing labellen bytes or strlen(peerlabel) bytes rather 
than sizeof(peerlabel); otherwise you are sending extra uninitialized 
bytes from the stack to the peer.  Looks like elsewhere we are sending 
strlen() of the label.
