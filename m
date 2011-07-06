MIME-Version: 1.0
In-Reply-To: <1309528564.31276.26.camel@moss-pluto>
References: <BANLkTinYGbMPaUMmJwMiCkxnBQEvZOd16g@mail.gmail.com>
	<1308920243.15355.55.camel@moss-pluto>
	<BANLkTimkpy3RPkT5Mzg-Uc140KPbEcX4=w@mail.gmail.com>
	<1308924690.15355.72.camel@moss-pluto>
	<BANLkTinSHxgR8nuBgeaPNqoV2aT8GKAa0Q@mail.gmail.com>
	<1309528564.31276.26.camel@moss-pluto>
Date: Wed, 6 Jul 2011 10:14:14 -0400
Message-ID: <CAMfCo-rh+vFmOZogqx-ysZ8O9jqWMjcnoMZ8MYRkWxGq_BxUtQ@mail.gmail.com>
Subject: Re: Wrong context for user
From: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dwalsh@redhat.com, SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016368e23881e796604a767378b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016368e23881e796604a767378b
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jul 1, 2011 at 9:56 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2011-06-24 at 14:44 +0000, c.r.madhusudhanan@gmail.com wrote:
> > Thanks Daniel, Stephen.
> >
> > I am able to get init_t, local_login_t for init, and login
> > respectively.
> > The mistake was tat I missed relabeling the file system, so all the
> > executable was in the type file_t.
> >
> > But it looks my problem still remains somehow, so that when I try
> > login it still shows me wrong domain/type.
> >
> > When I login using 'login' (tty1), the context shows as
> > user_u:user_r:chkpwd_t and when I check in the X (auto login to user
> > 'meego' using 'uxlaunch') shows as user_u:user_r:consoletype_t.
> >
> > Attached is the "ps -aeZ" after relabeling the system.
>
> Going back to this ps output, I think you'll need some policy changes to
> support MeeGo's uxlaunch approach to starting a user desktop.  You need
> uxlaunch to transition into a domain suitable for user login like xdm_t
> (used for gdm/xdm/kdm) rather than running in init_t or we won't get the
> expected transitions for user domains.
>
> Thanks for that, "setfilecon system_u:object_r:xdm_exec_t
/usr/sbin/uxlaunch"
solved context issue in X.


> --
> Stephen Smalley
> National Security Agency
>
>

--0016368e23881e796604a767378b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Jul 1, 2011 at 9:56 AM, Stephen =
Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tych=
o.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On Fri, 2011-06-24 at 14:44 +0000, <a href=3D"mailto:c.r.=
madhusudhanan@gmail.com">c.r.madhusudhanan@gmail.com</a> wrote:<br>
&gt; Thanks Daniel, Stephen.<br>
&gt;<br>
&gt; I am able to get init_t, local_login_t for init, and login<br>
&gt; respectively.<br>
&gt; The mistake was tat I missed relabeling the file system, so all the<br=
>
&gt; executable was in the type file_t.<br>
&gt;<br>
&gt; But it looks my problem still remains somehow, so that when I try<br>
&gt; login it still shows me wrong domain/type.<br>
&gt;<br>
&gt; When I login using &#39;login&#39; (tty1), the context shows as<br>
&gt; user_u:user_r:chkpwd_t and when I check in the X (auto login to user<b=
r>
&gt; &#39;meego&#39; using &#39;uxlaunch&#39;) shows as user_u:user_r:conso=
letype_t.<br>
&gt;<br>
&gt; Attached is the &quot;ps -aeZ&quot; after relabeling the system.<br>
<br>
</div>Going back to this ps output, I think you&#39;ll need some policy cha=
nges to<br>
support MeeGo&#39;s uxlaunch approach to starting a user desktop. =A0You ne=
ed<br>
uxlaunch to transition into a domain suitable for user login like xdm_t<br>
(used for gdm/xdm/kdm) rather than running in init_t or we won&#39;t get th=
e<br>
expected transitions for user domains.<br>
<font color=3D"#888888"><br></font></blockquote><div>Thanks for that,=A0&qu=
ot;setfilecon system_u:object_r:xdm_exec_t /usr/sbin/uxlaunch&quot;=A0</div=
><div>solved context issue in X.=A0</div><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"><div>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex;"><font color=3D"#888888">
--<br>
</font><div><div></div><div class=3D"h5">Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>

--0016368e23881e796604a767378b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
