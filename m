Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7RFT9Y7000869
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2012 11:29:09 -0400
Date: Mon, 27 Aug 2012 17:28:43 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: Re: SELinux performance depending on type count
Message-ID: <20120827152843.GD2168@telvanni>
References: <20120807130244.GE2085@telvanni>
 <20120810213845.GQ2296@telvanni>
 <1344861329.25589.16.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
In-Reply-To: <1344861329.25589.16.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--bajzpZikUji1w+G9
Content-Type: multipart/mixed; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2012 at 08:35:29AM -0400, Stephen Smalley wrote:
> On Fri, 2012-08-10 at 23:38 +0200, Ole Kliemann wrote:
> > [...]
> >
> > $ runcon -l s0:c0.c9999
> >=20
> > Now I'm system_u:system_r:unconfined_t:s0:c0.c9999.
> > I rerun the script. Average walltime is about 39sec.
> >=20
> > Ouch! :-/
> >
> > [...]
>=20
> I wonder how much of that time is spent on the chcon calls (i.e.
> getxattr + setxattr) vs the actual accessing of the files.

I was away for some time, but in case you are still interested:

As can be seen with the attached script, the time it takes=20
accessing the files remains stable. Only creating and chcon'ing=20
files and dirs seems to be the problem.=20

So for all of my purposes I consider this a non-issue.

--c3bfwLpm8qysLVxt
Content-Type: application/x-sh
Content-Disposition: attachment; filename="x.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Att1=3D0 && tt2=3D0 &&=0Aruns=3D5 &&=0Afor k in $(seq $runs)=
=0Ado=0A	t1=3D$(time --format %e sh -c '( mkdir -p test &&=0A	for i in $(se=
q 0 999)=0A	do=0A			x=3D"$(uuidgen)" && test -n "$x" &&=0A			y=3D"$(uuidgen=
)" && test -n "$y" &&=0A			mkdir -p test/"$x" &&=0A			chcon -t unconfined_t=
 -l s0:c${i} test/"$x" &&=0A			dd if=3D/dev/urandom of=3Dtest/"$x"/"$y" bs=
=3D1K count=3D1 2>&1 >/dev/null &&=0A			chcon -t unconfined_t -l s0:c${i} t=
est/"$x"/"$y"=0A	done ) 1>/dev/null 2>/dev/null=0A	=0A	exit 0' 2>&1) &&=0A=
=0A	t2=3D$(time --format %e sh -c 'rgrep lol test 1>/dev/null 2>/dev/null; =
exit 0' 2>&1) &&=0A=0A	echo "run $k: walltime t1: $t1" &&=0A	tt1=3D$(echo "=
$tt1 + $t1" | bc -l) &&=0A=0A	echo "run $k: walltime t2: $t2" &&=0A	tt2=3D$=
(echo "$tt2 + $t2" | bc -l) &&=0A	=0A	rm -fr test=0A=0Adone &&=0A=0Aecho "t=
otal: walltime t1: $tt1" &&=0Att1=3D$(echo "$tt1 / $runs" | bc -l ) &&=0Aec=
ho "average: walltime t1: $tt1"=0A=0Aecho "total: walltime t2: $tt2" &&=0At=
t2=3D$(echo "$tt2 / $runs" | bc -l ) &&=0Aecho "average: walltime t2: $tt2"=
=0A
--c3bfwLpm8qysLVxt--

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlA7kisACgkQS1FjE303ERyXrACgiaEeI92YsQke9H6h76HUX3DC
OJsAnAwyiZte8WrdsPeMjVkvxkN480FP
=VhN8
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
