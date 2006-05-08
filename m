Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48Md8NR000512
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 18:39:08 -0400
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48Md7EL029567
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 22:39:07 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 9 May 2006 00:39:06 +0200
Date: Tue, 9 May 2006 00:39:05 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: Valdis.Kletnieks@vt.edu, SE-Linux <selinux@tycho.nsa.gov>,
        viro@zeniv.linux.org.uk
Subject: Re: pam_namespace
Message-Id: <20060508223859.GA7479@thorium.jmh.mhn.de>
References: <200605051623.25533.russell@coker.com.au> <200605051006.k45A6vNK024699@turing-police.cc.vt.edu> <200605071928.22799.russell@coker.com.au> <200605081137.42066.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <200605081137.42066.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[CC'ing Al Viro because he surely knows this...]

* Russell Coker <russell@coker.com.au> [2006-05-08 05:23]:
> On Sunday 07 May 2006 19:28, Russell Coker <russell@coker.com.au> wrote:
> > Of course there's nothing stopping us from modifying a program such as
> > runuser or run_init to set up a namespace for a daemon. =C2=A0In fact w=
e should
> > probably make the default behavior of run_init and runuser be the creat=
ion
> > of a namespace. =C2=A0It would be easy to create a config file for runu=
ser that
> > allows excluding daemons on the basis of executable name, UID, or other
> > factors.
>=20
> One problem we have with separate name spaces is that when the administra=
tor=20
> mounts a file system the users won't see it.

I thought shared subtrees were invented to solve this problem?
I've read the documentation but never actually played with it, so I'd be
interested to hear if it doesn't work.

Thomas

> When the mount point has=20
> the "user" option in /etc/fstab that won't be such a problem, but for the=
=20
> more common cases of autofs and the automatic mounting we have in Fedora=
=20
> that's not going to work.
>=20
> As we want to provide as much protection as possible for as many users as=
=20
> possible it seems to me that for a typical targeted-policy system we woul=
d=20
> want to run daemons in their own name-space while leaving users in the sy=
stem=20
> name-space.  It would not be difficult to modify runuser such that it cou=
ld=20
> check for a domain_auto_trans() operation on launching a daemon (assuming=
=20
> that the runuser command in question runs the daemon directly instead of=
=20
> running a startup script) and then by default create a separate name spac=
e=20
> for every daemon that is confined in the targeted policy (which is probab=
ly a=20
> good list of daemons that may potentially become compromised and be used =
to=20
> attack users).
>=20
> Having such separate name-spaces for daemons that run as non-root allows=
=20
> protecting users from attack while avoiding the usability issues of=20
> namespaces for each user.  This is a good match the design philosophy of =
the=20
> targeted policy.
>=20
> For daemons such as xfs, we could have runuser set up a bind mount of the=
=20
> sub-directory of the /tmp directory that is used.  So /tmp/.font-unix cou=
ld=20
> be bind mounted into the name-space of the xfs daemon.  Incidentally at t=
he=20
> moment xfs is not started by runuser, so with my rough design outlined ab=
ove=20
> it would not get a separate name-space.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEX8iDD9qpeVMU938RAkFLAKCSVeJYFRyIzmYQ1sAg5Od6MvJbUwCdFPnB
WfSR9SJ2tD4CveaQ/Atu1dM=
=SuOI
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
