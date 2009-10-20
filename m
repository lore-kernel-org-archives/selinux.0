MIME-Version: 1.0
In-Reply-To: <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
	 <4AD9AD06.9030309@redhat.com>
	 <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com>
	 <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com>
	 <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 19 Oct 2009 18:43:16 -0700
Message-ID: <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com>
Subject: Re: sshd error: Failed to get default security context
From: Larry Ross <selinux.larry@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001517576bd277c353047653fcd8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001517576bd277c353047653fcd8
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 19, 2009 at 10:13 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

>  On Mon, 2009-10-19 at 09:49 -0700, Larry Ross wrote:
> > On Mon, Oct 19, 2009 at 6:53 AM, Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> >
> >         On Sat, 2009-10-17 at 11:17 -0700, Larry Ross wrote:
> >         >
> >         >
> >         > On Sat, Oct 17, 2009 at 4:39 AM, Daniel J Walsh
> >         <dwalsh@redhat.com>
> >         > wrote:
> >         >
> >         >         On 10/16/2009 08:15 PM, Larry Ross wrote:
> >         >         > I have created a custom selinux user for the
> >         strict policy
> >         >         on RHEL5.3 who's
> >         >         > purpose is to connect via ssh and scp files off
> >         the
> >         >         machine.  When that user
> >         >         > tries to login via ssh, I see the following
> >         messages
> >         >         in /var/log/secure:
> >         >         >
> >         >         > In enforcing:
> >         >         > Oct 16 07:49:40 localhost sshd[20461]: Accepted
> >         password for
> >         >         scpuser
> >         >         > from 192.168.1.1 port 64680 ssh2
> >         >         > Oct 16 07:49:40 localhost sshd[20461]: error:
> >         Failed to get
> >         >         default security
> >         >         > context for scpuser.
> >         >         > Oct 16 07:49:40 localhost sshd[20461]: fatal:
> >         SELinux
> >         >         failure. Aborting
> >         >         > connection.
> >         >         >
> >         >         > In permissive:
> >         >         > Oct 16 07:55:59 localhost sshd[23302]: Accepted
> >         password for
> >         >         scpuser from
> >         >         > 192.168.1.1 port 56254 ssh2
> >         >         > Oct 16 07:55:59 localhost sshd[23302]: error:
> >         Failed to get
> >         >         default security
> >         >         > context for scpuser.
> >         >         > Oct 16 07:55:59 localhost sshd[23302]: error:
> >         SELinux
> >         >         failure. Continuing in
> >         >         > permissive mode.
> >         >         >
> >         >         > Could someone explain what these messages mean?
> >         >         >
> >         >         > I believe that I have a default context defined in
> >         the
> >         >         "default context"
> >         >         > file that should work. I believe I have an
> >         executable
> >         >         context available for
> >         >         > this user (using rbash rather than bash).
> >         >         >
> >         >         > How is sshd making this decision?  It looks like
> >         it is
> >         >         calling setexeccon,
> >         >         > but I'm not sure how that makes its decision.
> >          Where should
> >         >         I look for clues
> >         >         > as to how to fix it?
> >         >         >
> >         >         >    Thank you,
> >         >         >    Larry
> >         >         >
> >         >
> >         >         Did you add an entry to default_types?
> >         >
> >         > I did.  And in default_contexts and in users/scpuser.  None
> >         of
> >         > them fixed the issue.
> >         > Could someone explain to me if these files are still used
> >         and what
> >         > they are used for?  And if there are other files that might
> >         need to be
> >         > modified as well?
> >
> >
> >         Not up to date, but possibly still useful:
> >
> http://www.nsa.gov/research/_files/selinux/papers/policy2/x724.shtml
> >         http://oss.tresys.com/projects/refpolicy/wiki/RoleCreation
> >
> > Stephen,
> >   Thank you for these links, I hadn't found them in my searching and
> > they seem to contain the information I need (and it looks like they
> > are for the most part still accurate).
> >
> >   The missing piece is the MLS/MCS portion of the context, that seems
> > to be included in the files that came with RHEL5, is that used as any
> > part of the context decision?  Is it used when setting the new
> > context?
>
> Not anymore, no - that is a legacy of the original MLS logic and
> predates the use of the seusers configuration.  The MLS/MCS portion gets
> set from the user's entry in the seusers configuration these days,
> although it has to be within the authorized range for the corresponding
> SELinux user in the policy of course.  LSPP configuration also has a
> setup where sshd will try to preserve the level of the client when using
> labeled networking, but that has to be enabled.
>

Stephen,
  Thank you for your reply.  That was helpful.
  One question, what do you mean when you say "seusers configuration"?  Is
that the files in <policy type>/contexts/users or the information maintained
by semanage or something else?

  Thanks,
  Larry


>
> --
>  Stephen Smalley
> National Security Agency
>
>

--001517576bd277c353047653fcd8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Oct 19, 2009 at 10:13 AM, Stephen Smalle=
y <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.=
gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Mon, 2009-10-19 at 09:49 -0700, Larry Ross wrote:<br>&=
gt; On Mon, Oct 19, 2009 at 6:53 AM, Stephen Smalley &lt;<a href=3D"mailto:=
sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>&gt; wrote:<br>&gt;<br>&gt;=
 =A0 =A0 =A0 =A0 On Sat, 2009-10-17 at 11:17 -0700, Larry Ross wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =
=A0 &gt; On Sat, Oct 17, 2009 at 4:39 AM, Daniel J Walsh<br>&gt; =A0 =A0 =
=A0 =A0 &lt;<a href=3D"mailto:dwalsh@redhat.com">dwalsh@redhat.com</a>&gt;<=
br>&gt; =A0 =A0 =A0 =A0 &gt; wrote:<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 On 10/16/2009 08:15 PM, Larry Ros=
s wrote:<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; I have created a=
 custom selinux user for the<br>&gt; =A0 =A0 =A0 =A0 strict policy<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 on RHEL5.3 who&#39;s<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; purpose is to connect via ss=
h and scp files off<br>&gt; =A0 =A0 =A0 =A0 the<br>&gt; =A0 =A0 =A0 =A0 &gt=
; =A0 =A0 =A0 =A0 machine. =A0When that user<br>&gt; =A0 =A0 =A0 =A0 &gt; =
=A0 =A0 =A0 =A0 &gt; tries to login via ssh, I see the following<br>
&gt; =A0 =A0 =A0 =A0 messages<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 =
in /var/log/secure:<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&g=
t; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; In enforcing:<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:49:40 localhost sshd[20461]: Ac=
cepted<br>
&gt; =A0 =A0 =A0 =A0 password for<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 scpuser<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; from 192.168.=
1.1 port 64680 ssh2<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; Oct 1=
6 07:49:40 localhost sshd[20461]: error:<br>&gt; =A0 =A0 =A0 =A0 Failed to =
get<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 default security<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; context for scpuser.<br>&gt; =A0 =A0 =A0 =
=A0 &gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:49:40 localhost sshd[20461]: fatal:=
<br>&gt; =A0 =A0 =A0 =A0 SELinux<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 failure. Aborting<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; connection.<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =
=A0 &gt; In permissive:<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; O=
ct 16 07:55:59 localhost sshd[23302]: Accepted<br>&gt; =A0 =A0 =A0 =A0 pass=
word for<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 scpuser from<br>&gt; =A0 =A0 =A0 =
=A0 &gt; =A0 =A0 =A0 =A0 &gt; 192.168.1.1 port 56254 ssh2<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:55:59 localhost sshd[23302]: er=
ror:<br>&gt; =A0 =A0 =A0 =A0 Failed to get<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0=
 =A0 =A0 =A0 default security<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; context for scpuser.<br>&gt;=
 =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; Oct 16 07:55:59 localhost sshd[2=
3302]: error:<br>&gt; =A0 =A0 =A0 =A0 SELinux<br>&gt; =A0 =A0 =A0 =A0 &gt; =
=A0 =A0 =A0 =A0 failure. Continuing in<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0=
 =A0 =A0 &gt; permissive mode.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;=
 =A0 =A0 =A0 =A0 &gt; Could someone explain what these messages mean?<br>&g=
t; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; =
=A0 =A0 =A0 =A0 &gt; I believe that I have a default context defined in<br>
&gt; =A0 =A0 =A0 =A0 the<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &quot=
;default context&quot;<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; fi=
le that should work. I believe I have an<br>&gt; =A0 =A0 =A0 =A0 executable=
<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 context available for<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; this user (using rbash rathe=
r than bash).<br>&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0=
 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; How is sshd making this decision? =
=A0It looks like<br>&gt; =A0 =A0 =A0 =A0 it is<br>&gt; =A0 =A0 =A0 =A0 &gt;=
 =A0 =A0 =A0 =A0 calling setexeccon,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; but I&#39;m not sure how tha=
t makes its decision.<br>&gt; =A0 =A0 =A0 =A0 =A0Where should<br>&gt; =A0 =
=A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 I look for clues<br>&gt; =A0 =A0 =A0 =A0 &=
gt; =A0 =A0 =A0 =A0 &gt; as to how to fix it?<br>&gt; =A0 =A0 =A0 =A0 &gt; =
=A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0Thank you,<br>&gt; =
=A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0Larry<br>&gt; =A0 =A0 =A0 =
=A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =
=A0 =A0 &gt; =A0 =A0 =A0 =A0 Did you add an entry to default_types?<br>&gt;=
 =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I did. =A0And in default_contexts and in users/sc=
puser. =A0None<br>&gt; =A0 =A0 =A0 =A0 of<br>&gt; =A0 =A0 =A0 =A0 &gt; them=
 fixed the issue.<br>&gt; =A0 =A0 =A0 =A0 &gt; Could someone explain to me =
if these files are still used<br>
&gt; =A0 =A0 =A0 =A0 and what<br>&gt; =A0 =A0 =A0 =A0 &gt; they are used fo=
r? =A0And if there are other files that might<br>&gt; =A0 =A0 =A0 =A0 need =
to be<br>&gt; =A0 =A0 =A0 =A0 &gt; modified as well?<br>&gt;<br>&gt;<br>&gt=
; =A0 =A0 =A0 =A0 Not up to date, but possibly still useful:<br>
&gt; =A0 =A0 =A0 =A0 <a href=3D"http://www.nsa.gov/research/_files/selinux/=
papers/policy2/x724.shtml" target=3D"_blank">http://www.nsa.gov/research/_f=
iles/selinux/papers/policy2/x724.shtml</a><br>&gt; =A0 =A0 =A0 =A0 <a href=
=3D"http://oss.tresys.com/projects/refpolicy/wiki/RoleCreation" target=3D"_=
blank">http://oss.tresys.com/projects/refpolicy/wiki/RoleCreation</a><br>
&gt;<br>&gt; Stephen,<br>&gt; =A0 Thank you for these links, I hadn&#39;t f=
ound them in my searching and<br>&gt; they seem to contain the information =
I need (and it looks like they<br>&gt; are for the most part still accurate=
).<br>
&gt;<br>&gt; =A0 The missing piece is the MLS/MCS portion of the context, t=
hat seems<br>&gt; to be included in the files that came with RHEL5, is that=
 used as any<br>&gt; part of the context decision? =A0Is it used when setti=
ng the new<br>
&gt; context?<br><br></div></div>Not anymore, no - that is a legacy of the =
original MLS logic and<br>predates the use of the seusers configuration. =
=A0The MLS/MCS portion gets<br>set from the user&#39;s entry in the seusers=
 configuration these days,<br>
although it has to be within the authorized range for the corresponding<br>=
SELinux user in the policy of course. =A0LSPP configuration also has a<br>s=
etup where sshd will try to preserve the level of the client when using<br>
labeled networking, but that has to be enabled.<br></blockquote>
<div>=A0</div>
<div>Stephen,</div>
<div>=A0 Thank you for your reply.=A0 That was helpful.</div>
<div>=A0=A0One question, what do you mean when you say &quot;seusers config=
uration&quot;?=A0 Is that the files in &lt;policy type&gt;/contexts/users o=
r the information maintained by semanage or something else?</div>
<div>=A0</div>
<div>=A0 Thanks,</div>
<div>=A0 Larry</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><font color=3D"#888888"><br>--<b=
r></font>
<div>
<div></div>
<div class=3D"h5">Stephen Smalley<br>National Security Agency<br><br></div>=
</div></blockquote></div><br>

--001517576bd277c353047653fcd8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
