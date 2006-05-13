Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4DK0LxD010762
	for <selinux@tycho.nsa.gov>; Sat, 13 May 2006 16:00:26 -0400
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4DK0KU6028673
	for <selinux@tycho.nsa.gov>; Sat, 13 May 2006 20:00:20 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 13 May 2006 22:00:18 +0200
Date: Sat, 13 May 2006 22:00:16 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux-dev@tresys.com, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][SECMARK 05/08] Add new packet controls to SELinux
Message-Id: <20060513200016.GE7481@thorium.jmh.mhn.de>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei> <Pine.LNX.4.64.0605071136100.8588@d.namei> <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.64.0605081947400.19850@d.namei> <1147174138.32651.5.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.64.0605091146350.25693@d.namei> <20060510221146.GG8937@thorium.jmh.mhn.de> <1147351945.8341.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zs/RYxT/hKAHzkfQ"
In-Reply-To: <1147351945.8341.114.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Smalley <sds@tycho.nsa.gov> [2006-05-11 14:48]:
> On Thu, 2006-05-11 at 00:11 +0200, Thomas Bleher wrote:
> > I'd prefer a config option because it makes it possible to load old
> > policy without changing things beyond the kernel. It also alerts people
> > that they will need to upgrade their userland before they switch to the
> > next kernel.
>=20
> I agree with the first point.  I'm not sure a config option helps much
> with the latter point - most people likely would just re-use an
> existing .config and not notice that introduction of a new option.

I always use "make oldconfig" but maybe I'm in the minority.

> > Remember: Not all people use distro kernels (or have selinux userland
> > provided by their distro). It's not nice to break compatibility without
> > a proper notice in advance.
> >=20
> > I think there is a tendency here to break backwards compatibility[1]
> > because "RedHat will fix it". This gives SELinux a reputation of "breaks
> > regularly, maintainers don't care for their users". We should avoid this
> > if at all possible.
>=20
> In truth, the introduction of new checks and new policy binary formats
> has actually caused problems in Fedora as well, as the kernel, patched
> userland components, and core SELinux components are maintained by
> different people, so they aren't always properly synchronized.
>=20
> > (Possibly crazy idea: Would it be possible to change the module format
> > so that the kernel recognizes permissions which are not defined in the
> > loaded policy at all and automatically allows them? This would allow us
> > to define new permissions (e.g. for decomposing CAP_SYS_ADMIN) without
> > needing comlex compatibility code or breaking systems.)
>=20
> Changing the module format isn't sufficient for that, as the kernel
> doesn't see the module format.  You'd have to change the kernel binary
> policy format, if a format change is truly required.

Upps, that's what I meant actually.

> It isn't as simple as just allowing undefined permissions; there is the
> issue of how one maps the intent of a policy written against one set of
> permission checks into a different set of permission checks.  One
> example was the past introduction of fine-grained netlink classes and
> checks (which did bump the binary policy version, but that was a hack),
> where you needed to map the finer-grained netlink classes to the old
> single netlink class when using an older policy.  In the packet controls
> case, we have two different sets of per-packet permission checks, and
> automatically mapping the intent of a policy written in terms of one set
> to another is not really feasible, particularly as the newer checks rely
> on separate netfilter labeling of the packets based on iptables rules.
>=20
> I'm also a bit uneasy about the implications for reasoning about /
> making assurance arguments about the actual enforcement if we have such
> conditional checking and it becomes pervasive as we continue to add new
> checks / replace old checks.

I can understand that. I'm also a bit uneasy about the security
implications.

How about the following idea:
On policy load time, the kernel compares the list of classes (file,
packet, ...) and permissions (read, write, ...) with the ones defined in
the policy. If something is missing, the kernel alerts the user on the
console and through the audit system that the system may be unusable
because of missing permissions and that he should update his SELinux
userspace.

I think this should solve the problem of how to inform the user without
compromising security and continually having to add cruft to the kernel
to support old policy.

What do you think about this?

Thomas


--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEZjrQD9qpeVMU938RAnvUAJ4/LpwgdSugejBs2VXJGlm/H/5oWQCgp42a
w7QaJqo6C5RHKDt6U7z1T2g=
=FN99
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
