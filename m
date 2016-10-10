Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9AHuDSu021373
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 13:56:13 -0400
Received: by mail-lf0-f65.google.com with SMTP id l131so11260409lfl.0
 for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2016 10:56:11 -0700 (PDT)
Subject: Re: should module_load be checked on a kernel module object?
To: Jeffrey Vander Stoep <jeffv@google.com>
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
 <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
 <f9266809-4000-1bb2-fcad-26ae69579d55@gmail.com>
 <CABXk95CjayBW2Opy9nA3Ds=k21EDPkXssurpeQsmHqAJ_FJFrQ@mail.gmail.com>
 <710b89e1-2457-8f1a-83ee-6c240322b692@gmail.com>
 <CABXk95BMHF1aRJNU=xFCABAKP8Nr20ayGqSOvBixzPR3QoPDHg@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <e44b71b0-0f6a-5328-221e-27d9ba16443d@gmail.com>
Date: Mon, 10 Oct 2016 19:56:03 +0200
MIME-Version: 1.0
In-Reply-To: <CABXk95BMHF1aRJNU=xFCABAKP8Nr20ayGqSOvBixzPR3QoPDHg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gqeXHT8sQPN8sMd3s3Pg8NNd1QbJTePWB"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gqeXHT8sQPN8sMd3s3Pg8NNd1QbJTePWB
Content-Type: multipart/mixed; boundary="PWjOx8vLwTTBpQ4N1A0ooICvXjJgE4xnt";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Message-ID: <e44b71b0-0f6a-5328-221e-27d9ba16443d@gmail.com>
Subject: Re: should module_load be checked on a kernel module object?
References: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
 <CABXk95CgrCk+th6Oc4yvDMhf1kJTZ11kyG+ByE9_vyZv-+zMSQ@mail.gmail.com>
 <f9266809-4000-1bb2-fcad-26ae69579d55@gmail.com>
 <CABXk95CjayBW2Opy9nA3Ds=k21EDPkXssurpeQsmHqAJ_FJFrQ@mail.gmail.com>
 <710b89e1-2457-8f1a-83ee-6c240322b692@gmail.com>
 <CABXk95BMHF1aRJNU=xFCABAKP8Nr20ayGqSOvBixzPR3QoPDHg@mail.gmail.com>
In-Reply-To: <CABXk95BMHF1aRJNU=xFCABAKP8Nr20ayGqSOvBixzPR3QoPDHg@mail.gmail.com>

--PWjOx8vLwTTBpQ4N1A0ooICvXjJgE4xnt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2016 07:50 PM, Jeffrey Vander Stoep wrote:
> On Mon, Oct 10, 2016 at 10:21 AM Dominick Grift <dac.override@gmail.com=
>
> wrote:
>=20
>> On 10/10/2016 07:16 PM, Jeffrey Vander Stoep wrote:
>>> No problem. We went through a number of iterations on this patch
>>> because of how confusing the target object for init_module is.
>>>
>>> On Android we neverallow use of init_module. Forcing userspace to use=

>>> finit_module allows us to enforce restrictions on kernel module
>>> origin. We only allow module loading from verified-boot protected
>>> partitions.
>>>
>>> https://android-review.googlesource.com/#/c/214021/
>>>
>>
>> That is a nice approach. After you reminded me, i started looking at m=
y
>> policy and i actually commented it (i rarely comment in my policy):
>>
>>                 ; for compatibility with Linux =3D< 4.6
>>                 (allow sys.load_kernel_module_subj_type_attribute self=

>> (system (module_load))))))
>>
>> So i suppose if i want to support Linux 4.6 then i might not have the
>> option to neverallow it.
>>
>>
> You shouldn't need this for compatibility. For kernel version <=3D 4.6,=
 the
> kernel hook for selinux_kernel_read_file is unused so no policy is need=
ed,
> it will already be allowed (or rather, not checked).
>=20
> The issue is that modprobe uses init_module() to load a kernel module. =
That
> would need to be updated to use finit_module() in order to disallow
> init_module().
>=20
> modprobe could be updated to behave more like insmod which defaults to
> using finit_module and falls back to init_module for old kernels.
> https://android.googlesource.com/platform/external/toybox/+/android-7.0=
=2E0_r14/toys/other/insmod.c#37
>=20
> I don't know what kind of control you have over kernels, but if you wan=
t a
> stable backport of the module_load patch, we backported to 4.4, 4,1, 3.=
18,
> 3.14, and 3.10:
> https://android-review.googlesource.com/#/q/61d612ea731e57dc510472fb746=
b55cdc017f371+owner:jeffv
>=20

Thank you. All is clear now. I will rephrase my comment and next time
look before asking because, even though the comment is inaccurate it,
together with the av allow rule still clearly indicated that this event
was to be expected (simply because in GNU/Linux some components use
init_module() and dont fall back to finit_module()

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--PWjOx8vLwTTBpQ4N1A0ooICvXjJgE4xnt--

--gqeXHT8sQPN8sMd3s3Pg8NNd1QbJTePWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX+9YzAAoJECV0jlU3+Udp1ccL+wR3Yn8swZ8VQ+1aHpuMdLse
wg2jzDA/FDnYYkxE4zHG3KQp00oVHADzW/2Jboe3yo3JVyipy+tiH2oFCtKExr42
oj6DxboChVDhWal3ULSQWnPyGQxaqMjQqvLnuCjo4qlGleTPUmxRgdUU2okWc2I8
GBDSGgHojskIRgxg9lYFrkmiBklHPjftN5OinBi0G2/HeysgD1TdGJwaR2w2wYY8
BllXLxTdLX+UQ+7a/yzmjctaa9/khoiHA5V9FrK+2GDvNg1pI0w/8hDEorEZVNgQ
Uv/e8MhMyVGNRyhvSBJrK0pdBbALm+kkUzWkGkDmxwF8xo4ZZZmweoRBiNBz+3YH
yFpMShDlbkapmmwBj//S39RUa/mTbYAvdLqBe0dEtUEwSqBoRJaTYy7Inmmi8DmT
bFahVUQqo8oK3ZT7J1h5J60WHV+F+wpFj4I7vCOaWVeb29l4TuH1UJpioKs8GbEF
AbLkMxewPzzNimcjiA3TIxlqBGcsxsBqVicnYdZgiA==
=ML6s
-----END PGP SIGNATURE-----

--gqeXHT8sQPN8sMd3s3Pg8NNd1QbJTePWB--
