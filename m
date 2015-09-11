Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8BGhuaf028989
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 12:43:56 -0400
Received: by ioiz6 with SMTP id z6so104103702ioi.2
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 09:43:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150911155344.GA4106@x250>
References: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
 <20150911134151.GA6297@x250>
 <CA+=dQ--_H_vrh2sLp4UePBaSBipVba+CX-tbsLR3u9Ft8P-MUg@mail.gmail.com>
 <20150911155344.GA4106@x250>
From: Divya Vyas <dvyas@mvista.com>
Date: Fri, 11 Sep 2015 22:13:34 +0530
Message-ID: <CA+=dQ-_fxDCjHZmO39O9=S0eQpWN7fhpQQRyqv9d-f82zXahdA@mail.gmail.com>
Subject: Re: Can I change default policy from targeted to minimum
To: Divya Vyas <dvyas@mvista.com>, selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113ff9cecde96e051f7b6b1f
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113ff9cecde96e051f7b6b1f
Content-Type: text/plain; charset=UTF-8

Hi Dominick,

I have a question, What is role of policy.29/28/27 . If I understand
correctly  It is a binary policy called while kernel booting. Is is
symbolic lick with policy.kern.

Thanks,
Divya

On Fri, Sep 11, 2015 at 9:23 PM, Dominick Grift <dac.override@gmail.com>
wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On Fri, Sep 11, 2015 at 09:15:56PM +0530, Divya Vyas wrote:
> > Hi Dominick,
> >
> > No its not fedora. It is basically yocto based kernel and root
> filesystem .
> >
> > Is it possible to have a minimum policy to allow everything and try out
> > limiting something.
>
> Sure, you could write one yourself (configurable policy is what SELinux
> is all about amongst other things). Theres also this:
>
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/security/SELinux.txt?id=e22619a29fcdb513b7bc020e84225bb3b5914259
>
> But it has a bug that only recently got fixed
>
> No matter what you choose, it is going to be a little hard if you arent
> confident with SELinux
>
> For the real adventurous theres my base policy, which needs tweaking to
> get it to work:
>
> https://github.com/doverride/cilpolicy
>
>
> >
> >
> >
> > On Fri, Sep 11, 2015 at 7:11 PM, Dominick Grift <dac.override@gmail.com>
> > wrote:
> >
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA512
> > >
> > > On Fri, Sep 11, 2015 at 05:25:39PM +0530, Divya Vyas wrote:
> > > > Hi,
> > > >
> > > > I have mls and targeted policy installed on my system. I want to
> have a
> > > > minimum policy with all user unconfined and nothing restricted.
> > > >
> > > > I took a minimum policy from selinux-policy-minium noarch rpm and
> kept in
> > > > /etc/selinux folder and edit SELINUXTYPE=minimum. Is this enough to
> load
> > > a
> > > > new policy .
> > > >
> > > > load_policy
> > > > SELinux:  Could not open policy file <=
> > > > /etc/selinux/minimum/policy/policy.28:  No such file or directory
> > > > load_policy:  Can't load policy:  No such file or directory
> > > >
> > > > Getting this error while the policy.28 exists in the path.
> > > >
> > > > Please guide me to have a minimum unrestricted policy.
> > >
> > > Looks like youre using Fedora. the "minimum" policy model is specific
> to
> > > Fedora. You might be able to get support on the Fedora selinux
> maillist:
> > > https://admin.fedoraproject.org/mailman/listinfo/selinux
> > >
> > > With that said. You could try (if things break then you get to keep the
> > > pieces): sudo setenforce 0 && sudo semodule -B &&
> > > sudo load_policy
> > >
> > > > _______________________________________________
> > > > Selinux mailing list
> > > > Selinux@tycho.nsa.gov
> > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > To get help, send an email containing "help" to
> > > Selinux-request@tycho.nsa.gov.
> > >
> > >
> > > - --
> > > 02DFF788
> > > 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> > > https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> > > Dominick Grift
> > > -----BEGIN PGP SIGNATURE-----
> > > Version: GnuPG v2
> > >
> > > iQGcBAEBCgAGBQJV8tobAAoJENAR6kfG5xmcZc8L/R22F6gTxgCrQaOa6uZAQ+V3
> > > G1Wyx8N31NYWJmJ4tpQCdOtKuLeNT3RTybPIGE7+W4tklAZRSob6ljpG4ySpJjO4
> > > SaI03QDVr1L1Hn5EduZDYsEgWXr4rSbRwRbAfV7EW1G+7cKVQktV8OejLPXFLUhj
> > > FsemqCJV44dvI8739w9T5KsmRJpVUvTDRwzlWPVWkmRk3Sj6yfPA/N2az3YAVq0B
> > > FOV26XUqE8EmGJC4N93VqTEo+f9rH52PhTJVArzSElBdYsVsSDRrCJCuKSJd42Cr
> > > MA1MtDu+DRwuGA0JZtEXekrKOG/6Jx/ZGKlfIwgMAqFjd3FSApWbtEpWDWvXD1Ol
> > > i9NvOMheLi3PkyM0NUlaE73davDTbyb1hlk0h1WDFvSJCUlNYG5KVkk2metAYk5B
> > > 3NC7EYvrroqnClXq1DfQfPxFPk2KfnnB0A6I4szUK7pJyh1LXG9+BlcecbtQx8Oy
> > > m1NC/L+9/+zv7hKl+SUMnkLimC2MrvM2qvYYMnm8aw==
> > > =znWe
> > > -----END PGP SIGNATURE-----
> > >
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
> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
>
> iQGcBAEBCgAGBQJV8vkEAAoJENAR6kfG5xmcX90L+wQHC3H8XDMAT9F9ZbWQyz+P
> 4t32n22Q8o92p5vmVQeCUiQU6eBbkFtidW5f6gc8txtiW/+c+nccVjwXYxBh4SLn
> t8P6zL6gknA2vpgSXspZgOhHtAaZY8jnPq2imHZvZIBbNHPna8JggTpDPHe2Ef4G
> 3asKRdwZY2cVDwGLdKph6yfgZq22WnhM3nG0UvE623JVubtUUWZ15sch31kU7bx1
> qAA5jtEch38TOC1VZU+EjsUvGaX/HIrDV2C5v9uC6zUA++10x8mPKMn11/oV+KbW
> 6coANYiPf+Uer63wQLQCpXuzW/8ARhzJCRyxeNHk3pQTr4UDsk9r3dEyjZclG7wT
> ryxNrgrrzBsizlPmuwL06kwi8/Nh+vZpyG6gU39U36/rP6fEyYvfiTL8/Pm1RavF
> N6dOjDgKSMNRWT6qcS9/yCQ4WuNhgRxF9G2PlrZENnY9jYCiP0dPbrQXDJEa9nly
> CK/lSaYqptSJ+zNMRhmZnEsFP/AIFw55guoaSWOZoQ==
> =uFQg
> -----END PGP SIGNATURE-----
>

--001a113ff9cecde96e051f7b6b1f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Dominick,<br><br></div>I have a question=
, What is role of policy.29/28/27 . If I understand correctly=C2=A0 It is a=
 binary policy called while kernel booting. Is is symbolic lick with policy=
.kern. <br><br></div>Thanks,<br></div>Divya<br></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Fri, Sep 11, 2015 at 9:23 PM, Domini=
ck Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:dac.override@gmail.com" ta=
rget=3D"_blank">dac.override@gmail.com</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><span class=3D"">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA512<br>
<br>
</span><span class=3D"">On Fri, Sep 11, 2015 at 09:15:56PM +0530, Divya Vya=
s wrote:<br>
&gt; Hi Dominick,<br>
&gt;<br>
&gt; No its not fedora. It is basically yocto based kernel and root filesys=
tem .<br>
&gt;<br>
&gt; Is it possible to have a minimum policy to allow everything and try ou=
t<br>
&gt; limiting something.<br>
<br>
</span>Sure, you could write one yourself (configurable policy is what SELi=
nux<br>
is all about amongst other things). Theres also this:<br>
<br>
<a href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/security/SELinux.txt?id=3De22619a29fcdb513b7bc020e84225b=
b3b5914259" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/cgi=
t/linux/kernel/git/torvalds/linux.git/tree/Documentation/security/SELinux.t=
xt?id=3De22619a29fcdb513b7bc020e84225bb3b5914259</a><br>
<br>
But it has a bug that only recently got fixed<br>
<br>
No matter what you choose, it is going to be a little hard if you arent<br>
confident with SELinux<br>
<br>
For the real adventurous theres my base policy, which needs tweaking to<br>
get it to work:<br>
<br>
<a href=3D"https://github.com/doverride/cilpolicy" rel=3D"noreferrer" targe=
t=3D"_blank">https://github.com/doverride/cilpolicy</a><br>
<div><div class=3D"h5"><br>
<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Sep 11, 2015 at 7:11 PM, Dominick Grift &lt;<a href=3D"mailto:=
dac.override@gmail.com">dac.override@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt; -----BEGIN PGP SIGNED MESSAGE-----<br>
&gt; &gt; Hash: SHA512<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Sep 11, 2015 at 05:25:39PM +0530, Divya Vyas wrote:<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I have mls and targeted policy installed on my system. I wan=
t to have a<br>
&gt; &gt; &gt; minimum policy with all user unconfined and nothing restrict=
ed.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I took a minimum policy from selinux-policy-minium noarch rp=
m and kept in<br>
&gt; &gt; &gt; /etc/selinux folder and edit SELINUXTYPE=3Dminimum. Is this =
enough to load<br>
&gt; &gt; a<br>
&gt; &gt; &gt; new policy .<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; load_policy<br>
&gt; &gt; &gt; SELinux:=C2=A0 Could not open policy file &lt;=3D<br>
&gt; &gt; &gt; /etc/selinux/minimum/policy/policy.28:=C2=A0 No such file or=
 directory<br>
&gt; &gt; &gt; load_policy:=C2=A0 Can&#39;t load policy:=C2=A0 No such file=
 or directory<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Getting this error while the policy.28 exists in the path.<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please guide me to have a minimum unrestricted policy.<br>
&gt; &gt;<br>
&gt; &gt; Looks like youre using Fedora. the &quot;minimum&quot; policy mod=
el is specific to<br>
&gt; &gt; Fedora. You might be able to get support on the Fedora selinux ma=
illist:<br>
&gt; &gt; <a href=3D"https://admin.fedoraproject.org/mailman/listinfo/selin=
ux" rel=3D"noreferrer" target=3D"_blank">https://admin.fedoraproject.org/ma=
ilman/listinfo/selinux</a><br>
&gt; &gt;<br>
&gt; &gt; With that said. You could try (if things break then you get to ke=
ep the<br>
&gt; &gt; pieces): sudo setenforce 0 &amp;&amp; sudo semodule -B &amp;&amp;=
<br>
&gt; &gt; sudo load_policy<br>
&gt; &gt;<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; Selinux mailing list<br>
&gt; &gt; &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.g=
ov</a><br>
&gt; &gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leav=
e@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; &gt; To get help, send an email containing &quot;help&quot; to<br=
>
&gt; &gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@=
tycho.nsa.gov</a>.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; - --<br>
&gt; &gt; 02DFF788<br>
&gt; &gt; 4D30 903A 1CF3 B756 FB48=C2=A0 1514 3148 83A2 02DF F788<br>
&gt; &gt; <a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;sea=
rch=3D0x314883A202DFF788" rel=3D"noreferrer" target=3D"_blank">https://sks-=
keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x314883A202DFF788</a><br>
&gt; &gt; Dominick Grift<br>
&gt; &gt; -----BEGIN PGP SIGNATURE-----<br>
&gt; &gt; Version: GnuPG v2<br>
&gt; &gt;<br>
&gt; &gt; iQGcBAEBCgAGBQJV8tobAAoJENAR6kfG5xmcZc8L/R22F6gTxgCrQaOa6uZAQ+V3<=
br>
&gt; &gt; G1Wyx8N31NYWJmJ4tpQCdOtKuLeNT3RTybPIGE7+W4tklAZRSob6ljpG4ySpJjO4<=
br>
&gt; &gt; SaI03QDVr1L1Hn5EduZDYsEgWXr4rSbRwRbAfV7EW1G+7cKVQktV8OejLPXFLUhj<=
br>
&gt; &gt; FsemqCJV44dvI8739w9T5KsmRJpVUvTDRwzlWPVWkmRk3Sj6yfPA/N2az3YAVq0B<=
br>
&gt; &gt; FOV26XUqE8EmGJC4N93VqTEo+f9rH52PhTJVArzSElBdYsVsSDRrCJCuKSJd42Cr<=
br>
&gt; &gt; MA1MtDu+DRwuGA0JZtEXekrKOG/6Jx/ZGKlfIwgMAqFjd3FSApWbtEpWDWvXD1Ol<=
br>
&gt; &gt; i9NvOMheLi3PkyM0NUlaE73davDTbyb1hlk0h1WDFvSJCUlNYG5KVkk2metAYk5B<=
br>
&gt; &gt; 3NC7EYvrroqnClXq1DfQfPxFPk2KfnnB0A6I4szUK7pJyh1LXG9+BlcecbtQx8Oy<=
br>
&gt; &gt; m1NC/L+9/+zv7hKl+SUMnkLimC2MrvM2qvYYMnm8aw=3D=3D<br>
&gt; &gt; =3DznWe<br>
&gt; &gt; -----END PGP SIGNATURE-----<br>
&gt; &gt;<br>
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
<a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x31=
4883A202DFF788" rel=3D"noreferrer" target=3D"_blank">https://sks-keyservers=
.net/pks/lookup?op=3Dget&amp;search=3D0x314883A202DFF788</a><br>
Dominick Grift<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v2<br>
<br>
</div></div>iQGcBAEBCgAGBQJV8vkEAAoJENAR6kfG5xmcX90L+wQHC3H8XDMAT9F9ZbWQyz+=
P<br>
4t32n22Q8o92p5vmVQeCUiQU6eBbkFtidW5f6gc8txtiW/+c+nccVjwXYxBh4SLn<br>
t8P6zL6gknA2vpgSXspZgOhHtAaZY8jnPq2imHZvZIBbNHPna8JggTpDPHe2Ef4G<br>
3asKRdwZY2cVDwGLdKph6yfgZq22WnhM3nG0UvE623JVubtUUWZ15sch31kU7bx1<br>
qAA5jtEch38TOC1VZU+EjsUvGaX/HIrDV2C5v9uC6zUA++10x8mPKMn11/oV+KbW<br>
6coANYiPf+Uer63wQLQCpXuzW/8ARhzJCRyxeNHk3pQTr4UDsk9r3dEyjZclG7wT<br>
ryxNrgrrzBsizlPmuwL06kwi8/Nh+vZpyG6gU39U36/rP6fEyYvfiTL8/Pm1RavF<br>
N6dOjDgKSMNRWT6qcS9/yCQ4WuNhgRxF9G2PlrZENnY9jYCiP0dPbrQXDJEa9nly<br>
CK/lSaYqptSJ+zNMRhmZnEsFP/AIFw55guoaSWOZoQ=3D=3D<br>
=3DuFQg<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div>

--001a113ff9cecde96e051f7b6b1f--
