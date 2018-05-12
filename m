Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4CCroR6023170
 for <selinux@tycho.nsa.gov>; Sat, 12 May 2018 08:53:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 40jn2h1p8HzrKYF
 for <selinux@tycho.nsa.gov>; Sat, 12 May 2018 12:53:48 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 40jn2f5DGxzrKYC
 for <selinux@tycho.nsa.gov>; Sat, 12 May 2018 12:53:46 +0000 (UTC)
Message-ID: <1526129620.28749.19.camel@cepl.eu>
From: =?UTF-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>
To: selinux-devel@alioth-lists.debian.net, selinux@lists.fedoraproject.org,
 selinux@tycho.nsa.gov
Date: Sat, 12 May 2018 14:53:40 +0200
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-fbJ4q7CQnXoCDHd8ekIY"
Mime-Version: 1.0
Subject: Packaging policycoreutils for OpenSUSE
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--=-fbJ4q7CQnXoCDHd8ekIY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am changing jobs (Red Hat -> SUSE; R&D, but not a security
related job), and although I will be switching my workstation to
OpenSUSE, I would love to keep SELinux working. Which meant I had
to dig into the current situation of SELinux and it is =E2=80=A6 not
good. So, I started to repackage all SELinux packages 2.7 for
OpenSUSE in my home build area
https://build.opensuse.org/project/show/home:mcepl:SELinux
. So,far I have packaged successfully packages for libselinux,
libselinux-bindings, checkpolicy, libsemanage, libsepol, and
python-semanage. Mostly I use original OpenSUSE packages for 2.6,
but if needed I seek inspiration in Fedora packages.

Unfortunately, I have trouble to package policycoreutils. First
of all, I don=E2=80=99t understand what=E2=80=99s the difference between tw=
o
upstream tarballs for it:
https://github.com/SELinuxProject/selinux/archive/policycoreutils
-2.7.tar.gz
(linked from https://github.com/SELinuxProject/selinux/releases)
and
https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/fil
es/releases/20170804/policycoreutils-2.7.tar.gz
(linked from
https://github.com/SELinuxProject/selinux/wiki/Releases). What=E2=80=99s
the point of confusing users with two different tarballs of the
same name?

Second, I don=E2=80=99t understand the behavior of the installation
scripts. Looking at https://is.gd/MivaE1 , why in the world that
installation scripts tons of stuff which is not part of
policycoreutils? Could anybody help me to get through this
obstacle, please?

Thank you for any suggestions,

Mat=C4=9Bj

--=C2=A0
https://matej.ceplovi.cz/blog/, Jabber: mcepl@ceplovi.cz
GPG Finger: 3C76 A027 CA45 AD70 98B5=C2=A0=C2=A0BC1D 7920 5802 880B C9D8
=C2=A0
A GOOD name is rather to be chosen than great riches.
=C2=A0=C2=A0=C2=A0-- Proverbs 22:1

--=-fbJ4q7CQnXoCDHd8ekIY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJa9uPXAAoJEHkgWAKIC8nYYBMQALLnXNXS/7Yb/TxRgngn/h8Q
X03/ElSD96Ayu/P1tboBUQ0o3KZDvLAXBlsYx7yifkzNOk1aFMZQI7/FkK4OmeR8
CevxNXQsc3F4K/1LkjxZ8B1jPabFbeyuU0jaxa4/L1+xjQjPbPEOnUx4j3Dh/o/K
fMm+O5sevQ0aSxf27pkOix31wCOnsryRyuwoW7vZHvguuZQuBghCfiY0gRgXl89C
M5gQs2Q0AtO31vlzgC8Va3IGM/EP+Nz8cONjXWgSwJbVZ4SxfeVZTWG/Rmob/g6d
krzWuCFtyRnvVNAaARz1fzl51THh0VMOzBjoQFnJNU/U1XPaRjBuE/FRNdydqaWG
BJ7VW1xfb0wGA78xRciIAbIwPY7Kog+012yvYvtuzsx/PpwC+o2EP/aMZk4B82me
MBBGmiPAS6D2AwPLCf9dkm2Rxkjqh52r9X/rlX32R8U/N59/uesyEqOCvmzpDBGa
d52ZK0kM1wbrXuzvn3wsubZGvSHRH7cp4ips776OPu6L6HskjjE9/lVbpbiz/a8O
hVicWEdIGgEY0gKThdQE6uluBORfga5jwo4XFeXyKvXmRuUuXqSkX4cQKzWY9CaO
V+R3z66pTUv1gXK8k3oHoPwrsN09yWgbYTZzVXgt0aL+rruhlzA7ydUQPaIA6YFK
Yz5OoGcOs3mxJCL6PQG1
=VQXv
-----END PGP SIGNATURE-----

--=-fbJ4q7CQnXoCDHd8ekIY--
