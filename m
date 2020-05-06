Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A4DC28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 14:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FE82073A
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 14:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLFi22gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgEFOKs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 10:10:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728248AbgEFOKs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 10:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588774246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFXbEUtETattVNt7X6anxvRyI5fMgR5E0bmj/MiJtSY=;
        b=LLFi22gukzIW2DEUBoswKDtJdzVLmcLrgDW4PruF13xPH71hh3Q6XZ9kyKzg7ZsZ/94mJB
        JxUEVreYJ98WP3+TuZ8Kaombw8DidVuWr5V+NVe7wffbcimUWIFmVOwd/4wv9Zr2tXvs59
        j4zr7XooN3s/5Zd17aXtbJ52IQRXv2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-xG8kI4uAOWaois-60_klgw-1; Wed, 06 May 2020 10:10:38 -0400
X-MC-Unique: xG8kI4uAOWaois-60_klgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC455835B51
        for <selinux@vger.kernel.org>; Wed,  6 May 2020 14:10:37 +0000 (UTC)
Received: from workstation (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE0EF60C18;
        Wed,  6 May 2020 14:10:33 +0000 (UTC)
Date:   Wed, 6 May 2020 16:10:29 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Richard Filo <rfilo@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v3] libselinux: Add missing errno setup
Message-ID: <20200506141029.GA52210@workstation>
References: <CAFqZXNs88P_VeYgO=9nOX1Z2vpPUVgHxTTqyk6Rj-peqhyN-bA@mail.gmail.com>
 <20200504103842.96472-1-rfilo@redhat.com>
 <CAFqZXNsMAwyzKehCN2oHe7jreUGZOAysvBWXa+yC81B3Q22xVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <CAFqZXNsMAwyzKehCN2oHe7jreUGZOAysvBWXa+yC81B3Q22xVw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 01:08:33PM +0200, Ondrej Mosnacek wrote:
> On Mon, May 4, 2020 at 12:39 PM Richard Filo <rfilo@redhat.com> wrote:
> > Errno is not set to ENOENT when lookup_all() doesn't find any match.
> >
> > fixes: https://src.fedoraproject.org/tests/selinux/issue/51
> >
> > Signed-off-by: Richard Filo <rfilo@redhat.com>
> > ---
> >         -removed check: result !=3D NULL
> >
> >  libselinux/src/label_file.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 300625c2..74d2027e 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -948,6 +948,8 @@ static const struct spec **lookup_all(struct selabe=
l_handle *rec,
> >                         goto finish;
> >                 }
> >         }
> > +       if (!result[0])
> > +               errno =3D ENOENT;
> >
> >  finish:
> >         free(clean_key);
> > --
> > 2.25.2
>=20
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>=20
> Thanks!
>=20

^&^ git am v3-libselinux-Add-missing-errno-setup.patch=20
Applying: libselinux: Add missing errno setup
=2Egit/rebase-apply/patch:15: trailing whitespace.
        if (!result[0])=20
warning: 1 line adds whitespace errors.

I have fixed the trailing whitespace and applied it.

Thanks.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6yxU8ACgkQviIJHj72
InUQUhAAkh61D/TUFVhTOiipbKarnUqV/H5iJPTPSCQfgYnbw6sWMkd23uQ/0FXt
4VLWk/H6z800dX9MaO+8MpSTLykfVxgXalQXphEwqVx2DJbIz4vORDFMODKG5JM6
LWdCFakvVjzbFWZb6E+AENHT8cJ3vB4UAFOPQ6c6JnmkMGyGISPqq3qFFrvXkeLo
vRyJJyf+KoMBBeG79R88Ihfr534ce59RQMwNlCUX4KGu8prUG/yZevgKxFA1sg6D
Po6AdRfeYJ5wVXcrQaEp7Dj4NuqAxnS4josxutNV8nDJWfWk5SK12np2F2ZK3zLi
3ekTE698/ZP16jtVtrssNhdaIf4AlmKzAM6OfshcHxKaJbtpg/3w0FNJvUTW7YSd
14cooWFy4ASyoEuI87EsYOsLc2kUHdTLHlbsHb3mgjMke6xnZ/p9N2hHnu7CI1VM
e9EbvKUUl+mf94W5YKz8FMYbdBgKF/OjNn90oXmNzapB1vipanM3TCnIsCLcT/HQ
aoTshwi+HNGRWboItwVyJilq9AYXrFVqRi7JsRZLPpCglTN5EjH76xDuY6G6KILE
RgIWHLA/J+v3j8Xu610UIbkL1l3UKjTok+Z+n5wVFB+MnhKrRHJy3riJDL6Dlxf0
0uQ9sTp5RXqjT/AAQOl4y3tMVLylBNVllLeTgcJqh388WSF4Z20=
=8R6g
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

