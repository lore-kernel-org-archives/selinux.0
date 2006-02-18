Subject: Re: semanage non MLS breakage
From: Chris PeBenito <pebenito@gentoo.org>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <method@gentoo.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <43F64063.4040601@cornell.edu>
References: <1140150258.13377.15.camel@gorn.pebenito.net>
	 <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org>
	 <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org>
	 <43F5E97B.8060102@cornell.edu> <43F5EB83.30402@gentoo.org>
	 <43F5EE32.5080101@cornell.edu>  <43F64063.4040601@cornell.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3zThbThTCcTs9A4oRbBT"
Date: Sat, 18 Feb 2006 13:44:37 -0500
Message-Id: <1140288277.18548.28.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-3zThbThTCcTs9A4oRbBT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-02-17 at 16:30 -0500, Ivan Gyurdiev wrote:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > So, your seuser has an mls range, which causes a crash, because=20
> > libsemanage doesn't handle that case very well.
> > I will patch the library to prevent that crash, but for the moment I=20
> > suggest you get rid of the end colon.
> >
> Let me know if this patch works out for you...

Definitely going the right way, but a range of s0 must be hardcoded if
the range isn't specified:

gorn selinux-usr # semanage login -a -s staff_u pebenito
libsemanage.validate_handler: MLS is disabled, MLS range s0 Unix user peben=
ito ignored
gorn selinux-usr # semanage login -l

Login Name                SELinux User              MLS/MCS Range

__default__               user_u                    None
pebenito                  staff_u                   s0
root                      root                      None


--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--=-3zThbThTCcTs9A4oRbBT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD92sVvI7kLeavkkMRAhR2AJ4u9//8JAvjt2963vyvDsEwlorQBACgjZOv
+x8bFAE5QeuYHM7SzgGG8WQ=
=xbca
-----END PGP SIGNATURE-----

--=-3zThbThTCcTs9A4oRbBT--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
