MIME-Version: 1.0
References: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
 <41fbbd99-00ef-3953-1049-acf975ae6ffa@tycho.nsa.gov>
 <CAFPpqQHXmvCNLwkW3xmYX9PWFwwmfc7wD2kOz-KKEVip-BFLyA@mail.gmail.com>
 <CAFPpqQGyUWsXwmfAybHKWhuQ6jytaNn_ZO-BfeqxNTQZDb+uvg@mail.gmail.com>
 <4e7d4090-e271-b904-c5bb-24f69304625d@tycho.nsa.gov>
 <85bb9bec-2bda-34fa-1f7d-256470c4f38c@tycho.nsa.gov>
 <CAFPpqQEw38WqjLCdHba=krGygiUqp8Z8i+UG6d4CTkg0rW9i3Q@mail.gmail.com>
 <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
In-Reply-To: <d4404bc7-9f23-7ed6-fb2f-24c31d7e4704@tycho.nsa.gov>
From: Ted Toth <txtoth@gmail.com>
Date: Tue, 11 Sep 2018 15:59:44 -0500
Message-ID: <CAFPpqQF9=aGg_s8jYzCUycpT6qf6GQv6vkKSAXejZcPPEHpxOw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008e451105759ec169"
Subject: Re: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000008e451105759ec169
Content-Type: text/plain; charset="UTF-8"

That's awesome and now it's got me thinking about other classes/permissions
that we could implement. Can cil macros can be referenced in .te/.if files?


On Tue, Sep 11, 2018 at 2:27 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/11/2018 02:49 PM, Ted Toth wrote:
> > Yes I too noticed the translate permission but couldn't find any info
> > related to it intended purpose. Regarding CIL unfortunately I have zero
> > experience with it but I've installed the compiler and started reading
> > through https://github.com/SELinuxProject/cil/wiki (any other pointers
> > to useful info would be appreciated). I have written lots of policy
> > would it be possible to add a class/permissions/mlsconstraints in an
> > old-fashion policy module?
>
> The older binary modules didn't support those kinds of statements
> outside of the base module.  Try this:
> $ cat > mcstrans.cil <<EOF
> ; define a mcstrans class with one permission color_use
> (class mcstrans (color_use))
> ; allow all domains mcstrans color_use permission to themselves
> (allow domain self (mcstrans (color_use)))
> ; only allow mcstrans color_use permission when h1 dominates h2
> (mlsconstrain (mcstrans (color_use)) (dom h1 h2))
> ; append the new mcstrans class to the end after all others
> (classorder (unordered mcstrans))
> EOF
>
> $ sudo semodule -i mcstrans.cil
>
> Then try performing permission checks with "mcstrans" as your class and
> "color_use" as your permission, between a domain and itself, with
> different levels.
>
> >
> > On Tue, Sep 11, 2018 at 1:27 PM Stephen Smalley <sds@tycho.nsa.gov
> > <mailto:sds@tycho.nsa.gov>> wrote:
> >
> >     On 09/11/2018 10:41 AM, Stephen Smalley wrote:
> >      > On 09/10/2018 06:30 PM, Ted Toth wrote:
> >      >> mcstrans mcscolor.c also uses the same logic I'd been using to
> >     check
> >      >> dominance so this too will no longer function as expected on
> >     el7. Do
> >      >> you any suggestions for doing a 'generic' (one not tied to a
> >     specific
> >      >> resource class) dominance check in lieu of context contains?
> >      >
> >      > You should probably define your own permission with its own
> >     constraint
> >      > to avoid depending on the base policy's particular constraint
> >      > definitions.  Certainly for your own code.  For mcstrans, mcscolor
> >      > probably ought to be switched to using at least a separate
> >     permission in
> >      > the context class if not its own class to avoid overloading the
> >     meaning
> >      > with pam_selinux's usage (or vice versa, but likely harder to
> change
> >      > pam_selinux at this point).
> >      >
> >      > It is possible to define an entirely new class, its permissions,
> >     and its
> >      > mls constraints via a CIL module IIUC, without needing to change
> the
> >      > base policy.
> >      >
> >      > I don't think you can add a permission to an existing class via a
> >     CIL
> >      > module currently, unfortunately, so you can't just extend the
> >     context
> >      > class without modifying the base policy.  So it may be easier to
> >     define
> >      > an entirely new class.
> >      >
> >      > The class and permission ought to be specific to the usage.  For
> >      > example, mcstrans could have its own class (mcstrans) with its own
> >      > permissions (e.g. color_match or color_use or ...) that abstract
> >     away
> >      > the logical check being performed.  Dominance checks performed for
> >      > different reasons ought to use different permissions so that one
> can
> >      > distinguish what TE pairs are allowed them.
> >      >
> >      > Your code could likewise define and use its own class and
> permission.
> >      >
> >      > Does that make sense?
> >
> >     BTW, I noticed there is another permission ("translate") defined in
> the
> >     context class and its constraint is ((h1 dom h2) or (t1 ==
> >     mlstranslate)).  I would have guessed that it was intended as a
> >     front-end service check over what processes could request context
> >     translations from mcstrans or what contexts they could translate,
> but I
> >     don't see it being used in mcstrans anywhere.  Is this a legacy thing
> >     from early setransd/mcstransd days?  There is a TODO comment in
> >     mcstrans
> >     process_request() that suggests there was an intent to perform a
> >     dominance check between the requester context and the specified
> >     context,
> >     but that's not implemented.  Appears to be allowed in current policy
> >     for
> >     all domains to the setrans_t domain itself.
> >
> >      >
> >      >>
> >      >> Ted
> >      >>
> >      >> On Mon, Sep 10, 2018 at 1:19 PM Ted Toth <txtoth@gmail.com
> >     <mailto:txtoth@gmail.com>
> >      >> <mailto:txtoth@gmail.com <mailto:txtoth@gmail.com>>> wrote:
> >      >>
> >      >>     Understood, thanks.
> >      >>
> >      >>     On Mon, Sep 10, 2018 at 12:46 PM Stephen Smalley
> >     <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
> >      >>     <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>>
> wrote:
> >      >>
> >      >>         On 09/10/2018 01:13 PM, Ted Toth wrote:
> >      >>          > We currently have code running on el6 that does a MLS
> >      >>         dominance check by
> >      >>          > calling security_compute_av_raw with the security
> >     object class
> >      >>          > SECCLASS_CONTEXT with permission CONTEXT__CONTAINS as
> >     you can
> >      >>         see in the
> >      >>          > python code below. When I run this code on el6 s1
> >     dominates
> >      >>         s0 however
> >      >>          > when I run the same code on el7 s1 does not dominate
> >     s0. On
> >      >>         both systems
> >      >>          > the file read dominance check works as expected. Can
> >     anyone
> >      >>         help me
> >      >>          > understand why the context contains check does not
> >     work the
> >      >>         same on both
> >      >>          > systems?
> >      >>
> >      >>         That would depend entirely on how the constraint is
> >     written in
> >      >> the
> >      >>         policy.  I assume this is with the -mls policy on both?
> >     seinfo
> >      >>         --constrain | grep -C1 context would show you the
> >     constraint
> >      >> in the
> >      >>         kernel policy.
> >      >>
> >      >>         Looks like refpolicy defines it as:
> >      >>         mlsconstrain context contains
> >      >>                   (( h1 dom h2 ) and ( l1 domby l2));
> >      >>
> >      >>         The 2nd part of the constraint was introduced by:
> >      >>         commit 4c365f4a6a6f933dd13b0127e03f832c6a6cf8fc
> >      >>         Author: Harry Ciao <qingtao.cao@windriver.com
> >     <mailto:qingtao.cao@windriver.com>
> >      >>         <mailto:qingtao.cao@windriver.com
> >     <mailto:qingtao.cao@windriver.com>>>
> >      >>         Date:   Tue Feb 15 10:16:32 2011 +0800
> >      >>
> >      >>               l1 domby l2 for contains MLS constraint
> >      >>
> >      >>               As identified by Stephan Smalley, the current MLS
> >      >>         constraint for the
> >      >>               contains permission of the context class should
> >     consider
> >      >>         the current
> >      >>               level of a user along with the clearance level so
> that
> >      >>         mls_systemlow
> >      >>               is no longer considered contained in
> mls_systemhigh.
> >      >>
> >      >>               Signed-off-by: Harry Ciao
> >     <qingtao.cao@windriver.com <mailto:qingtao.cao@windriver.com>
> >      >>         <mailto:qingtao.cao@windriver.com
> >     <mailto:qingtao.cao@windriver.com>>>
> >      >>
> >      >>         This was to prevent a user from logging in at a level
> >     below their
> >      >>         authorized range, in the unusual scenario where the
> >     user's low
> >      >>         level was
> >      >>         not s0/systemlow.
> >      >>
> >      >>          >
> >      >>          > Ted
> >      >>          >
> >      >>          >
> >      >>
> >      >>
> >
>  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> >
> >      >>
> >      >>          >
> >      >>          > import selinux
> >      >>          >
> >      >>          > SECCLASS_CONTEXT =
> >     selinux.string_to_security_class("context")
> >      >>          > CONTEXT__CONTAINS =
> >      >>         selinux.string_to_av_perm(SECCLASS_CONTEXT, "contains")
> >      >>          > SECCLASS_FILE =
> selinux.string_to_security_class("file")
> >      >>          > FILE__READ = selinux.string_to_av_perm(SECCLASS_FILE,
> >     "read")
> >      >>          >
> >      >>          > raw_con1 = "user_u:user_r:user_t:s1"
> >      >>          > raw_con2 = "user_u:user_r:user_t:s0"
> >      >>          >
> >      >>          > avd = selinux.av_decision()
> >      >>          > selinux.avc_reset()
> >      >>          > try:
> >      >>          >      rc = selinux.security_compute_av_raw(raw_con1,
> >     raw_con2,
> >      >>          > SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)
> >      >>          >      if rc < 0:
> >      >>          >          print("selinux.security_compute_av_raw
> >     failed for %s
> >      >>         %s" %
> >      >>          > (raw_con1, raw_con2))
> >      >>          >      if (avd.allowed & CONTEXT__CONTAINS) ==
> >      >> CONTEXT__CONTAINS:
> >      >>          >          print("%s dominates %s" % (raw_con1,
> raw_con2))
> >      >>          >      else:
> >      >>          >          print("%s does not dominate %s" % (raw_con1,
> >      >> raw_con2))
> >      >>          > except OSError, ex:
> >      >>          >      print "exception calling
> >      >>         selinux.security_compute_av_raw", ex
> >      >>          >
> >      >>          > avd = selinux.av_decision()
> >      >>          > selinux.avc_reset()
> >      >>          > try:
> >      >>          >      rc = selinux.security_compute_av_raw(raw_con1,
> >     raw_con2,
> >      >>          > SECCLASS_FILE, FILE__READ, avd)
> >      >>          >      if rc < 0:
> >      >>          >          print("selinux.security_compute_av_raw
> >     failed for %s
> >      >>         %s" %
> >      >>          > (raw_con1, raw_con2))
> >      >>          >      if (avd.allowed & FILE__READ) == FILE__READ:
> >      >>          >          print("%s dominates %s" % (raw_con1,
> raw_con2))
> >      >>          >      else:
> >      >>          >          print("%s does not dominate %s" % (raw_con1,
> >      >> raw_con2))
> >      >>          >
> >      >>          > except OSError:
> >      >>          >      print "exception calling
> >      >>         selinux.security_compute_av_raw", ex
> >      >>          >
> >      >>          >
> >      >>          >
> >      >>          > _______________________________________________
> >      >>          > Selinux mailing list
> >      >>          > Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>
> >     <mailto:Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov>>
> >      >>          > To unsubscribe, send email to
> >     Selinux-leave@tycho.nsa.gov <mailto:Selinux-leave@tycho.nsa.gov>
> >      >>         <mailto:Selinux-leave@tycho.nsa.gov
> >     <mailto:Selinux-leave@tycho.nsa.gov>>.
> >      >>          > To get help, send an email containing "help" to
> >      >> Selinux-request@tycho.nsa.gov <mailto:
> Selinux-request@tycho.nsa.gov>
> >      >>         <mailto:Selinux-request@tycho.nsa.gov
> >     <mailto:Selinux-request@tycho.nsa.gov>>.
> >      >>          >
> >      >>
> >      >
> >
>
>

--0000000000008e451105759ec169
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That&#39;s awesome and now it&#39;s got me thinking about =
other classes/permissions that we could implement. Can cil macros can be re=
ferenced in .te/.if files?=C2=A0<div><br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr">On Tue, Sep 11, 2018 at 2:27 PM Stephen Smalley &=
lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">On 09/11/2018 02:49 PM, Ted Toth wrot=
e:<br>
&gt; Yes I too noticed the translate permission but couldn&#39;t find any i=
nfo <br>
&gt; related to it intended purpose. Regarding CIL unfortunately I have zer=
o <br>
&gt; experience with it but I&#39;ve installed the compiler and started rea=
ding <br>
&gt; through <a href=3D"https://github.com/SELinuxProject/cil/wiki" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/SELinuxProject/cil/wiki</a=
> (any other pointers <br>
&gt; to useful info would be appreciated). I have written lots of policy <b=
r>
&gt; would it be possible to add a class/permissions/mlsconstraints in an <=
br>
&gt; old-fashion policy module?<br>
<br>
The older binary modules didn&#39;t support those kinds of statements <br>
outside of the base module.=C2=A0 Try this:<br>
$ cat &gt; mcstrans.cil &lt;&lt;EOF<br>
; define a mcstrans class with one permission color_use<br>
(class mcstrans (color_use))<br>
; allow all domains mcstrans color_use permission to themselves<br>
(allow domain self (mcstrans (color_use)))<br>
; only allow mcstrans color_use permission when h1 dominates h2<br>
(mlsconstrain (mcstrans (color_use)) (dom h1 h2))<br>
; append the new mcstrans class to the end after all others<br>
(classorder (unordered mcstrans))<br>
EOF<br>
<br>
$ sudo semodule -i mcstrans.cil<br>
<br>
Then try performing permission checks with &quot;mcstrans&quot; as your cla=
ss and <br>
&quot;color_use&quot; as your permission, between a domain and itself, with=
 <br>
different levels.<br>
<br>
&gt; <br>
&gt; On Tue, Sep 11, 2018 at 1:27 PM Stephen Smalley &lt;<a href=3D"mailto:=
sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@=
tycho.nsa.gov</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 09/11/2018 10:41 AM, Stephen Smalley wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On 09/10/2018 06:30 PM, Ted Toth wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; mcstrans mcscolor.c also uses the same lo=
gic I&#39;d been using to<br>
&gt;=C2=A0 =C2=A0 =C2=A0check<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; dominance so this too will no longer func=
tion as expected on<br>
&gt;=C2=A0 =C2=A0 =C2=A0el7. Do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; you any suggestions for doing a &#39;gene=
ric&#39; (one not tied to a<br>
&gt;=C2=A0 =C2=A0 =C2=A0specific<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; resource class) dominance check in lieu o=
f context contains?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; You should probably define your own permissio=
n with its own<br>
&gt;=C2=A0 =C2=A0 =C2=A0constraint<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; to avoid depending on the base policy&#39;s p=
articular constraint<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; definitions.=C2=A0 Certainly for your own cod=
e.=C2=A0 For mcstrans, mcscolor<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; probably ought to be switched to using at lea=
st a separate<br>
&gt;=C2=A0 =C2=A0 =C2=A0permission in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the context class if not its own class to avo=
id overloading the<br>
&gt;=C2=A0 =C2=A0 =C2=A0meaning<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; with pam_selinux&#39;s usage (or vice versa, =
but likely harder to change<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; pam_selinux at this point).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; It is possible to define an entirely new clas=
s, its permissions,<br>
&gt;=C2=A0 =C2=A0 =C2=A0and its<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; mls constraints via a CIL module IIUC, withou=
t needing to change the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; base policy.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I don&#39;t think you can add a permission to=
 an existing class via a<br>
&gt;=C2=A0 =C2=A0 =C2=A0CIL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; module currently, unfortunately, so you can&#=
39;t just extend the<br>
&gt;=C2=A0 =C2=A0 =C2=A0context<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; class without modifying the base policy.=C2=
=A0 So it may be easier to<br>
&gt;=C2=A0 =C2=A0 =C2=A0define<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; an entirely new class.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The class and permission ought to be specific=
 to the usage.=C2=A0 For<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; example, mcstrans could have its own class (m=
cstrans) with its own<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; permissions (e.g. color_match or color_use or=
 ...) that abstract<br>
&gt;=C2=A0 =C2=A0 =C2=A0away<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the logical check being performed.=C2=A0 Domi=
nance checks performed for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; different reasons ought to use different perm=
issions so that one can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; distinguish what TE pairs are allowed them.<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Your code could likewise define and use its o=
wn class and permission.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Does that make sense?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0BTW, I noticed there is another permission (&quot;t=
ranslate&quot;) defined in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0context class and its constraint is ((h1 dom h2) or=
 (t1 =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0mlstranslate)).=C2=A0 I would have guessed that it =
was intended as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0front-end service check over what processes could r=
equest context<br>
&gt;=C2=A0 =C2=A0 =C2=A0translations from mcstrans or what contexts they co=
uld translate, but I<br>
&gt;=C2=A0 =C2=A0 =C2=A0don&#39;t see it being used in mcstrans anywhere.=
=C2=A0 Is this a legacy thing<br>
&gt;=C2=A0 =C2=A0 =C2=A0from early setransd/mcstransd days?=C2=A0 There is =
a TODO comment in<br>
&gt;=C2=A0 =C2=A0 =C2=A0mcstrans<br>
&gt;=C2=A0 =C2=A0 =C2=A0process_request() that suggests there was an intent=
 to perform a<br>
&gt;=C2=A0 =C2=A0 =C2=A0dominance check between the requester context and t=
he specified<br>
&gt;=C2=A0 =C2=A0 =C2=A0context,<br>
&gt;=C2=A0 =C2=A0 =C2=A0but that&#39;s not implemented.=C2=A0 Appears to be=
 allowed in current policy<br>
&gt;=C2=A0 =C2=A0 =C2=A0for<br>
&gt;=C2=A0 =C2=A0 =C2=A0all domains to the setrans_t domain itself.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Ted<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; On Mon, Sep 10, 2018 at 1:19 PM Ted Toth =
&lt;<a href=3D"mailto:txtoth@gmail.com" target=3D"_blank">txtoth@gmail.com<=
/a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:txtoth@gmail.com" targ=
et=3D"_blank">txtoth@gmail.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; &lt;mailto:<a href=3D"mailto:txtoth@gmail=
.com" target=3D"_blank">txtoth@gmail.com</a> &lt;mailto:<a href=3D"mailto:t=
xtoth@gmail.com" target=3D"_blank">txtoth@gmail.com</a>&gt;&gt;&gt; wrote:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0 Understood, thanks.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0 On Mon, Sep 10, 2018 a=
t 12:46 PM Stephen Smalley<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"=
_blank">sds@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.go=
v" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;mailto:<a href=3D"=
mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a> &lt;mailt=
o:<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov<=
/a>&gt;&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 On 09/10/2018 01:13 PM, Ted Toth wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; We currently have code running on el6 that does a MLS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dominance check by<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; calling security_compute_av_raw with the security<br>
&gt;=C2=A0 =C2=A0 =C2=A0object class<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; SECCLASS_CONTEXT with permission CONTEXT__CONTAINS as<br>
&gt;=C2=A0 =C2=A0 =C2=A0you can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 see in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; python code below. When I run this code on el6 s1<br>
&gt;=C2=A0 =C2=A0 =C2=A0dominates<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 s0 however<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; when I run the same code on el7 s1 does not dominate<br>
&gt;=C2=A0 =C2=A0 =C2=A0s0. On<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 both systems<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; the file read dominance check works as expected. Can<br>
&gt;=C2=A0 =C2=A0 =C2=A0anyone<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 help me<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; understand why the context contains check does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0work the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 same on both<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; systems?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 That would depend entirely on how the constraint is<br>
&gt;=C2=A0 =C2=A0 =C2=A0written in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 policy.=C2=A0 I assume this is with the -mls policy on both? <br>
&gt;=C2=A0 =C2=A0 =C2=A0seinfo<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 --constrain | grep -C1 context would show you the<br>
&gt;=C2=A0 =C2=A0 =C2=A0constraint<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 kernel policy.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Looks like refpolicy defines it as:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mlsconstrain context contains<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(( h1 dom h2 ) and ( l1 domby l=
2));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 The 2nd part of the constraint was introduced by:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 commit 4c365f4a6a6f933dd13b0127e03f832c6a6cf8fc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Author: Harry Ciao &lt;<a href=3D"mailto:qingtao.cao@windriver.com" tar=
get=3D"_blank">qingtao.cao@windriver.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:qingtao.cao@windriver.=
com" target=3D"_blank">qingtao.cao@windriver.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &lt;mailto:<a href=3D"mailto:qingtao.cao@windriver.com" target=3D"_blan=
k">qingtao.cao@windriver.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:qingtao.cao@windriver.=
com" target=3D"_blank">qingtao.cao@windriver.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Date:=C2=A0 =C2=A0Tue Feb 15 10:16:32 2011 +0800<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0l1 domby l2 for contains MLS constraint<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0As identified by Stephan Smalley, the current=
 MLS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 constraint for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0contains permission of the context class shou=
ld<br>
&gt;=C2=A0 =C2=A0 =C2=A0consider<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 the current<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0level of a user along with the clearance leve=
l so that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mls_systemlow<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0is no longer considered contained in mls_syst=
emhigh.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Harry Ciao<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:qingtao.cao@windriver.com" ta=
rget=3D"_blank">qingtao.cao@windriver.com</a> &lt;mailto:<a href=3D"mailto:=
qingtao.cao@windriver.com" target=3D"_blank">qingtao.cao@windriver.com</a>&=
gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &lt;mailto:<a href=3D"mailto:qingtao.cao@windriver.com" target=3D"_blan=
k">qingtao.cao@windriver.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:qingtao.cao@windriver.=
com" target=3D"_blank">qingtao.cao@windriver.com</a>&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 This was to prevent a user from logging in at a level<br>
&gt;=C2=A0 =C2=A0 =C2=A0below their<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 authorized range, in the unusual scenario where the<br>
&gt;=C2=A0 =C2=A0 =C2=A0user&#39;s low<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 level was<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 not s0/systemlow.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; Ted<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; import selinux<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; SECCLASS_CONTEXT =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0selinux.string_to_security_class(&quot;context&quot=
;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; CONTEXT__CONTAINS =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 selinux.string_to_av_perm(SECCLASS_CONTEXT, &quot;contains&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; SECCLASS_FILE =3D selinux.string_to_security_class(&quot;fil=
e&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; FILE__READ =3D selinux.string_to_av_perm(SECCLASS_FILE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;read&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; raw_con1 =3D &quot;user_u:user_r:user_t:s1&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; raw_con2 =3D &quot;user_u:user_r:user_t:s0&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; avd =3D selinux.av_decision()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; selinux.avc_reset()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 rc =3D selinux.security_compute_av_raw(r=
aw_con1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0raw_con2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if rc &lt; 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;selinux.securi=
ty_compute_av_raw<br>
&gt;=C2=A0 =C2=A0 =C2=A0failed for %s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 %s&quot; %<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; (raw_con1, raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (avd.allowed &amp; CONTEXT__CONTAINS)=
 =3D=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; CONTEXT__CONTAINS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s dominates %=
s&quot; % (raw_con1, raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s does not do=
minate %s&quot; % (raw_con1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; except OSError, ex:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 print &quot;exception calling<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 selinux.security_compute_av_raw&quot;, ex<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; avd =3D selinux.av_decision()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; selinux.avc_reset()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 rc =3D selinux.security_compute_av_raw(r=
aw_con1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0raw_con2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; SECCLASS_FILE, FILE__READ, avd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if rc &lt; 0:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;selinux.securi=
ty_compute_av_raw<br>
&gt;=C2=A0 =C2=A0 =C2=A0failed for %s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 %s&quot; %<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; (raw_con1, raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 if (avd.allowed &amp; FILE__READ) =3D=3D=
 FILE__READ:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s dominates %=
s&quot; % (raw_con1, raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s does not do=
minate %s&quot; % (raw_con1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; raw_con2))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; except OSError:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 print &quot;exception calling<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 selinux.security_compute_av_raw&quot;, ex<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; _______________________________________________<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; Selinux mailing list<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">S=
elinux@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:Selinux@tycho.nsa.gov=
" target=3D"_blank">Selinux@tycho.nsa.gov</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:Selinux@tycho.nsa.gov"=
 target=3D"_blank">Selinux@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:S=
elinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.nsa.gov</a>&gt;&gt;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; To unsubscribe, send email to<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:Selinux-leave@tycho.nsa.gov" targ=
et=3D"_blank">Selinux-leave@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:=
Selinux-leave@tycho.nsa.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov<=
/a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &lt;mailto:<a href=3D"mailto:Selinux-leave@tycho.nsa.gov" target=3D"_bl=
ank">Selinux-leave@tycho.nsa.gov</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>&gt;&gt;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt; To get help, send an email containing &quot;help&quot; to<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; <a href=3D"mailto:Selinux-request@tycho.n=
sa.gov" target=3D"_blank">Selinux-request@tycho.nsa.gov</a> &lt;mailto:<a h=
ref=3D"mailto:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-requ=
est@tycho.nsa.gov</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 &lt;mailto:<a href=3D"mailto:Selinux-request@tycho.nsa.gov" target=3D"_=
blank">Selinux-request@tycho.nsa.gov</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:Selinux-request@tycho.=
nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa.gov</a>&gt;&gt;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000008e451105759ec169--
