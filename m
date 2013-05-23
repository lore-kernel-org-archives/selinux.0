MIME-Version: 1.0
In-Reply-To: <20130523005354.418a2541@fornost.bigon.be>
References: <20130523005354.418a2541@fornost.bigon.be>
Date: Thu, 23 May 2013 07:30:18 +0200
Message-ID: <CAPzO=NzDH47Ksfc4o7F=citU7DR1BF0VF0QFrCFNB82M7FfakA@mail.gmail.com>
Subject: Re: Last version of policycoreutils using Fedora only API
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Laurent Bigonville <bigon@debian.org>
Cc: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b5dbf9656065104dd5bfa30
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b5dbf9656065104dd5bfa30
Content-Type: text/plain; charset=ISO-8859-1

On May 23, 2013 1:09 AM, "Laurent Bigonville" <bigon@debian.org> wrote:
> The last release of policycoreutils is using a function
> (selinux_current_policy_path()) that is only available in Fedora. I
> guess this shouldn't have made upstream.
>
> An idea how this could be sorted for other distributions?

Please see my answer to Joshua's announcement on the new userspace. You'll
need to add in the function. There is also a dependency on yum Python
bindings that you might need to remove, and depending on your directory
structure you might need a /etc/selinux/sepolgen.conf (iirc) that defines
where to find the refpolicy Makefile.

Wkr,
  Sven Vermeulen

--047d7b5dbf9656065104dd5bfa30
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On May 23, 2013 1:09 AM, &quot;Laurent Bigonville&quot; &lt;<a href=3D"mail=
to:bigon@debian.org">bigon@debian.org</a>&gt; wrote:<br>
&gt; The last release of policycoreutils is using a function<br>
&gt; (selinux_current_policy_path()) that is only available in Fedora. I<br=
>
&gt; guess this shouldn&#39;t have made upstream.<br>
&gt;<br>
&gt; An idea how this could be sorted for other distributions?</p>
<p dir=3D"ltr">Please see my answer to Joshua&#39;s announcement on the new=
 userspace. You&#39;ll need to add in the function. There is also a depende=
ncy on yum Python bindings that you might need to remove, and depending on =
your directory structure you might need a /etc/selinux/sepolgen.conf (iirc)=
 that defines where to find the refpolicy Makefile.</p>

<p dir=3D"ltr">Wkr,<br>
=A0 Sven Vermeulen</p>

--047d7b5dbf9656065104dd5bfa30--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
