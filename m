Return-Path: <SRS0=fLGi=XV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A55C4360C
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17983222C2
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZHvUumta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfIZMze (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:55:34 -0400
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:19876 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfIZMzd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Sep 2019 08:55:33 -0400
X-EEMSG-check-017: 12246933|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,552,1559520000"; 
   d="scan'208";a="12246933"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2019 12:55:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569502532; x=1601038532;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=ZoXfvAaSCVTkBNoCyiWVJOaQ+rGN6XI8if1uP4igyYY=;
  b=ZHvUumtaxuXmUOIHnDwK2KehaCyTe/IUP6FwuH65UZk3VSSuTzdCgRkR
   XyEl6pfET1hZYuJ92qV1MZgwXQ2yxRo5lMN/peKjCZihOCv4CS3uam6Ug
   XxsjG8fizbvHgKGuGVyIBlLncAO5tjvDj1vbH+u0AK1KJXP5kboCoWr+J
   YIjdSan3RLXVM8W9vt6zthv+S5AGtrVm2wjpTw5NJ6Lzs7mRra9//BPTP
   e1KF7EQevm69H0RNcjcaHLuJOyF8yD4rHlwwMZzW4sQPrN5lXKt9GXgGJ
   3Uk4OldtqJNn6jARzLSTTcqnuyPIYhyhQ8uHCOeBSBLwSVD5BXsmy8+py
   w==;
X-IronPort-AV: E=Sophos;i="5.64,552,1559520000"; 
   d="scan'208";a="33383548"
IronPort-PHdr: =?us-ascii?q?9a23=3ADhGGXh8c+asLl/9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B32+8cTK2v8tzYMVDF4r011RmVBN6dsK4P1rGempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCCzbL59Ixm7rQvcvdQKjIV/Lao81g?=
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
 =?us-ascii?q?4enXkcNl1JYh2Hj4/3O13WOvD3Ee+/g0iwkDds3/3GJrnhDY/QLnjfirfuZq?=
 =?us-ascii?q?xy5lVGyAUt0N9f54hbCq0bLP3vXU/xscTSDgUlPAys3+bnFNJ925sFWW2RBq?=
 =?us-ascii?q?+ZMaXSsUKH5+80PemMa5EauCznJ/gm+fHul3k5lkEZfaWz2psXcn+4TbxaJB?=
 =?us-ascii?q?ChbGb2yvMIDHsQtAM1TKS+kFmLTCJJbX+aRa8w5jgnTomhCNGHDpughL2HwT?=
 =?us-ascii?q?eTAJJbfCZFB0qKHHOucJ+LCNkWbyfHGdNsijwJU/CaToYl0Ry//Fvhx6FPMv?=
 =?us-ascii?q?vf+ipes4nqktdy+buAxlkJ6TVoApHFgCm2RGZukzZNHmRn0Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2C7AACDtIxd/wHyM5BmHAEBAQQBAQwEAQGBVQUBAQsBg?=
 =?us-ascii?q?XMqgUAyKoQijw1NAQEBAQEBBoERJYl1jy2BewkBAQEBAQEBAQE0AQIBAYQ/A?=
 =?us-ascii?q?oMxIzYHDgIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCZwEFIxVRCw4KAgISARMCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/gXcUrw2BMoVMgzuBSIEMKAGMCxh4gQeBOAyCMS4+gReCd?=
 =?us-ascii?q?n8CgkGCWASVJGCXDIIsgi6Nb4RnBhuZK44bmxYDLoFYKwgCGAghD4MnUBAUk?=
 =?us-ascii?q?C8kAzCBBgEBiyACDReCLgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 26 Sep 2019 12:55:13 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8QCtDbc003908;
        Thu, 26 Sep 2019 08:55:13 -0400
Subject: Re: [PATCH] python/semanage: Do not use default s0 range in "semanage
 login -a"
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20190924191523.246357-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8faeb983-35d4-2194-58be-20c6e3c6908f@tycho.nsa.gov>
Date:   Thu, 26 Sep 2019 08:55:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190924191523.246357-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/24/19 3:15 PM, Petr Lautrbach wrote:
> Using the "s0" default means that new login mappings are always added with "s0"
> range instead of the range of SELinux user.
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, applied.

> ---
>   python/semanage/semanage | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 1934a561..f4266cef 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -237,7 +237,7 @@ def parser_add_level(parser, name):
>   
>   
>   def parser_add_range(parser, name):
> -    parser.add_argument('-r', '--range', default="s0",
> +    parser.add_argument('-r', '--range', default='',
>                           help=_('''
>   MLS/MCS Security Range (MLS/MCS Systems only)
>   SELinux Range  for SELinux login mapping
> 

