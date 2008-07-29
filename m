Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6TJsv7V007895
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 15:54:57 -0400
Received: from QMTA02.emeryville.ca.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6TJsuuH016164
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 19:54:56 GMT
Subject: Re: [refpolicy patch, second try] samba policy updates
From: Chris PeBenito <pebenito@gentoo.org>
To: Mike Edenfield <kutulu@kutulu.org>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <488F5590.6060908@kutulu.org>
References: <488DED3A.1030005@kutulu.org>
	 <1217342823.4934.42.camel@defiant.pebenito.net>
	 <488F5590.6060908@kutulu.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-23eyVhzNZ/upL8Y25WNN"
Date: Tue, 29 Jul 2008 15:54:53 -0400
Message-Id: <1217361293.5525.13.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-23eyVhzNZ/upL8Y25WNN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-29 at 13:38 -0400, Mike Edenfield wrote:
> Chris PeBenito wrote:
> > On Mon, 2008-07-28 at 12:00 -0400, Mike Edenfield wrote:
> >> +tunable_policy(`samba_create_home_dirs',`
> >> +	ifdef(`distro_redhat', `
> >> +		refpolicywarn(`Use of samba_create_home_dirs is discouraged.  Pleas=
e use pam_oddjob_mkhomedir instead.')
> >> +	', `
> >> +		unprivuser_create_home_dirs(smbd_t)
> >> +		allow smbd_t self:capability chown;
> >> +	')
> >> +')
> >=20
> > I don't think this has the effect that you're trying to get.  The ifdef
> > is resolved during build time, and the tunable is resolved at runtime.
> > So the warning message won't do any good for most redhat users (and it
> > leaves them with a noop samba_create_home_dirs tunable).
>=20
> I wasn't sure if that would work; I know Dan has expressed a preference=20
> for RH users to use oddjob for this, but I didn't know if there was any=20
> way to enforce that.  I certainly didn't want it to silently do nothing.=20
>   Is there a correct place to document this preference?

I would like to just put

optional_policy(
  tunable_policy(samba_
    oddjob_domtrans_
  )
',`
  tunable_policy(samba_
    unprivuser_create_
  ')
')

but that doesn't work in the compiler; it doesn't allow require blocks
in the else of an optional block.  So to work around it I guess we can
just put an optional oddjob_domtrans_mkhomedir()

ifdef(`distro_redhat
  optional_policy(`
    tunable_policy(`samba_
      oddjob_domtrans_
    ')
  ')
',`
  tunable_policy(`samba_
    unprivuser_create_
    unprivuser_home_filetrans_
  ')
')

Hopefully my pseudopolicy makes sense.

> >> +interface(`unprivuser_create_home_dirs',`
> >> +       unprivuser_home_filetrans_home_dir($1)
> >> +       unprivuser_manage_home_dirs($1)
> >> +')
> >=20
> > "Create" just means directory create, but you have the full manage
> > permission set, in addition to a filetrans.
>=20
> I think I did go a bit overboard with the manage permissions.  I'd=20
> copied these from the oddjob's policy, but I notice that oddjobs also=20
> permits deleting home directories, which probably isn't needed here.
>=20
> The filetrans is needed, though, because without it, the created home=20
> directories were getting labeled home_root_t instead of user_home_dir_t.=20
>   It also needs to copy the template files in and label them correctly,=20
> like the user_home_ssh_t on .ssh, etc.  I'll narrow this down.

Thats fine, but the filetrans shouldn't be included in the create
interface itself.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-23eyVhzNZ/upL8Y25WNN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiPdY0ACgkQvI7kLeavkkPk+QCeIVkderWOMQFvQvF7f1a7tHCT
Z/oAoKgw3Qd+IkYUG3H3lyiKxT4vHET9
=37db
-----END PGP SIGNATURE-----

--=-23eyVhzNZ/upL8Y25WNN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
