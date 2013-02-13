MIME-Version: 1.0
In-Reply-To: <511A3B8F.8000702@tycho.nsa.gov>
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
 <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
 <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
 <511951CC.1000607@tycho.nsa.gov> <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com>
 <CACcxAnEXkFasdDFKVw8baaXP7bbgx5vndfL=j7dUAsVhrMxxMA@mail.gmail.com>
 <51195783.5080201@tycho.nsa.gov> <CACcxAnHVdep6fkEFxqwt0ZmoPshDVG1PTvNpEEMGEL_gaZ_d8g@mail.gmail.com>
 <51195BFC.3000604@tycho.nsa.gov> <CACcxAnEiKMCS6pHj7cizm83OOhq+Zj4nFh7qSMjDFE78Oz5o9w@mail.gmail.com>
 <CACcxAnEa45SCjEJNxUf_b303-d9QjnyV36nOSBeHQgE6zKP7Bg@mail.gmail.com> <511A3B8F.8000702@tycho.nsa.gov>
From: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
Date: Tue, 12 Feb 2013 18:53:19 -0600
Message-ID: <CACcxAnGeKe_o4oMTZJZuUk+v2NANcQTQODR6ZMo9CJeTQX7uJg@mail.gmail.com>
Subject: Re: systemd selinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8fb1f500dfb02204d59093a3
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8fb1f500dfb02204d59093a3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ok, I have fixed most of the packages, I just need to update
policycoreutils, how can I build it so it is integraded with systemd (maybe
create a Unit for restorecond) I only have the package from
https://aur.archlinux.org/packages/selinux-usr-policycoreutils/ to guide
me, but there is an restorecond provided and I'm not sure that will work,
everything is implemented to work with sysvinit scripts.


2013/2/12 Stephen Smalley <sds@tycho.nsa.gov>

> On 02/11/2013 06:01 PM, Brian Iv=E1n Mart=EDnez wrote:
>
>> Me bothering again, I'm trying to build libselinux 2.1.12 and in the
>> make step I get the error undefined pcre_free, pcre_free_study,
>> pcre_compile, pcre_study and pcre_exec in the file label_file.c , is
>> there a patch to be applied or configuration needed or a bug?
>>
>
> Requires libpcre.
>
>


--=20
Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos por que t=
odos
son iguales-- J. Davis

--e89a8fb1f500dfb02204d59093a3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ok, I have fixed most of the packages, I just need to upda=
te policycoreutils, how can I build it so it is integraded with systemd (ma=
ybe create a Unit for restorecond) I only have the package from <a href=3D"=
https://aur.archlinux.org/packages/selinux-usr-policycoreutils/">https://au=
r.archlinux.org/packages/selinux-usr-policycoreutils/</a> to guide me, but =
there is an restorecond provided and I&#39;m not sure that will work, every=
thing is implemented to work with sysvinit scripts.<br>

</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2013/2/=
12 Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.go=
v" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span><br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">

<div class=3D"im">On 02/11/2013 06:01 PM, Brian Iv=E1n Mart=EDnez wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Me bothering again, I&#39;m trying to build libselinux 2.1.12 and in the<br=
>
make step I get the error undefined pcre_free, pcre_free_study,<br>
pcre_compile, pcre_study and pcre_exec in the file label_file.c , is<br>
there a patch to be applied or configuration needed or a bug?<br>
</blockquote>
<br></div>
Requires libpcre.<br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Ellos se r=EDen de mi p=
or que soy diferente, yo me r=EDo de ellos por que todos son iguales-- J. D=
avis
</div>

--e89a8fb1f500dfb02204d59093a3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
