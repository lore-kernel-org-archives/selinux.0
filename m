Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
To: Steve Lawrence <slawrence@tresys.com>,
 James Carter <jwcart2@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
 <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
 <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>
 <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>
 <cb19eb9c-6aaf-451a-55ca-6d92a31437a8@tresys.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <7428ea41-ff6b-cf55-db54-4c3466587a17@gmail.com>
Date: Fri, 20 Jan 2017 18:48:56 +0100
MIME-Version: 1.0
In-Reply-To: <cb19eb9c-6aaf-451a-55ca-6d92a31437a8@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bMOXUGwn4BJktim9jfrDX1Jp4UHk3PSgT"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bMOXUGwn4BJktim9jfrDX1Jp4UHk3PSgT
Content-Type: multipart/mixed; boundary="guBAcbBj2GaH2maaAlRm8RtHbJ0Mv9WNa";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>,
 James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
Message-ID: <7428ea41-ff6b-cf55-db54-4c3466587a17@gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix bug in handling type declaration in
 optional block.
References: <1484772829-15960-1-git-send-email-jwcart2@tycho.nsa.gov>
 <02cc173e-2a1a-3e7c-5de8-639b82585610@gmail.com>
 <1484846495.28584.13.camel@tycho.nsa.gov>
 <4d2eb68b-2fd1-c638-5d97-4dd6e92c80ff@gmail.com>
 <ba5c64b3-ae89-15a8-0b02-c5d5dc36b7eb@tycho.nsa.gov>
 <8fa28cc4-923b-7f9f-2dc5-2f431bfdc5fd@gmail.com>
 <cb19eb9c-6aaf-451a-55ca-6d92a31437a8@tresys.com>
In-Reply-To: <cb19eb9c-6aaf-451a-55ca-6d92a31437a8@tresys.com>

--guBAcbBj2GaH2maaAlRm8RtHbJ0Mv9WNa
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/20/2017 06:14 PM, Steve Lawrence wrote:
> On 01/20/2017 10:29 AM, Dominick Grift wrote:
>> On 01/20/2017 04:16 PM, James Carter wrote:
>>> On 01/19/2017 04:22 PM, Dominick Grift wrote:
>>>> On 01/19/2017 06:21 PM, Stephen Smalley wrote:
>>>>> On Wed, 2017-01-18 at 21:58 +0100, Dominick Grift wrote:
>>>>>> On 01/18/2017 09:53 PM, James Carter wrote:
>>>>>>>
>>>>>>> Nicolas Iooss discovered that requiring a type in an optional blo=
ck
>>>>>>> after the type has already been declared in another optional bloc=
k
>>>>>>> results in a duplicate declaration error.
>>>>>>>
>>>>>>
>>>>>> from what i have been told and from experience, types cannot,
>>>>>> reliably,
>>>>>> be declared in optional blocks.
>>>>>
>>>>> If true, that is likely a linker issue rather than a checkpolicy is=
sue.
>>>>> But that would make optionals rather useless if true.
>>>>
>>>> Let me present it in a different way then:
>>>>
>>>> Should one be able to, reliably, "blockinherit" in optionals?
>>>>
>>>> This is the commit in dssp1 where i hit the dead-end with declaring
>>>> types in optionals:
>>>>
>>>> https://github.com/DefenSec/dssp-contrib/commit/45236da4030f0a541c26=
753e13a91f69411d022e
>>>>
>>>>
>>>> I asked slawrence to have a look at the policy, and he indicated to =
me
>>>> that blocks cannot be inherited in optionals.
>>>>
>>>> The compiler accepts it but the policy becomes inconsistent
>>>>
>>>
>>> By inconsistent, do you mean that an the binary policy produced is no=
t
>>> valid, or something else?
>>
>> I used the word inconsistent because i actually forgot the details (it=

>> has been more than a year since I made this change and I tried hard to=

>> put this behind me, thinking that this was a fundamental limitation
>> rather than a "bug").
>>
>> I suspect the following:
>>
>> Rules end up in the policy but they aren't actually recognized/enforce=
d.
>>
>> Either the above or:
>>
>> Rules do *not* end up in the policy even though they are specified.
>>
>> Maybe slawrence remembers what the issue exactly was (added to recipie=
nts)
>>
>=20
> After digging through some past emails and discussions, I think part of=

> the issue is that things just start to get tricky and difficult to deal=

> with if you allow blockinherits (and for similar reasons blocks/macros)=

> in optionals.
>=20
> For example, say you had something like this:
>=20
> (optional foo
>   (block b
>     (blockinherit c)
>    )
>    ...
> )
>=20
> (block d
>   (blockinherit b))
>=20
>=20
> If something in optional foo fails, then the entire block b goes away.
> So does that mean the blockinherit b in block d goes away too? Or does
> that stay? Removing it could be potentially tricky since we need to
> remove tree nodes that have been copied (we don't currently where thing=
s
> are copied to), and that removal might have side effects. This is a
> similar reason why we don't allow macros in optionals. Once they've bee=
n
> called, it becomes difficult to remove them if the macros go away. Not
> impossible, but difficult.
>=20
> And since blockinherits can pull in blocks, you're essentially allowing=

> blocks inside optionals if you allow blockinherits inside optionals. So=

> this is likely the reason for not allowing blockinherits in optionals.
> They can pull in blocks and macros, which aren't allowed to be optional=
=2E
>=20
> I agree that supporting optional blocks/macros/blockinherits/etc would
> probably be really nice, but things get difficult pretty fast.
> Re-resolve when optionals fail is a messy bit of code. Figuring out the=

> right thing to do and when isn't obvious or easy.
>=20
> Now, we could add in some restrictions that make the changes less
> difficult (maybe), like blocks cannot be inside optionals, or
> blockinherits inside optionals cannot inherit blocks that contain other=

> blocks. But again, that's still kindof a pain to implement and those ar=
e
> probably restrictions that you'd end up running into eventually anyways=
=2E
> So it would be best to just really figure out how to make it all work.
> I'm sure it can work, it's just not an easy problem to solve and takes
> time to figure out.
>=20
> - Steve
>=20

Thank you.

I guess i somehow thought that the two issues were one and the same (ie.
"corruption" when declaring types in optionals vs. "corruption" when
inheriting blocks in optionals)

Seems I was wrong there. The "type issue" is probably not CIL related
and has been there for a very long time.

The two issues have things in common though. Both declaring types in
optionals, as well as inheriting blocks in optionals are unreliable and
should be avoided.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--guBAcbBj2GaH2maaAlRm8RtHbJ0Mv9WNa--

--bMOXUGwn4BJktim9jfrDX1Jp4UHk3PSgT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYgk2IAAoJECV0jlU3+Udp8XEL/A9dDKk5bHkdj6xCCwTr89eH
w7DpV6HUCFPupz6d2jUNbNBfARW+aZbkKtsoR4AWwwMxlQRC0+DURx4h5Gkdhb3o
awUTfnKUqOLsPisagiAlwvJOfUn9YB2mDRXP8+I7IMFGVxclwdxlKmpSQi10hjP2
l36np+yqqbUD3moaXRDPZnSx9Pjmsje+eTawCokKMnO3UuNjeFGQXJYY+KHLWhnS
IkjgVAtfu9cx+DP7vPkhrKY45wlz1Y4miiU0XJsJZPFFK1/TaZd5sZ7IqenF4nhE
eM4IIygw/IGtbuCV2J2J+0IQnSDeLMTaMfiY/7hChij6bzDKj5JRZTKJzYd3tCEb
H9Qw3uHGITwtEI521FXWJXByw/vM4hCA9BwKVUdHWC+nulB95M8e+kgnjUY/wc0i
Dtliy5spA9VMUBDcYPDhaGG903m/In5PzLvZsHUmngFbvvB6buGs9aQtTOaQO/wr
IIU//LFEWEn6Z26Fo/4xjjsv+/bFT37URUONT4YCbA==
=Efpu
-----END PGP SIGNATURE-----

--bMOXUGwn4BJktim9jfrDX1Jp4UHk3PSgT--
