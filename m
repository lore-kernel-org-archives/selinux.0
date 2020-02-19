Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755CFC34047
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A82024654
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YI5gU0ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBSNdi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:33:38 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:61163 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgBSNdh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 08:33:37 -0500
X-EEMSG-check-017: 57432848|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="57432848"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Feb 2020 13:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582119215; x=1613655215;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=HDa+z+CRsWiUzymMX9xqaWsxMjI/LWXau41Av0sIoY8=;
  b=YI5gU0gecAWQTW9n/DgykLj0Qv1n/bMZUl7xQx0ISWN3HcPNMZYgy1ek
   eWJXqH4l1JbPyWKyUOlnKiOwY7fHVhktmyc+k16oVACZZpHMM/R6MGpVW
   gfg7woAZwH9TTHKunjh3X/k2EwubsJft1l9s7A2T2pxRLo/cJY0W5bhME
   MK0QamCubjcSW/Jnw6hCa1zTS9vnR+LsgFziq9El7LQwqqZE5UQK/BCSZ
   UzSAVh5wRhh9m3jSZk44q2DIhnGVdZylqACWfweLo30nGVMUPRUbw4xPJ
   Oua1O6rnGOHRHQx1U3/ti/wMG4rZsjLJXQO1kvZ0ep1rDcng1gaPkbrz4
   A==;
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="39276956"
IronPort-PHdr: =?us-ascii?q?9a23=3AJMgQyRE7TDc5kW8uakf/Zp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yrsWwAkXT6L1XgUPTWs2DsrQY0raQ4/irBDVIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/Su8UKjodvKrs9wQ?=
 =?us-ascii?q?bVr3VVfOhb2WxnKVWPkhjm+8y+5oRj8yNeu/Ig885PT6D3dLkmQLJbETorLX?=
 =?us-ascii?q?k76NXkuhffQwSP4GAcUngNnRpTHwfF9hD6UYzvvSb8q+FwxTOVPczyTbAzRD?=
 =?us-ascii?q?Si86JmQwLmhSsbKzI09nzch9duh6xHvh2uux1/w5bVYI6LMvp+Yrjdds4eSW?=
 =?us-ascii?q?ZYQ8pdSzBNDoa6YoQBFeoBOftToZf7qVUAsBCyARCgCe3rxzNNgHL9wK803P?=
 =?us-ascii?q?k7EQzewQIuAdwOvnTXotv7OqgdXuK6w7XHwzjYc/Nb2y3w5JTUfh0vo/yBW6?=
 =?us-ascii?q?97f8rLyUkoEgPIlkieqZD7MDON1uQCrW6b5Pd9W+KqkWEnrwVxrSavx8wxjY?=
 =?us-ascii?q?TJnZ8aykvf+CVlwIc6Od24SElhbd6iC5tfrTuWN4RxQsM8WmxlvjsxxL4euZ?=
 =?us-ascii?q?OjYSQHx5sqywTfZvCaaYSE/B3uWPiLLTtlgn9uZaixiAyo8Ue6z+3xTsy00F?=
 =?us-ascii?q?FXoSVbitTMrXUN1wDL6siAV/t94l+t2TaR2ADX7eFJOVw0mrDBK54g374wjY?=
 =?us-ascii?q?AfsUXFHi/4n0X2l7GZeVk+9ui06+XofrXmppiGO49ylg7+Kbghlta6AeQ5Ng?=
 =?us-ascii?q?gCR2mb+eKi273/5UD1XbpHg/IsnqTZrZzWP9oXq6GnDwNPz4ov8xO/AC2n0N?=
 =?us-ascii?q?Qck3kHNlVFeBefgojyJl7OO+v1Deu/gluwkDdrwOrKPrv6AprXNHTDn7Dhfa?=
 =?us-ascii?q?hl505G1AUz1cxf545TCrwZJ/LzX0jxtMfeDhAjLwO73f3qCM9j2YwDWWKAGL?=
 =?us-ascii?q?OZPLnOvl+P4+IlO/OMa5MNuDbhN/gl4ObjjWQnll8ZfKmp24YXaX+jE/R4LE?=
 =?us-ascii?q?WWf2Dsjs0CEWgUpAo+SvLliFmYXT5UfXayULo25isnB4K+EYfDWoetjaSZ3C?=
 =?us-ascii?q?ihA51WYntLCkiWHnf1c4WIQvIMaCWVIs97jDMIT6SuS4gk1ULmiAiv7LxrNO?=
 =?us-ascii?q?fWsggfrpTq39V2r7nUkBYp8zV/AuyH3m2NRn0ylWQNEXt+x617oEpg2n+d3q?=
 =?us-ascii?q?Vixf9VD9pe47VOSAh+fabV0ugyLtf1QA+JKs+AVVKOWty7BXQ0SdUrzpkFZE?=
 =?us-ascii?q?MrSPu4iRWW5DanG78YkfSwAZUw9q/NlyzqK91V12fN1K5niUIvBMRIKzv11e?=
 =?us-ascii?q?ZE6wHPCtuRwA2inKGwePFZhXWc+Q=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CPAADyN01e/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gWwBMiqEFIkDhlIBAQEBAQEGgTeJcI9jgWcJAQEBAQEBAQEBNwQBA?=
 =?us-ascii?q?YRAAoIoNwYOAhABAQEFAQEBAQEFAwEBbIVDgjspAYMCAQUjFVELDgoCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgmM/glclrV2BMoVKg2yBPoEOKgGMPXmBB4E4D4JdPoQxgyqCX?=
 =?us-ascii?q?gSXV0aXdIJFglCUCgYcmyuOb51VI4FYKwgCGAghD4MnUBgNjigYjkEjAzCPE?=
 =?us-ascii?q?wEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Feb 2020 13:33:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01JDWVl0137363;
        Wed, 19 Feb 2020 08:32:32 -0500
Subject: Re: [PATCH v2] selinux: reduce the use of hard-coded hash sizes
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200219093255.157758-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5778e7a4-4ea3-b97f-b746-0b9372d33f34@tycho.nsa.gov>
Date:   Wed, 19 Feb 2020 08:34:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219093255.157758-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/20 4:32 AM, Ondrej Mosnacek wrote:
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

