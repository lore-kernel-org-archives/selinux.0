Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C34C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 16:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9A4207FF
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 16:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="avzSUSYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJQMm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:12:42 -0500
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:28320 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJQMm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 11:12:42 -0500
X-EEMSG-check-017: 59075938|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="59075938"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Dec 2019 16:12:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575994360; x=1607530360;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=v2IRq2fsXo4bfnui0kEUbehFw+zTqTxIQaJ/dYbsFKc=;
  b=avzSUSYFTm6nT04YrYAEnZK/IZNs5Fj1pFoORztp0DBK4lIo2nT+6Y47
   bg2zOd3ghHJZhX/C7Gxfify6zIH3TwLsRyWQtqByGMGy5mxHftc62c/o9
   9ZruVzJ0Vh37Y1SDAUXo2ihchY2zhWsbYjLZEZet3AdxIL4VtTfLevqGs
   QeWrcbZ49Q6mOPrnJxZLyOuDwV7j5683PuRdQaQ8FrZvY+BkeaR2v+1wa
   ekAKEDBpm1FkAWI/S79ChWdhfMSNaCmdLPo1zbQaDnFzBKV4Ug1NpF25X
   nTnifOVqXwqdsyy7VaBqGWRG20oR2MiCJBQ/aI5AWB2x/I+fxvblouXAy
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="36552910"
IronPort-PHdr: =?us-ascii?q?9a23=3As1QJ5BQ/J4FoHR1s7mFG49yk/Npsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZBaAt8tkgFKBZ4jH8fUM07OQ7/m7HzVRut3R6zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajI9sJ6o+yR?=
 =?us-ascii?q?bErGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZEqkBL+juWk/1r9HYFgU2MxGww+r+DdV90YQeWXiRDa?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896v71k3A5nV4dfa+03ZoYc324APtmLF?=
 =?us-ascii?q?uDYXb2gdcOD30KvgwgQ+zuklGCViRTZ3mqVaIm+j47EJ6mDZvERo21mryBxy?=
 =?us-ascii?q?a7EYBLaWBBCFCMEGzleJmDW/gRdi2dONJhkiYDVbi7UYAtzxautBX1y7B/NO?=
 =?us-ascii?q?rb5jUYtY7/1Nhy/+DTkRAy9TppD8WSym2NVH97kX8VRz8s3aB/vUx8xk6G0a?=
 =?us-ascii?q?h/nvNYCNhT6O1SXwckOp7T0fZ6B8rxWg3fZNeJTkipQtG8DTE2VNIxzIxGX0?=
 =?us-ascii?q?EoI9y/iljm2C2wDvdBj7WWALQs+7/Ymn32INxwjX3B0f9yoUMhR550KWC+hq?=
 =?us-ascii?q?N5vzPWDorNnlTRw72mbowAzSXN8yGF1mPIs0ZGBl0jGZ7ZVGwSMxOF5e/y4V?=
 =?us-ascii?q?nPGvr3VOUq?=
X-IPAS-Result: =?us-ascii?q?A2BLAAD2wu9d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQDiQOGZwEBAQEBAQaBEiWJaZFGCQEBAQEBAQEBA?=
 =?us-ascii?q?TcBAYRAAoInOBMCEAEBAQQBAQEBAQUDAQFshQsHMYI7KQGCeQEBAQECASMEE?=
 =?us-ascii?q?UEQCxgCAiYCAlcGDQYCAQGCXz+CUwUgrRt1fzOFT4M9gUiBDiiMMnmBB4E4D?=
 =?us-ascii?q?AOCXT6HWYJeBJZ8RpcigjmCO5MvBhuCQod2kAAtql8igVgrCAIYCCEPgydQE?=
 =?us-ascii?q?RSDDIoSjiwjAzCPKwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Dec 2019 16:12:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBAGCJ7J032232;
        Tue, 10 Dec 2019 11:12:20 -0500
Subject: Re: [RFC PATCH] selinux: ensure we cleanup the internal AVC counters
 on error in avc_insert()
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, rsiddoji@codeaurora.org,
        linux-security-module@vger.kernel.org
References: <157594281322.676903.11041338053333686450.stgit@chester>
 <f7e43b67-3f46-e480-f8b0-e86eff85293f@tycho.nsa.gov>
 <CAHC9VhSO0Jaqyxw_5AtPTTQTqS+Q9CWhBQQ7822hvUS8MWLy6A@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2abbcb79-4384-cfb0-1feb-c3a2e042a2ed@tycho.nsa.gov>
Date:   Tue, 10 Dec 2019 11:12:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSO0Jaqyxw_5AtPTTQTqS+Q9CWhBQQ7822hvUS8MWLy6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/19 10:54 AM, Paul Moore wrote:
> On Tue, Dec 10, 2019 at 8:44 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/9/19 8:53 PM, Paul Moore wrote:
>>> In AVC insert we don't call avc_node_kill() when avc_xperms_populate()
>>> fails, resulting in the avc->avc_cache.active_nodes counter having a
>>> false value.
>>
>> incorrect value?
>>
>>     This patch corrects this problem and does some cleanup
>>> in avc_insert() while we are there.
>>
>> submitting-patches.rst recommends describing in imperative mood and
>> avoiding the words "patch" in what will eventually just be a commit log,
>> ala "Correct this problem and perform some cleanup..."
> 
> Well, you've made me feel better about my nit-picky comments on patches ;)
> 
> Are you okay with the following?
> 
>    selinux: ensure we cleanup the internal AVC counters on error in avc_insert()
> 
>    Fix avc_insert() to call avc_node_kill() if we've already allocated
>    an AVC node and the code fails to insert the node in the cache.

Sure, or just "Fix the AVC to correctly decrement the count of AVC nodes 
if it encounters an allocation failure on an extended permissions node."

> 
>> Should probably add a:
>>
>> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
>>
>> Might be easier to back port if you split the cleanup from the fix, but
>> your call of course.
> 
> I waffled on that last night when I wrote up the patch, and more
> generally if this should go to -stable or -next (despite what is
> claimed, adding a "Fixes:" tag means it gets picked up by -stable more
> often than not in my experience).  At its worst, not fixing this bug
> means we could end up effectively shrinking the AVC cache if xperms
> are used *and* we happen to fail a memory allocation while adding a
> new entry to the AVC; we don't cause an incorrect node to be cached,
> we don't crash the system, we don't leak memory.  My thinking is that
> this isn't a major concern, and not worth the risk to -stable, but if
> anyone has any data that shows otherwise, please let me know.
> 
> I'll go ahead and add the "Fixes:" tag (technically this is the
> *right* thing to do), but I'm going to stick with -next and leave the
> cleanup as-is just to raise the bar a bit for the -stable backports
> which I'm sure are going to happen.
> 

