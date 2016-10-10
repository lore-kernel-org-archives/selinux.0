Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9AHLmIv018554
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 13:21:48 -0400
Received: by mail-lf0-f50.google.com with SMTP id b75so134600471lfg.3
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 10:21:46 -0700 (PDT)
Subject: Re: should module_load be checked on a kernel module object?
To: Jeffrey Vander Stoep <jeffv@google.com>
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
 <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
 <f9266809-4000-1bb2-fcad-26ae69579d55@gmail.com>
 <CABXk95CjayBW2Opy9nA3Ds=k21EDPkXssurpeQsmHqAJ_FJFrQ@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <710b89e1-2457-8f1a-83ee-6c240322b692@gmail.com>
Date: Mon, 10 Oct 2016 19:21:38 +0200
MIME-Version: 1.0
In-Reply-To: <CABXk95CjayBW2Opy9nA3Ds=k21EDPkXssurpeQsmHqAJ_FJFrQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SHMMDIK0DwJ5WDH8pRrBkoMNGS66eq4dK"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SHMMDIK0DwJ5WDH8pRrBkoMNGS66eq4dK
Content-Type: multipart/mixed; boundary="7xjUxlWXkPjLrJxF0dgTKc1Xm1ET7uLfL";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Message-ID: <710b89e1-2457-8f1a-83ee-6c240322b692@gmail.com>
Subject: Re: should module_load be checked on a kernel module object?
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
 <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
 <f9266809-4000-1bb2-fcad-26ae69579d55@gmail.com>
 <CABXk95CjayBW2Opy9nA3Ds=k21EDPkXssurpeQsmHqAJ_FJFrQ@mail.gmail.com>
In-Reply-To: <CABXk95CjayBW2Opy9nA3Ds=k21EDPkXssurpeQsmHqAJ_FJFrQ@mail.gmail.com>

--7xjUxlWXkPjLrJxF0dgTKc1Xm1ET7uLfL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2016 07:16 PM, Jeffrey Vander Stoep wrote:
> No problem. We went through a number of iterations on this patch
> because of how confusing the target object for init_module is.
>=20
> On Android we neverallow use of init_module. Forcing userspace to use
> finit_module allows us to enforce restrictions on kernel module
> origin. We only allow module loading from verified-boot protected
> partitions.
>=20
> https://android-review.googlesource.com/#/c/214021/
>=20

That is a nice approach. After you reminded me, i started looking at my
policy and i actually commented it (i rarely comment in my policy):

		; for compatibility with Linux =3D< 4.6
		(allow sys.load_kernel_module_subj_type_attribute self
(system (module_load))))))

So i suppose if i want to support Linux 4.6 then i might not have the
option to neverallow it.

> On Mon, Oct 10, 2016 at 8:10 AM, Dominick Grift <dac.override@gmail.com=
> wrote:
>> On 10/10/2016 05:02 PM, Jeffrey Vander Stoep wrote:
>>> When loading a kernel module using init_module the module is copied
>>> from memory of the calling process. In that case, the target really i=
s
>>> the calling process. When using finit_module a file is passed to the
>>> kernel and that file is the target object.
>>>
>>> See the commit message that added module_load for a more complete
>>> description: https://marc.info/?l=3Dselinux&m=3D145988689809307&w=3D2=

>>>
>>
>> Thanks, Sorry about that.
>>
>>> On Sun, Oct 9, 2016 at 1:10 AM, Dominick Grift <dac.override@gmail.co=
m> wrote:
>>>>
>>>> I encountered a system module_load event for the first time today.
>>>> Howver i am a bit surprised:
>>>>
>>>>
>>>> avc:  denied  { module_load } for  pid=3D473 comm=3D"modprobe"
>>>> scontext=3Dwheel.id:sysadm.role:lmc.subj:s0-s0:c0.c1023
>>>> tcontext=3Dwheel.id:sysadm.role:lmc.subj:s0-s0:c0.c1023 tclass=3Dsys=
tem
>>>> permissive=3D1
>>>>
>>>> Should that permission not have applied to a kernel module object
>>>> instead of "self"?
>>>> --
>>>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B=
02
>>>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C=
7B6B02
>>>> Dominick Grift
>>>>
>>>>
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to Selinux-request@tych=
o.nsa.gov.
>>
>>
>> --
>> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02=

>> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B=
6B02
>> Dominick Grift
>>


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--7xjUxlWXkPjLrJxF0dgTKc1Xm1ET7uLfL--

--SHMMDIK0DwJ5WDH8pRrBkoMNGS66eq4dK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX+84jAAoJECV0jlU3+UdpWxUL/RYJAKfU1uPWm2kKm+KZYggp
+o64o1mA0WBw+CDxYa+5RZRXHjiUag40rGNOLThqC/cwLWeeuAooHeejkZ6fOmDT
bpu6wmg/2jwMdo0T7t4h+5T3CuNSnwesfduCkM7yFbaIyXbpW9YVRv46QFfLFJ97
xtY4MZleIYiKMwJyLG5h09tUWGma59BYsgMVShAKO4BenhFqZRrB9CJyHOStypfH
uKf9QAUvbIlP8l3z/JrO+b8WflG5CeNAqYD1/Ho/7BAWfM2R/Jyklgk1X5Kx/sW6
lTv7jszctQ/ignmImamav8uMQXjWdDJ1Wyu+51boXwbkUCCRZo/cZ7wXZpiizEXP
sOAbDlYumLAWfo6YDJZI0q7o7iNstMKb1bJnu0y2tmF8cFYU0dts/R1amr7KaYbK
p18xNPKNwFm6+ZOFuBkGHQDTV52o6Iy4mPbt6rZLDZpUQlQJcLIdYxgGRRI+TdOM
+iEwcL8hMyQBMcPWRT6FOTqJpBip0wL2+p8f6hhnyA==
=pJK9
-----END PGP SIGNATURE-----

--SHMMDIK0DwJ5WDH8pRrBkoMNGS66eq4dK--
