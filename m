MIME-Version: 1.0
In-Reply-To: <CAFftDdqXCVruri3+49z33CPZYzbtQDqXi_igQTuSmku0qER2-Q@mail.gmail.com>
References: <121365621.6063900.1457189031805.JavaMail.yahoo@mail.yahoo.com>
 <767708561.7764421.1457365274229.JavaMail.yahoo@mail.yahoo.com>
 <56DDCBF6.6010605@tycho.nsa.gov> <56DDE54F.4050208@tycho.nsa.gov>
 <CAFftDdrQaU2jaoTLEbExHL_Qyrqg3XFvpfs=cLsNnxC690yv9A@mail.gmail.com>
 <56DED6C6.4000407@tycho.nsa.gov>
 <CAFftDdq_g07J-0LufxQM+5Bjxmk_LuVhAZ+aXU0zwu=GSjtwVg@mail.gmail.com>
 <56E02EAE.3090505@tycho.nsa.gov>
 <CAFftDdqXCVruri3+49z33CPZYzbtQDqXi_igQTuSmku0qER2-Q@mail.gmail.com>
Date: Wed, 9 Mar 2016 09:12:42 -0800
Message-ID: <CAFftDdpJa=RQcW8Q_buXvGJ=weSQfWZBN8+0BWGc+dz27waNHA@mail.gmail.com>
Subject: Re: initial_sid context via libsepol
From: William Roberts <bill.c.roberts@gmail.com>
To: Nick Kralevich <nnk@google.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=089e01183d1450eafd052da0ce75
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e01183d1450eafd052da0ce75
Content-Type: text/plain; charset=UTF-8

>
> <snip>
>


> I came accross this in build/tools/fs_config/fs_config.c:
>
>
>       char* secontext;
>       if (selabel_lookup(sehnd, &secontext, full_name, ( mode | (is_dir ?
> S_IFDIR : S_IFREG)))) {
>         secontext = strdup("u:object_r:unlabeled:s0");
>       }
>
>       printf(" selabel=%s", secontext);
>       free(full_name);
>       freecon(secontext);
>
>
> commit 0eb17d944704b3eb140bb9dded299d3be3aed77e
> Author: Nick Kralevich <nnk@google.com>
>
> I was just poking around at things to figure out what the intent is.
>
> I am assuming I have something like /foobar, it will fail on labeling
> since their is no match. At which point
> you would want to default to the initial sid for file.
>
> I was investigating how difficult it would be to not hardcode this value
> and retrieve it from sepol, which seems
> like more work than its worth.
>
>
>
Nick this popped up in a discussion recently. I was wondering if you could
shed light on the error path for selabel_loookup() and the conditions
that occur when it takes said path?

Thanks,
Bill

--089e01183d1450eafd052da0ce75
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddi=
ng-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmai=
l_extra">&lt;snip&gt;</div></div></div></blockquote><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding=
-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_=
extra">I came accross this in build/tools/fs_config/fs_config.c:</div><div =
class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><br></div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 char* =
secontext;</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 if (selabel=
_lookup(sehnd, &amp;secontext, full_name, ( mode | (is_dir ? S_IFDIR : S_IF=
REG)))) {</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 secon=
text =3D strdup(&quot;u:object_r:unlabeled:s0&quot;);</div><div class=3D"gm=
ail_extra">=C2=A0 =C2=A0 =C2=A0 }</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 printf(&quot; selabel=3D%s=
&quot;, secontext);</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 fr=
ee(full_name);</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 freecon=
(secontext);</div><div><br></div></div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra">commit 0eb17d944704b3eb140bb9dded299d3be3aed77e=
<br></div><div class=3D"gmail_extra"><div class=3D"gmail_extra">Author: Nic=
k Kralevich &lt;<a href=3D"mailto:nnk@google.com" target=3D"_blank">nnk@goo=
gle.com</a>&gt;</div><div class=3D"gmail_extra"><br></div><div class=3D"gma=
il_extra">I was just poking around at things to figure out what the intent =
is.=C2=A0<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">I am assuming I have something like /foobar, it will fail on labeli=
ng since their is no match. At which point</div><div class=3D"gmail_extra">=
you would want to default to the initial sid for file.</div><div class=3D"g=
mail_extra"><br></div><div class=3D"gmail_extra">I was investigating how di=
fficult it would be to not hardcode this value and retrieve it from sepol, =
which seems</div><div class=3D"gmail_extra">like more work than its worth.<=
/div><span class=3D"HOEnZb"><font color=3D"#888888"><div class=3D"gmail_ext=
ra"><br></div><div class=3D"gmail_extra"><br></div></font></span></div></di=
v></div>
</blockquote></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">Nick this popped up in a discussion recently. I was wondering if yo=
u could shed light on the error path for selabel_loookup() and the conditio=
ns</div><div class=3D"gmail_extra">that occur when it takes said path?</div=
><div class=3D"gmail_extra"><br></div>Thanks,</div><div class=3D"gmail_extr=
a">Bill<br><div class=3D"gmail_signature"><br></div>
</div></div>

--089e01183d1450eafd052da0ce75--
