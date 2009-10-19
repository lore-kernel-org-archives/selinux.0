MIME-Version: 1.0
In-Reply-To: <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
	 <4AD9AD06.9030309@redhat.com>
	 <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com>
	 <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 19 Oct 2009 09:49:38 -0700
Message-ID: <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com>
Subject: Re: sshd error: Failed to get default security context
From: Larry Ross <selinux.larry@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001485ecf984099ef304764c885a
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001485ecf984099ef304764c885a
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 19, 2009 at 6:53 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

>  On Sat, 2009-10-17 at 11:17 -0700, Larry Ross wrote:
> >
> >
> > On Sat, Oct 17, 2009 at 4:39 AM, Daniel J Walsh <dwalsh@redhat.com>
> > wrote:
> >
> >         On 10/16/2009 08:15 PM, Larry Ross wrote:
> >         > I have created a custom selinux user for the strict policy
> >         on RHEL5.3 who's
> >         > purpose is to connect via ssh and scp files off the
> >         machine.  When that user
> >         > tries to login via ssh, I see the following messages
> >         in /var/log/secure:
> >         >
> >         > In enforcing:
> >         > Oct 16 07:49:40 localhost sshd[20461]: Accepted password for
> >         scpuser
> >         > from 192.168.1.1 port 64680 ssh2
> >         > Oct 16 07:49:40 localhost sshd[20461]: error: Failed to get
> >         default security
> >         > context for scpuser.
> >         > Oct 16 07:49:40 localhost sshd[20461]: fatal: SELinux
> >         failure. Aborting
> >         > connection.
> >         >
> >         > In permissive:
> >         > Oct 16 07:55:59 localhost sshd[23302]: Accepted password for
> >         scpuser from
> >         > 192.168.1.1 port 56254 ssh2
> >         > Oct 16 07:55:59 localhost sshd[23302]: error: Failed to get
> >         default security
> >         > context for scpuser.
> >         > Oct 16 07:55:59 localhost sshd[23302]: error: SELinux
> >         failure. Continuing in
> >         > permissive mode.
> >         >
> >         > Could someone explain what these messages mean?
> >         >
> >         > I believe that I have a default context defined in the
> >         "default context"
> >         > file that should work. I believe I have an executable
> >         context available for
> >         > this user (using rbash rather than bash).
> >         >
> >         > How is sshd making this decision?  It looks like it is
> >         calling setexeccon,
> >         > but I'm not sure how that makes its decision.  Where should
> >         I look for clues
> >         > as to how to fix it?
> >         >
> >         >    Thank you,
> >         >    Larry
> >         >
> >
> >         Did you add an entry to default_types?
> >
> > I did.  And in default_contexts and in users/scpuser.  None of
> > them fixed the issue.
> > Could someone explain to me if these files are still used and what
> > they are used for?  And if there are other files that might need to be
> > modified as well?
>
> Not up to date, but possibly still useful:
> http://www.nsa.gov/research/_files/selinux/papers/policy2/x724.shtml
> http://oss.tresys.com/projects/refpolicy/wiki/RoleCreation
>

Stephen,
  Thank you for these links, I hadn't found them in my searching and they
seem to contain the information I need (and it looks like they are for the
most part still accurate).

  The missing piece is the MLS/MCS portion of the context, that seems to be
included in the files that came with RHEL5, is that used as any part of the
context decision?  Is it used when setting the new context?

  Thank you,
  Larry


>
> > At this point it looks like I was missing a rule to allow the role
> > transition, but it isn't quite fixed yet (and some of the entries in
> > the files above may or not have been required as well).
>
> --
> Stephen Smalley
> National Security Agency
>
>

--001485ecf984099ef304764c885a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Oct 19, 2009 at 6:53 AM, Stephen Smalley=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.g=
ov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Sat, 2009-10-17 at 11:17 -0700, Larry Ross wrote:<br>&=
gt;<br>&gt;<br>&gt; On Sat, Oct 17, 2009 at 4:39 AM, Daniel J Walsh &lt;<a =
href=3D"mailto:dwalsh@redhat.com">dwalsh@redhat.com</a>&gt;<br>&gt; wrote:<=
br>
&gt;<br>&gt; =A0 =A0 =A0 =A0 On 10/16/2009 08:15 PM, Larry Ross wrote:<br>&=
gt; =A0 =A0 =A0 =A0 &gt; I have created a custom selinux user for the stric=
t policy<br>&gt; =A0 =A0 =A0 =A0 on RHEL5.3 who&#39;s<br>&gt; =A0 =A0 =A0 =
=A0 &gt; purpose is to connect via ssh and scp files off the<br>
&gt; =A0 =A0 =A0 =A0 machine. =A0When that user<br>&gt; =A0 =A0 =A0 =A0 &gt=
; tries to login via ssh, I see the following messages<br>&gt; =A0 =A0 =A0 =
=A0 in /var/log/secure:<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =
=A0 &gt; In enforcing:<br>&gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:49:40 localho=
st sshd[20461]: Accepted password for<br>
&gt; =A0 =A0 =A0 =A0 scpuser<br>&gt; =A0 =A0 =A0 =A0 &gt; from 192.168.1.1 =
port 64680 ssh2<br>&gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:49:40 localhost sshd=
[20461]: error: Failed to get<br>&gt; =A0 =A0 =A0 =A0 default security<br>&=
gt; =A0 =A0 =A0 =A0 &gt; context for scpuser.<br>
&gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:49:40 localhost sshd[20461]: fatal: SEL=
inux<br>&gt; =A0 =A0 =A0 =A0 failure. Aborting<br>&gt; =A0 =A0 =A0 =A0 &gt;=
 connection.<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; In p=
ermissive:<br>&gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:55:59 localhost sshd[2330=
2]: Accepted password for<br>
&gt; =A0 =A0 =A0 =A0 scpuser from<br>&gt; =A0 =A0 =A0 =A0 &gt; 192.168.1.1 =
port 56254 ssh2<br>&gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:55:59 localhost sshd=
[23302]: error: Failed to get<br>&gt; =A0 =A0 =A0 =A0 default security<br>&=
gt; =A0 =A0 =A0 =A0 &gt; context for scpuser.<br>
&gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:55:59 localhost sshd[23302]: error: SEL=
inux<br>&gt; =A0 =A0 =A0 =A0 failure. Continuing in<br>&gt; =A0 =A0 =A0 =A0=
 &gt; permissive mode.<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0=
 &gt; Could someone explain what these messages mean?<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; I believe that I hav=
e a default context defined in the<br>&gt; =A0 =A0 =A0 =A0 &quot;default co=
ntext&quot;<br>&gt; =A0 =A0 =A0 =A0 &gt; file that should work. I believe I=
 have an executable<br>&gt; =A0 =A0 =A0 =A0 context available for<br>
&gt; =A0 =A0 =A0 =A0 &gt; this user (using rbash rather than bash).<br>&gt;=
 =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; How is sshd making this =
decision? =A0It looks like it is<br>&gt; =A0 =A0 =A0 =A0 calling setexeccon=
,<br>&gt; =A0 =A0 =A0 =A0 &gt; but I&#39;m not sure how that makes its deci=
sion. =A0Where should<br>
&gt; =A0 =A0 =A0 =A0 I look for clues<br>&gt; =A0 =A0 =A0 =A0 &gt; as to ho=
w to fix it?<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =
=A0Thank you,<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0Larry<br>&gt; =A0 =A0 =A0=
 =A0 &gt;<br>&gt;<br>&gt; =A0 =A0 =A0 =A0 Did you add an entry to default_t=
ypes?<br>
&gt;<br>&gt; I did. =A0And in default_contexts and in users/scpuser. =A0Non=
e of<br>&gt; them fixed the issue.<br>&gt; Could someone explain to me if t=
hese files are still used and what<br>&gt; they are used for? =A0And if the=
re are other files that might need to be<br>
&gt; modified as well?<br><br></div></div>Not up to date, but possibly stil=
l useful:<br><a href=3D"http://www.nsa.gov/research/_files/selinux/papers/p=
olicy2/x724.shtml" target=3D"_blank">http://www.nsa.gov/research/_files/sel=
inux/papers/policy2/x724.shtml</a><br>
<a href=3D"http://oss.tresys.com/projects/refpolicy/wiki/RoleCreation" targ=
et=3D"_blank">http://oss.tresys.com/projects/refpolicy/wiki/RoleCreation</a=
><br></blockquote>
<div>=A0</div>
<div>Stephen,</div>
<div>=A0 Thank you for these links, I hadn&#39;t found them in my searching=
 and they seem to contain the information I need (and it looks like they ar=
e for the most part still accurate).</div>
<div>=A0</div>
<div>=A0 The missing piece is the MLS/MCS portion of the context, that seem=
s to be included in the files that came with RHEL5, is that used as any par=
t of the context decision?=A0 Is it used when setting the new context?</div=
>

<div>=A0</div>
<div>=A0 Thank you,</div>
<div>=A0 Larry</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5"><br>&gt; At this point it looks like I was missing a rule=
 to allow the role<br>&gt; transition, but it isn&#39;t quite fixed yet (an=
d some of the entries in<br>&gt; the files above may or not have been requi=
red as well).<br>
<br>--<br></div></div><font color=3D"#888888">Stephen Smalley<br>National S=
ecurity Agency<br><br></font></blockquote></div><br>

--001485ecf984099ef304764c885a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
