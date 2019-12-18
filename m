Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566EDC2D0CD
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 05:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B99C205ED
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 05:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="oVs4ae2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLRF66 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 00:58:58 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:28366 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfLRF66 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 00:58:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576648737; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=0CumTbfhGoP+1h0Gl7LnTSUH8mwM1nvfEcLk+U1HrIM=; b=oVs4ae2a6DSnjmgtkfq+obet8EwfRCyzy1ki/9F1Vozm+6uZ7sqjXrwVUXOQwKTB4UnRjNol
 YziIKxsvT/JyW6XPYZZZSj0u2uuBavo50mN/VXS12X2bOOiX9JzpI+G0i2Ek+/QL4I8rQQ8j
 f8cXKjcNFOT9Ve6aHZ8P2LXs5Zk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyIxZmM3MiIsICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df9c01e.7f994d8c6730-smtp-out-n01;
 Wed, 18 Dec 2019 05:58:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29A2BC433A2; Wed, 18 Dec 2019 05:58:53 +0000 (UTC)
Received: from rsiddoji1 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B7B1C433CB;
        Wed, 18 Dec 2019 05:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B7B1C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   "Ravi Kumar Siddojigari" <rsiddoji@codeaurora.org>
To:     "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@vger.kernel.org>
Cc:     <paul@paul-moore.com>, <linux-security-module@vger.kernel.org>
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com> <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov> <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com> <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov> <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov> <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com> <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov> <001e01d5b4f0$495efbd0$dc1cf370$@codeaurora.org> <21b5511a-fdba-3c2f-e9a6-efdc890b5881@tycho.nsa.gov> <0f6b6f32-e4bc-1ec0-dc27-2f4214ea479a@tycho.nsa.gov>
In-Reply-To: <0f6b6f32-e4bc-1ec0-dc27-2f4214ea479a@tycho.nsa.gov>
Subject: RE: Looks like issue in handling active_nodes count in 4.19 kernel .
Date:   Wed, 18 Dec 2019 11:28:47 +0530
Organization: The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
Message-ID: <002101d5b568$393887d0$aba99770$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHnox6jYXzQWBJanA4xvaBIwH53oQHEBp5eAW+3n+oCcppYQQLX+pcHAZBKVBoDAGwdBwG8Ix8zAUmroZsDW73tkqcAAlWw
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Yes this is the first time that we are getting this stress tested done =
on v4.19 kernel .=20
We had not tested this prior version of kernel though . Current proposed =
changes seems to really help and testing is still going on .=20
As per the delta it looks  change  6b6bc620  seem to be missing in =
earlier version of kernel not sure if this was the cause.=20

Br ,=20
Ravi.
-----Original Message-----
From: Stephen Smalley <sds@tycho.nsa.gov>=20
Sent: Tuesday, December 17, 2019 9:54 PM
To: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>; =
selinux@vger.kernel.org
Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
Subject: Re: Looks like issue in handling active_nodes count in 4.19 =
kernel .

On 12/17/19 10:52 AM, Stephen Smalley wrote:
> On 12/17/19 10:40 AM, Ravi Kumar Siddojigari wrote:
>> Yes  indeed this is a stress test on ARM64 device with multicore=20
>> where most of the cores /tasks are stuck  in avc_reclaim_node .
>> We still see this issue even after picking the earlier patch "=20
>> selinux: ensure we cleanup the internal AVC counters on error in
>> avc_insert() commit: d8db60cb23e4"
>> Where selinux_state  during issue was as below where all the slots=20
>> are  NULL and the count was more than threshold.
>> Which seem to be calling avc_reclaim_node always and as the all the=20
>> slots are empty its going for full for- loop with locks and unlock=20
>> and taking too long .
>> Not sure what could make the  slots null , for sure its not due to
>> flush() /Reset(). We think that still we need to call  avc_kill_node=20
>> in update_node function .
>> Adding the patch below can you please review or correct the following =

>> patch .
>>
>>
>>    selinux_state =3D (
>>      disabled =3D FALSE,
>>      enforcing =3D TRUE,
>>      checkreqprot =3D FALSE,
>>      initialized =3D TRUE,
>>      policycap =3D (TRUE, TRUE, TRUE, FALSE, FALSE, TRUE),
>>      avc =3D 0xFFFFFF9BEFF1E890 -> (
>>        avc_cache_threshold =3D 512,  /* <<<<<not configured and its=20
>> with default*/
>>        avc_cache =3D (
>>          slots =3D ((first =3D 0x0), (first =3D 0x0), (first =3D =
0x0), (first=20
>> =3D 0x0), (first =3D 0x0), (first =3D 0x0), (first =3D 0x0), (first =
=3D 0x0),
>> (first =3D 0x0), (first =3D 0x0), (first =3D 0x0), (first =3D 0x0), =
(first  =20
>> /*<<<< all are NULL */
>>          slots_lock =3D ((rlock =3D (raw_lock =3D (val =3D (counter =
=3D 0),=20
>> locked =3D 0, pending =3D 0, locked_pending =3D 0, tail =3D 0), magic =
=3D=20
>> 3735899821, owner_cpu =3D 4294967295, owner =3D 0xFFFFFFFFFFFFFFFF,=20
>> dep_map =3D (key =3D 0xFFFFFF9BEFF298A8, cla
>>          lru_hint =3D (counter =3D 616831529),
>>          active_nodes =3D (counter =3D 547),   /*<<<<< increased more =

>> than 512*/
>>          latest_notif =3D 1)),
>>      ss =3D 0xFFFFFF9BEFF2E578)
>>
>>
>> --
>> In AVC update we don't call avc_node_kill() when=20
>> avc_xperms_populate() fails, resulting in the=20
>> avc->avc_cache.active_nodes counter having a false value.In last =
patch this changes was missed , so correcting it.
>>
>> Change-Id: Ic0298162cc766c0f21be7ab232e259766654dad3
>> Signed-off-by: Jaihind Yadav<jaihindyadav@codeaurora.org>
>> ---
>>   security/selinux/avc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c index=20
>> 91d24c2..3d1cff2 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -913,7 +913,7 @@ static int avc_update_node(struct selinux_avc=20
>> *avc,
>>          if (orig->ae.xp_node) {
>>                  rc =3D avc_xperms_populate(node, orig->ae.xp_node);
>>                  if (rc) {
>> -                       kmem_cache_free(avc_node_cachep, node);
>> +                       avc_node_kill(avc, node);
>>                          goto out_unlock;
>>                  }
>>          }
>> --
>=20
> That looks correct to me; I guess that one got missed by the prior =
fix.
> Still not sure how your AVC got into that state though...
>=20
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

BTW, have you been running these stress tests on earlier kernels too?=20
If so, what version(s) are known to pass them?  I ask because this code =
has been present since v4.3 and this is the first such report.

