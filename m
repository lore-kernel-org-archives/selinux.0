Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3EGB5GF024498
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 12:11:05 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3EGBxQk029838
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 16:11:59 GMT
Received: by vws9 with SMTP id 9so134858vws.12
        for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 09:11:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3acfd6eb614d7ebec2d3c10d98940708@sngx.net>
References: <C7EA5D61.B6871%csellers@tresys.com>
	 <a7997a4e13a79796e80e71b9ff6d31c9@sngx.net>
	 <4BC5B6AC.1040101@redhat.com>
	 <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net>
	 <4BC5D183.20403@redhat.com>
	 <3acfd6eb614d7ebec2d3c10d98940708@sngx.net>
Date: Wed, 14 Apr 2010 09:11:04 -0700
Message-ID: <j2w81092d891004140911gae7239f8s9c5e05500b1c77f7@mail.gmail.com>
Subject: Re: sudo + selinux
From: Larry Ross <selinux.larry@gmail.com>
To: Selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001517573f8e0296aa048434a0d1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001517573f8e0296aa048434a0d1
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Apr 13, 2010 at 6:53 AM, James Cammarata <jimi@sngx.net> wrote:

>
> On Wed, 14 Apr 2010 10:30:27 -0400, Daniel J Walsh <dwalsh@redhat.com>
> > We are very careful of what we backport and sudo has not come up on the
> > priority list.  With Shipping versions of RHEL we are hesitant to make
> > major modifications that could cause a regression.
>
> Understood, I'm just surprised that running SElinux in strict mode breaks
> sudo isn't more of a priority.  Are that few people using strict mode?
>


I am using SELinux with RHEL5 and the strict policy.  I am using the per
role sudo domains, and have custom policy to make it all work, but my system
if fairly tightly constrained.

  -- Larry



>
> --
> This message has been scanned for viruses and
> dangerous content by MailScanner, and is
> believed to be clean.
>
>
> --
>  This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--001517573f8e0296aa048434a0d1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">On Tue, Apr 13, 2010 at 6:53 AM, James Cammarata=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:jimi@sngx.net">jimi@sngx.net</a>&g=
t;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>On Wed, 14 Apr 2010 10:30:27=
 -0400, Daniel J Walsh &lt;<a href=3D"mailto:dwalsh@redhat.com">dwalsh@redh=
at.com</a>&gt;<br>

<div class=3D"im">&gt; We are very careful of what we backport and sudo has=
 not come up on the<br>&gt; priority list. =A0With Shipping versions of RHE=
L we are hesitant to make<br>&gt; major modifications that could cause a re=
gression.<br>
<br></div>Understood, I&#39;m just surprised that running SElinux in strict=
 mode breaks<br>sudo isn&#39;t more of a priority. =A0Are that few people u=
sing strict mode?<br></blockquote>
<div>=A0</div>
<div>=A0<br>I am using SELinux with RHEL5 and the strict policy.=A0 I am us=
ing the per role sudo domains, and have custom policy to make it all work, =
but my system if fairly tightly constrained.<br>=A0<br>=A0 -- Larry=A0 <br>=
=A0<br>
=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im"><br>--<br>This message has been scanned for viruses and<b=
r>dangerous content by MailScanner, and is<br>believed to be clean.<br><br>=
<br>--<br></div>
<div>
<div></div>
<div class=3D"h5">This message was distributed to subscribers of the selinu=
x mailing list.<br>If you no longer wish to subscribe, send mail to <a href=
=3D"mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>the=
 words &quot;unsubscribe selinux&quot; without quotes as the message.<br>
</div></div></blockquote></div><br>

--001517573f8e0296aa048434a0d1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
