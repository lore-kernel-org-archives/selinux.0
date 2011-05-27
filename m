MIME-Version: 1.0
In-Reply-To: <BANLkTik7AS=9J4gXUpORehuEAJxYcizQXA@mail.gmail.com>
References: <BANLkTikr=mJPfq5FJUkL9=s5e4Xn6+WMsw@mail.gmail.com>
	<1306501267.4346.25.camel@localhost.localdomain>
	<BANLkTik7AS=9J4gXUpORehuEAJxYcizQXA@mail.gmail.com>
Date: Fri, 27 May 2011 20:39:03 +0530
Message-ID: <BANLkTi=iwnFcZ8Tsvb8RO_-yn3Ti1RmQyA@mail.gmail.com>
Subject: Re: Regarding SELinux User mapping
From: "c.r.madhusudhanan@gmail.com" <c.r.madhusudhanan@gmail.com>
To: Dominick Grift <domg472@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00032555818a77eec604a44351b4
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00032555818a77eec604a44351b4
Content-Type: text/plain; charset=ISO-8859-1

Hi Guys,

Thanks for the help, I am now able to map SELinux user to the Linux user
after enabling the pam_selinux.


Regards,
Madhu

On Fri, May 27, 2011 at 7:00 PM, c.r.madhusudhanan@gmail.com <
c.r.madhusudhanan@gmail.com> wrote:

> Hello Dominick, Stephen,
>
> Thanks for the quick response. Meego doesnt use pam_selinux by default.
>
> I will try to enable the pam_selinux support, and let you know the result.
> Thanks for the help.
>
> Regards,
> Madhu
>
>
> On Fri, May 27, 2011 at 6:31 PM, Dominick Grift <domg472@gmail.com> wrote:
>
>>
>>
>> On Fri, 2011-05-27 at 18:20 +0530, c.r.madhusudhanan@gmail.com wrote:
>> > Hi All,
>> >
>> > I am trying to map Linux user to different SELinux user (user_u,
>> guest_u,
>> > xguest_u), but when I login it shows only as
>> > system_u:system_r:local_login_t for all users.
>>
>> SElinux uses pam (pam_selinux) to tell login programs what context they
>> should set for a user that logs in, i believe.
>>
>> pam_selinux gets these from /etc/selinux/*/contexts/ { default_contexts
>> users/.* }, i think
>> >
>> > Regards,
>> > Madhu
>>
>
>

--00032555818a77eec604a44351b4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guys,<br><br>Thanks for the help, I am now able to map SELinux user to t=
he Linux user after enabling the pam_selinux.<br><br><br>Regards,<br>Madhu<=
br><br><div class=3D"gmail_quote">On Fri, May 27, 2011 at 7:00 PM, <a href=
=3D"mailto:c.r.madhusudhanan@gmail.com">c.r.madhusudhanan@gmail.com</a> <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:c.r.madhusudhanan@gmail.com">c.r.madhu=
sudhanan@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Hello Dominick, Stephen,<br><br>Thanks for =
the quick response. Meego doesnt use pam_selinux by default.<br><br>I will =
try to enable the pam_selinux support, and let you know the result. Thanks =
for the help.<br>
<br>Regards,<br>
Madhu<div><div></div><div class=3D"h5"><br><br><div class=3D"gmail_quote">O=
n Fri, May 27, 2011 at 6:31 PM, Dominick Grift <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:domg472@gmail.com" target=3D"_blank">domg472@gmail.com</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div><br>
<br>
On Fri, 2011-05-27 at 18:20 +0530, <a href=3D"mailto:c.r.madhusudhanan@gmai=
l.com" target=3D"_blank">c.r.madhusudhanan@gmail.com</a> wrote:<br>
</div><div>&gt; Hi All,<br>
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
</div></div></blockquote></div><br>

--00032555818a77eec604a44351b4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
