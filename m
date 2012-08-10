Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7AAbXFb019705
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2012 06:37:33 -0400
Date: Fri, 10 Aug 2012 12:37:04 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Possible bug in finding default context?
Message-ID: <20120810103704.GC2296@telvanni>
References: <20120809174519.GE1643@telvanni>
 <201208101913.03332.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
In-Reply-To: <201208101913.03332.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2012 at 07:13:03PM +1000, Russell Coker wrote:
> On Fri, 10 Aug 2012, Ole Kliemann <ole@plastictree.net> wrote:
> > I'm doing this on Ubuntu 12.04, so it could be the crappily=20
> > maintained selinux userland here.
>=20
> What are the problems in Ubuntu SE Linux?
>=20
> I've idly considered joining the Ubuntu project to help maintain SE Linux=
=20
> there.  Doing it for two Debian-based distros can't be much more work tha=
n=20
> doing it for one.

Admittedly that statement contains a lot of prejudice. When I=20
started with SELinux I expectedly had problems finding my way=20
around. Documentation is often hard to find. The only good=20
reference I found so far is Richard Haines' SELinux Notebook.

But that's, like most SELinux documentation, quite abstract. If=20
you want more concrete information you always end up on the=20
websites of either Red Hat or Fedora. If you google for Ubuntu=20
and SELinux you won't find much.

Running a strict SELinux policy is a rather delicate affair. My=20
overall feeling regarding Ubuntu policy was: I shouldn't be=20
surprised if something suddenly stops working. But TBH I never=20
really tested it. When I tryed installing the ubuntu policy on my=20
test system right now, it failed due to some error, but normally=20
installing works. (I probably messed something up.)

There are a few problems I ran into that I remember off the top=20
of my head:

Reference policy sources can be installed and compiled but not=20
inserted due to missing dependencies.

There's an null pointer dereference in libsemanage, something=20
with genhomedircon, when trying to build a non-mcs policy. That's=20
a know issue but unpatched in Ubuntu.

The reference policy ubuntu's policy is based on is something=20
=66rom 2009. It doesn't have the

    bool mmap_low_allowed false;

As far as my limited understanding goes that isn't a problem=20
unless you do something stupid anyways. (Like installing wine... =20
vm.mmap_min_addr is set to 65536 by default on Ubuntu.)


So bottom line: Things aren't neccessarily bad. But they do look=20
old. And I just lack the trust that the policy is maintained in a=20
way that I can do updates without worries. Hence my prejudice.

Ole

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAk5FAACgkQS1FjE303ERxb0ACdGhElm3iJqmBUHKuytVjrlgt5
VxcAn3xwjN/8UzsVo72Sq3ojENU+y5EI
=6Tb2
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
