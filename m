Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6IEWNvo017137
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2011 10:32:23 -0400
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6IEWMBX002234
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2011 14:32:22 GMT
Received: by gyg8 with SMTP id 8so1458538gyg.12
        for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2011 07:32:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGFYgbPN41ax88SYosv2e4_RBvc6k3R+hV07vsBiyTZiUreKVw@mail.gmail.com>
References: <CAGFYgbPN41ax88SYosv2e4_RBvc6k3R+hV07vsBiyTZiUreKVw@mail.gmail.com>
Date: Mon, 18 Jul 2011 20:02:22 +0530
Message-ID: <CA+bChDjKBSGYDPCdsDz0OK0z2o8BXmgc74U+r99=E4_Qvc1_Fw@mail.gmail.com>
Subject: Re: is "type poisoning" possible?
From: mohit verma <mohit89mlnc@gmail.com>
To: Zoltan Arnold NAGY <zoltan.arnold.nagy@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf3056303b08ec5e04a858de08
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf3056303b08ec5e04a858de08
Content-Type: text/plain; charset=ISO-8859-1

I think for this type of solution u should have a look at SELinux policy
changin concepts. It supports migrating processes to different security
levels depending on accessing different labeled files.

On Mon, Jul 18, 2011 at 4:15 PM, Zoltan Arnold NAGY <
zoltan.arnold.nagy@gmail.com> wrote:

> Hi,
>
> I apologize in advance if my use of nomenclature is a bit sloppy. I'm
> new to this. :)
>
> Let's say I have a process with type P, but it needs a config file.
>
> Is there a way to specify that if P accesses any file having a type Q, then
> the process type should transition to T?
>
> This would allow to mitigate attacks where specific config changes are
> allowed
> (but are always coupled with a relabeling to type Q), but we don't
> trust the changer.
> A side question would be how to force this relabeling to take place
> automatically?
>
> Thanks,
> Zoltan
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>



-- 
........................
*MOHIT VERMA*

--20cf3056303b08ec5e04a858de08
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think for this type of solution u should have a look at SELinux policy ch=
angin concepts. It supports migrating processes to different security level=
s depending on accessing different labeled files.<br><br><div class=3D"gmai=
l_quote">
On Mon, Jul 18, 2011 at 4:15 PM, Zoltan Arnold NAGY <span dir=3D"ltr">&lt;<=
a href=3D"mailto:zoltan.arnold.nagy@gmail.com">zoltan.arnold.nagy@gmail.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
Hi,<br>
<br>
I apologize in advance if my use of nomenclature is a bit sloppy. I&#39;m<b=
r>
new to this. :)<br>
<br>
Let&#39;s say I have a process with type P, but it needs a config file.<br>
<br>
Is there a way to specify that if P accesses any file having a type Q, then=
<br>
the process type should transition to T?<br>
<br>
This would allow to mitigate attacks where specific config changes are allo=
wed<br>
(but are always coupled with a relabeling to type Q), but we don&#39;t<br>
trust the changer.<br>
A side question would be how to force this relabeling to take place<br>
automatically?<br>
<br>
Thanks,<br>
Zoltan<br>
<font color=3D"#888888"><br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>................=
........<div><i>MOHIT VERMA</i></div><br>

--20cf3056303b08ec5e04a858de08--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
