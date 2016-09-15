Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8FE1V15018328
 for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2016 10:01:31 -0400
Received: by mail-lf0-f48.google.com with SMTP id u14so38103653lfd.1
 for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2016 07:01:06 -0700 (PDT)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id r8sm3641920wjs.22.2016.09.15.07.01.03
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Sep 2016 07:01:03 -0700 (PDT)
Subject: Re: NFSv4.2 unlabeled_t on mountpoints
To: selinux@tycho.nsa.gov
References: <20160915071522.GA6893@meriadoc.perfinion.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <21f1b111-aad4-ac20-445f-5e0a49996549@gmail.com>
Date: Thu, 15 Sep 2016 16:00:50 +0200
MIME-Version: 1.0
In-Reply-To: <20160915071522.GA6893@meriadoc.perfinion.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R3UhbaxJNGU3PkegjAnULJwDKSN73ejxs"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R3UhbaxJNGU3PkegjAnULJwDKSN73ejxs
Content-Type: multipart/mixed; boundary="XPRS1GPIqlr5vFjaF6o8fQKrMUiMWBwlU"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <21f1b111-aad4-ac20-445f-5e0a49996549@gmail.com>
Subject: Re: NFSv4.2 unlabeled_t on mountpoints
References: <20160915071522.GA6893@meriadoc.perfinion.com>
In-Reply-To: <20160915071522.GA6893@meriadoc.perfinion.com>

--XPRS1GPIqlr5vFjaF6o8fQKrMUiMWBwlU
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Have you looked at this (might be outdated):

http://selinuxproject.org/page/Labeled_NFS

On 09/15/2016 09:15 AM, Jason Zaman wrote:
> Hi All,
>=20
> I have kerberized NFSv4 between my laptop and server and when I use
> vers=3D4.2 I cannot access the mount. It looks like the fcontext needs =
to
> be invalidated or re-checked or something but I'm not familiar with
> kernel internals so not sure how to fix it (If someone can point me to
> the place, I'd love to get my hands dirty).
>=20
> Steps to repro:
> kinit works fine
> mount /home/jason/bregalad works fine, the fstab line is:
> bregalad.perfinion.com:/jason /home/jason/bregalad nfs4 noauto,users,ve=
rs=3D4.2,sec=3Dkrb5p,rw,intr,soft,timeo=3D100,_netdev,fsc 0 0
>=20
> Once mounted as my normal user:
> $ ls -aldZ /home/jason/bregalad
> ls: cannot access /home/jason/bregalad: Permission denied
>=20
> I get the following denial:
> type=3DAVC msg=3Daudit(1473923050.591:1577): avc:  denied  { getattr } =
for  pid=3D7630 comm=3D"ls" path=3D"/home/jason/bregalad" dev=3D"0:55" in=
o=3D4 scontext=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023 tcontext=3Dsystem=
_u:object_r:unlabeled_t:s0 tclass=3Ddir permissive=3D0
> type=3DSYSCALL msg=3Daudit(1473923050.591:1577): arch=3Dc000003e syscal=
l=3D6 success=3Dno exit=3D-13 a0=3D399b2bc22f2 a1=3D7a03d6e960 a2=3D7a03d=
6e960 a3=3D7a02aa8d7b items=3D1 ppid=3D6440 pid=3D7630 auid=3D1000 uid=3D=
1000 gid=3D100 euid=3D1000 suid=3D1000 fsuid=3D1000 egid=3D100 sgid=3D100=
 fsgid=3D100 tty=3Dpts3 ses=3D5 comm=3D"ls" exe=3D"/bin/ls" subj=3Dstaff_=
u:staff_r:staff_t:s0-s0:c0.c1023 key=3D(null)
> type=3DCWD msg=3Daudit(1473923050.591:1577):  cwd=3D"/home/jason"
> type=3DPATH msg=3Daudit(1473923050.591:1577): item=3D0 name=3D"/home/ja=
son/bregalad" inode=3D4 dev=3D00:37 mode=3D040711 ouid=3D1000 ogid=3D100 =
rdev=3D00:00 obj=3Dsystem_u:object_r:unlabeled_t:s0 nametype=3DNORMAL
> type=3DPROCTITLE msg=3Daudit(1473923050.591:1577): proctitle=3D6C73002D=
46002D2D636F6C6F723D6175746F002D616C645A002F686F6D652F6A61736F6E2F6272656=
7616C6164
>=20
> If I ls with sysadm_t (which has permissions for unlabeled_t) then the
> fcontext swaps to what it should be and everything works after that as
> staff_t too. I have not had issues with other dirs/files inside the NFS=

> mount, only the mountpoint has this issue.=20
>=20
> As root / sysadm_t: # ls -aldZ /home/jason/bregalad
> drwx--x--x. 50 jason users staff_u:object_r:user_home_dir_t:s0 84 Sep 1=
3 22:38 /home/jason/bregalad/
> As jason / staff_t: $ ls -aldZ /home/jason/bregalad
> drwx--x--x. 50 jason users staff_u:object_r:user_home_dir_t:s0 84 Sep 1=
3 22:38 /home/jason/bregalad/
>=20
> $ uname -a
> Linux meriadoc 4.7.2-hardened-r1 #1 SMP PREEMPT Sat Sep 3 11:27:29 SGT =
2016 x86_64 Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz GenuineIntel GNU/Lin=
ux
> I'm on gentoo hardened but dont think GRSec is responsible here. I also=
 had the same problem back on 4.4.
>=20
> Is there anything else that can help track this down?
> -- Jason
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--XPRS1GPIqlr5vFjaF6o8fQKrMUiMWBwlU--

--R3UhbaxJNGU3PkegjAnULJwDKSN73ejxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX2qmaAAoJECV0jlU3+UdpJ2IL/iG+DP+Loo3D1qWd8jIfwHcu
+xEfmX9IfVryYH9ZFUoQYVsqZ1Yd9IlJUeZUmPCzF1SzPZ1sHOJqHbRzoZmm50B8
gLI7yY0udud/xtNXS8cC6qKzD2yZTLcvY/k4iLZfU/FXpcYe+H/bdFdnv71fU+ls
4Kvw+M4omNMQNYgI+vf2fZFE62uXF3ML4MlO5diaZxkVwNSH2VBVYs9IV4sRBBXh
VvZkvDDP2VpyMTHnZsQO9mgO2Xetrs65ZkYXx9u5G3guRJJMS1GEwA9a484Zluxg
OSU8yTQ2uAzBZSwQyvxBtDyp2pGr0BJwc5sViWAIONKYn44dbMDzfNwJJjqkjnty
zziopH3GA5OzAjfZn1NA6Adzq0YhXQ3F/tfrE5oCosu8O7lpq2ADVi2RGAvopBHR
cmB1HodY/BxT16cioiIJaDJ4NmwqCkCtVIsLBmV7mOIpp2EszSAKbrEl6OOkCdyz
X36mTYRJOI2RJdh2uTz1EJzy38Vo5TNh3YlCGVJD+Q==
=dxtK
-----END PGP SIGNATURE-----

--R3UhbaxJNGU3PkegjAnULJwDKSN73ejxs--
