Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4CKpOeP002296
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 16:51:24 -0400
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4CKqQlx017869
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 20:52:27 GMT
Received: by wwb39 with SMTP id 39so375273wwb.12
        for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 13:51:14 -0700 (PDT)
Message-ID: <4BEB14B5.9070707@gmail.com>
Date: Wed, 12 May 2010 22:51:01 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Restorecond and .xsession-errors
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDC84@EUSAACMS0703.eamcs.ericsson.se> <4BEB132F.4040002@gmail.com>
In-Reply-To: <4BEB132F.4040002@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9D91F10205F27C8750AAA3CD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D91F10205F27C8750AAA3CD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/12/2010 10:44 PM, Dominick Grift wrote:
> On 05/12/2010 09:10 PM, Alan Rouse wrote:
>> I'm down to one AVC left booting to a desktop in OpenSUSE 11.3 milesto=
ne 6.
>>
>> type=3DAVC msg=3Daudit(127369094.093:8): avc: denied { relabelfrom } f=
or pid=3D3089 comm=3D"restorecond" name=3D".xsession-errors" dev=3Dsda3 i=
no=3D127759 scontext=3Duser_u:user_r:user_t:s0 tcontext=3Dsystem_u:object=
_r:xauth_home_t:s0 tclass=3Dfile
>>
>> It looks to me like somewhere late in the boot, a windowing error occu=
rs and it attempts to log it to .xsession-errors.  For some reason at tha=
t point in time it attempts to relabel that file and is denied.
>>
>> The file context on .xsession-errors in the unprivileged user's home d=
irectory is user_u:object_r:user_home_t:s0
>>
>> However, when I run audit2allow on that avc, it says "This avc is a co=
nstraint violation.  You will need to add an attribute to either the sour=
ce or target type to make it work."
>>
>> Should I relabel .xsession-errors?  If so, to what?
>>
>>
>=20
> Here in Fedora that file is xdm_home_t but nonetheless both should have=

> the user_home_type attribute and $1_usertype (attribute for user
> domains) should be able to relabelto and relabelfrom user_home_types.
>=20
> In other words the user should be able to relabel the file.
>=20
> However, since the audit2allow say's that it is a constraint violation,=

> i am guessing that UBAC is enabled.
>=20
> That would mean the the user_u SELinux identity cannot interact with th=
e
> system_u SELinux identity of the files label.
>=20
> In that case, either deal with UBAC or disable UBAC.
>=20

Well actually. I bet the file context for this location has system_u
specified and restorecond just does what its told.

So restorecond (with runs as the user_u SELinux identity) is trying to
relabel the file ~/.xsession-errors (with the user_u SELinux identity)
to the specified context of system_u:object_r:xauth_home_t:s0. I am
guessing that is not allowed by the constraints. I wonder what the
proper solution is but my money say's the file context specification for
that and other locations in "user_u" home should have the user_u SELinux
identity. The question would then be how does genhomedircon know what
identity to use for the various different SELinux user homes.


--------------enig9D91F10205F27C8750AAA3CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvrFL8ACgkQMlxVo39jgT9G3wCdFxGhWOourFAWIyGNYzFuNYyL
kMIAn1cRmobEwl3T4AYNJZBFPTfDyrkl
=ggdH
-----END PGP SIGNATURE-----

--------------enig9D91F10205F27C8750AAA3CD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
