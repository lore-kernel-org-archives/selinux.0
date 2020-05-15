Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DA8C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5309320657
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkiOQbTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgEONn3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 09:43:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32204 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgEONn2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 09:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589550207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x2SVnpTNSwMwJ24wlz1aL0Pp9vEnc7+UJIZCkWCC5Kc=;
        b=PkiOQbTM4QLjp0201/oIGOB6ncMxhlUMF++wRUsXjIUVM/OvN8bHbRxubjH5uMT0lC+mLB
        r/V/In/eyq8yVBwATDFSuaJR+gLCr8BbAD6Zdxa2qeyJjGfLROClmupxfdkPfPrOdIO5sB
        Uy23Hpl6EpVyyJ4FHQAO8MAXKxPCIAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-RFvPgCSfMrO3KktjLWB6Gg-1; Fri, 15 May 2020 09:43:25 -0400
X-MC-Unique: RFvPgCSfMrO3KktjLWB6Gg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C97E8018A6;
        Fri, 15 May 2020 13:43:24 +0000 (UTC)
Received: from workstation (unknown [10.40.194.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D6185C1D6;
        Fri, 15 May 2020 13:43:23 +0000 (UTC)
Date:   Fri, 15 May 2020 15:43:20 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] secilc: Fix policy optimization test
Message-ID: <20200515134320.GG255621@workstation>
References: <20200513144329.181671-1-plautrba@redhat.com>
 <CAP+JOzRsdSmdwUFAOpPRvggRkHyrazx6-ZYBMZ9NFHHjiexvUA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+JOzRsdSmdwUFAOpPRvggRkHyrazx6-ZYBMZ9NFHHjiexvUA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2020 at 01:37:13PM -0400, James Carter wrote:
> On Wed, May 13, 2020 at 10:46 AM Petr Lautrbach <plautrba@redhat.com> wro=
te:
> >
> > Commit 692716fc5fd5 ("libsepol/cil: raise default attrs_expand_size to =
2") was
> > reverted and attributes with one type are not expanded anymore.
> >
> > Fixes:
> >     ./secilc test/policy.cil
> >     ./secilc -c 32 -O -M 1 -f /dev/null -o opt-actual.bin test/opt-inpu=
t.cil
> >     checkpolicy -b -C -M -o opt-actual.cil opt-actual.bin >/dev/null
> >     diff test/opt-expected.cil opt-actual.cil
> >     11a12
> >     > (typeattribute at01)
> >     21a23
> >     > (typeattributeset at01 (tp01))
> >     25c27,28
> >     < (allow tp01 self (cl01 (p01a p01b p11a p11b)))
> >     ---
> >     > (allow tp01 at01 (cl01 (p11b)))
> >     > (allow tp01 self (cl01 (p01a p01b p11a)))
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> Acked-by: James Carter <jwcart2@gmail.com>

Applied.

> > ---
> >  secilc/test/opt-expected.cil | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/secilc/test/opt-expected.cil b/secilc/test/opt-expected.ci=
l
> > index 73ac9045f23e..14033f9be4dd 100644
> > --- a/secilc/test/opt-expected.cil
> > +++ b/secilc/test/opt-expected.cil
> > @@ -9,6 +9,7 @@
> >  (category c01)
> >  (categoryorder (c01))
> >  (sensitivitycategory s01 (c01))
> > +(typeattribute at01)
> >  (typeattribute at02)
> >  (boolean b01 false)
> >  (type tp01)
> > @@ -19,10 +20,12 @@
> >  (type tpr3)
> >  (type tpr4)
> >  (type tpr5)
> > +(typeattributeset at01 (tp01))
> >  (typeattributeset at02 (tp01 tp02))
> >  (allow at02 tpr1 (cl01 (p01a p01b p11a)))
> >  (allow at02 tpr3 (cl01 (p01a p01b p11a)))
> > -(allow tp01 self (cl01 (p01a p01b p11a p11b)))
> > +(allow tp01 at01 (cl01 (p11b)))
> > +(allow tp01 self (cl01 (p01a p01b p11a)))
> >  (allow tp01 tpr1 (cl01 (p11b)))
> >  (dontaudit at02 tpr2 (cl01 (p01a p01b p11a)))
> >  (dontaudit at02 tpr4 (cl01 (p01a p01b p11a)))
> > --
> > 2.26.2
> >
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6+nHIACgkQviIJHj72
InUW6g/+Nuz/LdbNF0tSminYJj5jyXugBrWohCpJY2jBsTbFk16wVi4Yw7oK0DU6
9jSy4HJ8qtlwQSWr+qdwn6DEVxrgGlI8C2Jol1M3f5iNCayap7ninK+ucOUEwO50
uwgWZa4vQYe7yf7e2F8P2KHujgMgo0KeClAe6OrA0wHWfFY7cwbliQLRGc0mdXgv
UYYdBiMmSmNgJvvP6+RSk5QpIBwLmhnIY06N0F2oTcBM/8hFL2eX4BpRUt6InUt5
PCDz2o+nMumMc/nCEwvUDX/jaE+bTLyFX58NMTLB6ly+s2y8gOK8/DhHJv7uQYIP
luZnT+XU1GPFDUFr7JIHgaQYWNiWM5sEFTXo1xMogohdQtjZaxxYEH/0q5mCbktZ
8QwjFzGBwEOPwzukyoXysRBe44yW9wi5s7AQ3kidpqReiQjzZQjSnJwC9ENgZZu9
dANr/8halNMJF3fiBTEkuSQt+tzTXhyW2NtTsIefsRgNUh1VV55XyjpJIV81S8MD
jVatOyECLm04dKv8AKeo4MkTnaeM9vAdCrLMlZbVKguD59+WJ5CbA5b1NfzSYgu4
RJnT65LShy5jixbIa0AqOXEyOZ9CCOo/3av+1gCpp0heZrV3P0kcOLt7OmzXiRAk
ESw9DWpSjQ/okoEM/3zMOQr+WwJ+PhC9HEG/CR49+wHu8vlDdBM=
=smrA
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--

