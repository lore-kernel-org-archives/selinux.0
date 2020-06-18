Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF069C433DF
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBC720890
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 19:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWbt49zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFRTdR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:33:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46337 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726940AbgFRTdQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 15:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592508795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5JFoKm3q9BeZ7wExv/m0tGzLt9Maf1g2QMn4oKNhTw=;
        b=dWbt49zRS5kFTWks1KSV5BukSygptQhHZKW62UT6JBe2EKARVDf3ZXXWr1penyMEQPXgtD
        HviX9tZyQPrtzgOXKLF/wkH5aoX/OkteotQcy8zMDo0nfnIlQnlhyseJaMhCkVHzCXPU3B
        wszetX3MHLXv+PfjQI94Hplvl1QOcxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-zvQoO34FN4q6kb2TXS0nTQ-1; Thu, 18 Jun 2020 15:33:11 -0400
X-MC-Unique: zvQoO34FN4q6kb2TXS0nTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68A1E8018A7;
        Thu, 18 Jun 2020 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 759415C1D0;
        Thu, 18 Jun 2020 19:33:09 +0000 (UTC)
Date:   Thu, 18 Jun 2020 21:33:06 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Ji Qin <jiqin.ji@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH] libselinux: Fix NULL pointer use in
 selinux_restorecon_set_sehandle
Message-ID: <20200618193306.GC689512@localhost.localdomain>
References: <20200615012023.8315-1-jiqin.ji@huawei.com>
 <CAEjxPJ4_09hUSYrvs7Av_JV7w9ApiQDRmY=wVu6B2MGJYStKVA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ4_09hUSYrvs7Av_JV7w9ApiQDRmY=wVu6B2MGJYStKVA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 07:39:23AM -0400, Stephen Smalley wrote:
> On Sun, Jun 14, 2020 at 9:22 PM Ji Qin <jiqin.ji@huawei.com> wrote:
> >
> > error occur when selinux_restorecon_default_handle return NULL in
> > restorecon_init.
> >
> > fixes: https://github.com/SELinuxProject/selinux/issues/249
> >
> > Signed-off-by: Ji Qin <jiqin.ji@huawei.com>
>=20
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>=20

Applied, thanks!
--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7rwWwACgkQviIJHj72
InWK2w//elpO/mwuZUAg8nIMBqXdddFuHEUnyp5YLQDjlQ4w8i9gBkpgB6A0wAUG
2hrzeEd4uBqJR6P8QqRL02ELd3I6FIt/nH6nXLgGZQ9x5uepmiqrdYov58L0QoSH
qbvEv0VFO2QlrxpdOcMUceQSM1k5BhL4Lr2A8Ow7LMXz5h/bqcGNRKc2OdGX/EW0
RadG0nrlGYHXLpTLArZVWsCoN3Lu3QjeSjtfYPBjTSniGm5WONG7UTptKGY3ea0Q
GB3/TE/0F3WfhhCRBkTo9EXVIRaMLAmzghVeGArmzxx34rCMBcm56SsrIPVUtPvo
V4cK0Upq6G+1zXATFNA6j2s6yMfXCr3pD5qOAorF1NXbB9WpOC7ZG9xmvdsXSa2d
ENyU1z/Ej8V0puQTXeqaJESr00lQPwBxVWjvGJNGrMXhN+mtWDQqgQBWBgFJpsM7
HMGdL2C1jemjYK6NUmn1nsuOqVloUtB+J8QKKulDOR0stAOAGoVZxfD7gm07c9w5
XSuXxm5BkM9sRG9GpEgWLye7/GN49oBio5SI9u/hSSFF1U3O6kFbIJmvqtz7YFzQ
SC3ydJ8qa/yfod/LSxVoePyjVPQclNcb/B/PVHhFTcTMnZ5SoiQHhlMSwkk79Rfs
6d9k4liVx1/OPZR4/n78xYNTGoz7pbWUJS0KyPBzS+XvhXA0FSs=
=/K49
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--

