Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0D380Ii021320
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 22:08:00 -0500 (EST)
Date: Wed, 12 Jan 2005 21:07:55 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux <selinux@tycho.nsa.gov>, Ingo Molnar <mingo@elte.hu>
Subject: Re: lots of execmem failures with 2.6.10
Message-ID: <20050113030755.GA24828@yggdrasil.localdomain>
References: <20050112112630.GA12730@yggdrasil.localdomain> <1105541256.22495.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
In-Reply-To: <1105541256.22495.57.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2005 at 09:47:36AM -0500, Stephen Smalley wrote:
> The question is why is your userland attempting to create executable
> anonymous mappings or executable writable private file mappings.  May
> be related to the legacy binary issue that came up earlier, where the
> mainline kernel enables read-implies-exec behavior if the binary is a
> "legacy" binary, i.e. lacks PT_GNU_STACK.  What does execstack -q
> `which uname` report?

I think you've pointed me in the right direction.  On my SELinux box it=20
yields the following:

   adric@sasami:~$ execstack -q `which uname`
   ? /bin/uname

On my non-SELinux box (also Debian sid), however, it looks like this:

   adric@yggdrasil[~]$ execstack -q `which uname`
   - /bin/uname

The difference is caused by the former box getting the "coreutils"
package (and a handful of others) from Russell's SELinux archive, which=20
I guess has gotten somewhat out of date.  I'll try rebuilding the=20
relevant packages over the next few days, and see if that resolves my=20
problem... if so, I'll post the updated packages under=20
"http://people.debian.org/~adric/".

Thanx for your assistance!


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB5eYLgrEMyr8Cx2YRAsvzAKDHHmWStz2g0CdL7LpFwC1Jct4vMgCdF8xL
8kdpXFi+LVriM0p3wVU23F8=
=s0+S
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
