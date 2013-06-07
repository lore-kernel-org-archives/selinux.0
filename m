Message-ID: <51B23681.8070508@mthode.org>
Date: Fri, 07 Jun 2013 14:37:37 -0500
From: Matthew Thode <mthode@mthode.org>
Reply-To: mthode@mthode.org
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: selinux on zfs(onlinux)
References: <51B125CE.5020801@mthode.org> <51B2136F.10900@tycho.nsa.gov> <51B214EF.5090609@tycho.nsa.gov>
In-Reply-To: <51B214EF.5090609@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2FTCAGNILRDVVUPPIGXRD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FTCAGNILRDVVUPPIGXRD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/07/2013 12:14 PM, Stephen Smalley wrote:
> On 06/07/2013 01:07 PM, Stephen Smalley wrote:
>> On 06/06/2013 08:14 PM, Matthew Thode wrote:
>>> zfs is very close to usable as a root file-system with selinux, but i=
s
>>> just missing one thing, it doesn't know what to set the root context =
to
>>> on mount.
>>>
>>> I am going to petition for this to be added as a property, but should=
 it
>>> be called rootcontext (want to make sure it's valid).
>>>
>>> system_u:object_r:fs_t is what I used just to get my system working
>>> (including stuff like /usr, but meh).
>>>
>>>
>>> here is the upstream bug if curious
>>> https://github.com/zfsonlinux/zfs/issues/1504
>>
>> The mount options interpreted by SELinux are:
>> 1. context=3D (treat all inodes in the filesystem as if they had the
>> specified security context regardless of any on-disk extended attribut=
e
>> value),
>>
>> 2. fscontext=3D (treat the filesystem/superblock as if it had the
>> specified security context, used in certain permission checks affectin=
g
>> filesystem operations like mount and umount),
>>
>> 3. rootcontext=3D (treat the root inode in the filesystem as if it had=
 the
>> specified security context but the normal behavior for the rest, usefu=
l
>> for assigning an initial context to a root directory of e.g. a tmpfs
>> mount), and
>>
>> 4. defcontext=3D (treat any file that lacks an extended attribute as i=
f it
>> had the specified security context).
>>
>> The context you specified is a fscontext (fs_t), not one normally used=

>> for inodes.  But I'm not sure which one you meant to use or whether yo=
u
>> ultimately ought to support them all.
>=20
> Possibly a simpler method would be to just pass through any mount
> options unknown to zfs to the kernel to allow interpretation and use by=

> the vfs and/or security modules.  That would also allow use with other
> security modules.
>=20
>=20
ya, this is probably a better option.  I do think that rootcontext
matches closest though, but am confused as to how it is different then
fscontext.  I will suggest a more generic option though, thanks :D

--=20
-- Matthew Thode


------enig2FTCAGNILRDVVUPPIGXRD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRsjaMAAoJECRx6z5ArFrDxKwP/ApV8DGVnxHGhQr2tOBknZqC
au1q87cTzQ6W9SLD9Q2SI/l6E0Mk6XJLHf7Re4bPE1pz3Y3omis+hP7X+aG/Y5Yv
mjN/AzIBFS1GZsPaTFFhTK25NPWmL6h5r3druoREoSMTUjf5C5cRbgS89URHSWuS
knLiiaH96BnSvNHSV/2RbHsOWxPYGa8agG82HlqIjG2sA6gUVDvtkzqFAe13wb8U
RpgO3M5BO+R0GGHgFnkU+3NrO2Xhz52uyxAQoyXKnFxkjVJ6hIO6FjvLHR9mOh4y
YFszWwjKJB0yBQv44HdjOATR9VEMW2VtDTULG7JLjWrDsHNDmPlgLrm6AvFugPx2
y1ph0rAuAMQoe64z9IoMXDLYQbtz7Qz3fq2I4To3kSx69MtnenU0MGHT4gyEwJNp
WKpQ2Jl8IqTpXcdQOYrCc7pfzj5fT3Z53DQYbYFl7DxfsWguNq5tn0JrxNU9uqXm
Sj3Qxny6h+B8vqG5jBNSAcLN25b/yl9E3hTRpib2gSCz01xiVfe2ffq52pTiV+/b
22WRI7fytPIzUGGX0+UKUuUFaMCkIEDbhr1O8z11U5OAN60Fy2OiE2w0jH7pe28F
dTEx+OPvfsADOjwfPs3LjS2pZlgjpxSF4F7wFpBaUB6Zdyolf0Of2xl0GE1yIABs
tHNGw3y5fT7PZ/KagVVj
=KKNq
-----END PGP SIGNATURE-----

------enig2FTCAGNILRDVVUPPIGXRD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
