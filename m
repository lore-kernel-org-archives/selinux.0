Message-ID: <1328805651.5174.29.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: SELinux on Wheezy
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: russell@coker.com.au
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE-Linux <selinux@tycho.nsa.gov>
Date: Thu, 09 Feb 2012 08:40:51 -0800
In-Reply-To: <201202100005.26791.russell@coker.com.au>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328707470.19254.16.camel@moss-pluto>
	 <1328722790.23833.9.camel@foxtrot.cjac.ntr.f5net.com>
	 <201202100005.26791.russell@coker.com.au>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-9Sm0c2MGN4okEhlf1wBT"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9Sm0c2MGN4okEhlf1wBT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-02-10 at 00:05 +1100, Russell Coker wrote:
> On Thu, 9 Feb 2012, "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org> wr=
ote:
> > On Wed, 2012-02-08 at 08:24 -0500, Stephen Smalley wrote:
> > > On Tue, 2012-02-07 at 13:05 -0800, C.J. Adams-Collier wrote:
> > > > cjac@foxtrot:~$ sudo which seinfo
> > > > cjac@foxtrot:~$ apt-file search seinfo | grep bin | wc -l
> > > > 0
> > >=20
> > > seinfo is part of the setools package.
> >=20
> > $ apt-cache search -n setools
> > erlang-parsetools - Erlang/OTP parsing tools
> >=20
> > Hmm.
>=20
> # apt-cache search -n setools
> erlang-parsetools - Erlang/OTP parsing tools
> libsetools-java - SETools Java bindings (architecture-independent)
> libsetools-jni - SETools Java bindings (architecture-dependent)
> libsetools-tcl - SETools Tcl bindings
> python-setools - SETools Python bindings
> setools - tools for Security Enhanced Linux policy analysis
>=20
> Works for me when tracking unstable.

I was hoping you wouldn't say that.  I like the sound of wheezy better
than sid.  I guess my=20

$ cat /etc/debian_version=20

says

wheezy/sid

Let's get it back into testing if we can.

> http://bugs.debian.org/cgi-bin/pkgreport.cgi?package=3Dsetools
>=20
> But it's got a grave bug and an important bug.  CJ Would you like to help=
 in=20
> fixing these?  It's probably not going to be any more difficult than buil=
ding=20
> your own copy from upstream source.

That sounds fine.  If maintenance lasts beyond 2013/01/01, (and I expect
it will), you should know that my volunteer time will be considered part
of my donation in public service to my state guard association.  Shared
Copyright will then be donated to this public Company.

I have a copy of the upstream source which Mr. Smalley directed me to.
I will build it as time permits.  Right now I've got to write some Perl
for my Employer.

> > > > Sounds reasonable.  Do I get policy from my distribution, or should=
 I
> > > > generate one myself?
> > >=20
> > > Normally from your distribution, assuming the selinux packages for
> > > Debian are still being maintained.
>=20
> Of course they are still being maintained.

Good to hear from you what I already knew.  I'm glad we're all on the
same page.

> > I believe they are.  I exchanged email with Russell about it not long
> > ago.  But then, gtkglarea is still officially maintained and I made the
> > first update in nearly a year 36 hours ago.  Perhaps the package needs =
1
> > or more co-maintainers to improve coverage.
>=20
> Yes, more help would be good.

Sounds good.

> Manoj has disappeared, he has not answered any mail I sent him for a long=
=20
> time.  Everything that lists him as the maintainer needs a new maintainer=
.

Roger.  I'll get my alioth account back online and my key into my
authorized_keys file.  I tried to bring it back online the other day,
and the mono/cli team said they thought it should still be active.  So
I'll see if the sysops can reset my credentials.

> > > IIRC, the Debian selinux policy package tries to minimize the set of
> > > installed policy modules based on the set of installed packages, but
> > > that isn't an exact mapping and might be leaving you without a comple=
te
> > > policy.  Whereas Fedora installs all policy modules unconditionally.
> >=20
> > If the overhead is not too great, perhaps this can be duplicated in
> > Debian.  I do hate paying for things I don't use, though.  Especially
> > when the cost is substantial.  The same is probably true of many other
> > Debian users.
>=20
> The only problem in Debian in this regard is when you install new package=
s=20
> after installing the SE Linux policy.  I plan to somehow hook into the pa=
ckage=20
> installation process to install new policy modules as needed.
>=20

Sounds good.  Last I heard it was written in Perl.


--=-9Sm0c2MGN4okEhlf1wBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPM/cTAAoJEEyimPmPQm23kSAH+QFHnmGqejWjEpUOmTLiOxaV
m3bFJayAuVoAX16L2qVUuHZVDTXrf9ahwria/jk3pvIQlHKsmgb2OyzfUOjAhm7k
Z3m1J/p49+OyZKFme5z5dvCYT19rhuXoJLK7b5bGARCMCNM9I+grlUKiJJmSDOvF
Sx1kdABPXrqZ3mg0tOz4Ik8rlxvTVID4b8GVf/zQmax8Pwy1YFzWS0nkFWO/DYJB
vQhHchcjNjvxMS7eWNFspBGHsn1FxkuW5VsnJ7mJy7xOkSwqM92algfJ4E706b6o
aKEcvmmOPr8VXayD1SycKxZHnWbU58A7nQr49vjGRqv1r3XosXD/boz0K66B2Uo=
=Ylih
-----END PGP SIGNATURE-----

--=-9Sm0c2MGN4okEhlf1wBT--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
