Subject: Re: default user roles
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203706878.32061.28.camel@gorn>
References: <1203704148.3669.953.camel@bluejay.goodinassociates.com>
	 <1203706878.32061.28.camel@gorn>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-K/FcRseRfjxrCH2Su148"
Date: Fri, 22 Feb 2008 13:09:11 -0600
Message-Id: <1203707351.3669.961.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-K/FcRseRfjxrCH2Su148
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Since I'm working with the refpolicy source can I set it up there, or
does this have to be a file separate from the source?

On Fri, 2008-02-22 at 14:01 -0500, Christopher J. PeBenito wrote:
> On Fri, 2008-02-22 at 12:15 -0600, Jeremiah Jahn wrote:
> > I can't seem to get the login to set the proper initial role for a user=
.
> > Every time I login, I end up as auditadm, and not secstaff.
> >=20
> > I have the following in my policy:
> [...]
> > user secstaff_u roles { secstaff_r secadm_r auditadm_r } level s0 range=
 s0 - s0;
>=20
> You want to make the file /etc/selinux/NAME/contexts/users/secstaff_u
> with the default contexts that you want.  You probably want at least
> this:
>=20
> system_r:local_login_t:s0     auditadm_r:auditadm_t:s0
> system_r:remote_login_t:s0    auditadm_r:auditadm_t:s0
> system_r:sshd_t:s0            auditadm_r:auditadm_t:s0
>=20
PLUNDERER'S THEME (to Supercalifragilisticexpialidocius) Pillage, rape,
and loot and burn, but all in moderation. If you do the things we say,
then you'll soon rule the nation. Kill your foes and enemies and then
kill your relations. Pillage, rape, and loot and burn, but all in
moderation.

--=-K/FcRseRfjxrCH2Su148
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHvx3X6caZY8jbHDkRAvkPAJ0Vu/oAxeuLOyf7Nik6KWhgaZiZpgCggrBK
uNpqUpZ/7F12GlosqHm03tk=
=3hJO
-----END PGP SIGNATURE-----

--=-K/FcRseRfjxrCH2Su148--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
