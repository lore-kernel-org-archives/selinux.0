Subject: Re: [RFC] selinux-support (1.0.1) available
From: Colin Walters <walters@verbum.org>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, ubuntu-hardened@lists.ubuntu.com,
   selinux@tycho.nsa.gov
In-Reply-To: <1111761662.27644.121.camel@localhost.localdomain>
References: <1111704432.27644.62.camel@localhost.localdomain>
	 <1111759697.15280.53.camel@moss-spartans.epoch.ncsc.mil>
	 <1111761662.27644.121.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J0l8xmLkzDNZvO0kvmW5"
Date: Fri, 25 Mar 2005 10:31:32 -0500
Message-Id: <1111764692.3932.45.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-J0l8xmLkzDNZvO0kvmW5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-25 at 15:41 +0100, Lorenzo Hern=C3=A1ndez Garc=C3=ADa-Hierr=
o
wrote:

> In my opinion, it's going to be Ubuntu specific until it's back-accepted
> in Debian, anyways, I expect to have, at least, the user-land ready for
> SELinux support within the Ubuntu Linux distribution, for the Hoary+1
> release (Breezy).

That's probably reasonable.  If Ubuntu can get SELinux working well on a
Debian-derived system out of the box, it will probably be easier for
Debian to then pull all of the current patches into their distribution.

Nevertheless, I encourage you to work with Debian on this as much as
possible.  SELinux, like any access control system worth something,
requires extensive integration with the rest of the OS.  And core parts
of the OS at that.  You do not want to be deviating much from the Debian
core for packages such as dpkg and coreutils in the long term. =20

Also, I strongly suggest that you look at the "targeted" policy shipping
with Fedora.  I had a glance at the Ubuntu wiki page for SELinux and it
seems the proposed policy is "selinux-policy-default", which IIRC is the
"strict" policy.  The experience with Fedora is that strict is not yet
workable as the default for a general-purpose OS, as Ubuntu is.  If you
can get the targeted policy as the Ubuntu default and most importantly
*on* by default, then "Hardened Ubuntu" becomes just s/targeted/strict/,
and perhaps a few other features.  Much less work for the "Hardened"
team.  Getting as many features of "Hardened" into the core should be
your goal anyways; I think that permanently-forked "Hardened" variants
are basically wrong.  They're kind of inherently doomed to be only used
by a very small subset of users.  You want it to be more of a proving
ground or staging area than a fork.

We're doing a lot of work in Fedora to make targeted work well, and I
think we could work together on it to good effect.

I haven't really done any Debian development in a year, but I think I
still remember much of how things work, so I'd be happy to help with any
integration issues you might have.  I'm sure the same is true of
Russell.  Posting to selinux@tycho.nsa.gov is probably your best bet.


--=-J0l8xmLkzDNZvO0kvmW5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCRC7UOIkJWWp2WGURApdgAJ0U5gwbrr20wUplcpD+eF7NTgi+QwCcC3JL
1Zbu90ywQjqV7BRIe2N+Xu4=
=kSm1
-----END PGP SIGNATURE-----

--=-J0l8xmLkzDNZvO0kvmW5--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
