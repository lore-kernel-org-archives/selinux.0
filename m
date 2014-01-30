Message-ID: <52EA86D2.104@mthode.org>
Date: Thu, 30 Jan 2014 11:07:30 -0600
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
 <52EA737C.7010802@tycho.nsa.gov> <52EA74E9.3020406@mthode.org>
 <52EA80AC.2070802@tycho.nsa.gov>
In-Reply-To: <52EA80AC.2070802@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Re6Gh9RqAxf0pejUggI1wHlEDT3BkAfI8"
Cc: behlendorf@llnl.gov, selinux@tycho.nsa.gov
Reply-To: mthode@mthode.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Re6Gh9RqAxf0pejUggI1wHlEDT3BkAfI8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/30/2014 10:41 AM, Stephen Smalley wrote:
> On 01/30/2014 10:51 AM, Matthew Thode wrote:
>> On 01/30/2014 09:45 AM, Stephen Smalley wrote:
>>> On 01/30/2014 10:38 AM, Matthew Thode wrote:
>>>> On 01/30/2014 07:43 AM, Stephen Smalley wrote:
>>>>> On 01/30/2014 03:20 AM, Matthew Thode wrote:
>>>>>> On 01/29/2014 04:39 PM, Richard Yao wrote:
>>>>>>> Gentoo systems have custom kernels made by their users. I can run=
 through Matthew=92s kernel config with him to make sure that all of the =
right options are checked this evening. If any changes are necessary, he =
can recompile.
>>>>>>>
>>>>>>> On Jan 29, 2014, at 5:35 PM, Brian Behlendorf <behlendorf1@llnl.g=
ov> wrote:
>>>>>>>
>>>>>>>> On 01/29/14 13:36, Stephen Smalley wrote:
>>>>>>>>> On 01/29/2014 11:58 AM, Matthew Thode wrote:
>>>>>>>>>> On 01/29/2014 08:17 AM, Stephen Smalley wrote:
>>>>>>>>>>> On 01/29/2014 09:07 AM, Stephen Smalley wrote:
>>>>>>>>>>>> On 01/29/2014 08:55 AM, Paul Moore wrote:
>>>>>>>>>>>>> On Wednesday, January 29, 2014 02:11:45 AM Matthew Thode wr=
ote:
>>>>>>>>>>>>>> On 01/29/2014 02:04 AM, Matthew Thode wrote:
>>>>>>>>>>>>>>> This happens consistantly, just ls a particular dir and w=
heeeeee.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [  473.893141] ------------[ cut here ]------------
>>>>>>>>>>>>>>> [  473.962110] kernel BUG at security/selinux/ss/services=
=2Ec:654!
>>>>>>>>>>>>>>> [  473.995314] invalid opcode: 0000 [#6] SMP
>>>>>>>>>>>>>>> [  474.027196] Modules linked in:
>>>>>>>>>>>>>>> [  474.058118] CPU: 0 PID: 8138 Comm: ls Tainted: G      =
D   I
>>>>>>>>>>>>>>> 3.13.0-grsec #1
>>>>>>>>>>>>>>> [  474.116637] Hardware name: Supermicro X8ST3/X8ST3, BIO=
S 2.0
>>>>>>>>>>>>>>> 07/29/10
>>>>>>>>>>>>>>> [  474.149768] task: ffff8805f50cd010 ti: ffff8805f50cd48=
8 task.ti:
>>>>>>>>>>>>>>> ffff8805f50cd488
>>>>>>>>>>>>>>> [  474.183707] RIP: 0010:[<ffffffff814681c7>]  [<ffffffff=
814681c7>]
>>>>>>>>>>>>>>> context_struct_compute_av+0xce/0x308
>>>>>>>>>>>>>>> [  474.219954] RSP: 0018:ffff8805c0ac3c38  EFLAGS: 000102=
46
>>>>>>>>>>>>>>> [  474.252253] RAX: 0000000000000000 RBX: ffff8805c0ac3d9=
4 RCX:
>>>>>>>>>>>>>>> 0000000000000100
>>>>>>>>>>>>>>> [  474.287018] RDX: ffff8805e8aac000 RSI: 00000000fffffff=
f RDI:
>>>>>>>>>>>>>>> ffff8805e8aaa000
>>>>>>>>>>>>>>> [  474.321199] RBP: ffff8805c0ac3cb8 R08: 000000000000001=
0 R09:
>>>>>>>>>>>>>>> 0000000000000006
>>>>>>>>>>>>>>> [  474.357446] R10: 0000000000000000 R11: ffff8805c567a00=
0 R12:
>>>>>>>>>>>>>>> 0000000000000006
>>>>>>>>>>>>>>> [  474.419191] R13: ffff8805c2b74e88 R14: 00000000000001d=
a R15:
>>>>>>>>>>>>>>> 0000000000000000
>>>>>>>>>>>>>>> [  474.453816] FS:  00007f2e75220800(0000) GS:ffff88061fc=
00000(0000)
>>>>>>>>>>>>>>> knlGS:0000000000000000
>>>>>>>>>>>>>>> [  474.489254] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
>>>>>>>>>>>>>>> [  474.522215] CR2: 00007f2e74716090 CR3: 00000005c085e00=
0 CR4:
>>>>>>>>>>>>>>> 00000000000207f0
>>>>>>>>>>>>>>> [  474.556058] Stack:
>>>>>>>>>>>>>>> [  474.584325]  ffff8805c0ac3c98 ffffffff811b549b ffff880=
5c0ac3c98
>>>>>>>>>>>>>>> ffff8805f1190a40
>>>>>>>>>>>>>>> [  474.618913]  ffff8805a6202f08 ffff8805c2b74e88 0006880=
0d0464990
>>>>>>>>>>>>>>> ffff8805e8aac860
>>>>>>>>>>>>>>> [  474.653955]  ffff8805c0ac3cb8 000700068113833a ffff880=
606c75060
>>>>>>>>>>>>>>> ffff8805c0ac3d94
>>>>>>>>>>>>>>> [  474.690461] Call Trace:
>>>>>>>>>>>>>>> [  474.723779]  [<ffffffff811b549b>] ? lookup_fast+0x1cd/=
0x22a
>>>>>>>>>>>>>>> [  474.778049]  [<ffffffff81468824>] security_compute_av+=
0xf4/0x20b
>>>>>>>>>>>>>>> [  474.811398]  [<ffffffff8196f419>] avc_compute_av+0x2a/=
0x179
>>>>>>>>>>>>>>> [  474.843813]  [<ffffffff8145727b>] avc_has_perm+0x45/0x=
f4
>>>>>>>>>>>>>>> [  474.875694]  [<ffffffff81457d0e>] inode_has_perm+0x2a/=
0x31
>>>>>>>>>>>>>>> [  474.907370]  [<ffffffff81457e76>] selinux_inode_getatt=
r+0x3c/0x3e
>>>>>>>>>>>>>>> [  474.938726]  [<ffffffff81455cf6>] security_inode_getat=
tr+0x1b/0x22
>>>>>>>>>>>>>>> [  474.970036]  [<ffffffff811b057d>] vfs_getattr+0x19/0x2=
d
>>>>>>>>>>>>>>> [  475.000618]  [<ffffffff811b05e5>] vfs_fstatat+0x54/0x9=
1
>>>>>>>>>>>>>>> [  475.030402]  [<ffffffff811b063b>] vfs_lstat+0x19/0x1b
>>>>>>>>>>>>>>> [  475.061097]  [<ffffffff811b077e>] SyS_newlstat+0x15/0x=
30
>>>>>>>>>>>>>>> [  475.094595]  [<ffffffff8113c5c1>] ? __audit_syscall_en=
try+0xa1/0xc3
>>>>>>>>>>>>>>> [  475.148405]  [<ffffffff8197791e>] system_call_fastpath=
+0x16/0x1b
>>>>>>>>>>>>>>> [  475.179201] Code: 00 48 85 c0 48 89 45 b8 75 02 0f 0b =
48 8b 45 a0 48
>>>>>>>>>>>>>>> 8b 3d 45 d0 b6 00 8b 40 08 89 c6 ff ce e8 d1 b0 06 00 48 =
85 c0 49 89 c7
>>>>>>>>>>>>>>> 75 02 <0f> 0b 48 8b 45 b8 4c 8b 28 eb 1e 49 8d 7d 08 be 8=
0 01 00 00 e8
>>>>>>>>>>>>>>> [  475.255884] RIP  [<ffffffff814681c7>]
>>>>>>>>>>>>>>> context_struct_compute_av+0xce/0x308
>>>>>>>>>>>>>>> [  475.296120]  RSP <ffff8805c0ac3c38>
>>>>>>>>>>>>>>> [  475.328734] ---[ end trace f076482e9d754adc ]---
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> sorry, forgot to add, this is for 3.13.0 as well.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> ls ./.config/ipython/profile_default/
>>>>>>>>>>>>>> Segmentation fault
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks for passing this along, but can you elaborate a bit =
more on this?
>>>>>>>>>>>>> Distribution?  Kernel package?  SELinux policy?  Any unusua=
l configuration?
>>>>>>>>>>>>> etc.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I ask because I'm not seeing this problem on my system and =
it seems like a
>>>>>>>>>>>>> fairly basic thing to be broken; if there was an issue with=
 'ls' on 3.13 I
>>>>>>>>>>>>> expect we would be flooded with angry users right now ...
>>>>>>>>>>>>
>>>>>>>>>>>> Does it happen on any filesystem other than ZFS?
>>>>>>>>>>>>
>>>>>>>>>>>> Do you have any prior SELinux output leading up to this bug?=

>>>>>>>>>>>
>>>>>>>>>>> Also, what policy are you using and what is the security cont=
ext on that
>>>>>>>>>>> file?
>>>>>>>>>>>
>>>>>>>>>> Ok, one at a time :D
>>>>>>>>>>
>>>>>>>>>> I'm on gentoo using the strict policy (in permissive for now..=
=2E)
>>>>>>>>>>
>>>>>>>>>> Kernel is 3.13 (zfs is built from git head as of 2014-01-26 (s=
elinux
>>>>>>>>>> patches went in :D))
>>>>>>>>>>
>>>>>>>>>> using basepol 2.20130424
>>>>>>>>>>
>>>>>>>>>> No unusual config that I can think of.  I've found multiple fi=
les that
>>>>>>>>>> this happens with).
>>>>>>>>>>
>>>>>>>>>> Only on zfs that I can see
>>>>>>>>>>
>>>>>>>>>> Dunno what you mean by prior selinux output, just some random =
selinux
>>>>>>>>>> denials because restorecon -RF fails because of this.
>>>>>>>>>>
>>>>>>>>>> I can't see either the file name or the context of that file. =
 As soon
>>>>>>>>>> as anything tries to access anything about the file I get that=
 backtrace.
>>>>>>>>>
>>>>>>>>> Looking at the code in question, I don't see any way to reach t=
hat BUG
>>>>>>>>> without memory corruption in the kernel.  Which could just as e=
asily be
>>>>>>>>> in ZFS as anything else...
>>>>>>>>
>>>>>>>> Memory corruption is possible but we haven't seen any other evid=
ence of that in ZFS.  If Gentoo has a kernel-debug package similar to Fed=
ora/RHELs that may be worth a try.  The additional debugging may catch so=
mething non-obvious.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Brian
>>>>>>>
>>>>>> Ok, booted up without selinux, does this seem right to you (note t=
he
>>>>>> empty security.selinux field for
>>>>>> '.config/ipython/profile_default/history.sqlite-journal').
>>>>>>
>>>>>> # getfattr -n security.selinux .config/ipython/profile_default/*
>>>>>>
>>>>>> # file: .config/ipython/profile_default/db
>>>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>>>
>>>>>> # file: .config/ipython/profile_default/history.sqlite
>>>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>>>
>>>>>> # file: .config/ipython/profile_default/history.sqlite-journal
>>>>>> security.selinux
>>>>>>
>>>>>> # file: .config/ipython/profile_default/log
>>>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>>>
>>>>>> # file: .config/ipython/profile_default/pid
>>>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>>>
>>>>>> # file: .config/ipython/profile_default/security
>>>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>>>
>>>>>> # file: .config/ipython/profile_default/startup
>>>>>> security.selinux=3D"root:object_r:xdg_config_home_t"
>>>>>>
>>>>>> storage ~ # touch asdasdasdadasdasd
>>>>>> storage ~ # getfattr -n security.selinux asdasdasdadasdasd
>>>>>> asdasdasdadasdasd: security.selinux: No such attribute
>>>>>
>>>>> No, should never be empty, although that shouldn't lead to this BUG=

>>>>> either, just a warning that the inode was found to have an invalid
>>>>> context in your dmesg and remapping it to the unlabeled context.  F=
ull
>>>>> dmesg or /var/log/messages output (or at least all lines with SELin=
ux,
>>>>> audit, or avc in them) when running the SE-enabled kernel would be =
of
>>>>> interest.
>>>>>
>>>>> Files created while running a non-SE kernel will normally not have =
any
>>>>> security.selinux attribute, so that isn't surprising.  You have to
>>>>> relabel when switching back and forth between non-SE and SE.  But a=
gain,
>>>>> that shouldn't produce this BUG, just an unlabeled file that could =
yield
>>>>> some avc denials until it is relabeled.
>>>>>
>>>>> The BUG in question has to do with a flex_array_get() call returnin=
g
>>>>> NULL on an array that was preallocated via flex_array_prealloc().  =
So
>>>>> the only way for it to occur is if the provided index (tcontext->ty=
pe -
>>>>> 1) is out of range, yet those values are validated via
>>>>> policydb_context_isvalid() before they are ever added to the sidtab=
=2E  So
>>>>> you are looking at memory corruption of either the flex array or th=
e
>>>>> context structure.  And as we have never seen this BUG in a mainlin=
e
>>>>> kernel with ext[432] or any other mainline filesystem, I have to th=
ink
>>>>> that it has something to do with your specific kernel, either in ZF=
S or
>>>>> in some other change in your specific kernel.
>>>>>
>>>>
>>>> Well, it is empty :P  as far as AVC denials go it was just for stuff=

>>>> that wasn't relabled from the previous boot.
>>>>
>>>> I can't relabel this file because accessing it (even a dir listing)
>>>> causes BUG!
>>>>
>>>> I also tracked it down to the flex array get function, but that's th=
e
>>>> limit of my C knowlege atm.
>>>>
>>>> I feel like this is a bug in both mainline and zfs; Mainline because=
 it
>>>> can't handle the context and zfs because it generated the context.  =
I'm
>>>> also not convinced about the memory corruption though.
>>>
>>> I was able to reproduce it w/o ZFS, so ZFS is clear on the BUG part, =
but
>>> unclear how you get an empty xattr value there.
>>>
>>> su
>>> setenforce 0
>>> touch foo
>>> setfattr -n security.selinux foo
>>>
>>> triggers the BUG.
>>>
>>> We'll have to investigate, as that obviously shouldn't be possible.
>>> Wouldn't be allowed in enforcing mode or for any non-root process.
>>>
>>>
>> You know that good feeling you get when someone else can reproduce a
>> bug?  I have that now :D
>>
>> Thanks.  I'll likely keep on trying to fix though :D  I'm not too sure=

>> when that file was generated though.  It was generated by a root proce=
ss
>> both times (nfs and ipython run as root) and I was very likely to be i=
n
>> permissive mode.
>=20
> Try the attached patch.
>=20
>=20
Confirmed that this fixes it :D thanks a ton for this.

Here's some dmesg if you are curious (a bit much for email, so link)
http://bpaste.net/show/YcRsO0IhO8XvMVtKjMlv/

but here's the important bits.

ls .config/ipython/profile_default/
[  324.461669] SELinux: inode=3D4148 on dev=3Dzfs was found to have an
invalid context=3Droot:object_r:xdg_config_home_t.  This indicates you ma=
y
need to relabel the inode or the filesystem in question.

storage ~ # restorecon -RF ./.config/ipython/profile_default/ -vvvv
restorecon reset
/root/.config/ipython/profile_default/history.sqlite-journal context
system_u:object_r:unlabeled_t->root:object_r:xdg_config_home_t

#no more dmesg after restorecon, so confirmed that worked as well
storage ~ # ls .config/ipython/profile_default/



--=20
-- Matthew Thode


--Re6Gh9RqAxf0pejUggI1wHlEDT3BkAfI8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS6obYAAoJECRx6z5ArFrDHzgQAKTuJzTpowxWT1dDb8Aj7D9r
lDoKMARyEGsZCwD20a3sjlBOc4dxh30fco+x1kIu+BzeuPBhFLm1vZBH3S+PMgMK
ImoX7R87si8kVyU59v27O5cCiPASo6epYyXPIzt3c3vwWF2c6ueak+WYKa/9fxaS
HGM9sa7An2gDE7NqD+7iO799m5JwY4l+lH7xndEMthCPqPwbdliYqp9CBggCTEhO
41k143PzEYdn3Tj2K96iQYPesPSZ3hLXzaxJ8Ko8d3NFjUq6Q524C0KQY12c0gP5
xXk864POsypL6VXLa0hFmDv4KwLbRUDU+f3Povn93Z856E5pxqIoURVAAwa/gZKi
7rHz5E+wOpC42W78ahdI+/g0gUI/9/wJBoj8tlughewqkJBbuH/qSFkUlbrSui6L
8ZTQgi1YgiVA3AOzauRYSpJjqykwDf+PB34x/9RsbMSC4I2CwN2X6t2lCX9RioGk
hsq3uHuNxNnfLuYW6GBajgLuKLc0VPQVhZcA8+VJx04jAcgKmOw8cnt3oSVb4X8/
Hp3ngwwdMFWYl8kTjXOo0ht3ieGMeHmrJlhdYWjvytZ4aMWbUyxNNddfaWAljkeF
8sxISTjMzaw4qSU3tqcZhqmchfMHbCzs4J1Q/2ZqkEHoGUsTA2+TtPh/sGtvwnI2
tnmPSX+nGJgXw/q9JwPW
=NT9E
-----END PGP SIGNATURE-----

--Re6Gh9RqAxf0pejUggI1wHlEDT3BkAfI8--
