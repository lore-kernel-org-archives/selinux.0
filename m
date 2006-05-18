Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4IIEtk1015045
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 14:15:02 -0400
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4IIEr7v025087
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 18:14:54 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 18 May 2006 20:14:51 +0200
Date: Thu, 18 May 2006 20:14:52 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>, Jeremy Katz <katzj@redhat.com>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping of inode security contexts
Message-Id: <20060518181452.GA4935@thorium2.jmh.mhn.de>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil> <20060517075435.GB7665@thorium.jmh.mhn.de> <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
In-Reply-To: <1147888337.22880.165.camel@jackjack.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Karl MacMillan <kmacmillan@tresys.com> [2006-05-17 19:55]:
> On Wed, 2006-05-17 at 09:54 +0200, Thomas Bleher wrote:
> > [Added CCs from earlier thread]
> >=20
> > * Stephen Smalley <sds@tycho.nsa.gov> [2006-05-15 18:31]:
> > > During the earlier thread on splitting policy into individual packages
> > > (using policy modules), it was requested that SELinux provide a way f=
or
> > > a privileged process (like a package manager) to label an inode with a
> > > not-yet-defined security context (treating it as having the unlabeled
> > > SID until defined in the policy) and then automatically update the
> > > in-memory state when a policy that defines the security context is
> > > loaded such that the inode immediately becomes accessible under the
> > > rules governing access to that context in the new policy.
> > [...]
> > > The second logical change introduces the
> > > support for setting invalid contexts by privileged processes, both via
> > > setxattr() and via /proc/self/attr/fscreate, which is the more
> > > controversial aspect.
> >=20
> > I am still not convinced that we actually need this second change.
> >=20
> > In http://marc.theaimsgroup.com/?l=3Dselinux&m=3D114677075207486&w=3D2,=
 I
> > outlined how rpm could work with the current kernel. I think this scheme
> > is preferable to changing the kernel, mainly because of two points:
> >=20
> > * It makes it possible to later confine rpm more strictly:
> >   If you load policy before installing the package, you can use the
> >   policy server to prevent rpm from loading certain policies; rpm will
> >   only be able to put labels on disk it is allowed to by policy.
> >   If you load policy after package installation, rpm needs the labelpriv
> >   privilege, so you can't confine rpm in any meaningful sense.
> >=20
> > * It allows rpm to know beforehand if the policy module will actually=
=20
> >   apply on top of the current system policy (which is important if you=
=20
> >   think of the differences between strict and targeted policy). It is
> >   better to abort install before than to have invalid labels on disk
> >   later.
> >=20
> > As I didn't receive any response regarding my posting, I'd like to ask:
> > What prevents you from implementing it in a way similar to what I
> > described?
> > RPM already has trigger scripts so from the outside it looks like it
> > shouldn't be that hard to implement.
> >=20
>=20
> To get some realtime discussion going on this issue a telecon was held
> with Red Hat, Tresys, and Steve participating. I'll try to summarize the
> problems with the approaches that you, Josh, and I were pushing that
> came out during that telecom. This is in the context of rpm, but I
> believe that the problems are more general.
>=20
> There are two basic ways to ensure that the policy needed by an rpm is
> installed before that rpm: use package dependencies to make certain that
> separate policy rpms are installed before rpms that require them or, as
> you suggest, collect and install all of the policies from all of the
> rpms at the start of the transaction.
>=20
> The first solution does not work because it is not possible to order rpm
> installation within a transaction based on dependencies because of
> mutual and circular dependencies. There is _no_ general solution to
> sorting packages so that dependencies are met at every step of the
> transaction in the face of circular or mutual dependencies. Basically,
> topological sorting only works for directed _acyclic_ graphs (see
> http://en.wikipedia.org/wiki/Topological_sorting). Instead, rpm makes a
> more general guarantee that the dependencies will be met at the end of
> the transaction, which is not sufficient for our needs.
>=20
> The second solution, which you describe, has two problems. As rpm works
> now there are many circumstances, like network installations, where a
> transaction begins without all of the rpms. Changing this would not only
> be difficult, it is not clear that it would be desirable.
>=20
> Even if all of the rpms were available, there are many potential
> problems when a policy upgrade depends on a library or tool upgrade
> (e.g., libsepol or semodule). This leads directly back to the dependency
> problems.
>=20
> This leads me to conclude that package managers may need to be able to
> set raw contexts that are not currently valid. It is not a pleasant
> trade-off, but it does have potential side benefits for backup and
> restore tools.

Thank you for your explanation.
I see that these are very difficult issues, but I must admit that I
still feel very uneasy about the proposed changes.

So let me suggest one more possibility:
rpm installs the package, puts the labels on disk and afterwards
installs the policy (like Dan proposed originally).=20
EXCEPT: Whenever rpm finds that the label it wants to put on disk is not
valid in the current policy, it labels the file as unlabeled_t (or some
other special label). After rpm has installed the policy, it relabels
the guilty files. This adds no overhead - rpm already knows the paths and
the labels, and it would have had to visit the files anyway to verify
their labels -, looks exactly the same from the outside, doesn't require
kernel changes and makes it possible to later restrict rpm.

Now, you can't decline such an offer, can you? ;-)

Or am I missing something fundamental here?

Thomas


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEbLmcD9qpeVMU938RAn7DAJ995sSUB8zna4NxwbI3E1udp9Mf6wCfd3mv
ru5EIJ+reaSX6WgcTeSfLfU=
=Gw96
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
