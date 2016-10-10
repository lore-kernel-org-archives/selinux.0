Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9AFAnQS006264
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 11:10:49 -0400
Received: by mail-lf0-f47.google.com with SMTP id x79so131894505lff.0
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 08:10:47 -0700 (PDT)
Subject: Re: should module_load be checked on a kernel module object?
To: Jeffrey Vander Stoep <jeffv@google.com>
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
 <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <f9266809-4000-1bb2-fcad-26ae69579d55@gmail.com>
Date: Mon, 10 Oct 2016 17:10:39 +0200
MIME-Version: 1.0
In-Reply-To: <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iKtklKn5MudXksPwGwIOeSKGmCmiRcVLP"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iKtklKn5MudXksPwGwIOeSKGmCmiRcVLP
Content-Type: multipart/mixed; boundary="DatoGPx7iQC6ifJTk229uHfgIpJ1DSXPq";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Message-ID: <f9266809-4000-1bb2-fcad-26ae69579d55@gmail.com>
Subject: Re: should module_load be checked on a kernel module object?
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
 <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
In-Reply-To: <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>

--DatoGPx7iQC6ifJTk229uHfgIpJ1DSXPq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2016 05:02 PM, Jeffrey Vander Stoep wrote:
> When loading a kernel module using init_module the module is copied
> from memory of the calling process. In that case, the target really is
> the calling process. When using finit_module a file is passed to the
> kernel and that file is the target object.
>=20
> See the commit message that added module_load for a more complete
> description: https://marc.info/?l=3Dselinux&m=3D145988689809307&w=3D2
>=20

Thanks, Sorry about that.

> On Sun, Oct 9, 2016 at 1:10 AM, Dominick Grift <dac.override@gmail.com>=
 wrote:
>>
>> I encountered a system module_load event for the first time today.
>> Howver i am a bit surprised:
>>
>>
>> avc:  denied  { module_load } for  pid=3D473 comm=3D"modprobe"
>> scontext=3Dwheel.id:sysadm.role:lmc.subj:s0-s0:c0.c1023
>> tcontext=3Dwheel.id:sysadm.role:lmc.subj:s0-s0:c0.c1023 tclass=3Dsyste=
m
>> permissive=3D1
>>
>> Should that permission not have applied to a kernel module object
>> instead of "self"?
>> --
>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02=

>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02
>> Dominick Grift
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--DatoGPx7iQC6ifJTk229uHfgIpJ1DSXPq--

--iKtklKn5MudXksPwGwIOeSKGmCmiRcVLP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX+69vAAoJECV0jlU3+UdpoYwL/1DU/aLXkS4P1BmAREqOvvXf
m4A+zN9m3e95cHGhxOlVr4x15zibqOHbDTl8OTqupvC95g+ev2r3Y6M6gqCYVy97
0jixnmC04x2P7thMsh+mH9s+Cz2ED0Iq8Qm5qVgSVEzxkEpFWqjdSuL564ogCQgs
Jx6rynut/QvExNcZEG+vo4BeQ5rNR0KThRW4Gf0YVgGr71/ocg5y4ViLSYu+bROE
RWMSqfiuI4om8BWqNNKVtFPsNr75xRl4JbkQyIicCteIQAfpBg2+CZBEX840zkSj
oO7cWcyk8E8pHW7ntmKzho72zqANeft1V5Qsoff83S+I7lJXt9UrUXYve0tdJGnr
6oMOtWBFZB4sjuPlaiMcABWKXiinXV6a+ifgjLcgL3kF4Tb9zR2EHQVh3pQUNDFE
nnn9MhLyH7wJcLn0vBbCnMa7o/jDFhpBSHyh3LseUNkyTFIQHNf7EWuZFKO7m7Uz
zTgJmdrWXYz+PG63GR56qF2/sQTw+SkT/AElMkP30Q==
=l5WS
-----END PGP SIGNATURE-----

--iKtklKn5MudXksPwGwIOeSKGmCmiRcVLP--
