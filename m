Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p74Coi08016122
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2011 08:50:44 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p74CoheW021989
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2011 12:50:43 GMT
Received: by vws13 with SMTP id 13so1548494vws.12
        for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2011 05:50:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E3A8D16.7060807@cendio.se>
References: <4E3A8D16.7060807@cendio.se>
Date: Thu, 4 Aug 2011 14:50:43 +0200
Message-ID: <CAPzO=NympY1fiqZufFiG5OaMYTn+3JzNu2c66jr3VXHCuFH-ZQ@mail.gmail.com>
Subject: Re: SELinux policy regarding LD_LIBRARY_PATH
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf3071ca2ccfa95c04a9ad6d81
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf3071ca2ccfa95c04a9ad6d81
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 4, 2011 at 2:14 PM, Aaron Sowry <aaron@cendio.se> wrote:

> It appears that with SELinux enabled, the LD_LIBRARY_PATH environment
> variable is not inherited by user processes forked by a root process.
> This is on RHEL6.
>
> What is the general SELinux policy regarding LD_LIBRARY_PATH? Is there
> any way to change this behaviour? I couldn't find any documentation
> regarding this.
>
>
If the fork results in a type transition (say from sysadm_t to mozilla_t),
then the environment is cleaned up (see glibc's AT_SECURE setting).

If you do not want the environment to be cleared, allow noatsecure, like so:

allow sysadm_t mozilla_t:process noatsecure;

Wkr,
  Sven Vermeulen

PS Aaron sorry for double post, reply-to went to you instead of mailinglist.

--20cf3071ca2ccfa95c04a9ad6d81
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Aug 4, 2011 at 2:14 PM, Aaron Sowry <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:aaron@cendio.se">aaron@cendio.se</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex;">
It appears that with SELinux enabled, the LD_LIBRARY_PATH environment<br>
variable is not inherited by user processes forked by a root process.<br>
This is on RHEL6.<br>
<br>
What is the general SELinux policy regarding LD_LIBRARY_PATH? Is there<br>
any way to change this behaviour? I couldn&#39;t find any documentation<br>
regarding this.<br>
<br></blockquote><div><br>If the fork results in a type transition (say fro=
m sysadm_t to=20
mozilla_t), then the environment is cleaned up (see glibc&#39;s AT_SECURE=
=20
setting).<br><br>If you do not want the environment to be cleared, allow no=
atsecure, like so:<br>
<br>allow sysadm_t mozilla_t:process noatsecure;<br><br>Wkr,<br>=A0 Sven Ve=
rmeulen=A0 <br><br>PS Aaron sorry for double post, reply-to went to you ins=
tead of mailinglist.<br></div></div>

--20cf3071ca2ccfa95c04a9ad6d81--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
