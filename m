Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA6KAr58014953
 for <selinux@tycho.nsa.gov>; Sun, 6 Nov 2016 15:10:53 -0500
Received: by mail-wm0-f46.google.com with SMTP id t79so141788820wmt.0
 for <selinux@tycho.nsa.gov>; Sun, 06 Nov 2016 12:10:49 -0800 (PST)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id o62sm9340151wmg.12.2016.11.06.12.10.47
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 06 Nov 2016 12:10:47 -0800 (PST)
Subject: Re: setsebool or audit2allow rule
To: selinux@tycho.nsa.gov
References: <DM5PR20MB1499D8228FF526F3A78CA3C4CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <1ce1961b-6766-6f8f-85d8-e081757174ef@gmail.com>
Date: Sun, 6 Nov 2016 21:10:38 +0100
MIME-Version: 1.0
In-Reply-To: <DM5PR20MB1499D8228FF526F3A78CA3C4CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DcMW50bxCmUeKAboFa7khnIAW0BQ2o8up"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DcMW50bxCmUeKAboFa7khnIAW0BQ2o8up
Content-Type: multipart/mixed; boundary="HqBkKGgxt1KvRa7rpK0xSV71HnDniHOeN";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <1ce1961b-6766-6f8f-85d8-e081757174ef@gmail.com>
Subject: Re: setsebool or audit2allow rule
References: <DM5PR20MB1499D8228FF526F3A78CA3C4CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>
In-Reply-To: <DM5PR20MB1499D8228FF526F3A78CA3C4CEA40@DM5PR20MB1499.namprd20.prod.outlook.com>

--HqBkKGgxt1KvRa7rpK0xSV71HnDniHOeN
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/06/2016 08:58 PM, Vaughn Clinton wrote:
> I'm trying to understand and looking for clarity with future events  wh=
en presented with an option to either generate an allow rule using audit2=
allow or to execute setsebool to resolve an AVC denial, which would be co=
nsidered the correct option given the following event below?  I can't see=
m to find the answer via Google or maybe I'm phrasing the question incorr=
ectly.
>=20

Are you running firefox as root? If so, then it might be a better idea
to not run firefox as root.

>=20
> Thanks in advance.
>=20
>=20
> Cheers,
>=20
>=20
> ***********************************************************************=
********************
>=20
>=20
> Here's the query out:
>=20
>=20
> sealert -l 4ae65592-42a8-4141-8977-fdef20ee84aa
> SELinux is preventing plugin-containe from using the dac_override capab=
ility.
>=20
> *****  Plugin mozplugger (87.7 confidence) suggests   *****************=
*******
>=20
> If you want to use the plugin package
> Then you must turn off SELinux controls on the Firefox plugins.
> Do
> # setsebool -P unconfined_mozilla_plugin_transition 0
>=20
> *****  Plugin dac_override (12.1 confidence) suggests   ***************=
*******
>=20
> If you want to help identify if domain needs this access or you have a =
file with the wrong permissions on your system
> Then turn on full auditing to get path information about the offending =
file and generate the error again.
> Do
>=20
> Turn on full auditing
> # auditctl -w /etc/shadow -p w
> Try to recreate AVC. Then execute
> # ausearch -m avc -ts recent
> If you see PATH record check ownership/permissions on file, and fix it,=

> otherwise report as a bugzilla.
>=20
> *****  Plugin catchall (1.66 confidence) suggests   *******************=
*******
>=20
> If you believe that plugin-containe should have the dac_override capabi=
lity by default.
> Then you should report this as a bug.
> You can generate a local policy module to allow this access.
> Do
> allow this access for now by executing:
> # ausearch -c 'plugin-containe' --raw | audit2allow -M my-plugincontain=
e
> # semodule -X 300 -i my-plugincontaine.pp
>=20
>=20
> Additional Information:
> Source Context                unconfined_u:unconfined_r:mozilla_plugin_=
t:s0-s0:c0.c1023
> Target Context                unconfined_u:unconfined_r:mozilla_plugin_=
t:s0-s0:c0.c1023
> Target Objects                Unknown [ capability ]
> Source                        plugin-containe
> Source Path                   plugin-containe
> Port                          <Unknown>
> Host                          <removed>
> Source RPM Packages
> Target RPM Packages
> Policy RPM                    selinux-policy-3.13.1-191.19.fc24.noarch
> Selinux Enabled               True
> Policy Type                   targeted
> Enforcing Mode                Enforcing
> Host Name                     <removed>
> Platform                      Linux <removed> 4.8.4-200.fc24.x86_64 #1 =
SMP Tue Oct 25 13:06:04 UTC 2016 x86_64 x86_64
> Alert Count                   3
> First Seen                    2016-11-06 10:23:58 MST
> Last Seen                     2016-11-06 10:43:52 MST
> Local ID                      4ae65592-42a8-4141-8977-fdef20ee84aa
>=20
> Raw Audit Messages
> type=3DAVC msg=3Daudit(1478454232.260:418): avc:  denied  { dac_overrid=
e } for  pid=3D5985 comm=3D"plugin-containe" capability=3D1  scontext=3Du=
nconfined_u:unconfined_r:mozilla_plugin_t:s0-s0:c0.c1023 tcontext=3Duncon=
fined_u:unconfined_r:mozilla_plugin_t:s0-s0:c0.c1023 tclass=3Dcapability =
permissive=3D0
>=20
>=20
> Hash: plugin-containe,mozilla_plugin_t,mozilla_plugin_t,capability,dac_=
override
>=20
>=20
>=20
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


--HqBkKGgxt1KvRa7rpK0xSV71HnDniHOeN--

--DcMW50bxCmUeKAboFa7khnIAW0BQ2o8up
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYH45CAAoJECV0jlU3+UdpGxsL/0Ie9kzIT/wyWtYwVZqlFH1j
YL3KXrCQUEQroLl1sYjT9ekMmpxyQ9GQ06kR5OQAKekPkCcG9f8JQV/QOY5i9MLi
PTqapF+4fkiP+LG2QYr5o1uy2ycZ7LBjwg6GuQq390yS0bx7YvxeklS8b7tum1JV
vAeBMZWtjsiwXW81uE8eWb2fpqRaLE3daPr0XuPQj1mAANn6a5/757WePZym+Nlm
4dn+bJxcw7xKGkxrf383isDNZj9OcgtruJDgE+OWIh0PB077QlVoyl1/jE9ghPgI
ZxwUEgfNkunC+7FOVihGn3FpF5w9Re7AIx4Xtml25Gr7+0IYd0XyEs+m5kDvUZ6u
53T9mFZ4Fd8n/hTIysdkKp9O0W+Ty6rikZ90w8710myQOn3PWdgxKTRq3boLR7T/
SRWnG8vkolUTQCwGIyo6eh9jLlLEK26E/BnAkpLsVwwGvqH5xthbvX7aA+90PdeW
4Vj4DDVksbqms9Emirxgv5cGyGhB1D4o5F265k4XaA==
=bRKe
-----END PGP SIGNATURE-----

--DcMW50bxCmUeKAboFa7khnIAW0BQ2o8up--
