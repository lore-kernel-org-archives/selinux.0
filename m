Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9V9R3Sj027499
 for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2016 05:27:03 -0400
Received: by mail-wm0-f54.google.com with SMTP id t79so37890688wmt.0
 for <selinux@tycho.nsa.gov>; Mon, 31 Oct 2016 02:27:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3c579f68-4125-c2e2-a2d9-6d801f7f7de9@tycho.nsa.gov>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <c9ef14f5-1062-21a5-e5ef-d6746a1868d8@ieee.org>
 <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
 <3c579f68-4125-c2e2-a2d9-6d801f7f7de9@tycho.nsa.gov>
From: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Mon, 31 Oct 2016 10:27:00 +0100
Message-ID: <CAPzO=Nz0V58vgM_1m7sZ2yYLe-YCEf9f06vRMCyRV6Xixw5XhA@mail.gmail.com>
Subject: Re: [RFC] Split up policycoreutils
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c3add6664f66054025cf69
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c3add6664f66054025cf69
Content-Type: text/plain; charset=UTF-8

On Oct 24, 2016 3:19 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> We'd also need to move chcat, since it imports seobject.  However, on
> that topic, is there any reason to retain chcat?  It was created for the
> original discretionary MCS model and I'm not sure it is used anymore by
> anyone.

I am aware of at least one company using chcat. However, I don't know to
what extend they rely on it - they use it in their user provisioning
scripts.

I don't mind getting rid of it, assuming all its functionality is covered
elsewhere. Especially using the tool(s) in unattended scripts.

Wkr,
  Sven Vermeulen

--001a11c3add6664f66054025cf69
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">On Oct 24, 2016 3:19 PM, &quot;Stephen Smalley&quot; &lt;<a =
href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt; We&#39;d also need to move chcat, since it imports seobject.=C2=A0 How=
ever, on<br>
&gt; that topic, is there any reason to retain chcat?=C2=A0 It was created =
for the<br>
&gt; original discretionary MCS model and I&#39;m not sure it is used anymo=
re by<br>
&gt; anyone.</p>
<p dir=3D"ltr">I am aware of at least one company using chcat. However, I d=
on&#39;t know to what extend they rely on it - they use it in their user pr=
ovisioning scripts.</p>
<p dir=3D"ltr">I don&#39;t mind getting rid of it, assuming all its functio=
nality is covered elsewhere. Especially using the tool(s) in unattended scr=
ipts.</p>
<p dir=3D"ltr">Wkr,<br>
=C2=A0 Sven Vermeulen</p>

--001a11c3add6664f66054025cf69--
