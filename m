MIME-Version: 1.0
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
In-Reply-To: <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
From: Ted Toth <txtoth@gmail.com>
Date: Tue, 11 Sep 2018 13:49:00 -0500
Message-ID: <CAFPpqQEw38WqjLCdHba=krGygiUqp8Z8i+UG6d4CTkg0rW9i3Q@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ffefe205759ceddb"
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000ffefe205759ceddb
Content-Type: text/plain; charset="UTF-8"

Yes I too noticed the translate permission but couldn't find any info
related to it intended purpose. Regarding CIL unfortunately I have zero
experience with it but I've installed the compiler and started reading
through https://github.com/SELinuxProject/cil/wiki (any other pointers to
useful info would be appreciated). I have written lots of policy would it
be possible to add a class/permissions/mlsconstraints in an old-fashion
policy module?

On Tue, Sep 11, 2018 at 1:27 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/11/2018 10:41 AM, Stephen Smalley wrote:
> > On 09/10/2018 06:30 PM, Ted Toth wrote:
> >> mcstrans mcscolor.c also uses the same logic I'd been using to check
> >> dominance so this too will no longer function as expected on el7. Do
> >> you any suggestions for doing a 'generic' (one not tied to a specific
> >> resource class) dominance check in lieu of context contains?
> >
> > You should probably define your own permission with its own constraint
> > to avoid depending on the base policy's particular constraint
> > definitions.  Certainly for your own code.  For mcstrans, mcscolor
> > probably ought to be switched to using at least a separate permission in
> > the context class if not its own class to avoid overloading the meaning
> > with pam_selinux's usage (or vice versa, but likely harder to change
> > pam_selinux at this point).
> >
> > It is possible to define an entirely new class, its permissions, and its
> > mls constraints via a CIL module IIUC, without needing to change the
> > base policy.
> >
> > I don't think you can add a permission to an existing class via a CIL
> > module currently, unfortunately, so you can't just extend the context
> > class without modifying the base policy.  So it may be easier to define
> > an entirely new class.
> >
> > The class and permission ought to be specific to the usage.  For
> > example, mcstrans could have its own class (mcstrans) with its own
> > permissions (e.g. color_match or color_use or ...) that abstract away
> > the logical check being performed.  Dominance checks performed for
> > different reasons ought to use different permissions so that one can
> > distinguish what TE pairs are allowed them.
> >
> > Your code could likewise define and use its own class and permission.
> >
> > Does that make sense?
>
> BTW, I noticed there is another permission ("translate") defined in the
> context class and its constraint is ((h1 dom h2) or (t1 ==
> mlstranslate)).  I would have guessed that it was intended as a
> front-end service check over what processes could request context
> translations from mcstrans or what contexts they could translate, but I
> don't see it being used in mcstrans anywhere.  Is this a legacy thing
> from early setransd/mcstransd days?  There is a TODO comment in mcstrans
> process_request() that suggests there was an intent to perform a
> dominance check between the requester context and the specified context,
> but that's not implemented.  Appears to be allowed in current policy for
> all domains to the setrans_t domain itself.
>
> >
> >>
> >> Ted
> >>
> >> On Mon, Sep 10, 2018 at 1:19 PM Ted Toth <txtoth@gmail.com
> >> <mailto:txtoth@gmail.com>> wrote:
> >>
> >>     Understood, thanks.
> >>
> >>     On Mon, Sep 10, 2018 at 12:46 PM Stephen Smalley <sds@tycho.nsa.gov
> >>     <mailto:sds@tycho.nsa.gov>> wrote:
> >>
> >>         On 09/10/2018 01:13 PM, Ted Toth wrote:
> >>          > We currently have code running on el6 that does a MLS
> >>         dominance check by
> >>          > calling security_compute_av_raw with the security object
> class
> >>          > SECCLASS_CONTEXT with permission CONTEXT__CONTAINS as you can
> >>         see in the
> >>          > python code below. When I run this code on el6 s1 dominates
> >>         s0 however
> >>          > when I run the same code on el7 s1 does not dominate s0. On
> >>         both systems
> >>          > the file read dominance check works as expected. Can anyone
> >>         help me
> >>          > understand why the context contains check does not work the
> >>         same on both
> >>          > systems?
> >>
> >>         That would depend entirely on how the constraint is written in
> >> the
> >>         policy.  I assume this is with the -mls policy on both?  seinfo
> >>         --constrain | grep -C1 context would show you the constraint
> >> in the
> >>         kernel policy.
> >>
> >>         Looks like refpolicy defines it as:
> >>         mlsconstrain context contains
> >>                   (( h1 dom h2 ) and ( l1 domby l2));
> >>
> >>         The 2nd part of the constraint was introduced by:
> >>         commit 4c365f4a6a6f933dd13b0127e03f832c6a6cf8fc
> >>         Author: Harry Ciao <qingtao.cao@windriver.com
> >>         <mailto:qingtao.cao@windriver.com>>
> >>         Date:   Tue Feb 15 10:16:32 2011 +0800
> >>
> >>               l1 domby l2 for contains MLS constraint
> >>
> >>               As identified by Stephan Smalley, the current MLS
> >>         constraint for the
> >>               contains permission of the context class should consider
> >>         the current
> >>               level of a user along with the clearance level so that
> >>         mls_systemlow
> >>               is no longer considered contained in mls_systemhigh.
> >>
> >>               Signed-off-by: Harry Ciao <qingtao.cao@windriver.com
> >>         <mailto:qingtao.cao@windriver.com>>
> >>
> >>         This was to prevent a user from logging in at a level below
> their
> >>         authorized range, in the unusual scenario where the user's low
> >>         level was
> >>         not s0/systemlow.
> >>
> >>          >
> >>          > Ted
> >>          >
> >>          >
> >>
> >>
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>
> >>
> >>          >
> >>          > import selinux
> >>          >
> >>          > SECCLASS_CONTEXT =
> selinux.string_to_security_class("context")
> >>          > CONTEXT__CONTAINS =
> >>         selinux.string_to_av_perm(SECCLASS_CONTEXT, "contains")
> >>          > SECCLASS_FILE = selinux.string_to_security_class("file")
> >>          > FILE__READ = selinux.string_to_av_perm(SECCLASS_FILE, "read")
> >>          >
> >>          > raw_con1 = "user_u:user_r:user_t:s1"
> >>          > raw_con2 = "user_u:user_r:user_t:s0"
> >>          >
> >>          > avd = selinux.av_decision()
> >>          > selinux.avc_reset()
> >>          > try:
> >>          >      rc = selinux.security_compute_av_raw(raw_con1, raw_con2,
> >>          > SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)
> >>          >      if rc < 0:
> >>          >          print("selinux.security_compute_av_raw failed for %s
> >>         %s" %
> >>          > (raw_con1, raw_con2))
> >>          >      if (avd.allowed & CONTEXT__CONTAINS) ==
> >> CONTEXT__CONTAINS:
> >>          >          print("%s dominates %s" % (raw_con1, raw_con2))
> >>          >      else:
> >>          >          print("%s does not dominate %s" % (raw_con1,
> >> raw_con2))
> >>          > except OSError, ex:
> >>          >      print "exception calling
> >>         selinux.security_compute_av_raw", ex
> >>          >
> >>          > avd = selinux.av_decision()
> >>          > selinux.avc_reset()
> >>          > try:
> >>          >      rc = selinux.security_compute_av_raw(raw_con1, raw_con2,
> >>          > SECCLASS_FILE, FILE__READ, avd)
> >>          >      if rc < 0:
> >>          >          print("selinux.security_compute_av_raw failed for %s
> >>         %s" %
> >>          > (raw_con1, raw_con2))
> >>          >      if (avd.allowed & FILE__READ) == FILE__READ:
> >>          >          print("%s dominates %s" % (raw_con1, raw_con2))
> >>          >      else:
> >>          >          print("%s does not dominate %s" % (raw_con1,
> >> raw_con2))
> >>          >
> >>          > except OSError:
> >>          >      print "exception calling
> >>         selinux.security_compute_av_raw", ex
> >>          >
> >>          >
> >>          >
> >>          > _______________________________________________
> >>          > Selinux mailing list
> >>          > Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
> >>          > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov
> >>         <mailto:Selinux-leave@tycho.nsa.gov>.
> >>          > To get help, send an email containing "help" to
> >>         Selinux-request@tycho.nsa.gov
> >>         <mailto:Selinux-request@tycho.nsa.gov>.
> >>          >
> >>
> >
>
>

--000000000000ffefe205759ceddb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Yes I too noticed the translate permissio=
n but couldn&#39;t find any info related to it intended purpose. Regarding =
CIL unfortunately I have zero experience with it but I&#39;ve installed the=
 compiler and started reading through <a href=3D"https://github.com/SELinux=
Project/cil/wiki">https://github.com/SELinuxProject/cil/wiki</a> (any other=
 pointers to useful info would be appreciated). I have written lots of poli=
cy would it be possible to add a class/permissions/mlsconstraints in an old=
-fashion policy module?</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Tue, Sep 11, 2018 at 1:27 PM Stephen Smalley &lt;<a href=3D"mai=
lto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">On 09/11/2018 10:41 AM, Stephen Smalley wrote:<br>
&gt; On 09/10/2018 06:30 PM, Ted Toth wrote:<br>
&gt;&gt; mcstrans mcscolor.c also uses the same logic I&#39;d been using to=
 check <br>
&gt;&gt; dominance so this too will no longer function as expected on el7. =
Do <br>
&gt;&gt; you any suggestions for doing a &#39;generic&#39; (one not tied to=
 a specific <br>
&gt;&gt; resource class) dominance check in lieu of context contains?<br>
&gt; <br>
&gt; You should probably define your own permission with its own constraint=
 <br>
&gt; to avoid depending on the base policy&#39;s particular constraint <br>
&gt; definitions.=C2=A0 Certainly for your own code.=C2=A0 For mcstrans, mc=
scolor <br>
&gt; probably ought to be switched to using at least a separate permission =
in <br>
&gt; the context class if not its own class to avoid overloading the meanin=
g <br>
&gt; with pam_selinux&#39;s usage (or vice versa, but likely harder to chan=
ge <br>
&gt; pam_selinux at this point).<br>
&gt; <br>
&gt; It is possible to define an entirely new class, its permissions, and i=
ts <br>
&gt; mls constraints via a CIL module IIUC, without needing to change the <=
br>
&gt; base policy.<br>
&gt; <br>
&gt; I don&#39;t think you can add a permission to an existing class via a =
CIL <br>
&gt; module currently, unfortunately, so you can&#39;t just extend the cont=
ext <br>
&gt; class without modifying the base policy.=C2=A0 So it may be easier to =
define <br>
&gt; an entirely new class.<br>
&gt; <br>
&gt; The class and permission ought to be specific to the usage.=C2=A0 For =
<br>
&gt; example, mcstrans could have its own class (mcstrans) with its own <br=
>
&gt; permissions (e.g. color_match or color_use or ...) that abstract away =
<br>
&gt; the logical check being performed.=C2=A0 Dominance checks performed fo=
r <br>
&gt; different reasons ought to use different permissions so that one can <=
br>
&gt; distinguish what TE pairs are allowed them.<br>
&gt; <br>
&gt; Your code could likewise define and use its own class and permission.<=
br>
&gt; <br>
&gt; Does that make sense?<br>
<br>
BTW, I noticed there is another permission (&quot;translate&quot;) defined =
in the <br>
context class and its constraint is ((h1 dom h2) or (t1 =3D=3D <br>
mlstranslate)).=C2=A0 I would have guessed that it was intended as a <br>
front-end service check over what processes could request context <br>
translations from mcstrans or what contexts they could translate, but I <br=
>
don&#39;t see it being used in mcstrans anywhere.=C2=A0 Is this a legacy th=
ing <br>
from early setransd/mcstransd days?=C2=A0 There is a TODO comment in mcstra=
ns <br>
process_request() that suggests there was an intent to perform a <br>
dominance check between the requester context and the specified context, <b=
r>
but that&#39;s not implemented.=C2=A0 Appears to be allowed in current poli=
cy for <br>
all domains to the setrans_t domain itself.<br>
<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; Ted<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Sep 10, 2018 at 1:19 PM Ted Toth &lt;<a href=3D"mailto:txt=
oth@gmail.com" target=3D"_blank">txtoth@gmail.com</a> <br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:txtoth@gmail.com" target=3D"_blank">t=
xtoth@gmail.com</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Understood, thanks.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 On Mon, Sep 10, 2018 at 12:46 PM Stephen Smalle=
y &lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.=
gov</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov"=
 target=3D"_blank">sds@tycho.nsa.gov</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On 09/10/2018 01:13 PM,=
 Ted Toth wrote:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; We currently=
 have code running on el6 that does a MLS<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dominance check by<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; calling secu=
rity_compute_av_raw with the security object class<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; SECCLASS_CON=
TEXT with permission CONTEXT__CONTAINS as you can<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 see in the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; python code =
below. When I run this code on el6 s1 dominates<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s0 however<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; when I run t=
he same code on el7 s1 does not dominate s0. On<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 both systems<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; the file rea=
d dominance check works as expected. Can anyone<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help me<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; understand w=
hy the context contains check does not work the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 same on both<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; systems?<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 That would depend entir=
ely on how the constraint is written in <br>
&gt;&gt; the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 policy.=C2=A0 I assume =
this is with the -mls policy on both?=C2=A0 seinfo<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --constrain | grep -C1 =
context would show you the constraint <br>
&gt;&gt; in the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel policy.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Looks like refpolicy de=
fines it as:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mlsconstrain context co=
ntains<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(( h1 dom h2 ) and ( l1 domby l2));<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The 2nd part of the con=
straint was introduced by:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit 4c365f4a6a6f933d=
d13b0127e03f832c6a6cf8fc<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Author: Harry Ciao &lt;=
<a href=3D"mailto:qingtao.cao@windriver.com" target=3D"_blank">qingtao.cao@=
windriver.com</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"m=
ailto:qingtao.cao@windriver.com" target=3D"_blank">qingtao.cao@windriver.co=
m</a>&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Date:=C2=A0 =C2=A0Tue F=
eb 15 10:16:32 2011 +0800<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0l1 domby l2 for contains MLS constraint<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0As identified by Stephan Smalley, the current MLS<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 constraint for the<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0contains permission of the context class should consider<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the current<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0level of a user along with the clearance level so that<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mls_systemlow<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0is no longer considered contained in mls_systemhigh.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0Signed-off-by: Harry Ciao &lt;<a href=3D"mailto:qingtao.cao@windriver.co=
m" target=3D"_blank">qingtao.cao@windriver.com</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"m=
ailto:qingtao.cao@windriver.com" target=3D"_blank">qingtao.cao@windriver.co=
m</a>&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This was to prevent a u=
ser from logging in at a level below their<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 authorized range, in th=
e unusual scenario where the user&#39;s low<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 level was<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not s0/systemlow.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Ted<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;&gt; ------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------------------------------------ <br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; import selin=
ux<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; SECCLASS_CON=
TEXT =3D selinux.string_to_security_class(&quot;context&quot;)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; CONTEXT__CON=
TAINS =3D<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selinux.string_to_av_pe=
rm(SECCLASS_CONTEXT, &quot;contains&quot;)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; SECCLASS_FIL=
E =3D selinux.string_to_security_class(&quot;file&quot;)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; FILE__READ =
=3D selinux.string_to_av_perm(SECCLASS_FILE, &quot;read&quot;)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; raw_con1 =3D=
 &quot;user_u:user_r:user_t:s1&quot;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; raw_con2 =3D=
 &quot;user_u:user_r:user_t:s0&quot;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; avd =3D seli=
nux.av_decision()<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; selinux.avc_=
reset()<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; try:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 rc =3D selinux.security_compute_av_raw(raw_con1, raw_con2,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; SECCLASS_CON=
TEXT, CONTEXT__CONTAINS, avd)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 if rc &lt; 0:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 print(&quot;selinux.security_compute_av_raw failed fo=
r %s<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %s&quot; %<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; (raw_con1, r=
aw_con2))<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 if (avd.allowed &amp; CONTEXT__CONTAINS) =3D=3D <br>
&gt;&gt; CONTEXT__CONTAINS:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s dominates %s&quot; % (raw_con1, raw_co=
n2))<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 else:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s does not dominate %s&quot; % (raw_con1=
, <br>
&gt;&gt; raw_con2))<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; except OSErr=
or, ex:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 print &quot;exception calling<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selinux.security_comput=
e_av_raw&quot;, ex<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; avd =3D seli=
nux.av_decision()<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; selinux.avc_=
reset()<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; try:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 rc =3D selinux.security_compute_av_raw(raw_con1, raw_con2,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; SECCLASS_FIL=
E, FILE__READ, avd)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 if rc &lt; 0:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 print(&quot;selinux.security_compute_av_raw failed fo=
r %s<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %s&quot; %<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; (raw_con1, r=
aw_con2))<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 if (avd.allowed &amp; FILE__READ) =3D=3D FILE__READ:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s dominates %s&quot; % (raw_con1, raw_co=
n2))<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 else:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s does not dominate %s&quot; % (raw_con1=
, <br>
&gt;&gt; raw_con2))<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; except OSErr=
or:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0=
 =C2=A0 print &quot;exception calling<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 selinux.security_comput=
e_av_raw&quot;, ex<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; ____________=
___________________________________<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Selinux mail=
ing list<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; <a href=3D"m=
ailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.nsa.gov</a> &l=
t;mailto:<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux=
@tycho.nsa.gov</a>&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; To unsubscri=
be, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov" target=3D"=
_blank">Selinux-leave@tycho.nsa.gov</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"m=
ailto:Selinux-leave@tycho.nsa.gov" target=3D"_blank">Selinux-leave@tycho.ns=
a.gov</a>&gt;.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; To get help,=
 send an email containing &quot;help&quot; to<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <a href=3D"mailto:Selin=
ux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa.gov</=
a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tych=
o.nsa.gov</a>&gt;.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt;<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000ffefe205759ceddb--
