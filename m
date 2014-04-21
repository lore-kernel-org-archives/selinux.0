Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3LGJeJs007900
 for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2014 12:19:40 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so3923816wes.3
 for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2014 09:19:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <535516B6.4090705@tycho.nsa.gov>
References: <CAOFt0CQHwubzwGSTsw5ig-1tTG9QJe16X5HFoxgjwvV6_StoaA@mail.gmail.com>
 <535516B6.4090705@tycho.nsa.gov>
Date: Mon, 21 Apr 2014 18:19:39 +0200
Message-ID: <CAOFt0CT+i=A+pvAx+Di2rsTfWBY27A3u-9HR-fxY03jWDYzmLA@mail.gmail.com>
Subject: Re: Allowing access other then permissive mode.
From: Kernel freak <kernelfreak@gmail.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7bb03f9abc05f204f78fdd2b
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bb03f9abc05f204f78fdd2b
Content-Type: text/plain; charset=UTF-8

Thank you stephen. But you had also mentioned that security_compute_av()
are void functions from kernel 3.0, then how is it responsible if access is
allowed or not. Kindly clarify. Thank you for your time.


On Mon, Apr 21, 2014 at 3:01 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 04/19/2014 03:53 PM, Kernel freak wrote:
> > Hello friends,
> >                     I am starting a new thread to achieve the objective.
> > I want to attach my own piece of code wherever SELinux takes access
> > decision or Policy decision point. So for example, whenever it queries
> > the database to check the rule, I want to return "allowed" everytime
> > through code and not by using Permissive mode. It is very important I
> > don't use permissive mode.
> >
> > My point of confusion is which part of code I should look to see where
> > there is a policy decision point where database is queried. As far as I
> > understand, a return of '0' means access is allowed. I tried hardcoding
> > rc=0 in many situations, but there are a lot of denials I am getting.
> >
> > Kindly let me know. Thank you for your time.
>
> Permissive mode still logs the denial even though it does not return an
> error to the caller and allows the system call to proceed.  So that is
> why you still see avc denial messages even if you return 0 from
> avc_denied(), just like permissive mode.
>
> If you want to allow everything with no log messages, then just change
> security_compute_av() to just goto allow, where it sets the avd->allowed
> vector to all-bits-set (i.e. all permissions granted) and returns.
>
>

--047d7bb03f9abc05f204f78fdd2b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thank you stephen. But you had also mentioned that se=
curity_compute_av() are void functions from kernel 3.0, then how is it resp=
onsible if access is allowed or not. Kindly clarify. Thank you for your tim=
e. <br>
</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">O=
n Mon, Apr 21, 2014 at 3:01 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 0=
4/19/2014 03:53 PM, Kernel freak wrote:<br>
&gt; Hello friends,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
I am starting a new thread to achieve the objective.<br>
&gt; I want to attach my own piece of code wherever SELinux takes access<br=
>
&gt; decision or Policy decision point. So for example, whenever it queries=
<br>
&gt; the database to check the rule, I want to return &quot;allowed&quot; e=
verytime<br>
&gt; through code and not by using Permissive mode. It is very important I<=
br>
&gt; don&#39;t use permissive mode.<br>
&gt;<br>
&gt; My point of confusion is which part of code I should look to see where=
<br>
&gt; there is a policy decision point where database is queried. As far as =
I<br>
&gt; understand, a return of &#39;0&#39; means access is allowed. I tried h=
ardcoding<br>
&gt; rc=3D0 in many situations, but there are a lot of denials I am getting=
.<br>
&gt;<br>
&gt; Kindly let me know. Thank you for your time.<br>
<br>
</div></div>Permissive mode still logs the denial even though it does not r=
eturn an<br>
error to the caller and allows the system call to proceed. =C2=A0So that is=
<br>
why you still see avc denial messages even if you return 0 from<br>
avc_denied(), just like permissive mode.<br>
<br>
If you want to allow everything with no log messages, then just change<br>
security_compute_av() to just goto allow, where it sets the avd-&gt;allowed=
<br>
vector to all-bits-set (i.e. all permissions granted) and returns.<br>
<br>
</blockquote></div><br></div>

--047d7bb03f9abc05f204f78fdd2b--
