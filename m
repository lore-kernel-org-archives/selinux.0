Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE213C47257
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A13D2495A
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 08:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EawJt4C3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEDIoz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 04:44:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44762 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726351AbgEDIoy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 04:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588581892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZP7e10dhC7MUf9Sru0uswWVE5F4xE4U29c0+qO+pg90=;
        b=EawJt4C3gkZ6AOf+i7fbzyALZcWbWSdnPP1A/QQR/JLpiOKsvHT3jK4KwrLiJLreL9PlBp
        bWK9CTGZtAXjgXjYM5ctApeFc8joOW4NgOSQc/+L9EWwxicjDJ6yVWR9zzhzG3HBH2psHr
        fNtfmIACh5+RLPZH9HBBxqBFXny+c1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215--R8Ki2urPOavX_zZ5NQa2A-1; Mon, 04 May 2020 04:44:48 -0400
X-MC-Unique: -R8Ki2urPOavX_zZ5NQa2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EDF280B713;
        Mon,  4 May 2020 08:44:47 +0000 (UTC)
Received: from workstation (unknown [10.40.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65C665C1B2;
        Mon,  4 May 2020 08:44:46 +0000 (UTC)
Date:   Mon, 4 May 2020 10:44:42 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH v2] sepolicy: fix some typos and port definitions
Message-ID: <20200504084442.GA245818@workstation>
References: <20200430183035.9976-1-toiwoton@gmail.com>
 <20200501073734.GA210172@workstation>
MIME-Version: 1.0
In-Reply-To: <20200501073734.GA210172@workstation>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 09:37:34AM +0200, Petr Lautrbach wrote:
> On Thu, Apr 30, 2020 at 09:30:35PM +0300, Topi Miettinen wrote:
> > The range of unreserved ports starts from 1024 and ends to
> > 65535 (inclusive). (Secure) RPC ports can be between 512 and
> > 1023 (inclusive).
> >=20
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>=20
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> Thanks!
>=20
> It there's no other comment I'll merge this and the other patch on Monday=
.

Both applied.

>=20
> > ---
> >  python/sepolicy/sepolicy/generate.py  | 4 ++--
> >  python/sepolicy/sepolicy/interface.py | 2 +-
> >  python/sepolicy/sepolicy/network.py   | 6 +++---
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sep=
olicy/generate.py
> > index e8d07e7d..4e1ed4e9 100644
> > --- a/python/sepolicy/sepolicy/generate.py
> > +++ b/python/sepolicy/sepolicy/generate.py
> > @@ -340,7 +340,7 @@ class policy:
> >              (self.generate_root_user_types, self.generate_root_user_ru=
les),
> >              (self.generate_new_types, self.generate_new_rules))
> >          if not re.match(r"^[a-zA-Z0-9-_]+$", name):
> > -            raise ValueError(_("Name must be alpha numeric with no spa=
ces. Consider using option \"-n MODULENAME\""))
> > +            raise ValueError(_("Name must be alphanumeric with no spac=
es. Consider using option \"-n MODULENAME\""))
> > =20
> >          if type =3D=3D CGI:
> >              self.name =3D "httpd_%s_script" % name
> > @@ -438,7 +438,7 @@ class policy:
> > =20
> >      def set_init_script(self, initscript):
> >          if self.type !=3D DAEMON:
> > -            raise ValueError(_("Only Daemon apps can use an init scrip=
t.."))
> > +            raise ValueError(_("Only Daemon apps can use an init scrip=
t."))
> > =20
> >          self.initscript =3D initscript
> > =20
> > diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/se=
policy/interface.py
> > index 187419fa..7d4ebd7e 100644
> > --- a/python/sepolicy/sepolicy/interface.py
> > +++ b/python/sepolicy/sepolicy/interface.py
> > @@ -198,7 +198,7 @@ def get_xml_file(if_file):
> >      filename =3D os.path.basename(if_file).split(".")[0]
> >      rc, output =3D getstatusoutput("/usr/bin/python3 /usr/share/selinu=
x/devel/include/support/segenxml.py -w -m %s" % (basedir + filename))
> >      if rc !=3D 0:
> > -        sys.stderr.write("\n Could not proceed selected interface file=
.\n")
> > +        sys.stderr.write("\n Could not process selected interface file=
.\n")
> >          sys.stderr.write("\n%s" % output)
> >          sys.exit(1)
> >      else:
> > diff --git a/python/sepolicy/sepolicy/network.py b/python/sepolicy/sepo=
licy/network.py
> > index ff308fad..d26a7ce6 100755
> > --- a/python/sepolicy/sepolicy/network.py
> > +++ b/python/sepolicy/sepolicy/network.py
> > @@ -49,15 +49,15 @@ def get_network_connect(src, protocol, perm, check_=
bools=3DFalse):
> >                  if "port_t" in tlist:
> >                      continue
> >              if i =3D=3D "port_t":
> > -                d[(src, protocol, perm)].append((i, ["all ports with o=
ut defined types"]))
> > +                d[(src, protocol, perm)].append((i, ["all ports withou=
t defined types"]))
> >              if i =3D=3D "port_type":
> >                  d[(src, protocol, perm)].append((i, ["all ports"]))
> >              elif i =3D=3D "unreserved_port_type":
> > -                d[(src, protocol, perm)].append((i, ["all ports > 1024=
"]))
> > +                d[(src, protocol, perm)].append((i, ["all ports >=3D 1=
024"]))
> >              elif i =3D=3D "reserved_port_type":
> >                  d[(src, protocol, perm)].append((i, ["all ports < 1024=
"]))
> >              elif i =3D=3D "rpc_port_type":
> > -                d[(src, protocol, perm)].append((i, ["all ports > 500 =
and  < 1024"]))
> > +                d[(src, protocol, perm)].append((i, ["all ports >=3D 5=
12 and < 1024"]))
> >              else:
> >                  try:
> >                      d[(src, protocol, perm)].append((i, portrecs[(i, p=
rotocol)]))
> > --=20
> > 2.26.2
> >=20
>=20

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6v1fQACgkQviIJHj72
InWtxRAAldJcG6PV+823yOonmTJCcjuwMZNLDnwUtFaNhSLCsy6fACj82GswnQCd
hO8McZkvQ+99BwSkUFv2CRnmMOb8gCbibcvvjIO1GCVt3RCcW+9WyDqvOjmVudZG
J5C/Y/7ctOfE2AKIyco3Y2qIaOeWX23M4wFKblLz5Sn8vd5YvJ2JIYlZs3wh3ce0
jx2PM98Qeg+YwAJWWZYhGPboDTHPhEQ4CpnlUwCKVxgrsvVHs64KpysK7Vpia1iQ
cUXoMnBNgTOk8r9Tk8slv8aZbbMtKn3BHDs7TFjfjTrrEQZUKTRVctlmQtQ5l/c5
rdUPRk0updb9uaan9zK15ThWXiL5GrihU0w1Ev1NDLfYxB0HEvn0w8+gSJAt32B1
ayjafA4qcwp8thubeFg/opUNlo5r/E9VEx+LTXY1ZI+YLeZYasz7abL1WTxVT8xh
xI89Vw9WiCKGcLGDfrDKbEmijBo0n/+YXynPf8IOYJExv4acDWmgEZhJXosGaUhU
jQ/CbN18zNqvqpymy79HCdwAit5uHMeEKr6aBaHiX8B6vihkUmo9DLINweP1X9yX
gilShylrR9rrMixaWY7Q4KBvm2lxGHlKzfAe7sJ9IzpZN+KqjpV7lkAXrXNstT3W
7M9tQkNyOGv5BUbUwi0aur0pAqsmHBKnzW4rGoYGU6EdHg96cwQ=
=HZ/v
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

