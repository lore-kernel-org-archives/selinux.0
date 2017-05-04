Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44G85tP003697
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 12:08:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id z129so4331266wmb.1
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 09:07:52 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id d2sm1271141ede.31.2017.05.04.09.07.49
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 May 2017 09:07:49 -0700 (PDT)
Date: Thu, 4 May 2017 18:07:48 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Policy capabilities: when to use and complications with using
Message-ID: <20170504160748.GA29905@julius>
References: <1493828056.15269.9.camel@tycho.nsa.gov>
 <23de1ae5-c3ef-9c31-be15-4b9cde74157d@tycho.nsa.gov>
 <a1945b2a-d25b-87a9-df8f-4c33f78c5373@ieee.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
In-Reply-To: <a1945b2a-d25b-87a9-df8f-4c33f78c5373@ieee.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 08:18:10AM -0400, Chris PeBenito wrote:
> On 05/03/2017 03:35 PM, James Carter wrote:
> > On 05/03/2017 12:14 PM, Stephen Smalley wrote:
> > > Looking at adding a map permission for mmap [1], and thinking about
> > > whether it needs to be wrapped by a policy capability.  On the one
> > > hand, we made the open permission depend on a policy capability, but =
on
> > > the other hand, we haven't done that for other cases where we simply
> > > added a check of a new permission (recent examples include prlimit
> > > checking and module_load).  Compatibility for new permission checks is
> > > generally covered in Linux distributions via handle_unknown=3Dallow, =
and
> > > in Android where handle_unknown=3Ddeny, the kernel and policy are not
> > > independently updated so we can keep them properly synchronized witho=
ut
> > > needing such compatibility measures.
> > >=20
> > > It seems like we generally reserve the use of policy capabilities for
> > > when there is a more fundamental change in logic that wouldn't be
> > > covered by handle_unknown.  All of the current policy capabilities
> > > except for open_perms seem to fit into that category; they change what
> > > permissions/classes are checked rather than merely adding a new check,
> > > or they change when checks are applied, or they alter labeling
> > > behavior.  Even if that is our standard, we haven't consistently
> > > defined new policy capabilities for all such changes, e.g. for
> > > distinguishing non-init user namespace capability checks (commit
> > > 8e4ff6f228e4722cac74db716e308d1da33d744f) or for the earlier updating
> > > of netlink socket classes (commit
> > > 6c6d2e9bde1c1c87a7ead806f8f5e2181d41a652).  Those changes don't break
> > > existing policies because of handle_unknown=3Dallow, but since they a=
re
> > > actually changing what is checked and not merely adding new checks,
> > > they technically ought to have been wrapped (with handle_unknown=3Dal=
low,
> > > they could end up allowing what would have been previously denied due
> > > to changes in the classes).
> > >=20
> >=20
> > I think that there are three cases to consider. (I am ignoring removing
> > checks and/or permissions.)
> >=20
> > Case 1: Additional checks using existing permissions
> >=20
> > This case occurs when additional checks are added but they are very
> > similar to checks already being done and there does not seem to be any
> > benefit to adding a new permission. New policy is required to allow
> > access where additional checks apply. If this requires giving a domain
> > more access then desired, then probably a new permission should have
> > been created.
> > Compatibility:
> > new kernel - old policy
> >     Previously unchecked accesses may now be denied. Potential
> > compatibility issues.
> > old kernel - new policy
> >     No problems
> >=20
> >=20
> > Case 2: New checks using new permissions
> >=20
> > This case occurs when additional checks are added and they are not
> > similar to other checks, so a new permission would be beneficial. New
> > policy is required to allow access where the new checks apply.
> > Compatibility:
> > new kernel - old policy
> >     SEPOL_ALLOW_UNKNOWN - No problems, but not getting the security
> > benefits of the new check.
> >     SEPOL_DENY_UNKNOWN - Access attempts involving the new checks will
> > be denied instead of always being allowed like they were before the new
> > check was added. Potential compatibility issues.
> >     SEPOL_REJECT_UNKNOWN - Policy will not load.
> > old kernel - new policy
> >     No problem because no check will involve the new permission.
> >=20
> >=20
> > Case 3: Old checks now using new permissions
> >=20
> > This case occurs when there is a new use-case that makes splitting an
> > old permission into multiple ones worthwhile. New policy is required to
> > allow access where the new permissions are required.
> > Compatibility:
> > new kernel - old policy
> >     SEPOL_ALLOW_UNKNOWN - Previously denied access attempts will now be
> > allowed. Potential security issues.
> >     SEPOL_DENY_UNKNOWN - Accesses checked with the new permissions will
> > be denied. Potential compatibility issues.
> >     SEPOL_REJECT_UNKNOWN - Policy will not load
> > old kernel - new policy
> >     Denials will occur where old permission is no longer allowed because
> > only the new one needs to be allowed for a new kernel. Potential
> > security issues.
> >=20
> > Case 2 can be handled adequately by allowing unknown permissions, but
> > the other two cases (and case 3 particularly) need a policycap to avoid
> > problems.
> >=20
> > This seems to fit with what the practice has been.
> >=20
> > > Part of the reason that we tend to not introduce a new policy
> > > capability more often is that it is painful to do so currently.  We
> > > have to patch libsepol to recognize the new capability and patch the
> > > policy to declare it (although for the latter we can now declare them
> > > via a CIL module without modifying the base policy).  And since the
> > > policy or module won't build without the updated libsepol, we can't
> > > turn on the capability by default in refpolicy without making it
> > > dependent on a new libsepol version.  That's why extended_socket_class
> > > isn't yet enabled in refpolicy, for example.  That causes enablement
> > > and adoption to lag behind.  It also makes it harder to test the new
> > > kernel feature in the first place.
> > >=20
> > > We could possibly look into lighter weight support for policy
> > > capabilities.  If the policy compiler toolchain left the capability
> > > names as strings in the kernel policy (new binary format version), th=
en
> > > we would no longer need to update libsepol for each new policy
> > > capability.  The kernel would then turn the list into the bitmap
> > > internally.  The downside is that we would lose validation of the
> > > capability names when policy is built, and it isn't clear how the
> > > kernel should handle unknown names (presently the kernel will simply
> > > ignore any unknown capabilities in the bitmap).  Failing at policy lo=
ad
> > > time would mean we can't enable the capability in policy without maki=
ng
> > > it depend on a particular kernel version.
> > >=20
> >=20
> > I wonder if in the case of a new permission being added whether the
> > kernel could revert to the previous behavior if the new permission is
> > not in the policy. The new permission would be an implicit policy
> > capability.
>=20
> I'm not a fan of implicit behaviors.  It leads to unexplained behavior for
> the uninitiated.
>=20
>=20
> > Even if we just included strings in the kernel policy it would still be
> > nice to have something in libsepol, so that typos would be caught.
> >=20
> > > The lack of any direct relationship between policy capabilities and t=
he
> > > classes/permissions they affect also can be misleading.  For example,
> > > someone booting a recent kernel might see warnings about undefined
> > > classes introduced by the extended_socket_class feature and add those
> > > class definitions to their policy, which will silence the kernel
> > > warning and make them think that they are actually using those classes
> > > now.  But they won't actually get used until they declare the
> > > capability too in their policy, and the kernel doesn't warn about that
> > > (nor does it necessarily make sense to do so, since that may be a
> > > conscious choice by the policy author).  The kernel could however log
> > > each policy capability and its state as part of its normal logging and
> > > leave it up to the reader to decide whether those values are correct =
or
> > > not.  We also had talked originally about checkpolicy and friends
> > > possibly warning on inconsistencies, while leaving it up to the policy
> > > author.
> > >=20
> >=20
> > If the permissions acted as an implicit policy capability, that would
> > take care of this problem. The kernel could warn that since the new
> > permission is missing then these checks would be different.
> >=20
> > > So:
> > >=20
> > > 1) Should we investigate lighter weight support for policy
> > > capabilities, and if so, how?
> > >=20
> > > 2) Should the kernel log information about enabled/disabled policy
> > > capabilities in much the same manner as it does for undefined
> > > classes/permissions?
>=20
> Yes, I think it should.
>=20
>=20
> > > 3) Should the policy compiler toolchain warn the user if a policy
> > > capability is not declared and classes/permissions are used in rules
> > > that will only be used if that policy capability is declared?  And
> > > similarly if a policy capability is declared but the corresponding
> > > classes/permissions are not used in any rules?
>=20
> I think this is yes too.  For policy maintainers, it keeps reminding us
> there is something important to address (I admit I forgot about
> extended_socket_class).  For end users, it notifies them that their policy

Don't forget the cgroup_seclabel polcap. Paul Moore does a really good job =
at writing about these changes in his blog here:

http://www.paul-moore.com/blog/d/2017/05/linux-v411.html



> may not have the intended effect.
>=20
>=20
> > > 4) Do we need/want a policy capability for map permission and other
> > > cases where we are only adding a new permission check? Or should we
> > > continue to reserve them for cases not addressed via handle_unknown?
>=20
> I haven't come to a conclusion for a general rule, but for map, I'd expect
> that there wouldn't be a big impact by adding it in.  The (my guess) 99%
> would be handled by the one refpolicy interface that allows all the gener=
al
> shared lib access.
>=20
>=20
> > I know you also want this:
> > 5) Should CIL support adding a permission to a new class, so we don't
> > need to grab a source rpm and rebuild the whole policy from source just
> > to test a new permission?
> >=20
> > Jim
> >=20
> > > [1] https://github.com/SELinuxProject/selinux-kernel/issues/13
> > >=20
> >=20
> >=20
>=20
>=20
> --=20
> Chris PeBenito

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkLUdAACgkQJXSOVTf5
R2mPHgv/TS9KPrZnhTFbmZMvm7VHsbAM/aDrPYxMncTBiQngpDjJhj1DBt4wuzmR
dKnYGlww6gzldLMafrFHs88nsuKntlNrPPZlPZ1tQnpSaSee/B6dp5gWcBCqPAzk
YIbLLpvhvJyyi7yWBk99OAkT63m4ZtkH1dq9bBkDYe3cStNHep6qQyQiIdsom7TL
mnoLzm9g+7Al45jrNS4U79tIL+n3tlqWOGREtw8j7GsQg6WhBbPJIEt5a341zbjn
9iazTMCD8RFLImaNme3DBYkup29y3QERe4P8c0UvHHSwXZfYDn5NwhYtsAUc2AkK
3KbpOLo6q+zeHmvGs7wn7CaBZY9g/EAibN+kPdGOnuO8ZwjlvVbH5DjqjCdRfzbE
/Ziriz5zp9xphXWFa1avazI/hK2F/87GyAgkr8Yd/JsfNcE68dcH8iQ4G9y10o6V
meqOVVpvnhzLKphwNThysa1gs4oR/l+e+FeJb/jYGtemaCkGciDCAi/IyOaP5BLk
NLwGQk8p
=bTQI
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
