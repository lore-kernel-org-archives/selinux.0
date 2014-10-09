Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s99Lbb0h028053
 for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2014 17:37:37 -0400
Received: by mail-oi0-f43.google.com with SMTP id u20so4521681oif.2
 for <selinux@tycho.nsa.gov>; Thu, 09 Oct 2014 14:37:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1742469.2LKzxieDl0@sifl>
References: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
 <1742469.2LKzxieDl0@sifl>
Date: Thu, 9 Oct 2014 14:37:35 -0700
Message-ID: <CABXk95BY4p1iL3EGq0fCbtcZzq09xwfeYP7RBzqz4_QAhdj4WQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: hooks: Add permission for network MAC address
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=001a113e063ea06fca0505043d3f
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113e063ea06fca0505043d3f
Content-Type: text/plain; charset=UTF-8

Fair enough. I will get back to you regarding other hardware identifiers
that we are considering filtering via ioctl commands.

>From our initial look, it appears that most other hardware identifiers can
be protected with existing selinux permissions. MAC is (thus far) unique in
that many applications need access to the other information provided by
that ioctl.

On Thu, Oct 9, 2014 at 1:20 PM, Paul Moore <paul@paul-moore.com> wrote:

> On Wednesday, October 08, 2014 05:41:42 PM Jeffrey Vander Stoep wrote:
> > First time poster to the list. I would appreciate feedback/suggestions
> > regarding the following patch.
> >
> > This patch which provides SELinux control over network interface MAC
> > addresses. This patch allows access to the MAC address to be controlled
> by
> > policy. Network MAC addresses are a long lived unique device identifier,
> > and a security policy may wish to control access to the identifier
> without
> > further limiting network use, perhaps for privacy reasons.
>
> While I'm not opposed to such access controls, I'd like to see a more
> comprehensive patchset before we commit to support something like this in
> the
> mainline kernel.  Surely network MAC addresses aren't the only hardware
> identifier that one would be concerned about, right?
>
> --
> paul moore
> www.paul-moore.com
>
>

--001a113e063ea06fca0505043d3f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Fair enough. I will get back to you regarding other hardware identifiers =
that we are considering filtering via ioctl commands.=C2=A0<br><br>From our=
 initial look, it appears that most other hardware identifiers can be prote=
cted with existing selinux permissions. MAC is (thus far) unique in that ma=
ny applications need access to the other information provided by that ioctl=
.</span></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Thu, Oct 9, 2014 at 1:20 PM, Paul Moore <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:paul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wednesday,=
 October 08, 2014 05:41:42 PM Jeffrey Vander Stoep wrote:<br>
&gt; First time poster to the list. I would appreciate feedback/suggestions=
<br>
&gt; regarding the following patch.<br>
&gt;<br>
&gt; This patch which provides SELinux control over network interface MAC<b=
r>
&gt; addresses. This patch allows access to the MAC address to be controlle=
d by<br>
&gt; policy. Network MAC addresses are a long lived unique device identifie=
r,<br>
&gt; and a security policy may wish to control access to the identifier wit=
hout<br>
&gt; further limiting network use, perhaps for privacy reasons.<br>
<br>
</span>While I&#39;m not opposed to such access controls, I&#39;d like to s=
ee a more<br>
comprehensive patchset before we commit to support something like this in t=
he<br>
mainline kernel.=C2=A0 Surely network MAC addresses aren&#39;t the only har=
dware<br>
identifier that one would be concerned about, right?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" target=3D"_blank">www.paul-moore.com<=
/a><br>
<br>
</font></span></blockquote></div><br></div>

--001a113e063ea06fca0505043d3f--
