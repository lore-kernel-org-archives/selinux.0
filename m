MIME-Version: 1.0
In-Reply-To: <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com>
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
 <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
 <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
 <511951CC.1000607@tycho.nsa.gov> <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com>
From: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
Date: Mon, 11 Feb 2013 14:22:38 -0600
Message-ID: <CACcxAnEXkFasdDFKVw8baaXP7bbgx5vndfL=j7dUAsVhrMxxMA@mail.gmail.com>
Subject: Re: systemd selinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d04463170f40a6104d578adde
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04463170f40a6104d578adde
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I did use the makepkg command to test, should I try to ./configure my self?


2013/2/11 Brian Iv=E1n Mart=EDnez <xangelux@gmail.com>

> the first doesn't display anything and the second displays a 0 (zero)
>
>
> 2013/2/11 Stephen Smalley <sds@tycho.nsa.gov>
>
>> On 02/11/2013 02:31 PM, Brian Iv=E1n Mart=EDnez wrote:
>>
>>> yes, I have a /usr/lib/pkgconfig/libselinux.**pc , mm I'm using a 64bit
>>> system, does that matter?
>>>
>>
>> Don't think so.  I think that is just a difference between Arch and
>> Fedora - 32-bit in /usr/lib32 and 64-bit in /usr/lib vs 32-bit in /usr/l=
ib
>> and 64-bit in /usr/lib64.
>>
>> What does:
>> $ pkg-config --print-errors libselinux
>> $ echo $?
>>
>> display?
>>
>>
>>
>
>
> --
> Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos por que
> todos son iguales-- J. Davis
>



--=20
Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos por que t=
odos
son iguales-- J. Davis

--f46d04463170f40a6104d578adde
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I did use the makepkg command to test, should I try to ./c=
onfigure my self?<br></div><div class=3D"gmail_extra"><br><br><div class=3D=
"gmail_quote">2013/2/11 Brian Iv=E1n Mart=EDnez <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:xangelux@gmail.com" target=3D"_blank">xangelux@gmail.com</a>&g=
t;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">the first doesn&#39;t displ=
ay anything and the second displays a 0 (zero)<br></div><div class=3D"gmail=
_extra">

<div><div class=3D"h5"><br><br><div class=3D"gmail_quote">2013/2/11 Stephen=
 Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=
=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On 02/11/2013 02:31 PM, Brian Iv=E1n Ma=
rt=EDnez wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
yes, I have a /usr/lib/pkgconfig/libselinux.<u></u>pc , mm I&#39;m using a =
64bit<br>
system, does that matter?<br>
</blockquote>
<br></div>
Don&#39;t think so. =A0I think that is just a difference between Arch and F=
edora - 32-bit in /usr/lib32 and 64-bit in /usr/lib vs 32-bit in /usr/lib a=
nd 64-bit in /usr/lib64.<br>
<br>
What does:<br>
$ pkg-config --print-errors libselinux<br>
$ echo $?<br>
<br>
display?<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><br></div></div><div class=3D"im">=
-- <br>Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos po=
r que todos son iguales-- J. Davis
</div></div>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Ellos se r=EDen de mi p=
or que soy diferente, yo me r=EDo de ellos por que todos son iguales-- J. D=
avis
</div>

--f46d04463170f40a6104d578adde--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
