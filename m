Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t84Ck9Mw010422
 for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2015 08:46:09 -0400
Received: by vkbc123 with SMTP id c123so10620744vkb.3
 for <selinux@tycho.nsa.gov>; Fri, 04 Sep 2015 05:46:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150904123846.GC3733@x250>
References: <CA+=dQ-93w_WampuSFteVv6OU8RLiGMJ7XFVP-srpm6MwTE0aFw@mail.gmail.com>
 <20150904123846.GC3733@x250>
From: Divya Vyas <dvyas@mvista.com>
Date: Fri, 4 Sep 2015 18:15:48 +0530
Message-ID: <CA+=dQ--MhrCxc_s7HNwLCTvLWxQMpmh+8Vh9ZtxMAiSPDwu7Ng@mail.gmail.com>
Subject: Re: Enable user_xattr - Selinux failing
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=485b397dd5eb949811051eeb48b1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--485b397dd5eb949811051eeb48b1
Content-Type: text/plain; charset=UTF-8

Hi,

I built a yocto x86 image with selinux packages and required kernel config
in root filesystem. As kernel config DEFAULT_SECURITY_SELINUX is enabled so
when I boot the image default selinux will be enforcing mode.

If you see the below link, the error message is below:


https://github.com/flihp/meta-selinux/blob/master/recipes-security/selinux/selinux-config/selinux-init.sh

The script just does the check-rootfs and some check steps.


On Fri, Sep 4, 2015 at 6:08 PM, Dominick Grift <dac.override@gmail.com>
wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On Fri, Sep 04, 2015 at 04:34:42PM +0530, Divya Vyas wrote:
> > Hi,
> >
> > I am getting this error while building the selinux enabled image.
>
> What "selinux enabled image" are you refering to? What is your
> distribution?
>
> >
> >
> > * SELinux requires the root '/' filesystem support extended
> >   filesystem attributes (XATTRs).  It does not appear that this
> >   filesystem has extended attribute support or it is not enabled.
> >
> >   - To continue using SELinux you will need to enable extended
> >     attribute support on the root device.
> >
> >   - To disable SELinux, please add "selinux=0" in the kernel
> >     command line.
> >
> > * Halting the system now.
>
> I do not think that the above is a "selinux message". Could this be some
> third party script/application? Maybe the script/application is flawed.
>
> - --
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iQGcBAEBCgAGBQJV6ZDSAAoJENAR6kfG5xmcMtkMAJtUpqfbHsd8bASrn+hsZxor
> 8SPoWpBR481kV6gv4pcuDRvzeyOqvdSBk5Y2OZATblwAuC7Uh49BeL7DsN8WzU4b
> 144IqZmqjUPhSZqBQBI8v6ZkST8hcxnNKrPIuWNDTPLhJd5VZ/F6XRa9bRUj8s2x
> 7rScvBVqD/w/nIK/6mL//sXwgQc4b90PHFppMwhu7/SJ6tJWtsPz8JdfsDd8Fw+L
> gqdBE3dpMYS7y1o1AZNSnoVN1H+WXU1CRleCJ2h+/xf7fkx3HMpoqtzH50ZN0WBg
> I0ofpTGbcXR1VjZ/DcIBAAmaCI4/UAvkQimC5JjYn2eO3h/p6DBG8lCf+rLntrf0
> AUYQ8To7kcUFQffvSbxhE5Au1LUssCE/d22WBCsE671/6kCdabkLR+Rn+oRlY3Gw
> h7snDftce3C5EMqFjPiRPHZdtXSp+slPVA85h3M8zkRHaIEyyidUu0UZlio4Wn8a
> tXXGAG2+l7VWtSVHyW8IMCpUd42zrYGeVOwI7C7Tqg==
> =xGwb
> -----END PGP SIGNATURE-----
>

--485b397dd5eb949811051eeb48b1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>I built a yocto x86 image =
with selinux packages and required kernel config in root filesystem. As ker=
nel config DEFAULT_SECURITY_SELINUX is enabled so when I boot the image def=
ault selinux will be enforcing mode.<br><br></div>If you see the below link=
, the error message is below:<br><br>=C2=A0<a href=3D"https://github.com/fl=
ihp/meta-selinux/blob/master/recipes-security/selinux/selinux-config/selinu=
x-init.sh">https://github.com/flihp/meta-selinux/blob/master/recipes-securi=
ty/selinux/selinux-config/selinux-init.sh</a><br><br></div>The script just =
does the check-rootfs and some check steps.<br><br></div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Fri, Sep 4, 2015 at 6:08 PM, Dom=
inick Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:dac.override@gmail.com"=
 target=3D"_blank">dac.override@gmail.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><span class=3D"">-----BEGIN PGP SIGNED MESSAGE-----<=
br>
Hash: SHA512<br>
<br>
</span><span class=3D"">On Fri, Sep 04, 2015 at 04:34:42PM +0530, Divya Vya=
s wrote:<br>
</span><span class=3D"">&gt; Hi,<br>
&gt;<br>
&gt; I am getting this error while building the selinux enabled image.<br>
<br>
</span>What &quot;selinux enabled image&quot; are you refering to? What is =
your distribution?<br>
<span class=3D""><br>
&gt;<br>
&gt;<br>
&gt; * SELinux requires the root &#39;/&#39; filesystem support extended<br=
>
&gt;=C2=A0 =C2=A0filesystem attributes (XATTRs).=C2=A0 It does not appear t=
hat this<br>
&gt;=C2=A0 =C2=A0filesystem has extended attribute support or it is not ena=
bled.<br>
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
<br>
</span>I do not think that the above is a &quot;selinux message&quot;. Coul=
d this be some<br>
third party script/application? Maybe the script/application is flawed.<br>
<span class=3D""><br>
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
</span>iQGcBAEBCgAGBQJV6ZDSAAoJENAR6kfG5xmcMtkMAJtUpqfbHsd8bASrn+hsZxor<br>
8SPoWpBR481kV6gv4pcuDRvzeyOqvdSBk5Y2OZATblwAuC7Uh49BeL7DsN8WzU4b<br>
144IqZmqjUPhSZqBQBI8v6ZkST8hcxnNKrPIuWNDTPLhJd5VZ/F6XRa9bRUj8s2x<br>
7rScvBVqD/w/nIK/6mL//sXwgQc4b90PHFppMwhu7/SJ6tJWtsPz8JdfsDd8Fw+L<br>
gqdBE3dpMYS7y1o1AZNSnoVN1H+WXU1CRleCJ2h+/xf7fkx3HMpoqtzH50ZN0WBg<br>
I0ofpTGbcXR1VjZ/DcIBAAmaCI4/UAvkQimC5JjYn2eO3h/p6DBG8lCf+rLntrf0<br>
AUYQ8To7kcUFQffvSbxhE5Au1LUssCE/d22WBCsE671/6kCdabkLR+Rn+oRlY3Gw<br>
h7snDftce3C5EMqFjPiRPHZdtXSp+slPVA85h3M8zkRHaIEyyidUu0UZlio4Wn8a<br>
tXXGAG2+l7VWtSVHyW8IMCpUd42zrYGeVOwI7C7Tqg=3D=3D<br>
=3DxGwb<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div>

--485b397dd5eb949811051eeb48b1--
