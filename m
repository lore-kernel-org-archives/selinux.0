Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA38C43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 18:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2319208C3
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 18:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IMuxCVUG";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="P9F48pnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLISaU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:30:20 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:59870
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbfLISaU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 13:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575916219;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=hEQQj/HJOj3QpRrw/kfm96coqySjX8yFieXfkeQbeh0=;
        b=IMuxCVUGiI0CSx0u2rx76ot01ZRU3nuJgGjt6lvzN4UFHl+XO88fWATPJ82JOQ4r
        VqbKyWqEpAyYTVp09+XDmCp0GjCJMTM1bumyiDCgfn5OHXjd6dku2S/9dWw6DdYnPWA
        W9UPa6/gzvNWOkwrpl6Unat4Gkb6j41DgdVYHovg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575916219;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=hEQQj/HJOj3QpRrw/kfm96coqySjX8yFieXfkeQbeh0=;
        b=P9F48pnUDtjGAWKODP348ZnxUHT6CCpT0vFiLNLcNfMJrUBxQitOAqdmvWCqtG3B
        4Ky0WuxiN+MNV+lJtgceH4FRIlio8VeYNs65dS+1ZngR2AWqbFQ8OrwboqAZmqILR6W
        eI9/5vYJpLqEPv/KGO2f9Uj0C3rjd0cG3rbXSiPk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01C3EC447A6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rsiddoji@codeaurora.org
From:   <rsiddoji@codeaurora.org>
To:     "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@vger.kernel.org>
Cc:     <paul@paul-moore.com>, <linux-security-module@vger.kernel.org>
References: <0101016eeb5fdf43-18f58c0b-8670-43eb-ad08-60dae381f0fd-000000@us-west-2.amazonses.com> <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
In-Reply-To: <4335f89f-d2cb-7f45-d370-6ee0699d3c20@tycho.nsa.gov>
Subject: RE: Looks like issue in handling active_nodes count in 4.19 kernel .
Date:   Mon, 9 Dec 2019 18:30:19 +0000
Message-ID: <0101016eebed2b2e-db98eae1-b92b-450b-934e-c8e92c5370b3-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHnox6jYXzQWBJanA4xvaBIwH53oQHEBp5ep4ATdSA=
Content-Language: en-us
X-SES-Outgoing: 2019.12.09-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks for quick response , yes it will be helpful if you can raise the =
change .=20
On the second issue  in  avc_alloc_node we are trying to check the  slot =
status  as    active_nodes  > 512 ( default )=20
Where  checking the occupancy  should be corrected as     active_nodes > =
80% of slots occupied  or 16*512 or=20
May be we need to use a different logic .=20

> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) */
>=20
>   	if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>   	    avc->avc_cache_threshold)      //  default  threshold is 512
>   		avc_reclaim_node(avc);
>=20

Regards,
Ravi=20

-----Original Message-----
From: selinux-owner@vger.kernel.org <selinux-owner@vger.kernel.org> On =
Behalf Of Stephen Smalley
Sent: Monday, December 9, 2019 11:35 PM
To: rsiddoji@codeaurora.org; selinux@vger.kernel.org
Cc: paul@paul-moore.com; linux-security-module@vger.kernel.org
Subject: Re: Looks like issue in handling active_nodes count in 4.19 =
kernel .

On 12/9/19 10:55 AM, rsiddoji@codeaurora.org wrote:
> Hi team ,
> Looks like we have  issue in handling the  "active_nodes" count in the =

> Selinux - avc.c file.
> Where  avc_cache.active_nodes increase more than slot array   and code
> frequency calling of avc_reclaim_node()  from  avc_alloc_node() ;
>=20
> Where following are the 2 instance which seem to  possible culprits=20
> which are seen on 4.19 kernel . Can you  comment if my understand is =
wrong.
>=20
>=20
> #1. if we see the  active_nodes count is incremented in =20
> avc_alloc_node
> (avc) which is called in avc_insert()
> Where if the code take  failure path on  avc_xperms_populate  the code =

> will not decrement this counter .
>=20
>=20
> static struct avc_node *avc_insert(struct selinux_avc *avc,
> 				   u32 ssid, u32 tsid, u16 tclass,
>   				   struct av_decision *avd,
> ....=09
> 	node =3D avc_alloc_node(avc);  //incremented here ....
>                rc =3D avc_xperms_populate(node, xp_node);  //=20
> possibilities of this getting failure is there .
> 		if (rc) {
> 			kmem_cache_free(avc_node_cachep, node);  // but on failure we are=20
> not decrementing active_nodes ?
> 			return NULL;
>   		}

I think you are correct; we should perhaps be calling avc_node_kill() =
here as we do in an earlier error path?

>=20
> #2.  where it looks like the logic on comparing the  active_nodes=20
> against avc_cache_threshold seems  wired  as the count of active nodes =

> is always going to be
>   more than 512 will may land in simply  removing /calling =20
> avc_reclaim_node frequently much before the slots are full maybe we=20
> are not using cache at best ?
>   we should be comparing with some high watermark ? or my=20
> understanding wrong ?
>  =20
> /*@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc) */
>=20
>   	if (atomic_inc_return(&avc->avc_cache.active_nodes) >
>   	    avc->avc_cache_threshold)      //  default  threshold is 512
>   		avc_reclaim_node(avc);
>=20

Not entirely sure what you are asking here.  avc_reclaim_node() should =
reclaim multiple nodes up to AVC_CACHE_RECLAIM.  Possibly that should be =
configurable via selinuxfs too, and/or calculated from =
avc_cache_threshold in some way?

Were you interested in creating a patch to fix the first issue above or =
looking to us to do so?



