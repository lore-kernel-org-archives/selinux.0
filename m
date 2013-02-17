MIME-Version: 1.0
In-Reply-To: <511B95E8.9030401@tycho.nsa.gov>
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
 <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
 <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
 <511951CC.1000607@tycho.nsa.gov> <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com>
 <CACcxAnEXkFasdDFKVw8baaXP7bbgx5vndfL=j7dUAsVhrMxxMA@mail.gmail.com>
 <51195783.5080201@tycho.nsa.gov> <CACcxAnHVdep6fkEFxqwt0ZmoPshDVG1PTvNpEEMGEL_gaZ_d8g@mail.gmail.com>
 <51195BFC.3000604@tycho.nsa.gov> <CACcxAnEiKMCS6pHj7cizm83OOhq+Zj4nFh7qSMjDFE78Oz5o9w@mail.gmail.com>
 <CACcxAnEa45SCjEJNxUf_b303-d9QjnyV36nOSBeHQgE6zKP7Bg@mail.gmail.com>
 <511A3B8F.8000702@tycho.nsa.gov> <CACcxAnGeKe_o4oMTZJZuUk+v2NANcQTQODR6ZMo9CJeTQX7uJg@mail.gmail.com>
 <511B95E8.9030401@tycho.nsa.gov>
From: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
Date: Sun, 17 Feb 2013 00:43:46 -0600
Message-ID: <CACcxAnFy6v79Eiz5uA_Ac92c+kuJRhCi3BEw_ZkzG25G4etuSg@mail.gmail.com>
Subject: Re: systemd selinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=bcaec54b45ac82ef6f04d5e5f0c3
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec54b45ac82ef6f04d5e5f0c3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the help, I found the fedora package for policycoreutils and
copied the unit file to make the daemon run in every boot, you said it
wasn't necessary but it would be nice to have working everything I can and
even if I have the time and energy after this getting the gui tools too.
Anyway, I've downloaded the selinux notebook and the first thing I notice
is the change in the directories so I'm running thinking selinux was in
/selinux and no it isn't, should I erase the entry in the fstab or should I
change it to point to /sys/fs/selinux?. Another thing is, I installed an
old policy wich is sysvinit compatible but now I can't boot in enforcing
because it complains about not finding /dev/shm to boot (in permissive is
fine), in the IRC one guy helped me (I'm really sorry, I forgot the
username) and said it could be a policy issue so I should install a new one
either from Fedora's lates packages or from Tresys and then try to create
one based on those. My question is, could that be the issue or should I
search somewhere else?


2013/2/13 Stephen Smalley <sds@tycho.nsa.gov>

> On 02/12/2013 07:53 PM, Brian Iv=E1n Mart=EDnez wrote:
>
>> Ok, I have fixed most of the packages, I just need to update
>> policycoreutils, how can I build it so it is integraded with systemd
>> (maybe create a Unit for restorecond) I only have the package from
>> https://aur.archlinux.org/**packages/selinux-usr-**policycoreutils/<http=
s://aur.archlinux.org/packages/selinux-usr-policycoreutils/>to guide
>> me, but there is an restorecond provided and I'm not sure that will
>> work, everything is implemented to work with sysvinit scripts.
>>
>
> restorecond isn't required for SELinux operation.
>
>


--=20
Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos por que t=
odos
son iguales-- J. Davis

--bcaec54b45ac82ef6f04d5e5f0c3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the help, I found the fedora package for policy=
coreutils and copied the unit file to make the daemon run in every boot, yo=
u said it wasn&#39;t necessary but it would be nice to have working everyth=
ing I can and even if I have the time and energy after this getting the gui=
 tools too. Anyway, I&#39;ve downloaded the selinux notebook and the first =
thing I notice is the change in the directories so I&#39;m running thinking=
 selinux was in /selinux and no it isn&#39;t, should I erase the entry in t=
he fstab or should I change it to point to /sys/fs/selinux?. Another thing =
is, I installed an old policy wich is sysvinit compatible but now I can&#39=
;t boot in enforcing because it complains about not finding /dev/shm to boo=
t (in permissive is fine), in the IRC one guy helped me (I&#39;m really sor=
ry, I forgot the username) and said it could be a policy issue so I should =
install a new one either from Fedora&#39;s lates packages or from Tresys an=
d then try to create one based on those. My question is, could that be the =
issue or should I search somewhere else?<br>

</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2013/2/=
13 Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.go=
v" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span><br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">

<div class=3D"im">On 02/12/2013 07:53 PM, Brian Iv=E1n Mart=EDnez wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Ok, I have fixed most of the packages, I just need to update<br>
policycoreutils, how can I build it so it is integraded with systemd<br>
(maybe create a Unit for restorecond) I only have the package from<br>
<a href=3D"https://aur.archlinux.org/packages/selinux-usr-policycoreutils/"=
 target=3D"_blank">https://aur.archlinux.org/<u></u>packages/selinux-usr-<u=
></u>policycoreutils/</a> to guide<br>
me, but there is an restorecond provided and I&#39;m not sure that will<br>
work, everything is implemented to work with sysvinit scripts.<br>
</blockquote>
<br></div>
restorecond isn&#39;t required for SELinux operation.<br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Ellos se r=EDen de mi p=
or que soy diferente, yo me r=EDo de ellos por que todos son iguales-- J. D=
avis
</div>

--bcaec54b45ac82ef6f04d5e5f0c3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
