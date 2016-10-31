Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9VIBaDE017485
 for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2016 14:11:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id p190so13276920wmp.1
 for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2016 11:11:31 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id jx8sm31237072wjc.2.2016.10.31.11.11.29
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Oct 2016 11:11:29 -0700 (PDT)
Subject: Re: [RFC] Split up policycoreutils
To: selinux@tycho.nsa.gov
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <be8528f1-50ee-98da-91ea-0d0b0dfe0398@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <6317bf7a-1d25-31e6-9b2d-e0333a8b5e20@gmail.com>
Date: Mon, 31 Oct 2016 19:11:19 +0100
MIME-Version: 1.0
In-Reply-To: <be8528f1-50ee-98da-91ea-0d0b0dfe0398@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GKdMaacvrVfO7stdDw8cSO5Nba2QKOEsh"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GKdMaacvrVfO7stdDw8cSO5Nba2QKOEsh
Content-Type: multipart/mixed; boundary="lT1sH182aF6rkfroOVRBnjx3GVIxtFd01";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <6317bf7a-1d25-31e6-9b2d-e0333a8b5e20@gmail.com>
Subject: Re: [RFC] Split up policycoreutils
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <be8528f1-50ee-98da-91ea-0d0b0dfe0398@tycho.nsa.gov>
In-Reply-To: <be8528f1-50ee-98da-91ea-0d0b0dfe0398@tycho.nsa.gov>

--lT1sH182aF6rkfroOVRBnjx3GVIxtFd01
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/31/2016 07:05 PM, Stephen Smalley wrote:
> On 10/21/2016 01:47 PM, Stephen Smalley wrote:
>> Hi,
>>
>> policycoreutils started life as a small set of utilities that were
>> necessary or at least widely used in production on a SELinux system.
>> Over time though it has grown to include many optional components, and=

>> even within a given subdirectory (e.g. sepolicy) there seem to be a
>> number of components that should be optional (e.g. the dbus service).
>> I'd like to propose that we move a number of components out of
>> policycoreutils into their own top-level subdirectory (possibly groupi=
ng
>> some of the related ones together).
>>
>> Some possible components to move and the rationale for doing so includ=
e:
>>
>> - gui: not required for operation.  Unsure if this is even used outsid=
e
>> of Fedora, or how widely it is used within Fedora compared to the
>> command line tools. Packaged separately by Fedora as part of
>> policycoreutils-gui.
>>
>> - mcstrans: not required for operation outside of MLS environments (an=
d
>> even there, only if using that label encoding functionality), not buil=
t
>> by default even upstream (omitted from policycoreutils/Makefile).
>> Packaged separately in Fedora as mcstrans.
>>
>> - restorecond: not required for operation, adds dbus and glib
>> dependencies, largely obsoleted by name-based type transition support =
in
>> the kernel.  Packaged separately in Fedora as policycoreutils-restorec=
ond.
>>
>> - sandbox: not required for basic operation of SELinux.  Packaged
>> separately by Fedora as policycoreutils-sandbox.
>>  restorecond
>> - semodule_deps/expand/link: developer tools only, not required for
>> operation, unlike semodule.  Packaged separately by Fedora as part of
>> policycoreutils-devel.
>>
>> - sepolicy/{org.selinux*,selinux_client.py,selinux_server.py}: D-BUS
>> service for managing SELinux, not required for basic operation, not
>> desirable in high security environments. Packaged separately by Fedora=

>> as part of policycoreutils-gui.  Could perhaps be combined with the gu=
i
>> above, although I think they are logically distinct.
>>
>> We could of course go further, but those seem to be the most obvious
>> candidates.
>>
>> Thoughts?
>=20
> For discussion purposes, I've pushed a splitpolicycoreutils branch that=

> moves the above components and others identified in the discussion
> thread, and makes it easy to omit the non-core components from the
> build.  Take a look and see what you think.  Known issues:
>=20
> - I did not deal with splitting the policycoreutils/po files and moving=

> them around.  Not sure what the best way to handle that is.
>=20
> - python/sepolicy likely needs further rearrangement. I am unclear on
> the purpose/use of the desktop file and pixmaps; if those are only for
> the gui, then they can be moved to gui/, but I don't understand why the=
y
> are called sepolicy* or located here.  Also, should
> python/sepolicy/sepolicy/sedbus.py be moved over to dbus/ or stay here?=

> Dan?
>=20
> - dbus/selinux_client.py (formerly
> policycoreutils/sepolicy/selinux_client.py) seems like leftover testing=

> cruft.  Remove?
>=20
> - restorecond presently reuses source code directly from setfiles, so
> building it as a separate package may be a nuisance.  OTOH, I'm not
> entirely clear on whether restorecond needs to be kept around at all
> anymore?
>=20
> - policycoreutils/sepolgen-ifgen contains a single C program,
> sepolgen-ifgen-attr-helper, that is only used by
> python/audit2allow/sepolgen-ifgen.  Any reason to not just coalesce it
> into python/audit2allow even though it is not python itself?
>=20
> - After the restructuring, the only script left in policycoreutils is
> fixfiles.  Technically, that's not required for production either as on=
e
> can always just run setfiles or restorecon directly, but distros seem t=
o
> rely on it.  Is it worth moving just to free policycoreutils of any bas=
h
> dependencies, and if so, where?
>=20
> - I moved policycoreutils/semodule_{deps,expand,link} into a new
> semodule-utils directory.  This might however be slightly confusing
> since semodule and semodule_package remain in policycoreutils since the=
y
> are required and not merely for developers.  Feel free to suggest
> another name or structure.  Actually, I guess semodule_package might be=

> optional now with CIL, so perhaps that one can be moved too.

semodule itself is also optional and not only with CIL but also with
monolitic policy.

maybe:

semodule (just semodule)
semodule-utils (all the other semodule related)

>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--lT1sH182aF6rkfroOVRBnjx3GVIxtFd01--

--GKdMaacvrVfO7stdDw8cSO5Nba2QKOEsh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYF4lMAAoJECV0jlU3+UdpF44L+wY/gVg5loz+QEq26BNe0sQ0
i8darhG+Nd3aAF4oKqhYwMPpktm3OwqjhQbtltnKVztaTDdppA1G4QkMW/ZsP+ve
G3uRTusY6wIwyLbNGlG1J5uHrkP9i+rxO/w1qXRn4sOK1FfRPIYhWICnizbrTgh0
nfsuPvEXJBKZQ4wRSG36BLOgUk/MKekTG4do9+XEXu8PzxxGDlCrz+5q25gr/Z9x
LQ+eWNjJzlGky3aTx7csopI6FwvJMnqHuza/VCiHE6GHtQEBtF4YURyYJHKxKZ/F
JQTNEYNILTy1W0BOB68tcWan9XyjNnKy5Wcdzad5HL1s5uvVeTcjUrtDj9++MSDi
JPU1Mo0cJ29Ug3lQAw2SV+xLZBoApfejvTo+SfZovWDv2mwS9DD5+kiUBYlk4nTU
Erxs4vfk4V6+fc4pB/DnMwznaz0QPAvTH3G/WZQt0CW6vTBWX+sEoqiA21sLRm2F
df2a14VMTeYfdYHCotHEBewmWYN75Me3NjSb0rrX2w==
=9p/i
-----END PGP SIGNATURE-----

--GKdMaacvrVfO7stdDw8cSO5Nba2QKOEsh--
