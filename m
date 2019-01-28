Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2782C282CD
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 23:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A99F2171F
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 23:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="eqn4JrL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfA1XD4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:03:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43305 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfA1XD4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 18:03:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so15784702lji.10
        for <selinux@vger.kernel.org>; Mon, 28 Jan 2019 15:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8aM9Uk9hGsxGpldyaj9XeMB/4GxhAuElQQb2TL+otbg=;
        b=eqn4JrL9xFOzSY1QW8PU84WD3nc3I7DgVV3MCiccDvfDfpiYRhp7bzqFoLKZed6hIu
         fDVyIlLv6vfCseZ7+cjQHPKScUHF2zE0/BH+huobTf2o9/1wZ1JI4BBXkMjIF+M5zFTy
         cv1LOiAbGEpQC+TqMY9Atu+LnvQ622cDPPk3JAAiVwvjFX46bf/sU/k1s0AJPc6U7Te8
         spzCjbedX7CW0ffuvFAN2GDADqj9X3e8t6DmcJvrR7GQwkM0R0alRghNG9m8EBg9F/xH
         FfTTOM3RX7r2eUBQ9rMgNy3AvgpPFRKkd5Z4MACDdih3Pbv6vgqcGG1ViGotjuPSHSlN
         fpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8aM9Uk9hGsxGpldyaj9XeMB/4GxhAuElQQb2TL+otbg=;
        b=DpW3AiJ/gXkEv0mzro+JsCUizQUkoRq5qUYZC65InBCA1YfdYklIp8dUfF0CfRTLYt
         UAdcPoGgtRZhqdb1KVOsPKY0swn8XvSasfloZt01IzVOisPMifBJlXL/MFTaWocv/iWO
         s3ur17F40ac+7UeTpoMRyGQlH40kur7YOyEuNZz5rHqhAXC55njRfePvSf4xjFa/9lky
         VWutzId231ZWLkZgoW7ue5212QPFAVs0ZZJFHQWZFVyqgvbg5e8Q/KKcEX10/5OwNPZE
         ZgGiTAAIRc+XNwzpa6a5zduQrEQjt94Gf2O9SM0k2uA+/t++ZkUvqtviLhT2W+S2K1Jf
         NEMg==
X-Gm-Message-State: AJcUukfLFwGsa2hyueaz6vyjaeOS75DbgwB0ntGQ2tEPegvcS5QnvABh
        ZlqoJPdTuKzvAzCk1J85kyEM4iCS0VdjFQDiJDKu
X-Google-Smtp-Source: ALg8bN7yIRNH6uiSHGrkarkNOoKrPnNIRfkyEyguO//EMTvc/pyV7o8whvAAmhntrNdLyyD6YkYSX+2DaAZYfRXInX4=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr18743014ljj.161.1548716633633;
 Mon, 28 Jan 2019 15:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20190127081023.21124-1-leon@kernel.org> <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com>
In-Reply-To: <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 18:03:42 -0500
Message-ID: <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM notifications
To:     Daniel Jurgens <danielj@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 28, 2019 at 11:57 AM Daniel Jurgens <danielj@mellanox.com> wrot=
e:
> On 1/28/2019 10:37 AM, Paul Moore wrote:
> > On Sun, Jan 27, 2019 at 3:10 AM Leon Romanovsky <leon@kernel.org> wrote=
:
> >> From: Daniel Jurgens <danielj@mellanox.com>
> >>
> >> ---
> >>  drivers/infiniband/core/security.c | 34 ++++-------------------------=
-
> >>  include/rdma/ib_mad.h              |  3 ---
> >>  2 files changed, 4 insertions(+), 33 deletions(-)
> > Perhaps predictably, I'm not very excited about this change.  Have you
> > looked closer into the slowdown to see where the cycles are being
> > spent?  I'm wondering if the issue is that a large number of notifiers
> > are being registered with the same priority causing the while loop in
> > notifier_chain_register() to take a significant amount of time.
>
> That's what's happening, each MAD agent is registering it's own notifier.=
 The bug reporter was creating hundreds or thousands of  short lived MAD ag=
ents. With IRQs disabled too long it resulted in timeouts.
>
> When I initially added the notifier mechanism I thought it was you that s=
aid it wasn't really needed, since access wasn't generally revoked in these=
 types of scenarios. Given that I didn't think this would be especially con=
troversial. It was nice to have, unfortunately it causes problems even for =
users that don't enable SELinux.

Revoking permission is difficult, and in some cases likely impossible,
but that doesn't mean we shouldn't try to make it possible when we
can.  I'd like to see if we can sort this out before we give up and
rip it out.

We might be able to modify notifier_chain_register() such that if the
notifier being registered has the same priority as the current node it
is inserted before the current node.  It looks like all of the IB
notifiers have the same priority so that should speed up registration
significantly in this case, unfortunately that doesn't help
unregistering.  I think we would need to move to convert
notifier_block to use list_head if we want to handle removal in a
timely manner.

However, there is also a concern that delivering notifications to
hundreds of thousands of registered notifiers is going to be
problematic.  None of the above is going to fix that.

I'm trying to quickly understand the MAD agent lifecycle, and it looks
like you have your own register/unregister routines, with locking, so
is it reasonable to assume that it would be possible to iterate over
the MAD agents in the IB code?  I wonder if it would be possible to
group MAD agents (per-port grouping, does that make sense?) such that
several agents would share a single LSM notifier registration?

--=20
paul moore
www.paul-moore.com
