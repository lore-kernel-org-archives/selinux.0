Date: Thu, 24 Sep 2015 17:00:23 +1000
From: Matthew Cengia <mattcen@cyber.com.au>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: overlayfs+selinux error: OPNOTSUPP
Message-ID: <20150924070022.GA22582@cyber.com.au>
References: <20150921022517.GH22582@cyber.com.au>
 <56006BBA.4070602@tycho.nsa.gov>
 <201509231323.31482.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X8oaj2qX3NXXvcHN"
In-Reply-To: <201509231323.31482.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--X8oaj2qX3NXXvcHN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2015-09-23 13:23, Russell Coker wrote:
[...]
> To load the policy in the initrd you need to copy=20
> /etc/selinux/default/policy/policy.* and /usr/sbin/load_policy to the ini=
trd=20
> and first mount /proc and the selinuxfs before loading the policy.  It wi=
ll be=20
> a little fiddly to setup (as does anything involving the initrd) but not =
any=20
> great challenge.
>=20
> Also it's unlikely that systemd has been tested in a situation where an i=
nitrd=20
> loads the policy.  In case anyone wonders, I think it should be considere=
d a=20
> bug if systemd or SysVInit fails to work when the policy was loaded in th=
e=20
> initrd.

Thanks Russell!

Just a quick email to let you all know that with the below code in my
build script, I successfully copied in and loaded the SELinux policy in
the initrd, and my EOPNOTSUPP errors disappeared, allowing me to boot
the system!

That's Good Enough=E2=84=A2 for me for the moment, and I can revisit using a
more minimal policy or similar later if necessary. For now, I'm going to
ensure I'm using Russell's latest Debian Jessie-compatible SELinux
policy to see what AVC denials I'm getting, before deciding whether to
just go with that and tweak it to do the few lockdowns I need, or learn
how to write a new one from scratch.

I suspect writing a full policy will be deferred until quite some time
later if I can get something small sorted out in the short-term, as I'm
on a reasonably tight timeline at the moment, having spent a month
fighting this problem and the ones leading up to it.

Thanks again for all your help everyone!

diff --git c/bootstrap w/bootstrap
index c38651e..cb45635 100755
--- c/bootstrap
+++ w/bootstrap
@@ -401,0 +402,16 @@ setfiles -r $t/ $t/etc/selinux/default/contexts/files/=
file_contexts $t/
+>$t/etc/initramfs-tools/hooks/selinux   cat <<'EOF' && chmod +x $t/etc/ini=
tramfs-tools/hooks/selinux
+#!/bin/bash
+[ prereqs =3D "$1" ] && exit 0
+. /usr/share/initramfs-tools/hook-functions
+
+copy_exec /usr/sbin/load_policy
+cp -a {,"$DESTDIR"}/etc/selinux/
+EOF
+>$t/etc/initramfs-tools/scripts/init-top/selinux  cat <<'EOF' && chmod +x =
$t/etc/initramfs-tools/scripts/init-top/selinux
+#!/bin/sh
+[ prereqs =3D "$1" ] && exit 0
+
+mount -t selinuxfs selinuxfs /sys/fs/selinux
+load_policy
+EOF
+chroot $t update-initramfs -u -k all

--=20
Regards,
Matthew Cengia

--X8oaj2qX3NXXvcHN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQJ8BAEBCgBmBQJWA5+GXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRDMTlFRDFDRTdERThBODYxMjhGOEQwNEI5
RDBCNTY1NTlCRjZBNTYyAAoJEJ0LVlWb9qViAq4P/3iCNKrO9mBKr3MwnANMiSgb
J0s9M+WxlmjUZ2LDm3LRKEjGmUZhFUHTLFRACw0FT2e+nfLKdAoOJiH8Bcd81NSb
7vo5W5qpeTtmjm3Lk3vTYVsc/Y8Okan7hatD0fxUDLlOOeEs7T1OWhyueEJtvs4T
QMYF9BI+kstBDr8CWHbOlrWNlrKfhYG60fp849m5ByCT1YxK9fbLno2dByxPfWcz
h5FFE/rYWurshmT9c5fK7Po8f1I32QaJoMRS6MKSE7dlnvakOG6j0S7KqDchvwlx
G6TNQIl0BUIMne6zk3YZwJV9eLjKcxrsEgpVRBEsYwtCyX1OtfC0JqLxMmu4f5Lw
czUmGOUYbXTNDpxJIKuuEMBohPW1gjaS6O5YzycWFp890Srs0nwIS1yIzml6+bf9
v+HqCizUCBM+vg6BwXy+gzzkoMEq6IHo7NS9D8QhrAU9VKXNMzLlSh+3WYNEpF1h
dzGRnjKrbQxzqWAA/uulVEo6Ak0WFy7KLkvgxF83mHRavjwCaVh8mEei6+4R5Xxp
9TIKgMNnuMk7GvNBKD83nT2uBxJ4NaDeCxRorULZoNIUKXXl2vpb74p1Z+KrFtj/
qTSIXTA/AzcNbgQIhVcgkXWPv12ENJ//Xen4+McuzJ/ngm/us61pasJ3q7vU+LIt
Ix/wwK94OkeelXAuTUMJ
=ut72
-----END PGP SIGNATURE-----

--X8oaj2qX3NXXvcHN--
