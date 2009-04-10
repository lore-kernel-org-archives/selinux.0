MIME-Version: 1.0
In-Reply-To: <1239290888.22856.54.camel@moss-lions.epoch.ncsc.mil>
References: <1239290888.22856.54.camel@moss-lions.epoch.ncsc.mil>
Date: Fri, 10 Apr 2009 10:53:38 +0500
Message-ID: <e768086c0904092253v50c9405w15f2716aecf75840@mail.gmail.com>
Subject: Re: Problems related to the whole policy infrastructure
From: Kirill Novikov <redbyte.labs@gmail.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001636c5b3526df06204672cfc9c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636c5b3526df06204672cfc9c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If developers would add support of some kind of includes (around 50 lines of
code, fix me if I'm wrong) I think it would make policy easier to read and
edit, but it doesn't solves real problem - complexity to understand what's
really declared in policy and how does rules interfere. I've tried to work
with SLIDE - for sure, it much more handy than vim, but I suppose it would
be ideal (at least for me and an number of my colleagues) to use something
like UML for refpolicy customization.

Regards,

Kirill Novikov,
EastLinux Team

On Thu, Apr 9, 2009 at 8:28 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:

> 1.  Complexity of SELinux policies
>        a.  Inability to create policy abstraction layers
>                i.  If we had to write software the way we write policy,
>                we would have to compile everything in our system into
>                one gigantic, monolithic executable.
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--001636c5b3526df06204672cfc9c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

If developers would add support of some kind of includes (around 50 lines o=
f code, fix me if I&#39;m wrong) I think it would make policy easier to rea=
d and edit, but it doesn&#39;t solves real problem - complexity to understa=
nd what&#39;s really declared in policy and how does rules interfere. I&#39=
;ve tried to work with SLIDE - for sure, it much more handy than vim, but I=
 suppose it would be ideal (at least for me and an number of my colleagues)=
 to use something like UML for refpolicy customization. <br>
<br>Regards,<br><br>Kirill Novikov,<br>EastLinux Team<br><br><div class=3D"=
gmail_quote">On Thu, Apr 9, 2009 at 8:28 PM, James Carter <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov">jwcart2@tycho.nsa.gov</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">1. =A0Complexity =
of SELinux policies<br>
 =A0 =A0 =A0 =A0a. =A0Inability to create policy abstraction layers<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i. =A0If we had to write software the way w=
e write policy,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0we would have to compile everything in our =
system into<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0one gigantic, monolithic executable.<br>
<br>
--<br>
James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov">jwcart2@tycho.nsa=
.gov</a>&gt;<br>
National Security Agency<br>
<font color=3D"#888888"><br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></blockquote></div><br>

--001636c5b3526df06204672cfc9c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
