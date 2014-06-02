Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s526guN6028355
 for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2014 02:42:56 -0400
Received: by mail-yh0-f45.google.com with SMTP id b6so3455666yha.4
 for <selinux@tycho.nsa.gov>; Sun, 01 Jun 2014 23:42:52 -0700 (PDT)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <538B4487.8050807@gmail.com>
References: <538B4487.8050807@gmail.com>
Date: Mon, 2 Jun 2014 08:42:52 +0200
Message-ID: <CAPzO=NycsK+-5EDgtJh8nFx7WjFT0isYyxgrKxqqtrq3SdRgkg@mail.gmail.com>
Subject: Re: How does matchpathcon/setfiles work?
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: dE <de.techno@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c1bb8253ddb304fad4b423
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c1bb8253ddb304fad4b423
Content-Type: text/plain; charset=UTF-8

Policies do contain paths. They contain path expressions to be more precise.

During policy load, the path expressions together with the target contexts
are extracted and placed in /etc/selinux/mcs/contexts/files/file_contexts,
which is where tools like matchpathcon get their information from.

Wkr,
  Sven Vermeulen
On Jun 1, 2014 5:48 PM, "dE" <de.techno@gmail.com> wrote:

> As we know, policies don't contain paths. So the working of
> matchpathcon/setfiles must be based on common sense.
>
> It looks like it knows certain special folders and it's appropriate
> security context, for e.g. home folder contents should have files with
> user_home_t and suggests the correct SELinux user for the files/directories
> based on which user's home folder is it.
>
> Other directories/files should have the same security context as the
> parent directory, like with /opt.
>
> Is this correct?
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a11c1bb8253ddb304fad4b423
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Policies do contain paths. They contain path expressions to =
be more precise.</p>
<p dir=3D"ltr">During policy load, the path expressions together with the t=
arget contexts are extracted and placed in /etc/selinux/mcs/contexts/files/=
file_contexts, which is where tools like matchpathcon get their information=
 from.</p>

<p dir=3D"ltr">Wkr, <br>
=C2=A0 Sven Vermeulen</p>
<div class=3D"gmail_quote">On Jun 1, 2014 5:48 PM, &quot;dE&quot; &lt;<a hr=
ef=3D"mailto:de.techno@gmail.com">de.techno@gmail.com</a>&gt; wrote:<br typ=
e=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
As we know, policies don&#39;t contain paths. So the working of matchpathco=
n/setfiles must be based on common sense.<br>
<br>
It looks like it knows certain special folders and it&#39;s appropriate sec=
urity context, for e.g. home folder contents should have files with user_ho=
me_t and suggests the correct SELinux user for the files/directories based =
on which user&#39;s home folder is it.<br>

<br>
Other directories/files should have the same security context as the parent=
 directory, like with /opt.<br>
<br>
Is this correct?<br>
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

--001a11c1bb8253ddb304fad4b423--
