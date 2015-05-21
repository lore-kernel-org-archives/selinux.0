Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LH7Mp7026840
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 13:07:22 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4LH7J4T021642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 13:07:19 -0400
Received: from hulk.w.lan (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t4LH7Hkj024604
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 13:07:18 -0400
Message-ID: <555E10BE.900@redhat.com>
Date: Thu, 21 May 2015 19:07:10 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: add selinux_openssh_contexts_path()
References: <1432224862-14659-1-git-send-email-plautrba@redhat.com>
 <20150521163153.GC683@x131e>
In-Reply-To: <20150521163153.GC683@x131e>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kawfNP3gx6xnB9AjW4maft74FTNDKt4gI"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kawfNP3gx6xnB9AjW4maft74FTNDKt4gI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dne 21.5.2015 v 18:31 Dominick Grift napsal(a):
>> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_=
config.c
>> index 0a80141..bec5f3b 100644
>> --- a/libselinux/src/selinux_config.c
>> +++ b/libselinux/src/selinux_config.c
>> @@ -48,8 +48,9 @@
>>  #define FILE_CONTEXT_SUBS_DIST 25
>>  #define LXC_CONTEXTS      26
>>  #define BOOLEAN_SUBS      27
>> -#define SYSTEMD_CONTEXTS  28
>> -#define NEL               29
>> +#define OPENSSH_CONTEXTS  28
>> +#define SYSTEMD_CONTEXTS  29
>> +#define NEL               30
>=20
> How come openssh_context becomes version 28 and systemd_contexts change=
s from 28 to 29?

It's just internal "index" in static file_path_suffixes_data. Since it's
not exported and it's used only in libselinux/src/selinux_config.c,
the idea was to have it an alphabetic order therefore it's put before
SYSTEMD_CONTEXTS.

Maybe it would be better to just add a new values to the end of list.

Petr

>=20
>> =20
>>  /* Part of one-time lazy init */
>>  static pthread_once_t once =3D PTHREAD_ONCE_INIT;
>> @@ -491,6 +492,13 @@ const char *selinux_lxc_contexts_path(void)
>> =20
>>  hidden_def(selinux_lxc_contexts_path)
>> =20
>> +const char *selinux_openssh_contexts_path(void)
>> +{
>> +    return get_path(OPENSSH_CONTEXTS);
>> +}
>> +
>> +hidden_def(selinux_openssh_contexts_path)
>> +
>>  const char *selinux_systemd_contexts_path(void)
>>  {
>>  	return get_path(SYSTEMD_CONTEXTS);
>> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinu=
x_internal.h
>> index 0abf1b4..844e408 100644
>> --- a/libselinux/src/selinux_internal.h
>> +++ b/libselinux/src/selinux_internal.h
>> @@ -83,6 +83,7 @@ hidden_proto(selinux_mkload_policy)
>>      hidden_proto(selinux_media_context_path)
>>      hidden_proto(selinux_x_context_path)
>>      hidden_proto(selinux_sepgsql_context_path)
>> +    hidden_proto(selinux_openssh_contexts_path)
>>      hidden_proto(selinux_systemd_contexts_path)
>>      hidden_proto(selinux_path)
>>      hidden_proto(selinux_check_passwd_access)
>> --=20
>> 2.4.1
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.
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
Petr Lautrbach



--kawfNP3gx6xnB9AjW4maft74FTNDKt4gI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVXhC+AAoJEGOorUuYLENz0zEP/3VE1IImLHwcn/gkYBZaIbtl
lWBz+rrxknP5GG9a3VlPVTl9wsSiewHFpkwlZHTs+pnZFu06NTxbwFz5l5+ZTiEd
su2PUxqRTQ2yyNL2z3rMhO2CBmKnykSKk8XQaDzho7zTt1/uZfiggGidJ4N4QvBH
IozcqV2z0tyoW9cao0ADM8DvIo+lRx8WCaYzMElQnGZPBvPIJ5kAE0MsrrviR6K5
gZthD+E6sF9IQrEuAVOszV8LIhFV7MOGWvHOHeANaDjFhQt5qXj3L6SIJg5qQwbJ
0J5mGrwGVZhQsOnPu3syF7lWpSzXOTHJShKBil0GjXh1yBf6R2G3znLPqItQfyJt
OTA+QwQk87bSULTkFOtoCHgTib3h19OwIpRRgHV9UZNxQ1yov4c47aues2sfu9fT
3T1nZtXghDhPWKZl/kV89aMh4kA/ftxx32JFyHtnsrRkWi3kc2TJOVFfU6T1+oh5
8a8FkAqclSh50YSpH9b/51ce0IMwqYjwAhvM+H59PEp4xlU7P7EyvbCot6aIXXrA
nXXK/tHffwoge8TC6cLpFCvqd5cpwVmwBHJEPNyPo+vtaUABBuyrO5rROrm/Mqb9
rFVyWa0XO2i8tcfJ08ZHqesmj1T5xnedTy4FGtIC7XBEJ8Dk8FWdJ6O1O8keW/AQ
aoYiFswM+7jk0MFxyXRC
=owCk
-----END PGP SIGNATURE-----

--kawfNP3gx6xnB9AjW4maft74FTNDKt4gI--
