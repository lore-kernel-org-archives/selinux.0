Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25AL3Oi002111
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 05:21:03 -0500
Received: from atlantic.devin.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m25AL2UA017091
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 10:21:02 GMT
Date: Wed, 5 Mar 2008 02:20:59 -0800
From: Devin Carraway <selinux-list@devin.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [patch] refpolicy: exim policy fixes
Message-ID: <20080305102059.GB32119@atlantic.devin.com>
References: <20080220100058.GG5439@atlantic.devin.com> <1204654580.14217.12.camel@gorn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
In-Reply-To: <1204654580.14217.12.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2008 at 01:16:20PM -0500, Christopher J. PeBenito wrote:
> On Wed, 2008-02-20 at 02:00 -0800, Devin Carraway wrote:
> > Here are a handful of localized fixes to the Exim policy, based on SVN
> > head refpolicy and Debian Sid:
>=20
> Merged with two exceptions.

These look good.  Tested successfully from svn trunk.


> > - grant readonly access to var_lib_t, to read runtime-generated conf
>=20
> This seems questionable.  It sounds like there should be a specific type
> for this.

Agreed; I had a discrete type and entrypoints for the runtime config
generators in my original exim policy submission a few months ago, but that
wans't among the bits that got merged.  I can resubmit that portion as a
discrete patch.  I'm still trying to determine, though, whether the runtime
config is necessary outside of Debian/Ubuntu.


> >  corenet_tcp_sendrecv_all_if(exim_t)
> >  corenet_tcp_sendrecv_all_nodes(exim_t)
> >  corenet_tcp_sendrecv_all_ports(exim_t)
> > +corenet_tcp_sendrecv_smtp_port(exim_t)
> > +corenet_tcp_sendrecv_auth_port(exim_t)
> > +corenet_tcp_sendrecv_ldap_port(exim_t)
>=20
> This is redundant since it can already sendrecv all ports.

Hm, okay.  My own testing had suggested all_ports was actually acting like
all-nonpriveleged-ports, but now that I recheck I can't verify the behavior,
and current svn trunk can make & use outbound SMTP just fine.

Thanks.

--=20
Devin  \ aqua(at)devin.com, IRC:Requiem; http://www.devin.com
Carraway \ 1024D/E9ABFCD2: 13E7 199E DD1E 65F0 8905 2E43 5395 CA0D E9AB FCD2

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHznQLU5XKDemr/NIRAuMUAKC/NFTlMKC0ofSyLxjieI4gZiXqegCfZDUf
Y3gI2r9zbcbWS1Ewi2hsvRo=
=qtMa
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
