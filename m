Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uACIHljg017787
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 13:17:47 -0500
Received: by mail-wm0-f43.google.com with SMTP id t79so31945796wmt.0
 for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2016 10:17:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnFesuFFSi5C2MHs7qHgPvo3WjSuQ5RFXUixSEVENmzwrg@mail.gmail.com>
References: <CAFJ0LnGZ-f1UUK+yJevWKu=En5CK3s8ywaef_jju4ZFuU+LonA@mail.gmail.com>
 <021477d4-6816-1915-e84a-f038b30dbbd1@gmail.com>
 <CAFJ0LnFesuFFSi5C2MHs7qHgPvo3WjSuQ5RFXUixSEVENmzwrg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Sat, 12 Nov 2016 13:17:44 -0500
Message-ID: <CAB9W1A3ok=C5J5KMUJkB9A0gdNnX6-q1FKS31EJp6o_E-ysiSQ@mail.gmail.com>
Subject: Re: checkpolicy dontaudit compiler bug?
To: Nick Kralevich <nnk@google.com>
Cc: selinux <selinux@tycho.nsa.gov>, Dominick Grift <dac.override@gmail.com>
Content-Type: multipart/alternative; boundary=001a114672ca8a4c2d05411e9f3b
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114672ca8a4c2d05411e9f3b
Content-Type: text/plain; charset=UTF-8

Looks like it is being triggered by the dontaudit domain self:capability
sys_module; rule in the marlin sepolicy/domain.te file. dontaudit rule
merging differs since they are converted to auditdeny vectors. Likely a bug
in checkpolicy but will have to look at the logic.

On Nov 11, 2016 1:12 PM, "Nick Kralevich" <nnk@google.com> wrote:

> On Fri, Nov 11, 2016 at 9:59 AM, Dominick Grift <dac.override@gmail.com>
> wrote:
> >> Specifically, the following dontaudit rule is in that file:
> >>
> >>   dontaudit su self:capability_class_set *;
> >>
> >> which expands out to:
> >>
> >>   dontaudit su self:{ capability capability2 } *;
> >>
> >
> > That should not work. AFAIK you cannot use the "*" with two different
> > classes
> >
> > you would need to
> >
> > dontaudit su self:capability *;
> > dontaudit su self:capability2 *;
> >
> > Maybe the other policy "bullhead" does not have the invalid
> > dontaudit su self:capability_class_set *; rule
>
> They both have the same "dontaudit su self:capability_class_set *"
> statements, yet one compiles differently than the other.
>
> nnk@nick:~$ wget -q http://kralevich.com/bullhead.policy.conf
> nnk@nick:~$ wget -q http://kralevich.com/marlin.policy.conf
> nnk@nick:~$ grep "dontaudit su" bullhead.policy.conf
> marlin.policy.conf | grep capability
> bullhead.policy.conf:  dontaudit su self:{ capability capability2 } *;
> marlin.policy.conf:  dontaudit su self:{ capability capability2 } *;
>
> And changing from
>
>   dontaudit su self:{ capability capability2 } *;
>
> to
>
>   dontaudit su self:capability *;
>   dontaudit su self:capability2 *;
>
> has no effect and the policy continues to not pick up the neverallow rules.
>
> -- Nick
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a114672ca8a4c2d05411e9f3b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Looks like it is being triggered by the dontaudit domain sel=
f:capability sys_module; rule in the marlin sepolicy/domain.te file. dontau=
dit rule merging differs since they are converted to auditdeny vectors. Lik=
ely a bug in checkpolicy but will have to look at the logic. </p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Nov 11, 2016 1=
:12 PM, &quot;Nick Kralevich&quot; &lt;<a href=3D"mailto:nnk@google.com">nn=
k@google.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">On Fri, Nov 11, 2016 at 9:59 AM, Dominick Grift &lt;<a href=3D"mail=
to:dac.override@gmail.com">dac.override@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Specifically, the following dontaudit rule is in that file:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0dontaudit su self:capability_class_set *;<br>
&gt;&gt;<br>
&gt;&gt; which expands out to:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0dontaudit su self:{ capability capability2 } *;<br>
&gt;&gt;<br>
&gt;<br>
&gt; That should not work. AFAIK you cannot use the &quot;*&quot; with two =
different<br>
&gt; classes<br>
&gt;<br>
&gt; you would need to<br>
&gt;<br>
&gt; dontaudit su self:capability *;<br>
&gt; dontaudit su self:capability2 *;<br>
&gt;<br>
&gt; Maybe the other policy &quot;bullhead&quot; does not have the invalid<=
br>
&gt; dontaudit su self:capability_class_set *; rule<br>
<br>
They both have the same &quot;dontaudit su self:capability_class_set *&quot=
;<br>
statements, yet one compiles differently than the other.<br>
<br>
nnk@nick:~$ wget -q <a href=3D"http://kralevich.com/bullhead.policy.conf" r=
el=3D"noreferrer" target=3D"_blank">http://kralevich.com/bullhead.<wbr>poli=
cy.conf</a><br>
nnk@nick:~$ wget -q <a href=3D"http://kralevich.com/marlin.policy.conf" rel=
=3D"noreferrer" target=3D"_blank">http://kralevich.com/marlin.<wbr>policy.c=
onf</a><br>
nnk@nick:~$ grep &quot;dontaudit su&quot; bullhead.policy.conf<br>
marlin.policy.conf | grep capability<br>
bullhead.policy.conf:=C2=A0 dontaudit su self:{ capability capability2 } *;=
<br>
marlin.policy.conf:=C2=A0 dontaudit su self:{ capability capability2 } *;<b=
r>
<br>
And changing from<br>
<br>
=C2=A0 dontaudit su self:{ capability capability2 } *;<br>
<br>
to<br>
<br>
=C2=A0 dontaudit su self:capability *;<br>
=C2=A0 dontaudit su self:capability2 *;<br>
<br>
has no effect and the policy continues to not pick up the neverallow rules.=
<br>
<br>
-- Nick<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</blockquote></div></div>

--001a114672ca8a4c2d05411e9f3b--
