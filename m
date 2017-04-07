MIME-Version: 1.0
In-Reply-To: <58e7e264.8893620a.b74b6.74d3@mx.google.com>
References: <CAFJ0LnGQPYAxugZfak6az6ruB9Ea8J34nPXQYTUey_YOg4g1BQ@mail.gmail.com>
 <CAK2Cwb50YuP=3aMvYHWofF-=KEdKyPuiCzrp4Cb4sVbjcHuB+A@mail.gmail.com>
 <CAFftDdo6uqR3DGwZ8jALYf6k_Cb+-0PPgKr3pgCCQSX28jC87Q@mail.gmail.com>
 <CAK2Cwb7fk65zr9ouBvayFOBZyWmhvGi8piLNfoaYOdcb93U5vA@mail.gmail.com>
 <CAFftDdob8RRzPoUP--wyywH1xOLwt+iYTOKN49XZUr48Cag9aQ@mail.gmail.com>
 <58e7e264.8893620a.b74b6.74d3@mx.google.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 7 Apr 2017 12:44:40 -0700
Message-ID: <CAFftDdoxKD4Y30ydgv54YFkB0N6xRQ5dWJd24brAHBPWMtS4Fg@mail.gmail.com>
Subject: RE: add CONFIG_SECURITY_SELINUX_LOAD_ONCE
To: thomasclinganjones@gmail.com
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov,
 Nick Kralevich <nnk@google.com>
Content-Type: multipart/alternative; boundary=f40304354d843dd095054c98db9b
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f40304354d843dd095054c98db9b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Apr 7, 2017 12:03, <thomasclinganjones@gmail.com> wrote:

I think you misunderstand the threat. As we found from boot loader and
firmware update attacks, the ways to subvert policy are manifold. How can I
tell who the =E2=80=9Cmanufacturer=E2=80=9D of my android phone that sets t=
he policy really
is and do I trust Android to maintain that trust.

It's part of a signed  image, but it's tied to the trust of that image. An
attacked bootloader or compromise to the kernel subverts the policy. But
we've seen attacks on boot loaders, etc. none of this has anything to do
with the patch nnk submitted.



thx ..tom



*From: *William Roberts <bill.c.roberts@gmail.com>
*Sent: *Friday, April 7, 2017 11:59 AM
*To: *Tom Jones <thomasclinganjones@gmail.com>
*Cc: *seandroid-list@tycho.nsa.gov; selinux@tycho.nsa.gov; Nick Kralevich
<nnk@google.com>
*Subject: *Re: add CONFIG_SECURITY_SELINUX_LOAD_ONCE







On Apr 7, 2017 11:44, "Tom Jones" <thomasclinganjones@gmail.com> wrote:

I am highly skeptical of policy setting and the supply chain. In the threat
models I create, the supply chain is always the weak, open threat. I could
not begin to guess who the manufacturer of a device is. Android, Samsung,
Verizon or the US Gov't. Is there a threat model for SE Android, or
whatever it is called now?



Well SE Android is fully integrated into Android. Vendors create the policy
that ends up the boot image, which is typically signature verified at boot.
If your supply chain is compromised, the selinux policy is your least
concern. Under treble it ends up in different DM verity protected images.







I looked at the other site and decided it was looking at the technical
problem and not the policy problem at all.



On Fri, Apr 7, 2017 at 11:23 AM, William Roberts <bill.c.roberts@gmail.com>
wrote:





On Fri, Apr 7, 2017 at 11:02 AM, Tom Jones <thomasclinganjones@gmail.com>
wrote:

I like that, but I wonder at its scope. Would an update to the OS be
allowed to update the policy? For example, Microsoft ships updates to the
Windows O/S 2 times (at least) per month. Would that type of update to
Android allow policy updates?



Part of Android's updates include the policy that is loaded, so the update
mechanism is in place.





Another question involves the list of authoritative CSPs. That can now be
updated in most O/S available on the market. Is that still allowed to be
updated, or is that already allowed by policy?

..tom



The policy is updated, currently, as part of the root file system. In a
feature in progress, TREBLE (FULL_PRODUCT_TREBLE =3D=3D true), two files, o=
ne
from vendor and one from google are used to
generate the policy.



essentially, the policy only comes from those making the device, theirs no
random folks adding/removing policy.





On Fri, Apr 7, 2017 at 10:34 AM, Nick Kralevich <nnk@google.com> wrote:

I wanted to draw people's attention to the following proposed change:



  https://android-review.googlesource.com/367695



In the case of Android, it's common for security policy to be loaded once,
and never reloaded again. In that case, the locking / unlocking surrounding
the in-kernel policy is unnecessary and can be avoided. The patch above
turns the locks into no-ops and ensures that the kernel cannot load a
policy more than once. End result is that locking and preemption overhead
is avoided and there's less attack surface / code compiled into the kernel.



I would appreciate comments on the change. This feels like a worthwhile
change for the entire SELinux community.



-- Nick



--=20

Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
<(650)%20214-4037>



_______________________________________________
Seandroid-list mailing list
Seandroid-list@tycho.nsa.gov
To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Seandroid-list-request@tycho.nsa.gov.




--=20

..tom


_______________________________________________
Seandroid-list mailing list
Seandroid-list@tycho.nsa.gov
To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Seandroid-list-request@tycho.nsa.gov.





--=20

Respectfully,

William C Roberts



--=20

..tom

--f40304354d843dd095054c98db9b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Apr 7, 2017 12:03,  &lt;<a href=3D"mailto:thomasclinganjones@g=
mail.com">thomasclinganjones@gmail.com</a>&gt; wrote:<br type=3D"attributio=
n"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div lang=3D"EN-US" link=3D"blue" vlink=3D"#954=
F72"><div class=3D"m_3173694954902017510WordSection1"><p class=3D"MsoNormal=
">I think you misunderstand the threat. As we found from boot loader and fi=
rmware update attacks, the ways to subvert policy are manifold. How can I t=
ell who the =E2=80=9Cmanufacturer=E2=80=9D of my android phone that sets th=
e policy really is and do I trust Android to maintain that trust.</p></div>=
</div></blockquote></div></div></div><div dir=3D"auto">It&#39;s part of a s=
igned =C2=A0image, but it&#39;s tied to the trust of that image. An attacke=
d bootloader or compromise to the kernel subverts the policy. But we&#39;ve=
 seen attacks on boot loaders, etc. none of this has anything to do with th=
e patch nnk submitted.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><div lang=3D"EN-US" link=3D"blue" vlink=3D"#954F72"><div class=3D"m_3173=
694954902017510WordSection1"><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p=
><p class=3D"MsoNormal">thx ..tom</p><p class=3D"MsoNormal"><u></u>=C2=A0<u=
></u></p><div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3=
.0pt 0in 0in 0in"><p class=3D"MsoNormal" style=3D"border:none;padding:0in">=
<b>From: </b><a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">=
William Roberts</a><br><b>Sent: </b>Friday, April 7, 2017 11:59 AM<br><b>To=
: </b><a href=3D"mailto:thomasclinganjones@gmail.com" target=3D"_blank">Tom=
 Jones</a><br><b>Cc: </b><a href=3D"mailto:seandroid-list@tycho.nsa.gov" ta=
rget=3D"_blank">seandroid-list@tycho.nsa.gov</a>; <a href=3D"mailto:selinux=
@tycho.nsa.gov" target=3D"_blank">selinux@tycho.nsa.gov</a>; <a href=3D"mai=
lto:nnk@google.com" target=3D"_blank">Nick Kralevich</a><br><b>Subject: </b=
>Re: add CONFIG_SECURITY_SELINUX_LOAD_<wbr>ONCE</p></div><div class=3D"elid=
ed-text"><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p><div><div><p class=
=3D"MsoNormal"><u></u>=C2=A0<u></u></p><div><p class=3D"MsoNormal"><u></u>=
=C2=A0<u></u></p><div><p class=3D"MsoNormal">On Apr 7, 2017 11:44, &quot;To=
m Jones&quot; &lt;<a href=3D"mailto:thomasclinganjones@gmail.com" target=3D=
"_blank">thomasclinganjones@gmail.com</a>&gt; wrote:</p><blockquote style=
=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;m=
argin-left:4.8pt;margin-right:0in"><div><div><p class=3D"MsoNormal">I am hi=
ghly skeptical of policy setting and the supply chain. In the threat models=
 I create, the supply chain is always the weak, open threat. I could not be=
gin to guess who the manufacturer of a device is. Android, Samsung, Verizon=
 or the US Gov&#39;t. Is there a threat model for SE Android, or whatever i=
t is called now?</p></div></div></blockquote></div></div></div><div><p clas=
s=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><p class=3D"MsoNormal">W=
ell SE Android is fully integrated into Android. Vendors create the policy =
that ends up the boot image, which is typically signature verified at boot.=
 If your supply chain is compromised, the selinux policy is your least conc=
ern. Under treble it ends up in different DM verity protected images.</p></=
div><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><p class=
=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><div><div><blockquote sty=
le=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0in 0in 0in 6.0pt=
;margin-left:4.8pt;margin-right:0in"><div><div><p class=3D"MsoNormal"><u></=
u>=C2=A0<u></u></p></div><div><p class=3D"MsoNormal">I looked at the other =
site and decided it was looking at the technical problem and not the policy=
 problem at all.</p></div></div><div><div><p class=3D"MsoNormal"><u></u>=C2=
=A0<u></u></p><div><p class=3D"MsoNormal">On Fri, Apr 7, 2017 at 11:23 AM, =
William Roberts &lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_=
blank">bill.c.roberts@gmail.com</a>&gt; wrote:</p><blockquote style=3D"bord=
er:none;border-left:solid #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-le=
ft:4.8pt;margin-right:0in"><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u>=
</p><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p><div><p class=3D"Ms=
oNormal">On Fri, Apr 7, 2017 at 11:02 AM, Tom Jones &lt;<a href=3D"mailto:t=
homasclinganjones@gmail.com" target=3D"_blank">thomasclinganjones@gmail.com=
</a>&gt; wrote:</p><blockquote style=3D"border:none;border-left:solid #cccc=
cc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in"><div=
><div><p class=3D"MsoNormal">I like that, but I wonder at its scope. Would =
an update to the OS be allowed to update the policy? For example, Microsoft=
 ships updates to the Windows O/S 2 times (at least) per month. Would=C2=A0=
that type of=C2=A0update to Android allow policy updates?</p></div></div></=
blockquote><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><=
p class=3D"MsoNormal">Part of Android&#39;s updates include the policy that=
 is loaded, so the update mechanism is in place.</p></div><div><p class=3D"=
MsoNormal">=C2=A0</p></div><blockquote style=3D"border:none;border-left:sol=
id #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0=
in"><div><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><p =
class=3D"MsoNormal">Another question involves the list of authoritative CSP=
s. That can now be updated in most O/S available on the market. Is that sti=
ll allowed to be updated, or is that already=C2=A0allowed by policy?</p></d=
iv><div><p class=3D"MsoNormal">..tom</p></div></div></blockquote><div><p cl=
ass=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><p class=3D"MsoNormal"=
>The policy is updated, currently, as part of the root file system. In a fe=
ature in progress, TREBLE (FULL_PRODUCT_TREBLE =3D=3D true), two files, one=
 from vendor and one from google are used to<br>generate the policy.=C2=A0<=
/p></div><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><p =
class=3D"MsoNormal">essentially, the policy only comes from those making th=
e device, theirs no random folks adding/removing policy.</p></div><div><p c=
lass=3D"MsoNormal">=C2=A0</p></div><blockquote style=3D"border:none;border-=
left:solid #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin=
-right:0in"><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p><div><div><=
div><p class=3D"MsoNormal">On Fri, Apr 7, 2017 at 10:34 AM, Nick Kralevich =
&lt;<a href=3D"mailto:nnk@google.com" target=3D"_blank">nnk@google.com</a>&=
gt; wrote:</p></div></div><blockquote style=3D"border:none;border-left:soli=
d #cccccc 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0i=
n"><div><div><div><div><p class=3D"MsoNormal">I wanted to draw people&#39;s=
 attention to the following proposed change:</p></div><div><p class=3D"MsoN=
ormal"><u></u>=C2=A0<u></u></p></div><div><p class=3D"MsoNormal">=C2=A0=C2=
=A0<a href=3D"https://android-review.googlesource.com/367695" target=3D"_bl=
ank">https://android-review.<wbr>googlesource.com/367695</a></p></div><div>=
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><div><p class=3D"MsoNo=
rmal">In the case of Android, it&#39;s common for security policy to be loa=
ded once, and never reloaded again. In that case, the locking / unlocking s=
urrounding the in-kernel policy is unnecessary and can be avoided. The patc=
h above turns the locks into no-ops and ensures that the kernel cannot load=
 a policy more than once. End result is that locking and preemption overhea=
d is avoided and there&#39;s less attack surface / code compiled into the k=
ernel.</p></div><div><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><=
div><p class=3D"MsoNormal">I would appreciate comments on the change. This =
feels like a worthwhile change for the entire SELinux community.</p></div><=
div><p class=3D"MsoNormal"><span style=3D"color:#888888"><u></u>=C2=A0<u></=
u></span></p></div><div><p class=3D"MsoNormal"><span style=3D"color:#888888=
">-- Nick<u></u><u></u></span></p></div><div><p class=3D"MsoNormal"><span s=
tyle=3D"color:#888888"><u></u>=C2=A0<u></u></span></p></div><p class=3D"Mso=
Normal"><span class=3D"m_3173694954902017510m113729561397367759m-8435650962=
555701363m2483744922763063904hoenzb"><span style=3D"color:#888888">-- </spa=
n><u></u><u></u></span></p><div><div><p class=3D"MsoNormal"><span style=3D"=
color:#888888">Nick Kralevich | Android Security | <a href=3D"mailto:nnk@go=
ogle.com" target=3D"_blank">nnk@google.com</a> | <a href=3D"tel:(650)%20214=
-4037" target=3D"_blank">650.214.4037</a></span></p></div></div></div><p cl=
ass=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div></div><p class=3D"MsoNormal=
">______________________________<wbr>_________________<br>Seandroid-list ma=
iling list<br><a href=3D"mailto:Seandroid-list@tycho.nsa.gov" target=3D"_bl=
ank">Seandroid-list@tycho.nsa.gov</a><br>To unsubscribe, send email to <a h=
ref=3D"mailto:Seandroid-list-leave@tycho.nsa.gov" target=3D"_blank">Seandro=
id-list-leave@tycho.<wbr>nsa.gov</a>.<br>To get help, send an email contain=
ing &quot;help&quot; to <a href=3D"mailto:Seandroid-list-request@tycho.nsa.=
gov" target=3D"_blank">Seandroid-list-request@tycho.<wbr>nsa.gov</a>.</p></=
blockquote></div><p class=3D"MsoNormal"><span style=3D"color:#888888"><br><=
br clear=3D"all"><br><span class=3D"m_3173694954902017510m11372956139736775=
9m-8435650962555701363hoenzb">-- <u></u><u></u></span></span></p><div><p cl=
ass=3D"MsoNormal"><span style=3D"color:#888888">..tom</span></p></div></div=
><p class=3D"MsoNormal"><br>______________________________<wbr>____________=
_____<br>Seandroid-list mailing list<br><a href=3D"mailto:Seandroid-list@ty=
cho.nsa.gov" target=3D"_blank">Seandroid-list@tycho.nsa.gov</a><br>To unsub=
scribe, send email to <a href=3D"mailto:Seandroid-list-leave@tycho.nsa.gov"=
 target=3D"_blank">Seandroid-list-leave@tycho.<wbr>nsa.gov</a>.<br>To get h=
elp, send an email containing &quot;help&quot; to <a href=3D"mailto:Seandro=
id-list-request@tycho.nsa.gov" target=3D"_blank">Seandroid-list-request@tyc=
ho.<wbr>nsa.gov</a>.</p></blockquote></div><p class=3D"MsoNormal"><span sty=
le=3D"color:#888888"><br><br clear=3D"all"><span class=3D"m_317369495490201=
7510m113729561397367759hoenzb"><u></u><u></u></span></span></p><div><p clas=
s=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div><p class=3D"MsoNormal"><span =
class=3D"m_3173694954902017510m113729561397367759hoenzb"><span style=3D"col=
or:#888888">-- </span><u></u><u></u></span></p><div><p class=3D"MsoNormal" =
style=3D"margin-bottom:12.0pt"><span style=3D"color:#888888">Respectfully,<=
br><br>William C Roberts</span></p></div></div></div></blockquote></div><p =
class=3D"MsoNormal"><br><br clear=3D"all"></p></div><p class=3D"MsoNormal">=
<span style=3D"color:#888888">-- <u></u><u></u></span></p><div><p class=3D"=
MsoNormal"><span style=3D"color:#888888">..tom<u></u><u></u></span></p></di=
v></div></blockquote></div></div></div></div><p class=3D"MsoNormal"><u></u>=
=C2=A0<u></u></p><p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p></div></div=
></div></blockquote></div><br></div></div></div>

--f40304354d843dd095054c98db9b--
