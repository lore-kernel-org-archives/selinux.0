Message-ID: <5551F7F4.5050907@redhat.com>
Date: Tue, 12 May 2015 14:54:12 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com> <5550B1FE.5040304@tycho.nsa.gov>
 <5550B368.5020600@redhat.com> <5550B663.1070000@tycho.nsa.gov>
 <5550B6D4.4070002@tycho.nsa.gov> <5550B899.7060603@redhat.com>
 <5550C212.6090702@tycho.nsa.gov>
In-Reply-To: <5550C212.6090702@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="unQ8aKXiM4bxEdH4IkterS53rw1UH9URK"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--unQ8aKXiM4bxEdH4IkterS53rw1UH9URK
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/11/2015 04:52 PM, Stephen Smalley wrote:
> On 05/11/2015 10:11 AM, Petr Lautrbach wrote:
>> On 05/11/2015 04:04 PM, Stephen Smalley wrote:
>>> On 05/11/2015 10:02 AM, Stephen Smalley wrote:
>>>> On 05/11/2015 09:49 AM, Petr Lautrbach wrote:
>>>>> On 05/11/2015 03:43 PM, Stephen Smalley wrote:
>>>>>> On 05/11/2015 09:40 AM, Petr Lautrbach wrote:
>>>>>>> On 04/17/2015 03:42 PM, Stephen Smalley wrote:
>>>>>>>> SELinux can be disabled via the selinux=3D0 kernel parameter or =
via
>>>>>>>> /sys/fs/selinux/disable (triggered by setting SELINUX=3Ddisabled=
 in
>>>>>>>> /etc/selinux/config).  In either case, selinuxfs will be unmount=
ed
>>>>>>>> and unregistered and therefore it is sufficient to check for the=

>>>>>>>> selinuxfs mount.  We do not need to check for no-policy-loaded a=
nd
>>>>>>>> treat that as SELinux-disabled anymore; that is a relic of Fedor=
a Core 2
>>>>>>>> days.  Drop the no-policy-loaded test, which was a bit of a hack=
 anyway
>>>>>>>> (checking whether getcon_raw() returned "kernel" as that can onl=
y happen
>>>>>>>> if no policy is yet loaded and therefore security_sid_to_context=
() only
>>>>>>>> has the initial SID name available to return as the context).
>>>>>>>>
>>>>>>>> May possibly fix https://bugzilla.redhat.com/show_bug.cgi?id=3D1=
195074
>>>>>>>> by virtue of removing the call to getcon_raw() and therefore avo=
iding
>>>>>>>> use of tls on is_selinux_enabled() calls.  Regardless, it will m=
ake
>>>>>>>> is_selinux_enabled() faster and simpler.
>>>>>>>>
>>>>>>>
>>>>>>> This patch breaks system with SELinux enabled kernel and without
>>>>>>> loaded/installed an SELinux policy, see [1].
>>>>>>>
>>>>>>> Would it be feasible to have is_selinux_enabled() connected to ex=
istence
>>>>>>> of SELINUX variable in /etc/selinux/config file for the cases whe=
n
>>>>>>> there's no specific kernel command line option used in running sy=
stem?
>>>>>>> Or would it break something else?
>>>>>>>
>>>>>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1219045
>>>>>>
>>>>>> Sorry, does this occur even if they have SELINUX=3Ddisabled in
>>>>>> /etc/selinux/config?
>>>>>
>>>>> It works with SELINUX=3Ddisabled. It's only related to systems with=
out
>>>>> /etc/selinux/config and without selinux=3D0 on kernel command line.=

>>>>
>>>> I see.  So I can see that it is a regression for such systems, but s=
uch
>>>> systems are definitely running suboptimally by NOT disabling SELinux=
 if
>>>> they are not going to even load a policy.  They are just wasting all=
 of
>>>> the SELinux hook call overhead in the kernel.
>>
>> I agree.
>>
>>>>
>>>> In any event, one of the benefits of the change that caused this
>>>> regression is that it makes is_selinux_enabled() very fast and avoid=
s
>>>> any need to open any extra files on calls to it, thereby improving
>>>> performance on both SELinux-enabled and SELinux-disabled systems.
>>>>
>>>> I don't think we need or want to actually have it read
>>>> /etc/selinux/config and look for a SELINUX=3D variable.  Isn't it
>>>> sufficient to test for the existence of an /etc/selinux/config file,=

>>>> e.g. access("/etc/selinux/config", F_OK)?
>>
>> I'm fine with that.
>>
>>>>
>>>> We'll have to wrap that test with #ifndef ANDROID as Android does no=
t
>>>> use /etc/selinux/config.
>>>
>>> Oh, and let's do it once in init_selinuxmnt() and cache the result so=
 we
>>> aren't calling access() on each is_selinux_enabled() call.
>>
>> Do you want me to prepare and send a patch?
>=20
> See if my patch solves the problem.  I do however see one other
> potential scenario that could occur in Fedora, i.e. where they have
> selinux-policy installed (and thus have an /etc/selinux/config) but do
> not have selinux-policy-targeted installed (and thus do not have any
> /etc/selinux/targeted).  Not sure how far down this path we should trav=
el...
>=20

The patch solves the problem. Thanks.

I would say that a system with /etc/selinux/config with
SELINUXTYPE=3Dtargeted and without targeted policy is misconfigured. A
problem could with an empty config file but it's probably a minor corner
case.

Petr
--=20
Petr Lautrbach


--unQ8aKXiM4bxEdH4IkterS53rw1UH9URK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVUff0AAoJEGOorUuYLENztAAP/22YKK5EFZEYeAbi+HmTyLY4
hdpc9Soj65mBeYYU8H4BYH8Ej8eD6m93Q59ZB6/AWl5JgPYvZ1FXEZSgOBoL/lI0
f+Wdu9Vr4H33YmRCY/1/qGE7E+m4R2MQOnnO0nRvV3DE4RCUCdmHF9g7VJ0FAykx
+UZq2+7N6dvGLvcb9M6efO1SZudJBs5CN4RYEJo7atoApCxVwEFguP1YZtexWb5W
v+GdGfSOULSFU1zMPuDItDu1kgkDZ/QBnHchSzP1km/MYP79NGWaH266j5ffELgf
xPFsks6rx0oBlgkshB2vBoiLdAWP/RfYqCM/GDRWFWfFpDGQqB8AirPkEgo/lOXj
M+t8y0nhA8BVs5UVfbzogFDZ326dXVUYaNj1thwJftqdXmXU+RXAlr+Jea4wgMtC
rbKoBY/ekX0z/f8NyQfpid3pT6Ae7zmzHdCm64/hsIjW0Yo2cTcPzOCeq3dv8vvw
3/xMAyq3Ibc0ytkLRk084Sgi8arQhxaQsyQDuShzAOZOoqccegWZ12XMxRSrTw8j
0gUGOzfi5qVQ1s/LIwgk+Qce11KevYMxxiDzKg93ASCSYXij/+WmB/IsuycIQeS/
OIcJDwnbsUC6vYpDQRm1Cq9FN4cyYZ8dWmrkwE2uoRYmQJy1ZHNaD5dIbhRsgWSx
UsWaFEAnVRNxfpWPK19u
=eZOx
-----END PGP SIGNATURE-----

--unQ8aKXiM4bxEdH4IkterS53rw1UH9URK--
