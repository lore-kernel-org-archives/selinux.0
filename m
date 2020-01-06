Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D4EC33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 18:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397752072E
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 18:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="kWYFRyB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAFSds (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:33:48 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:20200 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFSdr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 13:33:47 -0500
X-EEMSG-check-017: 41750988|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="41750988"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jan 2020 18:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578335626; x=1609871626;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5LLwptKmdSyDTYNf1dz+v/XfXagDXhjmCPNsyxKcRyY=;
  b=kWYFRyB5fiGe9C+0jqbGr5vE5Y5UAMmoxafA0J8vBbFTWtiWYB2/XU1i
   rtxmN7d11koXo0j0Yi8cBwEbXbeSuho2FrktLgOLIAuu30c8HyEIneRSi
   VqsTDkhNDP8rykIeqxMj9qIrphFRlgKzeyfQnf4cl8SHZWwVc5Ik+emNs
   PLQ63vFEbqnZrSkNTcV/tThs0/u0nLqfje7a9CLcUUlMNdUhROhtwQSY0
   ykCPImz21GnMo38T2EIpC7hiQmB8+pmygVD4ncvCbGGoRmULHgqi4j2dP
   57WZtHWx4DrXlvmrk/Zppiwc1pnenUvyovd4gJP5pU2d5pZ/PuI6bnP2M
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="31637236"
IronPort-PHdr: =?us-ascii?q?9a23=3A3WhRghYKieoMiTX26EXo7OP/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsi6ZR7h7PlgxGXEQZ/co6odzbaP6Oa6BDRLuM/b+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUbgZduJqksxh?=
 =?us-ascii?q?fUvHdDZvhby35vKV+PhRj3+92+/IRk8yReuvIh89BPXKDndKkmTrJWESorPX?=
 =?us-ascii?q?kt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RC?=
 =?us-ascii?q?ii4qJ2QxLmlCsLKzg0+3zMh8dukKxUvg6upx1nw47Vfo6VMuZ+frjAdt8eXG?=
 =?us-ascii?q?ZNQ9pdWzBEDo66YYQPFe4BNvtGoYf7qVUFsB+yCRCiCe7rzzNFgGL9068n3O?=
 =?us-ascii?q?Q7CQzIwRIuH9wOvnrXotv6OqgdXuKpw6fH1jjDc/Fb1C3h5ITUfB0so/eBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgEiMqYP7JzOV1voCs26G5OR9UOKgkWonqwVvrTmv28whjZ?=
 =?us-ascii?q?LJiZ8Oyl3f6SV4wJo6Jd2/SEJhZ96kC4FfuzuVN4txXMMvWmdlszs0xL0BvJ?=
 =?us-ascii?q?60ZikKyJI/yh/RdfOHd4yI7gj6WOqIODt4n2xqd66ihxao8Eig1u39W8+p21?=
 =?us-ascii?q?hJtipIisTAu38C2hDJ6sWLV+Fx8lmu1DqRzQzf9+dJKl0um6XBMZ4u2Lswm4?=
 =?us-ascii?q?IWsUTEAyD5hl37jLSTdkU44uio7PnnYqn+qp+cKYB0jgb+P7wymsOlG+Q4Mx?=
 =?us-ascii?q?UOX3OB9eS90r3j80r5QK5UgfIqiKXZrJDbKtgbpq6+GQNV1Jos6w2jADu81d?=
 =?us-ascii?q?QYnH0HIEpEeBKBkYfpJ0nDLO33APqwmVihkCpny+rYMrDuHJnBNGXPnK/kfb?=
 =?us-ascii?q?ln6k5czAQzzcpY55JRErwBO+/8WlTqudzEDh42Lwy0w+H9BNV7zYMRQ3iDAq?=
 =?us-ascii?q?CeMKPMqVOI/P4gI/GQZI8JvzbwM/gl5+TvjXAkmV4SZ7Kk3ZQQaHC/EfRmJ1?=
 =?us-ascii?q?uWbWDwjdcGFGcAphA+Q/DyiF2eTT5TYG6/X7om6TEmDIKrFp/DSZqwgLyFxS?=
 =?us-ascii?q?u7G5pWZmdcCl+SC3vna4KEW/IUYiKIPsBhiiAEVaSmS4I5yx6urBX1y6BmLu?=
 =?us-ascii?q?rP4SAYrYjs1MJ05+3IjREy8SZ7ANiD3G2XSGF0hGwITScs3K9juUx91kuD0a?=
 =?us-ascii?q?9gjvxDC9NT4/JJUgEnNZ/T1OF6Fd/yVRzbftuTS1apXM+mATcvQdI12dMOZF?=
 =?us-ascii?q?x9G9q6hBDZwyWqG6MVl6CMBJEs9qLc3n7xJ9tyynrf16kukUMmQs1ROm2ina?=
 =?us-ascii?q?N/6QfTCJDTk0mDlKala74c3CjT+2eH12aOu1tYUAFoW6XfQX8fflfWrcj+5k?=
 =?us-ascii?q?7aTL+hF64nMg1fxs6GM6dKdsPmgk9DRPr4ItveZX++m323BRaJ27yAdpble2?=
 =?us-ascii?q?IY3C/FEkgLjxgT/WqaNQg5HiqhoXzRDDJgFVLxeE7s/u5+qHS0Tk8w0Q6GdV?=
 =?us-ascii?q?Fu172w+hQNn/yTV+sT3q4YuCcmszh0B0yy39bWCtuBpwther5Rbsk74Fhaz2?=
 =?us-ascii?q?LZsA19MYG6I69+gV4edlc/g0S79w92BpRJ2fYjqGgj1gNwNOrM0ElAeyKR9Z?=
 =?us-ascii?q?/3PbLTJy/5+xX5L+bu00zamPOR/b0CoKAgokjnlBmgC05n9nJgydQT2HyZsN?=
 =?us-ascii?q?GCIRATWtrJW1w27FAuqqnTeCgmz5vdz3x3Ka29uTKE3MgmUq9t0RukftFCII?=
 =?us-ascii?q?uaGwLoVc4XHc6jLKotgVftJhYFOv1Csa05JcWrc9OY16OxeuVthjSriSJA+o?=
 =?us-ascii?q?8u/FiL8n9HVuPQ35sDi8qd1w+DWia02EytqejriItEYncUBWP5xi/6Ut0CLp?=
 =?us-ascii?q?ZudJoGXD/9a/a8wc9z0tu0AC9V?=
X-IPAS-Result: =?us-ascii?q?A2CxAAB0fBNe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWsEA?=
 =?us-ascii?q?QELAYF8gWwBIBIqhAmJA4ZjAQEEBoESJYlukHEDVAkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCDTcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQRALGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+CUyWteX8zhU+DJoE9gQ4oAYwyeYEHgTgMA4JdPodZgjwiB?=
 =?us-ascii?q?JY1YUaXPYJAgkWTTwYbmluOU5xpIzeBISsIAhgIIQ+DJ1AYDZt2IwMwjmcBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Jan 2020 18:33:43 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 006IX8c6034771;
        Mon, 6 Jan 2020 13:33:08 -0500
Subject: Re: [PATCH] security: selinux: allow per-file labelling for binderfs
To:     Hridya Valsaraju <hridya@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>
References: <20200106181329.167322-1-hridya@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d78e4db4-5847-082c-189a-f13d7d6a6c7a@tycho.nsa.gov>
Date:   Mon, 6 Jan 2020 13:34:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106181329.167322-1-hridya@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/6/20 1:13 PM, Hridya Valsaraju wrote:
> This patch allows genfscon per-file labeling for binderfs.
> This is required to have separate permissions to allow
> access to binder, hwbinder and vndbinder devices which are
> relocating to binderfs.
> 
> Acked-by: Jeff Vander Stoep <jeffv@google.com>
> Acked-by: Mark Salyzyn <salyzyn@android.com>
> Signed-off-by: Hridya Valsaraju <hridya@google.com>

Do you want binderfs to also support userspace labeling of files via 
setxattr()?  If so, you'll want to also add it to 
selinux_is_genfs_special_handling() as well.

> ---
>   security/selinux/hooks.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 116b4d644f68..3f0669a708e9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -752,6 +752,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>   
>   	if (!strcmp(sb->s_type->name, "debugfs") ||
>   	    !strcmp(sb->s_type->name, "tracefs") ||
> +	    !strcmp(sb->s_type->name, "binderfs") ||
>   	    !strcmp(sb->s_type->name, "pstore"))
>   		sbsec->flags |= SE_SBGENFS;
>   
> 

