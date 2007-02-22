Subject: Re: libselinux patch
From: James Antill <james.antill@redhat.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <305125.10227.qm@web51504.mail.yahoo.com>
References: <305125.10227.qm@web51504.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jPn6K3GgmSB51M+0nl0b"
Date: Thu, 22 Feb 2007 09:45:04 -0500
Message-Id: <1172155504.23774.84.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jPn6K3GgmSB51M+0nl0b
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-02-22 at 05:46 -0800, Steve G wrote:
> >
> >- Why u_int32_t instead of just long (per the statfs man page)?
>=20
> SELINUX_MAGIC is 0xf97cff8c and the upper bit is 1, so it gets sign exten=
ded in
> 64 bit kernels. Then the direct comparison fails.

 Why not just have the define as:

#define SELINUX_MAGIC 0xf97cff8cU

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-jPn6K3GgmSB51M+0nl0b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBF3axw11eXTEMrxtQRAsWHAKC1y6B8rizkefbsOPKPhPpx+rsBTgCeLsFr
VkI3zdxh+tUhXnp98cmlQZk=
=Mft6
-----END PGP SIGNATURE-----

--=-jPn6K3GgmSB51M+0nl0b--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
