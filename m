Message-ID: <52E9331B.407@mthode.org>
Date: Wed, 29 Jan 2014 10:58:03 -0600
From: Matthew Thode <mthode@mthode.org>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 selinux@tycho.nsa.gov, Richard Yao <ryao@gentoo.org>, behlendorf@llnl.gov
Subject: Re: file access causes a kernel bug
References: <52E8B5F8.2070005@mthode.org> <52E8B7C1.1000101@mthode.org>
 <1621615.vHn06J0duj@sifl> <52E90B32.5010404@tycho.nsa.gov>
 <52E90D65.9030200@tycho.nsa.gov>
In-Reply-To: <52E90D65.9030200@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="g3547uFptewe10MTohFlfKrrB1E8D9GsR"
Reply-To: mthode@mthode.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g3547uFptewe10MTohFlfKrrB1E8D9GsR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/29/2014 08:17 AM, Stephen Smalley wrote:
> On 01/29/2014 09:07 AM, Stephen Smalley wrote:
>> On 01/29/2014 08:55 AM, Paul Moore wrote:
>>> On Wednesday, January 29, 2014 02:11:45 AM Matthew Thode wrote:
>>>> On 01/29/2014 02:04 AM, Matthew Thode wrote:
>>>>> This happens consistantly, just ls a particular dir and wheeeeee.
>>>>>
>>>>> [  473.893141] ------------[ cut here ]------------
>>>>> [  473.962110] kernel BUG at security/selinux/ss/services.c:654!
>>>>> [  473.995314] invalid opcode: 0000 [#6] SMP
>>>>> [  474.027196] Modules linked in:
>>>>> [  474.058118] CPU: 0 PID: 8138 Comm: ls Tainted: G      D   I
>>>>> 3.13.0-grsec #1
>>>>> [  474.116637] Hardware name: Supermicro X8ST3/X8ST3, BIOS 2.0
>>>>> 07/29/10
>>>>> [  474.149768] task: ffff8805f50cd010 ti: ffff8805f50cd488 task.ti:=

>>>>> ffff8805f50cd488
>>>>> [  474.183707] RIP: 0010:[<ffffffff814681c7>]  [<ffffffff814681c7>]=

>>>>> context_struct_compute_av+0xce/0x308
>>>>> [  474.219954] RSP: 0018:ffff8805c0ac3c38  EFLAGS: 00010246
>>>>> [  474.252253] RAX: 0000000000000000 RBX: ffff8805c0ac3d94 RCX:
>>>>> 0000000000000100
>>>>> [  474.287018] RDX: ffff8805e8aac000 RSI: 00000000ffffffff RDI:
>>>>> ffff8805e8aaa000
>>>>> [  474.321199] RBP: ffff8805c0ac3cb8 R08: 0000000000000010 R09:
>>>>> 0000000000000006
>>>>> [  474.357446] R10: 0000000000000000 R11: ffff8805c567a000 R12:
>>>>> 0000000000000006
>>>>> [  474.419191] R13: ffff8805c2b74e88 R14: 00000000000001da R15:
>>>>> 0000000000000000
>>>>> [  474.453816] FS:  00007f2e75220800(0000) GS:ffff88061fc00000(0000=
)
>>>>> knlGS:0000000000000000
>>>>> [  474.489254] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  474.522215] CR2: 00007f2e74716090 CR3: 00000005c085e000 CR4:
>>>>> 00000000000207f0
>>>>> [  474.556058] Stack:
>>>>> [  474.584325]  ffff8805c0ac3c98 ffffffff811b549b ffff8805c0ac3c98
>>>>> ffff8805f1190a40
>>>>> [  474.618913]  ffff8805a6202f08 ffff8805c2b74e88 00068800d0464990
>>>>> ffff8805e8aac860
>>>>> [  474.653955]  ffff8805c0ac3cb8 000700068113833a ffff880606c75060
>>>>> ffff8805c0ac3d94
>>>>> [  474.690461] Call Trace:
>>>>> [  474.723779]  [<ffffffff811b549b>] ? lookup_fast+0x1cd/0x22a
>>>>> [  474.778049]  [<ffffffff81468824>] security_compute_av+0xf4/0x20b=

>>>>> [  474.811398]  [<ffffffff8196f419>] avc_compute_av+0x2a/0x179
>>>>> [  474.843813]  [<ffffffff8145727b>] avc_has_perm+0x45/0xf4
>>>>> [  474.875694]  [<ffffffff81457d0e>] inode_has_perm+0x2a/0x31
>>>>> [  474.907370]  [<ffffffff81457e76>] selinux_inode_getattr+0x3c/0x3=
e
>>>>> [  474.938726]  [<ffffffff81455cf6>] security_inode_getattr+0x1b/0x=
22
>>>>> [  474.970036]  [<ffffffff811b057d>] vfs_getattr+0x19/0x2d
>>>>> [  475.000618]  [<ffffffff811b05e5>] vfs_fstatat+0x54/0x91
>>>>> [  475.030402]  [<ffffffff811b063b>] vfs_lstat+0x19/0x1b
>>>>> [  475.061097]  [<ffffffff811b077e>] SyS_newlstat+0x15/0x30
>>>>> [  475.094595]  [<ffffffff8113c5c1>] ? __audit_syscall_entry+0xa1/0=
xc3
>>>>> [  475.148405]  [<ffffffff8197791e>] system_call_fastpath+0x16/0x1b=

>>>>> [  475.179201] Code: 00 48 85 c0 48 89 45 b8 75 02 0f 0b 48 8b 45 a=
0 48
>>>>> 8b 3d 45 d0 b6 00 8b 40 08 89 c6 ff ce e8 d1 b0 06 00 48 85 c0 49 8=
9 c7
>>>>> 75 02 <0f> 0b 48 8b 45 b8 4c 8b 28 eb 1e 49 8d 7d 08 be 80 01 00 00=
 e8
>>>>> [  475.255884] RIP  [<ffffffff814681c7>]
>>>>> context_struct_compute_av+0xce/0x308
>>>>> [  475.296120]  RSP <ffff8805c0ac3c38>
>>>>> [  475.328734] ---[ end trace f076482e9d754adc ]---
>>>>>
>>>>
>>>> sorry, forgot to add, this is for 3.13.0 as well.
>>>>
>>>> ls ./.config/ipython/profile_default/
>>>> Segmentation fault
>>>
>>> Thanks for passing this along, but can you elaborate a bit more on th=
is? =20
>>> Distribution?  Kernel package?  SELinux policy?  Any unusual configur=
ation? =20
>>> etc.
>>>
>>> I ask because I'm not seeing this problem on my system and it seems l=
ike a=20
>>> fairly basic thing to be broken; if there was an issue with 'ls' on 3=
=2E13 I=20
>>> expect we would be flooded with angry users right now ...
>>
>> Does it happen on any filesystem other than ZFS?
>>
>> Do you have any prior SELinux output leading up to this bug?
>=20
> Also, what policy are you using and what is the security context on tha=
t
> file?
>=20
Ok, one at a time :D

I'm on gentoo using the strict policy (in permissive for now...)

Kernel is 3.13 (zfs is built from git head as of 2014-01-26 (selinux
patches went in :D))

using basepol 2.20130424

No unusual config that I can think of.  I've found multiple files that
this happens with).

Only on zfs that I can see

Dunno what you mean by prior selinux output, just some random selinux
denials because restorecon -RF fails because of this.

I can't see either the file name or the context of that file.  As soon
as anything tries to access anything about the file I get that backtrace.=


--=20
-- Matthew Thode


--g3547uFptewe10MTohFlfKrrB1E8D9GsR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6TMmAAoJECRx6z5ArFrDE2EP/inj3cFWqVEAL1/6o5FT0fKA
eLqEw/kB3x5te8Or7XxwmlFqk3moIGS6uEE2k+B692Xx4UZnCb74kNTAhuE1snBv
OgIBhgZObjgG1ua+Quz6n4gTORWWSuduZcVLEy87ZphCpU938YoxmEX2ab8IzDeB
kx9fgH3JyAlMQsTEQYI05OGtr3y9QLe2cKm/0mQhy8t63kxkAxDTTxmVeKmRNR7G
oxWK6S8w3Mo2fLc2IhfEBM2PyrmgAq5kSiycekpe/v754NYo+F/JBqUOm83CPO3q
wnKGWASM//TJW7RSZDqiZ0wOburLuw1pFq47bAbLALBg4wIV/9EYjvuDdWQbTcFc
PgTUuxfyXOMlC322GLh9xYr+b31kqE0KFEL5lnieTxaPdpr0k1cKJoBtheBDVhS4
x4v9e024oLCkQcvOffeVW2KDrFxZWMduAV2vA4l1SSOs3peXHeen2Pm16VwxEIOg
U/o3n4FgM5hpA2hZZTQ/c/u9lF0IsOpX0sCNthBsAnIfrEXDqezrqaV2p/M6oI2M
QtDDtyTPwi148z8LOUtjqWlnuup2K+Q+VhfLqFwoeOP3/6Mby1aHvaJWmWB0XYmD
0Luz//pRwpvqn5XQPEHHl0JN3ElI8BO/bNfmDoBLu9RkZysXozOA80f/2NGQvAH9
UCgknMqQTfioxo+xJdbO
=yrXZ
-----END PGP SIGNATURE-----

--g3547uFptewe10MTohFlfKrrB1E8D9GsR--
