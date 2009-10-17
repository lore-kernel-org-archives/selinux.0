Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9HIHvt7005814
	for <selinux@tycho.nsa.gov>; Sat, 17 Oct 2009 14:17:57 -0400
Received: from mail-vw0-f188.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9HIH3Rn020010
	for <selinux@tycho.nsa.gov>; Sat, 17 Oct 2009 18:17:03 GMT
Received: by vws26 with SMTP id 26so1361695vws.32
        for <selinux@tycho.nsa.gov>; Sat, 17 Oct 2009 11:17:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4AD9AD06.9030309@redhat.com>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
	 <4AD9AD06.9030309@redhat.com>
Date: Sat, 17 Oct 2009 11:17:55 -0700
Message-ID: <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com>
Subject: Re: sshd error: Failed to get default security context
From: Larry Ross <selinux.larry@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001485ecf9840f2a8c0476258862
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001485ecf9840f2a8c0476258862
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Oct 17, 2009 at 4:39 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:

>  On 10/16/2009 08:15 PM, Larry Ross wrote:
> > I have created a custom selinux user for the strict policy on RHEL5.3
> who's
> > purpose is to connect via ssh and scp files off the machine.  When that
> user
> > tries to login via ssh, I see the following messages in /var/log/secure:
> >
> > In enforcing:
> > Oct 16 07:49:40 localhost sshd[20461]: Accepted password for scpuser
> > from 192.168.1.1 port 64680 ssh2
> > Oct 16 07:49:40 localhost sshd[20461]: error: Failed to get default
> security
> > context for scpuser.
> > Oct 16 07:49:40 localhost sshd[20461]: fatal: SELinux failure. Aborting
> > connection.
> >
> > In permissive:
> > Oct 16 07:55:59 localhost sshd[23302]: Accepted password for scpuser from
> > 192.168.1.1 port 56254 ssh2
> > Oct 16 07:55:59 localhost sshd[23302]: error: Failed to get default
> security
> > context for scpuser.
> > Oct 16 07:55:59 localhost sshd[23302]: error: SELinux failure. Continuing
> in
> > permissive mode.
> >
> > Could someone explain what these messages mean?
> >
> > I believe that I have a default context defined in the "default context"
> > file that should work. I believe I have an executable context available
> for
> > this user (using rbash rather than bash).
> >
> > How is sshd making this decision?  It looks like it is calling
> setexeccon,
> > but I'm not sure how that makes its decision.  Where should I look for
> clues
> > as to how to fix it?
> >
> >    Thank you,
> >    Larry
> >
> Did you add an entry to default_types?
>

I did.  And in default_contexts and in users/scpuser.  None of them fixed
the issue.
Could someone explain to me if these files are still used and what they are
used for?  And if there are other files that might need to be modified as
well?

At this point it looks like I was missing a rule to allow the role
transition, but it isn't quite fixed yet (and some of the entries in the
files above may or not have been required as well).

  -- Larry

--001485ecf9840f2a8c0476258862
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Sat, Oct 17, 2009 at 4:39 AM, Daniel J Walsh =
<span dir=3D"ltr">&lt;<a href=3D"mailto:dwalsh@redhat.com">dwalsh@redhat.co=
m</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On 10/16/2009 08:15 PM, Larry Ross wrote:<br>&gt; I have =
created a custom selinux user for the strict policy on RHEL5.3 who&#39;s<br=
>&gt; purpose is to connect via ssh and scp files off the machine. =A0When =
that user<br>
&gt; tries to login via ssh, I see the following messages in /var/log/secur=
e:<br>&gt;<br>&gt; In enforcing:<br>&gt; Oct 16 07:49:40 localhost sshd[204=
61]: Accepted password for scpuser<br>&gt; from 192.168.1.1 port 64680 ssh2=
<br>
&gt; Oct 16 07:49:40 localhost sshd[20461]: error: Failed to get default se=
curity<br>&gt; context for scpuser.<br>&gt; Oct 16 07:49:40 localhost sshd[=
20461]: fatal: SELinux failure. Aborting<br>&gt; connection.<br>&gt;<br>
&gt; In permissive:<br>&gt; Oct 16 07:55:59 localhost sshd[23302]: Accepted=
 password for scpuser from<br>&gt; 192.168.1.1 port 56254 ssh2<br>&gt; Oct =
16 07:55:59 localhost sshd[23302]: error: Failed to get default security<br=
>
&gt; context for scpuser.<br>&gt; Oct 16 07:55:59 localhost sshd[23302]: er=
ror: SELinux failure. Continuing in<br>&gt; permissive mode.<br>&gt;<br>&gt=
; Could someone explain what these messages mean?<br>&gt;<br>&gt; I believe=
 that I have a default context defined in the &quot;default context&quot;<b=
r>
&gt; file that should work. I believe I have an executable context availabl=
e for<br>&gt; this user (using rbash rather than bash).<br>&gt;<br>&gt; How=
 is sshd making this decision? =A0It looks like it is calling setexeccon,<b=
r>
&gt; but I&#39;m not sure how that makes its decision. =A0Where should I lo=
ok for clues<br>&gt; as to how to fix it?<br>&gt;<br>&gt; =A0 =A0Thank you,=
<br>&gt; =A0 =A0Larry<br>&gt;<br></div></div>Did you add an entry to defaul=
t_types?<br>
</blockquote></div>
<div>=A0</div>
<div>I did.=A0 And in default_contexts and in users/scpuser.=A0=A0None of t=
hem=A0fixed the issue.</div>
<div>Could someone explain to me if these files are still used and what the=
y are used for?=A0 And if there are other files that might need to be modif=
ied as well?</div>
<div>=A0</div>
<div>At this point it looks like I was missing a rule to allow the role tra=
nsition, but it isn&#39;t quite fixed yet (and some of the entries in the f=
iles above may or not have been required as well).</div>
<div>=A0</div>
<div>=A0 -- Larry<br></div>

--001485ecf9840f2a8c0476258862--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
