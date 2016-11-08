Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA8IQmDU016976
 for <selinux@tycho.nsa.gov>; Tue, 8 Nov 2016 13:26:48 -0500
From: "Roberts, William C" <william.c.roberts@intel.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: GPF in sidtab_context_to_sid
Date: Tue, 8 Nov 2016 18:26:35 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD2178D@ORSMSX103.amr.corp.intel.com>
Content-Type: multipart/alternative;
 boundary="_000_476DC76E7D1DF2438D32BFADF679FC561CD2178DORSMSX103amrcor_"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_476DC76E7D1DF2438D32BFADF679FC561CD2178DORSMSX103amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I found a very similar oops online:
http://oops.kernel.org/oops/general-protection-fault-in-sidtab_context_to_s=
id/

Has anyone encountered this bug?

I had something reported to me very similar where the faulting instruction =
was:

0xffffffff8133c81e <+174>:   mov    0x14(%r12),%eax

Addr2line on vmlinux produced:
$ addr2line -f -e ./vmlinux ffffffff8133c81e
context_cmp
kernel/cht/security/selinux/ss/context.h:152

Actual Dump:

[131436.409639] general protection fault: 0000 [#1] PREEMPT SMP
[131436.416085] Modules linked in: tcp_diag inet_diag
atomisp_css2401a0_v21 videobuf_vmalloc videobuf_core bt_lpm
rfkill_gpio 8723bs(O) cfg80211 ov2680 ov8858_driver silead_ts ltr501
bmg160 ak09911 kxcjk_1013
[131436.436623] CPU: 3 PID: 3177 Comm: SettingsProvide Tainted: G
  W  O 3.14.70-x86_64-02246-g49319b8 #1
[131436.447500] Hardware name: XXX
CHTMRD.A6.002.016 09/20/2016
[131436.456542] task: ffff88006039cb30 ti: ffff88005e2ea000 task.ti:
ffff88005e2ea000
[131436.465000] RIP: 0010:[<ffffffff8133c81e>]
[131436.469579]  [<ffffffff8133c81e>] sidtab_context_to_sid+0xae/0x480
[131436.476783] RSP: 0018:ffff88005e2ebae0  EFLAGS: 00010286
[131436.482814] RAX: 00000000fff9f9f9 RBX: ffffffff82776540 RCX:
0000000000000000
[131436.490884] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffffff82776540
[131436.498953] RBP: ffff88005e2ebb28 R08: ffff88005e2ebb88 R09:
0000000000000000
[131436.507022] R10: ffff88007826c000 R11: 2f2f2f2f2f2f2f2f R12:
fff9f9f9fff9f9f9
[131436.515091] R13: ffff88005e2ebba0 R14: ffff88005e2ebbb8 R15:
0000000000000068
[131436.523160] FS:  00000000d1efbe00(006b) GS:ffff880079380000(0063)
knlGS:00000000d1a77960
[131436.532297] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[131436.538813] CR2: 0000000072e67750 CR3: 000000005e1ba000 CR4:
00000000001007e0
[131436.546883] Last Branch Records:
[131436.550590]    to: [<ffffffff81aa9ac0>] general_protection+0x0/0x80
[131436.557700]  from: [<ffffffff8133c81e>] sidtab_context_to_sid+0xae/0x48=
0
[131436.565292]    to: [<ffffffff8133c810>] sidtab_context_to_sid+0xa0/0x48=
0
[131436.572885]  from: [<ffffffff8133c806>] sidtab_context_to_sid+0x96/0x48=
0
[131436.580478]    to: [<ffffffff8133c800>] sidtab_context_to_sid+0x90/0x48=
0
[131436.588070]  from: [<ffffffff8133c825>] sidtab_context_to_sid+0xb5/0x48=
0
[131436.595662]    to: [<ffffffff8133c810>] sidtab_context_to_sid+0xa0/0x48=
0
[131436.603255]  from: [<ffffffff8133c842>] sidtab_context_to_sid+0xd2/0x48=
0
[131436.610847]    to: [<ffffffff8133c810>] sidtab_context_to_sid+0xa0/0x48=
0
[131436.618439]  from: [<ffffffff8133c842>] sidtab_context_to_sid+0xd2/0x48=
0
[131436.626031]    to: [<ffffffff8133c810>] sidtab_context_to_sid+0xa0/0x48=
0
[131436.633624]  from: [<ffffffff8133c842>] sidtab_context_to_sid+0xd2/0x48=
0
[131436.641216]    to: [<ffffffff8133c81e>] sidtab_context_to_sid+0xae/0x48=
0
[131436.648810]  from: [<ffffffff8133c7ef>] sidtab_context_to_sid+0x7f/0x48=
0
[131436.656401]    to: [<ffffffff8133c7e5>] sidtab_context_to_sid+0x75/0x48=
0
[131436.663994]  from: [<ffffffff8133cabb>] sidtab_context_to_sid+0x34b/0x4=
80
[131436.671684] Stack:
[131436.674023]  ffff88005e2ebb88 ffff88005e2ebb08 ffffffff8134938e
ffff88005e2ebc3c
[131436.682416]  0000000000000000 ffff88005e2ebb88 0000000000000010
ffff880060371ea8
[131436.690809]  ffff8800716d4968 ffff88005e2ebbf8 ffffffff8134372f
0000000600000000
[131436.699204] Call Trace:
[131436.702036]  [<ffffffff8134938e>] ? mls_context_isvalid+0x2e/0xb0
[131436.708944]  [<ffffffff8134372f>] security_compute_sid.part.10+0x43f/0x=
550
[131436.716727]  [<ffffffff81275d00>] ? search_dir+0x40/0x120
[131436.722851]  [<ffffffff8134388e>] security_compute_sid+0x4e/0x50
[131436.729660]  [<ffffffff81345d8d>] security_transition_sid+0x2d/0x40
[131436.736762]  [<ffffffff81330496>] may_create+0x96/0x100
[131436.742699]  [<ffffffff81330553>] selinux_inode_create+0x13/0x20
[131436.749509]  [<ffffffff8132bcef>] security_inode_create+0x1f/0x30
[131436.756417]  [<ffffffff811d146e>] vfs_create+0x8e/0x140
[131436.762353]  [<ffffffff811d1d01>] do_last+0x7e1/0x1210
[131436.768192]  [<ffffffff811cd71c>] ? link_path_walk+0x8c/0xfb0
[131436.774712]  [<ffffffff811ab3f1>] ? kmem_cache_alloc_trace+0xe1/0x1d0
[131436.782008]  [<ffffffff81333e4c>] ? selinux_file_alloc_security+0x3c/0x=
60
[131436.789692]  [<ffffffff811d27eb>] path_openat+0xbb/0x6d0
[131436.795724]  [<ffffffff811d0fb8>] ? SYSC_renameat+0xe8/0x3f0
[131436.802146]  [<ffffffff811d363a>] do_filp_open+0x3a/0xa0
[131436.808179]  [<ffffffff81aa8e78>] ? _raw_spin_unlock+0x18/0x40
[131436.814795]  [<ffffffff811e03b7>] ? __alloc_fd+0xa7/0x130
[131436.820925]  [<ffffffff811c090c>] do_sys_open+0x12c/0x220
[131436.827056]  [<ffffffff812176a1>] compat_SyS_openat+0x11/0x20
[131436.833574]  [<ffffffff81ab2f23>] sysenter_dispatch+0x7/0x1f
[131436.839997]  [<ffffffff8139b49b>] ? trace_hardirqs_on_thunk+0x3a/0x3c
[131436.847289] Code: 02 00 00 66 2e 0f 1f 84 00 00 00 00 00 41 8b 50
0c 85 d2 74 08 39 d0 0f 84 70 02 00 00 4d 8b 64 24 50 4d 85 e4 0f 84
92 02 00 00 <41> 8b 44 24 14 85 c0 75 d9 41 8b 48 0c 85 c9 75 e1 49 8b
00 49
[131436.869023] RIP
[131436.870977]  [<ffffffff8133c81e>] sidtab_context_to_sid+0xae/0x480
[131436.878180]  RSP <ffff88005e2ebae0>
[131436.882285] ---[ end trace 4c33bfa820f020fe ]---


--_000_476DC76E7D1DF2438D32BFADF679FC561CD2178DORSMSX103amrcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">I found a very similar oops online:<o:p></o:p></p>
<p class=3D"MsoNormal">http://oops.kernel.org/oops/general-protection-fault=
-in-sidtab_context_to_sid/<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Has anyone encountered this bug?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I had something reported to me very similar where th=
e faulting instruction was:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">0xffffffff8133c81e &lt;&#43;174&gt;:&nbsp;&nbsp; mov=
&nbsp;&nbsp;&nbsp; 0x14(%r12),%eax<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Addr2line on vmlinux produced:<o:p></o:p></p>
<p class=3D"MsoNormal">$ addr2line -f -e ./vmlinux ffffffff8133c81e<o:p></o=
:p></p>
<p class=3D"MsoNormal">context_cmp<o:p></o:p></p>
<p class=3D"MsoNormal">kernel/cht/security/selinux/ss/context.h:152<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Actual Dump:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[131436.409639] general protection fault: 0000 [#1] =
PREEMPT SMP<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.416085] Modules linked in: tcp_diag inet_dia=
g<o:p></o:p></p>
<p class=3D"MsoNormal">atomisp_css2401a0_v21 videobuf_vmalloc videobuf_core=
 bt_lpm<o:p></o:p></p>
<p class=3D"MsoNormal">rfkill_gpio 8723bs(O) cfg80211 ov2680 ov8858_driver =
silead_ts ltr501<o:p></o:p></p>
<p class=3D"MsoNormal">bmg160 ak09911 kxcjk_1013<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.436623] CPU: 3 PID: 3177 Comm: SettingsProvi=
de Tainted: G<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; W&nbsp; O 3.14.70-x86_64-02246-g49319b8 #1<o:=
p></o:p></p>
<p class=3D"MsoNormal">[131436.447500] Hardware name: XXX<o:p></o:p></p>
<p class=3D"MsoNormal">CHTMRD.A6.002.016 09/20/2016<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.456542] task: ffff88006039cb30 ti: ffff88005=
e2ea000 task.ti:<o:p></o:p></p>
<p class=3D"MsoNormal">ffff88005e2ea000<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.465000] RIP: 0010:[&lt;ffffffff8133c81e&gt;]=
<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.469579]&nbsp; [&lt;ffffffff8133c81e&gt;] sid=
tab_context_to_sid&#43;0xae/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.476783] RSP: 0018:ffff88005e2ebae0&nbsp; EFL=
AGS: 00010286<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.482814] RAX: 00000000fff9f9f9 RBX: ffffffff8=
2776540 RCX:<o:p></o:p></p>
<p class=3D"MsoNormal">0000000000000000<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.490884] RDX: 0000000000000000 RSI: 000000000=
0000000 RDI:<o:p></o:p></p>
<p class=3D"MsoNormal">ffffffff82776540<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.498953] RBP: ffff88005e2ebb28 R08: ffff88005=
e2ebb88 R09:<o:p></o:p></p>
<p class=3D"MsoNormal">0000000000000000<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.507022] R10: ffff88007826c000 R11: 2f2f2f2f2=
f2f2f2f R12:<o:p></o:p></p>
<p class=3D"MsoNormal">fff9f9f9fff9f9f9<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.515091] R13: ffff88005e2ebba0 R14: ffff88005=
e2ebbb8 R15:<o:p></o:p></p>
<p class=3D"MsoNormal">0000000000000068<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.523160] FS:&nbsp; 00000000d1efbe00(006b) GS:=
ffff880079380000(0063)<o:p></o:p></p>
<p class=3D"MsoNormal">knlGS:00000000d1a77960<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.532297] CS:&nbsp; 0010 DS: 002b ES: 002b CR0=
: 0000000080050033<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.538813] CR2: 0000000072e67750 CR3: 000000005=
e1ba000 CR4:<o:p></o:p></p>
<p class=3D"MsoNormal">00000000001007e0<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.546883] Last Branch Records:<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.550590]&nbsp;&nbsp;&nbsp; to: [&lt;ffffffff8=
1aa9ac0&gt;] general_protection&#43;0x0/0x80<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.557700]&nbsp; from: [&lt;ffffffff8133c81e&gt=
;] sidtab_context_to_sid&#43;0xae/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.565292]&nbsp;&nbsp;&nbsp; to: [&lt;ffffffff8=
133c810&gt;] sidtab_context_to_sid&#43;0xa0/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.572885]&nbsp; from: [&lt;ffffffff8133c806&gt=
;] sidtab_context_to_sid&#43;0x96/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.580478]&nbsp;&nbsp;&nbsp; to: [&lt;ffffffff8=
133c800&gt;] sidtab_context_to_sid&#43;0x90/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.588070]&nbsp; from: [&lt;ffffffff8133c825&gt=
;] sidtab_context_to_sid&#43;0xb5/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.595662]&nbsp;&nbsp;&nbsp; to: [&lt;ffffffff8=
133c810&gt;] sidtab_context_to_sid&#43;0xa0/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.603255]&nbsp; from: [&lt;ffffffff8133c842&gt=
;] sidtab_context_to_sid&#43;0xd2/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.610847]&nbsp;&nbsp;&nbsp; to: [&lt;ffffffff8=
133c810&gt;] sidtab_context_to_sid&#43;0xa0/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.618439]&nbsp; from: [&lt;ffffffff8133c842&gt=
;] sidtab_context_to_sid&#43;0xd2/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.626031]&nbsp;&nbsp;&nbsp; to: [&lt;ffffffff8=
133c810&gt;] sidtab_context_to_sid&#43;0xa0/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.633624]&nbsp; from: [&lt;ffffffff8133c842&gt=
;] sidtab_context_to_sid&#43;0xd2/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.641216]&nbsp;&nbsp;&nbsp; to: [&lt;ffffffff8=
133c81e&gt;] sidtab_context_to_sid&#43;0xae/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.648810]&nbsp; from: [&lt;ffffffff8133c7ef&gt=
;] sidtab_context_to_sid&#43;0x7f/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.656401]&nbsp;&nbsp;&nbsp; to: [&lt;ffffffff8=
133c7e5&gt;] sidtab_context_to_sid&#43;0x75/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.663994]&nbsp; from: [&lt;ffffffff8133cabb&gt=
;] sidtab_context_to_sid&#43;0x34b/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.671684] Stack:<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.674023]&nbsp; ffff88005e2ebb88 ffff88005e2eb=
b08 ffffffff8134938e<o:p></o:p></p>
<p class=3D"MsoNormal">ffff88005e2ebc3c<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.682416]&nbsp; 0000000000000000 ffff88005e2eb=
b88 0000000000000010<o:p></o:p></p>
<p class=3D"MsoNormal">ffff880060371ea8<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.690809]&nbsp; ffff8800716d4968 ffff88005e2eb=
bf8 ffffffff8134372f<o:p></o:p></p>
<p class=3D"MsoNormal">0000000600000000<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.699204] Call Trace:<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.702036]&nbsp; [&lt;ffffffff8134938e&gt;] ? m=
ls_context_isvalid&#43;0x2e/0xb0<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.708944]&nbsp; [&lt;ffffffff8134372f&gt;] sec=
urity_compute_sid.part.10&#43;0x43f/0x550<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.716727]&nbsp; [&lt;ffffffff81275d00&gt;] ? s=
earch_dir&#43;0x40/0x120<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.722851]&nbsp; [&lt;ffffffff8134388e&gt;] sec=
urity_compute_sid&#43;0x4e/0x50<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.729660]&nbsp; [&lt;ffffffff81345d8d&gt;] sec=
urity_transition_sid&#43;0x2d/0x40<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.736762]&nbsp; [&lt;ffffffff81330496&gt;] may=
_create&#43;0x96/0x100<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.742699]&nbsp; [&lt;ffffffff81330553&gt;] sel=
inux_inode_create&#43;0x13/0x20<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.749509]&nbsp; [&lt;ffffffff8132bcef&gt;] sec=
urity_inode_create&#43;0x1f/0x30<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.756417]&nbsp; [&lt;ffffffff811d146e&gt;] vfs=
_create&#43;0x8e/0x140<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.762353]&nbsp; [&lt;ffffffff811d1d01&gt;] do_=
last&#43;0x7e1/0x1210<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.768192]&nbsp; [&lt;ffffffff811cd71c&gt;] ? l=
ink_path_walk&#43;0x8c/0xfb0<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.774712]&nbsp; [&lt;ffffffff811ab3f1&gt;] ? k=
mem_cache_alloc_trace&#43;0xe1/0x1d0<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.782008]&nbsp; [&lt;ffffffff81333e4c&gt;] ? s=
elinux_file_alloc_security&#43;0x3c/0x60<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.789692]&nbsp; [&lt;ffffffff811d27eb&gt;] pat=
h_openat&#43;0xbb/0x6d0<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.795724]&nbsp; [&lt;ffffffff811d0fb8&gt;] ? S=
YSC_renameat&#43;0xe8/0x3f0<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.802146]&nbsp; [&lt;ffffffff811d363a&gt;] do_=
filp_open&#43;0x3a/0xa0<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.808179]&nbsp; [&lt;ffffffff81aa8e78&gt;] ? _=
raw_spin_unlock&#43;0x18/0x40<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.814795]&nbsp; [&lt;ffffffff811e03b7&gt;] ? _=
_alloc_fd&#43;0xa7/0x130<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.820925]&nbsp; [&lt;ffffffff811c090c&gt;] do_=
sys_open&#43;0x12c/0x220<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.827056]&nbsp; [&lt;ffffffff812176a1&gt;] com=
pat_SyS_openat&#43;0x11/0x20<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.833574]&nbsp; [&lt;ffffffff81ab2f23&gt;] sys=
enter_dispatch&#43;0x7/0x1f<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.839997]&nbsp; [&lt;ffffffff8139b49b&gt;] ? t=
race_hardirqs_on_thunk&#43;0x3a/0x3c<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.847289] Code: 02 00 00 66 2e 0f 1f 84 00 00 =
00 00 00 41 8b 50<o:p></o:p></p>
<p class=3D"MsoNormal">0c 85 d2 74 08 39 d0 0f 84 70 02 00 00 4d 8b 64 24 5=
0 4d 85 e4 0f 84<o:p></o:p></p>
<p class=3D"MsoNormal">92 02 00 00 &lt;41&gt; 8b 44 24 14 85 c0 75 d9 41 8b=
 48 0c 85 c9 75 e1 49 8b<o:p></o:p></p>
<p class=3D"MsoNormal">00 49<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.869023] RIP<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.870977]&nbsp; [&lt;ffffffff8133c81e&gt;] sid=
tab_context_to_sid&#43;0xae/0x480<o:p></o:p></p>
<p class=3D"MsoNormal">[131436.878180]&nbsp; RSP &lt;ffff88005e2ebae0&gt;<o=
:p></o:p></p>
<p class=3D"MsoNormal">[131436.882285] ---[ end trace 4c33bfa820f020fe ]---=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_476DC76E7D1DF2438D32BFADF679FC561CD2178DORSMSX103amrcor_--
