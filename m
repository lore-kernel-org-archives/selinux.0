Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43Gpiri032661
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 12:51:44 -0400
Received: by mail-wm0-f49.google.com with SMTP id m123so65172258wma.0
 for <selinux@tycho.nsa.gov>; Wed, 03 May 2017 09:51:41 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id w29sm8208069edb.33.2017.05.03.09.51.39
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 May 2017 09:51:39 -0700 (PDT)
Date: Wed, 3 May 2017 18:51:37 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Policy capabilities: when to use and complications with using
Message-ID: <20170503165137.GA15940@julius>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
In-Reply-To: <1493828056.15269.9.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 12:14:16PM -0400, Stephen Smalley wrote:
> Looking at adding a map permission for mmap [1], and thinking about
> whether it needs to be wrapped by a policy capability.  On the one
> hand, we made the open permission depend on a policy capability, but on
> the other hand, we haven't done that for other cases where we simply
> added a check of a new permission (recent examples include prlimit
> checking and module_load).  Compatibility for new permission checks is
> generally covered in Linux distributions via handle_unknown=3Dallow, and
> in Android where handle_unknown=3Ddeny, the kernel and policy are not
> independently updated so we can keep them properly synchronized without
> needing such compatibility measures.
>=20
> It seems like we generally reserve the use of policy capabilities for
> when there is a more fundamental change in logic that wouldn't be
> covered by handle_unknown.  All of the current policy capabilities
> except for open_perms seem to fit into that category; they change what
> permissions/classes are checked rather than merely adding a new check,
> or they change when checks are applied, or they alter labeling
> behavior.  Even if that is our standard, we haven't consistently
> defined new policy capabilities for all such changes, e.g. for
> distinguishing non-init user namespace capability checks (commit
> 8e4ff6f228e4722cac74db716e308d1da33d744f) or for the earlier updating
> of netlink socket classes (commit
> 6c6d2e9bde1c1c87a7ead806f8f5e2181d41a652).  Those changes don't break
> existing policies because of handle_unknown=3Dallow, but since they are
> actually changing what is checked and not merely adding new checks,
> they technically ought to have been wrapped (with handle_unknown=3Dallow,
> they could end up allowing what would have been previously denied due
> to changes in the classes).
>=20
> Part of the reason that we tend to not introduce a new policy
> capability more often is that it is painful to do so currently.  We
> have to patch libsepol to recognize the new capability and patch the
> policy to declare it (although for the latter we can now declare them
> via a CIL module without modifying the base policy).  And since the
> policy or module won't build without the updated libsepol, we can't
> turn on the capability by default in refpolicy without making it
> dependent on a new libsepol version.  That's why extended_socket_class
> isn't yet enabled in refpolicy, for example.  That causes enablement
> and adoption to lag behind.  It also makes it harder to test the new
> kernel feature in the first place.

I would like to see Fedora package the RC's in Rawhide as well (other distr=
ibutions could help by packaging the RC's in unstable as well). That would =
atleast make the RC's a bit more accessible.
In Fedora it is usually not the kernel that is the problem, it is user spac=
e that is generally to old. And as you've said policy is no longer a proble=
m with CIL.

>=20
> We could possibly look into lighter weight support for policy
> capabilities.  If the policy compiler toolchain left the capability
> names as strings in the kernel policy (new binary format version), then
> we would no longer need to update libsepol for each new policy
> capability.  The kernel would then turn the list into the bitmap
> internally.  The downside is that we would lose validation of the
> capability names when policy is built, and it isn't clear how the
> kernel should handle unknown names (presently the kernel will simply
> ignore any unknown capabilities in the bitmap).  Failing at policy load
> time would mean we can't enable the capability in policy without making
> it depend on a particular kernel version.
>=20
> The lack of any direct relationship between policy capabilities and the
> classes/permissions they affect also can be misleading.  For example,
> someone booting a recent kernel might see warnings about undefined
> classes introduced by the extended_socket_class feature and add those
> class definitions to their policy, which will silence the kernel
> warning and make them think that they are actually using those classes
> now.  But they won't actually get used until they declare the
> capability too in their policy, and the kernel doesn't warn about that
> (nor does it necessarily make sense to do so, since that may be a
> conscious choice by the policy author).  The kernel could however log
> each policy capability and its state as part of its normal logging and
> leave it up to the reader to decide whether those values are correct or
> not.  We also had talked originally about checkpolicy and friends
> possibly warning on inconsistencies, while leaving it up to the policy
> author.
>=20
> So:
>=20
> 1) Should we investigate lighter weight support for policy
> capabilities, and if so, how?
>=20
> 2) Should the kernel log information about enabled/disabled policy
> capabilities in much the same manner as it does for undefined
> classes/permissions?
>=20
> 3) Should the policy compiler toolchain warn the user if a policy
> capability is not declared and classes/permissions are used in rules
> that will only be used if that policy capability is declared?  And
> similarly if a policy capability is declared but the corresponding
> classes/permissions are not used in any rules?
>=20
> 4) Do we need/want a policy capability for map permission and other
> cases where we are only adding a new permission check? Or should we
> continue to reserve them for cases not addressed via handle_unknown?

Would the map permission "only add a new permission". The way i see it is t=
hat it will actually change the meaning of the "execute" existing permission

As a matter of fact: When we add map then what is execute for?

>=20
> [1] https://github.com/SELinuxProject/selinux-kernel/issues/13

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkKCpUACgkQJXSOVTf5
R2lVWQwAjXTAG+/GP0IIB4zGVH5a9VtWcoDK3LFJLwFK2YywD8Rq2lugnHYPXn66
fDAGxIkbvKzOAJBsyttjrBIPFuousJPM9qBGO3jDvrjVIMGCR2ZFrmEa7cXfjLFu
/AHekzJ+QM2sO0kfWGxjTPzCqZUQB2WDyZF0Ypu4P/5a8qgtDTwMfTGhtK73MGny
5TtJc9D9HMceGUArst67KqoJ/njKocHrmzil5sXoZVQFVGa2tcD/v8HfVkzOt5Rk
BK2sVxChxleGCepswBBPPhrgslt12B1ymJaxgLN52DGrYvLmQ+2skFVUV6lLnUHb
wIsvVBnrF7HJiNkIL+5rMxPCLklfyLy7e432+Z0nj27hySzmBhbWdpkae5q7JYwA
2qVhEeWbJcZzU+m6uJlRjz+LHeKLkqZ/wpz2ftxaBaZGqlatrotEhfZdRoz/+VEk
5B6yzHNjuBZJYEkt+1yplF174yYTk6heLB3E9Ho6dFDSVJ5xMoLjgfS//VCfvkOi
z3U2/6Yk
=Vgr3
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
