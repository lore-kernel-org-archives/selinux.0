MIME-Version: 1.0
In-Reply-To: <1308928177.15355.76.camel@moss-pluto>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
	<1308920243.15355.55.camel@moss-pluto>
	<BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
	<1308924690.15355.72.camel@moss-pluto>
	<BANLkTinSHxgR8nuBgeaPNqoV2aT8GKAa0Q@mail.gmail.com>
	<1308926890.15355.74.camel@moss-pluto>
	<BANLkTikWc10KFhJEwk9hdJ4e2BbbfcB8BQ@mail.gmail.com>
	<1308928177.15355.76.camel@moss-pluto>
Date: Fri, 24 Jun 2011 15:50:05 +0000
Message-ID: <BANLkTikJLUuP4g=krqa3wyxh1FF=2E52SA@mail.gmail.com>
Subject: Re: Wrong context for user
From: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dwalsh@redhat.com, SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf305f91c2c51cc404a67727fd
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf305f91c2c51cc404a67727fd
Content-Type: text/plain; charset=ISO-8859-1

[root@localhost utils]# ./getconlist user_u
user_u:user_r:consoletype_t
[root@localhost utils]# ./getconlist root
root:sysadm_r:sysadm_t

[root@localhost utils]# ./getseuser meego
seuser:  user_u, level (null)
Context 0       user_u:user_r:consoletype_t
[root@localhost utils]# ./getseuser root
seuser:  root, level (null)
Context 0       root:sysadm_r:sysadm_t
(I dont know but the getseuser dint work until I changed the code
 if (argc != 2). )

Regards
Madhu.


On Fri, Jun 24, 2011 at 3:09 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2011-06-24 at 14:52 +0000, c.r.madhusudhanan@gmail.com wrote:
> > attached for your reference.
>
> What do the libselinux/utils say, e.g.:
> cd libselinux/utils
> ./getconlist user_u system_u:system_r:local_login_t
> ./getseuser root system_u:system_r:local_login_t
>
> --
> Stephen Smalley
> National Security Agency
>
>

--20cf305f91c2c51cc404a67727fd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"gI"><span class=3D"go"></span></span>[root@localhost utils]#=
 ./getconlist user_u <br>user_u:user_r:consoletype_t<br>[root@localhost uti=
ls]# ./getconlist root<br>root:sysadm_r:sysadm_t<br><br>[root@localhost uti=
ls]# ./getseuser meego<br>
seuser:=A0 user_u, level (null)<br>Context 0=A0=A0=A0=A0=A0=A0 user_u:user_=
r:consoletype_t<br>[root@localhost utils]# ./getseuser root<br>seuser:=A0 r=
oot, level (null)<br>Context 0=A0=A0=A0=A0=A0=A0 root:sysadm_r:sysadm_t<br>=
(I dont know but the getseuser dint work until I changed the code <br>
=A0if (argc !=3D 2). )<br><br>Regards<br>Madhu.<br><br><br><div class=3D"gm=
ail_quote">On Fri, Jun 24, 2011 at 3:09 PM, Stephen Smalley <span dir=3D"lt=
r">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span=
> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">On Fri, 2011-06-24 at 14:52 +0000, <a href=
=3D"mailto:c.r.madhusudhanan@gmail.com">c.r.madhusudhanan@gmail.com</a> wro=
te:<br>

&gt; attached for your reference.<br>
<br>
What do the libselinux/utils say, e.g.:<br>
cd libselinux/utils<br>
./getconlist user_u system_u:system_r:local_login_t<br>
./getseuser root system_u:system_r:local_login_t<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"h5">Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>

--20cf305f91c2c51cc404a67727fd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
