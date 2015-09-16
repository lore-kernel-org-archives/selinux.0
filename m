Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8G5SHm9025031
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 01:28:17 -0400
Received: by wicgb1 with SMTP id gb1so56761566wic.1
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 22:28:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150916033909.GA27516@meriadoc.perfinion.com>
References: <CA+=dQ-8o9gDb9s-Y2m5TzQ-m3yueq=aSOjJPhi2aoRD7r3+o3w@mail.gmail.com>
 <20150916033909.GA27516@meriadoc.perfinion.com>
From: Divya Vyas <dvyas@mvista.com>
Date: Wed, 16 Sep 2015 10:57:55 +0530
Message-ID: <CA+=dQ-_Ga1mWTyp6D9R7mjdbkVjpoVsCm3_aUWCSuNzZBH=CgQ@mail.gmail.com>
Subject: Re: Neverallow in http policy
To: Jason Zaman <jason@perfinion.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c26bc6bafe35051fd690dd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c26bc6bafe35051fd690dd
Content-Type: text/plain; charset=UTF-8

Hi,

I dont want httpd_t to read etc_runtime_t tpe, If I remove read operation
from
below rules,will it work ?

sesearch -ACT -s httpd_t -t etc_runtime_t

allow httpd_t etc_runtime_t : file { ioctl read getattr lock open } ;
allow httpd_t etc_runtime_t : lnk_file { read getattr } ;
allow httpd_t file_type : filesystem getattr ;

On Wed, Sep 16, 2015 at 9:09 AM, Jason Zaman <jason@perfinion.com> wrote:

> On Wed, Sep 16, 2015 at 12:10:42AM +0530, Divya Vyas wrote:
> >    Hi,
> >    How do I write a policy rule to stop http server reading /etc/passwd
> >    file.
> > neverallow ~can_read_shadow_passwords httpd_t:file read;
> >
> >    Will this work?
>
> That is not what neverallow statements do. If you want to remove the
> ability for something to read a file,  you have to remove the allow
> rule. There is no deny rule. Neverallow means there will instead be a
> compile error if you try and add that rule. There should already be a
> neverallow for shadow and you need to grant an exception.
>
> But more importantly, have you checked that your http server is actually
> allowed to read shadow? Almost nothing can.
>
> sesearch -ACT -s httpd_t -t shadow_t
>
> this will tell you all the perms that httpd can do on shadow. If file
> read is not one of them you do not have to do anything.
>
> -- Jason
>

--001a11c26bc6bafe35051fd690dd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I dont want httpd_t to read etc_runtime_t tpe, =
If I remove read operation from <br>below rules,will it work ?<br><br>sesea=
rch -ACT -s httpd_t -t etc_runtime_t<br><br>allow httpd_t etc_runtime_t : f=
ile { ioctl read getattr lock open } ; <br>allow httpd_t etc_runtime_t : ln=
k_file { read getattr } ; <br>allow httpd_t file_type : filesystem getattr =
;<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed=
, Sep 16, 2015 at 9:09 AM, Jason Zaman <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:jason@perfinion.com" target=3D"_blank">jason@perfinion.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div clas=
s=3D"h5">On Wed, Sep 16, 2015 at 12:10:42AM +0530, Divya Vyas wrote:<br>
&gt;=C2=A0 =C2=A0 Hi,<br>
&gt;=C2=A0 =C2=A0 How do I write a policy rule to stop http server reading =
/etc/passwd<br>
&gt;=C2=A0 =C2=A0 file.<br>
&gt; neverallow ~can_read_shadow_passwords httpd_t:file read;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Will this work?<br>
<br>
</div></div>That is not what neverallow statements do. If you want to remov=
e the<br>
ability for something to read a file,=C2=A0 you have to remove the allow<br=
>
rule. There is no deny rule. Neverallow means there will instead be a<br>
compile error if you try and add that rule. There should already be a<br>
neverallow for shadow and you need to grant an exception.<br>
<br>
But more importantly, have you checked that your http server is actually<br=
>
allowed to read shadow? Almost nothing can.<br>
<br>
sesearch -ACT -s httpd_t -t shadow_t<br>
<br>
this will tell you all the perms that httpd can do on shadow. If file<br>
read is not one of them you do not have to do anything.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-- Jason<br>
</font></span></blockquote></div><br></div>

--001a11c26bc6bafe35051fd690dd--
