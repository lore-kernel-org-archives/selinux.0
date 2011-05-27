MIME-Version: 1.0
In-Reply-To: <1306501267.4346.25.camel@localhost.localdomain>
References: <BANLkTikr=mJPfq5FJUkL9=s5e4Xn6+WMsw@mail.gmail.com>
	<1306501267.4346.25.camel@localhost.localdomain>
Date: Fri, 27 May 2011 19:00:06 +0530
Message-ID: <BANLkTik7AS=9J4gXUpORehuEAJxYcizQXA@mail.gmail.com>
Subject: Re: Regarding SELinux User mapping
From: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
To: Dominick Grift <domg472@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00151743fa569bb5e104a441ef39
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00151743fa569bb5e104a441ef39
Content-Type: text/plain; charset=ISO-8859-1

Hello Dominick, Stephen,

Thanks for the quick response. Meego doesnt use pam_selinux by default.

I will try to enable the pam_selinux support, and let you know the result.
Thanks for the help.

Regards,
Madhu

On Fri, May 27, 2011 at 6:31 PM, Dominick Grift <domg472@gmail.com> wrote:

>
>
> On Fri, 2011-05-27 at 18:20 +0530, c.r.madhusudhanan@gmail.com wrote:
> > Hi All,
> >
> > I am trying to map Linux user to different SELinux user (user_u, guest_u,
> > xguest_u), but when I login it shows only as
> > system_u:system_r:local_login_t for all users.
>
> SElinux uses pam (pam_selinux) to tell login programs what context they
> should set for a user that logs in, i believe.
>
> pam_selinux gets these from /etc/selinux/*/contexts/ { default_contexts
> users/.* }, i think
> >
> > Regards,
> > Madhu
>

--00151743fa569bb5e104a441ef39
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Dominick, Stephen,<br><br>Thanks for the quick response. Meego doesnt=
 use pam_selinux by default.<br><br>I will try to enable the pam_selinux su=
pport, and let you know the result. Thanks for the help.<br><br>Regards,<br=
>
Madhu<br><br><div class=3D"gmail_quote">On Fri, May 27, 2011 at 6:31 PM, Do=
minick Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:domg472@gmail.com">dom=
g472@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im"><br>
<br>
On Fri, 2011-05-27 at 18:20 +0530, <a href=3D"mailto:c.r.madhusudhanan@gmai=
l.com">c.r.madhusudhanan@gmail.com</a> wrote:<br>
</div><div class=3D"im">&gt; Hi All,<br>
&gt;<br>
&gt; I am trying to map Linux user to different SELinux user (user_u, guest=
_u,<br>
&gt; xguest_u), but when I login it shows only as<br>
&gt; system_u:system_r:local_login_t for all users.<br>
<br>
</div>SElinux uses pam (pam_selinux) to tell login programs what context th=
ey<br>
should set for a user that logs in, i believe.<br>
<br>
pam_selinux gets these from /etc/selinux/*/contexts/ { default_contexts<br>
users/.* }, i think<br>
&gt;<br>
&gt; Regards,<br>
&gt; Madhu<br>
</blockquote></div><br>

--00151743fa569bb5e104a441ef39--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
