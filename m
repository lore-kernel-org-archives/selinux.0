Message-ID: <52EA74E9.3020406@mthode.org>
Date: Thu, 30 Jan 2014 09:51:05 -0600
From: Matthew Thode <mthode@mthode.org>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Richard Yao <ryao@gentoo.org>,
 Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: file access causes a kernel bug
References: <52E8B5F8.2070005@mthode.org> <52E8B7C1.1000101@mthode.org>
 <1621615.vHn06J0duj@sifl> <52E90B32.5010404@tycho.nsa.gov>
 <52E90D65.9030200@tycho.nsa.gov> <52E9331B.407@mthode.org>
 <52E97454.5060403@tycho.nsa.gov> <52E98240.5020901@llnl.gov>
 <F90298CB-DC5B-4DC9-BA64-E5C31461815D@gentoo.org> <52EA0B4F.30403@mthode.org>
 <52EA571B.6050008@tycho.nsa.gov> <52EA71F1.1040303@mthode.org>
 <52EA737C.7010802@tycho.nsa.gov>
In-Reply-To: <52EA737C.7010802@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="E4atE1LcjJ138W812oeUElwBgtBAh5skj"
Cc: behlendorf@llnl.gov, selinux@tycho.nsa.gov
Reply-To: mthode@mthode.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E4atE1LcjJ138W812oeUElwBgtBAh5skj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/30/2014 09:45 AM, Stephen Smalley wrote:
> On 01/30/2014 10:38 AM, Matthew Thode wrote:
>> On 01/30/2014 07:43 AM, Stephen Smalley wrote:
>>> On 01/30/2014 03:20 AM, Matthew Thode wrote:
>>>> On 01/29/2014 04:39 PM, Richard Yao wrote:
>>>>> Gentoo systems have custom kernels made by their users. I can run t=
hrough Matthew=92s kernel config with him to make sure that all of the ri=
ght options are checked this evening. If any changes are necessary, he ca=
n recompile.
>>>>>
>>>>> On Jan 29, 2014, at 5:35 PM, Brian Behlendorf <behlendorf1@llnl.gov=
> wrote:
>>>>>
>>>>>> On 01/29/14 13:36, Stephen Smalley wrote:
>>>>>>> On 01/29/2014 11:58 AM, Matthew Thode wrote:
>>>>>>>> On 01/29/2014 08:17 AM, Stephen Smalley wrote:
>>>>>>>>> On 01/29/2014 09:07 AM, Stephen Smalley wrote:
>>>>>>>>>> On 01/29/2014 08:55 AM, Paul Moore wrote:
>>>>>>>>>>> On Wednesday, January 29, 2014 02:11:45 AM Matthew Thode wrot=
e:
>>>>>>>>>>>> On 01/29/2014 02:04 AM, Matthew Thode wrote:
>>>>>>>>>>>>> This happens consistantly, just ls a particular dir and whe=
eeeee.
>>>>>>>>>>>>>
>>>>>>>>>>>>> [  473.893141] ------------[ cut here ]------------
>>>>>>>>>>>>> [  473.962110] kernel BUG at security/selinux/ss/services.c=
:654!
>>>>>>>>>>>>> [  473.995314] invalid opcode: 0000 [#6] SMP
>>>>>>>>>>>>> [  474.027196] Modules linked in:
>>>>>>>>>>>>> [  474.058118] CPU: 0 PID: 8138 Comm: ls Tainted: G      D =
  I
>>>>>>>>>>>>> 3.13.0-grsec #1
>>>>>>>>>>>>> [  474.116637] Hardware name: Supermicro X8ST3/X8ST3, BIOS =
2.0
>>>>>>>>>>>>> 07/29/10
>>>>>>>>>>>>> [  474.149768] task: ffff8805f50cd010 ti: ffff8805f50cd488 =
task.ti:
>>>>>>>>>>>>> ffff8805f50cd488
>>>>>>>>>>>>> [  474.183707] RIP: 0010:[<ffffffff814681c7>]  [<ffffffff81=
4681c7>]
>>>>>>>>>>>>> context_struct_compute_av+0xce/0x308
>>>>>>>>>>>>> [  474.219954] RSP: 0018:ffff8805c0ac3c38  EFLAGS: 00010246=

>>>>>>>>>>>>> [  474.252253] RAX: 0000000000000000 RBX: ffff8805c0ac3d94 =
RCX:
>>>>>>>>>>>>> 0000000000000100
>>>>>>>>>>>>> [  474.287018] RDX: ffff8805e8aac000 RSI: 00000000ffffffff =
RDI:
>>>>>>>>>>>>> ffff8805e8aaa000
>>>>>>>>>>>>> [  474.321199] RBP: ffff8805c0ac3cb8 R08: 0000000000000010 =
R09:
>>>>>>>>>>>>> 0000000000000006
>>>>>>>>>>>>> [  474.357446] R10: 0000000000000000 R11: ffff8805c567a000 =
R12:
>>>>>>>>>>>>> 0000000000000006
>>>>>>>>>>>>> [  474.419191] R13: ffff8805c2b74e88 R14: 00000000000001da =
R15:
>>>>>>>>>>>>> 0000000000000000
>>>>>>>>>>>>> [  474.453816] FS:  00007f2e75220800(0000) GS:ffff88061fc00=
000(0000)
>>>>>>>>>>>>> knlGS:0000000000000000
>>>>>>>>>>>>> [  474.489254] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
>>>>>>>>>>>>> [  474.522215] CR2: 00007f2e74716090 CR3: 00000005c085e000 =
CR4:
>>>>>>>>>>>>> 00000000000207f0
>>>>>>>>>>>>> [  474.556058] Stack:
>>>>>>>>>>>>> [  474.584325]  ffff8805c0ac3c98 ffffffff811b549b ffff8805c=
0ac3c98
>>>>>>>>>>>>> ffff8805f1190a40
>>>>>>>>>>>>> [  474.618913]  ffff8805a6202f08 ffff8805c2b74e88 00068800d=
0464990
>>>>>>>>>>>>> ffff8805e8aac860
>>>>>>>>>>>>> [  474.653955]  ffff8805c0ac3cb8 000700068113833a ffff88060=
6c75060
>>>>>>>>>>>>> ffff8805c0ac3d94
>>>>>>>>>>>>> [  474.690461] Call Trace:
>>>>>>>>>>>>> [  474.723779]  [<ffffffff811b549b>] ? lookup_fast+0x1cd/0x=
22a
>>>>>>>>>>>>> [  474.778049]  [<ffffffff81468824>] security_compute_av+0x=
f4/0x20b
>>>>>>>>>>>>> [  474.811398]  [<ffffffff8196f419>] avc_compute_av+0x2a/0x=
179
>>>>>>>>>>>>> [  474.843813]  [<ffffffff8145727b>] avc_has_perm+0x45/0xf4=

>>>>>>>>>>>>> [  474.875694]  [<ffffffff81457d0e>] inode_has_perm+0x2a/0x=
31
>>>>>>>>>>>>> [  474.907370]  [<ffffffff81457e76>] selinux_inode_getattr+=
0x3c/0x3e
>>>>>>>>>>>>> [  474.938726]  [<ffffffff81455cf6>] security_inode_getattr=
+0x1b/0x22
>>>>>>>>>>>>> [  474.970036]  [<ffffffff811b057d>] vfs_getattr+0x19/0x2d
>>>>>>>>>>>>> [  475.000618]  [<ffffffff811b05e5>] vfs_fstatat+0x54/0x91
>>>>>>>>>>>>> [  475.030402]  [<ffffffff811b063b>] vfs_lstat+0x19/0x1b
>>>>>>>>>>>>> [  475.061097]  [<ffffffff811b077e>] SyS_newlstat+0x15/0x30=

>>>>>>>>>>>>> [  475.094595]  [<ffffffff8113c5c1>] ? __audit_syscall_entr=
y+0xa1/0xc3
>>>>>>>>>>>>> [  475.148405]  [<ffffffff8197791e>] system_call_fastpath+0=
x16/0x1b
>>>>>>>>>>>>> [  475.179201] Code: 00 48 85 c0 48 89 45 b8 75 02 0f 0b 48=
 8b 45 a0 48
>>>>>>>>>>>>> 8b 3d 45 d0 b6 00 8b 40 08 89 c6 ff ce e8 d1 b0 06 00 48 85=
 c0 49 89 c7
>>>>>>>>>>>>> 75 02 <0f> 0b 48 8b 45 b8 4c 8b 28 eb 1e 49 8d 7d 08 be 80 =
01 00 00 e8
>>>>>>>>>>>>> [  475.255884] RIP  [<ffffffff814681c7>]
>>>>>>>>>>>>> context_struct_compute_av+0xce/0x308
>>>>>>>>>>>>> [  475.296120]  RSP <ffff8805c0ac3c38>
>>>>>>>>>>>>> [  475.328734] ---[ end trace f076482e9d754adc ]---
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> sorry, forgot to add, this is for 3.13.0 as well.
>>>>>>>>>>>>
>>>>>>>>>>>> ls ./.config/ipython/profile_default/
>>>>>>>>>>>> Segmentation fault
>>>>>>>>>>>
>>>>>>>>>>> Thanks for passing this along, but can you elaborate a bit mo=
re on this?
>>>>>>>>>>> Distribution?  Kernel package?  SELinux policy?  Any unusual =
configuration?
>>>>>>>>>>> etc.
>>>>>>>>>>>
>>>>>>>>>>> I ask because I'm not seeing this problem on my system and it=
 seems like a
>>>>>>>>>>> fairly basic thing to be broken; if there was an issue with '=
ls' on 3.13 I
>>>>>>>>>>> expect we would be flooded with angry users right now ...
>>>>>>>>>>
>>>>>>>>>> Does it happen on any filesystem other than ZFS?
>>>>>>>>>>
>>>>>>>>>> Do you have any prior SELinux output leading up to this bug?
>>>>>>>>>
>>>>>>>>> Also, what policy are you using and what is the security contex=
t on that
>>>>>>>>> file?
>>>>>>>>>
>>>>>>>> Ok, one at a time :D
>>>>>>>>
>>>>>>>> I'm on gentoo using the strict policy (in permissive for now...)=

>>>>>>>>
>>>>>>>> Kernel is 3.13 (zfs is built from git head as of 2014-01-26 (sel=
inux
>>>>>>>> patches went in :D))
>>>>>>>>
>>>>>>>> using basepol 2.20130424
>>>>>>>>
>>>>>>>> No unusual config that I can think of.  I've found multiple file=
s that
>>>>>>>> this happens with).
>>>>>>>>
>>>>>>>> Only on zfs that I can see
>>>>>>>>
>>>>>>>> Dunno what you mean by prior selinux output, just some random se=
linux
>>>>>>>> denials because restorecon -RF fails because of this.
>>>>>>>>
>>>>>>>> I can't see either the file name or the context of that file.  A=
s soon
>>>>>>>> as anything tries to access anything about the file I get that b=
acktrace.
>>>>>>>
>>>>>>> Looking at the code in question, I don't see any way to reach tha=
t BUG
>>>>>>> without memory corruption in the kernel.  Which could just as eas=
ily be
>>>>>>> in ZFS as anything else...
>>>>>>
>>>>>> Memory corruption is possible but we haven't seen any other eviden=
ce of that in ZFS.  If Gentoo has a kernel-debug package similar to Fedor=
a/RHELs that may be worth a try.  The additional debugging may catch some=
thing non-obvious.
>>>>>>
>>>>>> Thanks,
>>>>>> Brian
>>>>>
>>>> Ok, booted up without selinux, does this seem right to you (note the=

>>>> empty security.selinux field for
>>>> '.config/ipython/profile_default/history.sqlite-journal').
>>>>
>>>> # getfattr -n security.selinux .config/ipython/profile_default/*
>>>>
>>>> # file: .config/ipython/profile_default/db
>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>
>>>> # file: .config/ipython/profile_default/history.sqlite
>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>
>>>> # file: .config/ipython/profile_default/history.sqlite-journal
>>>> security.selinux
>>>>
>>>> # file: .config/ipython/profile_default/log
>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>
>>>> # file: .config/ipython/profile_default/pid
>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>
>>>> # file: .config/ipython/profile_default/security
>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>
>>>> # file: .config/ipython/profile_default/startup
>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>
>>>> storage ~ # touch asdasdasdadasdasd
>>>> storage ~ # getfattr -n security.selinux asdasdasdadasdasd
>>>> asdasdasdadasdasd: security.selinux: No such attribute
>>>
>>> No, should never be empty, although that shouldn't lead to this BUG
>>> either, just a warning that the inode was found to have an invalid
>>> context in your dmesg and remapping it to the unlabeled context.  Ful=
l
>>> dmesg or /var/log/messages output (or at least all lines with SELinux=
,
>>> audit, or avc in them) when running the SE-enabled kernel would be of=

>>> interest.
>>>
>>> Files created while running a non-SE kernel will normally not have an=
y
>>> security.selinux attribute, so that isn't surprising.  You have to
>>> relabel when switching back and forth between non-SE and SE.  But aga=
in,
>>> that shouldn't produce this BUG, just an unlabeled file that could yi=
eld
>>> some avc denials until it is relabeled.
>>>
>>> The BUG in question has to do with a flex_array_get() call returning
>>> NULL on an array that was preallocated via flex_array_prealloc().  So=

>>> the only way for it to occur is if the provided index (tcontext->type=
 -
>>> 1) is out of range, yet those values are validated via
>>> policydb_context_isvalid() before they are ever added to the sidtab. =
 So
>>> you are looking at memory corruption of either the flex array or the
>>> context structure.  And as we have never seen this BUG in a mainline
>>> kernel with ext[432] or any other mainline filesystem, I have to thin=
k
>>> that it has something to do with your specific kernel, either in ZFS =
or
>>> in some other change in your specific kernel.
>>>
>>
>> Well, it is empty :P  as far as AVC denials go it was just for stuff
>> that wasn't relabled from the previous boot.
>>
>> I can't relabel this file because accessing it (even a dir listing)
>> causes BUG!
>>
>> I also tracked it down to the flex array get function, but that's the
>> limit of my C knowlege atm.
>>
>> I feel like this is a bug in both mainline and zfs; Mainline because i=
t
>> can't handle the context and zfs because it generated the context.  I'=
m
>> also not convinced about the memory corruption though.
>=20
> I was able to reproduce it w/o ZFS, so ZFS is clear on the BUG part, bu=
t
> unclear how you get an empty xattr value there.
>=20
> su
> setenforce 0
> touch foo
> setfattr -n security.selinux foo
>=20
> triggers the BUG.
>=20
> We'll have to investigate, as that obviously shouldn't be possible.
> Wouldn't be allowed in enforcing mode or for any non-root process.
>=20
>=20
You know that good feeling you get when someone else can reproduce a
bug?  I have that now :D

Thanks.  I'll likely keep on trying to fix though :D  I'm not too sure
when that file was generated though.  It was generated by a root process
both times (nfs and ipython run as root) and I was very likely to be in
permissive mode.

--=20
-- Matthew Thode


--E4atE1LcjJ138W812oeUElwBgtBAh5skj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6nTwAAoJECRx6z5ArFrDs20QAKdu3jdMRZVzpNDWKgm6btAt
tl+khfRuoXUrqJImxD2eayKs8mNyY4en1W1cQmYh46WBNlTDSdrWLgndmmc+RtZp
aBwKi7fpBau12E0ygIl4vcmpB+9ZFaOnyeLxvTSe/zx8fplUC3FbzCHM7sK79Aao
n/LS7LRphhjmJlsEtv8pI/nOG5diimwM6DvYN7t2h/Y1UHgstI+g2uBfTGePD+PC
8DwFYTF+fe+0AhJv2qlasu02c1SfaYk13F0vjpp+XeqdrwNRrZ6MC0JB4/JiB1sz
ijqw61XwSgmJO/v2yMudn8XAbvduqsP06AoXP0PHJqxh/QA0fDKFJVbTEM7z8LkI
qJHnRvJuJF/R895sOMk+pTGQri9l6EXksA5k/Mk6jIkaVdayY/75PDfBP03Rs9tz
tCzpivk9AjYwgLjrHc73Ob+lQ49C5bBlFOeTb1DwN8jL1WIESG+MwhPCi93JiukJ
s0lTeDZRUN6nT8oCeCgoryfr6pS5r6KKON3IyEycSrXUA7Fhx1kWmQ8DsXihEUuY
WF7dyWLHrPqs4kvw5fmz2SSllMghGRihuAHCkf9bblq4sg3JSQ4g0pIYs6SD9wPW
ZpfFUlcEZSq0fufLkwN6tmpaMfDLcz4teKCmLYm3AgSHADanAo4kOsSsD4jyxrxc
9o54RfPThPhMsOJPqXxB
=OEHU
-----END PGP SIGNATURE-----

--E4atE1LcjJ138W812oeUElwBgtBAh5skj--
