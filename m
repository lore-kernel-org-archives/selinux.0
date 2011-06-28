MIME-Version: 1.0
In-Reply-To: <BANLkTim8At8cS9j85tf-_7RMQ8PgqM+ZgA@mail.gmail.com>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
	<1308920243.15355.55.camel@moss-pluto>
	<BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
	<1308924690.15355.72.camel@moss-pluto>
	<BANLkTinSHxgR8nuBgeaPNqoV2aT8GKAa0Q@mail.gmail.com>
	<1308926890.15355.74.camel@moss-pluto>
	<BANLkTikWc10KFhJEwk9hdJ4e2BbbfcB8BQ@mail.gmail.com>
	<1308928177.15355.76.camel@moss-pluto>
	<BANLkTikJLUuP4g=krqa3wyxh1FF=2E52SA@mail.gmail.com>
	<BANLkTim8At8cS9j85tf-_7RMQ8PgqM+ZgA@mail.gmail.com>
Date: Tue, 28 Jun 2011 11:34:35 -0400
Message-ID: <BANLkTik=8uj1=vo7oHzEq6OmNZ5DKA6MNA@mail.gmail.com>
Subject: Re: Wrong context for user
From: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, dwalsh@redhat.com,
        SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf305f91c2b19f4204a6c767b3
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf305f91c2b19f4204a6c767b3
Content-Type: text/plain; charset=ISO-8859-1

Hi Sam,

Sorry I couldnt reply you earlier, and the issue still remains,

I checked failsafe_context, and it was 'sysadm_r:syadm_t' and when I changed
to
'system_r:initrc_t' as you said, it dint have any effect.


Regards,
Madhu

On Fri, Jun 24, 2011 at 5:26 PM, Sam Gandhi <samgandhi9@gmail.com> wrote:

> On Fri, Jun 24, 2011 at 8:50 AM, c.r.madhusudhanan@gmail.com
> <c.r.madhusudhanan@gmail.com> wrote:
> > [root@localhost utils]# ./getconlist user_u
> > user_u:user_r:consoletype_t
> > [root@localhost utils]# ./getconlist root
> > root:sysadm_r:sysadm_t
> >
> > [root@localhost utils]# ./getseuser meego
> > seuser:  user_u, level (null)
> > Context 0       user_u:user_r:consoletype_t
> > [root@localhost utils]# ./getseuser root
> > seuser:  root, level (null)
> > Context 0       root:sysadm_r:sysadm_t
> > (I dont know but the getseuser dint work until I changed the code
> >  if (argc != 2). )
> >
>
> My guess it is picking up the context from
> /etc/selinux/<context>/contexts/failsafe_context file.
> Does your failsafe_context file have string  system_r:unconfined_t in
> it. For experimental purpose if you change it to system_r:initrc_t you
> will notice that your login session has context of
> root:system_r:initrc_t
>
> Now I don't know SELinux well enough to know if changing the
> failsafe_context file is correct thing to do. You could run getseuser
> through strace and see all the configuration files it examines.
>
> One thing you will notice is SELinux user libraries read & write
> various files in /selinux/ but I haven't found  description of how the
> interface for /selinux/XXX is supposed to work
>
>
> > On Fri, Jun 24, 2011 at 3:09 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> >>
> >> On Fri, 2011-06-24 at 14:52 +0000, c.r.madhusudhanan@gmail.com wrote:
> >> > attached for your reference.
> >>
> >> What do the libselinux/utils say, e.g.:
> >> cd libselinux/utils
> >> ./getconlist user_u system_u:system_r:local_login_t
> >> ./getseuser root system_u:system_r:local_login_t
> >>
> >> --
> >> Stephen Smalley
> >> National Security Agency
> >>
> >
> >
>
> -Sam
>

--20cf305f91c2b19f4204a6c767b3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8">Hi=
 Sam,<div><br></div><div>Sorry I couldnt reply you earlier, and the issue s=
till remains,</div><div><br></div><div>I checked failsafe_context, and it w=
as &#39;sysadm_r:syadm_t&#39; and when I changed to=A0</div>
<div>&#39;system_r:initrc_t&#39; as you said, it dint have any effect.</div=
><div><br></div><div><br></div><div>Regards,</div><div>Madhu</div><br><div =
class=3D"gmail_quote">On Fri, Jun 24, 2011 at 5:26 PM, Sam Gandhi <span dir=
=3D"ltr">&lt;<a href=3D"mailto:samgandhi9@gmail.com">samgandhi9@gmail.com</=
a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">On Fri, Jun 24, 2011 at 8:50 AM, <a href=3D=
"mailto:c.r.madhusudhanan@gmail.com">c.r.madhusudhanan@gmail.com</a><br>
<div class=3D"im">&lt;<a href=3D"mailto:c.r.madhusudhanan@gmail.com">c.r.ma=
dhusudhanan@gmail.com</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; [root@localhost utils]# ./getconlist user_u<br=
>
&gt; user_u:user_r:consoletype_t<br>
&gt; [root@localhost utils]# ./getconlist root<br>
&gt; root:sysadm_r:sysadm_t<br>
&gt;<br>
&gt; [root@localhost utils]# ./getseuser meego<br>
&gt; seuser: =A0user_u, level (null)<br>
&gt; Context 0 =A0 =A0 =A0 user_u:user_r:consoletype_t<br>
&gt; [root@localhost utils]# ./getseuser root<br>
&gt; seuser: =A0root, level (null)<br>
&gt; Context 0 =A0 =A0 =A0 root:sysadm_r:sysadm_t<br>
&gt; (I dont know but the getseuser dint work until I changed the code<br>
&gt; =A0if (argc !=3D 2). )<br>
&gt;<br>
<br>
</div>My guess it is picking up the context from<br>
/etc/selinux/&lt;context&gt;/contexts/failsafe_context file.<br>
Does your failsafe_context file have string =A0system_r:unconfined_t in<br>
it. For experimental purpose if you change it to system_r:initrc_t you<br>
will notice that your login session has context of<br>
root:system_r:initrc_t<br>
<br>
Now I don&#39;t know SELinux well enough to know if changing the<br>
failsafe_context file is correct thing to do. You could run getseuser<br>
through strace and see all the configuration files it examines.<br>
<br>
One thing you will notice is SELinux user libraries read &amp; write<br>
various files in /selinux/ but I haven&#39;t found =A0description of how th=
e<br>
interface for /selinux/XXX is supposed to work<br>
<div><div></div><div class=3D"h5"><br>
<br>
&gt; On Fri, Jun 24, 2011 at 3:09 PM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Fri, 2011-06-24 at 14:52 +0000, <a href=3D"mailto:c.r.madhusudh=
anan@gmail.com">c.r.madhusudhanan@gmail.com</a> wrote:<br>
&gt;&gt; &gt; attached for your reference.<br>
&gt;&gt;<br>
&gt;&gt; What do the libselinux/utils say, e.g.:<br>
&gt;&gt; cd libselinux/utils<br>
&gt;&gt; ./getconlist user_u system_u:system_r:local_login_t<br>
&gt;&gt; ./getseuser root system_u:system_r:local_login_t<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Stephen Smalley<br>
&gt;&gt; National Security Agency<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
<br>
</div></div><font color=3D"#888888">-Sam<br>
</font></blockquote></div><br>

--20cf305f91c2b19f4204a6c767b3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
