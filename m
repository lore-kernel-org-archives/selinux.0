Date: Mon, 18 Oct 2004 22:51:36 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Adding alternate root patch to restorecon (setfiles?)
Message-Id: <20041018205136.GA2536@jmh.mhn.de>
References: <41741A2C.8040408@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <41741A2C.8040408@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-10-18 22:40]:
> We are beginning to look into how we could support clusters with SELinux.=
=20
> Usually in clusters you move your configuration off on to some shared=20
> storage.
>=20
> So you might do a cp -a  /var/named /shared/var/named
>=20
> We need some way of relabeling these directories with file context.  My=
=20
> idea is to add an alternate
> root qualifier to restorecon

One thing to note here is that restorecon becomes more dangerous with
your changes. Right now restorecon is relatively safe in that you can
only change file labels to their system default. It would probably be
acceptable in most environments to give users access to restorecon so
they could properly set labels for files in their home dir.

With your changes and this scenario, users could do something like
        restorecon -p /home/foo /home/foo/sbin/unix_chkpwd
and start reading /etc/shadow.
So I am not sure this is the right way.

Thomas


--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBdCzYxWIrrrL0q+cRAnNMAJ9DClHCTytKP2Xu4Y3M3he1w7PnxACePK6k
Qjsfft4ux3sB/q9vDHLV90Y=
=Msby
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
