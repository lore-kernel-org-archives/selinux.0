Subject: Re: SELinux security and passed file descriptors
From: James Antill <jantill@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, viro@ftp.linux.org.uk,
        selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <8927.1188570735@redhat.com>
References: <1188487195.26572.351.camel@moss-spartans.epoch.ncsc.mil>
	 <10698.1188486734@redhat.com>  <8927.1188570735@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iZ/4H8jazGv0PqCrDdUP"
Date: Fri, 31 Aug 2007 11:39:43 -0400
Message-Id: <1188574783.11631.43.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-iZ/4H8jazGv0PqCrDdUP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-08-31 at 15:32 +0100, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>=20
> > That's how mandatory access control is supposed to work; otherwise, a
> > flaw in A can leak the descriptor to B at will in violation of security
> > policy.
>=20
> Yeah, but by making it impossible to have the flaw, you've also made it
> impossible for A to validly pass to B a file descriptor B wouldn't otherw=
ise
> be able to access directly, but should be able to access on behalf of A.
>=20
> To put it another way, how does A now legitimately pass on to B the grant=
 of
> rights A had on that specific file descriptor?

 It doesn't, that's what the _Mandatory_ part of Mandatory Access
Control is all about.
 See the third paragraph from wikipedia, on MAC:

"""MAC's most important feature involves denying users full control over
the access to resources that they create. [...] """

http://en.wikipedia.org/wiki/Mandatory_access_control

> I don't think you can practically change the security attached to the fil=
e
> struct,
>=20
> With respect to execve(), imagine that program A (a shell, say) opens a f=
ile
> to use as a stdout for program B, which it then proceeds to exec.  Imagin=
e,
> however, the process's security label is changed during the exec of B and=
 this
> disallows B from writing to its stdout.  Is this correct behaviour since =
it is
> differs depending on whether SELinux is in enforcing mode or not?  Or is =
there
> some way around this in SELinux?  (I presume this is what
> flush_unauthorized_files() does).

 This is correct, and often happens with respect to stdout (see
allow_daemons_use_tty etc.).

 You might also be asking how you can run B in the same security context
as A, and you can do that by calling setexeccon() with the result from
getcon(). But that is very likely to affect more than just writing to
stdout.=20
 Or you could call fsetfilecon() on stdout from A, so that it would be
in a context that B could use, but that might not be allowed (or just be
a bad idea).

--=20
James Antill <jantill@redhat.com>

--=-iZ/4H8jazGv0PqCrDdUP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBG2DY/11eXTEMrxtQRAiWMAJ9W1fTcrKJRDOFlbLH50j/9+8ELAwCff5hO
zN/SZO8CUkLY70mevqVzFjA=
=3Xi6
-----END PGP SIGNATURE-----

--=-iZ/4H8jazGv0PqCrDdUP--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
