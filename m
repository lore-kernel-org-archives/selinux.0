Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4IG3e3J008584
 for <selinux@tycho.nsa.gov>; Sun, 18 May 2014 12:03:40 -0400
Received: by mail-ve0-f180.google.com with SMTP id db12so5372845veb.11
 for <selinux@tycho.nsa.gov>; Sun, 18 May 2014 09:03:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140518104048.GA21381@siphos.be>
References: <CANh19KAN9O-S8VfGYjp8ObGLFsGtSJNXDtwyVvBrYp3U0zPaUw@mail.gmail.com>
 <20140518104048.GA21381@siphos.be>
Date: Sun, 18 May 2014 23:03:40 +0700
Message-ID: <CANh19KAN259pynb3CVgUFRgu+GgTMjqsSy=KwxRKHrL6zgj1jA@mail.gmail.com>
Subject: Re: create new roles for user
From: =?UTF-8?B?dG9hzIluIGN1zIA=?= <xuantoanbkfet@gmail.com>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Content-Type: multipart/alternative; boundary=047d7b677786549df104f9aeca5c
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b677786549df104f9aeca5c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank for your suggestion, very useful for me !!


2014-05-18 17:40 GMT+07:00 Sven Vermeulen <sven.vermeulen@siphos.be>:

> On Sat, May 17, 2014 at 04:26:09PM +0700, toa=CC=89n cu=CC=80 wrote:
> >    Hi all!=C3=82
> >    I just researching policy in selinux, and I am facing an issue when
> >    create new roles for user. I want to add roles for user.=C3=82 =C3=
=82 look
> >    forward your help!
>
> Hi Toa=CC=89n,
>
> SELinux roles are defined through the SELinux policy, so in order to crea=
te
> new roles, you need to create a SELinux policy module that contains the
> proper statements.
>
> With the reference policy, creating roles is not that hard. All that is
> needed is a policy like the following (example for a postgresql
> administration role):
>
> #v+
> policy_module(mypgsqladm, 1.0)
>
> userdom_login_user_template(pgsqladm)
>
> optional_policy(`
>         postgresql_admin(pgsqladm_t, pgsqladm_r)
> ')
> #v-
>
> The call to userdom_login_user_template() creates a role (pgsqladm_r in t=
he
> example) and user domain (pgsqladm_t in the example) that can be used as
> prilary login type (hence the "login" in the template call).
>
> There are other templates available as well, such as
> userdom_base_user_template() for the "basic" role definitions,
> userdom_unpriv_user_template() and userdom_admin_user_template() for
> unprivileged and privileged roles, etc.
>
> Once this policy module is built and loaded, you can use the generated us=
er
> domains and roles. You will need to update files in
> /etc/selinux/*/contexts,
> such as
> - default_type (where pgsqladm_r:pgsqladm_t needs to be added)
> - default_contexts (where the pgsqladm_r related target types will need t=
o
>   be added)
>
> With these changes in place, just assign the role(s) to the users and
> you're
> ready to go.
>
> Wkr,
>         Sven Vermeulen
>



--=20
Mr.Toan-Cu Xuan

School of Electronics and Telecommunications

Hanoi University of Science and Technology

1 Dai Co Viet, Ha noi, Viet nam.

Phone: 01656228762

Email:xuantoanbkfet@gmail.com

--047d7b677786549df104f9aeca5c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Thank for your suggestion,=C2=A0</span><font face=3D"arial, sans-serif">v=
ery useful for me !!</font></div><div class=3D"gmail_extra"><br><br><div cl=
ass=3D"gmail_quote">
2014-05-18 17:40 GMT+07:00 Sven Vermeulen <span dir=3D"ltr">&lt;<a href=3D"=
mailto:sven.vermeulen@siphos.be" target=3D"_blank">sven.vermeulen@siphos.be=
</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Sat, May 17, 2014 at 04:26:09PM +0700, toa=CC=89n cu=CC=80 wrote:<br>
&gt; =C2=A0 =C2=A0Hi all!=C3=82<br>
<div class=3D"">&gt; =C2=A0 =C2=A0I just researching policy in selinux, and=
 I am facing an issue when<br>
</div>&gt; =C2=A0 =C2=A0create new roles for user. I want to add roles for =
user.=C3=82 =C3=82 look<br>
&gt; =C2=A0 =C2=A0forward your help!<br>
<br>
Hi Toa=CC=89n,<br>
<br>
SELinux roles are defined through the SELinux policy, so in order to create=
<br>
new roles, you need to create a SELinux policy module that contains the<br>
proper statements.<br>
<br>
With the reference policy, creating roles is not that hard. All that is<br>
needed is a policy like the following (example for a postgresql<br>
administration role):<br>
<br>
#v+<br>
policy_module(mypgsqladm, 1.0)<br>
<br>
userdom_login_user_template(pgsqladm)<br>
<br>
optional_policy(`<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 postgresql_admin(pgsqladm_t, pgsqladm_r)<br>
&#39;)<br>
#v-<br>
<br>
The call to userdom_login_user_template() creates a role (pgsqladm_r in the=
<br>
example) and user domain (pgsqladm_t in the example) that can be used as<br=
>
prilary login type (hence the &quot;login&quot; in the template call).<br>
<br>
There are other templates available as well, such as<br>
userdom_base_user_template() for the &quot;basic&quot; role definitions,<br=
>
userdom_unpriv_user_template() and userdom_admin_user_template() for<br>
unprivileged and privileged roles, etc.<br>
<br>
Once this policy module is built and loaded, you can use the generated user=
<br>
domains and roles. You will need to update files in /etc/selinux/*/contexts=
,<br>
such as<br>
- default_type (where pgsqladm_r:pgsqladm_t needs to be added)<br>
- default_contexts (where the pgsqladm_r related target types will need to<=
br>
=C2=A0 be added)<br>
<br>
With these changes in place, just assign the role(s) to the users and you&#=
39;re<br>
ready to go.<br>
<br>
Wkr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Sven Vermeulen<br>
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

--047d7b677786549df104f9aeca5c--
