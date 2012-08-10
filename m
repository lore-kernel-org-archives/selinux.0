Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7ACBcZc024764
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 08:11:38 -0400
Date: Fri, 10 Aug 2012 14:11:13 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux performance depending on type count
Message-ID: <20120810121113.GE2296@telvanni>
References: <20120807130244.GE2085@telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
In-Reply-To: <20120807130244.GE2085@telvanni>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--6v9BRtpmy+umdQlo
Content-Type: multipart/mixed; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2012 at 03:02:44PM +0200, Ole Kliemann wrote:
> I read on some locations (Fedora FAQ...) that there is an overall=20
> performance impact of about 7% when running with SELinux.
>=20
> Does anyone know if this impact is dependent upon the number of=20
> types the policy has? I would assume no: A lot of types only take=20
> up memory and caching should prevent any impact on the runtime=20
> performance.
>=20
> But if there was a performance problem with a lot of types, at=20
> what number n would it start to hit hard? And how does it=20
> increase (linear, quadratic...)?
>=20
> And would it be better performance-wise to run a MCS-policy with=20
> say categories c0.cn than to have types c0_t, ... cn_t?
>=20
> Ole

I did some runtime test now. I have about 2000 types, 1000 of=20
them (named xIcJ_t, for 0 <=3D I <=3D 9, 0 <=3D J <=3D 99) each with his=20
own role (xIcJ_r) associated to a user_u. Then there is a user_r=20
and user_t for login. Additionally there is=20
system_u:system_r:root_t with full access to everything.

I run the attached script. It creates directories for each of the=20
1000 types, puts something in it, does a find/grep etc.

As system_u:system_r:root_t the script measures an average of=20
about 6sec walltime over 5 runs. (With very little variance.)

When I change context to user_u:user_r:user_t even things like=20
'ls' on home dir or 'id' lag consideribly the first time=20
executed. Just being in this context makes things slow. The=20
script measures an average of about 15sec walltime over 5 runs.=20

That's 2.5 times as much. Who thinks 7% is ridiculously high now?=20
;-)

While it's running the whole system sometimes lags even for just=20
writing on the terminal. top shows spikes of 50%+ CPU on kworker=20
threads.


Good side is: It's a clear result and kind of settles the=20
question. If you want a lot of different types for one user, go=20
for categories.


But I don't understand this result. Why isn't it slow when root=20
runs the script? He does the same relabeling to all those types.=20
It's not like user_u:user_r:user_t would be running in different=20
type concurrently. Just the fact that user_u is associated with=20
all those types seems to make it slow to run in any context=20
user_u:*

--3XA6nns4nE4KvaS/
Content-Type: application/x-sh
Content-Disposition: attachment; filename="x.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Ass=3D0 && mm=3D0 &&=0Aruns=3D5 &&=0Afor k in $(seq $runs)=0A=
do=0A	t=3D$(time --format %e sh -c 'mkdir -p test &&=0A	for i in $(seq -w 0=
 9)=0A	do=0A		for j in $(seq -w 0 99)=0A		do=0A			x=3D"$(uuidgen)" && test =
-n "$x" &&=0A			y=3D"$(uuidgen)" && test -n "$y" &&=0A			mkdir -p test/"$x"=
 &&=0A			chcon -t x${i}c${j}_t test/"$x" &&=0A			dd if=3D/dev/urandom of=3D=
test/"$x"/"$y" bs=3D1K count=3D1 2>&1 >/dev/null &&=0A			chcon -t x${i}c${j=
}_t test/"$x"/"$y"=0A		done=0A	done=0A	=0A	find test -print0 | xargs -0 gre=
p "lol"=0A	exit 0' 2>&1 >/dev/null)=0A=0A	s=3D$(echo "$t" | awk -F. '{print=
 $1}') &&=0A	echo "$s" &&=0A	m=3D$(echo "$t" | awk -F. '{print $2}') &&=0A	=
m=3D$(echo "$m" | sed 's/^0*//') &&=0A	echo "$m" &&=0A	ss=3D$(( $ss + $s ))=
 &&=0A	mm=3D$(( $mm + $m )) &&=0A	=0A	rm -fr test=0A=0Adone=0A=0At=3D$(( $m=
m / 100 )) &&=0At=3D$(( $t + $ss )) &&=0Aecho "$t" &&=0At=3D$(( $t / $runs =
)) &&=0Aecho "$t"=0A
--3XA6nns4nE4KvaS/--

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAk+mEACgkQS1FjE303ERxrqwCfQtry4ZZAmKOibOFlMQe7/h3T
YzwAn0JnB7Xz0yJBLUr7aVV1KTNwQlDz
=arDd
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
