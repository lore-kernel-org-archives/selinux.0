Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m17NEoTE019329
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 18:14:50 -0500
Received: from penguin.goodinassociates.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m17NEnu0024321
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 23:14:49 GMT
Received: from [206.80.71.242] ([206.80.71.242])
	(authenticated bits=0)
	by penguin.goodinassociates.com (8.13.1/8.13.1) with ESMTP id m17NEo1A025220
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 17:14:50 -0600
Subject: new user types
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dOor4sUT3tUHsA56YrPY"
Date: Thu, 07 Feb 2008 17:14:48 -0600
Message-Id: <1202426088.2801.500.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-dOor4sUT3tUHsA56YrPY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I can't seem to login as the right user, and I'm not sure what I missed.

I added the following roles and users to my monetra.te file:


#admin roles
role monetra_admin_r types monetra_t;
role monetra_admin_r types monetra_lib_t;

#client roles
role monetra_client_r types monetra_t;
role monetra_client_r types monetra_lib_t;
role monetra_client_r types monetra_client_t;

#monetra users
user monetra_u roles { monetra_client_r monetra_admin_r } level s0 range s0=
 - s0;




I ran the add login command:
semanage login -a -s monetra_u bob



I get the following output:
[root@xxx ~]# semanage login -l

Login Name                SELinux User              MLS/MCS Range          =
 =20

__default__               user_u                    s0                     =
 =20
root                      root                      s0-s0:c0.c255          =
 =20
system_u                  system_u                  s0-s0:c0.c255          =
 =20
bob                      monetra_u                 s0                      =
=20

[root@xxx ~]# semanage user -l

                Labeling   MLS/       MLS/                         =20
SELinux User    Prefix     MCS Level  MCS Range                      SELinu=
x Roles


monetra_u       user       s0         s0                             monetr=
a_admin_r monetra_client_r
root            sysadm     s0         s0-s0:c0.c255                  sysadm=
_r staff_r
staff_u         staff      s0         s0-s0:c0.c255                  sysadm=
_r staff_r
sysadm_u        sysadm     s0         s0-s0:c0.c255                  sysadm=
_r
system_u        user       s0         s0-s0:c0.c255                  system=
_r
unconfined_u    unconfined s0         s0-s0:c0.c255                  unconf=
ined_r
user_u          user       s0         s0                             user_r

yet when I login I get:
[bob@xxx ~]$ id -Z
system_u:system_r:unconfined_t:s0-s0:c0.c255


thanx for any help you can give.



--=-dOor4sUT3tUHsA56YrPY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD4DBQBHq5Do6caZY8jbHDkRAuyAAJjO4UQIGW0NBci+d+IntJDyW5b8AJ4llJpO
XCdAXqhe1skWwmQRW9u00w==
=/z33
-----END PGP SIGNATURE-----

--=-dOor4sUT3tUHsA56YrPY--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
