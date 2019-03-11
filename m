Return-Path: <SRS0=naTH=RO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68ADC43381
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 20:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A6C2147C
	for <selinux@archiver.kernel.org>; Mon, 11 Mar 2019 20:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OhleqeEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfCKUPn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:15:43 -0400
Received: from ucol19pa13.eemsg.mail.mil ([214.24.24.86]:18632 "EHLO
        ucol19pa13.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKUPm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Mar 2019 16:15:42 -0400
X-EEMSG-check-017: 686007183|UCOL19PA13_EEMSG_MP11.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.39,1,1493683200"; 
   d="scan'208";a="686007183"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Mar 2019 20:15:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1552335342; x=1583871342;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=3wSOEeFGoLEUKCq6ZfkFba1XO0Qff2DOpBmMsf6qMvc=;
  b=OhleqeEaLuYO9EmWDV6njTjJv1alTSikaLL5nc3yfXLrtJTTVbFEiiyN
   3jk3IJdISteGygVYI00qjVcjG2CDKU11C60ghgZxZJyVwj5GcgydG33hX
   8y37DUAN2ouZLKPhogUh7O4fcQkx/KetkSkJ96l2GmOz+zyEqmxFSXhl/
   LLGIqDfBOkW6wHulgTeJbiWhwWuAgfx3NsTnxCpKmGjwlM1cDkdGTodY2
   3718UE+Jb/ioCiJLYsOcaIOXQp/hrRCwHG0D95eD7mrqARY9F2l2iwaB7
   5aPDFyX/DrC/IkhWPa88ZVEoG07sT7mA6/PHptNKZP8yIINtDwV9hugAa
   w==;
X-IronPort-AV: E=Sophos;i="5.58,468,1544486400"; 
   d="scan'208";a="24903218"
IronPort-PHdr: =?us-ascii?q?9a23=3AkqXukR0pXxZBtD6gsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMUL/ad9pjvdHbS+e9qxAeQG9mCs7Qc0qL/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHOfwlEniaxba5vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb5Q6o0WT?=
 =?us-ascii?q?C/5Kl1ThHmhjoMOzog/G3JjsF8iaRWqw+jqRNi2Y7ZeJybOuRwfq3dft0US2?=
 =?us-ascii?q?ROUclTWCNdDY2xdJcPAugbMOpEs4XwqVkDoB2jDgesHuPvzTpIi2fr060mze?=
 =?us-ascii?q?shCQHG0xImH9kTrXrUqc/6NKMWUe+rzKjD0DLOb+hL1jfm84XIbhAgru2MXb?=
 =?us-ascii?q?J3a8bRz1IvGBnfglWfrozlISqY2+IQuGaV6OpgUPigi28hqwxpoTig2N0sio?=
 =?us-ascii?q?/XiYIR0FzE8j95wIktKd23T057ZtGkEJ9OuCGBMIt2X9kiTH12tyog1rIGvp?=
 =?us-ascii?q?u7cDANyJUmwx7QceeIc5OS7hLkTuaRLjF1j29mdrKnnxu+7Eetx+LmWsS0zV?=
 =?us-ascii?q?pGtDRJn9bSunwXyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4Uhwrsslp?=
 =?us-ascii?q?oLtkTDAzP2lF32jKCIckUk/fCl6/j9bbX8p5+cKpR0hhviMqUuhsO/AeM4Ph?=
 =?us-ascii?q?IIX2eH4uSzyKfv/Uj4QLVOlvE2k6/Zv47GJckDu6K0DABY3pwj5hqiFTuqzt?=
 =?us-ascii?q?sVkWcdIF5YYB6HipLmO1DKIPD2F/e/hFGsnS9wx//bJb3sGYnNL3jfn7fher?=
 =?us-ascii?q?Zx8UhcyBEpwtxF6JJUDa8BLOrpWkDtrNzYEgM5MwuszufoFdV90J8RWWKVDa?=
 =?us-ascii?q?+fP6PfqlCI5uUoI+mDYI8apizxJOQi5/7rlXU5g0MSfbG13ZsLb3C1Bu9mLF?=
 =?us-ascii?q?udYXrthNcBDGgLsxEgTOzlllKCSyRfZ3WsUKIm4DE0FoamAZ3ERoC3j7zSlB?=
 =?us-ascii?q?u8S6FXb2ZEC13EIWqgI5WZXfwMYSSdCsBmlTMAWP6qTIp3kVm1uQv7zad3Bv?=
 =?us-ascii?q?Tb9zdetp/50tVxoerJmkIc7ztxWv+B3nmNQmc8pWYBQzs7zegrukBm4kuS2q?=
 =?us-ascii?q?h/xfpDHJpc4O0fAVRyDoLV0+EvU4O6YQnGZNrcDQz3Tw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AiBQDhwIZc/wHyM5BkFgYBAQEEAQEHBAEBgWWBZipog?=
 =?us-ascii?q?QMnhAqTTkwBAQEBAQEGgQgtiT+Oe4FnMgYBg3pGAoQ6IjgSAQEDAQEBBgEDA?=
 =?us-ascii?q?gFsHAyCOimCaAEFIxVRCxgCAiYCAlcGAQwIAQGCXz8BgWgND7BfgS+EMAELA?=
 =?us-ascii?q?QdBQIRyBYELJIstF3iBB4E4gjYHLoMeAQMCgSoBEgGDKYJXA5E8kmUJh1GLN?=
 =?us-ascii?q?QYZgXmRQYp4gRKEU45oIWVxKwgCGAghD4MnghUYg0uFFIVbIwMwAQ13AQGMe?=
 =?us-ascii?q?4I+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Mar 2019 20:15:41 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x2BKFfrq006262;
        Mon, 11 Mar 2019 16:15:41 -0400
Subject: Re: Patch to the context lookup change
To:     Tianjie Xu <xunchang@google.com>, selinux@vger.kernel.org
References: <CADBPxw7XyZdQsipF80cpcYu0h1XvJBhe5_MwndqqSBf5GCuFbQ@mail.gmail.com>
 <CADBPxw6URXXxgsJUqpwGBQ+_oPffOAvfP0j2Rn0Vknk36wPrWA@mail.gmail.com>
 <CADBPxw5JFk625NBXauy+iLBU9fe5vQ8zSt83WONV4c-ViUd9DA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <697013d2-5f0c-e212-d15b-b4b6551034d0@tycho.nsa.gov>
Date:   Mon, 11 Mar 2019 16:12:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CADBPxw5JFk625NBXauy+iLBU9fe5vQ8zSt83WONV4c-ViUd9DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/11/19 3:36 PM, Tianjie Xu wrote:
> Hi there,
> I recently made a change in android's selinux repo. The change
> implements a new lookup helper function for context matches, and it
> aims to skip unnecessary restorecon if the corresponding context
> doesn't change.
> 
> Quote from the commit message. "We used to hash the file_context and
> skip the restorecon on the top level directory if the hash doesn't
> change. But the file_context might change after an OTA update; and
> some users experienced long restorecon time as they have lots of files
> under directories like /data/media. This CL tries to hash all the
> partial match entries in the file_context for each directory; and
> skips the restorecon if that digest stays the same, regardless of the
> changes to the other parts of file_context."
> CL in: https://android-review.googlesource.com/c/platform/external/selinux/+/918713
> 
> I haven't done the work in upstream code to fully implement this
> change. But this CL merges and compiles. It factors out a lookup
> helper function and returns an array of matched pointers instead of a
> single one. The old loopup_common function is then modified to take
> the first element in the array. I wonder if it's possible to merge in
> this change to the lookup functions first? It will make the upstream &
> android repo more consistent and also save some work for future
> merges.

Just like Linux kernel submitting patches [1][2], we want patches to be 
inline in the message for easier review and inline commenting.  Best way 
to do it is to use git send-email after first using git commit --amend 
to work some of the rationale above into the commit message.  See also:

[1] 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#submittingpatches

[2] https://www.ozlabs.org/~akpm/stuff/tpp.txt
