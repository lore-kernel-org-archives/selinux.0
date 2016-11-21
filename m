Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uALKn3B1032718
 for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2016 15:49:03 -0500
Received: by mail-wm0-f47.google.com with SMTP id g23so3129237wme.1
 for <selinux@tycho.nsa.gov>; Mon, 21 Nov 2016 12:49:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <557EC809.5050002@tycho.nsa.gov>
References: <1432739005-1955-1-git-send-email-sds@tycho.nsa.gov>
 <20150614053349.GA5191@localhost.localdomain> <557EC809.5050002@tycho.nsa.gov>
From: Nick Kralevich <nnk@google.com>
Date: Mon, 21 Nov 2016 12:48:59 -0800
Message-ID: <CAFJ0LnHTLD74Tatd7N=nY6TDH1wUE-xXukp0_aRXywjVwJ1upQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: Remove unused permission definitions
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1141d4361078480541d5c908
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1141d4361078480541d5c908
Content-Type: text/plain; charset=UTF-8

On Mon, Jun 15, 2015 at 5:41 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 06/14/2015 01:33 AM, Dominick Grift wrote:
> > On Wed, May 27, 2015 at 11:03:25AM -0400, Stephen Smalley wrote:
> >> Remove unused permission definitions from SELinux.
> >> Many of these were only ever used in pre-mainline
> >> versions of SELinux, prior to Linux 2.6.0.  Some of them
> >> were used in the legacy network or compat_net=1 checks
> >> that were disabled by default in Linux 2.6.18 and
> >> fully removed in Linux 2.6.30.
> >>
> >> Permissions never used in mainline Linux:
> >> file swapon
> >
> > I think that blk_file (fixed disk) swapon is actually used in my policy
> by fstools (i think swapon command)
>
> It isn't checked anywhere in the SELinux kernel code, so it might be
> defined in your policy but it has no meaning.  The LSM hook and SELinux
> hook function implementation that applied the check was never merged
> into mainline.
>

Why was the LSM hook and SELinux hook function implementation for swapon
never mainlined?

In particular, without some kind of swapon check, a process with
CAP_SYS_ADMIN could take any readable-writeable file, call swapon on the
file, force swapping, and gain read-write access to another process memory.

Can we try to get these patches mainlined again?



>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

--001a1141d4361078480541d5c908
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Jun 15, 2015 at 5:41 AM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 0=
6/14/2015 01:33 AM, Dominick Grift wrote:<br>
&gt; On Wed, May 27, 2015 at 11:03:25AM -0400, Stephen Smalley wrote:<br>
&gt;&gt; Remove unused permission definitions from SELinux.<br>
&gt;&gt; Many of these were only ever used in pre-mainline<br>
&gt;&gt; versions of SELinux, prior to Linux 2.6.0.=C2=A0 Some of them<br>
&gt;&gt; were used in the legacy network or compat_net=3D1 checks<br>
&gt;&gt; that were disabled by default in Linux 2.6.18 and<br>
&gt;&gt; fully removed in Linux 2.6.30.<br>
&gt;&gt;<br>
&gt;&gt; Permissions never used in mainline Linux:<br>
&gt;&gt; file swapon<br>
&gt;<br>
&gt; I think that blk_file (fixed disk) swapon is actually used in my polic=
y by fstools (i think swapon command)<br>
<br>
</span>It isn&#39;t checked anywhere in the SELinux kernel code, so it migh=
t be<br>
defined in your policy but it has no meaning.=C2=A0 The LSM hook and SELinu=
x<br>
hook function implementation that applied the check was never merged<br>
into mainline.<br></blockquote><div><br></div><div>Why was the LSM hook and=
 SELinux hook function implementation for swapon never mainlined?=C2=A0</di=
v><div><br></div><div>In particular, without some kind of swapon check, a p=
rocess with CAP_SYS_ADMIN could take any readable-writeable file, call swap=
on on the file, force swapping, and gain read-write access to another proce=
ss memory.=C2=A0</div><div><br></div><div>Can we try to get these patches m=
ainlined again?</div><div><br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div>Nick=
 Kralevich | Android Security | <a href=3D"mailto:nnk@google.com" target=3D=
"_blank">nnk@google.com</a> | 650.214.4037</div></div>
</div></div>

--001a1141d4361078480541d5c908--
