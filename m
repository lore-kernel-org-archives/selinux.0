MIME-Version: 1.0
In-Reply-To: <CAHC9VhR9A6cZT5OxXTf1wyD+z+Er8EXX1Bzz4G5PA6s-=HZ1ag@mail.gmail.com>
References: <1471290132-26336-1-git-send-email-william.c.roberts@intel.com>
 <CAHC9VhR9A6cZT5OxXTf1wyD+z+Er8EXX1Bzz4G5PA6s-=HZ1ag@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 18 Aug 2016 17:27:41 -0700
Message-ID: <CAFftDdquOxV-1jU9Ra5s85KRfq4KOOHzor7if=SfcbR2Sgc=qw@mail.gmail.com>
Subject: Re: [PATCH] selinux: drop SECURITY_SELINUX_POLICYDB_VERSION_MAX
To: Paul Moore <paul@paul-moore.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c19da5c43dc19053a61c44d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c19da5c43dc19053a61c44d
Content-Type: text/plain; charset=UTF-8

On Aug 18, 2016 17:07, "Paul Moore" <paul@paul-moore.com> wrote:
>
> On Mon, Aug 15, 2016 at 3:42 PM,  <william.c.roberts@intel.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Remove the SECURITY_SELINUX_POLICYDB_VERSION_MAX Kconfig option
> >
> > Per: https://github.com/SELinuxProject/selinux/wiki/Kernel-Todo
> >
> > This was only needed on Fedora 3 and 4 and just causes issues now,
> > so drop it.
> >
> > The MAX and MIN should just be whatever the kernel can support.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  security/selinux/Kconfig            | 38
-------------------------------------
> >  security/selinux/include/security.h |  4 ----
> >  2 files changed, 42 deletions(-)
>
> Merged, thanks for the help!

I plan on tinkering with some of the things on that list, hopefully I can
help whittle it down.
>
> --
> paul moore
> www.paul-moore.com
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--94eb2c19da5c43dc19053a61c44d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Aug 18, 2016 17:07, &quot;Paul Moore&quot; &lt;<a href=3D=
"mailto:paul@paul-moore.com">paul@paul-moore.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Aug 15, 2016 at 3:42 PM,=C2=A0 &lt;<a href=3D"mailto:william.c=
.roberts@intel.com">william.c.roberts@intel.com</a>&gt; wrote:<br>
&gt; &gt; From: William Roberts &lt;<a href=3D"mailto:william.c.roberts@int=
el.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Remove the SECURITY_SELINUX_POLICYDB_VERSION_MAX Kconfig option<b=
r>
&gt; &gt;<br>
&gt; &gt; Per: <a href=3D"https://github.com/SELinuxProject/selinux/wiki/Ke=
rnel-Todo">https://github.com/SELinuxProject/selinux/wiki/Kernel-Todo</a><b=
r>
&gt; &gt;<br>
&gt; &gt; This was only needed on Fedora 3 and 4 and just causes issues now=
,<br>
&gt; &gt; so drop it.<br>
&gt; &gt;<br>
&gt; &gt; The MAX and MIN should just be whatever the kernel can support.<b=
r>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c.ro=
berts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 security/selinux/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 38 -------------------------------------<br>
&gt; &gt;=C2=A0 security/selinux/include/security.h |=C2=A0 4 ----<br>
&gt; &gt;=C2=A0 2 files changed, 42 deletions(-)<br>
&gt;<br>
&gt; Merged, thanks for the help!</p>
<p dir=3D"ltr">I plan on tinkering with some of the things on that list, ho=
pefully I can help whittle it down.<br>
&gt;<br>
&gt; --<br>
&gt; paul moore<br>
&gt; <a href=3D"http://www.paul-moore.com">www.paul-moore.com</a><br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>=
</p>

--94eb2c19da5c43dc19053a61c44d--
