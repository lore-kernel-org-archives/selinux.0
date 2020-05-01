Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C046CC47254
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 07:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7492071C
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 07:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgINK+8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgEAHhq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 03:37:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728212AbgEAHhp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 03:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588318663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZ29X8UHX2vgdRRmyElZmigqHqwCpbBVhADEDp2k918=;
        b=YgINK+8vhmI9u7HmfxTGCDuzep0gd3AOcl1JBASnhn5h9Jg/6meHheRUc3P8EjhylUzReD
        Lp5HZkPMGDYByFMFg8KrV/cU4zXb6HZtGM24GOmikKXhk/sGFFSrsF/QFsOmuqFNV4vrA2
        6upqGEfGRi7T6evbcwZ6FH9GjILB3Dc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-7qn2aR5jN_q5mOIYy-WB_A-1; Fri, 01 May 2020 03:37:39 -0400
X-MC-Unique: 7qn2aR5jN_q5mOIYy-WB_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F650800D24;
        Fri,  1 May 2020 07:37:38 +0000 (UTC)
Received: from workstation (unknown [10.40.192.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B72C15D9CA;
        Fri,  1 May 2020 07:37:37 +0000 (UTC)
Date:   Fri, 1 May 2020 09:37:34 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH v2] sepolicy: fix some typos and port definitions
Message-ID: <20200501073734.GA210172@workstation>
References: <20200430183035.9976-1-toiwoton@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200430183035.9976-1-toiwoton@gmail.com>
Acked-by: Petr Lautrbach <plautrba@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 09:30:35PM +0300, Topi Miettinen wrote:
> The range of unreserved ports starts from 1024 and ends to
> 65535 (inclusive). (Secure) RPC ports can be between 512 and
> 1023 (inclusive).
>=20
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!

It there's no other comment I'll merge this and the other patch on Monday.


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
> index ff308fad..d26a7ce6 100755
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
> +                d[(src, protocol, perm)].append((i, ["all ports >=3D 102=
4"]))
>              elif i =3D=3D "reserved_port_type":
>                  d[(src, protocol, perm)].append((i, ["all ports < 1024"]=
))
>              elif i =3D=3D "rpc_port_type":
> -                d[(src, protocol, perm)].append((i, ["all ports > 500 an=
d  < 1024"]))
> +                d[(src, protocol, perm)].append((i, ["all ports >=3D 512=
 and < 1024"]))
>              else:
>                  try:
>                      d[(src, protocol, perm)].append((i, portrecs[(i, pro=
tocol)]))
> --=20
> 2.26.2
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6r0bgACgkQviIJHj72
InUajA/+ODR5JAN6Jo5xXJqzyW5Gyp+VMgGtx7RaCR3lx11izgKEUrFi8jucFdXa
10ewutHm0ckYp18KKXCOH7rnYK9OH30kUO5f952F4Wae7l/2yZszDkePDDgrQhL3
tbmF5NgnOIC2samY6VLBUJGXhznPPRn5vwvTaWbdJWLOr/48oDXt5SV4dw/L1vGf
ru7tSsnFiiCbeeljlhn6NyvBv8i0tLYxsV/IUIFPsTeL5+36VO3Pk9JyikuSHVNW
/Rvmh3XM1tvLzwbIWzg8PKlAgC8v3dgQA1Dx2E/sSBivCcKmkRgQboYYah5H03au
846kjFSO9Q/rs9ghPa0reP8XSRiTfIBSrcSRkmMGiN5wrbdZ6e6sKVShBZfWj6yG
wiT5lk1jciotscz6DHV+XGdb3Ecg1VzUEx5nk2N75mSZwlOr/JkW6fxYb6mzjaB4
/6myExX/MQ51g+e42GCsBCdRG5c8dcKw9ceRdrwNW3LQIMbSq/TAykNBivmuIcDP
H1oeS6q41+y2q3z6ixTptGq7zABqB0Haztz3EtcLaX+KN4RM5Ti/8AyyZEiGfeym
tYuqKVBSjwXA7A2/aUHz+rju81ajm2AvP81Tpjw4hMCP5F8Ig5seFOeRQPWrGiCT
DFnm1xjJjcCLLpTjB7UIqvsVbxHXlXz5yciuy6FQUNmzU326VyE=
=z11D
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

