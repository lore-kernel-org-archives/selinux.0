Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7QGu68Y011742
 for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2016 12:56:06 -0400
Received: by mail-ua0-f179.google.com with SMTP id n59so147651288uan.2
 for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2016 09:55:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C3AAB836-C2CB-4EA0-8EEF-ACB000B82C24@icloud.com>
References: <CAFC8oaeE46DS5MqpbH5NNL7WWorTQZifkfN1QjpdD7Zu_Ken2A@mail.gmail.com>
 <C3AAB836-C2CB-4EA0-8EEF-ACB000B82C24@icloud.com>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Fri, 26 Aug 2016 21:55:56 +0500
Message-ID: <CAFC8oacf3GMrD=H=157g211h4Z=D6sXOSHiThO8YqXchtYRtAA@mail.gmail.com>
Subject: Re: MLS Enforcing Problem
To: ileyd <ileyd@icloud.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c18fee86405f9053afc6398
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c18fee86405f9053afc6398
Content-Type: text/plain; charset=UTF-8

i'm using centos 6.5 and there is no error after putting selinux in
enforced machine won't allow me to login

On Fri, Aug 26, 2016 at 9:48 PM, ileyd <ileyd@icloud.com> wrote:

> Hi,
>
> Could you give more detail?  What operating system are you running, what
> error message exactly are you getting, etc.
>
> This sounds vaguely like an issue that seems to be present on EL7 and
> later, and all remotely recent fedora versions.
>
> The issue seems to be caused by /etc being labelled as SystemHigh instead
> of SystemLow, despite the policy.  If you start the system in permissive
> mode, relabel it manually, and then put in in enforcing mode, you're able
> to login, etc.  I'm not sure what causes it or how to fix it.
>
> Kind Regards,
> ileyd
>
> > On 26 Aug 2016, at 7:44 PM, Kashif ali <kashif.ali.9498@gmail.com>
> wrote:
> >
> > Hi
> > * I'm facing an issue which is as follow
> >   When Selinux is in enforcing mode and Policy type is Mls after
> relabeling of whole system it doesn't Allow me to login it gives me error
> login incorrect did i missing something? or it is something else.
> > Thanks
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--94eb2c18fee86405f9053afc6398
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">i&#39;m using centos 6.5 and there is no error after putti=
ng selinux in enforced machine won&#39;t allow me to login=C2=A0</div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Aug 26, 2016 a=
t 9:48 PM, ileyd <span dir=3D"ltr">&lt;<a href=3D"mailto:ileyd@icloud.com" =
target=3D"_blank">ileyd@icloud.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">Hi,<br>
<br>
Could you give more detail?=C2=A0 What operating system are you running, wh=
at error message exactly are you getting, etc.<br>
<br>
This sounds vaguely like an issue that seems to be present on EL7 and later=
, and all remotely recent fedora versions.<br>
<br>
The issue seems to be caused by /etc being labelled as SystemHigh instead o=
f SystemLow, despite the policy.=C2=A0 If you start the system in permissiv=
e mode, relabel it manually, and then put in in enforcing mode, you&#39;re =
able to login, etc.=C2=A0 I&#39;m not sure what causes it or how to fix it.=
<br>
<br>
Kind Regards,<br>
ileyd<br>
<div><div class=3D"h5"><br>
&gt; On 26 Aug 2016, at 7:44 PM, Kashif ali &lt;<a href=3D"mailto:kashif.al=
i.9498@gmail.com">kashif.ali.9498@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi<br>
&gt; * I&#39;m facing an issue which is as follow<br>
&gt;=C2=A0 =C2=A0When Selinux is in enforcing mode and Policy type is Mls a=
fter relabeling of whole system it doesn&#39;t Allow me to login it gives m=
e error login incorrect did i missing something? or it is something else.<b=
r>
&gt; Thanks<br>
</div></div>&gt; ______________________________<wbr>_________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</blockquote></div><br></div>

--94eb2c18fee86405f9053afc6398--
