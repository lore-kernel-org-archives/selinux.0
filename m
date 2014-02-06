Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s16FFKxl021308
 for <selinux@tycho.nsa.gov>; Thu, 6 Feb 2014 10:15:22 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so2894775qac.17
 for <selinux@tycho.nsa.gov>; Thu, 06 Feb 2014 07:15:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52F351F3.5050801@redhat.com>
References: <CA+KS1kaJu1RarB3X60NZFsoJduYrP4ZD+UnzppeHH9-x+jPYiw@mail.gmail.com>
 <52F351F3.5050801@redhat.com>
From: leo kirotawa <kirotawa@gmail.com>
Date: Thu, 6 Feb 2014 13:14:49 -0200
Message-ID: <CA+KS1kYZU0N8=v_h_NuvkjvjXOV5ZZT3SaDNk-4SoD0RzASU8g@mail.gmail.com>
Subject: Re: audit2allow: invalid binary policy
To: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/alternative; boundary=047d7bdc7810e7ab5f04f1be5661
Cc: SELinux <selinux@tycho.nsa.gov>,
 Fedora SELinux Users <selinux@lists.fedoraproject.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bdc7810e7ab5f04f1be5661
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

It works for me,
thank you for your quick response.



On Thu, Feb 6, 2014 at 7:12 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 02/05/2014 07:07 PM, leo kirotawa wrote:
> > Hi,
> >
> > I'm having issues when use audit2allow in a Z machine with Fedora 19.
> This
> > is the output message it raises:
> >
> > audit2allow -a security: ebitmap: map size 1064 does not match my size =
64
> > (high bit was 595) invalid binary policy
> >
> audit2allow is trying to read policy from the kernel, their might be a bu=
g
> there.
>
> try audit2allow -a -p /etc/selinux/policy/policy.$VERSION
> >
> > As a solution I thought in recompile my whole policy and generate a new
> > /policy/binary, but this time I grabbed a ERROR: (serefpolicy-3.12.1)
> >
> > /usr/bin/checkmodule base.conf -o tmp/base.mod /usr/bin/checkmodule:
> > loading policy configuration from base.conf
> > policy/modules/kernel/domain.te":256:ERROR 'unknown type tape_device_t
> used
> > in transition definition' at token ';' on line 22729: #line 256
> > type_transition unconfined_domain_type device_t:chr_file tape_device_t
> > "ht00"; /usr/bin/checkmodule:  error(s) encountered while parsing
> > configuration make: *** [tmp/base.mod] Error 1
> >
> > Looking in my /dev/ I did not find any 'ht00' device, what makes me
> > suppose maybe it is the problem. Also looking in .te files I saw
> > tape_device_t is defined into storage.te, and in this point I have no
> idea
> > what is cause of this problem or how to fix it.
> >
> > Have you ever seen it before?
> >
> >
> >
> >
> >
> >
> >
> > _______________________________________________ Selinux mailing list
> > Selinux@tycho.nsa.gov To unsubscribe, send email to
> > Selinux-leave@tycho.nsa.gov. To get help, send an email containing
> "help"
> > to Selinux-request@tycho.nsa.gov.
> >
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlLzUfMACgkQrlYvE4MpobOkOACeNXUaLcyJ8V4jPMcGU3rNh/aO
> F0MAoMkeafrYMdf17yvWv/ZUlb3GygyG
> =3Dx/gR
> -----END PGP SIGNATURE-----
>



--=20
----------------------------------------------
Le=F4nidas S. Barbosa (Kirotawa)

--047d7bdc7810e7ab5f04f1be5661
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It works for me, <br>thank you for your quick response.<br=
><br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On=
 Thu, Feb 6, 2014 at 7:12 AM, Daniel J Walsh <span dir=3D"ltr">&lt;<a href=
=3D"mailto:dwalsh@redhat.com" target=3D"_blank">dwalsh@redhat.com</a>&gt;</=
span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<div class=3D"im"><br>
On 02/05/2014 07:07 PM, leo kirotawa wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I&#39;m having issues when use audit2allow in a Z machine with Fedora =
19. This<br>
&gt; is the output message it raises:<br>
&gt;<br>
&gt; audit2allow -a security: ebitmap: map size 1064 does not match my size=
 64<br>
&gt; (high bit was 595) invalid binary policy<br>
&gt;<br>
</div>audit2allow is trying to read policy from the kernel, their might be =
a bug there.<br>
<br>
try audit2allow -a -p /etc/selinux/policy/policy.$VERSION<br>
<div class=3D"im">&gt;<br>
&gt; As a solution I thought in recompile my whole policy and generate a ne=
w<br>
&gt; /policy/binary, but this time I grabbed a ERROR: (serefpolicy-3.12.1)<=
br>
&gt;<br>
&gt; /usr/bin/checkmodule base.conf -o tmp/base.mod /usr/bin/checkmodule:<b=
r>
&gt; loading policy configuration from base.conf<br>
&gt; policy/modules/kernel/domain.te&quot;:256:ERROR &#39;unknown type tape=
_device_t used<br>
&gt; in transition definition&#39; at token &#39;;&#39; on line 22729: #lin=
e 256<br>
&gt; type_transition unconfined_domain_type device_t:chr_file tape_device_t=
<br>
&gt; &quot;ht00&quot;; /usr/bin/checkmodule: =A0error(s) encountered while =
parsing<br>
&gt; configuration make: *** [tmp/base.mod] Error 1<br>
&gt;<br>
&gt; Looking in my /dev/ I did not find any &#39;ht00&#39; device, what mak=
es me<br>
&gt; suppose maybe it is the problem. Also looking in .te files I saw<br>
&gt; tape_device_t is defined into storage.te, and in this point I have no =
idea<br>
&gt; what is cause of this problem or how to fix it.<br>
&gt;<br>
&gt; Have you ever seen it before?<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div>&gt; _______________________________________________ Selinux mailing =
list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a> To =
unsubscribe, send email to<br>
&gt; <a href=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa=
.gov</a>. To get help, send an email containing &quot;help&quot;<br>
&gt; to <a href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@ty=
cho.nsa.gov</a>.<br>
&gt;<br>
<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1<br>
Comment: Using GnuPG with Thunderbird - <a href=3D"http://www.enigmail.net/=
" target=3D"_blank">http://www.enigmail.net/</a><br>
<br>
iEYEARECAAYFAlLzUfMACgkQrlYvE4MpobOkOACeNXUaLcyJ8V4jPMcGU3rNh/aO<br>
F0MAoMkeafrYMdf17yvWv/ZUlb3GygyG<br>
=3Dx/gR<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div>------------------=
----------------------------</div>Le=F4nidas S. Barbosa (Kirotawa)<br><br>
</div>

--047d7bdc7810e7ab5f04f1be5661--
