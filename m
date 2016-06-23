MIME-Version: 1.0
In-Reply-To: <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
From: Ravi Kumar <nxp.ravi@gmail.com>
Date: Thu, 23 Jun 2016 22:31:27 +0530
Message-ID: <CACikiw0XhrE5+2R-AKHztPjtrAyUUq=uGG28A4vb-E+LYtY_og@mail.gmail.com>
Subject: Re: New rules on restrict kernel module loading
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: seandroid-list@tycho.nsa.gov, SELinux <Selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=089e0115ff3043422e0535f5019d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e0115ff3043422e0535f5019d
Content-Type: text/plain; charset=UTF-8

Hi Jeffrey,
I tried to do the same ,
added the allow rule in system_server as
* allow system_server system_file:system module_load;*

But still seeing issue  as of the wlan.ko is a symlink as below
wlan.ko -> /system/lib/modules/vendor_wlan.ko

Wlan.ko   or  vendor_wlan.ko are with   u:object_r:system_file:s0

But still  i see there is some issue where it show up this denial .

W WifiStateMachin: type=1400 audit(0.0:2074): avc: denied { module_load }
for scontext=u:r:system_server:s0 tcontext=u:r:system_server:s0
tclass=system permissive=0
in the above denial  i see the tcontext as system_server.

I had not debugged much into will do  but looks like there is some thing
which we are missing .

Regards,
Ravi


On Thu, Jun 23, 2016 at 12:32 AM, Jeffrey Vander Stoep <jeffv@google.com>
wrote:

> selinux@tycho.nsa.gov to bcc
>
> Hi Ravi,
>
> The intent is not to restrict which processes may load modules, but to
> place restrictions on the origin of the module itself. Modules, like the
> kernel, should live on a verity protected partition.
>
> If you want system apps to load a kernel module from the system partition
> you just need to add an allow rule. e.g.
>
> # system_app loads /system/lib/module/wlan.ko
> allow system_app system_file:system module_load;
>
> Similar rules may be added for platform_app or system_server.
>
> On Wed, Jun 22, 2016 at 10:43 AM Ravi Kumar <nxp.ravi@gmail.com> wrote:
>
>> Hi team ,
>>
>> I see some new changes  both in kernel and sepolicy project on
>> restricting the load of kernel module  .
>>
>> https://android-review.googlesource.com/#/c/213758/ -- kernel change  on
>> check for moudle_load request  by Jeff
>> https://android-review.googlesource.com/#/c/214021/-- sepolicy change
>> adding the neverallow  on module_load request  by Jeff .
>>
>> As most of the  SoC /OEM has there own KO  which are loaded on run-time
>> detection an mostly running in system_app/system_server/platfrom_app  are
>> there any special guideline here .
>>
>> As an good example  wlan.ko  .
>>
>>
>> Regard,
>> Ravi
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>
>

--089e0115ff3043422e0535f5019d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jeffrey,<div>I tried to do the same ,=C2=A0</div><div><=
div>added the allow rule in system_server as=C2=A0</div><div><span style=3D=
"font-size:12.8px"><i>=C2=A0allow system_server system_file:system module_l=
oad;</i></span></div></div><div><br></div><div>But still seeing issue =C2=
=A0as of the wlan.ko is a symlink as below =C2=A0<br></div><div><div>wlan.k=
o -&gt; /system/lib/modules/vendor_wlan.ko=C2=A0<br></div></div><div><br></=
div><div>Wlan.ko =C2=A0 or =C2=A0vendor_wlan.ko are with =C2=A0=C2=A0u:obje=
ct_r:system_file:s0</div><div><br></div><div>But still =C2=A0i see there is=
 some issue where it show up this denial .</div><div><br></div><div>W WifiS=
tateMachin: type=3D1400 audit(0.0:2074): avc: denied { module_load } for sc=
ontext=3Du:r:system_server:s0 tcontext=3Du:r:system_server:s0 tclass=3Dsyst=
em permissive=3D0<br></div><div>in the above denial =C2=A0i see the tcontex=
t as system_server.</div><div><br></div><div>I had not debugged much into w=
ill do =C2=A0but looks like there is some thing which we are missing .=C2=
=A0</div><div><br></div><div>Regards,</div><div>Ravi</div><div><br></div></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jun 2=
3, 2016 at 12:32 AM, Jeffrey Vander Stoep <span dir=3D"ltr">&lt;<a href=3D"=
mailto:jeffv@google.com" target=3D"_blank">jeffv@google.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><a href=3D"mailto=
:selinux@tycho.nsa.gov" target=3D"_blank">selinux@tycho.nsa.gov</a>=C2=A0to=
 bcc<div><br></div><div>Hi Ravi,</div><div><br></div><div>The intent is not=
 to restrict which processes may load modules, but to place restrictions on=
 the origin of the module itself. Modules, like the kernel, should live on =
a verity protected partition.</div><div><br></div><div>If you want system a=
pps to load a kernel module from the system partition you just need to add =
an allow rule. e.g.</div><div><br></div><div># system_app loads /system/lib=
/module/wlan.ko</div><div>allow system_app system_file:system module_load;<=
br><br>Similar rules may be added for platform_app or system_server.=C2=A0<=
br><br><div class=3D"gmail_quote"><div><div class=3D"h5"><div dir=3D"ltr">O=
n Wed, Jun 22, 2016 at 10:43 AM Ravi Kumar &lt;<a href=3D"mailto:nxp.ravi@g=
mail.com" target=3D"_blank">nxp.ravi@gmail.com</a>&gt; wrote:<br></div></di=
v></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5"><div dir=3D"l=
tr"><div>Hi team ,=C2=A0</div><div><br></div>I see some new changes =C2=A0b=
oth in kernel and sepolicy project on restricting the load of kernel module=
 =C2=A0.=C2=A0<div><br></div><div><a href=3D"https://android-review.googles=
ource.com/#/c/213758/" target=3D"_blank">https://android-review.googlesourc=
e.com/#/c/213758/</a> -- kernel change =C2=A0on check for moudle_load reque=
st =C2=A0by Jeff=C2=A0<br></div><div><a href=3D"https://android-review.goog=
lesource.com/#/c/214021/--" target=3D"_blank">https://android-review.google=
source.com/#/c/214021/--</a> sepolicy change adding the neverallow =C2=A0on=
 module_load request =C2=A0by Jeff .<br></div><div><br></div><div>As most o=
f the =C2=A0SoC /OEM has there own KO =C2=A0which are loaded on run-time de=
tection an mostly running in system_app/system_server/platfrom_app =C2=A0ar=
e there any special guideline here .=C2=A0</div><div><br></div><div>As an g=
ood example =C2=A0wlan.ko =C2=A0.</div><div><br></div><div><br></div><div>R=
egard,</div><div>Ravi=C2=A0</div></div></div></div>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.</blockquote></div></div></div>
</blockquote></div><br></div>

--089e0115ff3043422e0535f5019d--
