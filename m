Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9IIw3kl009375
	for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2009 14:58:03 -0400
Received: from mail-vw0-f188.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9IIxlfs027688
	for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2009 18:59:47 GMT
Received: by vws26 with SMTP id 26so1571290vws.32
        for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2009 11:58:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091018103341.GA8253@notebook1.grift.internal>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
	 <4AD9AD06.9030309@redhat.com>
	 <20091018103341.GA8253@notebook1.grift.internal>
Date: Sun, 18 Oct 2009 11:58:00 -0700
Message-ID: <81092d890910181158p40beabe7pa77a09f015640519@mail.gmail.com>
Subject: Re: sshd error: Failed to get default security context
From: Larry Ross <selinux.larry@gmail.com>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00163631073747d96504763a35bd
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00163631073747d96504763a35bd
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Oct 18, 2009 at 3:33 AM, Dominick Grift <domg472@gmail.com> wrote:

> On Sat, Oct 17, 2009 at 07:39:50AM -0400, Daniel J Walsh wrote:
> > On 10/16/2009 08:15 PM, Larry Ross wrote:
> > > I have created a custom selinux user for the strict policy on RHEL5.3
> who's
> > > purpose is to connect via ssh and scp files off the machine.  When that
> user
> > > tries to login via ssh, I see the following messages in
> /var/log/secure:
> > >
> > > In enforcing:
> > > Oct 16 07:49:40 localhost sshd[20461]: Accepted password for scpuser
> > > from 192.168.1.1 port 64680 ssh2
> > > Oct 16 07:49:40 localhost sshd[20461]: error: Failed to get default
> security
> > > context for scpuser.
> > > Oct 16 07:49:40 localhost sshd[20461]: fatal: SELinux failure. Aborting
> > > connection.
> > >
> > > In permissive:
> > > Oct 16 07:55:59 localhost sshd[23302]: Accepted password for scpuser
> from
> > > 192.168.1.1 port 56254 ssh2
> > > Oct 16 07:55:59 localhost sshd[23302]: error: Failed to get default
> security
> > > context for scpuser.
> > > Oct 16 07:55:59 localhost sshd[23302]: error: SELinux failure.
> Continuing in
> > > permissive mode.
> > >
> > > Could someone explain what these messages mean?
>
> I am not sure about el5 but in Fedora:
>
> the files in /etc/selinux/<policy model>/contexts/targeted have
> specifications that tell the login programs what context to use for the
> specified seuser when he logs in.
>
> I wrote an article about adding customized user domains for Fedora:
>
>
> http://selinux-mac.blogspot.com/2009/06/selinux-lockdown-part-four-customized.html
>
> And some screencasts:
>
> http://selinux-mac.blogspot.com/2009/06/selinux-screencasts.html


Dominick,
  Thanks for the links, I hadn't seen those before.  Those are great
examples of _how_ to do it.  I am looking for something that helps me to
understand _why_ things work the way they do.  In my case, I didn't need to
add my user to /etc/selinux/strict/contexts/users, nothing tells me to do
that or why it would work without it.  In fact, the strict policy only has
the root user defined there.

   Dan recommended updating "default_types", that wasn't needed, but I don't
know why he recommended that or how the system uses that file vs. the
default_contexts file, which I had modified to include my custom users.

   Can anyone point me to some current documentation that explains this (or
at least documentation that is not obviously out of date)?

   -- Larry



> > >
> > > I believe that I have a default context defined in the "default
> context"
> > > file that should work. I believe I have an executable context available
> for
> > > this user (using rbash rather than bash).
> > >
> > > How is sshd making this decision?  It looks like it is calling
> setexeccon,
> > > but I'm not sure how that makes its decision.  Where should I look for
> clues
> > > as to how to fix it?
> > >
> > >    Thank you,
> > >    Larry
> > >
> > Did you add an entry to default_types?
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> > the words "unsubscribe selinux" without quotes as the message.
>

--00163631073747d96504763a35bd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sun, Oct 18, 2009 at 3:33 AM, Dominick Grift =
<span dir=3D"ltr">&lt;<a href=3D"mailto:domg472@gmail.com">domg472@gmail.co=
m</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Sat, Oct 17, 2009 at 07:39:50AM -0400, Daniel J Walsh =
wrote:<br>&gt; On 10/16/2009 08:15 PM, Larry Ross wrote:<br>&gt; &gt; I hav=
e created a custom selinux user for the strict policy on RHEL5.3 who&#39;s<=
br>
&gt; &gt; purpose is to connect via ssh and scp files off the machine. =A0W=
hen that user<br>&gt; &gt; tries to login via ssh, I see the following mess=
ages in /var/log/secure:<br>&gt; &gt;<br>&gt; &gt; In enforcing:<br>&gt; &g=
t; Oct 16 07:49:40 localhost sshd[20461]: Accepted password for scpuser<br>
&gt; &gt; from 192.168.1.1 port 64680 ssh2<br>&gt; &gt; Oct 16 07:49:40 loc=
alhost sshd[20461]: error: Failed to get default security<br>&gt; &gt; cont=
ext for scpuser.<br>&gt; &gt; Oct 16 07:49:40 localhost sshd[20461]: fatal:=
 SELinux failure. Aborting<br>
&gt; &gt; connection.<br>&gt; &gt;<br>&gt; &gt; In permissive:<br>&gt; &gt;=
 Oct 16 07:55:59 localhost sshd[23302]: Accepted password for scpuser from<=
br>&gt; &gt; 192.168.1.1 port 56254 ssh2<br>&gt; &gt; Oct 16 07:55:59 local=
host sshd[23302]: error: Failed to get default security<br>
&gt; &gt; context for scpuser.<br>&gt; &gt; Oct 16 07:55:59 localhost sshd[=
23302]: error: SELinux failure. Continuing in<br>&gt; &gt; permissive mode.=
<br>&gt; &gt;<br>&gt; &gt; Could someone explain what these messages mean?<=
br>
<br></div>I am not sure about el5 but in Fedora:<br><br>the files in /etc/s=
elinux/&lt;policy model&gt;/contexts/targeted have specifications that tell=
 the login programs what context to use for the specified seuser when he lo=
gs in.<br>
<br>I wrote an article about adding customized user domains for Fedora:<br>=
<br><a href=3D"http://selinux-mac.blogspot.com/2009/06/selinux-lockdown-par=
t-four-customized.html" target=3D"_blank">http://selinux-mac.blogspot.com/2=
009/06/selinux-lockdown-part-four-customized.html</a><br>
<br>And some screencasts:<br><br><a href=3D"http://selinux-mac.blogspot.com=
/2009/06/selinux-screencasts.html" target=3D"_blank">http://selinux-mac.blo=
gspot.com/2009/06/selinux-screencasts.html</a></blockquote>
<div>=A0</div>
<div>Dominick,</div>
<div>=A0 Thanks for the links, I hadn&#39;t seen those before.=A0 Those are=
 great examples of _how_ to do it.=A0 I am looking for something that helps=
 me to understand _why_ things work the way they do.=A0 In my case, I didn&=
#39;t need to add my user to /etc/selinux/strict/contexts/users, nothing te=
lls me to do that or why it would work without it.=A0 In fact, the strict p=
olicy only has the root user defined there.</div>

<div>=A0</div>
<div>=A0=A0 Dan recommended updating &quot;default_types&quot;, that wasn&#=
39;t needed, but I don&#39;t know why he recommended that or how the system=
 uses that file vs. the default_contexts file,=A0which I had modified to in=
clude my custom users.</div>

<div>=A0</div>
<div>=A0=A0 Can anyone point me to some current documentation that explains=
 this (or at least documentation that is not obviously out of date)?</div>
<div>=A0</div>
<div>=A0=A0 -- Larry</div>
<div>=A0</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">&gt; &gt;<br>&gt; &gt; I believe that I have a default co=
ntext defined in the &quot;default context&quot;<br>&gt; &gt; file that sho=
uld work. I believe I have an executable context available for<br>&gt; &gt;=
 this user (using rbash rather than bash).<br>
&gt; &gt;<br>&gt; &gt; How is sshd making this decision? =A0It looks like i=
t is calling setexeccon,<br>&gt; &gt; but I&#39;m not sure how that makes i=
ts decision. =A0Where should I look for clues<br>&gt; &gt; as to how to fix=
 it?<br>
&gt; &gt;<br>&gt; &gt; =A0 =A0Thank you,<br>&gt; &gt; =A0 =A0Larry<br>&gt; =
&gt;<br>&gt; Did you add an entry to default_types?<br>&gt;<br></div>&gt; -=
-<br>&gt; This message was distributed to subscribers of the selinux mailin=
g list.<br>
&gt; If you no longer wish to subscribe, send mail to <a href=3D"mailto:maj=
ordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>&gt; the words &q=
uot;unsubscribe selinux&quot; without quotes as the message.<br></blockquot=
e>
</div><br>

--00163631073747d96504763a35bd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
