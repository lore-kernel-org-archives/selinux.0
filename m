Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF495C4724C
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 16:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC5220873
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 16:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEGhsDo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD3QJX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:09:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52883 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726702AbgD3QJW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 12:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588262960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+jDlY5ioTK07Dz5vTEkzO3rFqawO5V9jdvI8EduBl04=;
        b=fEGhsDo0bYWlBBn3PSkRhtNfLuf6btyCR6nsQP8E5VGcHrtz9f8dnpUtgXVibM8K8W/WD+
        LFsPpV6sLEe4cz6iX4Xf4W1sM0R4J97GSylQouWR3NCqunEuQMKe4mM4rnNIOn1IKAjxgR
        aERtViEsJwI7PDpcsamZBcZZYNr+Q28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-A4CtiQDzN0OZ4R5ySB5jEA-1; Thu, 30 Apr 2020 12:09:16 -0400
X-MC-Unique: A4CtiQDzN0OZ4R5ySB5jEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10BE4100D098;
        Thu, 30 Apr 2020 16:09:14 +0000 (UTC)
Received: from workstation (unknown [10.40.192.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8813110A48A0;
        Thu, 30 Apr 2020 16:09:12 +0000 (UTC)
Date:   Thu, 30 Apr 2020 18:09:09 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH] sepolicy: fix some typos and port definitions #230
Message-ID: <20200430160909.GB139885@workstation>
References: <20200429115321.21541-1-toiwoton@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200429115321.21541-1-toiwoton@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 02:53:21PM +0300, Topi Miettinen wrote:
> The range of unreserved ports starts from 1024 and ends to
> 65535 (inclusive). (Secure) RPC ports can be between 512 and
> 1023 (inclusive).
>=20
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  python/sepolicy/sepolicy/generate.py  | 4 ++--
>  python/sepolicy/sepolicy/interface.py | 2 +-
>  python/sepolicy/sepolicy/network.py   | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepol=
icy/generate.py
> index e8d07e7d..4e1ed4e9 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -340,7 +340,7 @@ class policy:
>              (self.generate_root_user_types, self.generate_root_user_rule=
s),
>              (self.generate_new_types, self.generate_new_rules))
>          if not re.match(r"^[a-zA-Z0-9-_]+$", name):
> -            raise ValueError(_("Name must be alpha numeric with no space=
s. Consider using option \"-n MODULENAME\""))
> +            raise ValueError(_("Name must be alphanumeric with no spaces=
. Consider using option \"-n MODULENAME\""))
> =20
>          if type =3D=3D CGI:
>              self.name =3D "httpd_%s_script" % name
> @@ -438,7 +438,7 @@ class policy:
> =20
>      def set_init_script(self, initscript):
>          if self.type !=3D DAEMON:
> -            raise ValueError(_("Only Daemon apps can use an init script.=
."))
> +            raise ValueError(_("Only Daemon apps can use an init script.=
"))
> =20
>          self.initscript =3D initscript
> =20
> diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepo=
licy/interface.py
> index 187419fa..7d4ebd7e 100644
> --- a/python/sepolicy/sepolicy/interface.py
> +++ b/python/sepolicy/sepolicy/interface.py
> @@ -198,7 +198,7 @@ def get_xml_file(if_file):
>      filename =3D os.path.basename(if_file).split(".")[0]
>      rc, output =3D getstatusoutput("/usr/bin/python3 /usr/share/selinux/=
devel/include/support/segenxml.py -w -m %s" % (basedir + filename))
>      if rc !=3D 0:
> -        sys.stderr.write("\n Could not proceed selected interface file.\=
n")
> +        sys.stderr.write("\n Could not process selected interface file.\=
n")
>          sys.stderr.write("\n%s" % output)
>          sys.exit(1)
>      else:
> diff --git a/python/sepolicy/sepolicy/network.py b/python/sepolicy/sepoli=
cy/network.py
> index ff308fad..add837b6 100755
> --- a/python/sepolicy/sepolicy/network.py
> +++ b/python/sepolicy/sepolicy/network.py
> @@ -49,15 +49,15 @@ def get_network_connect(src, protocol, perm, check_bo=
ols=3DFalse):
>                  if "port_t" in tlist:
>                      continue
>              if i =3D=3D "port_t":
> -                d[(src, protocol, perm)].append((i, ["all ports with out=
 defined types"]))
> +                d[(src, protocol, perm)].append((i, ["all ports without =
defined types"]))
>              if i =3D=3D "port_type":
>                  d[(src, protocol, perm)].append((i, ["all ports"]))
>              elif i =3D=3D "unreserved_port_type":
> -                d[(src, protocol, perm)].append((i, ["all ports > 1024"]=
))
> +                d[(src, protocol, perm)].append((i, ["all ports > 1023"]=
))

I'd prefer to use "all ports >=3D 1024" as "1024" is used in the refpolicy =
definition:

policy/modules/kernel/corenetwork.te.m4:ifelse(eval(range_start($2) < 1024)=
,1,`typeattribute $1 reserved_port_type;',`typeattribute $1 unreserved_port=
_type;')

>              elif i =3D=3D "reserved_port_type":
>                  d[(src, protocol, perm)].append((i, ["all ports < 1024"]=
))
>              elif i =3D=3D "rpc_port_type":
> -                d[(src, protocol, perm)].append((i, ["all ports > 500 an=
d  < 1024"]))
> +                d[(src, protocol, perm)].append((i, ["all ports > 511 an=
d < 1024"]))

"all ports >=3D 512 and < 1024"

policy/modules/kernel/corenetwork.te.m4:ifelse(eval(range_start($3) >=3D 51=
2 && range_start($3) < 1024),1,`typeattribute $1 rpc_port_type;


>              else:
>                  try:
>                      d[(src, protocol, perm)].append((i, portrecs[(i, pro=
tocol)]))
> --=20
> 2.26.2
>=20



--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6q+B4ACgkQviIJHj72
InWB5xAAgQJTPkKgAfgEbf9qvLIC412TXBgQEJL8IonY1VAG/EwQdP077Dz9TuOF
Z1XtuLNld07gpwqeHef7Cfa4DlQn3NsqpgvF67tL9OFOtqgRX3ugDF2NL4XpM5/D
SMkuL6cChVbPqLC64xlzeu2OsiAtzyNQmMm+gMQ7q35var1bE1gDdoesNoiXMuBN
pn3zCi+2tdBEzTBtWn/iyAiHC3J0WO1czB3L7vnfhJkMbPuJ/vjkLm6Y58gBVLtU
O1/JYSowDx3+OgwosDjXuUwgDFScTccwoXJYAg0CNoMBG42RhO9m4sRvUVffmC9f
YhzsBYM52igMad6QXTXcOhiaQRk430W79MyBOowcDtig0mpIEPx9s6CxgLLePbmL
xaNNgn0G6FUtGTFVDJwCIkvJJrHjNzA2p6MKY8qFVMYjk+a32xECTpIIxSitX57e
LryjQJXpAvGvJGF6nUra7ccWQB8DrRB7lfSqLgS6+Zbszor8ZyEb+mpEKu7xKfZl
8Hi9IbdHj0/keOpY2aPD4qYd12opQ07139HYJr3qdMKJvNmLU6YG/2IGfZ/9hLU/
Omwv4c3DtHhvQ7owsFi4kJ7prhK2PYs2NkAxPuv8QgHTaLsT4QOr2ihmt/RzJb1i
c/r0EPOoJobPGMGLUQ1jsv+7CExYOSqz4g4EmBJqMbYqbUn82CU=
=DRTq
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

