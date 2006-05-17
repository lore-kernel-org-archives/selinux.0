Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4H7sdF7005927
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 03:54:43 -0400
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4H7sb5q019868
	for <selinux@tycho.nsa.gov>; Wed, 17 May 2006 07:54:38 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 17 May 2006 09:54:36 +0200
Date: Wed, 17 May 2006 09:54:35 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        SELinux-dev@tresys.com, James Morris <jmorris@redhat.com>,
        Jeremy Katz <katzj@redhat.com>, Paul Nasrat <pnasrat@redhat.com>,
        James Antill <jantill@redhat.com>
Subject: Re: [RFC][PATCH] selinux:  introduce support for deferred mapping of inode security contexts
Message-Id: <20060517075435.GB7665@thorium.jmh.mhn.de>
References: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
In-Reply-To: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Added CCs from earlier thread]

* Stephen Smalley <sds@tycho.nsa.gov> [2006-05-15 18:31]:
> During the earlier thread on splitting policy into individual packages
> (using policy modules), it was requested that SELinux provide a way for
> a privileged process (like a package manager) to label an inode with a
> not-yet-defined security context (treating it as having the unlabeled
> SID until defined in the policy) and then automatically update the
> in-memory state when a policy that defines the security context is
> loaded such that the inode immediately becomes accessible under the
> rules governing access to that context in the new policy.
[...]
> The second logical change introduces the
> support for setting invalid contexts by privileged processes, both via
> setxattr() and via /proc/self/attr/fscreate, which is the more
> controversial aspect.

I am still not convinced that we actually need this second change.

In http://marc.theaimsgroup.com/?l=3Dselinux&m=3D114677075207486&w=3D2, I
outlined how rpm could work with the current kernel. I think this scheme
is preferable to changing the kernel, mainly because of two points:

* It makes it possible to later confine rpm more strictly:
  If you load policy before installing the package, you can use the
  policy server to prevent rpm from loading certain policies; rpm will
  only be able to put labels on disk it is allowed to by policy.
  If you load policy after package installation, rpm needs the labelpriv
  privilege, so you can't confine rpm in any meaningful sense.

* It allows rpm to know beforehand if the policy module will actually=20
  apply on top of the current system policy (which is important if you=20
  think of the differences between strict and targeted policy). It is
  better to abort install before than to have invalid labels on disk
  later.

As I didn't receive any response regarding my posting, I'd like to ask:
What prevents you from implementing it in a way similar to what I
described?
RPM already has trigger scripts so from the outside it looks like it
shouldn't be that hard to implement.

Thomas


--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEata7D9qpeVMU938RArPcAKCprvSHno2MtAcWIeJIkCLnn4eckACePO3O
MU7sipnxiShM9X9YR6qPL6U=
=kH8U
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
