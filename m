Subject: Re: New rules on restrict kernel module loading
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 Paul Moore <paul@paul-moore.com>
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
 <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
 <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>
 <93f091ed-6a9c-b582-6717-e124bff190d6@gmail.com>
 <793fb1d0-dd7d-62c4-bcae-30842d52478a@tycho.nsa.gov>
 <8c7fea79-36a4-51e1-f284-5d8586186416@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <0dd20e28-4a3c-25ee-879e-8ea88981da57@gmail.com>
Date: Wed, 29 Jun 2016 20:57:22 +0200
MIME-Version: 1.0
In-Reply-To: <8c7fea79-36a4-51e1-f284-5d8586186416@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Lu8bHDAJpE14T8gmoSBuSO43eInRFWEE2"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lu8bHDAJpE14T8gmoSBuSO43eInRFWEE2
Content-Type: multipart/mixed; boundary="LsnT4eOTgeTkxdRqtAiMrK8DRNVKOGjcM"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 Paul Moore <paul@paul-moore.com>
Message-ID: <0dd20e28-4a3c-25ee-879e-8ea88981da57@gmail.com>
Subject: Re: New rules on restrict kernel module loading
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
 <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
 <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>
 <93f091ed-6a9c-b582-6717-e124bff190d6@gmail.com>
 <793fb1d0-dd7d-62c4-bcae-30842d52478a@tycho.nsa.gov>
 <8c7fea79-36a4-51e1-f284-5d8586186416@tycho.nsa.gov>
In-Reply-To: <8c7fea79-36a4-51e1-f284-5d8586186416@tycho.nsa.gov>

--LsnT4eOTgeTkxdRqtAiMrK8DRNVKOGjcM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2016 03:41 PM, Stephen Smalley wrote:
> On 06/29/2016 09:33 AM, Stephen Smalley wrote:
>> On 06/29/2016 05:36 AM, Dominick Grift wrote:
>>> On 06/28/2016 02:54 PM, Stephen Smalley wrote:
>>>> On 06/28/2016 07:02 AM, Dominick Grift wrote:
>>>>> On 06/22/2016 09:02 PM, Jeffrey Vander Stoep wrote:
>>>>>> selinux@tycho.nsa.gov to bcc
>>>>>>
>>>>>> Hi Ravi,
>>>>>>
>>>>>> The intent is not to restrict which processes may load modules,
>>>>>> but to place restrictions on the origin of the module itself.
>>>>>> Modules, like the kernel, should live on a verity protected
>>>>>> partition.
>>>>>>
>>>>>> If you want system apps to load a kernel module from the system
>>>>>> partition you just need to add an allow rule. e.g.
>>>>>>
>>>>>> # system_app loads /system/lib/module/wlan.ko allow system_app
>>>>>> system_file:system module_load;
>>>>>>
>>>>>> Similar rules may be added for platform_app or system_server.
>>>>>>
>>>>>
>>>>> In Fedora rawhide i see these where the target is "self". example:
>>>>>
>>>>> allow kmod self:system module_load;
>>>>>
>>>>> is that intended?
>>>>
>>>> That's the fallback when using init_module() rather than
>>>> finit_module() to load modules, since the kernel does not see the fi=
le
>>>> when using init_module().  With init_module(), userspace loads the
>>>> module from the file into memory and passes a (pointer, len) pair to=

>>>> the kernel; with finit_module(), userspace opens the module file and=

>>>> passes the open file descriptor to the kernel.  Ideally, one would
>>>> convert all users of init_module() to finit_module(), then remove an=
y
>>>> self:system module_load permissions and only allow it for specific
>>>> file types.
>>>>
>>>
>>> I suspect that something is broken here then (although i might be wro=
ng)
>>>
>>> systemd-udevd seems to be using finit_module() but selinux still chec=
ks
>>> "self" instead of a module file type. (whereas i would have expected =
the
>>> latter)
>>
>> I don't see how that is possible, given the code in question.  I'd
>> recommend checking that it is actually using finit_module() and not
>> falling back to init_module().
>=20
> BTW, you should be able to just check the SYSCALL audit record to see
> what system call was invoked upon the denial.  ausearch -m AVC -i will
> show you any related SYSCALL records for any avc denial and will map th=
e
> architecture + system call numbers to string names.  So if you have an
> audit.log containing the denial in question, you should be able to
> easily tell whether it was init_module or finit_module.

Confirmed. It falls back to init_module. We do not know why, but i think
it does not really matter, and that we should always take into account
this fall back scenario. So i do not believe i will be able to drop the
init_module support anytime soon.

Thanks again

>=20
>>
>>>
>>> I see that there is no selinux test-suite test implemented for this
>>> functionality.
>>
>> Can't really do that until the permission is defined in the Fedora
>> policy.  Otherwise, it will always be allowed due to the allow-unknown=

>> default in Fedora.
>>
>>
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--LsnT4eOTgeTkxdRqtAiMrK8DRNVKOGjcM--

--Lu8bHDAJpE14T8gmoSBuSO43eInRFWEE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXdBoSAAoJECV0jlU3+Udp7aIL/AsLXhmp/WFCbXVdtxZMDEdO
lnPEBP29qD3DoXkDYK0gzS2wRjQpi/KEiyAcPSQJoiySW1MvEFfDkXYlr63DIzyY
22Ts7a+QHU6eZeRF4Ufged0/7akrPxgdDBUx3MuBdfkIC3+PK0JEmOrXjFUzHnS6
a1ejXnbEydqh5ZrnlO3twhSyJHeKd5TnjTmQroQ02d6xF6FSiucO39jTQ3RIUJOw
df8yt6Nfiec/Tp54+46hccH27ZFcTB5vxpSIl8qBmVi+TGTEYfk41wblQFwB4ZVH
BzkIApBO33Rnoz5/42ohr6trF/57RqwYccVtiVkWfn128oJEd27G0Xscm8g8LI0O
4BLdLtRf35QyP7lreJBewNjB8h7qoBYEXjlFSnhApGEFWZuYfV8ooyWI88DoynHj
v3b9x29l5pRdC+lTG9M27NsxfRPrN7irsJryOqi5jo2clqJSoPr9nRz4B6nTRKAG
iB8omOMvDf1UtATE5TG/1W/ZHezt17coLRJ57A4etw==
=SZWc
-----END PGP SIGNATURE-----

--Lu8bHDAJpE14T8gmoSBuSO43eInRFWEE2--
