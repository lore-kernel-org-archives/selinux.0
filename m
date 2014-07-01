Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s61AaQHo018982
 for <selinux@tycho.nsa.gov>; Tue, 1 Jul 2014 06:36:26 -0400
Received: by mail-oa0-f53.google.com with SMTP id l6so10277814oag.40
 for <selinux@tycho.nsa.gov>; Tue, 01 Jul 2014 03:36:28 -0700 (PDT)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <53B2759A.2030209@gmail.com>
References: <53B2759A.2030209@gmail.com>
Date: Tue, 1 Jul 2014 12:36:28 +0200
Message-ID: <CAPzO=NxwTjb14sWaaR-Dg_POOzruF_bcrbJwUjHNskub05Tj9A@mail.gmail.com>
Subject: Re: Where's the class defined in file_contexts*
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: dE <de.techno@gmail.com>
Content-Type: multipart/alternative; boundary=001a1136358a2ab3e404fd1f5927
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1136358a2ab3e404fd1f5927
Content-Type: text/plain; charset=UTF-8

It is defined through the "middle" column. For instance, -- is a regular
file, -l a symlink, etc.

These can de defined with "semanage fcontext" as well.

Wkr,
  Sven
On Jul 1, 2014 10:57 AM, "dE" <de.techno@gmail.com> wrote:

> The default security context of a object also depends on it's class.
>
> I was looking at etc/selinux/<SELINUXTYPE>/contexts/files/file_contexts*,
> but I couldn't see any definition of a class.
>
> Also semanage fcontext doesn't have an option define a class. Entries are
> based only on files and directories.
>
> If you get red text in this email please notify.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a1136358a2ab3e404fd1f5927
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">It is defined through the &quot;middle&quot; column. For ins=
tance, -- is a regular file, -l a symlink, etc.</p>
<p dir=3D"ltr">These can de defined with &quot;semanage fcontext&quot; as w=
ell.</p>
<p dir=3D"ltr">Wkr,<br>
=C2=A0 Sven</p>
<div class=3D"gmail_quote">On Jul 1, 2014 10:57 AM, &quot;dE&quot; &lt;<a h=
ref=3D"mailto:de.techno@gmail.com">de.techno@gmail.com</a>&gt; wrote:<br ty=
pe=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
The default security context of a object also depends on it&#39;s class.<br=
>
<br>
I was looking at etc/selinux/&lt;SELINUXTYPE&gt;/<u></u>contexts/files/file=
_contexts*, but I couldn&#39;t see any definition of a class.<br>
<br>
Also semanage fcontext doesn&#39;t have an option define a class. Entries a=
re based only on files and directories.<br>
<br>
If you get red text in this email please notify.<br>
______________________________<u></u>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</blockquote></div>

--001a1136358a2ab3e404fd1f5927--
