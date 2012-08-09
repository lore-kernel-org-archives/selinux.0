Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q79BvTvN016408
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2012 07:57:29 -0400
Date: Thu, 9 Aug 2012 13:56:58 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Adam Tkac <atkac@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux performance depending on type count
Message-ID: <20120809115658.GB1643@telvanni>
References: <20120807130244.GE2085@telvanni>
 <20120808204401.GA5403@telvanni>
 <20120809104459.GA1446@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
In-Reply-To: <20120809104459.GA1446@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 12:45:00PM +0200, Adam Tkac wrote:
> On Wed, Aug 08, 2012 at 10:44:01PM +0200, Ole Kliemann wrote:
> > Of course this is a very rough and inprecise testing. But I guess=20
> > one can say that the policy infrastructure get's into trouble=20
> > with high type count whereas a high category count seems to be=20
> > handled flawlessly.
>=20
> I already wrote a patch for this and sent it to the ML some time ago. It =
is
> currently present in Fedora git tree, you can try it and report if it spe=
eds up
> your operations with SELinux.
>=20
> http://pkgs.fedoraproject.org/cgit/libsepol.git/plain/libsepol-rhat.patch

Thanks! But unfortunately this is out of the box incompatible=20
with Ubuntu's libsepol 2.1.0-1.2 and I don't really have the=20
overview to try to merge this right now.

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAjpYoACgkQS1FjE303ERxVMQCeMTiEXqmt/EnE2PleON3EgoOx
mUwAn1idmbkP/3JIjjZepJqSDBXG+PZ5
=bgCA
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
