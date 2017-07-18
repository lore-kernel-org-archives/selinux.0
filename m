Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6IEI04w032192
 for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2017 10:18:01 -0400
Received: by mail-wr0-f195.google.com with SMTP id c24so96268wra.2
 for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2017 06:58:05 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id a20sm1501006edd.60.2017.07.18.06.57.00
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Jul 2017 06:57:00 -0700 (PDT)
Date: Tue, 18 Jul 2017 15:56:58 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170718135658.GA30912@julius.enp8s0.d30>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <20170716151512.GA4615@meriadoc.perfinion.com>
 <CAHC9VhRe=4N8S74_QD-rwAhRXLF6vceDt=Q0wx8TmTwgy6DNLA@mail.gmail.com>
 <1500383878.18445.1.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <1500383878.18445.1.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 09:17:58AM -0400, Stephen Smalley wrote:
> On Mon, 2017-07-17 at 15:54 -0400, Paul Moore wrote:
> > On Sun, Jul 16, 2017 at 11:15 AM, Jason Zaman <jason@perfinion.com>
> > wrote:
> > > On Fri, Jul 14, 2017 at 12:46:47PM -0400, Stephen Smalley wrote:
> > > > As systemd ramps up enabling NNP (NoNewPrivileges) for system
> > > > services,
> > > > it is increasingly breaking SELinux domain transitions for those
> > > > services
> > > > and their descendants.=A0=A0systemd enables NNP not only for servic=
es
> > > > whose
> > > > unit files explicitly specify NoNewPrivileges=3Dyes but also for
> > > > services
> > > > whose unit files specify any of the following options in
> > > > combination with
> > > > running without CAP_SYS_ADMIN (e.g. specifying User=3D or a
> > > > CapabilityBoundingSet=3D without CAP_SYS_ADMIN): SystemCallFilter=
=3D,
> > > > SystemCallArchitectures=3D, RestrictAddressFamilies=3D,
> > > > RestrictNamespaces=3D,
> > > > PrivateDevices=3D, ProtectKernelTunables=3D, ProtectKernelModules=
=3D,
> > > > MemoryDenyWriteExecute=3D, or RestrictRealtime=3D as per the
> > > > systemd.exec(5)
> > > > man page.
> > > >=20
> > > > The end result is bad for the security of both SELinux-disabled
> > > > and
> > > > SELinux-enabled systems.=A0=A0Packagers have to turn off these
> > > > options in the unit files to preserve SELinux domain
> > > > transitions.=A0=A0For
> > > > users who choose to disable SELinux, this means that they miss
> > > > out on
> > > > at least having the systemd-supported protections.=A0=A0For users w=
ho
> > > > keep
> > > > SELinux enabled, they may still be missing out on some
> > > > protections
> > > > because it isn't necessarily guaranteed that the SELinux policy
> > > > for
> > > > that service provides the same protections in all cases.
> > > >=20
> > > > commit 7b0d0b40cd78 ("selinux: Permit bounded transitions under
> > > > NO_NEW_PRIVS or NOSUID.") allowed bounded transitions under NNP
> > > > in
> > > > order to support limited usage for sandboxing programs.=A0=A0Howeve=
r,
> > > > defining typebounds for all of the affected service domains
> > > > is impractical to implement in policy, since typebounds requires
> > > > us
> > > > to ensure that each domain is allowed everything all of its
> > > > descendant
> > > > domains are allowed, and this has to be repeated for the entire
> > > > chain
> > > > of domain transitions.=A0=A0There is no way to clone all allow rules
> > > > from
> > > > descendants to their ancestors in policy currently, and doing so
> > > > would
> > > > be undesirable even if it were practical, as it requires leaking
> > > > permissions to objects and operations into ancestor domains that
> > > > could
> > > > weaken their own security in order to allow them to the
> > > > descendants
> > > > (e.g. if a descendant requires execmem permission, then so do all
> > > > of
> > > > its ancestors; if a descendant requires execute permission to a
> > > > file,
> > > > then so do all of its ancestors; if a descendant requires read to
> > > > a
> > > > symbolic link or temporary file, then so do all of its
> > > > ancestors...).
> > > > SELinux domains are intentionally not hierarchical / bounded in
> > > > this
> > > > manner normally, and making them so would undermine their
> > > > protections
> > > > and least privilege.
> > > >=20
> > > > We have long had a similar tension with SELinux transitions and
> > > > nosuid
> > > > mounts, albeit not as severe.=A0=A0Users often have had to choose
> > > > between
> > > > retaining nosuid on a mount and allowing SELinux domain
> > > > transitions on
> > > > files within those mounts.=A0=A0This likewise leads to unfortunate
> > > > tradeoffs
> > > > in security.
> > > >=20
> > > > Decouple NNP/nosuid from SELinux transitions, so that we don't
> > > > have to
> > > > make a choice between them. Introduce a nnp_nosuid_transition
> > > > policy
> > > > capability that causes the ability to transition under NNP/nosuid
> > > > to
> > > > be based on a nnp_nosuid_transition permission between the old
> > > > and new
> > > > contexts rather than typebounds.=A0=A0Domain transitions can then be
> > > > allowed
> > > > in policy without requiring the parent to be a strict superset of
> > > > all of
> > > > its children.
> > > >=20
> > > > With this change, systemd unit files can be left unmodified from
> > > > upstream.
> > > > SELinux-disabled and SELinux-enabled users will benefit from
> > > > retaining any
> > > > of the systemd-provided protections.=A0=A0SELinux policy will only
> > > > need to
> > > > be adapted to enable the new policy capability and to allow the
> > > > new permission between domain pairs as appropriate.
> > >=20
> > > A few things, the name is pretty awkward. my main issue with it is
> > > what
> > > if some other similar kind of thing is added in the future then
> > > we'll
> > > have nnp_nosuid_transition that should also cover it but the name
> > > wont
> > > cover it.
> >=20
> > Yes, I don't think anyone is in love with the name, but no one
> > offered
> > anything better; see the previous patch posting for some of that
> > discussion.=A0=A0If you have a better suggestion I would love to hear i=
t.
>=20
> Agreed, although I'm skeptical that there will be any "other similar
> kind of thing" added in the future that we would want to cover under
> the same permission.
>=20
> >=20
> > > Why do we want to disallow type-bounds to work even with the
> > > capability?
> > > it seems sensible to me to allow typebounds to transition even in
> > > the
> > > future. If we do then we probably dont need the policycap which
> > > seems
> > > less complicated.
> >=20
> > The suggestion to continue to support bounded domain transitions
> > seems
> > reasonable to me, although we would need to worry about which check
> > to
> > do first (bounded transition or process:nnp_nosuid_transition), and
> > how to limit the auditing/reporting so admins are confused by the
> > first check failing, yet the transition still taking place.=A0=A0None of
> > these are unsolvable problems, but it will likely need a bit more
> > work.
> >=20
> > I'm sure Stephen has some thoughts on this as well.
>=20
> Others (e.g. Dominick) seemed to take the opposite view on the earlier
> RFC discussion, i.e. that we should only check the new permission if
> the capability is enabled.  I specifically raised that as a question
> there.
>=20
> I'm willing to change it to fallback to checking for a bounded type,
> but that will mean two audit messages (I don't think we can just hide
> one of them) when neither is allowed.  That said, it is unlikely to
> cause much confusion in practice because users typically only look for
> and pay attention to AVC messages, and anyone using audit2allow will
> just end up allowing the permission, not the bounds.
>=20

I am not opposed to that either. It might be useful. For example you might =
want to use type_bounds for containers and nnp_nosuid_transition for system=
d services.
This whole situation is already messy anyway with or without this. I just f=
eel sorry for the support departments that need to support this.

> >=20
> > > also how are we thinking to do this in refpol? only add it
> > > specifically
> > > as needed? or would it be added to the execute_file_perms type
> > > macros?
> > > Although, grep typebounds is nowhere to be found currently in
> > > either
> > > refpol and gentoo's repo.
> >=20
> > I'm *really* hoping this new permission is only granted where
> > absolutely needed, which I hope should be rather small (see the patch
> > description and the discussion regarding systemd unit files).
>=20
> Actually, I'm not clear on that.  If systemd continues to expand the
> usage of these options in its unit files (which seems likely), then I
> could see this ultimately affecting all service domains and all of
> their descendants.  If it was only going to be a handful of domains,
> then the typebounds solution might be more tractable, albeit painful.
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlluE6UACgkQJXSOVTf5
R2lFOwv8CQ460uPDgKmXtA41lUrv+zIkZJVa8/7tjl5Cb1whtc3E8ULSkCR/PwH1
OhHLeflx3NZgfx5XzooY3BaO1od68zrfsneoAGj6S6mRVM49eUlERNTEVznJ4z6O
z7vNq8DNHDou+C3RI5luCZCmG8dBXbPYHW4XwCUKZ4KKz7ZNZIe84vImQ+YXADWZ
agahHzVJUCQLQXFMoabMTRIV6PERztktRhkOosfLaEcZ9i1gubY6Ml5sCJ5jTv+h
zmOM2qd5I/xEZ2hW60wvRR9Ko5woJppX0N9XWuBUhXmz0flQokAhqoQykK+lmut5
RIeH9/64iRu1HwKGwEC89Ctpioa4A/mCJCyN9whCboTJKX0gIZNU/x63ChO9eLN3
SAcO05LYxfjIm11cHqDyqPA2a4bDzBwaGHNTfrKIqscEE+ub9jYycEePQX6xKWKQ
By3/YpABVrHDZMxDZPRvfXZoc3QMnP3S/oBjhUgEjDygYMS2/XRUsYbRQgTQ5D1T
1hfND291
=ol6/
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
