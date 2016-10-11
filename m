Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9BGnB2f023232
 for <selinux@tycho.nsa.gov>; Tue, 11 Oct 2016 12:49:11 -0400
Received: by mail-lf0-f67.google.com with SMTP id b75so4702016lfg.3
 for <selinux@tycho.nsa.gov>; Tue, 11 Oct 2016 09:49:01 -0700 (PDT)
Subject: Re: should module_load be checked on a kernel module object?
To: Jeffrey Vander Stoep <jeffv@google.com>
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
 <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
 <f9266809-4000-1bb2-fcad-26ae69579d55@gmail.com>
 <CABXk95CjayBW2Opy9nA3Ds=k21EDPkXssurpeQsmHqAJ_FJFrQ@mail.gmail.com>
 <710b89e1-2457-8f1a-83ee-6c240322b692@gmail.com>
 <CABXk95BMHF1aRJNU=xFCABAKP8Nr20ayGqSOvBixzPR3QoPDHg@mail.gmail.com>
 <e44b71b0-0f6a-5328-221e-27d9ba16443d@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <b5da8ca0-a6d3-3291-4001-5e845e056b4b@gmail.com>
Date: Tue, 11 Oct 2016 18:48:43 +0200
MIME-Version: 1.0
In-Reply-To: <e44b71b0-0f6a-5328-221e-27d9ba16443d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dgtgOth1j93Rsirfc8Q2xKDHKW2VRpvN2"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dgtgOth1j93Rsirfc8Q2xKDHKW2VRpvN2
Content-Type: multipart/mixed; boundary="7TaQJBnBUhpHtwtDUxBUp3PBFmwv8IERb";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Message-ID: <b5da8ca0-a6d3-3291-4001-5e845e056b4b@gmail.com>
Subject: Re: should module_load be checked on a kernel module object?
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
 <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
 <f9266809-4000-1bb2-fcad-26ae69579d55@gmail.com>
 <CABXk95CjayBW2Opy9nA3Ds=k21EDPkXssurpeQsmHqAJ_FJFrQ@mail.gmail.com>
 <710b89e1-2457-8f1a-83ee-6c240322b692@gmail.com>
 <CABXk95BMHF1aRJNU=xFCABAKP8Nr20ayGqSOvBixzPR3QoPDHg@mail.gmail.com>
 <e44b71b0-0f6a-5328-221e-27d9ba16443d@gmail.com>
In-Reply-To: <e44b71b0-0f6a-5328-221e-27d9ba16443d@gmail.com>

--7TaQJBnBUhpHtwtDUxBUp3PBFmwv8IERb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2016 07:56 PM, Dominick Grift wrote:
> On 10/10/2016 07:50 PM, Jeffrey Vander Stoep wrote:
>> On Mon, Oct 10, 2016 at 10:21 AM Dominick Grift <dac.override@gmail.co=
m>
>> wrote:
>>
>>> On 10/10/2016 07:16 PM, Jeffrey Vander Stoep wrote:
>>>> No problem. We went through a number of iterations on this patch
>>>> because of how confusing the target object for init_module is.
>>>>
>>>> On Android we neverallow use of init_module. Forcing userspace to us=
e
>>>> finit_module allows us to enforce restrictions on kernel module
>>>> origin. We only allow module loading from verified-boot protected
>>>> partitions.
>>>>
>>>> https://android-review.googlesource.com/#/c/214021/
>>>>
>>>
>>> That is a nice approach. After you reminded me, i started looking at =
my
>>> policy and i actually commented it (i rarely comment in my policy):
>>>
>>>                 ; for compatibility with Linux =3D< 4.6
>>>                 (allow sys.load_kernel_module_subj_type_attribute sel=
f
>>> (system (module_load))))))
>>>
>>> So i suppose if i want to support Linux 4.6 then i might not have the=

>>> option to neverallow it.
>>>
>>>
>> You shouldn't need this for compatibility. For kernel version <=3D 4.6=
, the
>> kernel hook for selinux_kernel_read_file is unused so no policy is nee=
ded,
>> it will already be allowed (or rather, not checked).
>>
>> The issue is that modprobe uses init_module() to load a kernel module.=
 That
>> would need to be updated to use finit_module() in order to disallow
>> init_module().
>>
>> modprobe could be updated to behave more like insmod which defaults to=

>> using finit_module and falls back to init_module for old kernels.
>> https://android.googlesource.com/platform/external/toybox/+/android-7.=
0.0_r14/toys/other/insmod.c#37
>>
>> I don't know what kind of control you have over kernels, but if you wa=
nt a
>> stable backport of the module_load patch, we backported to 4.4, 4,1, 3=
=2E18,
>> 3.14, and 3.10:
>> https://android-review.googlesource.com/#/q/61d612ea731e57dc510472fb74=
6b55cdc017f371+owner:jeffv
>>
>=20
> Thank you. All is clear now. I will rephrase my comment and next time
> look before asking because, even though the comment is inaccurate it,
> together with the av allow rule still clearly indicated that this event=

> was to be expected (simply because in GNU/Linux some components use
> init_module() and dont fall back to finit_module()
>=20

After some deliberation i decided to conditionally support init_module()

It seems finit_module() requires that kernel modules aren't compressed.
Distributions compress kernel modules to save valuable space, and thus
even though kmod tries to use finit_module() by default it falls back to
init_module() since the modules are compressed.

By conditionally supporting init_module() one can make it work by
default but give one the opportunity to enable finit_module by
decompressing kernel modules and by toggling the boolean that allows
init_module() to false.


https://github.com/DefenSec/dssp/commit/12994152cce90a5cfecd7dbbc2ffb1c1d=
524ad98

https://github.com/DefenSec/dssp/commit/7f31dffeb2af83a23d2f47dd7cfbf6f40=
6a5d243
--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--7TaQJBnBUhpHtwtDUxBUp3PBFmwv8IERb--

--dgtgOth1j93Rsirfc8Q2xKDHKW2VRpvN2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX/RfyAAoJECV0jlU3+UdpL1cL/0Oy1nLrxaX7MQGfRjxYmDOJ
X4nvo/jBomtEOh3BUiUKXzlOgZmhbVuBn+T/db8041dgBhcTRFjU9hVjxDCQCMzU
01ek71eF09WG3noJ1WRloVwx3W6uNUPjfiKXJ8jI0EmOY3N5gmuak8Rom2HN+MpY
tKZCLMtRuOlpGK0IlR5sFURniYeVgZH7req4MaBN0v/GbbHT57xc6lyEt1YOYgwd
hiQNhb7Uz7yDx4YXZIxUUnY4a7XOD58L5c7xO6xZccpdRuTkkj5nvbhLsrdfTqTW
3a5TI6KWURHwLj6bMr6Y5iRBbE/Aw9s155QaiRQCShVYkWxNtuJssVCw76JCKh3O
8HqkjYD7ItCwKGlrelSRR+AIGmocPHWCZgpInGs8ANKXYTcuHuobXE67OVQ8oFAF
xIT5HgmDeBqTQpSbioMlipxx+EvWoRROoanlYiyavw6/nXEtqScHuuZXiyg9r2G/
KwcsYTREaCXYnS8suKDyLHWHweKN/QPS5+2y2HkfQA==
=cxPq
-----END PGP SIGNATURE-----

--dgtgOth1j93Rsirfc8Q2xKDHKW2VRpvN2--
