Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7466DC34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 14:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4871B2176D
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 14:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Yxwd47A1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgBRO7r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:59:47 -0500
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:45473 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgBRO7q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 09:59:46 -0500
X-EEMSG-check-017: 57264966|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="57264966"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 14:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582037985; x=1613573985;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9rhdE4MbgMliJDcahPriAO/UNtJ126x2L/fFmjCGabE=;
  b=Yxwd47A1eKuGOSIpLDjss3DJpxjHd3OSE/W9Ou75PZSv52n46eoFVXrm
   XS9CgFOOTASjgtDY4jNiHCpwG1ZzodS5nZp0Z6oo+ZWtWBsKNzFfn9ugx
   vGOD8WOnHHsUAVQia56EamBawoOyxppUDZr0eTw8FeBUJRYFeeaDx1K+n
   JiV9Y2+jY4hgJEhzH/pEcW2xCB1XdM+04xDupBkcvi3xMDC0PDjtD6ERQ
   qe/AGDY/3CuULjFFu9o1bugSI7aabMRW77NS8CxxMl2jGRPcQUbqFPnt6
   KKvKk1sMFYMY09r4vOClSoYJmITFoxjEp9neNpGboH3m1ItxunDjioN4r
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="33151695"
IronPort-PHdr: =?us-ascii?q?9a23=3AoyeY8ROrdMIPRVEiXMUl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/XyrarrMEGX3/hxlliBBdydt6sYzbWG+P6wEUU7or+/81k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba59IRmsrwjctcYajIphJ60s1h?=
 =?us-ascii?q?bHv3xEdvhZym9vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZErYBIPf0Wk/qstzXFAM2PBKvzub9Ftpyy4MeVniTAq?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896v71k3A5nV4dfa+03ZoYc324APtmLF?=
 =?us-ascii?q?uDYXb2gdcOD30KvgwgQ+zuklGCViRTZ3mqVaIm+j47EJ6mDZvERo21mLyOxj?=
 =?us-ascii?q?q7HplNa2BeEF+MDHPoe5yBW/cLbyKSONFuniYYWrimTo9ynS2p4Sj8x6BqLK?=
 =?us-ascii?q?Lx/TYevJnu15Ah4OjUjhc7/jFcFcmR02iRCWpzmzVMDyQ72KF5vFxV1FiOy+?=
 =?us-ascii?q?57juZeGNgV4OlGFk8CPIPYh8l9DMr/ElbZd8qNYE6vX9HjBDY2VN93yNgLNR?=
 =?us-ascii?q?VTAdKn2yvf0jKqDrldrLmCAJg54+qIxHTqD9pswHbBkq86hh8pRdUZZj7uvb?=
 =?us-ascii?q?J26wWGX92BqE6ejav/MP1HjSM=3D?=
X-IPAS-Result: =?us-ascii?q?A2CFAgCF+0te/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBSJA4ZhBoESJYlwj2OBZwkBAQEBAQEBAQE3BAEBhEACgic4EwIQA?=
 =?us-ascii?q?QEBBQEBAQEBBQMBAWyFQ4I7KQGDAgEFIwQRUQsOCgICJgICVwYBDAYCAQGCY?=
 =?us-ascii?q?z+CVyWsS38zhUqDUIE+gQ4qjD55gQeBEScMA4JdPoQxgyqCXgSNZASJakaXc?=
 =?us-ascii?q?oJFglCUAwYcmyaObZ1PIoFYKwgCGAghD4MnUBgNjigBF4EEAQiNNCMDMJENA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Feb 2020 14:59:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IEwRKK009342;
        Tue, 18 Feb 2020 09:58:29 -0500
Subject: Re: [PATCH] selinux: reduce the use of hard-coded hash sizes
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200217114943.67607-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <072c5073-3810-e2fd-ee54-fe8a5dc163df@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 10:01:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217114943.67607-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/17/20 6:49 AM, Ondrej Mosnacek wrote:
> Instead allocate hash tables with just the right size based on the
> actual number of elements (which is almost always known beforehand, we
> just need to defer the hashtab allocation to the right time). The only
> case when we don't know the size (with the current policy format) is the
> new filename transitions hashtable. Here I just left the existing value.
> 
> After this patch, the time to load Fedora policy on x86_64 decreases
> from 950 ms to 220 ms. If the unconfined module is removed, it decreases
> from 870 ms to 170 ms. It is also likely that other operations are going
> to be faster, mainly string_to_context_struct() or mls_compute_sid(),
> but I didn't try to quantify that.
> 
> The memory usage increases a bit after this patch, but only by ~1-2 MB
> (it is hard to measure precisely). I believe it is a small price to pay
> for the increased performance.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/ss/hashtab.c  | 21 ++++++++++++--
>   security/selinux/ss/hashtab.h  |  2 +-
>   security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
>   security/selinux/ss/policydb.h |  2 --
>   4 files changed, 40 insertions(+), 38 deletions(-)
> 
> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index ebfdaa31ee32..554a91ef3f06 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -27,6 +41,9 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
>   	p->nel = 0;
>   	p->hash_value = hash_value;
>   	p->keycmp = keycmp;
> +	if (!size)
> +		return p;
> +
>   	p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
>   	if (!p->htable) {
>   		kfree(p);

Thanks, this looks promising.  However, I was wondering: if we end up 
with size == 0 (e.g. policy happens to have an empty table), does the 
rest of the hashtab_* code always correctly handle the fact that 
->htable could be NULL?  Doesn't look obviously safe to me on a quick look.

