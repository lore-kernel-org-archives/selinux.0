Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C14C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 14:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3B82173E
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 14:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FMB1lMnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfLKOrT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:47:19 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:1031 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbfLKOrO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 09:47:14 -0500
X-EEMSG-check-017: 34477870|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="34477870"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Dec 2019 14:47:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576075632; x=1607611632;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GRl9uGaOORWXmwWWs/7pLvaSl4fQC+lQhEbZIoKLYXY=;
  b=FMB1lMnOrNBTD/bATiklE0EvHDvYPfwDo3czuW6L9l9MGm/YLzvIBy9a
   vaqDCOpE18+1nCGRDDGJTswuTwwxbI8hLg+xWrGgchBOppDKtsvm7/Qe0
   7jd7RvkxkhjTFbG8+7vwDaQF/ffR9RR/IhJN5/mdqPutkLiqJAS32v2f1
   91NE48ENVTDI2X+f10P99I67e/BTz/BBRy+O2XG5dmcX77ZkzMgul2F0x
   e/CjCxYCO7jiodGDAENZDoxmsgECzk0hDksOC3L6PQBSgLYHA14WyYiRw
   D+F7eyCWdZvMvdG5lWgVIjBj34Qdu2kPOR1zmehuE9EHybVhpxQtpJWQz
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="30990543"
IronPort-PHdr: =?us-ascii?q?9a23=3ATKPtMxE+Gi5dkYT5hCyjOZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8y4bnLW6fgltlLVR4KTs6sC17ON9fmxBCdeu96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txjdu80WjIdtK6s91A?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDE36mHXjtF7grxdrhyvuhdzx5fYbJ+ROfZ7eK7WYNEUSn?=
 =?us-ascii?q?dbXstJSiJPAp2yb4UMAeQPM+lXoIvyqEcBoxalGQmhB/nixiNUinL436A31f?=
 =?us-ascii?q?kqHwHc3AwnGtIDqGnarMnrO6cKUeC60q/IxijeYfNTwzj97IzIfQ4hoPqRWr?=
 =?us-ascii?q?9watfeyVI0GgPZjlSftYzlPzSP2uQLqGiU9fBsVe2oi245sgx8pCWkyMQ0io?=
 =?us-ascii?q?TRm44YxV/J+T95zYooP9G0VkF2bcC+HJdNsSyRKpF4Tdk4Q25yvSY30rgGuZ?=
 =?us-ascii?q?mmcycU0Jkn3Bvfa+Cfc4iP/xLjSP6dITdmi3Jhf7Kynwqy/lK6yu39S8m0y0?=
 =?us-ascii?q?xGritDktnCsXANzALc5dSdRvth/kauxTaP1wfJ5uFCPU80jrbUJ4Qkwr4xkp?=
 =?us-ascii?q?ofqUXDHinol0XqlKKaa0op9+ey5+nnf7nqvIGQOoBqhg3kL6gigsm/Dv45Mg?=
 =?us-ascii?q?gKUWib4+O81Lj78E3iXbpKleY7krXZsZ/GJcQbobS1AwlO0ok58Rq/ADCm0M?=
 =?us-ascii?q?oAkXkdMF1FYA6Hj5TuO1zWOvD4Fva/jEmxnzdsxfDGP6bsDYnKLnfejrjuZ6?=
 =?us-ascii?q?t961RbyAop199T/ZVUCqsOIPjrQE/+qMTYDgMlMwyz2+vnE8ty1ocfWWKJH6?=
 =?us-ascii?q?+YP7jfsUGH5u0xOemAfowVtyjnK/gj+fHuiWU1mVgHfammxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhms8BHn0Xvgo6V+HqkEeNUSNXZ3qrWqI84TY7CJi4AovZWo+th7mB1j?=
 =?us-ascii?q?+hHpJKfmBGFkyMEXDweoWAWvcMbj+SI8B4njwfS7euV5Ih1QuvtA/my7trN+?=
 =?us-ascii?q?/U+ioFupL+0Nh6+fbelQ899TNqFcSRyWKNQH9unmMOWTA22LpzoUtnyleMgu?=
 =?us-ascii?q?BEhKlCDt1f6/RLUy8xMpLRxvFgDMr7HAXbcZPBU1uiQ9O7ERkvQd8rhdwDeU?=
 =?us-ascii?q?BwH5OllB+Q8TCtBuoui7GTBJEyupnZ1nz1Ktc1n23Kz4E9nlImRY1JLmTgia?=
 =?us-ascii?q?lhoVuAT7XVmlmUwv75PZ8X2zTAoSLZnGc=3D?=
X-IPAS-Result: =?us-ascii?q?A2BbAAA8APFd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQDiQOGbAEBAQEBAQaBN4lpkUYJAQEBAQEBAQEBN?=
 =?us-ascii?q?wEBhEACgik4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KYJ6AQEBAQMjBAsBBUEMB?=
 =?us-ascii?q?AkCEQQBAQECAiYCAk8IBwwGAgEBgl8/glMlkTKaf3V/M4kOgUiBDiiMMnmBB?=
 =?us-ascii?q?4ERJw+CXT6HWYJeBI1miDqBKJcjgjmCPJM0BhuCQow3i0ctjh2cSSKBWCsIA?=
 =?us-ascii?q?hgIIQ+DJ1ARFIxyF45BIwMwDI8ZAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 11 Dec 2019 14:47:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBBEkuit158708;
        Wed, 11 Dec 2019 09:46:56 -0500
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     rsiddoji@codeaurora.org, selinux@vger.kernel.org
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
 <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
 <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
 <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov>
Message-ID: <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
Date:   Wed, 11 Dec 2019 09:47:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/11/19 9:37 AM, Stephen Smalley wrote:
> On 12/9/19 1:30 PM, rsiddoji@codeaurora.org wrote:
>> Thanks for quick response , yes it will be helpful if you can raise 
>> the change .
>> On the second issue  in  avc_alloc_node we are trying to check the  
>> slot status  as    active_nodes  > 512 ( default )
>> Where  checking the occupancy  should be corrected as     active_nodes 
>> > 80% of slots occupied  or 16*512 or
>> May be we need to use a different logic .
> 
> Are you seeing an actual problem with this in practice, and if so, what 
> exactly is it that you are seeing and do you have a reproducer?

BTW, on Linux distributions, there is an avcstat(8) utility that can be 
used to monitor the AVC statistics, or you can directly read the stats 
from the kernel via /sys/fs/selinux/avc/cache_stats

> 
>>
>>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) */
>>>
>>>        if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>>            avc->avc_cache_threshold)      //  default  threshold is 512
>>>            avc_reclaim_node(avc);
>>>
>>
>> Regards,
>> Ravi
>>
>> -----Original Message-----
>> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On 
>> Behalf Of Stephen Smalley
>> Sent: Monday, December 9, 2019 11:35 PM
>> To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
>> Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
>> Subject: Re: Looks like issue in handling active_nodes count in 4.19 
>> kernel .
>>
>> On 12/9/19 10:55 AM, rsiddoji@codeaurora.org wrote:
>>> Hi team ,
>>> Looks like we have  issue in handling the  "active_nodes" count in the
>>> Selinux - avc.c file.
>>> Where  avc_cache.active_nodes increase more than slot array   and code
>>> frequency calling of avc_reclaim_node()  from  avc_alloc_node() ;
>>>
>>> Where following are the 2 instance which seem to  possible culprits
>>> which are seen on 4.19 kernel . Can you  comment if my understand is 
>>> wrong.
>>>
>>>
>>> #1. if we see the  active_nodes count is incremented in
>>> avc_alloc_node
>>> (avc) which is called in avc_insert()
>>> Where if the code take  failure path on  avc_xperms_populate  the code
>>> will not decrement this counter .
>>>
>>>
>>> static struct avc_node *avc_insert(struct selinux_avc *avc,
>>>                    u32 ssid, u32 tsid, u16 tclass,
>>>                       struct av_decision *avd,
>>> ....
>>>     node = avc_alloc_node(avc);  //incremented here ....
>>>                 rc = avc_xperms_populate(node, xp_node);  //
>>> possibilities of this getting failure is there .
>>>         if (rc) {
>>>             kmem_cache_free(avc_node_cachep, node);  // but on 
>>> failure we are
>>> not decrementing active_nodes ?
>>>             return NULL;
>>>            }
>>
>> I think you are correct; we should perhaps be calling avc_node_kill() 
>> here as we do in an earlier error path?
>>
>>>
>>> #2.  where it looks like the logic on comparing the  active_nodes
>>> against avc_cache_threshold seems  wired  as the count of active nodes
>>> is always going to be
>>>    more than 512 will may land in simply  removing /calling
>>> avc_reclaim_node frequently much before the slots are full maybe we
>>> are not using cache at best ?
>>>    we should be comparing with some high watermark ? or my
>>> understanding wrong ?
>>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) */
>>>
>>>        if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>>            avc->avc_cache_threshold)      //  default  threshold is 512
>>>            avc_reclaim_node(avc);
>>>
>>
>> Not entirely sure what you are asking here.  avc_reclaim_node() should 
>> reclaim multiple nodes up to AVC_CACHE_RECLAIM.  Possibly that should 
>> be configurable via selinuxfs too, and/or calculated from 
>> avc_cache_threshold in some way?
>>
>> Were you interested in creating a patch to fix the first issue above 
>> or looking to us to do so?
>>
>>
>>
> 

