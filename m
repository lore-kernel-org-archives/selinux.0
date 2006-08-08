Subject: Re: setexeccon vs. setfscreatecon
From: James Antill <james.antill@redhat.com>
To: Jim Meyering <jim@meyering.net>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
In-Reply-To: <87ejvrcj9i.fsf@rho.meyering.net>
References: <87u04ncqqq.fsf@rho.meyering.net>
	 <1155050462.1123.36.camel@moss-spartans.epoch.ncsc.mil>
	 <87ejvrcj9i.fsf@rho.meyering.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hsViu6V3hK/c8+b4cOzt"
Date: Tue, 08 Aug 2006 12:20:26 -0400
Message-Id: <1155054026.12606.26.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-hsViu6V3hK/c8+b4cOzt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-08 at 17:57 +0200, Jim Meyering wrote:

> What you're saying seems to be at odds with setexeccon.1
> as well as with this demonstration (using 2.6.17-1.2462.fc6):
>=20
>     $ id -Z
>     user_u:system_r:unconfined_t
>     $ runcon -r object_r -- ./id -Z
>     user_u:object_r:unconfined_t
>=20
> since runcon's call to setexeccon does what the man page says it does
> (set exec context for subsequent execve call) and changes the role from
> system_r to object_r.  Does that mean this behavior is Red Hat/Fedora-
> specific?

 No, what Steven was saying is that the label for execcon will be reset
on exec (after doing it's thing). To see this visually use "secon
--self-exec" instead of id.

% secon
user: user_u
role: system_r
type: unconfined_t
sensitivity:
clearance:
mls-range:
% secon --self-exec
user:
role:
type:
sensitivity:
clearance:
mls-range:
% runcon -r system_r secon
user: user_u
role: system_r
type: unconfined_t
sensitivity:
clearance:
mls-range:
% runcon -r system_r -- secon --self-exec
user:
role:
type:
sensitivity:
clearance:
mls-range:


--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-hsViu6V3hK/c8+b4cOzt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE2LnK11eXTEMrxtQRAtGcAJ44XA4dvNeaK4olETRlsKImV+p1ggCdG5Ms
Qp28AjEAMJlA+YlVGDspFt4=
=dN+J
-----END PGP SIGNATURE-----

--=-hsViu6V3hK/c8+b4cOzt--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
