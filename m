From: Sachin Grover <grover_sachin@outlook.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon, 13 Aug 2018 12:59:46 +0000
Message-ID: <CO1PR14MB10618CA82AFA6551A776376986390@CO1PR14MB1061.namprd14.prod.outlook.com>
References: <CO1PR14MB10615AE03A49927CC39A041986390@CO1PR14MB1061.namprd14.prod.outlook.com>
 <531392a3-1a17-9732-3a89-4231339f800d@tycho.nsa.gov>,
 <19b33f36-0dbd-12e3-e224-5aa4b8c796f2@tycho.nsa.gov>
In-Reply-To: <19b33f36-0dbd-12e3-e224-5aa4b8c796f2@tycho.nsa.gov>
Content-Type: multipart/alternative;
 boundary="_000_CO1PR14MB10618CA82AFA6551A776376986390CO1PR14MB1061namp_"
MIME-Version: 1.0
Subject: Re: Possible OOB Read in Kernel Heap Memory in call to
 ext4_xattr_set_entry()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_CO1PR14MB10618CA82AFA6551A776376986390CO1PR14MB1061namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I agree with you that it cannot be exploitable on Android, but Kasan is abl=
e to find it as OOB if I run syzkaller on x86 based VM image. My last commi=
t is actually only fixing one path, but there are multiple path which are h=
aving same issue, so it would be better if fix is given in context_struct_t=
o_string() where length is calculated.

Let me know what is your take on this.




From: Stephen Smalley
Sent: Monday 13 August, 18:05
Subject: Re: Possible OOB Read in Kernel Heap Memory in call to ext4_xattr_=
set_entry()
To: Sachin Grover, selinux@tycho.nsa.gov, Paul Moore


On 08/13/2018 08:23 AM, Stephen Smalley wrote: > On 08/13/2018 01:19 AM, Sa=
chin Grover wrote: >> Hi Stephen/Paul, >> >> This issue was discovered usin=
g >> https://android.googlesource.com/kernel/common -b android-4.9-o, but >=
> I've verified the code path exists in msm-4.4. It likely exists in >> oth=
er kernel versions as well. >> >> As a privileged user, one can override th=
e current SELinux context via >> a call to setfscreatecon() or by writing d=
irectly to >> /proc/self/attr/fscreate. The context is then used to label t=
he next >> newly created file object, e.g. mknod(). Upon handling the creat=
ion of >> the new object on the EXT4 FS we end up calling >> selinux_inode_=
init_security() to create a new xattr object for the >> inode. This will en=
d up calling context_struct_to_string() to convert >> the SID back to the s=
tring version of the SELinux security context >> that was stored. >> >> sta=
tic int context_struct_to_string(struct context *context, char >> **scontex=
t, u32 *scontext_len) >>   { >>      char *scontextp; >> >>       if (scont=
ext) >>           *scontext =3D NULL; >>       *scontext_len =3D 0; >> >>  =
     if (context->len) { >>          *scontext_len =3D context->len; >>    =
        if (scontext) { >>                *scontext =3D kstrdup(context->st=
r, GFP_ATOMIC); >>                 if (!(*scontext)) >>                    =
   return -ENOMEM; >>           } >>           return 0; >>       } >> >> s=
context is populated with the context length, directly from the >> context =
structure, and using kstrdup() to copy the string. Much later >> down the c=
all stack ext4_xattr_set_entry() is called with the SELinux >> xattr object=
. >> >> >>               if (i->value =3D=3D EXT4_ZERO_XATTR_VALUE) { >>   =
                memset(val, 0, size); >>               } else { >>         =
          /* Clear the pad bytes first. */ >>                   memset(val =
+ size - EXT4_XATTR_PAD, 0, >>                          EXT4_XATTR_PAD); >>=
                   memcpy(val, i->value, i->value_len); >>               } =
>> >> SELinux allows for the creation of contexts that include NULL bytes. =
>> Unfortunately in this case if a NULL byte occurs not as the string >> te=
rminator, then kstrdup() will allocate a memory region smaller than >> what=
 context->len represents. Later in ext4_xattr_set_entry() the >> original c=
ontext->len will be used in memcpy() and will exceed the >> heap memory all=
ocated by kstrdup() leading to an OOB issue. There may >> also be the poten=
tial for memory corruption depending on the total >> length of the SELinux =
context, but this would require further analysis. >> >> Can you please let =
me know if my analysis is correct. >> As per me, it looks like there is pro=
blem in the code. > > Your earlier commit efe3de79e0b52ca281ef6691480c8c68c=
82a4657 ensures > that context->len is only ever set to strlen(str)+1.  So =
is it still > possible for this condition to occur? Also, as with the earli=
er bug, this one is only exploitable for a process with CAP_MAC_ADMIN that =
is allowed mac_admin permission in SELinux policy, and this is prohibited i=
n Android policy via neverallow and checked by CTS.


--_000_CO1PR14MB10618CA82AFA6551A776376986390CO1PR14MB1061namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
I agree with you that it cannot be exploitable on Android, but Kasan is abl=
e to find it as OOB if I run syzkaller on x86 based VM image. My last commi=
t is actually only fixing one path, but there are multiple path which are h=
aving same issue, so it would be
 better if fix is given in context_struct_to_string() where length is calcu=
lated.
<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Let me know what is your take on this.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
From: Stephen Smalley<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Sent: Monday 13 August, 18:05<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
Subject: Re: Possible OOB Read in Kernel Heap Memory in call to ext4_xattr_=
set_entry()<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
To: Sachin Grover, selinux@tycho.nsa.gov, Paul Moore<br>
<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
On 08/13/2018 08:23 AM, Stephen Smalley wrote: &gt; On 08/13/2018 01:19 AM,=
 Sachin Grover wrote: &gt;&gt; Hi Stephen/Paul, &gt;&gt; &gt;&gt; This issu=
e was discovered using &gt;&gt; https://android.googlesource.com/kernel/com=
mon -b android-4.9-o, but &gt;&gt; I've verified the code path exists
 in msm-4.4. It likely exists in &gt;&gt; other kernel versions as well. &g=
t;&gt; &gt;&gt; As a privileged user, one can override the current SELinux =
context via &gt;&gt; a call to setfscreatecon() or by writing directly to &=
gt;&gt; /proc/self/attr/fscreate. The context is then used to
 label the next &gt;&gt; newly created file object, e.g. mknod(). Upon hand=
ling the creation of &gt;&gt; the new object on the EXT4 FS we end up calli=
ng &gt;&gt; selinux_inode_init_security() to create a new xattr object for =
the &gt;&gt; inode. This will end up calling context_struct_to_string()
 to convert &gt;&gt; the SID back to the string version of the SELinux secu=
rity context &gt;&gt; that was stored. &gt;&gt; &gt;&gt; static int context=
_struct_to_string(struct context *context, char &gt;&gt; **scontext, u32 *s=
context_len) &gt;&gt; &nbsp;&nbsp;{ &gt;&gt; &nbsp;&nbsp; &nbsp; char *scon=
textp; &gt;&gt; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp;if (scontext)
 &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*scontext =3D NULL; &gt;&=
gt; &nbsp;&nbsp; &nbsp; &nbsp;*scontext_len =3D 0; &gt;&gt; &gt;&gt; &nbsp;=
&nbsp; &nbsp; &nbsp;if (context-&gt;len) { &gt;&gt; &nbsp;&nbsp; &nbsp; &nb=
sp; &nbsp; *scontext_len =3D context-&gt;len; &gt;&gt; &nbsp;&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; if (scontext) { &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; *scontext =3D kstrdup(context-&gt;str, GFP_ATOMIC=
); &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if=
 (!(*scontext))
 &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;return -ENOMEM; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;} &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0; &gt;&gt=
; &nbsp;&nbsp; &nbsp; &nbsp;} &gt;&gt; &gt;&gt; scontext is populated with =
the context length, directly from the &gt;&gt; context structure, and using=
 kstrdup() to copy the string. Much later &gt;&gt; down the call stack
 ext4_xattr_set_entry() is called with the SELinux &gt;&gt; xattr object. &=
gt;&gt; &gt;&gt; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;if (i-&gt;value =3D=3D EXT4_ZERO_XATTR_VALUE) { &gt;&gt; &nbsp;&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memset(val, 0, size)=
; &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} else { &=
gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;/* Clear the pad bytes first. */ &gt;&gt;
 &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memset=
(val &#43; size - EXT4_XATTR_PAD, 0, &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; EXT4_XATTR_PAD=
); &gt;&gt; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp;memcpy(val, i-&gt;value, i-&gt;value_len); &gt;&gt; &nbsp;&nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} &gt;&gt; &gt;&gt; SELinux allows for =
the creation of contexts that include NULL bytes. &gt;&gt;
 Unfortunately in this case if a NULL byte occurs not as the string &gt;&gt=
; terminator, then kstrdup() will allocate a memory region smaller than &gt=
;&gt; what context-&gt;len represents. Later in ext4_xattr_set_entry() the =
&gt;&gt; original context-&gt;len will be used in memcpy()
 and will exceed the &gt;&gt; heap memory allocated by kstrdup() leading to=
 an OOB issue. There may &gt;&gt; also be the potential for memory corrupti=
on depending on the total &gt;&gt; length of the SELinux context, but this =
would require further analysis. &gt;&gt; &gt;&gt; Can you please
 let me know if my analysis is correct. &gt;&gt; As per me, it looks like t=
here is problem in the code. &gt; &gt; Your earlier commit efe3de79e0b52ca2=
81ef6691480c8c68c82a4657 ensures &gt; that context-&gt;len is only ever set=
 to strlen(str)&#43;1.&nbsp; So is it still &gt; possible for
 this condition to occur? Also, as with the earlier bug, this one is only e=
xploitable for a process with CAP_MAC_ADMIN that is allowed mac_admin permi=
ssion in SELinux policy, and this is prohibited in Android policy via never=
allow and checked by CTS.
<br>
<br>
</div>
</body>
</html>

--_000_CO1PR14MB10618CA82AFA6551A776376986390CO1PR14MB1061namp_--
