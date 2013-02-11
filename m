MIME-Version: 1.0
In-Reply-To: <CACcxAnEiKMCS6pHj7cizm83OOhq+Zj4nFh7qSMjDFE78Oz5o9w@mail.gmail.com>
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
 <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
 <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
 <511951CC.1000607@tycho.nsa.gov> <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com>
 <CACcxAnEXkFasdDFKVw8baaXP7bbgx5vndfL=j7dUAsVhrMxxMA@mail.gmail.com>
 <51195783.5080201@tycho.nsa.gov> <CACcxAnHVdep6fkEFxqwt0ZmoPshDVG1PTvNpEEMGEL_gaZ_d8g@mail.gmail.com>
 <51195BFC.3000604@tycho.nsa.gov> <CACcxAnEiKMCS6pHj7cizm83OOhq+Zj4nFh7qSMjDFE78Oz5o9w@mail.gmail.com>
From: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
Date: Mon, 11 Feb 2013 17:01:43 -0600
Message-ID: <CACcxAnEa45SCjEJNxUf_b303-d9QjnyV36nOSBeHQgE6zKP7Bg@mail.gmail.com>
Subject: Re: systemd selinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8fb1f500ef255704d57ae6a5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8fb1f500ef255704d57ae6a5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Me bothering again, I'm trying to build libselinux 2.1.12 and in the make
step I get the error undefined pcre_free, pcre_free_study, pcre_compile,
pcre_study and pcre_exec in the file label_file.c , is there a patch to be
applied or configuration needed or a bug?

Thanks again


2013/2/11 Brian Iv=E1n Mart=EDnez <xangelux@gmail.com>

> Ok, I will try it, thanks, I'll be sure to come back if anything happends
>
>
> 2013/2/11 Stephen Smalley <sds@tycho.nsa.gov>
>
>> On 02/11/2013 03:54 PM, Brian Iv=E1n Mart=EDnez wrote:
>>
>>> I'll talk to the maintainer, we are in 2.1.0 right now, I'll see how to
>>> update the package, for libselinux. Any patch that should be added to
>>> the 2.1.9 or any better version?
>>>
>>
>> You should use the latest release from:
>> http://userspace.**selinuxproject.org/trac/wiki/**Releases<http://usersp=
ace.selinuxproject.org/trac/wiki/Releases>
>> which would put you at libselinux 2.1.12.
>>
>>
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

--e89a8fb1f500ef255704d57ae6a5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Me bothering again, I&#39;m trying to build libselinux 2.1=
.12 and in the make step I get the error undefined pcre_free, pcre_free_stu=
dy, pcre_compile, pcre_study and pcre_exec in the file label_file.c , is th=
ere a patch to be applied or configuration needed or a bug?<br>

<br>Thanks again<br></div><div class=3D"gmail_extra"><br><br><div class=3D"=
gmail_quote">2013/2/11 Brian Iv=E1n Mart=EDnez <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:xangelux@gmail.com" target=3D"_blank">xangelux@gmail.com</a>&gt=
;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Ok, I will try it, thanks, =
I&#39;ll be sure to come back if anything happends<br></div><div class=3D"g=
mail_extra">

<div><div class=3D"h5"><br><br><div class=3D"gmail_quote">2013/2/11 Stephen=
 Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=
=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On 02/11/2013 03:54 PM, Brian Iv=E1n Ma=
rt=EDnez wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I&#39;ll talk to the maintainer, we are in 2.1.0 right now, I&#39;ll see ho=
w to<br>
update the package, for libselinux. Any patch that should be added to<br>
the 2.1.9 or any better version?<br>
</blockquote>
<br></div>
You should use the latest release from:<br>
<a href=3D"http://userspace.selinuxproject.org/trac/wiki/Releases" target=
=3D"_blank">http://userspace.<u></u>selinuxproject.org/trac/wiki/<u></u>Rel=
eases</a><br>
which would put you at libselinux 2.1.12.<br>
<br>
<br>
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

--e89a8fb1f500ef255704d57ae6a5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
