MIME-Version: 1.0
In-Reply-To: <51238001.5030804@tycho.nsa.gov>
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com>
 <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com>
 <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com>
 <511951CC.1000607@tycho.nsa.gov> <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com>
 <CACcxAnEXkFasdDFKVw8baaXP7bbgx5vndfL=j7dUAsVhrMxxMA@mail.gmail.com>
 <51195783.5080201@tycho.nsa.gov> <CACcxAnHVdep6fkEFxqwt0ZmoPshDVG1PTvNpEEMGEL_gaZ_d8g@mail.gmail.com>
 <51195BFC.3000604@tycho.nsa.gov> <CACcxAnEiKMCS6pHj7cizm83OOhq+Zj4nFh7qSMjDFE78Oz5o9w@mail.gmail.com>
 <CACcxAnEa45SCjEJNxUf_b303-d9QjnyV36nOSBeHQgE6zKP7Bg@mail.gmail.com>
 <511A3B8F.8000702@tycho.nsa.gov> <CACcxAnGeKe_o4oMTZJZuUk+v2NANcQTQODR6ZMo9CJeTQX7uJg@mail.gmail.com>
 <511B95E8.9030401@tycho.nsa.gov> <CACcxAnFy6v79Eiz5uA_Ac92c+kuJRhCi3BEw_ZkzG25G4etuSg@mail.gmail.com>
 <51238001.5030804@tycho.nsa.gov>
From: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
Date: Tue, 19 Feb 2013 09:20:48 -0600
Message-ID: <CACcxAnENXUM4Jm4izmt1JN8_wzdr-kERvq4qr+9UhSBW-P20OA@mail.gmail.com>
Subject: Re: systemd selinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=bcaec54b45ac4688bf04d615654f
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec54b45ac4688bf04d615654f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks Stephen, I think it is policy related, I'm too new to this so I
better find some time to read the selinux notebook and learn about policies
before asking stupid questions, anything you recommend?


2013/2/19 Stephen Smalley <sds@tycho.nsa.gov>

> On 02/17/2013 01:43 AM, Brian Iv=E1n Mart=EDnez wrote:
>
>> Thanks for the help, I found the fedora package for policycoreutils and
>> copied the unit file to make the daemon run in every boot, you said it
>> wasn't necessary but it would be nice to have working everything I can
>> and even if I have the time and energy after this getting the gui tools
>> too. Anyway, I've downloaded the selinux notebook and the first thing I
>> notice is the change in the directories so I'm running thinking selinux
>> was in /selinux and no it isn't, should I erase the entry in the fstab
>> or should I change it to point to /sys/fs/selinux?. Another thing is, I
>> installed an old policy wich is sysvinit compatible but now I can't boot
>> in enforcing because it complains about not finding /dev/shm to boot (in
>> permissive is fine), in the IRC one guy helped me (I'm really sorry, I
>> forgot the username) and said it could be a policy issue so I should
>> install a new one either from Fedora's lates packages or from Tresys and
>> then try to create one based on those. My question is, could that be the
>> issue or should I search somewhere else?
>>
>
> You don't need it in fstab because systemd calls libselinux
> selinux_init_load_policy() which will automatically try to mount selinuxf=
s
> on /sys/fs/selinux first, and then fall back to /selinux if that director=
y
> does not exist (which would be the case on older kernels).
>
> Updating to a recent policy certainly wouldn't hurt.  But for policy
> issues, you should:
> a) post your actual denials,
> b) take your questions to the refpolicy list,
> http://oss.tresys.com/mailman/**listinfo/refpolicy<http://oss.tresys.com/=
mailman/listinfo/refpolicy>
>
>


--=20
Ellos se r=EDen de mi por que soy diferente, yo me r=EDo de ellos por que t=
odos
son iguales-- J. Davis

--bcaec54b45ac4688bf04d615654f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Stephen, I think it is policy related, I&#39;m too =
new to this so I better find some time to read the selinux notebook and lea=
rn about policies before asking stupid questions, anything you recommend?<b=
r>

</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2013/2/=
19 Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.go=
v" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span><br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">

<div class=3D"im">On 02/17/2013 01:43 AM, Brian Iv=E1n Mart=EDnez wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Thanks for the help, I found the fedora package for policycoreutils and<br>
copied the unit file to make the daemon run in every boot, you said it<br>
wasn&#39;t necessary but it would be nice to have working everything I can<=
br>
and even if I have the time and energy after this getting the gui tools<br>
too. Anyway, I&#39;ve downloaded the selinux notebook and the first thing I=
<br>
notice is the change in the directories so I&#39;m running thinking selinux=
<br>
was in /selinux and no it isn&#39;t, should I erase the entry in the fstab<=
br>
or should I change it to point to /sys/fs/selinux?. Another thing is, I<br>
installed an old policy wich is sysvinit compatible but now I can&#39;t boo=
t<br>
in enforcing because it complains about not finding /dev/shm to boot (in<br=
>
permissive is fine), in the IRC one guy helped me (I&#39;m really sorry, I<=
br>
forgot the username) and said it could be a policy issue so I should<br>
install a new one either from Fedora&#39;s lates packages or from Tresys an=
d<br>
then try to create one based on those. My question is, could that be the<br=
>
issue or should I search somewhere else?<br>
</blockquote>
<br></div>
You don&#39;t need it in fstab because systemd calls libselinux selinux_ini=
t_load_policy() which will automatically try to mount selinuxfs on /sys/fs/=
selinux first, and then fall back to /selinux if that directory does not ex=
ist (which would be the case on older kernels).<br>


<br>
Updating to a recent policy certainly wouldn&#39;t hurt. =A0But for policy =
issues, you should:<br>
a) post your actual denials,<br>
b) take your questions to the refpolicy list,<br>
<a href=3D"http://oss.tresys.com/mailman/listinfo/refpolicy" target=3D"_bla=
nk">http://oss.tresys.com/mailman/<u></u>listinfo/refpolicy</a><br>
<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Ellos se r=EDen de mi p=
or que soy diferente, yo me r=EDo de ellos por que todos son iguales-- J. D=
avis
</div>

--bcaec54b45ac4688bf04d615654f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
