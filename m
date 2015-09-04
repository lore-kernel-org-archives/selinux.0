Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t84C0Z3j006482
 for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2015 08:00:35 -0400
Received: by vkbf67 with SMTP id f67so10065485vkb.0
 for <selinux@tycho.nsa.gov>; Fri, 04 Sep 2015 05:00:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150904113418.GA3733@x250>
References: <CA+=dQ-93w_WampuSFteVv6OU8RLiGMJ7XFVP-srpm6MwTE0aFw@mail.gmail.com>
 <20150904113418.GA3733@x250>
From: Divya Vyas <dvyas@mvista.com>
Date: Fri, 4 Sep 2015 17:29:53 +0530
Message-ID: <CA+=dQ-_AesBZxnWWu80W0sr0gAQu9G=+NjbHkYF0qoQDnAf7MA@mail.gmail.com>
Subject: Re: Enable user_xattr - Selinux failing
To: Divya Vyas <dvyas@mvista.com>, selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=bcaec51d205a6c9669051eeaa435
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--bcaec51d205a6c9669051eeaa435
Content-Type: text/plain; charset=UTF-8

Hi,

Here is the kernel  configuration :

KERNEL_CONFIG_AUDIT="y"
KERNEL_CONFIG_NETWORK_SECMARK="y"
KERNEL_CONFIG_EXT2_FS_SECURITY="y"
KERNEL_CONFIG_EXT3_FS_SECURITY="y"
KERNEL_CONFIG_EXT4_FS_SECURITY="y"
KERNEL_CONFIG_EXT2_FS_ATTR="y"
KERNEL_CONFIG_EXT3_FS_ATTR="y"
KERNEL_CONFIG_JFS_SECURITY="y"
KERNEL_CONFIG_REISERFS_FS_SECURITY="y"
KERNEL_CONFIG_JFFS2_FS_SECURITY="y"
KERNEL_CONFIG_SECURITY_NETWORK="y"
KERNEL_CONFIG_SECURITY_SELINUX="y"
KERNEL_CONFIG_SECURITY_SELINUX_BOOTPARAM="y"
KERNEL_CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE="1"
KERNEL_CONFIG_SECURITY_SELINUX_DISABLE="y"
KERNEL_CONFIG_SECURITY_SELINUX_DEVELOP="y"
KERNEL_CONFIG_SECURITY_SELINUX_AVC_STATS="y"
KERNEL_CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE="1"
KERNEL_CONFIG_SECURITY="y"
KERNEL_CONFIG_SECURITYFS="y"
KERNEL_CONFIG_AUDIT_GENERIC="y"
KERNEL_CONFIG_DEFAULT_SECURITY_SELINUX="y"
KERNEL_CONFIG_SECURITY_PATH="y"

My filesystem is ext3 . I think all configs are enabled.

How to check whether policy supports filesystem?

Thanks,


On Fri, Sep 4, 2015 at 5:04 PM, Dominick Grift <dac.override@gmail.com>
wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On Fri, Sep 04, 2015 at 04:34:42PM +0530, Divya Vyas wrote:
> > Hi,
> >
> > I am getting this error while building the selinux enabled image.
> >
> >
> > * SELinux requires the root '/' filesystem support extended
> >   filesystem attributes (XATTRs).  It does not appear that this
> >   filesystem has extended attribute support or it is not enabled.
>
> It is refering to "security" extended attributes and not "user" extended
> attributes
>
> >
> >   - To continue using SELinux you will need to enable extended
> >     attribute support on the root device.
> >
> >   - To disable SELinux, please add "selinux=0" in the kernel
> >     command line.
> >
> > * Halting the system now.
> >
> > My fstab is below :
> >
> > rootfs                  /               ext3
> > defaults,acl,user_xattr 0 1
> >
> > Any idea where is the problem?
> >
>
> See whether your file system supports "security extended attributes",
> and whether that support is enabled in your Linux configuration. When
> those requirements are met nd it still does not work, see if your
> selinux policy supports the file system.
>
> > Thanks,
>
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
>
> - --
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iQGcBAEBCgAGBQJV6YG1AAoJENAR6kfG5xmcj94L/iRCtn8pFqDOSqv1mrgmBBim
> sAkAdtRq60w3YfLXblYeYxKwthZYYBamF/wsrMKxQ0X7vcpFO82ymzcOOb/AWGV/
> LoI0I3w3OfdnFZyJrbc+C1KlXpmmVkvzmdWHW00oEMipGI9RBx0Wd2hY5/XVGG4B
> +rAp4Kkvnnf4gGgKmZX3pa7OsS5j8fGvTSELqgg6/4UpO+yrkftTRu8y/E930JAF
> eKbbE97vbZkIz57PjGiqLVTdsD0gCA46V2kVqNecFxxHAbrFJaHbjDxdw/u8uoaN
> 9Nftq7whzeDaWXOO97io6T8uVVmZd37+8ewBFR4Lc2+wXdX1G8dHhi15PIGQMfYw
> nFuc4efQKeNd+mtAeN8gOBQySEkrVtfXBsr7WI4DgZ+Lh9ERmwz9ZuZwiUdegOMk
> WRk/jamPyIska8JJPCvLLCMfkapN1ZNFLGalf7dVGNJjbnyDkIUPfA9GVaa+Z3rN
> EWpOJwC+GC1BY36l6gW2y4WKaZU03XGYtan/ioCG9w==
> =USvg
> -----END PGP SIGNATURE-----
>

--bcaec51d205a6c9669051eeaa435
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>Here is the kernel=C2=A0 config=
uration :<br><br>KERNEL_CONFIG_AUDIT=3D&quot;y&quot;<br>KERNEL_CONFIG_NETWO=
RK_SECMARK=3D&quot;y&quot;<br>KERNEL_CONFIG_EXT2_FS_SECURITY=3D&quot;y&quot=
;<br>KERNEL_CONFIG_EXT3_FS_SECURITY=3D&quot;y&quot;<br>KERNEL_CONFIG_EXT4_F=
S_SECURITY=3D&quot;y&quot;<br>KERNEL_CONFIG_EXT2_FS_ATTR=3D&quot;y&quot;<br=
>KERNEL_CONFIG_EXT3_FS_ATTR=3D&quot;y&quot;<br>KERNEL_CONFIG_JFS_SECURITY=
=3D&quot;y&quot;<br>KERNEL_CONFIG_REISERFS_FS_SECURITY=3D&quot;y&quot;<br>K=
ERNEL_CONFIG_JFFS2_FS_SECURITY=3D&quot;y&quot;<br>KERNEL_CONFIG_SECURITY_NE=
TWORK=3D&quot;y&quot;<br>KERNEL_CONFIG_SECURITY_SELINUX=3D&quot;y&quot;<br>=
KERNEL_CONFIG_SECURITY_SELINUX_BOOTPARAM=3D&quot;y&quot;<br>KERNEL_CONFIG_S=
ECURITY_SELINUX_BOOTPARAM_VALUE=3D&quot;1&quot;<br>KERNEL_CONFIG_SECURITY_S=
ELINUX_DISABLE=3D&quot;y&quot;<br>KERNEL_CONFIG_SECURITY_SELINUX_DEVELOP=3D=
&quot;y&quot;<br>KERNEL_CONFIG_SECURITY_SELINUX_AVC_STATS=3D&quot;y&quot;<b=
r>KERNEL_CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D&quot;1&quot;<br>KERN=
EL_CONFIG_SECURITY=3D&quot;y&quot;<br>KERNEL_CONFIG_SECURITYFS=3D&quot;y&qu=
ot;<br>KERNEL_CONFIG_AUDIT_GENERIC=3D&quot;y&quot;<br>KERNEL_CONFIG_DEFAULT=
_SECURITY_SELINUX=3D&quot;y&quot;<br>KERNEL_CONFIG_SECURITY_PATH=3D&quot;y&=
quot;<br><br></div><div>My filesystem is ext3 . I think all configs are ena=
bled. <br><br></div><div>How to check whether policy supports filesystem?<b=
r><br></div><div>Thanks,<br></div><div><br></div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Fri, Sep 4, 2015 at 5:04 PM, Domin=
ick Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:dac.override@gmail.com" t=
arget=3D"_blank">dac.override@gmail.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA512<br>
<span class=3D""><br>
On Fri, Sep 04, 2015 at 04:34:42PM +0530, Divya Vyas wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am getting this error while building the selinux enabled image.<br>
&gt;<br>
&gt;<br>
&gt; * SELinux requires the root &#39;/&#39; filesystem support extended<br=
>
&gt;=C2=A0 =C2=A0filesystem attributes (XATTRs).=C2=A0 It does not appear t=
hat this<br>
&gt;=C2=A0 =C2=A0filesystem has extended attribute support or it is not ena=
bled.<br>
<br>
</span>It is refering to &quot;security&quot; extended attributes and not &=
quot;user&quot; extended attributes<br>
<span class=3D""><br>
&gt;<br>
&gt;=C2=A0 =C2=A0- To continue using SELinux you will need to enable extend=
ed<br>
&gt;=C2=A0 =C2=A0 =C2=A0attribute support on the root device.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0- To disable SELinux, please add &quot;selinux=3D0&quot; i=
n the kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0command line.<br>
&gt;<br>
&gt; * Halting the system now.<br>
&gt;<br>
&gt; My fstab is below :<br>
&gt;<br>
&gt; rootfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ext3<br>
&gt; defaults,acl,user_xattr 0 1<br>
&gt;<br>
&gt; Any idea where is the problem?<br>
&gt;<br>
<br>
</span>See whether your file system supports &quot;security extended attrib=
utes&quot;,<br>
and whether that support is enabled in your Linux configuration. When<br>
those requirements are met nd it still does not work, see if your<br>
selinux policy supports the file system.<br>
<br>
&gt; Thanks,<br>
<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
<br>
<br>
- --<br>
02DFF788<br>
4D30 903A 1CF3 B756 FB48=C2=A0 1514 3148 83A2 02DF F788<br>
<a href=3D"http://keys.gnupg.net/pks/lookup?op=3Dvindex&amp;search=3D0x3148=
83A202DFF788" rel=3D"noreferrer" target=3D"_blank">http://keys.gnupg.net/pk=
s/lookup?op=3Dvindex&amp;search=3D0x314883A202DFF788</a><br>
Dominick Grift<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v2<br>
<br>
iQGcBAEBCgAGBQJV6YG1AAoJENAR6kfG5xmcj94L/iRCtn8pFqDOSqv1mrgmBBim<br>
sAkAdtRq60w3YfLXblYeYxKwthZYYBamF/wsrMKxQ0X7vcpFO82ymzcOOb/AWGV/<br>
LoI0I3w3OfdnFZyJrbc+C1KlXpmmVkvzmdWHW00oEMipGI9RBx0Wd2hY5/XVGG4B<br>
+rAp4Kkvnnf4gGgKmZX3pa7OsS5j8fGvTSELqgg6/4UpO+yrkftTRu8y/E930JAF<br>
eKbbE97vbZkIz57PjGiqLVTdsD0gCA46V2kVqNecFxxHAbrFJaHbjDxdw/u8uoaN<br>
9Nftq7whzeDaWXOO97io6T8uVVmZd37+8ewBFR4Lc2+wXdX1G8dHhi15PIGQMfYw<br>
nFuc4efQKeNd+mtAeN8gOBQySEkrVtfXBsr7WI4DgZ+Lh9ERmwz9ZuZwiUdegOMk<br>
WRk/jamPyIska8JJPCvLLCMfkapN1ZNFLGalf7dVGNJjbnyDkIUPfA9GVaa+Z3rN<br>
EWpOJwC+GC1BY36l6gW2y4WKaZU03XGYtan/ioCG9w=3D=3D<br>
=3DUSvg<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div>

--bcaec51d205a6c9669051eeaa435--
