Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p59HHasJ013281
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2011 13:17:36 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p59HHaGN005984
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2011 17:17:36 GMT
Received: by iyb26 with SMTP id 26so1951634iyb.12
        for <selinux@tycho.nsa.gov>; Thu, 09 Jun 2011 10:17:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4DEFE619.9080606@tresys.com>
References: <4DEFE619.9080606@tresys.com>
Date: Thu, 9 Jun 2011 13:17:33 -0400
Message-ID: <BANLkTimPvvAB6T=tapuRN_8PvCmarjZ91g@mail.gmail.com>
Subject: Re: SELinux Common Intermediate Language Update
From: Justin Ethier <justin.ethier@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=bcaec5299a75fb1dec04a54aa061
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec5299a75fb1dec04a54aa061
Content-Type: text/plain; charset=ISO-8859-1

The README says that gcc >= 4.5.1 is required, but when building on 4.5.1 I
received the following errors:

    cc1: error: unrecognized command line option
"-Wunused-but-set-parameter"

According to http://gcc.gnu.org/gcc-4.6/changes.html this is a new warning
added in gcc 4.6.
Thanks,

Justin

On Wed, Jun 8, 2011 at 5:14 PM, Steve Lawrence <slawrence@tresys.com> wrote:

> As many of you know, we've been working on the SELinux Common
> Intermediate Language (CIL) compiler for many months now, most recently
> discussed in November of last year [1].
>
> As a refresher, CIL is an intermediate language designed as a policy
> representation that sits between high level policy languages and the
> kernel policy representation. We're happy to answer any questions about
> the language, but for more information, please take a look at the CIL
> Design wiki at http://userspace.selinuxproject.org/trac/wiki/CilDesign
>
> As to the purpose of this email, we've recently reached a pretty
> significant milestone with the compiler, in that it now supports most of
> the features that are currently supported by reference policy (e.g.
> macros, optionals, tunables, etc) as well as the standard SELinux policy
> rules (e.g. allow, type, role, etc). Now that the compiler has reached
> this milestone, we would love for the community to play around with it a
> bit and give us any feedback as we continue on to integration and
> implementing the more advanced features, such has inheritance and
> transforms.
>
> The CIL compiler repository can be downloaded via git:
>
> $ git clone http://oss.tresys.com/git/cil.git
>
> Thanks,
> Steve Lawrence
>
> [1] http://marc.info/?l=selinux&m=128881480827958&w=2
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--bcaec5299a75fb1dec04a54aa061
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The README says that gcc &gt;=3D 4.5.1 is required, but when building on 4.=
5.1 I received the following errors:<div><br></div><div>=A0 =A0 cc1: error:=
 unrecognized command line option &quot;-Wunused-but-set-parameter&quot;<br=
><br>
</div><div>According to=A0<a href=3D"http://gcc.gnu.org/gcc-4.6/changes.htm=
l">http://gcc.gnu.org/gcc-4.6/changes.html</a>=A0this is a new warning adde=
d in gcc 4.6.</div><div>Thanks,</div><div><br></div><div>Justin</div><div><=
br>
<div class=3D"gmail_quote">On Wed, Jun 8, 2011 at 5:14 PM, Steve Lawrence <=
span dir=3D"ltr">&lt;<a href=3D"mailto:slawrence@tresys.com">slawrence@tres=
ys.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
As many of you know, we&#39;ve been working on the SELinux Common<br>
Intermediate Language (CIL) compiler for many months now, most recently<br>
discussed in November of last year [1].<br>
<br>
As a refresher, CIL is an intermediate language designed as a policy<br>
representation that sits between high level policy languages and the<br>
kernel policy representation. We&#39;re happy to answer any questions about=
<br>
the language, but for more information, please take a look at the CIL<br>
Design wiki at <a href=3D"http://userspace.selinuxproject.org/trac/wiki/Cil=
Design" target=3D"_blank">http://userspace.selinuxproject.org/trac/wiki/Cil=
Design</a><br>
<br>
As to the purpose of this email, we&#39;ve recently reached a pretty<br>
significant milestone with the compiler, in that it now supports most of<br=
>
the features that are currently supported by reference policy (e.g.<br>
macros, optionals, tunables, etc) as well as the standard SELinux policy<br=
>
rules (e.g. allow, type, role, etc). Now that the compiler has reached<br>
this milestone, we would love for the community to play around with it a<br=
>
bit and give us any feedback as we continue on to integration and<br>
implementing the more advanced features, such has inheritance and<br>
transforms.<br>
<br>
The CIL compiler repository can be downloaded via git:<br>
<br>
$ git clone <a href=3D"http://oss.tresys.com/git/cil.git" target=3D"_blank"=
>http://oss.tresys.com/git/cil.git</a><br>
<br>
Thanks,<br>
Steve Lawrence<br>
<br>
[1] <a href=3D"http://marc.info/?l=3Dselinux&amp;m=3D128881480827958&amp;w=
=3D2" target=3D"_blank">http://marc.info/?l=3Dselinux&amp;m=3D1288814808279=
58&amp;w=3D2</a><br>
<font color=3D"#888888"><br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></blockquote></div><br></div>

--bcaec5299a75fb1dec04a54aa061--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
