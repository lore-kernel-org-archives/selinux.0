Subject: Re: load_policy fails to load policy with ENOENT
To: Richard Haines <richard_c_haines@btinternet.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <ea84ceb6-d481-9ba2-8649-638f9c6690e6@gmail.com>
 <1c3181bc-fd63-bc43-1838-e8550b733096@tycho.nsa.gov>
 <3f6232af-bcf5-661c-2531-28ba6c54fa8f@gmail.com>
 <1479223847.11104.12.camel@btinternet.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <193049f3-cb37-871c-e730-eae054b62be9@gmail.com>
Date: Tue, 15 Nov 2016 16:35:02 +0100
MIME-Version: 1.0
In-Reply-To: <1479223847.11104.12.camel@btinternet.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dFeDXwRXQAkb6HP229GQ9ettjj95RfxVP"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dFeDXwRXQAkb6HP229GQ9ettjj95RfxVP
Content-Type: multipart/mixed; boundary="MnvGCgVR8QmnP1sNFa2fvxhnPKXjEoWBI";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <193049f3-cb37-871c-e730-eae054b62be9@gmail.com>
Subject: Re: load_policy fails to load policy with ENOENT
References: <ea84ceb6-d481-9ba2-8649-638f9c6690e6@gmail.com>
 <1c3181bc-fd63-bc43-1838-e8550b733096@tycho.nsa.gov>
 <3f6232af-bcf5-661c-2531-28ba6c54fa8f@gmail.com>
 <1479223847.11104.12.camel@btinternet.com>
In-Reply-To: <1479223847.11104.12.camel@btinternet.com>

--MnvGCgVR8QmnP1sNFa2fvxhnPKXjEoWBI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/15/2016 04:30 PM, Richard Haines wrote:
> On Tue, 2016-11-15 at 16:02 +0100, Dominick Grift wrote:
>> On 11/15/2016 03:58 PM, Stephen Smalley wrote:
>>>
>>> On 11/15/2016 07:19 AM, Dominick Grift wrote:
>>>>
>>>> I finished porting dssp-base to dssp1-base, however when i try
>>>> testing it load_policy fails with ENOENT.
>>>>
>>>> Even though load_policy returns error status the policy seems to
>>>> be loaded, except that it is not (or so it seems). When i reboot
>>>> the system freezes for whatever reason. Whether it is due to
>>>> systemd refusing due to load_policy failure or anything else i am
>>>> not sure.
>>>>
>>>> I have double checked the policy.
>>>>
>>>> 1. secilc has no problems with it 2. the initial sids are
>>>> declared
>>>> and ordered 3. the classes are there (and the linux classes are
>>>> ordered)
>>>>
>>>> I cannot think of anything that might cause this and i am looking
>>>> for suggestions.
>>>>
>>>> It is easy to reproduce:
>>>>
>>>> 1. git clone https://github.com/DefenSec/dssp1-base.git 2. cd
>>>> dssp1-base 3. secilc `ls *.cil` 4. seinfo policy.30 5. mv
>>>> /etc/selinux/targeted/policy/policy.30=20
>>>> /etc/selinux/targeted/policy/policy.30.ori 6. cp policy.30
>>>> /etc/selinux/targeted/policy/ 7. setenforce 0 8. load_policy 9.
>>>> sestatus, seinfo, ps uaxZ
>>>>
>>>> I have also uploaded a demo:
>>>>
>>>> https://youtu.be/8NCME9dLZd4
>>>>
>>>> Suggestions and help are appreciated
>>>
>>> Any dmesg output at the time of the failed load?
>>> What does strace load_policy show?
>>>
>>
>> write(4, "\214\377|\371\10\0\0\0SE
>> Linux\36\0\0\0\1\0\0\0\10\0\0\0\7\0\0\0"..., 296645) =3D -1 ENOENT (No=

>> such file or directory)
>>
>> dmesg shows exactly what it would show on a successful policy load
>> AFAICT
>>
>> From dmesg there is no indication that anything went wrong (all the
>> expected output is there (the stats the unmapped/invalidated
>> contexts.
>> also sestatus shows that the policy is loaded). It *seems* that only
>> load policy throws this error. However as i said the system freezes
>> on
>> boot and i cannot tell whether that is due to systemd, the policy or
>> load_policy.
>>
>> following the steps to reproduce will take less than five minutes:
>>
>>>
>>>>
>>>> 1. git clone https://github.com/DefenSec/dssp1-base.git 2. cd
>>>> dssp1-base 3. secilc `ls *.cil` 4. seinfo policy.30 5. mv
>>>> /etc/selinux/targeted/policy/policy.30
>>>> /etc/selinux/targeted/policy/policy.30.ori 6. cp policy.30
>>>> /etc/selinux/targeted/policy/ 7. setenforce 0 8. load_policy 9.
>>>> sestatus, seinfo, ps uaxZ
>>
>=20
> I found that the booleans are causing the problem. If you move the
> (boolean ...) statements to global space your policy loads (the
> booleanif statements are okay where they are). Not sure why yet but
> kernel boolean check could get confused with sys.load_kernel_module=20

Hmm, I consider that to be a bug, in any case. the sid declarations can
also not be in any blocks but at least secilc tells me about it.
>=20
> BTW you are missing the netlink_socket class. I have not tried to boot
> with the policy but I guess you would also need to update the config
> files with the new contexts to boot system !!!

The netlink_socket class is deprecated, no longer used. They left it in
the kernel but my policy does not support it

I know about the other prerequisites, thanks.

>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho
>> .nsa.gov.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--MnvGCgVR8QmnP1sNFa2fvxhnPKXjEoWBI--

--dFeDXwRXQAkb6HP229GQ9ettjj95RfxVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYKysmAAoJECV0jlU3+UdpwFQL/RHyXhUCEGJsPtsUoJ9w3fJp
dqtpeHBG0jn5heF0SQ86r9XwTHOwMHvRgxkUOrIt5IKoROrRwCt3ZmFEm+CVQlMy
Bm5MkUggm8AaaMoD72U0lLqgycF15hzCbvWoaiRbMELnFBTzCYyz0eR6cJyCPbzZ
Eh5AtQfdwv5z3FBsZLSnCfvXKesSA0Sm5ql44hVzLDstI3M8BL8Lu4B2uPjhpIY8
OWRvnvNKJE4zmxvNXcNKvLtdFdfDIAZdO/hWieCcXy8ObhMXkSQP352mubxoEAJj
t+mZC9KE29ZE35R5eMt32Vrw8/SR326TSP59jW2KNu1WgXbLT/yjAbXG1n5N7zbc
71jJR31+o4ljKOE/+QB4fQ54aPRPyOwH9XpY+5HNoHdzSx9qBrE/HzsGcogGYp+t
Lih/UuRpJQMFF8CYAdVH2ObjZCT3nbspwuqmxR9LLC5/hybq+fYRlsWFuuVXUZaO
1xB7Ij3nGtFnYKzZaomhdMXmfidQxuWV0WIFCxeSIA==
=3cPT
-----END PGP SIGNATURE-----

--dFeDXwRXQAkb6HP229GQ9ettjj95RfxVP--
