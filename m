Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8BFkHe9023807
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 11:46:17 -0400
Received: by igbkq10 with SMTP id kq10so47875338igb.0
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 08:46:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150911134151.GA6297@x250>
References: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
 <20150911134151.GA6297@x250>
From: Divya Vyas <dvyas@mvista.com>
Date: Fri, 11 Sep 2015 21:15:56 +0530
Message-ID: <CA+=dQ--_H_vrh2sLp4UePBaSBipVba+CX-tbsLR3u9Ft8P-MUg@mail.gmail.com>
Subject: Re: Can I change default policy from targeted to minimum
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=089e011835d0b46470051f7a9d07
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e011835d0b46470051f7a9d07
Content-Type: text/plain; charset=UTF-8

Hi Dominick,

No its not fedora. It is basically yocto based kernel and root filesystem .

Is it possible to have a minimum policy to allow everything and try out
limiting something.



On Fri, Sep 11, 2015 at 7:11 PM, Dominick Grift <dac.override@gmail.com>
wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> On Fri, Sep 11, 2015 at 05:25:39PM +0530, Divya Vyas wrote:
> > Hi,
> >
> > I have mls and targeted policy installed on my system. I want to have a
> > minimum policy with all user unconfined and nothing restricted.
> >
> > I took a minimum policy from selinux-policy-minium noarch rpm and kept in
> > /etc/selinux folder and edit SELINUXTYPE=minimum. Is this enough to load
> a
> > new policy .
> >
> > load_policy
> > SELinux:  Could not open policy file <=
> > /etc/selinux/minimum/policy/policy.28:  No such file or directory
> > load_policy:  Can't load policy:  No such file or directory
> >
> > Getting this error while the policy.28 exists in the path.
> >
> > Please guide me to have a minimum unrestricted policy.
>
> Looks like youre using Fedora. the "minimum" policy model is specific to
> Fedora. You might be able to get support on the Fedora selinux maillist:
> https://admin.fedoraproject.org/mailman/listinfo/selinux
>
> With that said. You could try (if things break then you get to keep the
> pieces): sudo setenforce 0 && sudo semodule -B &&
> sudo load_policy
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
> iQGcBAEBCgAGBQJV8tobAAoJENAR6kfG5xmcZc8L/R22F6gTxgCrQaOa6uZAQ+V3
> G1Wyx8N31NYWJmJ4tpQCdOtKuLeNT3RTybPIGE7+W4tklAZRSob6ljpG4ySpJjO4
> SaI03QDVr1L1Hn5EduZDYsEgWXr4rSbRwRbAfV7EW1G+7cKVQktV8OejLPXFLUhj
> FsemqCJV44dvI8739w9T5KsmRJpVUvTDRwzlWPVWkmRk3Sj6yfPA/N2az3YAVq0B
> FOV26XUqE8EmGJC4N93VqTEo+f9rH52PhTJVArzSElBdYsVsSDRrCJCuKSJd42Cr
> MA1MtDu+DRwuGA0JZtEXekrKOG/6Jx/ZGKlfIwgMAqFjd3FSApWbtEpWDWvXD1Ol
> i9NvOMheLi3PkyM0NUlaE73davDTbyb1hlk0h1WDFvSJCUlNYG5KVkk2metAYk5B
> 3NC7EYvrroqnClXq1DfQfPxFPk2KfnnB0A6I4szUK7pJyh1LXG9+BlcecbtQx8Oy
> m1NC/L+9/+zv7hKl+SUMnkLimC2MrvM2qvYYMnm8aw==
> =znWe
> -----END PGP SIGNATURE-----
>

--089e011835d0b46470051f7a9d07
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Dominick,<br><br></div>No its not fedora. It =
is basically yocto based kernel and root filesystem .<br><br></div>Is it po=
ssible to have a minimum policy to allow everything and try out limiting so=
mething.<br><br><br></div><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Fri, Sep 11, 2015 at 7:11 PM, Dominick Grift <span dir=3D"ltr">=
&lt;<a href=3D"mailto:dac.override@gmail.com" target=3D"_blank">dac.overrid=
e@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">-----BE=
GIN PGP SIGNED MESSAGE-----<br>
Hash: SHA512<br>
<div><div class=3D"h5"><br>
On Fri, Sep 11, 2015 at 05:25:39PM +0530, Divya Vyas wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I have mls and targeted policy installed on my system. I want to have =
a<br>
&gt; minimum policy with all user unconfined and nothing restricted.<br>
&gt;<br>
&gt; I took a minimum policy from selinux-policy-minium noarch rpm and kept=
 in<br>
&gt; /etc/selinux folder and edit SELINUXTYPE=3Dminimum. Is this enough to =
load a<br>
&gt; new policy .<br>
&gt;<br>
&gt; load_policy<br>
&gt; SELinux:=C2=A0 Could not open policy file &lt;=3D<br>
&gt; /etc/selinux/minimum/policy/policy.28:=C2=A0 No such file or directory=
<br>
&gt; load_policy:=C2=A0 Can&#39;t load policy:=C2=A0 No such file or direct=
ory<br>
&gt;<br>
&gt; Getting this error while the policy.28 exists in the path.<br>
&gt;<br>
&gt; Please guide me to have a minimum unrestricted policy.<br>
<br>
</div></div>Looks like youre using Fedora. the &quot;minimum&quot; policy m=
odel is specific to<br>
Fedora. You might be able to get support on the Fedora selinux maillist:<br=
>
<a href=3D"https://admin.fedoraproject.org/mailman/listinfo/selinux" rel=3D=
"noreferrer" target=3D"_blank">https://admin.fedoraproject.org/mailman/list=
info/selinux</a><br>
<br>
With that said. You could try (if things break then you get to keep the pie=
ces): sudo setenforce 0 &amp;&amp; sudo semodule -B &amp;&amp;<br>
sudo load_policy<br>
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
iQGcBAEBCgAGBQJV8tobAAoJENAR6kfG5xmcZc8L/R22F6gTxgCrQaOa6uZAQ+V3<br>
G1Wyx8N31NYWJmJ4tpQCdOtKuLeNT3RTybPIGE7+W4tklAZRSob6ljpG4ySpJjO4<br>
SaI03QDVr1L1Hn5EduZDYsEgWXr4rSbRwRbAfV7EW1G+7cKVQktV8OejLPXFLUhj<br>
FsemqCJV44dvI8739w9T5KsmRJpVUvTDRwzlWPVWkmRk3Sj6yfPA/N2az3YAVq0B<br>
FOV26XUqE8EmGJC4N93VqTEo+f9rH52PhTJVArzSElBdYsVsSDRrCJCuKSJd42Cr<br>
MA1MtDu+DRwuGA0JZtEXekrKOG/6Jx/ZGKlfIwgMAqFjd3FSApWbtEpWDWvXD1Ol<br>
i9NvOMheLi3PkyM0NUlaE73davDTbyb1hlk0h1WDFvSJCUlNYG5KVkk2metAYk5B<br>
3NC7EYvrroqnClXq1DfQfPxFPk2KfnnB0A6I4szUK7pJyh1LXG9+BlcecbtQx8Oy<br>
m1NC/L+9/+zv7hKl+SUMnkLimC2MrvM2qvYYMnm8aw=3D=3D<br>
=3DznWe<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div>

--089e011835d0b46470051f7a9d07--
