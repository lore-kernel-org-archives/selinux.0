Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3IE7jZE011431
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 10:07:45 -0400
Received: by mail-wr0-f169.google.com with SMTP id o21so103438566wrb.2
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 07:07:43 -0700 (PDT)
Received: from markus (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id w126sm14605331wmb.25.2017.04.18.07.07.41
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Apr 2017 07:07:41 -0700 (PDT)
Date: Tue, 18 Apr 2017 16:07:39 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Cannot write policy to allow { relabelto }
Message-ID: <20170418140739.GG26339@markus>
References: <31ef73c8-592e-8d94-be8d-9630c4c33023@gmail.com>
 <20170418061509.GA26339@markus>
 <3255746b-643f-4b2f-3629-1afab5fe974d@gmail.com>
 <20170418121016.GE26339@markus>
 <0f391c3b-bf00-1ba2-8983-3df0fca6c7bf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
In-Reply-To: <0f391c3b-bf00-1ba2-8983-3df0fca6c7bf@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 08:26:50AM -0500, Ian Pilcher wrote:
> On 04/18/2017 07:10 AM, Dominick Grift wrote:
> > where are you copying that object to? There should be no content with
> > type "cert_t" in a user home directory
>=20
> I'm copying the mod_nss NSS database directory (/etc/httpd/alias).  The
> program is intended to update Let's Encrypt certificates in mod_nss.
>=20
> I've moved the actual mod_nss database into a directory named something
> like /etc/httpd/alias-20170218081357 and /etc/httpd/alias is now a
> symbolic link to that directory.
>=20
> My program does this following:
>=20
>  * Create a new directory with a current timestamp:
>    /etc/httpd/alias-20170408143539 for example.
>=20
>  * Copy the NSS database files (cert8.db, key3.db, and secmod.db) from
>    the "old" directory to the new directory.  I can get away with this,
>    because mod_nss always opens the database read-only.
>=20
>  * Open the NSS database in the new directory, delete any existing
>    certificates with the matching nickname (hostname), and import the
>    new certificate.
>=20
>  * Recursively copy any other content (files, symlinks, subdirectories)
>    from the old directory to the new directory.  This step also copies
>    the ownership, permissions, and SELinux context of *all* objects,
>    including the NSS database files.  (This is where I hit the relabelto
>    denial.)

Okay so i suppose that behaves like `cp -a`. That copies the file context a=
s well.

I think then you are stuck with the object id change exemption solution bec=
ause AFAIK there is no `cp -a-minus-selinux-context` or equivalent

This is also an issue with dracut, where it cp -a a bunch of files from / t=
o /var/tmp/dracut to create the initramfs forcing us the me to allow dracut=
 to manage and relabel a lot of files

>=20
>  * Create a new symbolic link, /etc/httpd/alias.new, that points to the
>    new directory.
>=20
>  * Rename the /etc/httpd/alias.new symbolic link to /etc/httpd/alias.
>=20
>  * Recursively delete the old directory.
>=20
>  * Reload (SIGUSR1) httpd, so it will start using the new certificate.
>    (Actually, systemd does this in an ExecStartPost.)
>=20
> --=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Ian Pilcher                                         arequipeno@gmail.com
> -------- "I grew up before Mark Zuckerberg invented friendship" --------
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlj2HacACgkQJXSOVTf5
R2nH6gv9EaFX3LnH8ndISalWOWr+uiI+SMvVaVawfxnUOhPDI0Bs70QoUVW9XDLK
Qps9MkVas92So5h9hcaS256xeGcmqmGz8BfhBO5KKB49Zb3qeUiOSD7gxNGpom3r
aV5qgo8yTsGEhRDYf7Yl2gEje/Z4CsA1vC1p0Nxhw4r8DNFP7bnzVNjcRyqrpgqp
wOmZZy1OTHXeAhh8lLDRWjff3qJZaBwUoFbE+1+aNGczoW5abAnADXyx2utnNWTC
qYEPjzJqze+1kEpCDoC0p7GdSFwPpwRquPPDeh0BEN6uBhe8hKa+EtWCOoYRwMfW
lKaodKt+NdRXotri4aF/cVVURiSEMPw01GPiYt8RaxeePLIdDbWqWuHRiX1PyG5G
r8D+jSk1Yq9sh7Zvfs+yTyekG1s59vCxXtpOSpepBL+Y3P/l/aGU9AieNvWXwQ9F
TJZtobFG7i7jNw+OcCqsDrOeEolmF8L0IVDYtUx95runi6j7eoGeQA/fwW6lv5vR
hUbqUvwq
=aXHR
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--
