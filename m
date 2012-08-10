Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7AFjFLG006756
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 11:45:20 -0400
Date: Fri, 10 Aug 2012 17:44:54 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: Re: SELinux performance depending on type count
Message-ID: <20120810154454.GH2296@telvanni>
References: <20120807130244.GE2085@telvanni>
 <20120810121113.GE2296@telvanni>
 <1344603615.10631.26.camel@moss-pluto.epoch.ncsc.mil>
 <20120810143656.GF2296@telvanni>
 <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
In-Reply-To: <1344611147.10631.65.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

PS: Have you actually reproduced this problem? Could still be=20
something else broken on my system...

On Fri, Aug 10, 2012 at 11:05:47AM -0400, Stephen Smalley wrote:
> On Fri, 2012-08-10 at 16:36 +0200, Ole Kliemann wrote:
> > On Fri, Aug 10, 2012 at 09:00:15AM -0400, Stephen Smalley wrote:
> > > On Fri, 2012-08-10 at 14:11 +0200, Ole Kliemann wrote:
> > > > I did some runtime test now. I have about 2000 types, 1000 of=20
> > > > them (named xIcJ_t, for 0 <=3D I <=3D 9, 0 <=3D J <=3D 99) each wit=
h his=20
> > > > own role (xIcJ_r) associated to a user_u. Then there is a user_r=20
> > > > and user_t for login. Additionally there is=20
> > > > system_u:system_r:root_t with full access to everything.
> > > >=20
> > > > I run the attached script. It creates directories for each of the=
=20
> > > > 1000 types, puts something in it, does a find/grep etc.
> > > >=20
> > > > As system_u:system_r:root_t the script measures an average of=20
> > > > about 6sec walltime over 5 runs. (With very little variance.)
> > > >=20
> > > > When I change context to user_u:user_r:user_t even things like=20
> > > > 'ls' on home dir or 'id' lag consideribly the first time=20
> > > > executed. Just being in this context makes things slow. The=20
> > > > script measures an average of about 15sec walltime over 5 runs.=20
> > > >=20
> > > > That's 2.5 times as much. Who thinks 7% is ridiculously high now?=
=20
> > > > ;-)
> > > >=20
> > > > While it's running the whole system sometimes lags even for just=20
> > > > writing on the terminal. top shows spikes of 50%+ CPU on kworker=20
> > > > threads.
> > > >=20
> > > >=20
> > > > Good side is: It's a clear result and kind of settles the=20
> > > > question. If you want a lot of different types for one user, go=20
> > > > for categories.
> > > >=20
> > > >=20
> > > > But I don't understand this result. Why isn't it slow when root=20
> > > > runs the script? He does the same relabeling to all those types.=20
> > > > It's not like user_u:user_r:user_t would be running in different=20
> > > > type concurrently. Just the fact that user_u is associated with=20
> > > > all those types seems to make it slow to run in any context=20
> > > > user_u:*
> > >=20
> > > Your result doesn't sound right.  Wondering whether you are triggering
> > > masses of AVC denials (which could then peg syslog or audit) when
> > > running your script?
> >=20
> > Checked that of course. dmesg showed nothing or just occasional=20
> > denials. Just tryed again giving user_t full access to=20
> > everything. Changes nothing and dmesg is clear.=20
> >=20
> > Anyway turns out above I forgot to mention something that=20
> > actually is the core of the problem:
> >=20
> > I build a minimal example which is attached. Of course you have=20
> > at modify it to your policy.=20
> >=20
> > Basicly there is one role choke_r with one type choke_t und a=20
> > user choke_u with role choke_r. Then are 1000 other types in the=20
> > choke role each with a corresponding attribute.
> >=20
> > This alone isn't a problem. But if each of these attributes get=20
> > attributed to choke_t, the slowdown starts. Not as bad as=20
> > mentioned above but still significantly. (10sec in the test=20
> > above.)
> >=20
> > So we have choke_u:choke_r:choke_t. Although all other types are=20
> > in choke_r, that alone causes nothing. But as soon as there are
> > these 1000 attributes on choke_t the fun starts. Actually you=20
> > don't even need the 1000 types. Just 1000 attributes on one type=20
> > produces a measurable slowdown (7sec) and lags. Having 1000 types=20
> > beside just makes it a lot worse. But there absolutely no=20
> > slowdown with just 1000 types and no attributes.
>=20
> Interesting.  We would expect some slowdown on an AVC cache miss in that
> situation, although the amount seems troubling.  Things to consider:
> - Does the AVC cache need to be increased or otherwise tuned?  You can
> see some information via the avcstat utility or by directly looking
> at /sys/fs/selinux/avc.
>=20
> - Does security_compute_av(), which is called on a cache miss, need some
> profiling and tuning?  Particularly the logic within
> context_struct_compute_av(), where we are iterating through the type
> attribute ebitmaps.
>=20
> In Fedora 17, most types only have a few attributes (as shown by seinfo
> -t -x).  unconfined_t has a larger number of attributes than most, but
> even it only has 46 attributes.  So we likely don't see this behavior
> there.
>=20
> --=20
> Stephen Smalley
> National Security Agency

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAlLHYACgkQS1FjE303ERwLxgCcC/q6YKChKBLwaGO4zzeGZ34B
zOsAoIYW9iDKRdUItzLOwKyGdB3THFnO
=WRAI
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
