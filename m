Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2R0tYDo018019
	for <selinux@tycho.nsa.gov>; Sat, 26 Mar 2005 19:55:35 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2R0qOa7027500
	for <selinux@tycho.nsa.gov>; Sun, 27 Mar 2005 00:52:24 GMT
Subject: selinux-policy-targeted (1:1.22-2) available
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: ubuntu-hardened@lists.ubuntu.com
Cc: rcoker@redhat.com, dwalsh@redhat.com, selinux@tycho.nsa.gov,
   ubuntu-devel@lists.ubuntu.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U89u7pmNVTpX+EtecVGG"
Date: Sun, 27 Mar 2005 01:54:32 +0100
Message-Id: <1111884872.27644.228.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-U89u7pmNVTpX+EtecVGG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm (very) glad to announce the availability of the first targeted
policy package for Debian and more concretely Ubuntu Linux (this package
is Ubuntu-dependent because of the versions of logrotate, libselinux1,
etc, in which it relies, to be fixed when Debian consolidates userland
for SELinux support and accepts the patches).

The policy source itself has nothing to do Russell Coker's old
selinux-policy-default, but the package is based on his one, this mean,s
same configuration method.Of course it has been updated to complain with
the current Debian Policy (sigh) and some building errors have been
fixed (most notably are related with changes ported out of Fedora's
targeted policy specs).

I encourage all of those interested in SELinux deployment in Ubuntu
Linux (and subsequently, Debian) to check the package, report errors to
this list (we still don't have our bug reporting area like Hardened
Gentoo has within the Gentoo bugzilla, I hope to solve this soon with
the Ubuntu folks) or directly to me, make suggestions, send patches...

The http://www.ubuntulinux.org/wiki/SELinux wiki page has been updated
to reflect the changes.
The current percentage of work done amounts to 75%, if talking in basic
deployment terms, but we could talk about a percentage of 87.5% as
coreutils just need a fixed (and updated) Linux-PAM [1], among a few
fixes, currently available and provided with SELinux support, but has to
be reviewed by a Debian developer or an Ubuntu maintainer.

dpkg is left, thus, the targeted policy package still installs the
suboptimal selinux dpkg postinst script, being replace by Manoj's
changes when I get the clean diff for dpkg from him.

Among that, the configuration method needs to be reworked and I would
like to know who could take care of it, as I wouldn't have time for it.

Package available at:
http://pearls.tuxedo-es.org/selinux/ubuntu/selinux-policy-targeted/

[1]:
http://pearls.tuxedo-es.org/selinux/ubuntu/pam/

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-U89u7pmNVTpX+EtecVGG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCRgRIDcEopW8rLewRAvgjAKDhjIA7lmlSYuK6mPSkbnS65a89bwCgoJNa
sNL5J+BI5+cnpl1RBlXamq0=
=9MpL
-----END PGP SIGNATURE-----

--=-U89u7pmNVTpX+EtecVGG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
