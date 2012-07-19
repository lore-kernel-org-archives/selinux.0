Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6JEiKbf008639
	for <selinux@tycho.nsa.gov>; Thu, 19 Jul 2012 10:44:21 -0400
Date: Thu, 19 Jul 2012 16:44:05 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
        selinux@tycho.nsa.gov
Subject: Re: Information about XSELinux
Message-ID: <20120719144405.GB19890@telvanni>
References: <20120716161006.GA14824@telvanni>
 <201207170423.14495.russell@coker.com.au>
 <20120716221818.GA16156@telvanni>
 <1342704589.31048.22.camel@moss-pluto.epoch.ncsc.mil>
 <50081541.3040909@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
In-Reply-To: <50081541.3040909@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2012 at 10:10:09AM -0400, Daniel J Walsh wrote:
> On 07/19/2012 09:29 AM, Stephen Smalley wrote:
> > XSELinux is included in Fedora, but they don't enable it by default so =
it
> > doesn't get much testing.  They took a different approach for isolating=
 X
> > applications via nested Xephyr servers in their sandbox tool.
> >=20
>=20
> My opinion is that XAce or XSELinux works ok with the MLS model, but not =
with
> the type enforcement model.  In my opinion isolating applications within =
the
> own sandbox/containers is a simpler and more sustainable approach.
>=20
> XClients that get a permission denied, are likely to misbehave (die) since
> they were coded with the assumption that they either get full access to X=
 or
> no access to X.
>=20
> Finally trying to write confinement policy for a type enforcement model o=
n X
> is very difficult, how do I isolate two instances of firefox?  If Firefox
> execs a open office, how does this libreoffice interact with the existing
> libreoffice that might be running under a different context.  How does
> cut/paste work, how about one window obscuring another, transparent windo=
ws
> ...  Way too complicated.  Sandbox model is just total separation.  They =
do
> not even know the other apps exist.

Xephyr is what I have been using so far under Ubuntu. I don't=20
know how it runs under Fedora, but I notice here a performance=20
decrease. Sluggish cursor, sluggish scrolling etc.=20

So I wanted to get away from this. But I think my goals are=20
simple.

Right now I have one (standard linux) user as main user and=20
several (standard linux) users as subusers. I have a suid root=20
program that checks a database on disk and allows the main user=20
to drop privileges to one of his subusers. I use a subuser for=20
each job (mail, browser, writing etc.).

Seperation under X is achieved using "terminal-chains" (mainuser=20
starts a subuser with X access who starts a terminal and a=20
subuser of his own with no X access who than runs the shell=20
inside the terminal - an idea my brother had years ago), or using=20
"xephyr-chains" which I think is more or less how sandbox does=20
it.

Terminal-chains are fast but have no X, xephyr-chains have X but=20
lose performance.

What I want to do is to extend the standard linux user seperation=20
to X. Assign the mainuser and every subuser a context and then=20
make sure X-applications in one context can't mess with those in=20
other contexts. Selinux here has only to make sure X is secured.=20
I'll still be using different linux users for every context.

I don't need no "fancy stuff" like automatic domain transitions=20
using certain applications as entrypoints. I can perfectly=20
understand the beauty of this in an integrated desktop=20
environment. But something in my wants simplicity when it comes=20
to security concepts. ;-)

I'm not exactly sure how MLS works, but I'd intuitively would=20
say, my approach is more MLS-like because change of privileges=20
only goes in one direction. Privileges are only dropped, never=20
gained. (Mainuser drops to subuser, subuser never elevates back=20
to mainuser or any other subuser.)

I started working on a policy for X using TE. Do you think, what=20
I want could be better expressed in MLS?

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAIHTUACgkQS1FjE303ERz1BQCeMNr/wWX5R5kx4CrJwJj11z9q
7lsAn3PjJEEwzJdC63NzdyAnYmTAH+07
=I36v
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
