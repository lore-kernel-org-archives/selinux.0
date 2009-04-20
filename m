MIME-Version: 1.0
In-Reply-To: <1239798813.27560.16.camel@localhost.localdomain>
References: <7b740b700904142351i6eb6078bq862a181b168694b5@mail.gmail.com>
	 <1239798813.27560.16.camel@localhost.localdomain>
Date: Mon, 20 Apr 2009 15:22:55 +0500
Message-ID: <7b740b700904200322o58f3885we503582929657abc@mail.gmail.com>
Subject: Re: Policy building and loading problems
From: Shaz <shazalive@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>,
        Security Engineering Archive <groupsecurityengineering@gmail.com>
Content-Type: multipart/alternative; boundary=0015175cba90e0c4f30467f9e9fe
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0015175cba90e0c4f30467f9e9fe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Apr 15, 2009 at 5:33 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2009-04-15 at 11:51 +0500, Shaz wrote:
> > Hi everyone,
> >
> > I have some problem with loading policy. The device is in enabled and
> > permissive mode.
> >
> > ----------------
> >
> > root@some-device:/etc/selinux/targeted# make load
> > make: Warning: File `/usr/bin/checkpolicy' has modification time 1.6e
> > +07 s in the future
> > Compiling policy ...
> > /usr/bin/checkpolicy  -o /etc/selinux/targeted/policy/policy.23
> > policy.conf
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > /usr/bin/checkpolicy:  policy configuration loaded
> > /usr/bin/checkpolicy:  writing binary representation (version 23)
> > to /etc/selinux/targeted/policy/policy.23
> > /usr/bin/checkpolicy  -c 19 -o /etc/selinux/targeted/policy/policy.19
> > policy.conf
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > /usr/bin/checkpolicy:  policy configuration loaded
> > /usr/bin/checkpolicy:  writing binary representation (version 19)
> > to /etc/selinux/targeted/policy/policy.19
> > Loading Policy ...
> > /usr/bin/load_policy /etc/selinux/targeted/policy/policy.19
> > BusyBox v1.10.1 (2009-04-07 15:36:44 PKT) multi-call binary
> >
> > Usage: load_policy
>
> As the usage message says, load_policy doesn't take a policy file
> argument anymore (it always loads policy from the standard location and
> selects the appropriate version).  So just modify your Makefile to omit
> the policy file or run load_policy by hand with no arguments.


We actually were trying to load_policy through ssh remotely and when we
tried locally then it worked. We came to the conclusion that loading policy
over ssh is stupid because of security reasons and it is not allowed. Is
this right?


>
>
> >
> >
> >
> > make: * [tmp/load] Error 1
> >
> > ---------------------------------
> >
> > I also had a clock skew warning at every build step of policy
> > building. Does it matter? How to solve it easily?
>
> That just means that the timestamps on the files are in the future of
> your current clock setting.  Check your system clock and/or the
> timestamps on the files.


The device clock had problems :) Now its fine.


>
>
> >  Where did policy 23 come from?
>
> That's the latest policy version supported by the version of checkpolicy
> you have.


So policy support is hard-coded into kernel and the userspace can determine
it through some library functionality?


>
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Shaz

--0015175cba90e0c4f30467f9e9fe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Apr 15, 2009 at 5:33 PM, Stephen=
 Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tyc=
ho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<div class=3D"im">On Wed, 2009-04-15 at 11:51 +0500, Shaz wrote:<br>
&gt; Hi everyone,<br>
&gt;<br>
&gt; I have some problem with loading policy. The device is in enabled and<=
br>
&gt; permissive mode.<br>
&gt;<br>
&gt; ----------------<br>
&gt;<br>
&gt; root@some-device:/etc/selinux/targeted# make load<br>
&gt; make: Warning: File `/usr/bin/checkpolicy&#39; has modification time 1=
.6e<br>
&gt; +07 s in the future<br>
&gt; Compiling policy ...<br>
&gt; /usr/bin/checkpolicy =A0-o /etc/selinux/targeted/policy/policy.23<br>
&gt; policy.conf<br>
&gt; /usr/bin/checkpolicy: =A0loading policy configuration from policy.conf=
<br>
&gt; /usr/bin/checkpolicy: =A0policy configuration loaded<br>
&gt; /usr/bin/checkpolicy: =A0writing binary representation (version 23)<br=
>
&gt; to /etc/selinux/targeted/policy/policy.23<br>
&gt; /usr/bin/checkpolicy =A0-c 19 -o /etc/selinux/targeted/policy/policy.1=
9<br>
&gt; policy.conf<br>
&gt; /usr/bin/checkpolicy: =A0loading policy configuration from policy.conf=
<br>
&gt; /usr/bin/checkpolicy: =A0policy configuration loaded<br>
&gt; /usr/bin/checkpolicy: =A0writing binary representation (version 19)<br=
>
&gt; to /etc/selinux/targeted/policy/policy.19<br>
&gt; Loading Policy ...<br>
&gt; /usr/bin/load_policy /etc/selinux/targeted/policy/policy.19<br>
&gt; BusyBox v1.10.1 (2009-04-07 15:36:44 PKT) multi-call binary<br>
&gt;<br>
&gt; Usage: load_policy<br>
<br>
</div>As the usage message says, load_policy doesn&#39;t take a policy file=
<br>
argument anymore (it always loads policy from the standard location and<br>
selects the appropriate version). =A0So just modify your Makefile to omit<b=
r>
the policy file or run load_policy by hand with no arguments.</blockquote><=
div><br>We actually were trying to load_policy through ssh remotely and whe=
n we tried locally then it worked. We came to the conclusion that loading p=
olicy over ssh is stupid because of security reasons and it is not allowed.=
 Is this right?<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; make: * [tmp/load] Error 1<br>
&gt;<br>
&gt; ---------------------------------<br>
&gt;<br>
&gt; I also had a clock skew warning at every build step of policy<br>
&gt; building. Does it matter? How to solve it easily?<br>
<br>
</div>That just means that the timestamps on the files are in the future of=
<br>
your current clock setting. =A0Check your system clock and/or the<br>
timestamps on the files.</blockquote><div><br>The device clock had problems=
 :) Now its fine.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">
<br>
<div class=3D"im"><br>
&gt; =A0Where did policy 23 come from?<br>
<br>
</div>That&#39;s the latest policy version supported by the version of chec=
kpolicy<br>
you have.</blockquote><div><br>So policy support is hard-coded into kernel =
and the userspace can determine it through some library functionality?<br>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Shaz<br><br>

--0015175cba90e0c4f30467f9e9fe--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
