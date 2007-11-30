Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUHOrWC018706
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 12:24:53 -0500
Received: from ppsw-8.csi.cam.ac.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAUHOkFb012122
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 17:24:46 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:49617)
	by ppsw-8.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.138]:25)
	with esmtp id 1Iy9bT-0005fp-Sq (Exim 4.67) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Fri, 30 Nov 2007 17:24:39 +0000
Message-ID: <47504744.9040202@martinorr.name>
Date: Fri, 30 Nov 2007 17:24:20 +0000
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_caligula-4103-1196443480-0001-2"
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
References: <20071126144547.GA334@bobek.pm.i.cz>	 <1196189369.30997.6.camel@gorn> <474F1BD4.2010908@martinorr.name>	 <20071130134933.GA11780@bobek.pm.i.cz> <1196433514.4298.42.camel@gorn>	 <20071130153024.GA13299@bobek.pm.i.cz> <1196438149.4298.43.camel@gorn>
In-Reply-To: <1196438149.4298.43.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-4103-1196443480-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/11/07 15:55, Christopher J. PeBenito wrote:
> On Fri, 2007-11-30 at 16:30 +0100, V=E1clav Ovs=EDk wrote:
>> On Fri, Nov 30, 2007 at 09:38:33AM -0500, Christopher J. PeBenito wrot=
e:
>>>> Corresponding code is in udev_node.c, function node_symlink().
>>>>     if (strcmp(target, buf) =3D=3D 0) {
>>>> 	    info("preserve already existing symlink '%s' to '%s'", slink,
>>>> target);
>>>> 	    selinux_setfilecon(slink, NULL, S_IFLNK);
>>>> 	    goto exit;
>>>>     }
>>> I'll add the rule.  Perhaps someone should send up a patch to remove =
the
>>> setfilecon, and update the info message.
>> Mean you to compare the context of symlink and no setfilecon if it is
>> ok?
>=20
> Yes.  Unless there's a good reason to keep it as-is that I don't know
> about.

Well I'll send a patch to udev.  Should it just be the below, or should u=
dev
be relabelling symlinks if it finds that they exist but are wrongly
labelled?  How do I test for equality of security contexts?

--- a/udev_node.c
+++ b/udev_node.c
@@ -146,7 +146,6 @@ static int node_symlink(const char *node, const char =
*slink)
 				buf[len] =3D '\0';
 				if (strcmp(target, buf) =3D=3D 0) {
 					info("preserve already existing symlink '%s' to '%s'", slink, targe=
t);
-					selinux_setfilecon(slink, NULL, S_IFLNK);
 					goto exit;
 				}
 			}

--=20
Martin Orr


--=_caligula-4103-1196443480-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHUEdKZ6a/BjxtAMARAmBYAJ9Ik6ZQvwyBNee1krXWBwYZtcPvSgCfYqkJ
savHW789gLCLFB/SPacJTEA=
=Vra/
-----END PGP SIGNATURE-----

--=_caligula-4103-1196443480-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
