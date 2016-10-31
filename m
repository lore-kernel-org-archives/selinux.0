Subject: Re: [RFC] Split up policycoreutils
To: Stephen Smalley <sds@tycho.nsa.gov>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <be8528f1-50ee-98da-91ea-0d0b0dfe0398@tycho.nsa.gov>
 <eaeb9dc4-e69f-47de-50ad-083ce97e1153@gmail.com>
 <98931665-f141-29e3-fb3a-9335e58874b0@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <8f15b444-4a9e-b5ac-a7de-0bb5aeda83f9@gmail.com>
Date: Mon, 31 Oct 2016 19:26:04 +0100
MIME-Version: 1.0
In-Reply-To: <98931665-f141-29e3-fb3a-9335e58874b0@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oBUcqcxlxWR0gqIXuK5N2T3qx8WBn4Vki"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oBUcqcxlxWR0gqIXuK5N2T3qx8WBn4Vki
Content-Type: multipart/mixed; boundary="EcEAS2DK9NtFd3B6TIe4B1tKFWoLeNh0l";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-ID: <8f15b444-4a9e-b5ac-a7de-0bb5aeda83f9@gmail.com>
Subject: Re: [RFC] Split up policycoreutils
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <be8528f1-50ee-98da-91ea-0d0b0dfe0398@tycho.nsa.gov>
 <eaeb9dc4-e69f-47de-50ad-083ce97e1153@gmail.com>
 <98931665-f141-29e3-fb3a-9335e58874b0@tycho.nsa.gov>
In-Reply-To: <98931665-f141-29e3-fb3a-9335e58874b0@tycho.nsa.gov>

--EcEAS2DK9NtFd3B6TIe4B1tKFWoLeNh0l
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/31/2016 07:23 PM, Stephen Smalley wrote:
> On 10/31/2016 02:15 PM, Dominick Grift wrote:
>> On 10/31/2016 07:05 PM, Stephen Smalley wrote:
>>> On 10/21/2016 01:47 PM, Stephen Smalley wrote:
>>>> Hi,
>>>>
>>>> policycoreutils started life as a small set of utilities that
>>>> were necessary or at least widely used in production on a
>>>> SELinux system. Over time though it has grown to include many
>>>> optional components, and even within a given subdirectory (e.g.
>>>> sepolicy) there seem to be a number of components that should
>>>> be optional (e.g. the dbus service). I'd like to propose that
>>>> we move a number of components out of policycoreutils into
>>>> their own top-level subdirectory (possibly grouping some of the
>>>> related ones together).
>>>>
>>>> Some possible components to move and the rationale for doing so
>>>> include:
>>>>
>>>> - gui: not required for operation.  Unsure if this is even used
>>>> outside of Fedora, or how widely it is used within Fedora
>>>> compared to the command line tools. Packaged separately by
>>>> Fedora as part of policycoreutils-gui.
>>>>
>>>> - mcstrans: not required for operation outside of MLS
>>>> environments (and even there, only if using that label encoding
>>>> functionality), not built by default even upstream (omitted
>>>> from policycoreutils/Makefile). Packaged separately in Fedora
>>>> as mcstrans.
>>>>
>>>> - restorecond: not required for operation, adds dbus and glib=20
>>>> dependencies, largely obsoleted by name-based type transition
>>>> support in the kernel.  Packaged separately in Fedora as
>>>> policycoreutils-restorecond.
>>>>
>>>> - sandbox: not required for basic operation of SELinux.
>>>> Packaged separately by Fedora as policycoreutils-sandbox.=20
>>>> restorecond - semodule_deps/expand/link: developer tools only,
>>>> not required for operation, unlike semodule.  Packaged
>>>> separately by Fedora as part of policycoreutils-devel.
>>>>
>>>> - sepolicy/{org.selinux*,selinux_client.py,selinux_server.py}:
>>>> D-BUS service for managing SELinux, not required for basic
>>>> operation, not desirable in high security environments.
>>>> Packaged separately by Fedora as part of policycoreutils-gui.
>>>> Could perhaps be combined with the gui above, although I think
>>>> they are logically distinct.
>>>>
>>>> We could of course go further, but those seem to be the most
>>>> obvious candidates.
>>>>
>>>> Thoughts?
>>>
>>> For discussion purposes, I've pushed a splitpolicycoreutils
>>> branch that moves the above components and others identified in
>>> the discussion thread, and makes it easy to omit the non-core
>>> components from the build.  Take a look and see what you think.
>>> Known issues:
>>>
>>> - I did not deal with splitting the policycoreutils/po files and
>>> moving them around.  Not sure what the best way to handle that
>>> is.
>>>
>>> - python/sepolicy likely needs further rearrangement. I am
>>> unclear on the purpose/use of the desktop file and pixmaps; if
>>> those are only for the gui, then they can be moved to gui/, but I
>>> don't understand why they are called sepolicy* or located here.
>>> Also, should python/sepolicy/sepolicy/sedbus.py be moved over to
>>> dbus/ or stay here? Dan?
>>>
>>> - dbus/selinux_client.py (formerly=20
>>> policycoreutils/sepolicy/selinux_client.py) seems like leftover
>>> testing cruft.  Remove?
>>>
>>> - restorecond presently reuses source code directly from
>>> setfiles, so building it as a separate package may be a nuisance.
>>> OTOH, I'm not entirely clear on whether restorecond needs to be
>>> kept around at all anymore?
>>>
>>> - policycoreutils/sepolgen-ifgen contains a single C program,=20
>>> sepolgen-ifgen-attr-helper, that is only used by=20
>>> python/audit2allow/sepolgen-ifgen.  Any reason to not just
>>> coalesce it into python/audit2allow even though it is not python
>>> itself?
>>>
>>> - After the restructuring, the only script left in
>>> policycoreutils is fixfiles.  Technically, that's not required
>>> for production either as one can always just run setfiles or
>>> restorecon directly, but distros seem to rely on it.  Is it worth
>>> moving just to free policycoreutils of any bash dependencies, and
>>> if so, where?
>>>
>>> - I moved policycoreutils/semodule_{deps,expand,link} into a new=20
>>> semodule-utils directory.  This might however be slightly
>>> confusing since semodule and semodule_package remain in
>>> policycoreutils since they are required and not merely for
>>> developers.  Feel free to suggest another name or structure.
>>> Actually, I guess semodule_package might be optional now with
>>> CIL, so perhaps that one can be moved too.
>>
>> sepolgen-ifgen is reference policy specific and thus not core
>>
>> also i would move run_init and newrole out of policycoreutils
>=20
> You didn't cc the list?
>=20
> I think the problem is that if we keep pulling that thread, we'll
> quickly get to the point where nothing is left in policycoreutils at
> all.  sepolgen-ifgen I agree with.  run_init and newrole have been
> part of core SELinux from the beginning and are pretty fundamental
> especially in a confined user environment.
>=20
>=20

Whoops, Cc'ing the list

Okay, yes, ideally my policycoreutils would look like this:

setfiles
load_policy
secon
restorecon
setsebool/getsebool

But i see your point and i can live with that


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--EcEAS2DK9NtFd3B6TIe4B1tKFWoLeNh0l--

--oBUcqcxlxWR0gqIXuK5N2T3qx8WBn4Vki
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYF4y9AAoJECV0jlU3+UdpuWIL/0vdg5ikUxuL5h5TaBsYsB6E
1k5X5E8X/Ah3oDlEpHS9NJo7rZyp5YAx3mjcrhkzQCW4HtLdte8w3hSheXw2jC/n
1jrhu9/nSaeKLMWY8JF8irdm/V9ACi6KuKBsb1mk6NDe72B1ppsgkHI9K1I416tZ
b827dT6ZMLjMO7cVdGcOHx7Ff0KYhp6bv84ngNEVtAEDL1bNQa7TzKyLMYfnmMJu
TIuINo2ap00iMXYZSeIm5sVEbgInr1CsXUn+Vb0/zgfn0SHGTgq8AijFxRt875QU
pWOA06ZmNECDI5Ie3dwci6074t1ODxiIfOW3IxPDvY/5oWOwymUwUj/sQWjSPW7A
5JL+rcNCMAmu9ritGzPEMON+Twl+PlRHE769EyJlJ8pMpaQcmECuQsBQ23SCoisd
C+sFBUk/BxmDSJrz9qGaABbPYfhEWLZEcPs7X+eIkfhADvf8549nx32wvZGucDLW
nB4qDageOPjP9PV4DSucFtTunkgwbhvBnMnlyM8Fhw==
=i+FU
-----END PGP SIGNATURE-----

--oBUcqcxlxWR0gqIXuK5N2T3qx8WBn4Vki--
