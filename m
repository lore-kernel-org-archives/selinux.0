Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1J1lp4X018899
 for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2015 20:47:52 -0500
Received: from tracyreed.org (wsip-98-175-106-200.sd.sd.cox.net
 [98.175.106.200])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.copilotco.com (Postfix) with ESMTP id 6CB3964C81
 for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2015 17:47:47 -0800 (PST)
Date: Wed, 18 Feb 2015 17:48:04 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: MCS error
Message-ID: <20150219014803.GB12937@tracyreed.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uLm21ivgZj9Xvi41"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--uLm21ivgZj9Xvi41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

I am implementing Multi-Category Security for a client to contain various
different instances of their web application which all run on the same box.
This sort of multi-tenant operation seems like a perfect fit for MCS.

I am using the following guide as a basis for getting started:

https://www.centos.org/docs/5/html/Deployment_Guide-en-US/sec-mcs-getstarte=
d.html

However, I am actually running CentOS 6. I can't seem to find a CentOS 6
version of this guide.

When I try to add the category to the user I get this error:

[mcstest:/root]# chcat -l -- +user1 user1
libsemanage.validate_handler: MLS range s0-s0:c1 for Unix user user1 exceed=
s allowed range s0 for SELinux user user_u (No such file or directory).
libsemanage.validate_handler: seuser mapping [user1 -> (user_u, s0-s0:c1)] =
is invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No such fi=
le or directory).
/usr/sbin/semanage: Could not commit semanage transaction

Here's some relevant config info:

[mcstest:/root]# chcat -L=20
s0:c1                          user1
s0:c2                          user2
s0:c3                          user3
s0                             SystemLow
s0-s0:c0.c1023                 SystemLow-SystemHigh
s0:c0.c1023                    SystemHigh


[mcstest:/root]# semanage user -l=20

Labeling   MLS/       MLS/                         =20
SELinux User    Prefix     MCS Level  MCS Range                      SELinu=
x Roles

git_shell_u     user       SystemLow  SystemLow                      git_sh=
ell_r
guest_u         user       SystemLow  SystemLow                      guest_r
root            user       SystemLow  SystemLow-SystemHigh           staff_=
r sysadm_r system_r unconfined_r
staff_u         user       SystemLow  SystemLow-SystemHigh           staff_=
r sysadm_r system_r unconfined_r
sysadm_u        user       SystemLow  SystemLow-SystemHigh           sysadm=
_r
system_u        user       SystemLow  SystemLow-SystemHigh           system=
_r unconfined_r
unconfined_u    user       SystemLow  SystemLow-SystemHigh           system=
_r unconfined_r
user_u          user       SystemLow  SystemLow                      user_r
xguest_u        user       SystemLow  SystemLow                      xguest=
_r

I notice that the MCS Range for user_u is only SystemLow. In the documentat=
ion
referenced above the output of this command shows user_u as:

user_u                  user           s0                      s0-s0:c0.c10=
23    system_r sysadm_r user_r

so the MCS range is s0-s0:c0.c1023. This seems to be what is missing in my
setup. But I don't understand how to allow that MCS Range for user_u.

Any pointers are greatly appreciated. Thanks!

--=20
Tracy Reed

--uLm21ivgZj9Xvi41
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFU5UDTBhSTPg0d/nQRAsk/AKC8JTh06et1z/tPLeaYHsS3xaeljQCgi9HB
azXexqOr9wuqOZJM/2QXbwo=
=pIy+
-----END PGP SIGNATURE-----

--uLm21ivgZj9Xvi41--
