MIME-Version: 1.0
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
In-Reply-To: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Wed, 22 Jun 2016 19:02:19 +0000
Message-ID: <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
Subject: Re: New rules on restrict kernel module loading
To: Ravi Kumar <nxp.ravi@gmail.com>, seandroid-list@tycho.nsa.gov
Cc: SELinux <Selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c04ca83a42750535e29484
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c04ca83a42750535e29484
Content-Type: text/plain; charset=UTF-8

selinux@tycho.nsa.gov to bcc

Hi Ravi,

The intent is not to restrict which processes may load modules, but to
place restrictions on the origin of the module itself. Modules, like the
kernel, should live on a verity protected partition.

If you want system apps to load a kernel module from the system partition
you just need to add an allow rule. e.g.

# system_app loads /system/lib/module/wlan.ko
allow system_app system_file:system module_load;

Similar rules may be added for platform_app or system_server.

On Wed, Jun 22, 2016 at 10:43 AM Ravi Kumar <nxp.ravi@gmail.com> wrote:

> Hi team ,
>
> I see some new changes  both in kernel and sepolicy project on restricting
> the load of kernel module  .
>
> https://android-review.googlesource.com/#/c/213758/ -- kernel change  on
> check for moudle_load request  by Jeff
> https://android-review.googlesource.com/#/c/214021/-- sepolicy change
> adding the neverallow  on module_load request  by Jeff .
>
> As most of the  SoC /OEM has there own KO  which are loaded on run-time
> detection an mostly running in system_app/system_server/platfrom_app  are
> there any special guideline here .
>
> As an good example  wlan.ko  .
>
>
> Regard,
> Ravi
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.

--001a11c04ca83a42750535e29484
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa=
.gov</a>=C2=A0to bcc<div><br></div><div>Hi Ravi,</div><div><br></div><div>T=
he intent is not to restrict which processes may load modules, but to place=
 restrictions on the origin of the module itself. Modules, like the kernel,=
 should live on a verity protected partition.</div><div><br></div><div>If y=
ou want system apps to load a kernel module from the system partition you j=
ust need to add an allow rule. e.g.</div><div><br></div><div># system_app l=
oads /system/lib/module/wlan.ko</div><div>allow system_app system_file:syst=
em module_load;<br><br>Similar rules may be added for platform_app or syste=
m_server.=C2=A0<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, =
Jun 22, 2016 at 10:43 AM Ravi Kumar &lt;<a href=3D"mailto:nxp.ravi@gmail.co=
m">nxp.ravi@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"ltr"><div>Hi team ,=C2=A0</div><div><br></div>I see some new =
changes =C2=A0both in kernel and sepolicy project on restricting the load o=
f kernel module =C2=A0.=C2=A0<div><br></div><div><a href=3D"https://android=
-review.googlesource.com/#/c/213758/" target=3D"_blank">https://android-rev=
iew.googlesource.com/#/c/213758/</a> -- kernel change =C2=A0on check for mo=
udle_load request =C2=A0by Jeff=C2=A0<br></div><div><a href=3D"https://andr=
oid-review.googlesource.com/#/c/214021/--" target=3D"_blank">https://androi=
d-review.googlesource.com/#/c/214021/--</a> sepolicy change adding the neve=
rallow =C2=A0on module_load request =C2=A0by Jeff .<br></div><div><br></div=
><div>As most of the =C2=A0SoC /OEM has there own KO =C2=A0which are loaded=
 on run-time detection an mostly running in system_app/system_server/platfr=
om_app =C2=A0are there any special guideline here .=C2=A0</div><div><br></d=
iv><div>As an good example =C2=A0wlan.ko =C2=A0.</div><div><br></div><div><=
br></div><div>Regard,</div><div>Ravi=C2=A0</div></div>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.</blockquote></div></div></div>

--001a11c04ca83a42750535e29484--
