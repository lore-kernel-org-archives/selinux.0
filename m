Return-Path: <SRS0=o958=YQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D596CA9EB6
	for <selinux@archiver.kernel.org>; Wed, 23 Oct 2019 14:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C4F21906
	for <selinux@archiver.kernel.org>; Wed, 23 Oct 2019 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PXaL9G8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389941AbfJWO1d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:27:33 -0400
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:58827 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbfJWO1d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Oct 2019 10:27:33 -0400
X-EEMSG-check-017: 24665698|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,221,1569283200"; 
   d="scan'208";a="24665698"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Oct 2019 14:27:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571840849; x=1603376849;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ZOKWJkTvkrAkMW2ErtHOeAB7TiVdzw0L8lSvV+Gboek=;
  b=PXaL9G8PNCuf2xHhvYiOAJ2OdVDl0Q4uGBX2IQPORzx/1PqjBYAWWxAF
   4ENPaZ/VQ1muZWdUV1xIiFdxkveml7aljV8X/YZvykUEEBO6GmLkE8gRV
   ohGnjOzBMjOaeTd3S0wnIDZhfhhGYO5uz57leK/qaAGxr3L1vZ1zfgpuo
   OTm9kqzWiTsbBnvdH+RtrX2+8YY1boBVfojsYpCwjvDsFpyw5ODRcBzIz
   sJiCh9sc6KW68U657AhF4J970q6MXenwJAk8X57a3g1CHqFFAAYrdz0QP
   Wvl+EqKjpX/fOhbx/AarzJqG1tZ9P2w5iRMLrp/cJuzO7+LIe8tc6PQ+E
   w==;
X-IronPort-AV: E=Sophos;i="5.68,221,1569283200"; 
   d="scan'208";a="34554434"
IronPort-PHdr: =?us-ascii?q?9a23=3AQDUnMx8MBe9Yvv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B31OIcTK2v8tzYMVDF4r011RmVBN6du6MP1LeempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCC+bL52Ixm7rwXcvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/9KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe90VRX?=
 =?us-ascii?q?BFXs1MSSJPBI2yZJYLA+YYM+tVq4zxql0TphW8GAasHvvixCJWiH/43aM00O?=
 =?us-ascii?q?ovHg/J0wMiA90Av2/ZrMn3OaoITey50KfFwDfFYvhL2Tn98o/IchU5rP+RQb?=
 =?us-ascii?q?J/b9LRyUkxGAPDk16etInlMCmR1uQJrWea7/drWOW0i2E6sAF8uSSvx8cwhY?=
 =?us-ascii?q?nJgYIZ0FbE9T5jz4ovKt24T1B7bMeiHZBNtC+aL5N7Tt4tTmxnoio3yqAKtY?=
 =?us-ascii?q?SlcCUF1pgr3QPTZvqaeIaS+B3jTvyeITJgiXJgf7Kwmgi9/FC7yu35Ssm0yF?=
 =?us-ascii?q?FKrjdZktXUtnACyRjT6s+fR/th5EihwzeP1x3I6u1ePUA1lbbUK54mwrIqkJ?=
 =?us-ascii?q?ocrV/DETPslEXzja+Wcl0o+umu6+v5frXrvoKQOoB7hw3kMqkih9azDfo3Pw?=
 =?us-ascii?q?QQRWSX5Pyw1Lj58k34RLVKgOc2kq7csJ3CPsQUu7W5DhRJ0ocj9xm/DzCm3M?=
 =?us-ascii?q?4enXkcNl1JYh2Hj4/3O13WOvD3Ee+/g0iwkDds3/3GILjhApLPLnnCkbfhZq?=
 =?us-ascii?q?1w61RCxwUuzdBQ/Y5UBqsdL/L0X0/7rMbYAQMhMwyo3+bnD81w1pgAVmKLA6?=
 =?us-ascii?q?+ZNr7SsFCT6+IxLOmDepUVtCz+K/c7/f7ui2E2mVsHcamux5sXZyPwIvMzHU?=
 =?us-ascii?q?SFKV/rgMUACi9eoA85Tv7rk3WYXDJTbmr0VKU5sHVzE4+iDIHeVqizj7Gbmi?=
 =?us-ascii?q?S2BJtbYiZBEF/fP23vctC/R/oUaC+UavRkmzgAWKnpH5QtzjmypQT6zPxhNe?=
 =?us-ascii?q?OS9SoG48GwnONp7vHewElhvQd/CN6QhiTUFDB5?=
X-IPAS-Result: =?us-ascii?q?A2AaAACRYrBd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBZwYBAQELAYFzLIFAMiqEJ4gihk1UBoE2iX2PNIF7CQEBAQEBAQEBATQBA?=
 =?us-ascii?q?gEBhEACgzQkNAkOAgwBAQEEAQEBAQEFAwEBbIVDgjopAYJsAQEBAQIBIxVGC?=
 =?us-ascii?q?wsOCgICEgETAgJXBgEMBgIBAYJfP4JTBSCxPXWBMoVOgzGBSIEOKAGMDhh4g?=
 =?us-ascii?q?QeBESeCaz6BF4N2AoJGgjwiBIxqiGhhlyuCLoIyjXyEcgYbmU6ONptBOYFYK?=
 =?us-ascii?q?wgCGAghDzuCbFAQFJFoJQMwgQYBAYxlDReCNQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Oct 2019 14:27:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9NERSPF015526;
        Wed, 23 Oct 2019 10:27:28 -0400
Subject: Re: [PATCH] python/semanage: Document DCCP and SCTP support
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
References: <20191021143736.13456-1-vmojzis@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <4f7a9197-f42d-83c1-c2ad-50989157aac1@tycho.nsa.gov>
Date:   Wed, 23 Oct 2019 10:27:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021143736.13456-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/21/19 10:37 AM, Vit Mojzis wrote:
> Add DCCP and SCTP protocols in semanage port man page and --help
> message.
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, applied but see note below for future reference.

> ---
>   python/semanage/semanage        | 5 +----
>   python/semanage/semanage-port.8 | 2 +-
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 864f9212..b2fabea6 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -73,9 +73,6 @@ usage_interface_dict = {' --add': ('-t TYPE', '-r RANGE', 'interface'), ' --modi
>   usage_boolean = "semanage boolean [-h] [-n] [-N] [-S STORE] ["
>   usage_boolean_dict = {' --modify': ('(', '--on', '|', '--off', ')', 'boolean'), ' --list': ('-C',), '  --extract': ('',), ' --deleteall': ('',)}
>   
> -
> -
> -

Generally you should avoid unrelated whitespace fixes in a patch and put 
those in a separate patch.

>   class CheckRole(argparse.Action):
>   
>       def __call__(self, parser, namespace, value, option_string=None):
> @@ -248,7 +245,7 @@ SELinux Range for SELinux user defaults to s0.
>   
>   def parser_add_proto(parser, name):
>       parser.add_argument('-p', '--proto', help=_('''
> -    Protocol  for  the specified port (tcp|udp) or internet protocol
> +    Protocol  for  the specified port (tcp|udp|dccp|sctp) or internet protocol
>       version for the specified node (ipv4|ipv6).
>   '''))
>   
> diff --git a/python/semanage/semanage-port.8 b/python/semanage/semanage-port.8
> index a21287c0..12ec14c2 100644
> --- a/python/semanage/semanage-port.8
> +++ b/python/semanage/semanage-port.8
> @@ -49,7 +49,7 @@ SELinux type for the object
>   MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux login mapping defaults to the SELinux user record range. SELinux Range for SELinux user defaults to s0.
>   .TP
>   .I   \-p PROTO, \-\-proto PROTO
> -Protocol for the specified port (tcp|udp) or internet protocol version for the specified node (ipv4|ipv6).
> +Protocol for the specified port (tcp|udp|dccp|sctp) or internet protocol version for the specified node (ipv4|ipv6).
>   
>   .SH EXAMPLE
>   .nf
> 

