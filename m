Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMDtPNF024133
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 08:55:27 -0500
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com
 [209.85.216.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id CC611564742
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 14:55:20 +0100 (CET)
Received: by mail-qt0-f172.google.com with SMTP id w33so11143539qtc.3
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 05:55:20 -0800 (PST)
MIME-Version: 1.0
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 22 Nov 2016 14:55:18 +0100
Message-ID: <CAJfZ7=mvF8a32+-R1PK_kGP-uSFJFta427nnkzJbctUFGtu-DA@mail.gmail.com>
Subject: segmentation fault in additive_scopes_to_cil()
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=001a113f235c78b95d0541e41fe9
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113f235c78b95d0541e41fe9
Content-Type: multipart/alternative; boundary=001a113f235c78b9590541e41fe7

--001a113f235c78b9590541e41fe7
Content-Type: text/plain; charset=UTF-8

Hello,

I have been fuzzing semodule_package and /usr/libexec/selinux/hll/pp for a
few days. After all the crashing policy modules it found because of missing
bound checks and missing NULL pointer checks in libsepol (I will send some
patches once I cleaned them [1]), the fuzzer found an other kind of crash:
a NULL pointer execution in additive_scopes_to_cil_map(). Here is what gdb
says when running pp on the file attached to this email:

Starting program: /usr/libexec/selinux/hll/pp
afl-out/pp/crashes/id:000001,sig:11,src:003451,op:flip2,pos:401
libsepol.sepol_module_package_read: unknown magic number at section 1,
offset: 2d1, number: 0
(roleattributeset cil_gen_require object_r)

Program received signal SIGSEGV, Segmentation fault.
0x0000000000000000 in ?? ()
=> 0x0000000000000000: Cannot access memory at address 0x0
(gdb) bt
#0  0x0000000000000000 in ?? ()
#1  0x00007ffff79ecd80 in additive_scopes_to_cil_map (key=<optimized out>,
data=<optimized out>, arg=<optimized out>) at module_to_cil.c:3522
#2  0x00007ffff79b096d in hashtab_map (h=0x60bd80,
apply=apply@entry=0x7ffff79ecd10
<additive_scopes_to_cil_map>, args=args@entry=0x7fffffffd950) at
hashtab.c:235
#3  0x00007ffff7a09bb6 in additive_scopes_to_cil (decl_stack=0x6080b0,
block=0x60b780, pdb=<optimized out>, indent=0) at module_to_cil.c:3544
#4  block_to_cil (pdb=pdb@entry=0x6082e0, block=block@entry=0x60b780,
stack=stack@entry=0x6080b0, indent=indent@entry=0) at module_to_cil.c:3631
#5  0x00007ffff7a11af8 in global_block_to_cil (pdb=pdb@entry=0x6082e0,
block=block@entry=0x60b780, stack=0x6080b0) at module_to_cil.c:3742
#6  0x00007ffff7a13dc3 in blocks_to_cil (pdb=0x6082e0) at
module_to_cil.c:3768
#7  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff79165e0
<_IO_2_1_stdout_>, pdb=0x6082e0, linked=linked@entry=0) at
module_to_cil.c:4055
#8  0x00007ffff7a15a55 in sepol_module_package_to_cil
(fp=fp@entry=0x7ffff79165e0
<_IO_2_1_stdout_>, mod_pkg=0x608280) at module_to_cil.c:4084
#9  0x00000000004021c0 in main (argc=<optimized out>, argv=<optimized out>)
at pp.c:150


As far as I understand, this is because additive_scopes_to_cil() calls
additive_scopes_to_cil_map() with args->sym_index = 0 [2],
and func_to_cil[0] is NULL [3]. A simple fix would consist in starting the
for loop in additive_scopes_to_cil() from args.sym_index = 1, but this may
hide another bug. An other way to fix this bug would be to detect such an
invalid policy earlier, if a valid policy is expected to always have
empty decl->symtab[0] tables. What would you recommend to fix this?

Cheers,
Nicolas

[1] Right now, my work-in-progress patches are in
https://github.com/fishilico/selinux/commits/master
[2] The relevant code is
https://github.com/SELinuxProject/selinux/blob/libsepol-2.6/libsepol/src/module_to_cil.c#L3506-L3542
[3]
https://github.com/SELinuxProject/selinux/blob/libsepol-2.6/libsepol/src/module_to_cil.c#L3339

--001a113f235c78b9590541e41fe7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I have been fuzzing semodule_pac=
kage and /usr/libexec/selinux/hll/pp for a few days. After all the crashing=
 policy modules it found because of missing bound checks and missing NULL p=
ointer checks in libsepol (I will send some patches once I cleaned them [1]=
), the fuzzer found an other kind of crash: a NULL pointer execution in=C2=
=A0additive_scopes_to_cil_map(). Here is what gdb says when running pp on t=
he file attached to this email:</div><div><br></div><div><div>Starting prog=
ram: /usr/libexec/selinux/hll/pp afl-out/pp/crashes/id:000001,sig:11,src:00=
3451,op:flip2,pos:401</div><div>libsepol.sepol_module_package_read: unknown=
 magic number at section 1, offset: 2d1, number: 0=C2=A0</div><div>(roleatt=
ributeset cil_gen_require object_r)</div><div><br></div><div>Program receiv=
ed signal SIGSEGV, Segmentation fault.</div><div>0x0000000000000000 in ?? (=
)</div><div>=3D&gt; 0x0000000000000000:<span class=3D"gmail-Apple-tab-span"=
 style=3D"white-space:pre">	</span>Cannot access memory at address 0x0</div=
><div>(gdb) bt</div><div>#0 =C2=A00x0000000000000000 in ?? ()</div><div>#1 =
=C2=A00x00007ffff79ecd80 in additive_scopes_to_cil_map (key=3D&lt;optimized=
 out&gt;, data=3D&lt;optimized out&gt;, arg=3D&lt;optimized out&gt;) at mod=
ule_to_cil.c:3522</div><div>#2 =C2=A00x00007ffff79b096d in hashtab_map (h=
=3D0x60bd80, apply=3Dapply@entry=3D0x7ffff79ecd10 &lt;additive_scopes_to_ci=
l_map&gt;, args=3Dargs@entry=3D0x7fffffffd950) at hashtab.c:235</div><div>#=
3 =C2=A00x00007ffff7a09bb6 in additive_scopes_to_cil (decl_stack=3D0x6080b0=
, block=3D0x60b780, pdb=3D&lt;optimized out&gt;, indent=3D0) at module_to_c=
il.c:3544</div><div>#4 =C2=A0block_to_cil (pdb=3Dpdb@entry=3D0x6082e0, bloc=
k=3Dblock@entry=3D0x60b780, stack=3Dstack@entry=3D0x6080b0, indent=3Dindent=
@entry=3D0) at module_to_cil.c:3631</div><div>#5 =C2=A00x00007ffff7a11af8 i=
n global_block_to_cil (pdb=3Dpdb@entry=3D0x6082e0, block=3Dblock@entry=3D0x=
60b780, stack=3D0x6080b0) at module_to_cil.c:3742</div><div>#6 =C2=A00x0000=
7ffff7a13dc3 in blocks_to_cil (pdb=3D0x6082e0) at module_to_cil.c:3768</div=
><div>#7 =C2=A0sepol_module_policydb_to_cil (fp=3Dfp@entry=3D0x7ffff79165e0=
 &lt;_IO_2_1_stdout_&gt;, pdb=3D0x6082e0, linked=3Dlinked@entry=3D0) at mod=
ule_to_cil.c:4055</div><div>#8 =C2=A00x00007ffff7a15a55 in sepol_module_pac=
kage_to_cil (fp=3Dfp@entry=3D0x7ffff79165e0 &lt;_IO_2_1_stdout_&gt;, mod_pk=
g=3D0x608280) at module_to_cil.c:4084</div><div>#9 =C2=A00x00000000004021c0=
 in main (argc=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;) at pp=
.c:150</div></div><div><br></div><div><br></div><div>As far as I understand=
, this is because additive_scopes_to_cil() calls additive_scopes_to_cil_map=
() with=C2=A0args-&gt;sym_index =3D 0 [2], and=C2=A0func_to_cil[0] is NULL =
[3]. A simple fix would consist in starting the for loop in=C2=A0additive_s=
copes_to_cil() from=C2=A0args.sym_index =3D 1, but this may hide another bu=
g. An other way to fix this bug would be to detect such an invalid policy e=
arlier, if a valid policy is expected to always have empty=C2=A0decl-&gt;sy=
mtab[0] tables. What would you recommend to fix this?</div><div><br></div><=
div>Cheers,</div><div>Nicolas</div><div><br></div><div>[1] Right now, my wo=
rk-in-progress patches are in=C2=A0<a href=3D"https://github.com/fishilico/=
selinux/commits/master">https://github.com/fishilico/selinux/commits/master=
</a></div><div>[2] The relevant code is=C2=A0<a href=3D"https://github.com/=
SELinuxProject/selinux/blob/libsepol-2.6/libsepol/src/module_to_cil.c#L3506=
-L3542">https://github.com/SELinuxProject/selinux/blob/libsepol-2.6/libsepo=
l/src/module_to_cil.c#L3506-L3542</a></div><div>[3]=C2=A0<a href=3D"https:/=
/github.com/SELinuxProject/selinux/blob/libsepol-2.6/libsepol/src/module_to=
_cil.c#L3339">https://github.com/SELinuxProject/selinux/blob/libsepol-2.6/l=
ibsepol/src/module_to_cil.c#L3339</a></div></div>

--001a113f235c78b9590541e41fe7--

--001a113f235c78b95d0541e41fe9
Content-Type: application/octet-stream;
	name="id:000000,sig:11,src:003436,op:flip2,pos:401"
Content-Disposition: attachment;
	filename="id:000000,sig:11,src:003436,op:flip2,pos:401"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivtjwrjn0

j/98+QEAAAACAAAAFAAAANECAACN/3z5DwAAAFNFIExpbnV4IE1vZHVsZQIAAAARAAAAAAAAAAgA
AAAAAAAABQAAAGJhc2ljBQAAADEuMC4wQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAAC
AAAACAAAAAEAAAAAAAAAb2JqZWN0X3JAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAA
AAAAAAAAAAAAAEAAAAAAAAAAAAAAAAgAAAACAAAAAAAAAHN5IHRlbV9yQAAAAIAAAAABAAAAAAAA
AAIAAAAAAAAAQAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAEAAAABAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAABAAAAAAQAAAAAA
AAABAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAA
AEAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAA
AAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAA
AAAAAAAA7QIAAAAQAAAAAAAAAAAAAAAAAAAAAwAAAAAAAAAAAAAAAgAAAAgAAABvYmogAHRfcgIA
AAABAAAAAQAAAAgAAABzeXN0ZW1fcgEAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAIA
AAAIAAAAAQAAAAAAAABvYmplY3RfckAAAAAAAAAAc3lzdGVtX3JAAAAAQAAAAAEAAAAAAAAAAgAA
BAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAQAAAEAAAAAAAAgAAAAAAAAABQAAAGJh
c2ljBQAAADEuMC4wQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==
--001a113f235c78b95d0541e41fe9--
