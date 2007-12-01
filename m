Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lB1NLhG0010835
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2007 18:21:43 -0500
Received: from QMTA09.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB1NLhYe026334
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2007 23:21:43 GMT
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
From: Chris PeBenito <pebenito@gentoo.org>
To: Martin Orr <martin@martinorr.name>
Cc: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov
In-Reply-To: <47504744.9040202@martinorr.name>
References: <20071126144547.GA334@bobek.pm.i.cz>
	 <1196189369.30997.6.camel@gorn> <474F1BD4.2010908@martinorr.name>
	 <20071130134933.GA11780@bobek.pm.i.cz> <1196433514.4298.42.camel@gorn>
	 <20071130153024.GA13299@bobek.pm.i.cz> <1196438149.4298.43.camel@gorn>
	 <47504744.9040202@martinorr.name>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FLkwMO1Axt1ESEMiK/TN"
Date: Sat, 01 Dec 2007 18:21:41 -0500
Message-Id: <1196551302.4808.6.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-FLkwMO1Axt1ESEMiK/TN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-11-30 at 17:24 +0000, Martin Orr wrote:
> On 30/11/07 15:55, Christopher J. PeBenito wrote:
> > On Fri, 2007-11-30 at 16:30 +0100, V=E1clav Ovs=EDk wrote:
> >> On Fri, Nov 30, 2007 at 09:38:33AM -0500, Christopher J. PeBenito wrot=
e:
> >>>> Corresponding code is in udev_node.c, function node_symlink().
> >>>>     if (strcmp(target, buf) =3D=3D 0) {
> >>>> 	    info("preserve already existing symlink '%s' to '%s'", slink,
> >>>> target);
> >>>> 	    selinux_setfilecon(slink, NULL, S_IFLNK);
> >>>> 	    goto exit;
> >>>>     }
> >>> I'll add the rule.  Perhaps someone should send up a patch to remove =
the
> >>> setfilecon, and update the info message.
> >> Mean you to compare the context of symlink and no setfilecon if it is
> >> ok?
> >=20
> > Yes.  Unless there's a good reason to keep it as-is that I don't know
> > about.
>=20
> Well I'll send a patch to udev.  Should it just be the below, or should u=
dev
> be relabelling symlinks if it finds that they exist but are wrongly
> labelled?  How do I test for equality of security contexts?
>=20
> --- a/udev_node.c
> +++ b/udev_node.c
> @@ -146,7 +146,6 @@ static int node_symlink(const char *node, const char =
*slink)
>  				buf[len] =3D '\0';
>  				if (strcmp(target, buf) =3D=3D 0) {
>  					info("preserve already existing symlink '%s' to '%s'", slink, targe=
t);
> -					selinux_setfilecon(slink, NULL, S_IFLNK);
>  					goto exit;
>  				}
>  			}

Yes, thats what I was thinkin.  Since the function is node_symlink(),
I'm guessing there is a similar function for char and block node, etc?
Those should be checked to make sure they don't do unneeded relabeling
too.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-FLkwMO1Axt1ESEMiK/TN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHUeyFvI7kLeavkkMRAushAJ9YoreWraANHFcSmV7h6jcjkLRRvgCgnwJI
mvNEzo/RLOMh7hCpllhyJHM=
=O4Xy
-----END PGP SIGNATURE-----

--=-FLkwMO1Axt1ESEMiK/TN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
