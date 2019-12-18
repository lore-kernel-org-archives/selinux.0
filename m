Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE416C2D0C3
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 13:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8A82176D
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 13:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jWnh7oge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfLRNyK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:54:10 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:58428 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLRNyJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 08:54:09 -0500
X-EEMSG-check-017: 63325529|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,329,1571702400"; 
   d="scan'208";a="63325529"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 13:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576677191; x=1608213191;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=B1VJ1ddOGZKrIiRmAu/dSAhuPfQGvmKewq91Ah43aK4=;
  b=jWnh7ogeeBr6KsazkRrzc8CCB08/WwnzOJkA5PBQrg2lHFva0jVhDmzu
   PB+t2cxi6xtVcqlEptQRW2dhLPPRoyX3wd9qZKKU1T06CAQFFG88FVWSe
   OvyWBGru8By7s8Q2+Bjwc/u5VVj1RIaqJS22K2RtJzzU4beQFzb+yHiOb
   EFQN/4Z77YttvSQdP0BQR/OGUfyWx4S1+EHfcrp9duwzcp40aT1rK53xT
   T187HfltBXYWCuh6TImPwK3dzAdQHnN3u6/lK8Gm6PgbtZ24tdcCcgRsA
   EcBitFW022AmfL8oDbSt4/uJqHndmTqjISkqxOr69N9xeLxX7NX6fDAE3
   w==;
X-IronPort-AV: E=Sophos;i="5.69,329,1571702400"; 
   d="scan'208";a="36896192"
IronPort-PHdr: =?us-ascii?q?9a23=3AuWvG+x3yI1NDmzAysmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWLPTxwZ3uMQTl6Ol3ixeRBMOHsqkC0bKH+P28EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm6sQHcusYWjIZtN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5Dxq0UKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK58nwr4+kZ?=
 =?us-ascii?q?oTqlrMETPslEXqjK6ZakUk+u+y5+ThfrrmvYOTO5VxigH/NqQigs2/AeImPQ?=
 =?us-ascii?q?gSR2WX5Oux2bL58UD5XblGlOM6n6bHvJzAOMgXvqu5DBVU0oYn5Ra/FTCm0N?=
 =?us-ascii?q?EAkHkcMV1FYwmKj5TpOl7SIPD4Cu2zg1K3kDhx3fzGMbrhAovVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcr19Bf/JNUBawcL/L0WE/xtcfVAQM+MwOp3enoEsh91pkZWWKVGK?=
 =?us-ascii?q?CVKqTSsUWH5ug3OemDeJcVuCrhK/gi//PulmE2mVscfamvwJsWZ2u1HuppI0?=
 =?us-ascii?q?qHe3rgmNQBHnkQvgo4UuPqjEeOUTlJZ3a9R6g8/C00CJq6DYffQYCgmKSB0z?=
 =?us-ascii?q?2mHp1SfW1GEkqDEWrsd4mdXvcMbyWSItV/nTAeSbehTIoh3wm0tADm07pnMv?=
 =?us-ascii?q?bU+ioAuJLn1dh14fDTlB4r+TxvEcuSz3yNT3t1nmMURz46xaV/oUtgxVee1a?=
 =?us-ascii?q?h3nedVFcJc5/xXSAc2L53cwPJgC9D0RA3Bes2FSFG8QtWpUnkNSYcLysEPK2?=
 =?us-ascii?q?VgHty4xivC0yatAb4anqaKTMgu6aPQ03/zJu52zHrL3bQ7iEMvBMxVOjvizr?=
 =?us-ascii?q?Vy8wnVGp7hjUqUjeCpeL4a0SqL832MnkSUu0QNaxJ9SaXIWzgkY0LSqdnorh?=
 =?us-ascii?q?fZQ6SGFaUsMgwHz9WLbKRNdIu63h19WP7/NYGGMCqKkGCqCEPNn+ndYQ=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2BYAABZLvpd/wHyM5BdCBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBfIF2gRhVIBIqhASJA4ZTAQEBAQEGgTeJao9egWcJAQEBAQEBA?=
 =?us-ascii?q?QEBIxQBAYRAAoI9OBMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYJ5AQEBAQIBI?=
 =?us-ascii?q?wQRQQwECxEEAQEBAgImAgJPCAYBDAYCAQGCXz8BglIFIK0QdX8zhU+DRIFBg?=
 =?us-ascii?q?Q4ojDJ5gQeBEScPgl0+hBISDheDEIJeBJcORpc1gj+CQ4RujlwGG4JDdYcEk?=
 =?us-ascii?q?BItjiGBRpsZIoFYKwgCGAghD4MnCUcYDZNbiBsjAzAMjFOCQQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Dec 2019 13:53:10 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIDqo5Q221797;
        Wed, 18 Dec 2019 08:52:50 -0500
Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>,
        selinux@vger.kernel.org
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com>
 <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
 <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
 <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov>
 <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
 <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com>
 <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov>
 <001e01d5b4f0$495efbd0$dc1cf370$@codeaurora.org>
 <21b5511a-fdba-3c2f-e9a6-efdc890b5881@tycho.nsa.gov>
 <0f6b6f32-e4bc-1ec0-dc27-2f4214ea479a@tycho.nsa.gov>
 <002101d5b568$393887d0$aba99770$@codeaurora.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <628ec743-8f18-85b9-f9fb-81b7b0cf1ee1@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 08:53:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <002101d5b568$393887d0$aba99770$@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/18/19 12:58 AM, Ravi Kumar Siddojigari wrote:
> Yes this is the first time that we are getting this stress tested done on v4.19 kernel .
> We had not tested this prior version of kernel though . Current proposed changes seems to really help and testing is still going on .
> As per the delta it looks  change  6b6bc620  seem to be missing in earlier version of kernel not sure if this was the cause.

6b6bc620 shouldn't have altered any behavior; it was purely an 
encapsulation of the data structures.  Both of the bugs you've 
identified were introduced by the xperms support in fa1aa143ac4a68. 
Maybe they were harder to trigger when the AVC was still using 
GFP_ATOMIC instead of GFP_NOWAIT, but they were bugs nonetheless.

> 
> Br ,
> Ravi.
> -----Original Message-----
> From: Stephen Smalley <sds@tycho.nsa.gov>
> Sent: Tuesday, December 17, 2019 9:54 PM
> To: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>; selinux@vger.kernel.org
> Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
> Subject: Re: Looks like issue in handling active_nodes count in 4.19 kernel .
> 
> On 12/17/19 10:52 AM, Stephen Smalley wrote:
>> On 12/17/19 10:40 AM, Ravi Kumar Siddojigari wrote:
>>> Yes  indeed this is a stress test on ARM64 device with multicore
>>> where most of the cores /tasks are stuck  in avc_reclaim_node .
>>> We still see this issue even after picking the earlier patch "
>>> selinux: ensure we cleanup the internal AVC counters on error in
>>> avc_insert() commit: d8db60cb23e4"
>>> Where selinux_state  during issue was as below where all the slots
>>> are  NULL and the count was more than threshold.
>>> Which seem to be calling avc_reclaim_node always and as the all the
>>> slots are empty its going for full for- loop with locks and unlock
>>> and taking too long .
>>> Not sure what could make the  slots null , for sure its not due to
>>> flush() /Reset(). We think that still we need to call  avc_kill_node
>>> in update_node function .
>>> Adding the patch below can you please review or correct the following
>>> patch .
>>>
>>>
>>>     selinux_state = (
>>>       disabled = FALSE,
>>>       enforcing = TRUE,
>>>       checkreqprot = FALSE,
>>>       initialized = TRUE,
>>>       policycap = (TRUE, TRUE, TRUE, FALSE, FALSE, TRUE),
>>>       avc = 0xFFFFFF9BEFF1E890 -> (
>>>         avc_cache_threshold = 512,  /* <<<<<not configured and its
>>> with default*/
>>>         avc_cache = (
>>>           slots = ((first = 0x0), (first = 0x0), (first = 0x0), (first
>>> = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0),
>>> (first = 0x0), (first = 0x0), (first = 0x0), (first = 0x0), (first
>>> /*<<<< all are NULL */
>>>           slots_lock = ((rlock = (raw_lock = (val = (counter = 0),
>>> locked = 0, pending = 0, locked_pending = 0, tail = 0), magic =
>>> 3735899821, owner_cpu = 4294967295, owner = 0xFFFFFFFFFFFFFFFF,
>>> dep_map = (key = 0xFFFFFF9BEFF298A8, cla
>>>           lru_hint = (counter = 616831529),
>>>           active_nodes = (counter = 547),   /*<<<<< increased more
>>> than 512*/
>>>           latest_notif = 1)),
>>>       ss = 0xFFFFFF9BEFF2E578)
>>>
>>>
>>> --
>>> In AVC update we don't call avc_node_kill() when
>>> avc_xperms_populate() fails, resulting in the
>>> avc->avc_cache.active_nodes counter having a false value.In last patch this changes was missed , so correcting it.
>>>
>>> Change-Id: Ic0298162cc766c0f21be7ab232e259766654dad3
>>> Signed-off-by: Jaihind Yadav<jaihindyadav@codeaurora.org>
>>> ---
>>>    security/selinux/avc.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c index
>>> 91d24c2..3d1cff2 100644
>>> --- a/security/selinux/avc.c
>>> +++ b/security/selinux/avc.c
>>> @@ -913,7 +913,7 @@ static int avc_update_node(struct selinux_avc
>>> *avc,
>>>           if (orig->ae.xp_node) {
>>>                   rc = avc_xperms_populate(node, orig->ae.xp_node);
>>>                   if (rc) {
>>> -                       kmem_cache_free(avc_node_cachep, node);
>>> +                       avc_node_kill(avc, node);
>>>                           goto out_unlock;
>>>                   }
>>>           }
>>> --
>>
>> That looks correct to me; I guess that one got missed by the prior fix.
>> Still not sure how your AVC got into that state though...
>>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> 
> BTW, have you been running these stress tests on earlier kernels too?
> If so, what version(s) are known to pass them?  I ask because this code has been present since v4.3 and this is the first such report.
> 

