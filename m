Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8425C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9835C24672
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="k7uQPCLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLQPkX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:40:23 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:56305 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbfLQPkW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 10:40:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576597222; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=KJ1AbHMkv6ev1vNSxxTMqudhxeC+tK7Ws5svbBYRSpA=; b=k7uQPCLAM/KH2NyDWlwm6s+xXnZSQlbGJ6OBbNVTnC5Fr+ebJSVjYVORU7QTG6T8pkxwA1Fn
 PkFaFd/eIUOTGAxA+MXlUatJaPDVp/QGxnwIz3FGws6Yhq+fOUnimsVs1GnVO9Dpt1JHO2uy
 ECHaSf9QzSNOFl8wcdqmgrzy7LM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyIxZmM3MiIsICJzZWxpbnV4QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df8f6e5.7fca5d04d618-smtp-out-n01;
 Tue, 17 Dec 2019 15:40:21 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 76452C43383; Tue, 17 Dec 2019 15:40:20 +0000 (UTC)
Received: from rsiddoji1 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rsiddoji)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 307C9C433CB;
        Tue, 17 Dec 2019 15:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 307C9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   "Ravi Kumar Siddojigari" <rsiddoji@codeaurora.org>
To:     "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@vger.kernel.org>
Cc:     <paul@paul-moore.com>, <linux-security-module@vger.kernel.org>
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com> <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov> <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com> <7b047966-33c0-de62-b10f-047819890337@tycho.nsa.gov> <d6081414-613f-fdb8-8dcd-9ebf6a3baa27@tycho.nsa.gov> <0101016ef59a2152-41e65aac-8784-4401-b20d-45b2852872d4-000000@us-west-2.amazonses.com> <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov>
In-Reply-To: <411fa1ea-d9b4-b89e-8cab-656db8eef259@tycho.nsa.gov>
Subject: RE: Looks like issue in handling active_nodes count in 4.19 kernel .
Date:   Tue, 17 Dec 2019 21:10:15 +0530
Organization: The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
Message-ID: <001e01d5b4f0$495efbd0$dc1cf370$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHnox6jYXzQWBJanA4xvaBIwH53oQHEBp5eAW+3n+oCcppYQQLX+pcHAZBKVBoDAGwdB6cyIdZQ
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Yes  indeed this is a stress test on ARM64 device with multicore  where =
most of the cores /tasks are stuck  in avc_reclaim_node .=20
We still see this issue even after picking the earlier patch " selinux: =
ensure we cleanup the internal AVC counters on error in avc_insert() =
commit: d8db60cb23e4"
Where selinux_state  during issue was as below where all the slots are  =
NULL and the count was more than threshold.
Which seem to be calling avc_reclaim_node always and as the all the =
slots are empty its going for full for- loop with locks and unlock and =
taking too long .=20
Not sure what could make the  slots null , for sure its not due to =
flush() /Reset(). We think that still we need to call  avc_kill_node  in =
update_node function .
Adding the patch below can you please review or correct the following =
patch .


  selinux_state =3D (
    disabled =3D FALSE,
    enforcing =3D TRUE,
    checkreqprot =3D FALSE,
    initialized =3D TRUE,
    policycap =3D (TRUE, TRUE, TRUE, FALSE, FALSE, TRUE),
    avc =3D 0xFFFFFF9BEFF1E890 -> (
      avc_cache_threshold =3D 512,  /* <<<<<not configured and its with =
default*/
      avc_cache =3D (
        slots =3D ((first =3D 0x0), (first =3D 0x0), (first =3D 0x0), =
(first =3D 0x0), (first =3D 0x0), (first =3D 0x0), (first =3D 0x0), =
(first =3D 0x0), (first =3D 0x0), (first =3D 0x0), (first =3D 0x0), =
(first =3D 0x0), (first   /*<<<< all are NULL */
        slots_lock =3D ((rlock =3D (raw_lock =3D (val =3D (counter =3D =
0), locked =3D 0, pending =3D 0, locked_pending =3D 0, tail =3D 0), =
magic =3D 3735899821, owner_cpu =3D 4294967295, owner =3D =
0xFFFFFFFFFFFFFFFF, dep_map =3D (key =3D 0xFFFFFF9BEFF298A8, cla
        lru_hint =3D (counter =3D 616831529),
        active_nodes =3D (counter =3D 547),   /*<<<<< increased more =
than 512*/
        latest_notif =3D 1)),
    ss =3D 0xFFFFFF9BEFF2E578)


--
In AVC update we don't call avc_node_kill() when avc_xperms_populate()
fails, resulting in the avc->avc_cache.active_nodes counter having a
false value.In last patch this changes was missed , so correcting it.

Change-Id: Ic0298162cc766c0f21be7ab232e259766654dad3
Signed-off-by: Jaihind Yadav<jaihindyadav@codeaurora.org>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 91d24c2..3d1cff2 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -913,7 +913,7 @@ static int avc_update_node(struct selinux_avc *avc,
        if (orig->ae.xp_node) {
                rc =3D avc_xperms_populate(node, orig->ae.xp_node);
                if (rc) {
-                       kmem_cache_free(avc_node_cachep, node);
+                       avc_node_kill(avc, node);
                        goto out_unlock;
                }
        }
--

Regards,
Ravi


-----Original Message-----
From: Stephen Smalley <sds@tycho.nsa.gov>=20
Sent: Wednesday, December 11, 2019 9:24 PM
To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
Subject: Re: Looks like issue in handling active_nodes count in 4.19 =
kernel .

On 12/11/19 10:35 AM, rsiddoji@codeaurora.org wrote:
> Thanks for tacking the patch fwd . On the  question :
>=20
> Actually issue started when we were seeing most of the  time =
"avc_reclaim_node" in the stack .
> Which on debugging further  avc_cache.active_nodes was already in 7K+=20
> nodes  and  as the logic  is
>=20
> As below .
> 	if (atomic_inc_return(&avc->avc_cache.active_nodes) >   =
avc->avc_cache_threshold)
>             			avc_reclaim_node(avc);
>=20
> So if the  active_nodes count is  > 512  (if not configured) we will =
be always be calling   avc_reclaim_node() and eventually  for each  node =
insert we will be calling avc_reclaim_node  and might  be expansive then =
using
> cache  and advantage of cache might be null and void due to this =
overhead?

Was this on a system with the default avc_cache_threshold value or was =
it set higher by the distro/user?

If it was still 512 or any value significantly less than 7K, then the =
bug is that it ever reached 7K in the first place. The first bug should =
only trigger under severe memory pressure.  The other potential reason =
for growing numbers of active nodes would be cache thrashing leading to
avc_reclaim_node() being unable to take the lock on any buckets and =
therefore unable to release nodes.

Possibly you need a larger cache threshold set on this system.  It can =
be set via /sys/fs/selinux/avc/cache_threshold.

Allowing AVC_CACHE_RECLAIM to also be set via selinuxfs or computed =
relative to avc_cache_threshold would make sense as a further =
improvement.

>=20
> Thanks ,
> Ravi
>=20
> -----Original Message-----
> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On =

> Behalf Of Stephen Smalley
> Sent: Wednesday, December 11, 2019 8:18 PM
> To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
> Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
> Subject: Re: Looks like issue in handling active_nodes count in 4.19 =
kernel .
>=20
> On 12/11/19 9:37 AM, Stephen Smalley wrote:
>> On 12/9/19 1:30 PM, rsiddoji@codeaurora.org wrote:
>>> Thanks for quick response , yes it will be helpful if you can raise=20
>>> the change .
>>> On the second issue  in  avc_alloc_node we are trying to check the
>>> slot status  as    active_nodes  > 512 ( default ) Where  checking
>>> the occupancy  should be corrected as     active_nodes
>>>> 80% of slots occupied  or 16*512 or
>>> May be we need to use a different logic .
>>
>> Are you seeing an actual problem with this in practice, and if so,=20
>> what exactly is it that you are seeing and do you have a reproducer?
>=20
> BTW, on Linux distributions, there is an avcstat(8) utility that can=20
> be used to monitor the AVC statistics, or you can directly read the=20
> stats from the kernel via /sys/fs/selinux/avc/cache_stats
>=20
>>
>>>
>>>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) =

>>>> */
>>>>
>>>>         if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>>>             avc->avc_cache_threshold)      //  default  threshold =
is
>>>> 512
>>>>             avc_reclaim_node(avc);
>>>>
>>>
>>> Regards,
>>> Ravi
>>>
>>> -----Original Message-----
>>> From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org>=20
>>> On Behalf Of Stephen Smalley
>>> Sent: Monday, December 9, 2019 11:35 PM
>>> To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
>>> Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
>>> Subject: Re: Looks like issue in handling active_nodes count in 4.19 =

>>> kernel .
>>>
>>> On 12/9/19 10:55 AM, rsiddoji@codeaurora.org wrote:
>>>> Hi team ,
>>>> Looks like we have  issue in handling the  "active_nodes" count in=20
>>>> the Selinux - avc.c file.
>>>> Where  avc_cache.active_nodes increase more than slot array   and
>>>> code frequency calling of avc_reclaim_node()  from =20
>>>> avc_alloc_node() ;
>>>>
>>>> Where following are the 2 instance which seem to  possible culprits =

>>>> which are seen on 4.19 kernel . Can you  comment if my understand=20
>>>> is wrong.
>>>>
>>>>
>>>> #1. if we see the  active_nodes count is incremented in=20
>>>> avc_alloc_node
>>>> (avc) which is called in avc_insert() Where if the code take=20
>>>> failure path on  avc_xperms_populate  the code will not decrement=20
>>>> this counter .
>>>>
>>>>
>>>> static struct avc_node *avc_insert(struct selinux_avc *avc,
>>>>                     u32 ssid, u32 tsid, u16 tclass,
>>>>                        struct av_decision *avd, ....
>>>>      node =3D avc_alloc_node(avc);  //incremented here ....
>>>>                  rc =3D avc_xperms_populate(node, xp_node);  //=20
>>>> possibilities of this getting failure is there .
>>>>          if (rc) {
>>>>              kmem_cache_free(avc_node_cachep, node);  // but on=20
>>>> failure we are not decrementing active_nodes ?
>>>>              return NULL;
>>>>             }
>>>
>>> I think you are correct; we should perhaps be calling=20
>>> avc_node_kill() here as we do in an earlier error path?
>>>
>>>>
>>>> #2.  where it looks like the logic on comparing the  active_nodes=20
>>>> against avc_cache_threshold seems  wired  as the count of active=20
>>>> nodes is always going to be
>>>>     more than 512 will may land in simply  removing /calling=20
>>>> avc_reclaim_node frequently much before the slots are full maybe we =

>>>> are not using cache at best ?
>>>>     we should be comparing with some high watermark ? or my=20
>>>> understanding wrong ?
>>>> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) =

>>>> */
>>>>
>>>>         if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>>>>             avc->avc_cache_threshold)      //  default  threshold =
is
>>>> 512
>>>>             avc_reclaim_node(avc);
>>>>
>>>
>>> Not entirely sure what you are asking here.  avc_reclaim_node()=20
>>> should reclaim multiple nodes up to AVC_CACHE_RECLAIM.  Possibly=20
>>> that should be configurable via selinuxfs too, and/or calculated=20
>>> from avc_cache_threshold in some way?
>>>
>>> Were you interested in creating a patch to fix the first issue above =

>>> or looking to us to do so?
>>>
>>>
>>>
>>
>=20
>=20

