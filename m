Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t84CVb98009519
 for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2015 08:31:37 -0400
Received: by vkbf67 with SMTP id f67so10501850vkb.0
 for <selinux@tycho.nsa.gov>; Fri, 04 Sep 2015 05:31:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150904120840.GB3733@x250>
References: <CA+=dQ-93w_WampuSFteVv6OU8RLiGMJ7XFVP-srpm6MwTE0aFw@mail.gmail.com>
 <20150904113418.GA3733@x250>
 <CA+=dQ-_AesBZxnWWu80W0sr0gAQu9G=+NjbHkYF0qoQDnAf7MA@mail.gmail.com>
 <20150904120840.GB3733@x250>
From: Divya Vyas <dvyas@mvista.com>
Date: Fri, 4 Sep 2015 18:01:15 +0530
Message-ID: <CA+=dQ-9wc7MwZqiR1X9aua_9KCnqPnnNfJ0PhBG9fwAso98U0A@mail.gmail.com>
Subject: Re: Enable user_xattr - Selinux failing
To: Divya Vyas <dvyas@mvista.com>, selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=bcaec51d205a9723b7051eeb149a
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--bcaec51d205a9723b7051eeb149a
Content-Type: text/plain; charset=UTF-8

Hi,

I am getting the SELinux attributes error while booting the selinux image
and the system is halting. So I booted the image with selinux=0 in boot
parms

I am getting this output while /etc/selinux/mls/policy/policy.27 is present.

seinfo --fs_use | grep ext
ERROR: Could not determine running system's policy version.
ERROR: Unable to open policy /etc/selinux/mls/policy/policy.27.
ERROR: No such file or directory

I am booting selinux image first time.




On Fri, Sep 4, 2015 at 5:38 PM, Dominick Grift <dac.override@gmail.com>
wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On Fri, Sep 04, 2015 at 05:29:53PM +0530, Divya Vyas wrote:
> <snip>
> >
> > My filesystem is ext3 . I think all configs are enabled.
> >
> > How to check whether policy supports filesystem?
> >
>
> Looks like it
>
> seinfo --fs_use | grep ext
>
> - --
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iQGcBAEBCgAGBQJV6YnEAAoJENAR6kfG5xmcgoUMAJM921GYecpUb3AFKFtLo6bW
> 2r3wckkKcv0S2QDSa1kSfyCmXp2blGFYtI3ywn1U0xo+jCsNirsE+MZrEzJU8HcI
> rXh+SF4BxxwZKBNqH+CqcR4S+XQ3Z2hkUjjLDljpLz3tgsmQVNTCRnjMa+8zqcq/
> uK+fyNeR2aO8GAq1Xmd+MKE0lTmnq7EkU/lcvLOEQzhiBisdrV7DzI0yV3nw7dI0
> 3S/PXga2yAWEurHroPPGlFM0PLmb8B4VQHM3e711r/jRKuxmFe4eAtzPzS71qDxM
> 0FopQYfXRJWu/NqPdkp5xaGEtP865A5wJsOBeAkA3mNiBdhF6gDW5we5/+Vw4DPQ
> A6gUMjprcpNXDRxqeJPxq2Fz5wQYaNsGvGANLydIFzttSYZbAqmfNR5k4UR1iE7a
> 0hMS8LOiqN0jwzGlCacldJbGlO7am5emAJ62EmVeFUAQAkYPJrMJzdMul9KaFjm8
> nTLeOv/1XgxGkCRkLde2R+t6GFLBg6PeVw7d+IAzNw==
> =G1xo
> -----END PGP SIGNATURE-----
>

--bcaec51d205a9723b7051eeb149a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>I am getting the SELinux attributes error =
while booting the selinux image and the system is halting. So I booted the =
image with selinux=3D0 in boot parms<br> <br></div><div>I am getting this o=
utput while /etc/selinux/mls/policy/policy.27 is present.<br><br> </div><di=
v>seinfo --fs_use | grep ext<br>ERROR: Could not determine running system&#=
39;s policy version.<br>ERROR: Unable to open policy /etc/selinux/mls/polic=
y/policy.27.<br>ERROR: No such file or directory<br><br></div><div>I am boo=
ting selinux image first time. <br></div><div><br><br><br></div></div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Sep 4, 2015 at=
 5:38 PM, Dominick Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:dac.overri=
de@gmail.com" target=3D"_blank">dac.override@gmail.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><span class=3D"">-----BEGIN PGP SIGNED =
MESSAGE-----<br>
Hash: SHA512<br>
<br>
</span>On Fri, Sep 04, 2015 at 05:29:53PM +0530, Divya Vyas wrote:<br>
&lt;snip&gt;<br>
<span class=3D"">&gt;<br>
&gt; My filesystem is ext3 . I think all configs are enabled.<br>
&gt;<br>
&gt; How to check whether policy supports filesystem?<br>
&gt;<br>
<br>
</span>Looks like it<br>
<br>
seinfo --fs_use | grep ext<br>
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
</span>iQGcBAEBCgAGBQJV6YnEAAoJENAR6kfG5xmcgoUMAJM921GYecpUb3AFKFtLo6bW<br>
2r3wckkKcv0S2QDSa1kSfyCmXp2blGFYtI3ywn1U0xo+jCsNirsE+MZrEzJU8HcI<br>
rXh+SF4BxxwZKBNqH+CqcR4S+XQ3Z2hkUjjLDljpLz3tgsmQVNTCRnjMa+8zqcq/<br>
uK+fyNeR2aO8GAq1Xmd+MKE0lTmnq7EkU/lcvLOEQzhiBisdrV7DzI0yV3nw7dI0<br>
3S/PXga2yAWEurHroPPGlFM0PLmb8B4VQHM3e711r/jRKuxmFe4eAtzPzS71qDxM<br>
0FopQYfXRJWu/NqPdkp5xaGEtP865A5wJsOBeAkA3mNiBdhF6gDW5we5/+Vw4DPQ<br>
A6gUMjprcpNXDRxqeJPxq2Fz5wQYaNsGvGANLydIFzttSYZbAqmfNR5k4UR1iE7a<br>
0hMS8LOiqN0jwzGlCacldJbGlO7am5emAJ62EmVeFUAQAkYPJrMJzdMul9KaFjm8<br>
nTLeOv/1XgxGkCRkLde2R+t6GFLBg6PeVw7d+IAzNw=3D=3D<br>
=3DG1xo<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div>

--bcaec51d205a9723b7051eeb149a--
