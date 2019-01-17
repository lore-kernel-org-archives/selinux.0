Return-Path: <SRS0=ZoZM=PZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A9EC43387
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 14:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F0220856
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 14:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MO6F+rst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfAQOQ4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:16:56 -0500
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:54570 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQOQ4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Jan 2019 09:16:56 -0500
X-EEMSG-check-017: 182817932|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Jan 2019 14:16:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547734612; x=1579270612;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=LhMeP4mLoiBPO2scHyxA5J5X7BhiRuEWmkPBFaVvk6M=;
  b=MO6F+rstMqDQ2t076EGQ7QM3jcBJdn+1y6vykhgbFuWWV8qyiEQxqVBW
   m7eN36R9HfOGg6VaFyki1gky3d06S1Jg2o1Xim0dcaloqfVo9O5Z8gw16
   lVwOkmtKtjnpiKdAcT4Q5jEtwZJvjz8pc6Qz4wrzRSWQRYABuraIbm4Xy
   ndalZ3RsBXiepiDlAohdmO/IpRM/yWEER6DGWgkRzs3elBMzspY7IJm3F
   4jZGEXESzLwl3kwC0tAas0bQ3zmVh7TBGNbNyJ4USwC8YEcDPHEOxSCf4
   J0P8XGozcsVnezZL6YZTNNbx8i/AzeoloxtkMom5kH88CaEFoZRnPulMU
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539648000"; 
   d="scan'208";a="22785151"
IronPort-PHdr: =?us-ascii?q?9a23=3AaM622BM4PhWH1IAFKuwl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/3/rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cSE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXbOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCqF5tQsjuVN4pwQs46TGFouTo6yr0buZ?=
 =?us-ascii?q?GgZiQF1JMnxxvZZveacIaI+gruWPueLDp3nn5oeK+ziwys/UWv1OHwTNS43V?=
 =?us-ascii?q?BXpSRfiNbMrGoC1xnL58iCTfty41mu1C6U1wDW9uFEOUc0lbfHK5I5wr4/iJ?=
 =?us-ascii?q?4TsUPbEy/qgkr2lq6Wdlg/+uSy9+TmYqnppp+bN4NujAHxLr8uldClDeQ9Mw?=
 =?us-ascii?q?gOW3CX+eW61LL94U30WKhGg/I5n6XDsJ3WON4XqrC2DgNLyIov9g6zDzK839?=
 =?us-ascii?q?QZmXkHIkhFeBWCj4XxIFHBPev4AOyjg1WsjDhrx/fGMqfnApXWNHfPirjhfb?=
 =?us-ascii?q?Fj60JE0go80chf545ICrEGOP/zQkvxu8bFDh8lKQy72PzoBc5n1owARG2PAr?=
 =?us-ascii?q?WWML/IvVCU4eIvJvGGZJUJtzblN/gl+/nugGcimVADeamp3J0XaG23H/l9PU?=
 =?us-ascii?q?WZbmTjgs0bHWcJoAU+Vurqh0OGUTJJYHayRa08tXkHD9eeAJvZDqSknaCb1i?=
 =?us-ascii?q?6wHtUCfmRPF0yWG37AbYiIW/4QLimVJ5kl2icJUbmnVp8Jyx6jrkn5xqBhI+?=
 =?us-ascii?q?6S/TcX5rz5090g3PHejRE/83RPCs2Z12ycBzVvknggWy493Kc5p1d0jFiEz/?=
 =?us-ascii?q?4r0LRjCdVP6qYRAU8BPpnGwrk/UomqVw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CSAABhjUBc/wHyM5BjHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopZk8zJ4QBk3xMAQEBAQEBBoE1iTCQSTAIAYRAAoJWIjcGDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsHAyCOikBgmcBBSMVUQsOCgICJgICVwYBDAYCAQGCXz8BgXQND6sKgS+EL?=
 =?us-ascii?q?gGBFIRwgQuLNBd4gQeBOIJrgx4CgSqDQIJXApBLOZEMCYciimsGGIIyj1mKA?=
 =?us-ascii?q?IUYjVIigVYrCAIYCCEPgycJhgCGcYQAIQMwgQUBAYdfgk0BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Jan 2019 14:16:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0HEGnpF010845;
        Thu, 17 Jan 2019 09:16:50 -0500
Subject: Re: [PATCH] libselinux/audit2why.so: Filter out non-python related
 symbols
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <353f9889-d43c-9a14-4605-5ba1eac22284@tycho.nsa.gov>
 <20190115133629.21263-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e6e56640-b2f6-abca-5c1b-4f192b6c8d7e@tycho.nsa.gov>
Date:   Thu, 17 Jan 2019 09:18:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115133629.21263-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/15/19 8:36 AM, Petr Lautrbach wrote:
> audit2why.so used to export libsepol.a symbols. We only need Python related
> symbols:
> 
> - initaudit2why for python 2
> - PyInit_audit2why for python3
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

I submitted a pull request to trigger Travis CI of this change here:
https://github.com/SELinuxProject/selinux/pull/130

> ---
>   libselinux/src/Makefile      | 2 +-
>   libselinux/src/audit2why.map | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
>   create mode 100644 libselinux/src/audit2why.map
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 8891086e..92e30738 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -165,7 +165,7 @@ $(AUDIT2WHYLOBJ): audit2why.c
>   	$(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
>   
>   $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> -	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(LDLIBS_LIBSEPOLA) $(PYLIBS) -Wl,-soname,audit2why.so,--version-script=audit2why.map,-z,defs
>   
>   %.o:  %.c policy.h
>   	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> diff --git a/libselinux/src/audit2why.map b/libselinux/src/audit2why.map
> new file mode 100644
> index 00000000..65989a8d
> --- /dev/null
> +++ b/libselinux/src/audit2why.map
> @@ -0,0 +1,6 @@
> +AUDIT2WHY_2.9 {
> +  global:
> +    initaudit2why;
> +    PyInit_audit2why;
> +  local: *;
> +};
> 

