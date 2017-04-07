MIME-Version: 1.0
In-Reply-To: <CAFftDdo6uqR3DGwZ8jALYf6k_Cb+-0PPgKr3pgCCQSX28jC87Q@mail.gmail.com>
References: <CAFJ0LnGQPYAxugZfak6az6ruB9Ea8J34nPXQYTUey_YOg4g1BQ@mail.gmail.com>
 <CAK2Cwb50YuP=3aMvYHWofF-=KEdKyPuiCzrp4Cb4sVbjcHuB+A@mail.gmail.com>
 <CAFftDdo6uqR3DGwZ8jALYf6k_Cb+-0PPgKr3pgCCQSX28jC87Q@mail.gmail.com>
From: Tom Jones <thomasclinganjones@gmail.com>
Date: Fri, 7 Apr 2017 11:44:46 -0700
Message-ID: <CAK2Cwb7fk65zr9ouBvayFOBZyWmhvGi8piLNfoaYOdcb93U5vA@mail.gmail.com>
Subject: Re: add CONFIG_SECURITY_SELINUX_LOAD_ONCE
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Nick Kralevich <nnk@google.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 SELinux <Selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c0d8d7c0e9008054c9805a9
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c0d8d7c0e9008054c9805a9
Content-Type: text/plain; charset=UTF-8

I am highly skeptical of policy setting and the supply chain. In the threat
models I create, the supply chain is always the weak, open threat. I could
not begin to guess who the manufacturer of a device is. Android, Samsung,
Verizon or the US Gov't. Is there a threat model for SE Android, or
whatever it is called now?

I looked at the other site and decided it was looking at the technical
problem and not the policy problem at all.

On Fri, Apr 7, 2017 at 11:23 AM, William Roberts <bill.c.roberts@gmail.com>
wrote:

>
>
> On Fri, Apr 7, 2017 at 11:02 AM, Tom Jones <thomasclinganjones@gmail.com>
> wrote:
>
>> I like that, but I wonder at its scope. Would an update to the OS be
>> allowed to update the policy? For example, Microsoft ships updates to the
>> Windows O/S 2 times (at least) per month. Would that type of update to
>> Android allow policy updates?
>>
>
> Part of Android's updates include the policy that is loaded, so the update
> mechanism is in place.
>
>
>>
>> Another question involves the list of authoritative CSPs. That can now be
>> updated in most O/S available on the market. Is that still allowed to be
>> updated, or is that already allowed by policy?
>> ..tom
>>
>
> The policy is updated, currently, as part of the root file system. In a
> feature in progress, TREBLE (FULL_PRODUCT_TREBLE == true), two files, one
> from vendor and one from google are used to
> generate the policy.
>
> essentially, the policy only comes from those making the device, theirs no
> random folks adding/removing policy.
>
>
>>
>> On Fri, Apr 7, 2017 at 10:34 AM, Nick Kralevich <nnk@google.com> wrote:
>>
>>> I wanted to draw people's attention to the following proposed change:
>>>
>>>   https://android-review.googlesource.com/367695
>>>
>>> In the case of Android, it's common for security policy to be loaded
>>> once, and never reloaded again. In that case, the locking / unlocking
>>> surrounding the in-kernel policy is unnecessary and can be avoided. The
>>> patch above turns the locks into no-ops and ensures that the kernel cannot
>>> load a policy more than once. End result is that locking and preemption
>>> overhead is avoided and there's less attack surface / code compiled into
>>> the kernel.
>>>
>>> I would appreciate comments on the change. This feels like a worthwhile
>>> change for the entire SELinux community.
>>>
>>> -- Nick
>>>
>>> --
>>> Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
>>> <(650)%20214-4037>
>>>
>>> _______________________________________________
>>> Seandroid-list mailing list
>>> Seandroid-list@tycho.nsa.gov
>>> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Seandroid-list-request@tycho.nsa.gov.
>>>
>>
>>
>>
>> --
>> ..tom
>>
>> _______________________________________________
>> Seandroid-list mailing list
>> Seandroid-list@tycho.nsa.gov
>> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Seandroid-list-request@tycho.nsa.gov.
>>
>
>
>
> --
> Respectfully,
>
> William C Roberts
>
>


-- 
..tom

--94eb2c0d8d7c0e9008054c9805a9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I am highly skeptical of policy setting and the suppl=
y chain. In the threat models I create, the supply chain is always the weak=
, open threat. I could not begin to guess who the manufacturer of a device =
is. Android, Samsung, Verizon or the US Gov&#39;t. Is there a threat model =
for SE Android, or whatever it is called now?</div><div><br></div><div>I lo=
oked at the other site and decided it was looking at the technical problem =
and not the policy problem at all.</div></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Fri, Apr 7, 2017 at 11:23 AM, William Rober=
ts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=
=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote"><span>On Fri, Apr 7, 2017 at 11:02 AM, Tom Jones <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:thomasclinganjones@gmail.com" target=3D=
"_blank">thomasclinganjones@gmail.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><div dir=3D"ltr"><div>I like that, but I wonder at its s=
cope. Would an update to the OS be allowed to update the policy? For exampl=
e, Microsoft ships updates to the Windows O/S 2 times (at least) per month.=
 Would=C2=A0that type of=C2=A0update to Android allow policy updates?</div>=
</div></blockquote><div><br></div></span><div>Part of Android&#39;s updates=
 include the policy that is loaded, so the update mechanism is in place.</d=
iv><span><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><=
div><br></div><div>Another question involves the list of authoritative CSPs=
. That can now be updated in most O/S available on the market. Is that stil=
l allowed to be updated, or is that already=C2=A0allowed by policy?</div><d=
iv>..tom</div></div></blockquote><div><br></div></span><div>The policy is u=
pdated, currently, as part of the root file system. In a feature in progres=
s, TREBLE (FULL_PRODUCT_TREBLE =3D=3D true), two files, one from vendor and=
 one from google are used to<br>generate the policy.=C2=A0</div><div><br></=
div><div>essentially, the policy only comes from those making the device, t=
heirs no random folks adding/removing policy.</div><span><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex"><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote"><div><div class=3D"m_-8435650962555701363h5">On Fri, Apr 7, 20=
17 at 10:34 AM, Nick Kralevich <span dir=3D"ltr">&lt;<a href=3D"mailto:nnk@=
google.com" target=3D"_blank">nnk@google.com</a>&gt;</span> wrote:<br></div=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div><div class=3D"m_-843565096255570=
1363h5"><div dir=3D"ltr"><div>I wanted to draw people&#39;s attention to th=
e following proposed change:</div><div><br></div><div>=C2=A0=C2=A0<a href=
=3D"https://android-review.googlesource.com/367695" target=3D"_blank">https=
://android-review.googl<wbr>esource.com/367695</a></div><div><br></div><div=
>In the case of Android, it&#39;s common for security policy to be loaded o=
nce, and never reloaded again. In that case, the locking / unlocking surrou=
nding the in-kernel policy is unnecessary and can be avoided. The patch abo=
ve turns the locks into no-ops and ensures that the kernel cannot load a po=
licy more than once. End result is that locking and preemption overhead is =
avoided and there&#39;s less attack surface / code compiled into the kernel=
.</div><div><br></div><div>I would appreciate comments on the change. This =
feels like a worthwhile change for the entire SELinux community.</div><span=
 class=3D"m_-8435650962555701363m_2483744922763063904HOEnZb"><font color=3D=
"#888888"><div><br></div><div>-- Nick</div><div><br></div>-- <br><div class=
=3D"m_-8435650962555701363m_2483744922763063904m_-7124039682513563411gmail_=
signature"><div>Nick Kralevich | Android Security | <a href=3D"mailto:nnk@g=
oogle.com" target=3D"_blank">nnk@google.com</a> | <a href=3D"tel:(650)%2021=
4-4037" target=3D"_blank" value=3D"+16502144037">650.214.4037</a></div></di=
v>
</font></span></div>
<br></div></div><span>______________________________<wbr>_________________<=
br>
Seandroid-list mailing list<br>
<a href=3D"mailto:Seandroid-list@tycho.nsa.gov" target=3D"_blank">Seandroid=
-list@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@tycho.=
nsa.gov" target=3D"_blank">Seandroid-list-leave@tycho.nsa<wbr>.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Seandroid-list-request@tycho.nsa.gov" target=3D"_blank">Seandroid-list-req=
uest@tycho.n<wbr>sa.gov</a>.<br></span></blockquote></div><span class=3D"m_=
-8435650962555701363HOEnZb"><font color=3D"#888888"><br><br clear=3D"all"><=
br>-- <br><div class=3D"m_-8435650962555701363m_2483744922763063904gmail_si=
gnature" data-smartmail=3D"gmail_signature">..tom</div>
</font></span></div>
<br>______________________________<wbr>_________________<br>
Seandroid-list mailing list<br>
<a href=3D"mailto:Seandroid-list@tycho.nsa.gov" target=3D"_blank">Seandroid=
-list@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@tycho.=
nsa.gov" target=3D"_blank">Seandroid-list-leave@tycho.nsa<wbr>.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Seandroid-list-request@tycho.nsa.gov" target=3D"_blank">Seandroid-list-req=
uest@tycho.n<wbr>sa.gov</a>.<br></blockquote></span></div><span class=3D"HO=
EnZb"><font color=3D"#888888"><br><br clear=3D"all"><div><br></div>-- <br><=
div class=3D"m_-8435650962555701363gmail_signature" data-smartmail=3D"gmail=
_signature">Respectfully,<br><br>William C Roberts<br><br></div>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature" data-smartmail=3D"gmail_signature">..tom</div>
</div>

--94eb2c0d8d7c0e9008054c9805a9--
