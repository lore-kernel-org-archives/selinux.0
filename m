Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3REh3mF023230
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 10:43:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 40Xc9d1DVWz3GD9r
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 14:43:01 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 40Xc9c4WmGz3GD9p
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 14:43:00 +0000 (UTC)
Received: by mail-qt0-f178.google.com with SMTP id m5-v6so2557177qti.1
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 07:42:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d893d3fd-b5cf-f959-7de2-3adbedd773f4@tycho.nsa.gov>
References: <CAJ9kUZ=afxguhDWvttDf6ws-wH=dNcvTT_5s1XU8b-xD7b9-kw@mail.gmail.com>
 <d893d3fd-b5cf-f959-7de2-3adbedd773f4@tycho.nsa.gov>
From: Troels Arvin <troels.arvin@gmail.com>
Date: Fri, 27 Apr 2018 16:42:56 +0200
Message-ID: <CAJ9kUZ=Bzzbs=VVP65XwaiMv1aVy=mAeRunKbPTLrM51iXvVUQ@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="00000000000011a542056ad58513"
Subject: Re: Loopback TCP connection
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--00000000000011a542056ad58513
Content-Type: text/plain; charset="UTF-8"

Hello,

On Fri, Apr 27, 2018 at 4:31 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> See:
> https://github.com/SELinuxProject/selinux-kernel/issues/21
> https://bugzilla.redhat.com/show_bug.cgi?id=1168044
>

OK. So currently, it's not possible to write a policy item which allows
connections to sockets on the loopback interface only.

In that case, I'll work on a patch proposal for a boolean to activate this:
  allow tomcat_t smtp_port_t:tcp_socket name_connect;

-- 
Regards,
Troels Arvin

--00000000000011a542056ad58513
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br><div><div><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_quote">On Fri, Apr 27, 2018 at 4:31 PM, Stephen Smalley <span =
dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@=
tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><span class=3D"gmail-">
</span>See:<br>
<a href=3D"https://github.com/SELinuxProject/selinux-kernel/issues/21" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/<wbr>SELinuxProject/se=
linux-kernel/<wbr>issues/21</a><br>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1168044" rel=3D"no=
referrer" target=3D"_blank">https://bugzilla.redhat.com/<wbr>show_bug.cgi?i=
d=3D1168044</a><br>
</blockquote></div><br></div><div class=3D"gmail_extra">OK. So currently, i=
t&#39;s not possible to write a policy item which allows connections to soc=
kets on the loopback interface only.<br><br></div><div class=3D"gmail_extra=
">In that case, I&#39;ll work on a patch proposal for a boolean to activate=
 this:<br>=C2=A0 allow tomcat_t smtp_port_t:tcp_socket name_connect;<br><br=
>-- <br></div><div class=3D"gmail_extra">Regards,<br>Troels Arvin<br></div>=
<div class=3D"gmail_extra"><br></div></div></div></div>

--00000000000011a542056ad58513--
