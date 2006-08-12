Subject: Re: [patch] libselinux:  access per-thread proc pid attr nodes,
	unify code
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1155324042.30078.100.camel@moss-spartans.epoch.ncsc.mil>
References: <1155324042.30078.100.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-K9FFkUhoY3bYanJ5sLXo"
Date: Sat, 12 Aug 2006 01:34:45 -0400
Message-Id: <1155360886.2496.29.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-K9FFkUhoY3bYanJ5sLXo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-08-11 at 15:20 -0400, Stephen Smalley wrote:
> Rework the libselinux functions that access /proc/pid/attr to access the
> per-thread nodes, and unify the code to simplify maintenance.

 The main glibc author has stated[1] that gettid() isn't a public
function because he reserves the right to not have the user space thread
tied to the kernel space thread, which would really confuse anyone using
these functions...

On Thu, 2006-06-08 at 09:02 -0700, Ulrich Drepper wrote:
>  And currently we use the same TID (for the kernel: the PID) for the
> lifetime of the thread.  But this could change at any time.  It's an
> implementation detail and if there are advantages to do some userlevel
> scheduling (i.e., swap the underlying process of two threads) I'll
> implement this and it'll break all code depending on the fixed
> relationship.
>=20
> If they don't care and don't blame us they can use
>=20
>   syscall (__NR_gettid)
>=20
> after including <sys/syscall.h>.  But get it in writing that they
> won't put it in production code.=20


[1] This is from a semi-private mail, so I can't provide a link ...
however I'm sure Ulrich will publicly state something resembling the
above if you ask him.

--=20
James Antill <jantill@redhat.com>

--=-K9FFkUhoY3bYanJ5sLXo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE3Wh111eXTEMrxtQRAv3xAJ9sGveEBJ6b6dBRvUPGFXEdU/fYfwCfSmcL
FgmkeJe5AAdGw3EUrsAZUh8=
=kugV
-----END PGP SIGNATURE-----

--=-K9FFkUhoY3bYanJ5sLXo--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
