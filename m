MIME-Version: 1.0
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
In-Reply-To: <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
From: Ted Toth <txtoth@gmail.com>
Date: Mon, 10 Sep 2018 13:19:52 -0500
Message-ID: <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="000000000000e87a840575886766"
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000e87a840575886766
Content-Type: text/plain; charset="UTF-8"

Understood, thanks.

On Mon, Sep 10, 2018 at 12:46 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/10/2018 01:13 PM, Ted Toth wrote:
> > We currently have code running on el6 that does a MLS dominance check by
> > calling security_compute_av_raw with the security object class
> > SECCLASS_CONTEXT with permission CONTEXT__CONTAINS as you can see in the
> > python code below. When I run this code on el6 s1 dominates s0 however
> > when I run the same code on el7 s1 does not dominate s0. On both systems
> > the file read dominance check works as expected. Can anyone help me
> > understand why the context contains check does not work the same on both
> > systems?
>
> That would depend entirely on how the constraint is written in the
> policy.  I assume this is with the -mls policy on both?  seinfo
> --constrain | grep -C1 context would show you the constraint in the
> kernel policy.
>
> Looks like refpolicy defines it as:
> mlsconstrain context contains
>          (( h1 dom h2 ) and ( l1 domby l2));
>
> The 2nd part of the constraint was introduced by:
> commit 4c365f4a6a6f933dd13b0127e03f832c6a6cf8fc
> Author: Harry Ciao <qingtao.cao@windriver.com>
> Date:   Tue Feb 15 10:16:32 2011 +0800
>
>      l1 domby l2 for contains MLS constraint
>
>      As identified by Stephan Smalley, the current MLS constraint for the
>      contains permission of the context class should consider the current
>      level of a user along with the clearance level so that mls_systemlow
>      is no longer considered contained in mls_systemhigh.
>
>      Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
>
> This was to prevent a user from logging in at a level below their
> authorized range, in the unusual scenario where the user's low level was
> not s0/systemlow.
>
> >
> > Ted
> >
> >
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> >
> > import selinux
> >
> > SECCLASS_CONTEXT = selinux.string_to_security_class("context")
> > CONTEXT__CONTAINS = selinux.string_to_av_perm(SECCLASS_CONTEXT,
> "contains")
> > SECCLASS_FILE = selinux.string_to_security_class("file")
> > FILE__READ = selinux.string_to_av_perm(SECCLASS_FILE, "read")
> >
> > raw_con1 = "user_u:user_r:user_t:s1"
> > raw_con2 = "user_u:user_r:user_t:s0"
> >
> > avd = selinux.av_decision()
> > selinux.avc_reset()
> > try:
> >      rc = selinux.security_compute_av_raw(raw_con1, raw_con2,
> > SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)
> >      if rc < 0:
> >          print("selinux.security_compute_av_raw failed for %s %s" %
> > (raw_con1, raw_con2))
> >      if (avd.allowed & CONTEXT__CONTAINS) == CONTEXT__CONTAINS:
> >          print("%s dominates %s" % (raw_con1, raw_con2))
> >      else:
> >          print("%s does not dominate %s" % (raw_con1, raw_con2))
> > except OSError, ex:
> >      print "exception calling selinux.security_compute_av_raw", ex
> >
> > avd = selinux.av_decision()
> > selinux.avc_reset()
> > try:
> >      rc = selinux.security_compute_av_raw(raw_con1, raw_con2,
> > SECCLASS_FILE, FILE__READ, avd)
> >      if rc < 0:
> >          print("selinux.security_compute_av_raw failed for %s %s" %
> > (raw_con1, raw_con2))
> >      if (avd.allowed & FILE__READ) == FILE__READ:
> >          print("%s dominates %s" % (raw_con1, raw_con2))
> >      else:
> >          print("%s does not dominate %s" % (raw_con1, raw_con2))
> >
> > except OSError:
> >      print "exception calling selinux.security_compute_av_raw", ex
> >
> >
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
> >
>
>

--000000000000e87a840575886766
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Understood, thanks.</div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr">On Mon, Sep 10, 2018 at 12:46 PM Stephen Smalley &lt;<a href=
=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">On 09/10/2018 01:13 PM, Ted Toth wrote:<br>
&gt; We currently have code running on el6 that does a MLS dominance check =
by <br>
&gt; calling security_compute_av_raw with the security object class <br>
&gt; SECCLASS_CONTEXT with permission CONTEXT__CONTAINS as you can see in t=
he <br>
&gt; python code below. When I run this code on el6 s1 dominates s0 however=
 <br>
&gt; when I run the same code on el7 s1 does not dominate s0. On both syste=
ms <br>
&gt; the file read dominance check works as expected. Can anyone help me <b=
r>
&gt; understand why the context contains check does not work the same on bo=
th <br>
&gt; systems?<br>
<br>
That would depend entirely on how the constraint is written in the <br>
policy.=C2=A0 I assume this is with the -mls policy on both?=C2=A0 seinfo <=
br>
--constrain | grep -C1 context would show you the constraint in the <br>
kernel policy.<br>
<br>
Looks like refpolicy defines it as:<br>
mlsconstrain context contains<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(( h1 dom h2 ) and ( l1 domby l2));<br>
<br>
The 2nd part of the constraint was introduced by:<br>
commit 4c365f4a6a6f933dd13b0127e03f832c6a6cf8fc<br>
Author: Harry Ciao &lt;<a href=3D"mailto:qingtao.cao@windriver.com" target=
=3D"_blank">qingtao.cao@windriver.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Tue Feb 15 10:16:32 2011 +0800<br>
<br>
=C2=A0 =C2=A0 =C2=A0l1 domby l2 for contains MLS constraint<br>
<br>
=C2=A0 =C2=A0 =C2=A0As identified by Stephan Smalley, the current MLS const=
raint for the<br>
=C2=A0 =C2=A0 =C2=A0contains permission of the context class should conside=
r the current<br>
=C2=A0 =C2=A0 =C2=A0level of a user along with the clearance level so that =
mls_systemlow<br>
=C2=A0 =C2=A0 =C2=A0is no longer considered contained in mls_systemhigh.<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Harry Ciao &lt;<a href=3D"mailto:qingtao=
.cao@windriver.com" target=3D"_blank">qingtao.cao@windriver.com</a>&gt;<br>
<br>
This was to prevent a user from logging in at a level below their <br>
authorized range, in the unusual scenario where the user&#39;s low level wa=
s <br>
not s0/systemlow.<br>
<br>
&gt; <br>
&gt; Ted<br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------------------------------<br>
&gt; <br>
&gt; import selinux<br>
&gt; <br>
&gt; SECCLASS_CONTEXT =3D selinux.string_to_security_class(&quot;context&qu=
ot;)<br>
&gt; CONTEXT__CONTAINS =3D selinux.string_to_av_perm(SECCLASS_CONTEXT, &quo=
t;contains&quot;)<br>
&gt; SECCLASS_FILE =3D selinux.string_to_security_class(&quot;file&quot;)<b=
r>
&gt; FILE__READ =3D selinux.string_to_av_perm(SECCLASS_FILE, &quot;read&quo=
t;)<br>
&gt; <br>
&gt; raw_con1 =3D &quot;user_u:user_r:user_t:s1&quot;<br>
&gt; raw_con2 =3D &quot;user_u:user_r:user_t:s0&quot;<br>
&gt; <br>
&gt; avd =3D selinux.av_decision()<br>
&gt; selinux.avc_reset()<br>
&gt; try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 rc =3D selinux.security_compute_av_raw(raw_con1, r=
aw_con2, <br>
&gt; SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if rc &lt; 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;selinux.security_compute=
_av_raw failed for %s %s&quot; % <br>
&gt; (raw_con1, raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (avd.allowed &amp; CONTEXT__CONTAINS) =3D=3D CO=
NTEXT__CONTAINS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s dominates %s&quot; % =
(raw_con1, raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s does not dominate %s&=
quot; % (raw_con1, raw_con2))<br>
&gt; except OSError, ex:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 print &quot;exception calling selinux.security_com=
pute_av_raw&quot;, ex<br>
&gt; <br>
&gt; avd =3D selinux.av_decision()<br>
&gt; selinux.avc_reset()<br>
&gt; try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 rc =3D selinux.security_compute_av_raw(raw_con1, r=
aw_con2, <br>
&gt; SECCLASS_FILE, FILE__READ, avd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if rc &lt; 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;selinux.security_compute=
_av_raw failed for %s %s&quot; % <br>
&gt; (raw_con1, raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (avd.allowed &amp; FILE__READ) =3D=3D FILE__REA=
D:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s dominates %s&quot; % =
(raw_con1, raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s does not dominate %s&=
quot; % (raw_con1, raw_con2))<br>
&gt; <br>
&gt; except OSError:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 print &quot;exception calling selinux.security_com=
pute_av_raw&quot;, ex<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tyc=
ho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tych=
o.nsa.gov</a>.<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000e87a840575886766--
