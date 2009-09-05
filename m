Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n857FSVm011221
	for <selinux@tycho.nsa.gov>; Sat, 5 Sep 2009 03:15:28 -0400
Received: from mail.gmx.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n857GiW2021334
	for <selinux@tycho.nsa.gov>; Sat, 5 Sep 2009 07:16:45 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: can't login in enforcing mode for some reason.
Date: Sat, 5 Sep 2009 15:15:17 +0800
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <dd18b0c30909042230r3da58c1ay996b7f0fbac361d0@mail.gmail.com>
In-Reply-To: <dd18b0c30909042230r3da58c1ay996b7f0fbac361d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart21225424.Zy4paFSj0J";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200909051515.20822.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart21225424.Zy4paFSj0J
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Is that on a regular distro or on your custom compile?

If the latter: Which getty are you using? I had serious problems with agett=
y,=20
but could get around those by switching to mingetty.

Also I think there are two version of login, the one you're using may depen=
d=20
on the compile-order. I think one is in the shadow-package and one is in ut=
il-
linux-ng. For a reason that I don't remember I think I am now using the one=
 in=20
util-linux-ng.

> any ideas on why I'm hitting this:
>
>  type=3D1106 audit(1252128138.800:242): user pid=3D5022 uid=3D0 auid=3D10=
00
> ses=3D12 subj=3Dsystem_u:system_r:sysadm_t msg=3D'op=3DPAM:session_close
> acct=3D"name" exe=3D"/bin/login" hostname=3D? addr=3D? terminal=3D/dev/tt=
y1
> res=3Dsuccess'
> [ 4110.457610] type=3D1100 audit(1252128145.452:243): user pid=3D5468
> uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:sysad=
m_t
> msg=3D'op=3DPAM:authentication acct=3D"name" exe=3D"/bin/login" hostname=
=3D?
> addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
> [ 4110.460426] type=3D1101 audit(1252128145.452:244): user pid=3D5468
> uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:sysad=
m_t
> msg=3D'op=3DPAM:accounting acct=3D"name" exe=3D"/bin/login" hostname=3D? =
addr=3D?
> terminal=3D/dev/tty1 res=3Dsuccess'
> [ 4110.461260] type=3D1006 audit(1252128145.452:245): login pid=3D5468
> uid=3D0 old auid=3D4294967295 new auid=3D1000 old ses=3D4294967295 new se=
s=3D13
> [ 4110.473666] type=3D2300 audit(1252128145.472:246): user pid=3D5468
> uid=3D0 auid=3D1000 ses=3D13 subj=3Dsystem_u:system_r:sysadm_t msg=3D'pam:
> default-context=3Dname:sysadm_r:sysadm_t
> selected-context=3Dname:sysadm_r:sysadm_t: exe=3D"/bin/login" hostname=3D?
> addr=3D? terminal=3Dtty1 res=3Dsuccess'
> [ 4110.473824] type=3D1105 audit(1252128145.472:247): user pid=3D5468
> uid=3D0 auid=3D1000 ses=3D13 subj=3Dsystem_u:system_r:sysadm_t
> msg=3D'op=3DPAM:session_open acct=3D"name" exe=3D"/bin/login" hostname=3D?
> addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
> [ 4110.474729] type=3D1103 audit(1252128145.472:248): user pid=3D5468
> uid=3D0 auid=3D1000 ses=3D13 subj=3Dsystem_u:system_r:sysadm_t
> msg=3D'op=3DPAM:setcred acct=3D"name" exe=3D"/bin/login" hostname=3D? add=
r=3D?
> terminal=3D/dev/tty1 res=3Dsuccess'
> [ 4110.474792] type=3D1112 audit(1252128145.472:249): user pid=3D5468
> uid=3D0 auid=3D1000 ses=3D13 subj=3Dsystem_u:system_r:sysadm_t msg=3D'op=
=3Dlogin
> acct=3D"name" exe=3D"/bin/login" hostname=3D? addr=3D? terminal=3D/dev/tt=
y1
> res=3Dsuccess'
> [ 4110.475448] type=3D1400 audit(1252128145.472:250): avc:  denied  {
> transition } for  pid=3D5475 comm=3D"login" path=3D"/bin/bash" dev=3Dsda3
> ino=3D204858 scontext=3Dsystem_u:system_r:sysadm_t
> tcontext=3Dname:sysadm_r:sysadm_t tclass=3Dprocess
> [ 4110.476010] type=3D1400 audit(1252128145.472:250): avc:  denied  {
> rlimitinh } for  pid=3D5475 comm=3D"bash"
> scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Dname:sysadm_r:sysadm_t
> tclass=3Dprocess
> [ 4110.476026] type=3D1400 audit(1252128145.472:250): avc:  denied  {
> siginh } for  pid=3D5475 comm=3D"bash" scontext=3Dsystem_u:system_r:sysad=
m_t
> tcontext=3Dname:sysadm_r:sysadm_t tclass=3Dprocess
> [ 4110.476048] type=3D1400 audit(1252128145.472:250): avc:  denied  {
> noatsecure } for  pid=3D5475 comm=3D"bash"
> scontext=3Dsystem_u:system_r:sysadm_t tcontext=3Dname:sysadm_r:sysadm_t
> tclass=3Dprocess
> [ 4110.476096] type=3D1300 audit(1252128145.472:250): arch=3Dc000003e
> syscall=3D59 success=3Dyes exit=3D0 a0=3D616760 a1=3D7fffce1af800 a2=3D60=
a060 a3=3D0
> items=3D0 ppid=3D5468 pid=3D5475 auid=3D1000 uid=3D1000 gid=3D1000 euid=
=3D1000
> suid=3D1000 fsuid=3D1000 egid=3D1000 sgid=3D1000 fsgid=3D1000 tty=3Dtty1 =
ses=3D13
> comm=3D"bash" exe=3D"/bin/bash" subj=3Dname:sysadm_r:sysadm_t key=3D(null)
>
>
> audit2allow shows this:
> allow sysadm_t self:process { siginh rlimitinh transition noatsecure };
>
> seems I had these three avc's fixed by removing securetty
> but for some reason these appeared again.
>
> any ideas would be helpful.

--nextPart21225424.Zy4paFSj0J
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkqiEAgACgkQ1sXw8/2VziRn9ACfYkNk/zhPX2jwBQImCumu9Jxd
D6gAnjs/9ZKAb0H+N8pK2SnNniAybrZW
=uK/n
-----END PGP SIGNATURE-----

--nextPart21225424.Zy4paFSj0J--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
