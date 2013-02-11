MIME-Version: 1.0
In-Reply-To: <511951CC.1000607@tycho.nsa.gov>
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
 <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
 <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
 <511951CC.1000607@tycho.nsa.gov>
From: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
Date: Mon, 11 Feb 2013 14:21:17 -0600
Message-ID: <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com>
Subject: Re: systemd selinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8ff2514a359f5a04d578a9b9
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff2514a359f5a04d578a9b9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

the first doesn't display anything and the second displays a 0 (zero)


2013/2/11 Stephen Smalley <sds@tycho.nsa.gov>

> On 02/11/2013 02:31 PM, Brian Iv=E1n Mart=EDnez wrote:
>
>> yes, I have a /usr/lib/pkgconfig/libselinux.**pc , mm I'm using a 64bit
>> system, does that matter?
>>
>
> Don't think so.  I think that is just a difference between Arch and Fedor=
a
> - 32-bit in /usr/lib32 and 64-bit in /usr/lib vs 32-bit in /usr/lib and
> 64-bit in /usr/lib64.
>
> What does:
> $ pkg-config --print-errors libselinux
> $ echo $?
>
> display?
>
>
>


--=20
Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos por que t=
odos
son iguales-- J. Davis

--e89a8ff2514a359f5a04d578a9b9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">the first doesn&#39;t display anything and the second disp=
lays a 0 (zero)<br></div><div class=3D"gmail_extra"><br><br><div class=3D"g=
mail_quote">2013/2/11 Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mail=
to:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span><br=
>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 02/11/2013 02:31 PM, Br=
ian Iv=E1n Mart=EDnez wrote:<br>
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
</blockquote></div><br><br clear=3D"all"><br>-- <br>Ellos se r=EDen de mi p=
or que soy diferente, yo me r=EDo de ellos por que todos son iguales-- J. D=
avis
</div>

--e89a8ff2514a359f5a04d578a9b9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
