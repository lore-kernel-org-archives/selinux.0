Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3U0MJuh010876
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 20:22:19 -0400
Received: by mail-wi0-f173.google.com with SMTP id z2so8291651wiv.12
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 17:22:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
Date: Tue, 29 Apr 2014 17:22:17 -0700
Message-ID: <CAFftDdr-NiGV8rZGVz4EJT_7y9oz7DK_+b_cqXDUtpGHu+TKSw@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Content-Type: multipart/alternative; boundary=001a113484ca83c26604f8378aac
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113484ca83c26604f8378aac
Content-Type: text/plain; charset=UTF-8

Fine by me, probably not a bad idea.
On Apr 29, 2014 4:59 PM, "Stephen Smalley" <stephen.smalley@gmail.com>
wrote:

> Requested for Android in order to distinguish denials that are not in
> fact breaking anything yet due to permissive domains versus denials
> that are being enforced, but seems generally useful.  result field was
> already in the selinux audit data structure and was being passed to
> avc_audit() but wasn't being used.  Seems to cause no harm to ausearch
> or audit2allow to add it as a field.  Comments?
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a113484ca83c26604f8378aac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Fine by me, probably not a bad idea.</p>
<div class=3D"gmail_quote">On Apr 29, 2014 4:59 PM, &quot;Stephen Smalley&q=
uot; &lt;<a href=3D"mailto:stephen.smalley@gmail.com">stephen.smalley@gmail=
.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Requested for Android in order to distinguish denials that are not in<br>
fact breaking anything yet due to permissive domains versus denials<br>
that are being enforced, but seems generally useful. =C2=A0result field was=
<br>
already in the selinux audit data structure and was being passed to<br>
avc_audit() but wasn&#39;t being used. =C2=A0Seems to cause no harm to ause=
arch<br>
or audit2allow to add it as a field. =C2=A0Comments?<br>
<br>_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div>

--001a113484ca83c26604f8378aac--
