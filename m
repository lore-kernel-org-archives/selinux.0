Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6PEuJij003556
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 10:56:19 -0400
Received: from QMTA03.emeryville.ca.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6PEuIn9013625
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 14:56:18 GMT
Subject: RE: libsepol.context_from_record: MLS is disabled, but MLS
	context"s0" found
From: Chris PeBenito <pebenito@gentoo.org>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Vikram Ambrose <Vikram.Ambrose@windriver.com>, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880246B40D@exchange.columbia.tresys.com>
References: <4888E754.9030504@windriver.com>
	 <1216944435.4931.20.camel@defiant.pebenito.net>
	 <6FE441CD9F0C0C479F2D88F959B015880246B40D@exchange.columbia.tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4JQetNB5itW3RQVHhcgG"
Date: Fri, 25 Jul 2008 10:55:39 -0400
Message-Id: <1216997739.5392.14.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4JQetNB5itW3RQVHhcgG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-07-25 at 10:30 -0400, Karl MacMillan wrote:
> > -----Original Message-----
> > From: Chris PeBenito [mailto:pebenito@gentoo.org]
> > Sent: Thursday, July 24, 2008 8:07 PM
> > To: Vikram Ambrose
> > Cc: selinux@tycho.nsa.gov; Karl MacMillan
> > Subject: Re: libsepol.context_from_record: MLS is disabled, but MLS
> > context"s0" found
> >=20
> > On Thu, 2008-07-24 at 16:34 -0400, Vikram Ambrose wrote:
> > > I keep getting this error with audit2why.
> > >
> > > root@localhost:/root> cat msg
> > > type=3D1400 audit(1216736766.147:35): avc:  denied  { read write }
> > for
> > > pid=3D1829 comm=3D"modprobe" name=3D"console" dev=3Dsda ino=3D344069
> > > scontext=3Dsystem_u:system_r:insmod_t
> > > tcontext=3Dunconfined_u:object_r:default_t tclass=3Dchr_file
> > >
> > > root@localhost:/root> audit2allow < msg #=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D insmod_t
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D allow insmod_t default_t:c=
hr_file { read write };
> > >
> > > root@localhost:/root> audit2why < msg
> > > libsepol.context_from_record: MLS is disabled, but MLS context "s0"
> > > found
> > > libsepol.context_from_record: could not create context structure
> > > libsepol.context_from_string: could not create context structure
> > > libsepol.sepol_context_to_sid: could not convert
> > > system_u:system_r:insmod_t:s0 to sid Invalid Source Context
> > > system_u:system_r:insmod_t:s0
> >=20
> > I ran into this last week.  Sepolgen incorrectly adds the MLS portion
> > of the context regardless if MLS is enabled or not.  Then when the
> > tool uses the context, libsepol throws the above errors when MLS is
> > disabled.
> > I haven't had a chance to really look at what would be the right way
> > to fix it, since I'm no python expert.  Karl?
> >=20
>=20
> Maybe I'm missing something, but from above this looks like an audit2why
> bug not an sepolgen bug.

Perhaps.  I didn't have a change to analyze the problem fully, so I
don't know if sepolgen is supposed to be informed if this is an MLS
policy or not, or if sepolgen itself is supposed to figure it out.  In
the end the offending function is in the SecurityContext class in
sepolgen:

def to_string(self, default_level=3D"s0"):
        fields =3D [self.user, self.role, self.type]
        if self.level =3D=3D "":
            if default_level !=3D "":
                fields.append(default_level)
        else:
            fields.append(self.level)
        return ":".join(fields)

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-4JQetNB5itW3RQVHhcgG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJ6WsACgkQvI7kLeavkkNlNQCgkAUJcz+A7teamr+GF5minkvc
buwAnR872mnwBquTXhMKD6XC0RYhw4NO
=cny+
-----END PGP SIGNATURE-----

--=-4JQetNB5itW3RQVHhcgG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
