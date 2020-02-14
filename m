Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D513EC35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 19:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B28206D7
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 19:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="f9Z6ZN5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbgBNTz4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:55:56 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:57996 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387881AbgBNTz4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 14:55:56 -0500
X-EEMSG-check-017: 56318996|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="56318996"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 19:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581710154; x=1613246154;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zMTYNNEJaRnIhgcrrMmCmPoY2EXgdJYfwh0IIkBtidg=;
  b=f9Z6ZN5dbjZVqoULgZdMH0wfITjsa1+7aT+tCtmMU2lRukIXQlx8yqG3
   Ub3JJ4gxDAJr7MD7PRhmvg+9X8wyjOEn7v8VaJqzzA68VaIhBOi4M+jEJ
   u/g/LBaY3ptKp1tzjhptaLhUj0X2OnMBfKL7Ma97ZQ7zY9edgeBr8s/nI
   f5g7ZeJtQTBsVHGs+ZH/zzTIszVg5tIRqqyNqLgHDK2Hk0n5nlVtWWx0X
   j2JlfBbnI0bqjbASa3hGieIQAx/HF29Df6kjSB+3SVoa0vll3F7VTUrGv
   Kh6YC97C2w2odZ7mykpGkXEidPXqUIgimR043I8tjz0CvRK7loU9zeLBJ
   A==;
X-IronPort-AV: E=Sophos;i="5.70,441,1574121600"; 
   d="scan'208";a="33094786"
IronPort-PHdr: =?us-ascii?q?9a23=3Ae+QYCBDRtczRdTA9G+TGUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPTzrsbcNUDSrc9gkEXOFd2Cra4d16yJ6+u5AjRIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/Tu8UKjoduN6g8xg?=
 =?us-ascii?q?fUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrhxzJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAswAsHrUotv2OqkdX++6w6vUwjvMdP5WxTXw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAFt5?=
 =?us-ascii?q?6jZCUG1ZsqyhHFZ/GHboSE+AzvWemPLTtimX5ofq+0iQyo/ki60OL8U9G50F?=
 =?us-ascii?q?NNriVYjNbBrmsN1xnP6sifTft941uh1S6P1w/N7uFEJlg5lbbBJJ47w74wi4?=
 =?us-ascii?q?ETvV7CHi/wlkX2i7SWeVs49eSy9+TmYqnppp+bN4NujAHxLr8uldClDeQ9Mw?=
 =?us-ascii?q?gOW3CX+eW61LL94U30WKhGg/I5n6XDsJ3WON4XqrC2DgNLyIov9g6zDzK839?=
 =?us-ascii?q?QZmXkHIkhFeBWCj4XxIFHBPev4AOyjg1WsjDhrx/fGMqfnApXWNHfPirjhfb?=
 =?us-ascii?q?Fj60JE0go80chf545ICrEGOP/zXUrxtNvDDh8/KQO73/joBc5n1owARG2PAr?=
 =?us-ascii?q?WWML/IvVCU4eIvJvGGZJUJtzblN/gl+/nugGcimVADeamp3J0XaG23H/l9PU?=
 =?us-ascii?q?WZbmTjgs0bHWcJoAU+Vurqh0OGUTJJYHayRa08tXkHD9eBC4vZS4Llpbua2i?=
 =?us-ascii?q?6wE54eMmdDDUuKGHzlX5+JV/cFdGSZJco3wRIeUr30cJMszRGjskfBzrNjKu?=
 =?us-ascii?q?fFsnkDuYnLyMl+5+qVkwo7szNzEZLOgCm2U2hokzZQFHcN16dlrBk4kwzS3A?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CWAgAt+kZe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YINEiqEFIkDhlwBAQEDBoE3iXCRSgkBAQEBAQEBAQE3BAEBhEACgiU4EwIQA?=
 =?us-ascii?q?QEBBQEBAQEBBQMBAWyFQ4I7KQGDAgEFIxVBEAsOCgICJgICVwYNBgIBAYJjP?=
 =?us-ascii?q?4JXJa41gTKFSoNNgT6BDiqMPnmBB4E4D4JdPodbgl4El0dGl22CRIJPjnaFB?=
 =?us-ascii?q?gYcgnmYH6wnIoFYKwgCGAghD4MnUBgNnQEjAzCQWAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Feb 2020 19:55:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EJsqpB014125;
        Fri, 14 Feb 2020 14:54:53 -0500
Subject: Re: [PATCH userspace v2] libsepol: cache ebitmap cardinality value
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
References: <20200213133959.14217-1-omosnace@redhat.com>
 <1a11d058-eee1-41c5-9686-da01ecf6ea33@tycho.nsa.gov>
 <CAFqZXNtpqOszQ5a2s86TTHtQGK_c+vqmtaRPBv04+vFAqExEmg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <16a48f3a-886c-dbd7-52dd-a97329fa8cdd@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 14:57:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtpqOszQ5a2s86TTHtQGK_c+vqmtaRPBv04+vFAqExEmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/14/20 2:51 PM, Ondrej Mosnacek wrote:
> On Fri, Feb 14, 2020 at 6:37 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 2/13/20 8:39 AM, Ondrej Mosnacek wrote:
>>> According to profiling of semodule -BN, ebitmap_cardinality() is called
>>> quite often and contributes a lot to the total runtime. Cache its result
>>> in the ebitmap struct to reduce this overhead. The cached value is
>>> invalidated on most modifying operations, but ebitmap_cardinality() is
>>> usually called once the ebitmap doesn't change any more.
>>>
>>> After this patch, the time to do 'semodule -BN' on Fedora Rawhide has
>>> decreased from ~14.6s to ~12.4s (2.2s saved).
>>>
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>
>> This seems fine but I was wondering how many of the callers of
>> ebitmap_cardinality() actually need anything more than ebitmap_length()?
> 
> The caller that calls it the most (>99%) during a 'semodule -B' is
> __cil_should_expand_attribute(), which logically needs the actual
> cardinality. It might be possible to cache the decision directly in
> 'struct cil_typeattribute', but I don't know the CIL code well enough
> to attempt that...

That's fine - I'm ok with the patch itself.  I just happened to notice 
that there appear to be quite a few callers elsewhere in libsepol that 
only seem to care whether the result is zero or non-zero, which 
seemingly would be just as happy using ebitmap_length().


