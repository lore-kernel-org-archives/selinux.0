Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7UCRjV1018951
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 08:27:48 -0400
Received: by mail-ua0-f178.google.com with SMTP id i32so29264303uai.2
 for <selinux@tycho.nsa.gov>; Tue, 30 Aug 2016 05:27:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFC8oaes9Sfq1KNbNYKJDDOtxEarSFb6Hk+Fs8FzmtzaK7y4Jg@mail.gmail.com>
References: <CAFC8oaeE46DS5MqpbH5NNL7WWorTQZifkfN1QjpdD7Zu_Ken2A@mail.gmail.com>
 <C3AAB836-C2CB-4EA0-8EEF-ACB000B82C24@icloud.com>
 <CAFC8oacf3GMrD=H=157g211h4Z=D6sXOSHiThO8YqXchtYRtAA@mail.gmail.com>
 <6558120.7835182.1472559846164.JavaMail.zimbra@redhat.com>
 <CAFC8oaes9Sfq1KNbNYKJDDOtxEarSFb6Hk+Fs8FzmtzaK7y4Jg@mail.gmail.com>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Tue, 30 Aug 2016 05:27:44 -0700
Message-ID: <CAFC8oac_tJf_VOzVCnWTYU7fB=0r1UWyPyTdHvbkXP+tZpQN0w@mail.gmail.com>
Subject: Re: MLS Enforcing Problem
To: Simon Sekidde <ssekidde@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, ileyd <ileyd@icloud.com>
Content-Type: multipart/alternative; boundary=001a114e286e97341f053b491bc4
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114e286e97341f053b491bc4
Content-Type: text/plain; charset=UTF-8

No i am not login through ssh, i am try to  directly login on machine and
it gives error

On 30 Aug 2016 5:24 pm, "Simon Sekidde" <ssekidde@redhat.com> wrote:



----- Original Message -----
> From: "Kashif ali" <kashif.ali.9498@gmail.com>
> To: "ileyd" <ileyd@icloud.com>
> Cc: "SELinux" <selinux@tycho.nsa.gov>
> Sent: Friday, August 26, 2016 12:55:56 PM
> Subject: Re: MLS Enforcing Problem
>
> i'm using centos 6.5 and there is no error after putting selinux in
enforced
> machine won't allow me to login
>

How are you trying to login? Is this through ssh?
If so please make sure you have the 'ssh_sysadm_login' boolean enabled.

> On Fri, Aug 26, 2016 at 9:48 PM, ileyd < ileyd@icloud.com > wrote:
>
>
> Hi,
>
> Could you give more detail? What operating system are you running, what
error
> message exactly are you getting, etc.
>
> This sounds vaguely like an issue that seems to be present on EL7 and
later,
> and all remotely recent fedora versions.
>
> The issue seems to be caused by /etc being labelled as SystemHigh instead
of
> SystemLow, despite the policy. If you start the system in permissive mode,
> relabel it manually, and then put in in enforcing mode, you're able to
> login, etc. I'm not sure what causes it or how to fix it.
>
> Kind Regards,
> ileyd
>
> > On 26 Aug 2016, at 7:44 PM, Kashif ali < kashif.ali.9498@gmail.com >
wrote:
> >
> > Hi
> > * I'm facing an issue which is as follow
> > When Selinux is in enforcing mode and Policy type is Mls after
relabeling
> > of whole system it doesn't Allow me to login it gives me error login
> > incorrect did i missing something? or it is something else.
> > Thanks
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov .
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov .
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.

--
Simon Sekidde * Red Hat, Inc. * Westford, MA
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E

--001a114e286e97341f053b491bc4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">No i am not login through ssh, i am try to=C2=A0 directly lo=
gin on machine and it gives error </p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 30 Aug 2016 5:=
24 pm, &quot;Simon Sekidde&quot; &lt;<a href=3D"mailto:ssekidde@redhat.com"=
>ssekidde@redhat.com</a>&gt; wrote:<br type=3D"attribution"><blockquote cla=
ss=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div class=3D"quoted-text"><br>
<br>
----- Original Message -----<br>
&gt; From: &quot;Kashif ali&quot; &lt;<a href=3D"mailto:kashif.ali.9498@gma=
il.com">kashif.ali.9498@gmail.com</a>&gt;<br>
&gt; To: &quot;ileyd&quot; &lt;<a href=3D"mailto:ileyd@icloud.com">ileyd@ic=
loud.com</a>&gt;<br>
&gt; Cc: &quot;SELinux&quot; &lt;<a href=3D"mailto:selinux@tycho.nsa.gov">s=
elinux@tycho.nsa.gov</a>&gt;<br>
&gt; Sent: Friday, August 26, 2016 12:55:56 PM<br>
&gt; Subject: Re: MLS Enforcing Problem<br>
&gt;<br>
&gt; i&#39;m using centos 6.5 and there is no error after putting selinux i=
n enforced<br>
&gt; machine won&#39;t allow me to login<br>
&gt;<br>
<br>
</div>How are you trying to login? Is this through ssh?<br>
If so please make sure you have the &#39;ssh_sysadm_login&#39; boolean enab=
led.<br>
<div class=3D"elided-text"><br>
&gt; On Fri, Aug 26, 2016 at 9:48 PM, ileyd &lt; <a href=3D"mailto:ileyd@ic=
loud.com">ileyd@icloud.com</a> &gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Could you give more detail? What operating system are you running, wha=
t error<br>
&gt; message exactly are you getting, etc.<br>
&gt;<br>
&gt; This sounds vaguely like an issue that seems to be present on EL7 and =
later,<br>
&gt; and all remotely recent fedora versions.<br>
&gt;<br>
&gt; The issue seems to be caused by /etc being labelled as SystemHigh inst=
ead of<br>
&gt; SystemLow, despite the policy. If you start the system in permissive m=
ode,<br>
&gt; relabel it manually, and then put in in enforcing mode, you&#39;re abl=
e to<br>
&gt; login, etc. I&#39;m not sure what causes it or how to fix it.<br>
&gt;<br>
&gt; Kind Regards,<br>
&gt; ileyd<br>
&gt;<br>
&gt; &gt; On 26 Aug 2016, at 7:44 PM, Kashif ali &lt; <a href=3D"mailto:kas=
hif.ali.9498@gmail.com">kashif.ali.9498@gmail.com</a> &gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Hi<br>
&gt; &gt; * I&#39;m facing an issue which is as follow<br>
&gt; &gt; When Selinux is in enforcing mode and Policy type is Mls after re=
labeling<br>
&gt; &gt; of whole system it doesn&#39;t Allow me to login it gives me erro=
r login<br>
&gt; &gt; incorrect did i missing something? or it is something else.<br>
&gt; &gt; Thanks<br>
&gt; &gt; ______________________________<wbr>_________________<br>
&gt; &gt; Selinux mailing list<br>
&gt; &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a=
><br>
&gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tyc=
ho.nsa.gov">Selinux-leave@tycho.nsa.gov</a> .<br>
&gt; &gt; To get help, send an email containing &quot;help&quot; to<br>
&gt; &gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@=
tycho.nsa.gov</a> .<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to<br>
&gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho=
.nsa.gov</a>.<br>
<br>
</div><font color=3D"#888888">--<br>
Simon Sekidde * Red Hat, Inc. * Westford, MA<br>
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E<br>
<br>
</font></blockquote></div><br></div>

--001a114e286e97341f053b491bc4--
