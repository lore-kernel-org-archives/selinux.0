Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r572O2Us025711
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2013 22:24:02 -0400
Message-ID: <51B14452.8040701@mthode.org>
Date: Thu, 06 Jun 2013 21:24:18 -0500
From: Matthew Thode <mthode@mthode.org>
Reply-To: mthode@mthode.org
MIME-Version: 1.0
To: "Patrick K., ITF" <cto@itechfrontiers.com>
CC: selinux@tycho.nsa.gov
Subject: Re: selinux on zfs(onlinux)
References: <51B125CE.5020801@mthode.org> <51B12FD4.5070206@itechfrontiers.com>
In-Reply-To: <51B12FD4.5070206@itechfrontiers.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MOMQOEJAANUQRDMNKEVV"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MOMQOEJAANUQRDMNKEVV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/06/2013 07:56 PM, Patrick K., ITF wrote:
> Hello,
>=20
> Excuse me,  But ZFS is a patented technology Owned by Oracle Inc., and
> only its implementation in CDDL was/is free.
>=20
> CDDL is incompatible with GPL,
>=20
> How come that ZFS can be used as root File System on Linux then?! , ZFS=

> cannot be integrated into kernel due to Legal reasons as explained,
> unless every recipient makes modification and compilation himself/herse=
lf.
>=20
> Even if you make a Module you cannot distribute it as binary, subject t=
o
> derivative work.
>=20
> If you distribute it as Module you must distribute source code, and the=

> recipient must compile the whole kernel (on every system that is being
> deployed).
>=20
> If you compile into binary module and distribute it, then due to linkin=
g
> you still violate CDDL (derivative work)
>=20
> All may result in getting sued by Oracle Inc. due to Patent violation.
>=20
>=20
> Best regards,
>=20
>    Patrick K.
>=20
> On 6/6/2013 8:14 PM, Matthew Thode wrote:
>> zfs is very close to usable as a root file-system with selinux, but is=

>> just missing one thing, it doesn't know what to set the root context t=
o
>> on mount.
>>
>> I am going to petition for this to be added as a property, but should =
it
>> be called rootcontext (want to make sure it's valid).
>>
>> system_u:object_r:fs_t is what I used just to get my system working
>> (including stuff like /usr, but meh).
>>
>>
>> here is the upstream bug if curious
>> https://github.com/zfsonlinux/zfs/issues/1504
>>
>>

zfs version 28 was released under the cddl, which means it is not able
to be integrated statically into the kernel and then redistributed (my
interpretation).  I can create my own static kernel image with zfs and
use it on my own though (and this is my preferred method of using it).

You are also able to use proprietary kernel modules as well.  Ever use
the AFS (filesystem) on Linux?  Here is a link as to what Linus has to
think on the mater.
http://linuxmafia.com/faq/Kernel/proprietary-kernel-modules.html

The CDDL provides a patent grant and the conflict only affects
distribution of linked binaries on the GPL end.  Since the modules are
from Solaris, they are not considered a derived work, so the derived
work in the GPL is irrelevant.  It is my interpretation that I can make
and distribute a module, but that is not the question here.

So, do you think the name for that zfs property would be accurate
(rootcontext)?

--=20
-- Matthew Thode


------enig2MOMQOEJAANUQRDMNKEVV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRsURYAAoJECRx6z5ArFrDhukP/0f/UXh9r/9m2ky6jTLUQEyd
afRB7c4DRW5Ks0teqnHQk7/FTGGpa4i6WY4pn+4f/6mowCpIUHF4IlYEt+MxB/Dd
jiIP/akTY4HX3gOsO2xe0LW+MIcvwfDao0+tcKIxyR42sw51C1b2IPs+Vd6ZhehU
HRygA3jZ6vnjfssXuvLqQw3IDn68y/60dPtniIHexA0DbxtjPR/k80w0SVXAswwM
R1b/Rd0FYCgvPsyu9m7Fvs2Ia70057Xwuu3BpAKgQdnYu6aYZ8CG4+xJPDjtuSfy
cQoNE8SntIg8MPEsLGoMNe8voNqe7X8RyJTE3U2bqdrF/dUBHMmW+SGqjDBmBqpf
EY1yQlH5wPT0F016a6gGcadW6FKr7R2VLWlT8gHTy6m9SXJbsfD9hm2HXA092Boo
JbxuhF15O8LPddbAd+BQyR7NsYJiiWZMGEkWPYQi61m1AQI2M7t5qJkXnepPWfMp
llix8tTYIdLf57e8X+gugS2GSFj6ly/1Chf0zuxFaEfiMbxsNHf54/tqgehvmD6L
slfQmB+NFxKKVW2lx8mHCXzO/3ay+YzxAB3jq86OnTMyYeK0zMk2iZftytYSPW4p
4Vbys2Zq6gvcy1JKX6QTVPxG3zfQMHabzKWKss3flaFN1zheQOVy/exSyoIYiQ0h
AgKQY76D5+QsDlK0g5AC
=tQ4d
-----END PGP SIGNATURE-----

------enig2MOMQOEJAANUQRDMNKEVV--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
