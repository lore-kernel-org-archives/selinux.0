Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o487Bi60025132
	for <selinux@tycho.nsa.gov>; Sat, 8 May 2010 03:11:45 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o487B4m8004220
	for <selinux@tycho.nsa.gov>; Sat, 8 May 2010 07:11:05 GMT
Date: Sat, 8 May 2010 09:11:14 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: Martin Orr <martin@martinorr.name>
Cc: selinux@tycho.nsa.gov, sysvinit-devel@nongnu.org, 580272@bugs.debian.org
Subject: Re: sysvinit 2.88 and SELinux policy
Message-ID: <20100508071114.GH27129@myhost.felk.cvut.cz>
References: <20100507192427.9mwu09kubk0w44o0@legacy.mxes.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0P/MvzTfyTu5j9Q"
In-Reply-To: <20100507192427.9mwu09kubk0w44o0@legacy.mxes.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--/0P/MvzTfyTu5j9Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Martin Orr wrote:
> The differences here are that the new code ensures that /proc is
> mounted, and !is_selinux_enabled() becomes (is_selinux_enabled() >
> 0).
=20
> I think the change was due to this:
> http://thread.gmane.org/gmane.comp.security.selinux/13320
> (is_selinux_enabled() returns -1 if /proc not mounted).

They might have been inspired by it, but it is a completely different
fix than I proposed.=20

In the original context, the C expression "!is_selinux_enabled()"
means "is_selinux_enabled() =3D=3D 0". However, the function is tristate, as
its return values are -1, 0, and 1. In addition to 0, we also want -1 to
execute the code block below, so the expression becomes
"(foo =3D is_selinux_enabled(), foo =3D=3D 0 || foo =3D=3D -1)", or simply =
put
"is_selinux_enabled() !=3D 1".

And why we want that? Because the function checks if we already have a
policy loaded in the kernel. 1 means yes, 0 means no and -1 means no as
well. No need to mess with mounting /proc ;-)


Michal Svoboda


--/0P/MvzTfyTu5j9Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvlDpIACgkQg/fU9pp1uX43oACeLcQBPoRL0CuJ7daeKWz3VOyk
g6EAoK7AZGaezY0wjIC2mghFD/WBLnj+
=FfU2
-----END PGP SIGNATURE-----

--/0P/MvzTfyTu5j9Q--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
