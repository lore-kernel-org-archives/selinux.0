Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6LCQMAl010692
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 08:26:22 -0400
Received: from QMTA07.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6LCQKhc011862
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2008 12:26:21 GMT
Subject: Re: Patch: 1/6: selinux-policy: remove dupe delimiter.
From: Chris PeBenito <pebenito@gentoo.org>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1216472939.4085.5.camel@sulphur.notebook.internal>
References: <1216472939.4085.5.camel@sulphur.notebook.internal>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KWo0urWUvxQcrLJGEwLL"
Date: Mon, 21 Jul 2008 08:26:17 -0400
Message-Id: <1216643177.3487.2.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KWo0urWUvxQcrLJGEwLL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 15:08 +0200, Dominick Grift wrote:
> This patch aims to remove any duplicate delimiter.

Actually, you've got this backwards.  We do want the space after the
comma for better readability.  I've slowly been applying the change
though the policy as I make other changes, which is probably why it
seems like its wrong style.

> @@ -12,10 +12,10 @@
>  #
>  interface(`usbmodules_domtrans',`
>         gen_require(`
> -               type usbmodules_t, usbmodules_exec_t;
> +               type usbmodules_t,usbmodules_exec_t;
>         ')
> =20
> -       domtrans_pattern($1, usbmodules_exec_t, usbmodules_t)
> +       domtrans_pattern($1,usbmodules_exec_t,usbmodules_t)
>  ')
> =20
>  ########################################

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-KWo0urWUvxQcrLJGEwLL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiEgGkACgkQvI7kLeavkkPXPQCglo7mWtF7uMEd7eNrbrcgunqY
KogAnRQ6g3XmyrTH+4dfoulrHiefxW0a
=RkT0
-----END PGP SIGNATURE-----

--=-KWo0urWUvxQcrLJGEwLL--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
