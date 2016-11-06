Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA6Lnq0r022074
 for <selinux@tycho.nsa.gov>; Sun, 6 Nov 2016 16:49:52 -0500
Received: by mail-wm0-f48.google.com with SMTP id f82so85554621wmf.1
 for <selinux@tycho.nsa.gov>; Sun, 06 Nov 2016 13:49:50 -0800 (PST)
Subject: Re: setsebool or audit2allow rule
To: Vaughn Clinton <vclinton@msn.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <DM5PR20MB1499D8228FF526F3A78CA3C4CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
 <1ce1961b-6766-6f8f-85d8-e081757174ef@gmail.com>
 <DM5PR20MB14997374142FEB060A14ABF0CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <f282e5fc-612f-5739-9c49-445d5eaeb848@gmail.com>
Date: Sun, 6 Nov 2016 22:49:43 +0100
MIME-Version: 1.0
In-Reply-To: <DM5PR20MB14997374142FEB060A14ABF0CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1KCt0IsfmmCQNMLK3EjMg9uKwri0nJw9q"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1KCt0IsfmmCQNMLK3EjMg9uKwri0nJw9q
Content-Type: multipart/mixed; boundary="TqnTmhn5R6UDiJcgPwUSuNsmVSbtgQ11w";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Vaughn Clinton <vclinton@msn.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <f282e5fc-612f-5739-9c49-445d5eaeb848@gmail.com>
Subject: Re: setsebool or audit2allow rule
References: <DM5PR20MB1499D8228FF526F3A78CA3C4CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
 <1ce1961b-6766-6f8f-85d8-e081757174ef@gmail.com>
 <DM5PR20MB14997374142FEB060A14ABF0CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
In-Reply-To: <DM5PR20MB14997374142FEB060A14ABF0CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>

--TqnTmhn5R6UDiJcgPwUSuNsmVSbtgQ11w
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/06/2016 10:43 PM, Vaughn Clinton wrote:
> No, I'm running FireFox as a normal user.
>=20
>=20

Can you consistently reproduce this issue? Linux capabilities (like
dac_override), are a way to partition root capabilities. The fact that
your firefox plugin container wanted the dac_override Linux capability
indicates to me that the process may have been associated with uid 0.

> Thanks for responding.
>=20
>=20
> Cheers,
>=20
>=20
> ________________________________
> From: Selinux <selinux-bounces@tycho.nsa.gov> on behalf of Dominick Gri=
ft <dac.override@gmail.com>
> Sent: Sunday, November 6, 2016 1:10 PM
> To: selinux@tycho.nsa.gov
> Subject: Re: setsebool or audit2allow rule
>=20
> On 11/06/2016 08:58 PM, Vaughn Clinton wrote:
>> I'm trying to understand and looking for clarity with future events  w=
hen presented with an option to either generate an allow rule using audit=
2allow or to execute setsebool to resolve an AVC denial, which would be c=
onsidered the correct option given the following event below?  I can't se=
em to find the answer via Google or maybe I'm phrasing the question incor=
rectly.
>>
>=20
> Are you running firefox as root? If so, then it might be a better idea
> to not run firefox as root.
>=20
>>
>> Thanks in advance.
>>
>>
>> Cheers,
>>
>>
>> **********************************************************************=
*********************
>>
>>
>> Here's the query out:
>>
>>
>> sealert -l 4ae65592-42a8-4141-8977-fdef20ee84aa
>> SELinux is preventing plugin-containe from using the dac_override capa=
bility.
>>
>> *****  Plugin mozplugger (87.7 confidence) suggests   ****************=
********
>>
>> If you want to use the plugin package
>> Then you must turn off SELinux controls on the Firefox plugins.
>> Do
>> # setsebool -P unconfined_mozilla_plugin_transition 0
>>
>> *****  Plugin dac_override (12.1 confidence) suggests   **************=
********
>>
>> If you want to help identify if domain needs this access or you have a=
 file with the wrong permissions on your system
>> Then turn on full auditing to get path information about the offending=
 file and generate the error again.
>> Do
>>
>> Turn on full auditing
>> # auditctl -w /etc/shadow -p w
>> Try to recreate AVC. Then execute
>> # ausearch -m avc -ts recent
>> If you see PATH record check ownership/permissions on file, and fix it=
,
>> otherwise report as a bugzilla.
>>
>> *****  Plugin catchall (1.66 confidence) suggests   ******************=
********
>>
>> If you believe that plugin-containe should have the dac_override capab=
ility by default.
>> Then you should report this as a bug.
>> You can generate a local policy module to allow this access.
>> Do
>> allow this access for now by executing:
>> # ausearch -c 'plugin-containe' --raw | audit2allow -M my-plugincontai=
ne
>> # semodule -X 300 -i my-plugincontaine.pp
>>
>>
>> Additional Information:
>> Source Context                unconfined_u:unconfined_r:mozilla_plugin=
_t:s0-s0:c0.c1023
>> Target Context                unconfined_u:unconfined_r:mozilla_plugin=
_t:s0-s0:c0.c1023
>> Target Objects                Unknown [ capability ]
>> Source                        plugin-containe
>> Source Path                   plugin-containe
>> Port                          <Unknown>
>> Host                          <removed>
>> Source RPM Packages
>> Target RPM Packages
>> Policy RPM                    selinux-policy-3.13.1-191.19.fc24.noarch=

>> Selinux Enabled               True
>> Policy Type                   targeted
>> Enforcing Mode                Enforcing
>> Host Name                     <removed>
>> Platform                      Linux <removed> 4.8.4-200.fc24.x86_64 #1=
 SMP Tue Oct 25 13:06:04 UTC 2016 x86_64 x86_64
>> Alert Count                   3
>> First Seen                    2016-11-06 10:23:58 MST
>> Last Seen                     2016-11-06 10:43:52 MST
>> Local ID                      4ae65592-42a8-4141-8977-fdef20ee84aa
>>
>> Raw Audit Messages
>> type=3DAVC msg=3Daudit(1478454232.260:418): avc:  denied  { dac_overri=
de } for  pid=3D5985 comm=3D"plugin-containe" capability=3D1  scontext=3D=
unconfined_u:unconfined_r:mozilla_plugin_t:s0-s0:c0.c1023 tcontext=3Dunco=
nfined_u:unconfined_r:mozilla_plugin_t:s0-s0:c0.c1023 tclass=3Dcapability=
 permissive=3D0
>>
>>
>> Hash: plugin-containe,mozilla_plugin_t,mozilla_plugin_t,capability,dac=
_override
>>
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.
>>
>=20
>=20
> --
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02
> Dominick Grift
>=20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--TqnTmhn5R6UDiJcgPwUSuNsmVSbtgQ11w--

--1KCt0IsfmmCQNMLK3EjMg9uKwri0nJw9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYH6V3AAoJECV0jlU3+UdpSzQMALc+7oJUlGxMmmZV/mXtraL8
seBGZjH5H3hOd6BB5aDWnbP6gwKZjO84erWrj1yVC9f3WL2mXde1n4fwTkPmFSDr
0xFZw74JpG1nX/ap9+1u5f2S9x3r0wxI/Txq0xsKslrkaGP47Byz4E66WcBcaQ72
pUHKi5bodNCDibeDz0EwERLsaxQLorzSGDqLDKqijXfslVWNOCFTy5L0E6NZROWz
64oUkd3qYp/rAQULq8xEl9uVh1V4QxkiB45hLf5xhHgnF9YP6HwSv/IESArkqaRF
V0r0t2i1UxhGam6wvZ56mDjLb5DKoZ2j4mJcZ5Msbqt+sXPxf3SbcqTlk0t0R8Nl
U972vh47WuhFIgzNTLR/KdUDmtolAX4Srh+tsX3YvPv6nheCoGsgFuVQ9CwalF+V
Gh1oi+M28xWtp8ahlBwjABazMyrc5NigZ7OvekMVNRG/+esi387fpKJFHgIMtT0s
EdflwrUebEk2xJTJAyYn6ZZ95A20F/dJhjou6BHQGQ==
=7MlE
-----END PGP SIGNATURE-----

--1KCt0IsfmmCQNMLK3EjMg9uKwri0nJw9q--
