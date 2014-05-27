MIME-Version: 1.0
In-Reply-To: <5384D1EE.7030106@tycho.nsa.gov>
References: <CANh19KBDGC4PPBitWUeFov-=1Mc51wBmfGYf0c3Zuy5-rtJAjA@mail.gmail.com>
 <5384D1EE.7030106@tycho.nsa.gov>
Date: Wed, 28 May 2014 01:22:02 +0700
Message-ID: <CANh19KBO3ujY1z68M7uj-Oh57EtN+B4bd9LoyetFNayoGnwv7g@mail.gmail.com>
Subject: Re: change selinux user's roles
From: =?UTF-8?B?dG9hzIluIGN1zIA=?= <xuantoanbkfet@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=bcaec547c629b7fb6504fa65c5b0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--bcaec547c629b7fb6504fa65c5b0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank for your suggestion! could you tell me detail! or a link relate it!


2014-05-28 0:57 GMT+07:00 Stephen Smalley <sds@tycho.nsa.gov>:

> On 05/27/2014 01:45 PM, toa=CC=89n cu=CC=80 wrote:
> > Hi all!
> >
> > I want to change a selinux user's role
> > Examble:
> >    Linux account: ToanCu and relation with SELinux user staff_u (staff_=
u
> > can access a number of roles staff_r, system_r, unconfiled_r, sysadm_r)
> > when I checked context of user by command *# id,* i have context of
> > selinux user :
> > uid=3D502(ToanCu) gid=3D503(ToanCu) groups=3D503(ToanCu)
> > *context=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023*
> >
> > I want to change the context above to : *context:
> > staff_u:sysadm_r:staff_t:s0-s0:c0.c1023*
> >
> > Look forward your help!
> >
> > Thanks!
>
> newrole -r sysadm_r
>
> or
>
> sudo -r sysadm_r <command>
>
>


--=20
Mr.Toan-Cu Xuan

School of Electronics and Telecommunications

Hanoi University of Science and Technology

1 Dai Co Viet, Ha noi, Viet nam.

Phone: 01656228762

Email:xuantoanbkfet@gmail.com

--bcaec547c629b7fb6504fa65c5b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Thank for your suggestion!=C2=A0</span><font face=3D"arial, sans-serif">c=
ould you tell me detail! or a link relate it!</font></div><div class=3D"gma=
il_extra">
<br><br><div class=3D"gmail_quote">2014-05-28 0:57 GMT+07:00 Stephen Smalle=
y <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_bla=
nk">sds@tycho.nsa.gov</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"">On 05/27/2014 01:45 PM, toa=CC=89n cu=CC=80 wrote:<br>
&gt; Hi all!<br>
&gt;<br>
&gt; I want to change a selinux user&#39;s role<br>
&gt; Examble:<br>
&gt; =C2=A0 =C2=A0Linux account: ToanCu and relation with SELinux user staf=
f_u (staff_u<br>
&gt; can access a number of roles staff_r, system_r, unconfiled_r, sysadm_r=
)<br>
</div>&gt; when I checked context of user by command *# id,* i have context=
 of<br>
<div class=3D"">&gt; selinux user :<br>
&gt; uid=3D502(ToanCu) gid=3D503(ToanCu) groups=3D503(ToanCu)<br>
</div>&gt; *context=3Dstaff_u:staff_r:staff_t:s0-s0:c0.c1023*<br>
&gt;<br>
&gt; I want to change the context above to : *context:<br>
&gt; staff_u:sysadm_r:staff_t:s0-s0:c0.c1023*<br>
<div class=3D"">&gt;<br>
&gt; Look forward your help!<br>
&gt;<br>
&gt; Thanks!<br>
<br>
</div>newrole -r sysadm_r<br>
<br>
or<br>
<br>
sudo -r sysadm_r &lt;command&gt;<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>Mr.Toan-Cu X=
uan<div><p style=3D"font-family:arial,sans-serif;font-size:13px;background-=
color:rgb(255,255,255)">School of Electronics and Telecommunications</p><p =
style=3D"font-family:arial,sans-serif;font-size:13px;background-color:rgb(2=
55,255,255)">
Hanoi University of Science and Technology</p><p style=3D"font-family:arial=
,sans-serif;font-size:13px;background-color:rgb(255,255,255)">1 Dai Co Viet=
, Ha noi, Viet nam.</p><p style=3D"font-family:arial,sans-serif;font-size:1=
3px;background-color:rgb(255,255,255)">
Phone: 01656228762</p><p style=3D"font-family:arial,sans-serif;font-size:13=
px;background-color:rgb(255,255,255)"><a href=3D"mailto:Email%3Axuantoanbkf=
et@gmail.com" target=3D"_blank">Email:xuantoanbkfet@gmail.com</a></p></div>
</div>

--bcaec547c629b7fb6504fa65c5b0--
