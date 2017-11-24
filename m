Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAO79MTk004447
 for <selinux@tycho.nsa.gov>; Fri, 24 Nov 2017 02:09:22 -0500
Received: by mail-io0-f182.google.com with SMTP id v21so28718035ioi.4
 for <selinux@tycho.nsa.gov>; Thu, 23 Nov 2017 23:09:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CACikiw0K0ospvKt-midzSPYQegd3GR46mVjhwiPc3eUULV4oUg@mail.gmail.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <CACikiw0K0ospvKt-midzSPYQegd3GR46mVjhwiPc3eUULV4oUg@mail.gmail.com>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Fri, 24 Nov 2017 12:39:05 +0530
Message-ID: <CAPMH7-9UzFWtpCbJwkh5yvaq7G+wPMsB68gzvjpNVgSNn3j76g@mail.gmail.com>
To: Ravi Kumar <nxp.ravi@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113f8cc467d5f5055eb53a06"
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113f8cc467d5f5055eb53a06
Content-Type: text/plain; charset="UTF-8"

Hi Ravi,

Thanks for your reply but SSH and Sysadm_login is already enabled.

Actually I need to change the root context  from*System_u:system_r:unconfined_t
to sysadm_u:sysadm_r or **unconfined_u:**unconfined_r**.*

*I found one command (**runcon
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash**) but that
command will not work after reboot . Is there any parmanent solution for
this.*

On Fri, Nov 24, 2017 at 12:22 PM, Ravi Kumar <nxp.ravi@gmail.com> wrote:

> Based on the config  each type of login ( ssh ,shell  ) will have it own
> role .  if this is just for testing you can try setting the  bool value  if
> you are logging via ssh.
>
> setsebool -P ssh_sysadm_login 1
>
>
>
> Regards,
> Ravi
>
> On Fri, Nov 24, 2017 at 10:47 AM, Aman Sharma <amansh.sharma5@gmail.com>
> wrote:
>
>>
>>
>> Hi All,
>>
>> Currently Working on Cent OS 7.3 and login as a root User and my Id
>> command output is :
>>
>> *id*
>> *uid=0(root) gid=0(root) groups=0(root)
>> context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
>>
>> I want to change *System_u:system_r:unconfined_t to sysadm_u:sysadm_r
>> or **unconfined_u:**unconfined_r**. *
>>
>> *Also showing the output of following command :*
>>
>> *semanage user -l*
>>
>> *                Labeling   MLS/       MLS/                          *
>> *SELinux User    Prefix     MCS Level  MCS Range
>> SELinux Roles*
>>
>> *admin_u         user       s0         s0-s0:c0.c1023
>>  sysadm_r system_r*
>> *guest_u         user       s0         s0
>>  guest_r*
>> *root            user       s0         s0-s0:c0.c1023
>>  staff_r sysadm_r*
>> *specialuser_u   user       s0         s0
>>  sysadm_r system_r*
>> *staff_u         user       s0         s0-s0:c0.c1023
>>  staff_r sysadm_r system_r*
>> *sysadm_u        user       s0         s0-s0:c0.c1023
>>  sysadm_r*
>> *system_u        user       s0         s0-s0:c0.c1023
>>  system_r*
>> *unconfined_u    user       s0         s0-s0:c0.c1023
>>  system_r unconfined_r*
>> *user_u          user       s0         s0
>>  user_r*
>> *xguest_u        user       s0         s0
>>  xguest_r*
>>
>>
>> * semanage login -l*
>>
>> *Login Name           SELinux User         MLS/MCS Range        Service*
>>
>> *__default__          sysadm_u             s0-s0:c0.c1023       **
>> *ccmservice           specialuser_u        s0                   **
>> *cucm                 admin_u              s0-s0:c0.c1023       **
>> *drfkeys              specialuser_u        s0                   **
>> *drfuser              specialuser_u        s0                   **
>> *informix             specialuser_u        s0                   **
>> *pwrecovery           specialuser_u        s0                   **
>> *root                 sysadm_u             s0-s0:c0.c1023       **
>> *sftpuser             specialuser_u        s0                   **
>> *system_u             sysadm_u             s0-s0:c0.c1023       **
>>
>>
>> *Can anybody Please help me.*
>>
>> --
>>
>> Thanks
>> Aman
>> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
>>
>>
>


-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a113f8cc467d5f5055eb53a06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Ravi,=C2=A0<div><br></div><div>Thanks for your reply bu=
t SSH and Sysadm_login is already enabled.=C2=A0</div><div><br></div><div>A=
ctually I need to change the root context=C2=A0 from<b style=3D"color:rgb(8=
0,0,80);font-size:12.8px">System_u:system_r:unconfined_t to sysadm_u:sysadm=
_r or=C2=A0</b><b style=3D"color:rgb(80,0,80);font-size:12.8px">unconfined_=
u:</b><b style=3D"color:rgb(80,0,80);font-size:12.8px">unconfined_r</b><b s=
tyle=3D"color:rgb(80,0,80);font-size:12.8px">.</b></div><div><b style=3D"co=
lor:rgb(80,0,80);font-size:12.8px"><br></b></div><div><b style=3D"color:rgb=
(80,0,80);font-size:12.8px">I found one command (</b><font color=3D"#500050=
"><span style=3D"font-size:12.8px"><b>runcon unconfined_u:unconfined_r:unco=
nfined_t:s0-s0:c0.c1023 /bin/bash</b></span></font><b style=3D"color:rgb(80=
,0,80);font-size:12.8px">) but that command will not work after reboot . Is=
 there any parmanent solution for this.</b></div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Fri, Nov 24, 2017 at 12:22 PM, Rav=
i Kumar <span dir=3D"ltr">&lt;<a href=3D"mailto:nxp.ravi@gmail.com" target=
=3D"_blank">nxp.ravi@gmail.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Based on the config=C2=A0 each type of login=
 ( ssh ,shell=C2=A0 ) will have it own role .=C2=A0 if this is just for tes=
ting you can try setting the=C2=A0 bool value=C2=A0 if you are logging via =
ssh.=C2=A0<div><br><div>setsebool -P ssh_sysadm_login 1<br></div></div><div=
><br></div><div><br></div><div><br></div><div>Regards,<br>Ravi</div></div><=
div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Fri, Nov 24, 2017 at 10:47 AM, Aman Sharma <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:amansh.sharma5@gmail.com" target=3D"_blank=
">amansh.sharma5@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><br><div class=3D"m_-65=
09404784413243435m_-6298651858841528148HOEnZb"><div class=3D"m_-65094047844=
13243435m_-6298651858841528148h5"><div dir=3D"ltr"><div class=3D"gmail_quot=
e"><br><div dir=3D"ltr">Hi All,<div><br></div><div>Currently Working on Cen=
t OS 7.3 and login as a root User and my Id command output is :</div><div><=
b><br></b></div><div><div><b>id</b></div><div><b>uid=3D0(root) gid=3D0(root=
) groups=3D0(root) context=3Dsystem_u:system_r:unco<wbr>nfined_t:s0-s0:c0.c=
1023</b></div><div><b><br></b></div><div>I want to change <b>System_u:syste=
m_r:unconfined_t to sysadm_u:sysadm_r or=C2=A0</b><b>unconfined_u:</b><b>un=
confined_r</b><b>.=C2=A0</b></div><div><b><br></b></div><div><b>Also showin=
g the output of following command :</b></div><div><b><br></b></div><div><di=
v><b>semanage user -l</b></div><div><b><br></b></div><div><b>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Labeling=C2=A0 =C2=A0MLS/=C2=A0 =
=C2=A0 =C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0</b></div><div><b>SELinux Us=
er=C2=A0 =C2=A0 Prefix=C2=A0 =C2=A0 =C2=A0MCS Level=C2=A0 MCS Range=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SELin=
ux Roles</b></div><div><b><br></b></div><div><b>admin_u=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sysadm_r system_r</b></div><div><b>guest_u=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_r</b></div><div><b>root=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0staff_r sysadm_r</b></div><div><b>specialuser_u=
=C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysadm_r system_r</b></div><div><b>st=
aff_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0staff_r sysadm_r system_r</b></div><div><=
b>sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysadm_r</b></div><div><b>system_u=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0system_r</b></div><div><b>unconfined_u=C2=A0 =C2=A0 user=C2=
=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_r unco=
nfined_r</b></div><div><b>user_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=
=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0user_r</b></div><div><b>xguest_u=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xguest_r</b></div><div style=3D"font-weight:=
bold"><br></div></div><div style=3D"font-weight:bold"><br></div><div><div><=
b>=C2=A0semanage login -l</b></div><div><b><br></b></div><div><b>Login Name=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SELinux User=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0MLS/MCS Range=C2=A0 =C2=A0 =C2=A0 =C2=A0 Service</b></div><div=
><b><br></b></div><div><b>__default__=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys=
adm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =
=C2=A0 =C2=A0 =C2=A0*</b></div><div><b>ccmservice=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0specialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*</b></div><div><b>c=
ucm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0admin_u=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s0-s0:c0.c1023=C2=A0 =C2=A0 =
=C2=A0 =C2=A0*</b></div><div><b>drfkeys=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 specialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*</b></div><div><b>drfu=
ser=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 specialuser_u=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*</b></div><div><b>informix=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0specialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*</b></div><div><b>pwre=
covery=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specialuser_u=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*</b></div><div><b>root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0*</b></div><div><b>sftpuser=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specialuser_u=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*</b></div><div><b>system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c10=
23=C2=A0 =C2=A0 =C2=A0 =C2=A0*</b></div><div style=3D"font-weight:bold"><br=
></div></div><div><b><br></b></div><div><b>Can anybody Please help me.</b><=
/div><span class=3D"m_-6509404784413243435HOEnZb"><font color=3D"#888888"><=
span class=3D"m_-6509404784413243435m_-6298651858841528148m_-11914848770396=
42653HOEnZb"><font color=3D"#888888"><div><br></div>-- <br><div class=3D"m_=
-6509404784413243435m_-6298651858841528148m_-1191484877039642653m_-41890620=
23581759453gmail_signature"><div dir=3D"ltr"><div><br></div><div>Thanks</di=
v><div>Aman</div><div>Cell: +91 9990296404 | =C2=A0Email ID : <a href=3D"ma=
ilto:amansh.sharma5@gmail.com" target=3D"_blank">amansh.sharma5@gmail.com</=
a></div></div></div>
</font></span></font></span></div></div>
</div></div></div></div></div><div class=3D"m_-6509404784413243435m_-629865=
1858841528148gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><br></div></div>
</div>
</blockquote></div><br></div>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a113f8cc467d5f5055eb53a06--
