Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83227C43603
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 15:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FED82073D
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 15:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="LqtsJWE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbfLKPxb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:53:31 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:35071 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbfLKPxb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 10:53:31 -0500
X-EEMSG-check-017: 37452700|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="37452700"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Dec 2019 15:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576079606; x=1607615606;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rw+8uKq5pqbJ4jEglqTQ9aG0YolUkownIQjAbZckgNY=;
  b=LqtsJWE14hAWjTDpAHgikIuo7WxGCmgockGg7/KNBaaPubiPgUfhNTtB
   HNQB9tFZuXkzw8Q+Xo92ZkLVToYuR7Gz+wU8m+rf6EWmfDx8tLNg2ZgGw
   Ir5A/SGlWSMo4SLOHuZpq41VtKvzS+Bfox8zRmr0sNCZo8eJpZM5TGuMd
   ldYnIB/sv2f3OrLZ0I5JaXkBPR2AY4bkxKey3sSnj6r8MNjD449lim5My
   qnsNJ4uoQo79xy04mtcImYNnAGRoxxDL1FOpXkWj5o6d4OsZcTd/i8CVP
   bJgb8day7RFPLVCWgV8AjNdHcYJ6mlRhf1eWEG8rrWB4kDk8xbCQatry4
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="36610161"
IronPort-PHdr: =?us-ascii?q?9a23=3Aw1eNQxN2DKJ2NdboDUEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/z7pcbcNUDSrc9gkEXOFd2Cra4d0KyP4v2rBjFIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjVtsQajolvJ6YswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwIOSQ58GXKgcJuiqxVrg+qqxhmz4LKZIyZMfxzdb7fc9wHX2?=
 =?us-ascii?q?pMRttfWTJPAo28bIUBAeQOMulaoIbhqFUDtge+CAu2Ce/z1jNFiH370Ksn2O?=
 =?us-ascii?q?ohCwHG2wkgEsoTvnTIstr1LKcSXv6zzKLV0DvDaulZ2TP56IfWchEqvPaBXa?=
 =?us-ascii?q?ltfsrK0kQvCwPEgUmQqYziJT+V0P8NvHKB4+pvUuKvlXcqpgdsqTas3schkp?=
 =?us-ascii?q?TFi40ax1ze9Sh13Zw5KcO3RUJle9KoDZ1dvDyAOYRsWMMtWWRotT4/yr0BpJ?=
 =?us-ascii?q?G0YjAHyI8ixx7Dc/yHdJWI4g77WOaRPzh4gHVldaqjhxmo60igy/D8VtKu3F?=
 =?us-ascii?q?ZLqCpFnN7MtmsT2BPP8MSHVvt88Vuh2TaIzQzT7P1LIVsomqbBLp4hw7owmo?=
 =?us-ascii?q?ISsUTFACD2hF37gLKZe0gr4OSl6/nrbq/4qpKTKYN4kBzyPrwrmsOlAOQ4Ng?=
 =?us-ascii?q?YOX3Kc+eS5zLDj5lD2QK5Rg/0qkqjWrJDaJcMBqq6/GA9ayJwv6xm4Dze4yN?=
 =?us-ascii?q?gYh2UILEpZeBKbiIjkI0vOIOv5DfiinluslzVrx/HdM7L9BZXCM2bMn638fb?=
 =?us-ascii?q?Zn7E5c0hA8wcpY55JOBbELOOjzVVPptNzEEh85NBS5w/35B9V514MeX3+PA6?=
 =?us-ascii?q?CCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcrGj3YELZ3CgAvRmP0?=
 =?us-ascii?q?KZbGL0gtgbDGcKuhEzTPTwh12fVT5ffnOyX6U75jEhFo2qF5vMRoeogLaZxi?=
 =?us-ascii?q?e0AoVWZnxaClCLCXroc4SEW/ERaCOdO8NhiSILWqS8S4871BGuqA/7x6NiLu?=
 =?us-ascii?q?rT5yIYqJbj28Zu6u3NmhE96yZ0A96e026TVWF0mH0HRzss0KB4u0x9xQTL7a?=
 =?us-ascii?q?8tmedZGdBU5fJhWQA2OJfB1etgApb1QA2FNsyETFegX8WOHz48VJQyzsUIbk?=
 =?us-ascii?q?I7HM+t3T7Z2C//OKMYj7yGAtQP96vY23Xgb5Jmx23uyLgqj15gRNBGc2KhmP?=
 =?us-ascii?q?gspEDoG4fVnhDBxO6RfqMG0XuIrjaO?=
X-IPAS-Result: =?us-ascii?q?A2BCAAA0EPFd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBbQMBAQELAYFzgWwBIBIqhAOJA4ZvAQEBBoE3iWmRRgkBAQEBAQEBAQE3A?=
 =?us-ascii?q?QGEQAKCKTcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KYJ6AQEBAQIBIwQRQQwEC?=
 =?us-ascii?q?xEEAQEBAgImAgJPCAcMBgIBAYJfP4JTBSCsXnV/M4VPgz2BSIEOKAGMMXmBB?=
 =?us-ascii?q?4ERJw+CXT6HWYJeBI1miDpiRpcjgjmCPJM0BhuCQow3i0ctjh2cSCOBWCsIA?=
 =?us-ascii?q?hgIIQ+DJ1ARFIxyF45BIwMwDI45XwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Dec 2019 15:53:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBBFr7dL187000;
        Wed, 11 Dec 2019 10:53:09 -0500
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
To:     rsiddoji@codeaurora.org, selinux@vger.kernel.org
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
 <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
 <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
 <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov>
 <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
 <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov>
Date:   Wed, 11 Dec 2019 10:53:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/11/19 10:35 AM, rsiddoji@codeaurora.org wrote:
> Thanks for tacking the patch fwd . On the  question :
> 
> Actually issue started when we were seeing most of the  time "avc_reclaim_node" in the stack .
> Which on debugging further  avc_cache.active_nodes was already in 7K+ nodes  and  as the logic  is
> 
> As below .
> 	if (atomic_inc_return(&avc->avc_cache.active_nodes) >   avc->avc_cache_threshold)
>             			avc_reclaim_node(avc);
> 
> So if the  active_nodes count is  > 512  (if not configured) we will be always be calling   avc_reclaim_node() and eventually  for each  node insert we will be calling avc_reclaim_node  and might  be expansive then using
> cache  and advantage of cache might be null and void due to this overhead?

Was this on a system with the default avc_cache_threshold value or was 
it set higher by the distro/user?

If it was still 512 or any value significantly less than 7K, then the 
bug is that it ever reached 7K in the first place. The first bug should 
only trigger under severe memory pressure.  The other potential reason 
for growing numbers of active nodes would be cache thrashing leading to 
avc_reclaim_node() being unable to take the lock on any buckets and 
therefore unable to release nodes.

Possibly you need a larger cache threshold set on this system.  It can 
be set via /sys/fs/selinux/avc/cache_threshold.

Allowing AVC_CACHE_RECLAIM to also be set via selinuxfs or computed 
relative to avc_cache_threshold would make sense as a further improvement.

> 
> Thanks ,
> Ravi
> 
> -----Original Message-----
> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On Behalf Of Stephen Smalley
> Sent: Wednesday, December 11, 2019 8:18 PM
> To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
> Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
> Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
> 
> On 12/11/19 9:37 AM, Stephen Smalley wrote:
>> On 12/9/19 1:30 PM, rsiddoji@codeaurora.org wrote:
>>> Thanks for quick response , yes it will be helpful if you can raise
>>> the change .
>>> On the second issue  in  avc_alloc_node we are trying to check the
>>> slot status  as    active_nodes  > 512 ( default ) Where  checking
>>> the occupancy  should be corrected as     active_nodes
>>>> 80% of slots occupied  or 16*512 or
>>> May be we need to use a different logic .
>>
>> Are you seeing an actual problem with this in practice, and if so,
>> what exactly is it that you are seeing and do you have a reproducer?
> 
> BTW, on Linux distributions, there is an avcstat(8) utility that can be used to monitor the AVC statistics, or you can directly read the stats from the kernel via /sys/fs/selinux/avc/cache_stats
> 
>>
>>>
>>>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc)
>>>> */
>>>>
>>>>         if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>>>             avc->avc_cache_threshold)      //  default  threshold is
>>>> 512
>>>>             avc_reclaim_node(avc);
>>>>
>>>
>>> Regards,
>>> Ravi
>>>
>>> -----Original Message-----
>>> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org>
>>> On Behalf Of Stephen Smalley
>>> Sent: Monday, December 9, 2019 11:35 PM
>>> To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
>>> Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
>>> Subject: Re: Looks like issue in handling active_nodes count in 4.19
>>> kernel .
>>>
>>> On 12/9/19 10:55 AM, rsiddoji@codeaurora.org wrote:
>>>> Hi team ,
>>>> Looks like we have  issue in handling the  "active_nodes" count in
>>>> the Selinux - avc.c file.
>>>> Where  avc_cache.active_nodes increase more than slot array   and
>>>> code frequency calling of avc_reclaim_node()  from  avc_alloc_node()
>>>> ;
>>>>
>>>> Where following are the 2 instance which seem to  possible culprits
>>>> which are seen on 4.19 kernel . Can you  comment if my understand is
>>>> wrong.
>>>>
>>>>
>>>> #1. if we see the  active_nodes count is incremented in
>>>> avc_alloc_node
>>>> (avc) which is called in avc_insert() Where if the code take
>>>> failure path on  avc_xperms_populate  the code will not decrement
>>>> this counter .
>>>>
>>>>
>>>> static struct avc_node *avc_insert(struct selinux_avc *avc,
>>>>                     u32 ssid, u32 tsid, u16 tclass,
>>>>                        struct av_decision *avd, ....
>>>>      node = avc_alloc_node(avc);  //incremented here ....
>>>>                  rc = avc_xperms_populate(node, xp_node);  //
>>>> possibilities of this getting failure is there .
>>>>          if (rc) {
>>>>              kmem_cache_free(avc_node_cachep, node);  // but on
>>>> failure we are not decrementing active_nodes ?
>>>>              return NULL;
>>>>             }
>>>
>>> I think you are correct; we should perhaps be calling avc_node_kill()
>>> here as we do in an earlier error path?
>>>
>>>>
>>>> #2.  where it looks like the logic on comparing the  active_nodes
>>>> against avc_cache_threshold seems  wired  as the count of active
>>>> nodes is always going to be
>>>>     more than 512 will may land in simply  removing /calling
>>>> avc_reclaim_node frequently much before the slots are full maybe we
>>>> are not using cache at best ?
>>>>     we should be comparing with some high watermark ? or my
>>>> understanding wrong ?
>>>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc)
>>>> */
>>>>
>>>>         if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>>>             avc->avc_cache_threshold)      //  default  threshold is
>>>> 512
>>>>             avc_reclaim_node(avc);
>>>>
>>>
>>> Not entirely sure what you are asking here.  avc_reclaim_node()
>>> should reclaim multiple nodes up to AVC_CACHE_RECLAIM.  Possibly that
>>> should be configurable via selinuxfs too, and/or calculated from
>>> avc_cache_threshold in some way?
>>>
>>> Were you interested in creating a patch to fix the first issue above
>>> or looking to us to do so?
>>>
>>>
>>>
>>
> 
> 

