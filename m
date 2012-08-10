Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7AIkw4F018864
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 14:46:58 -0400
Date: Fri, 10 Aug 2012 20:46:53 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: Re: SELinux performance depending on type count
Message-ID: <20120810184653.GK2296@telvanni>
References: <20120807130244.GE2085@telvanni>
 <20120810121113.GE2296@telvanni>
 <1344603615.10631.26.camel@moss-pluto.epoch.ncsc.mil>
 <20120810143656.GF2296@telvanni>
 <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
 <20120810154454.GH2296@telvanni>
 <1344614902.10631.70.camel@moss-pluto.epoch.ncsc.mil>
 <1344615485.10631.72.camel@moss-pluto.epoch.ncsc.mil>
 <20120810170008.GI2296@telvanni>
 <1344622106.10631.75.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9kDAZ2EyO0AcRYa"
In-Reply-To: <1344622106.10631.75.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--s9kDAZ2EyO0AcRYa
Content-Type: multipart/mixed; boundary="kK1uqZGE6pgsGNyR"
Content-Disposition: inline


--kK1uqZGE6pgsGNyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2012 at 02:08:26PM -0400, Stephen Smalley wrote:
> On Fri, 2012-08-10 at 19:00 +0200, Ole Kliemann wrote:
> > I don't have an auditd, not running mcstransd and also had=20
> > disabled restorecond.
> >=20
> > I take it, /sys/fs/selinux is equivalent to /selinux?
>=20
> Yes.  /selinux moved to /sys/fs/selinux in more modern distro versions.
>=20
> > /sys/fs/selinux is empty on both my Ubuntu systems.
> >=20
> > /selinux/policyver in 26 as is the suffix of the policy file.
> >=20
> > Complete policy is attached. choke/src/support/choke.spt can be tuned=
=20
> > to suck even more. Do 'make load' in choke/src/ and you are good=20
> > to go.
>=20
> Ok, loaded.  Now what exactly are you doing to test it?

$ runcon choke_u:choke_r:choke_t ksh -l
$ id

Then witness the lag.

If you want hard numbers, use the attached script. First start=20
off in system_r:unconfined_r:unconfined_t. Run the script=20
somewhere, /tmp e.g. For proper average value computation you=20
need 'bc' installed, otherwise it's rounded but doesn't matter.

Then switch to choke_u:choke_r:choke_t. Run the script here. If=20
it's inconclusive, start uncommenting additional attributes in=20
choke/src/support/choke.spt.

--kK1uqZGE6pgsGNyR
Content-Type: application/x-sh
Content-Disposition: attachment; filename="x.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Ass=3D0 && mm=3D0 &&=0Aruns=3D5 &&=0Afor k in $(seq $runs)=0A=
do=0A	t=3D$(time --format %e sh -c 'mkdir -p test &&=0A	for i in $(seq -w 0=
 9)=0A	do=0A		for j in $(seq -w 0 99)=0A		do=0A			x=3D"$(uuidgen)" && test =
-n "$x" &&=0A			y=3D"$(uuidgen)" && test -n "$y" &&=0A			mkdir -p test/"$x"=
 &&=0A			chcon -t choke${i}c${j}_t test/"$x" &&=0A			dd if=3D/dev/urandom o=
f=3Dtest/"$x"/"$y" bs=3D1K count=3D1 2>&1 >/dev/null &&=0A			chcon -t choke=
${i}c${j}_t test/"$x"/"$y"=0A		done=0A	done=0A	=0A	find test -print0 | xarg=
s -0 grep "lol"=0A	exit 0' 2>&1 >/dev/null)=0A=0A	echo "run $k: walltime: $=
t" &&=0A	s=3D$(echo "$t" | awk -F. '{print $1}') &&=0A	m=3D$(echo "$t" | aw=
k -F. '{print $2}') &&=0A	{ test "$m" =3D "00" || {=0A		m=3D$(echo "$m" | s=
ed 's/^0*//') &&=0A		mm=3D$(( $mm + $m ))=0A	}; }  &&=0A	ss=3D$(( $ss + $s =
)) &&=0A	=0A	rm -fr test=0A=0Adone &&=0A=0At=3D$(( $mm / 100 )) &&=0At=3D$(=
( $t + $ss )) &&=0Aecho "total: walltime: ~=3D$t" &&=0A{ { which bc 2>&1 >/=
dev/null &&=0A	t=3D$(echo "$mm / 100" | bc -l ) &&=0A	t=3D$(echo "$t + $ss"=
 | bc -l ) &&=0A	t=3D$(echo "$t / $runs" | bc -l ) &&=0A	echo "average: wal=
ltime: $t"=0A} || {=0A	t=3D$(( $t / $runs )) &&=0A	echo "average: walltime:=
 ~=3D$t"=0A}; }=0A
--kK1uqZGE6pgsGNyR--

--s9kDAZ2EyO0AcRYa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAlVx0ACgkQS1FjE303ERxangCfWcgghBLi1+wp0Z45NY8dex31
OZQAn2y/iMK3kw7zE50bI+ypCv6u99XN
=cS+1
-----END PGP SIGNATURE-----

--s9kDAZ2EyO0AcRYa--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
