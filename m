Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7D5JOB4028502
 for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2018 01:19:24 -0400
From: Sachin Grover <grover_sachin@outlook.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Mon, 13 Aug 2018 05:19:15 +0000
Message-ID: <CO1PR14MB10615AE03A49927CC39A041986390@CO1PR14MB1061.namprd14.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="_000_CO1PR14MB10615AE03A49927CC39A041986390CO1PR14MB1061namp_"
MIME-Version: 1.0
Subject: Possible OOB Read in Kernel Heap Memory in call to
 ext4_xattr_set_entry()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_CO1PR14MB10615AE03A49927CC39A041986390CO1PR14MB1061namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Stephen/Paul,

This issue was discovered using https://android.googlesource.com/kernel/com=
mon -b android-4.9-o, but I've verified the code path exists in msm-4.4. It=
 likely exists in other kernel versions as well.

As a privileged user, one can override the current SELinux context via a ca=
ll to setfscreatecon() or by writing directly to /proc/self/attr/fscreate. =
The context is then used to label the next newly created file object, e.g. =
mknod(). Upon handling the creation of the new object on the EXT4 FS we end=
 up calling selinux_inode_init_security() to create a new xattr object for =
the inode. This will end up calling context_struct_to_string() to convert t=
he SID back to the string version of the SELinux security context that was =
stored.

static int context_struct_to_string(struct context *context, char **scontex=
t, u32 *scontext_len)
 {
    char *scontextp;

     if (scontext)
         *scontext =3D NULL;
     *scontext_len =3D 0;

     if (context->len) {
        *scontext_len =3D context->len;
          if (scontext) {
              *scontext =3D kstrdup(context->str, GFP_ATOMIC);
               if (!(*scontext))
                     return -ENOMEM;
         }
         return 0;
     }

scontext is populated with the context length, directly from the context st=
ructure, and using kstrdup() to copy the string. Much later down the call s=
tack ext4_xattr_set_entry() is called with the SELinux xattr object.


             if (i->value =3D=3D EXT4_ZERO_XATTR_VALUE) {
                 memset(val, 0, size);
             } else {
                 /* Clear the pad bytes first. */
                 memset(val + size - EXT4_XATTR_PAD, 0,
                        EXT4_XATTR_PAD);
                 memcpy(val, i->value, i->value_len);
             }

SELinux allows for the creation of contexts that include NULL bytes. Unfort=
unately in this case if a NULL byte occurs not as the string terminator, th=
en kstrdup() will allocate a memory region smaller than what context->len r=
epresents. Later in ext4_xattr_set_entry() the original context->len will b=
e used in memcpy() and will exceed the heap memory allocated by kstrdup() l=
eading to an OOB issue. There may also be the potential for memory corrupti=
on depending on the total length of the SELinux context, but this would req=
uire further analysis.

Can you please let me know if my analysis is correct.
As per me, it looks like there is problem in the code.

Regards,
Sachin Grover

--_000_CO1PR14MB10615AE03A49927CC39A041986390CO1PR14MB1061namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Hi Stephen/Paul,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span>This issue was discovered using https://android.googlesource.com/kern=
el/common -b android-4.9-o, but I've verified the code path exists in msm-4=
.4. It likely exists in other kernel versions as well.<br>
</span>
<div><br>
</div>
<div>As a privileged user, one can override the current SELinux context via=
 a call to setfscreatecon() or by writing directly to /proc/self/attr/fscre=
ate. The context is then used to label the next newly created file object, =
e.g. mknod(). Upon handling the
 creation of the new object on the EXT4 FS we end up calling selinux_inode_=
init_security() to create a new xattr object for the inode. This will end u=
p calling context_struct_to_string() to convert the SID back to the string =
version of the SELinux security
 context that was stored.<br>
</div>
<div><br>
</div>
<div>static int context_struct_to_string(struct context *context, char **sc=
ontext, u32 *scontext_len)
<br>
</div>
<div>&nbsp;{<br>
</div>
<div>&nbsp; &nbsp; char *scontextp;<br>
</div>
<div><br>
</div>
<div>&nbsp; &nbsp; &nbsp;if (scontext)<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*scontext =3D NULL;<br>
</div>
<div>&nbsp; &nbsp; &nbsp;*scontext_len =3D 0;<br>
</div>
<div>&nbsp;<br>
</div>
<div>&nbsp; &nbsp; &nbsp;if (context-&gt;len) {<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; *scontext_len =3D context-&gt;len;<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (scontext) {<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *scontext =3D kstrdup=
(context-&gt;str, GFP_ATOMIC);<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!(*scontext=
))</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;return -ENOMEM;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
</div>
<div>&nbsp; &nbsp; &nbsp;}<br>
</div>
<div><br>
</div>
<div>scontext is populated with the context length, directly from the conte=
xt structure, and using kstrdup() to copy the string. Much later down the c=
all stack ext4_xattr_set_entry() is called with the SELinux xattr object.<b=
r>
</div>
<div><br>
</div>
<div><br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (i-&gt;value =3D=3D=
 EXT4_ZERO_XATTR_VALUE) {<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memset(v=
al, 0, size);<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Clear=
 the pad bytes first. */<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memset(v=
al &#43; size - EXT4_XATTR_PAD, 0,<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; EXT4_XATTR_PAD);<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memcpy(v=
al, i-&gt;value, i-&gt;value_len);<br>
</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
</div>
<div><br>
</div>
<span>SELinux allows for the creation of contexts that include NULL bytes. =
Unfortunately in this case if a NULL byte occurs not as the string terminat=
or, then kstrdup() will allocate a memory region smaller than what context-=
&gt;len represents. Later in ext4_xattr_set_entry()
 the original context-&gt;len will be used in memcpy() and will exceed the =
heap memory allocated by kstrdup() leading to an OOB issue. There may also =
be the potential for memory corruption depending on the total length of the=
 SELinux context, but this would require
 further analysis.</span><br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span>Can you please let me know if my analysis is correct.</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span>As per me, it looks like there is problem in the code.</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span>Regards,</span></div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<span>Sachin Grover</span></div>
</body>
</html>

--_000_CO1PR14MB10615AE03A49927CC39A041986390CO1PR14MB1061namp_--
