Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6JEIdQn006931
	for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2012 10:18:39 -0400
Date: Thu, 19 Jul 2012 16:18:23 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Information about XSELinux
Message-ID: <20120719141823.GA19890@telvanni>
References: <1342534966.11916.YahooMailClassic@web87705.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
In-Reply-To: <1342534966.11916.YahooMailClassic@web87705.mail.ir2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks Richard, your X-setest tool is quite helpful to understand=20
what's going on.

Under Ubuntu I compiled the xserver-xorg package and manually=20
enabled --enable-selinux. Now it's working here. (They are at=20
1.11.4). I'm now writing a simple policy from scratch to extend=20
traditional linux user seperation to X.

I have one question though: This bug that appears under Fedora=20
and crashes the Xserver, is that a bug in the xorg sources or=20
something that came with patches from Fedora?

And how often have things like this happend in the past? I'm=20
planing on using this on a production system and ask myself how=20
careful I will have to be with updates to xorg in the future.

On Tue, Jul 17, 2012 at 03:22:46PM +0100, Richard Haines wrote:
> I've attached some updated XSELinux information that I've been working on=
 for the next version of the SELinux Notebook (old XSELinux stuff at: http:=
//selinuxproject.org/page/NB_XWIN).
>=20
> The XSELinux module is in the X source and always included with Fedora - =
I don't use other distributions so don't know whether they enable it in the=
ir builds or not. If they do build it, then you need the reference policy m=
odules and then enable the xserver boolean as follows:
>=20
> =A0 =A0=A0=A0setsebool xserver_object_manager true
>=20
> I'm not sure what the current development status is but I've submitted a =
couple of patches (the last one for xorg-x11-server-1.12.2 as it core dumps=
 when XSELinux is enabled with the above boolean).
>=20
> I've written a few apps to 'play with XSELinux' that are mentioned in the=
 text. Let me know if you would like the source (tested on Fedora 16/17).
>=20
> I have not really done anything with the XSELinux reference policy module=
s as they come with Fedora and seem to work (well for my limited use anyway=
).
>=20
> Richard
>=20
> --- On Mon, 16/7/12, Ole Kliemann <ole@plastictree.net> wrote:
>=20
> > From: Ole Kliemann <ole@plastictree.net>
> > Subject: Information about XSELinux
> > To: selinux@tycho.nsa.gov
> > Date: Monday, 16 July, 2012, 17:10
> > Hi everyone!
> >=20
> > I'm desperately trying to implement proper privilege
> > seperation=20
> > while using X.
> >=20
> > Currently I'm looking into XSELinux but am having a really
> > hard=20
> > time finding any information, documention etc.
> >=20
> > What's the development status?
> > Where can I get it?
> > Is it included in any major distributions? (Currently using
> >=20
> > Ubuntu 12.04)
> >=20
> > Any hint on where to find information would be highly=20
> > appreciated!
> >=20
> > Many thanks in advance and best regards,
> > Ole
> >



--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAIFy8ACgkQS1FjE303ERxqsACfcKZSS6k3aHRe9T+iZ70K+U9t
xXcAnj6JiHGiMheVCVBql+l09HPxjo2r
=Hqiv
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
