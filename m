Subject: Re: su problems again
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1202158361.3070.141.camel@moss-spartans.epoch.ncsc.mil>
References: <1202151733.2801.116.camel@bluejay.goodinassociates.com>
	 <1202152318.3070.121.camel@moss-spartans.epoch.ncsc.mil>
	 <1202154013.2801.119.camel@bluejay.goodinassociates.com>
	 <1202155858.3070.127.camel@moss-spartans.epoch.ncsc.mil>
	 <1202156505.2801.122.camel@bluejay.goodinassociates.com>
	 <1202156860.3070.132.camel@moss-spartans.epoch.ncsc.mil>
	 <1202157694.2801.128.camel@bluejay.goodinassociates.com>
	 <1202158361.3070.141.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sj5VTvrAM2flt6i2Xc3Z"
Date: Tue, 05 Feb 2008 08:25:19 -0600
Message-Id: <1202221519.2801.201.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-sj5VTvrAM2flt6i2Xc3Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Would it be worthwhile to submit a patch against the Rules.modular that
disables the dontaudits? Seems like a simple and useful patch without
requiring a whole new tool chain.

-jj-=20

On Mon, 2008-02-04 at 15:52 -0500, Stephen Smalley wrote:
> On Mon, 2008-02-04 at 14:41 -0600, Jeremiah Jahn wrote:
> > Any idea what this is about?
> >=20
> > policy/modules/system/mount.te:18:ERROR 'syntax error' at token
> > 'typeattribute' on line 844559:
> >=20
> > This is the third one I've gotten. I got the same error for mono and
> > monop. This is why I didn't just change the build.conf file. I seem to
> > be able to move on to the next on if I set this back to module instead
> > of base, but this seems to not seem right to me.=20
>=20
> Yes, sounds like a bug in the policy.  Surrounding context from that
> line might be useful, although I'm sure Chris can reproduce easily
> enough just by trying a build that puts everything into base.
>=20
Paradise is exactly like where you are right now ... only much, much
better. -- Laurie Anderson

--=-sj5VTvrAM2flt6i2Xc3Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHqHHP6caZY8jbHDkRAmO3AJ45yyP0vejF0058a8Sj3/m4DU3alQCfaDIu
71xBrEknqYJfse49uOPLKYQ=
=O/ip
-----END PGP SIGNATURE-----

--=-sj5VTvrAM2flt6i2Xc3Z--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
