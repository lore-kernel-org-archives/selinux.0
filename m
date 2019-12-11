Return-Path: <SRS0=W72o=2B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69432C00454
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 15:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337F92077B
	for <selinux@archiver.kernel.org>; Wed, 11 Dec 2019 15:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cjCFTBJq";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="A8sbbGm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfLKPfu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:35:50 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:47462
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388226AbfLKPft (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Dec 2019 10:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576078548;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=rV4v6Lop81IZGMoLzmce/cfcYM6iRPo3L6TYBiuEy9w=;
        b=cjCFTBJq2W2zZ/iCSgwrL2wj9UagN1B8viXETDYP0/YkTlyxf9B2ptphnT82l6Oi
        ZDblmlb2adL5E9T3Lh1dzUKufPcb69s2SV5z7ZxNrSWGQtdfDdYKiG6aN6unyM2qHap
        /A4F181B/9vmZ+qYAYvWKxe8exiiY9gUrT4Frgbk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576078548;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=rV4v6Lop81IZGMoLzmce/cfcYM6iRPo3L6TYBiuEy9w=;
        b=A8sbbGm8qNRU6ReeXp9239GJr6TbUrB7yThWCe11Ntn6elVUc82CqpWBdeNMubgD
        TL3sr0RQMVisF/ovgm8d+ilKqmwBtsRyfOfJalQwBYHKNEs6mhLckL9DK26lAoc1NIQ
        ZIv2TjWgME4FqZ7fby4bgHITvRf9xifPXyBIF1C4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47D55C8F137
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   <rsiddoji@codeaurora.org>
To:     "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@vger.kernel.org>
Cc:     <paul@paul-moore.com>, <linux-security-module@vger.kernel.org>
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com> <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov> <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com> <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov> <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
In-Reply-To: <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov>
Subject: RE: Looks like issue in handling active_nodes count in 4.19 kernel .
Date:   Wed, 11 Dec 2019 15:35:48 +0000
Message-ID: <0101016ef59a1e09-acb95851-4399-47c5-847b-a93cab7a8e89-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHnox6jYXzQWBJanA4xvaBIwH53oQHEBp5eAW+3n+oCcppYQQLX+pcHp00yuFA=
Content-Language: en-us
X-SES-Outgoing: 2019.12.11-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks for tacking the patch fwd . On the  question :

Actually issue started when we were seeing most of the  time =
"avc_reclaim_node" in the stack .=20
Which on debugging further  avc_cache.active_nodes was already in 7K+ =
nodes  and  as the logic  is=20

As below .=20
	if (atomic_inc_return(&avc->avc_cache.active_nodes) >   =
avc->avc_cache_threshold)
           			avc_reclaim_node(avc);

So if the  active_nodes count is  > 512  (if not configured) we will be =
always be calling   avc_reclaim_node() and eventually  for each  node =
insert we will be calling avc_reclaim_node  and might  be expansive then =
using=20
cache  and advantage of cache might be null and void due to this =
overhead?

Thanks ,=20
Ravi

-----Original Message-----
From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On =
Behalf Of Stephen Smalley
Sent: Wednesday, December 11, 2019 8:18 PM
To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
Subject: Re: Looks like issue in handling active_nodes count in 4.19 =
kernel .

On 12/11/19 9:37 AM, Stephen Smalley wrote:
> On 12/9/19 1:30 PM, rsiddoji@codeaurora.org wrote:
>> Thanks for quick response , yes it will be helpful if you can raise=20
>> the change .
>> On the second issue  in  avc_alloc_node we are trying to check the=20
>> slot status  as    active_nodes  > 512 ( default ) Where  checking=20
>> the occupancy  should be corrected as     active_nodes
>> > 80% of slots occupied  or 16*512 or
>> May be we need to use a different logic .
>=20
> Are you seeing an actual problem with this in practice, and if so,=20
> what exactly is it that you are seeing and do you have a reproducer?

BTW, on Linux distributions, there is an avcstat(8) utility that can be =
used to monitor the AVC statistics, or you can directly read the stats =
from the kernel via /sys/fs/selinux/avc/cache_stats

>=20
>>
>>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc)=20
>>> */
>>>
>>>        if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>>            avc->avc_cache_threshold)      //  default  threshold is=20
>>> 512
>>>            avc_reclaim_node(avc);
>>>
>>
>> Regards,
>> Ravi
>>
>> -----Original Message-----
>> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org>=20
>> On Behalf Of Stephen Smalley
>> Sent: Monday, December 9, 2019 11:35 PM
>> To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
>> Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
>> Subject: Re: Looks like issue in handling active_nodes count in 4.19=20
>> kernel .
>>
>> On 12/9/19 10:55 AM, rsiddoji@codeaurora.org wrote:
>>> Hi team ,
>>> Looks like we have  issue in handling the  "active_nodes" count in=20
>>> the Selinux - avc.c file.
>>> Where  avc_cache.active_nodes increase more than slot array   and=20
>>> code frequency calling of avc_reclaim_node()  from  avc_alloc_node() =

>>> ;
>>>
>>> Where following are the 2 instance which seem to  possible culprits=20
>>> which are seen on 4.19 kernel . Can you  comment if my understand is =

>>> wrong.
>>>
>>>
>>> #1. if we see the  active_nodes count is incremented in=20
>>> avc_alloc_node
>>> (avc) which is called in avc_insert() Where if the code take =20
>>> failure path on  avc_xperms_populate  the code will not decrement=20
>>> this counter .
>>>
>>>
>>> static struct avc_node *avc_insert(struct selinux_avc *avc,
>>>                    u32 ssid, u32 tsid, u16 tclass,
>>>                       struct av_decision *avd, ....
>>>     node =3D avc_alloc_node(avc);  //incremented here ....
>>>                 rc =3D avc_xperms_populate(node, xp_node);  //=20
>>> possibilities of this getting failure is there .
>>>         if (rc) {
>>>             kmem_cache_free(avc_node_cachep, node);  // but on=20
>>> failure we are not decrementing active_nodes ?
>>>             return NULL;
>>>            }
>>
>> I think you are correct; we should perhaps be calling avc_node_kill() =

>> here as we do in an earlier error path?
>>
>>>
>>> #2.  where it looks like the logic on comparing the  active_nodes=20
>>> against avc_cache_threshold seems  wired  as the count of active=20
>>> nodes is always going to be
>>>    more than 512 will may land in simply  removing /calling=20
>>> avc_reclaim_node frequently much before the slots are full maybe we=20
>>> are not using cache at best ?
>>>    we should be comparing with some high watermark ? or my=20
>>> understanding wrong ?
>>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc)=20
>>> */
>>>
>>>        if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>>            avc->avc_cache_threshold)      //  default  threshold is=20
>>> 512
>>>            avc_reclaim_node(avc);
>>>
>>
>> Not entirely sure what you are asking here.  avc_reclaim_node()=20
>> should reclaim multiple nodes up to AVC_CACHE_RECLAIM.  Possibly that =

>> should be configurable via selinuxfs too, and/or calculated from=20
>> avc_cache_threshold in some way?
>>
>> Were you interested in creating a patch to fix the first issue above=20
>> or looking to us to do so?
>>
>>
>>
>=20


