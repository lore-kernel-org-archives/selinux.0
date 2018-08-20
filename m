From: Sachin Grover <grover_sachin@outlook.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Aug 2018 06:29:56 +0000
Message-ID: <CO1PR14MB106114A87AD82A0D6895EC6986320@CO1PR14MB1061.namprd14.prod.outlook.com>
References: <CO1PR14MB10615AE03A49927CC39A041986390@CO1PR14MB1061.namprd14.prod.outlook.com>
 <531392a3-1a17-9732-3a89-4231339f800d@tycho.nsa.gov>
 <19b33f36-0dbd-12e3-e224-5aa4b8c796f2@tycho.nsa.gov>
 <CO1PR14MB10618CA82AFA6551A776376986390@CO1PR14MB1061.namprd14.prod.outlook.com>,
 <45661f73-3bfa-ad2d-d4c6-5ea03a093ac5@tycho.nsa.gov>
In-Reply-To: <45661f73-3bfa-ad2d-d4c6-5ea03a093ac5@tycho.nsa.gov>
Content-Type: multipart/alternative;
 boundary="_000_CO1PR14MB106114A87AD82A0D6895EC6986320CO1PR14MB1061namp_"
MIME-Version: 1.0
Subject: Re: Possible OOB Read in Kernel Heap Memory in call to
 ext4_xattr_set_entry()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_CO1PR14MB106114A87AD82A0D6895EC6986320CO1PR14MB1061namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

My POC uses fscreate() to modify the current SELinux context of the running=
 process, it then creates a new node via mknod(), (), which is then going t=
o assign the current SLEinux context over to that object.

In the call path I am seeing security_sid_to_context_core().

I see a code path where it in fact seem to correctly take the strlen() of t=
he incoming context, based on the sid, and use kmemdup(), but that only occ=
urs when SELinux is not initialized.

    if (!ss_initialized) {
           if (sid <=3D SECINITSID_NUM) {
                   char *scontextp;

                   *scontext_len =3D strlen(initial_sid_to_string[sid]) + 1=
;
                   if (!scontext)
                           goto out;
                   scontextp =3D kmemdup(initial_sid_to_string[sid],
                                      *scontext_len, GFP_ATOMIC);
                   if (!scontextp) {
                           rc =3D -ENOMEM;
                           goto out;
                   }
                   *scontext =3D scontextp;
                   goto out;
           }
           printk(KERN_ERR "SELinux: %s:  called before initial "
                  "load_policy on unknown SID %d\n", __func__, sid);
           rc =3D -EINVAL;
           goto out;
    }

Once SELinux is initialized that block will be skipped and further down you=
=92ll see the call to context_struct_to_string() which copies the context u=
sing kstrdup() and uses the incoming length rather than the strlen() length=
. In addition to this I=92m not sure how safe using strlen() is in general =
as there seems to be an assumption that context strings can contain NULL ch=
aracters based on this comment.

                          /* We strip a nul only if it is at the end, other=
wise the
                           * context contains a nul and we should audit tha=
t */
                          if (str[size - 1] =3D=3D '\0')
                                 audit_size =3D size - 1;
                          else
                                 audit_size =3D size;

Call StacK:

[<ffffffff80430b25>] kasan_report+0x32c/0x485 mm/kasan/report.c:309
[<ffffffff8042fafb>] check_memory_region_inline mm/kasan/kasan.c:301 [inlin=
e]
[<ffffffff8042fafb>] check_memory_region+0x2b/0x130 mm/kasan/kasan.c:315
[<ffffffff8042fc38>] __asan_loadN+0xf/0x11 mm/kasan/kasan.c:745
[<ffffffff805775be>] ext4_xattr_set_entry+0x6a1/0x6d3 fs/ext4/xattr.c:747
[<ffffffff805790ab>] ext4_xattr_ibody_set.isra.9+0x4f/0x118 fs/ext4/xattr.c=
:1118
[<ffffffff8057a1cb>] ext4_xattr_set_handle+0x39a/0x7b4 fs/ext4/xattr.c:1224
[<ffffffff80582683>] ext4_initxattrs+0x6b/0x96 fs/ext4/xattr_security.c:42
[<ffffffff805ecd43>] security_inode_init_security+0x170/0x1c9 security/secu=
rity.c:403
[<ffffffff8058275d>] ext4_init_security+0x35/0x3d fs/ext4/xattr_security.c:=
56
[<ffffffff8050295a>] __ext4_new_inode+0x1f24/0x2266 fs/ext4/ialloc.c:1059
[<ffffffff8051f771>] ext4_mknod+0x11a/0x263 fs/ext4/namei.c:2510
[<ffffffff8044d8e6>] vfs_mknod2+0x1ee/0x29f fs/namei.c:3722
[<ffffffff804554fb>] SYSC_mknodat fs/namei.c:3780 [inline]
[<ffffffff804554fb>] SyS_mknodat+0x19a/0x22a fs/namei.c:3752
[<ffffffff802028f9>] do_syscall_64+0xf8/0x191 arch/x86/entry/common.c:282
[<ffffffff80fa963e>] entry_SYSCALL_64_after_swapgs+0x58/0xc6

Syzkaller reproducer:
# {Threaded:false Collide:false Repeat:false Procs:1 Sandbox:none Fault:fal=
se FaultCall:-1 FaultNth:0 EnableTun:false UseTmpDir:false EnableCgroups:fa=
lse EnableNetdev:false ResetNet:false HandleSegv:false WaitRepeat:false Deb=
ug:false Repro:false}
r0 =3D syz_open_procfs(0xffffffffffffffff, &(0x7f00000002c0)=3D'attr/fscrea=
te\x00')
write$cgroup_pid(r0, &(0x7f0000000180)=3DANY=3D[
ANYBLOB<https://people.qualcomm.com/People?id=3DANYBLOB>
=3D"37393430ad3c35020000000000000023959c533574eab7032c45f6d7384f73ab"], 0x2=
0)
syz_fuseblk_mount(&(0x7f0000000000)=3D'./file0\x00', &(0x7f0000000080)=3D'.=
/file0\x00', 0xe003, 0x0, 0x0, 0x100000000, 0x4, 0x0)

Please let me know if something is wrong with the way I am seeing this.

Regards,
Sachin Grover
________________________________
From: Stephen Smalley <sds@tycho.nsa.gov>
Sent: Monday, August 13, 2018 6:37 PM
To: Sachin Grover; selinux@tycho.nsa.gov; Paul Moore
Subject: Re: Possible OOB Read in Kernel Heap Memory in call to ext4_xattr_=
set_entry()

On 08/13/2018 08:59 AM, Sachin Grover wrote:
> I agree with you that it cannot be exploitable on Android, but Kasan is
> able to find it as OOB if I run syzkaller on x86 based VM image. My last
> commit is actually only fixing one path, but there are multiple path
> which are having same issue, so it would be better if fix is given in
> context_struct_to_string() where length is calculated.
>
> Let me know what is your take on this.

Are you sure that your earlier commit is included in the kernels you are
testing? If so, can you provide one of the other code paths not
addressed by your earlier commit?  It appears that context.len is only
ever set by security_context_to_sid_core(), and there it is set to
strlen(str)+1 after your commit (and context.str is set to str, which is
the result of kstrdup of the original context).  Thus, when we reach
context_struct_to_string() later, context->len can only be
strlen(context->str)+1 AFAICS.  What am I missing?

>
>
>
>
> From: Stephen Smalley
> Sent: Monday 13 August, 18:05
> Subject: Re: Possible OOB Read in Kernel Heap Memory in call to
> ext4_xattr_set_entry()
> To: Sachin Grover, selinux@tycho.nsa.gov, Paul Moore
>
>
> On 08/13/2018 08:23 AM, Stephen Smalley wrote: > On 08/13/2018 01:19 AM,
> Sachin Grover wrote: >> Hi Stephen/Paul, >> >> This issue was discovered
> using >> https://android.googlesource.com/kernel/common -b
> android-4.9-o, but >> I've verified the code path exists in msm-4.4. It
> likely exists in >> other kernel versions as well. >> >> As a privileged
> user, one can override the current SELinux context via >> a call to
> setfscreatecon() or by writing directly to >> /proc/self/attr/fscreate.
> The context is then used to label the next >> newly created file object,
> e.g. mknod(). Upon handling the creation of >> the new object on the
> EXT4 FS we end up calling >> selinux_inode_init_security() to create a
> new xattr object for the >> inode. This will end up calling
> context_struct_to_string() to convert >> the SID back to the string
> version of the SELinux security context >> that was stored. >> >> static
> int context_struct_to_string(struct context *context, char >>
> **scontext, u32 *scontext_len) >>   { >>      char *scontextp; >> >>
>     if (scontext) >>           *scontext =3D NULL; >>       *scontext_len
> =3D 0; >> >>       if (context->len) { >>          *scontext_len =3D
> context->len; >>            if (scontext) { >>                *scontext
> =3D kstrdup(context->str, GFP_ATOMIC); >>                 if
> (!(*scontext)) >>                       return -ENOMEM; >>           }
>  >>           return 0; >>       } >> >> scontext is populated with the
> context length, directly from the >> context structure, and using
> kstrdup() to copy the string. Much later >> down the call stack
> ext4_xattr_set_entry() is called with the SELinux >> xattr object. >> >>
>  >>               if (i->value =3D=3D EXT4_ZERO_XATTR_VALUE) { >>
>         memset(val, 0, size); >>               } else { >>
>       /* Clear the pad bytes first. */ >>                   memset(val +
> size - EXT4_XATTR_PAD, 0, >>                          EXT4_XATTR_PAD);
>  >>                   memcpy(val, i->value, i->value_len); >>
>     } >> >> SELinux allows for the creation of contexts that include
> NULL bytes. >> Unfortunately in this case if a NULL byte occurs not as
> the string >> terminator, then kstrdup() will allocate a memory region
> smaller than >> what context->len represents. Later in
> ext4_xattr_set_entry() the >> original context->len will be used in
> memcpy() and will exceed the >> heap memory allocated by kstrdup()
> leading to an OOB issue. There may >> also be the potential for memory
> corruption depending on the total >> length of the SELinux context, but
> this would require further analysis. >> >> Can you please let me know if
> my analysis is correct. >> As per me, it looks like there is problem in
> the code. > > Your earlier commit
> efe3de79e0b52ca281ef6691480c8c68c82a4657 ensures > that context->len is
> only ever set to strlen(str)+1.  So is it still > possible for this
> condition to occur? Also, as with the earlier bug, this one is only
> exploitable for a process with CAP_MAC_ADMIN that is allowed mac_admin
> permission in SELinux policy, and this is prohibited in Android policy
> via neverallow and checked by CTS.
>


--_000_CO1PR14MB106114A87AD82A0D6895EC6986320CO1PR14MB1061namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
My POC uses fscreate() to modify the current SELinux context of the running=
 process, it then creates a new node via mknod(),&nbsp;<span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">(),
 which is then going to assign the current SLEinux context over to that obj=
ect.</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">In the call path =
I am seeing
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">
security_sid_to_context_core().</span></span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"fo=
nt-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"fo=
nt-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span>I
 see a code path where it in fact seem to correctly take the strlen() of th=
e incoming context, based on the sid, and use kmemdup(), but that only occu=
rs when SELinux is not initialized.<br>
</span>
<div><br>
</div>
<div>&nbsp; &nbsp; if (!ss_initialized) {<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (sid &lt;=3D SECINITSID_NU=
M) {<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;c=
har *scontextp;<br>
</div>
<div><br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*=
scontext_len =3D strlen(initial_sid_to_string[sid]) &#43; 1;<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;i=
f (!scontext)<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;goto out;<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;s=
contextp =3D kmemdup(initial_sid_to_string[sid],<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *scontext_le=
n, GFP_ATOMIC);<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;i=
f (!scontextp) {<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;rc =3D -ENOMEM;<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;goto out;<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}=
<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*=
scontext =3D scontextp;<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;g=
oto out;<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;printk(KERN_ERR &quot;SELinux=
: %s: &nbsp;called before initial &quot;<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;l=
oad_policy on unknown SID %d\n&quot;, __func__, sid);<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rc =3D -EINVAL;<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto out;<br>
</div>
<div>&nbsp; &nbsp; }<br>
</div>
<div><br>
</div>
<div>Once SELinux is initialized that block will be skipped and further dow=
n you=92ll see the call to context_struct_to_string() which copies the cont=
ext using kstrdup() and uses the incoming length rather than the strlen() l=
ength. In addition to this I=92m not
 sure how safe using strlen() is in general as there seems to be an assumpt=
ion that context strings can contain NULL characters based on this comment.=
<br>
</div>
<div><br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; /* We strip a nul only if it is at the end, otherwise =
the<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;* context contains a nul and we should audit tha=
t */<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; if (str[size - 1] =3D=3D '\0')<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;audit_size =3D size - 1;<br=
>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; else<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;audit_size =3D size;<br>
</div>
<span></span><br>
</span></span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"fo=
nt-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">Call
 StacK:</span></span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"fo=
nt-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255); display: inline !important">=
[&lt;ffffffff80430b25&gt;]
 kasan_report&#43;0x32c/0x485 mm/kasan/report.c:309</span><br style=3D"box-=
sizing: border-box; color: rgb(51, 51, 51); font-family: QualcommWeb, Arial=
, sans-serif; font-size: 17px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff8042fafb&gt;] check_memory_region_inline mm/k=
asan/kasan.c:301 [inline]</span><br style=3D"box-sizing: border-box; color:=
 rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-size: 1=
7px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff8042fafb&gt;] check_memory_region&#43;0x2b/0x=
130 mm/kasan/kasan.c:315</span><br style=3D"box-sizing: border-box; color: =
rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-size: 17=
px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff8042fc38&gt;] __asan_loadN&#43;0xf/0x11 mm/ka=
san/kasan.c:745</span><br style=3D"box-sizing: border-box; color: rgb(51, 5=
1, 51); font-family: QualcommWeb, Arial, sans-serif; font-size: 17px; backg=
round-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff805775be&gt;] ext4_xattr_set_entry&#43;0x6a1/=
0x6d3 fs/ext4/xattr.c:747</span><br style=3D"box-sizing: border-box; color:=
 rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-size: 1=
7px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff805790ab&gt;] ext4_xattr_ibody_set.isra.9&#43=
;0x4f/0x118 fs/ext4/xattr.c:1118</span><br style=3D"box-sizing: border-box;=
 color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-=
size: 17px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff8057a1cb&gt;] ext4_xattr_set_handle&#43;0x39a=
/0x7b4 fs/ext4/xattr.c:1224</span><br style=3D"box-sizing: border-box; colo=
r: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-size:=
 17px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff80582683&gt;] ext4_initxattrs&#43;0x6b/0x96 f=
s/ext4/xattr_security.c:42</span><br style=3D"box-sizing: border-box; color=
: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-size: =
17px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff805ecd43&gt;] security_inode_init_security&#4=
3;0x170/0x1c9 security/security.c:403</span><br style=3D"box-sizing: border=
-box; color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; =
font-size: 17px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff8058275d&gt;] ext4_init_security&#43;0x35/0x3=
d fs/ext4/xattr_security.c:56</span><br style=3D"box-sizing: border-box; co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff8050295a&gt;] __ext4_new_inode&#43;0x1f24/0x2=
266 fs/ext4/ialloc.c:1059</span><br style=3D"box-sizing: border-box; color:=
 rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-size: 1=
7px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff8051f771&gt;] ext4_mknod&#43;0x11a/0x263 fs/e=
xt4/namei.c:2510</span><br style=3D"box-sizing: border-box; color: rgb(51, =
51, 51); font-family: QualcommWeb, Arial, sans-serif; font-size: 17px; back=
ground-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff8044d8e6&gt;] vfs_mknod2&#43;0x1ee/0x29f fs/n=
amei.c:3722</span><br style=3D"box-sizing: border-box; color: rgb(51, 51, 5=
1); font-family: QualcommWeb, Arial, sans-serif; font-size: 17px; backgroun=
d-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff804554fb&gt;] SYSC_mknodat fs/namei.c:3780 [i=
nline]</span><br style=3D"box-sizing: border-box; color: rgb(51, 51, 51); f=
ont-family: QualcommWeb, Arial, sans-serif; font-size: 17px; background-col=
or: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff804554fb&gt;] SyS_mknodat&#43;0x19a/0x22a fs/=
namei.c:3752</span><br style=3D"box-sizing: border-box; color: rgb(51, 51, =
51); font-family: QualcommWeb, Arial, sans-serif; font-size: 17px; backgrou=
nd-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff802028f9&gt;] do_syscall_64&#43;0xf8/0x191 ar=
ch/x86/entry/common.c:282</span><br style=3D"box-sizing: border-box; color:=
 rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-size: 1=
7px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">[&lt;ffffffff80fa963e&gt;] entry_SYSCALL_64_after_swapgs&#=
43;0x58/0xc6</span><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255); display: inline !important">=
Syzkaller
 reproducer:</span><br style=3D"box-sizing: border-box; color: rgb(51, 51, =
51); font-family: QualcommWeb, Arial, sans-serif; font-size: 17px; backgrou=
nd-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important"># {Threaded:false Collide:false Repeat:false Procs:1 Sandb=
ox:none Fault:false FaultCall:-1 FaultNth:0
 EnableTun:false UseTmpDir:false EnableCgroups:false EnableNetdev:false Res=
etNet:false HandleSegv:false WaitRepeat:false Debug:false Repro:false}</spa=
n><br style=3D"box-sizing: border-box; color: rgb(51, 51, 51); font-family:=
 QualcommWeb, Arial, sans-serif; font-size: 17px; background-color: rgb(255=
, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">r0 =3D syz_open_procfs(0xffffffffffffffff, &amp;(0x7f00000=
002c0)=3D'attr/fscreate\x00')</span><br style=3D"box-sizing: border-box; co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">write$cgroup_pid(r0, &amp;(0x7f0000000180)=3DANY=3D[</span=
>
<div style=3D"box-sizing: border-box; color: rgb(51, 51, 51); font-family: =
QualcommWeb, Arial, sans-serif; font-size: 17px; background-color: rgb(255,=
 255, 255); display: inline">
<span title=3D"" style=3D"box-sizing: border-box;"><a href=3D"https://peopl=
e.qualcomm.com/People?id=3DANYBLOB" target=3D"_blank" style=3D"box-sizing: =
border-box; cursor: pointer">ANYBLOB</a></span></div>
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">=3D&quot;37393430ad3c35020000000000000023959c533574eab7032=
c45f6d7384f73ab&quot;], 0x20)</span><br style=3D"box-sizing: border-box; co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255)">
<span style=3D"color: rgb(51, 51, 51); font-family: QualcommWeb, Arial, san=
s-serif; font-size: 17px; background-color: rgb(255, 255, 255); display: in=
line !important">syz_fuseblk_mount(&amp;(0x7f0000000000)=3D'./file0\x00', &=
amp;(0x7f0000000080)=3D'./file0\x00', 0xe003,
 0x0, 0x0, 0x100000000, 0x4, 0x0)</span><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255); display: inline !important">=
<br>
</span></span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255); display: inline !important">=
Please
 let me know if something is wrong with the way I am seeing this.</span></s=
pan></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255); display: inline !important">=
<br>
</span></span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255); display: inline !important">=
Regards,</span></span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
=0A=
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:=0A=
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA"><span style=3D"co=
lor: rgb(51, 51, 51); font-family: QualcommWeb, Arial, sans-serif; font-siz=
e: 17px; background-color: rgb(255, 255, 255); display: inline !important">=
Sachin
 Grover</span></span></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Stephen Smalley &lt;s=
ds@tycho.nsa.gov&gt;<br>
<b>Sent:</b> Monday, August 13, 2018 6:37 PM<br>
<b>To:</b> Sachin Grover; selinux@tycho.nsa.gov; Paul Moore<br>
<b>Subject:</b> Re: Possible OOB Read in Kernel Heap Memory in call to ext4=
_xattr_set_entry()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 08/13/2018 08:59 AM, Sachin Grover wrote:<br>
&gt; I agree with you that it cannot be exploitable on Android, but Kasan i=
s <br>
&gt; able to find it as OOB if I run syzkaller on x86 based VM image. My la=
st <br>
&gt; commit is actually only fixing one path, but there are multiple path <=
br>
&gt; which are having same issue, so it would be better if fix is given in =
<br>
&gt; context_struct_to_string() where length is calculated.<br>
&gt; <br>
&gt; Let me know what is your take on this.<br>
<br>
Are you sure that your earlier commit is included in the kernels you are <b=
r>
testing? If so, can you provide one of the other code paths not <br>
addressed by your earlier commit?&nbsp; It appears that context.len is only=
 <br>
ever set by security_context_to_sid_core(), and there it is set to <br>
strlen(str)&#43;1 after your commit (and context.str is set to str, which i=
s <br>
the result of kstrdup of the original context).&nbsp; Thus, when we reach <=
br>
context_struct_to_string() later, context-&gt;len can only be <br>
strlen(context-&gt;str)&#43;1 AFAICS.&nbsp; What am I missing?<br>
<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; From: Stephen Smalley<br>
&gt; Sent: Monday 13 August, 18:05<br>
&gt; Subject: Re: Possible OOB Read in Kernel Heap Memory in call to <br>
&gt; ext4_xattr_set_entry()<br>
&gt; To: Sachin Grover, selinux@tycho.nsa.gov, Paul Moore<br>
&gt; <br>
&gt; <br>
&gt; On 08/13/2018 08:23 AM, Stephen Smalley wrote: &gt; On 08/13/2018 01:1=
9 AM, <br>
&gt; Sachin Grover wrote: &gt;&gt; Hi Stephen/Paul, &gt;&gt; &gt;&gt; This =
issue was discovered <br>
&gt; using &gt;&gt; <a href=3D"https://android.googlesource.com/kernel/comm=
on">https://android.googlesource.com/kernel/common</a> -b
<br>
&gt; android-4.9-o, but &gt;&gt; I've verified the code path exists in msm-=
4.4. It <br>
&gt; likely exists in &gt;&gt; other kernel versions as well. &gt;&gt; &gt;=
&gt; As a privileged <br>
&gt; user, one can override the current SELinux context via &gt;&gt; a call=
 to <br>
&gt; setfscreatecon() or by writing directly to &gt;&gt; /proc/self/attr/fs=
create. <br>
&gt; The context is then used to label the next &gt;&gt; newly created file=
 object, <br>
&gt; e.g. mknod(). Upon handling the creation of &gt;&gt; the new object on=
 the <br>
&gt; EXT4 FS we end up calling &gt;&gt; selinux_inode_init_security() to cr=
eate a <br>
&gt; new xattr object for the &gt;&gt; inode. This will end up calling <br>
&gt; context_struct_to_string() to convert &gt;&gt; the SID back to the str=
ing <br>
&gt; version of the SELinux security context &gt;&gt; that was stored. &gt;=
&gt; &gt;&gt; static <br>
&gt; int context_struct_to_string(struct context *context, char &gt;&gt; <b=
r>
&gt; **scontext, u32 *scontext_len) &gt;&gt; &nbsp;&nbsp;{ &gt;&gt; &nbsp;&=
nbsp; &nbsp; char *scontextp; &gt;&gt; &gt;&gt;&nbsp;&nbsp;&nbsp; <br>
&gt;&nbsp; &nbsp; &nbsp;if (scontext) &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp;*scontext =3D NULL; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp;*scontex=
t_len <br>
&gt; =3D 0; &gt;&gt; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp;if (context-&gt;len=
) { &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; *scontext_len =3D <br>
&gt; context-&gt;len; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if =
(scontext) { &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; *scontext <br>
&gt; =3D kstrdup(context-&gt;str, GFP_ATOMIC); &gt;&gt; &nbsp;&nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if <br>
&gt; (!(*scontext)) &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -ENOMEM; &gt;&gt; &nbsp;&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp;} <br>
&gt;&nbsp; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0; &gt;&=
gt; &nbsp;&nbsp; &nbsp; &nbsp;} &gt;&gt; &gt;&gt; scontext is populated wit=
h the <br>
&gt; context length, directly from the &gt;&gt; context structure, and usin=
g <br>
&gt; kstrdup() to copy the string. Much later &gt;&gt; down the call stack =
<br>
&gt; ext4_xattr_set_entry() is called with the SELinux &gt;&gt; xattr objec=
t. &gt;&gt; &gt;&gt; <br>
&gt;&nbsp; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;i=
f (i-&gt;value =3D=3D EXT4_ZERO_XATTR_VALUE) { &gt;&gt;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memset(val, 0, size); &gt;&gt; &nbsp;=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} else { &gt;&gt;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp;/* Clear the pad bytes first. */ &gt;&gt; &n=
bsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memset(va=
l &#43; <br>
&gt; size - EXT4_XATTR_PAD, 0, &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; EXT4_XATTR_PAD); <br=
>
&gt;&nbsp; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;memcpy(val, i-&gt;value, i-&gt;value_len); &gt;&gt;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;&nbsp; &nbsp; &nbsp;} &gt;&gt; &gt;&gt; SELinux allows for the creation=
 of contexts that include <br>
&gt; NULL bytes. &gt;&gt; Unfortunately in this case if a NULL byte occurs =
not as <br>
&gt; the string &gt;&gt; terminator, then kstrdup() will allocate a memory =
region <br>
&gt; smaller than &gt;&gt; what context-&gt;len represents. Later in <br>
&gt; ext4_xattr_set_entry() the &gt;&gt; original context-&gt;len will be u=
sed in <br>
&gt; memcpy() and will exceed the &gt;&gt; heap memory allocated by kstrdup=
() <br>
&gt; leading to an OOB issue. There may &gt;&gt; also be the potential for =
memory <br>
&gt; corruption depending on the total &gt;&gt; length of the SELinux conte=
xt, but <br>
&gt; this would require further analysis. &gt;&gt; &gt;&gt; Can you please =
let me know if <br>
&gt; my analysis is correct. &gt;&gt; As per me, it looks like there is pro=
blem in <br>
&gt; the code. &gt; &gt; Your earlier commit <br>
&gt; efe3de79e0b52ca281ef6691480c8c68c82a4657 ensures &gt; that context-&gt=
;len is <br>
&gt; only ever set to strlen(str)&#43;1.&nbsp; So is it still &gt; possible=
 for this <br>
&gt; condition to occur? Also, as with the earlier bug, this one is only <b=
r>
&gt; exploitable for a process with CAP_MAC_ADMIN that is allowed mac_admin=
 <br>
&gt; permission in SELinux policy, and this is prohibited in Android policy=
 <br>
&gt; via neverallow and checked by CTS.<br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CO1PR14MB106114A87AD82A0D6895EC6986320CO1PR14MB1061namp_--
