Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAE8jjtO010716
	for <selinux@tycho.nsa.gov>; Sat, 14 Nov 2009 03:45:45 -0500
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAE8ljm9003233
	for <selinux@tycho.nsa.gov>; Sat, 14 Nov 2009 08:47:46 GMT
Received: by ey-out-1920.google.com with SMTP id 3so1115986eyh.32
        for <selinux@tycho.nsa.gov>; Sat, 14 Nov 2009 00:45:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <C72058B7.AFD80%csellers@tresys.com>
References: <bb74313d0911110415xf7e6ec7hb0986bf827aa837d@mail.gmail.com>
	 <C72058B7.AFD80%csellers@tresys.com>
Date: Sat, 14 Nov 2009 12:15:42 +0330
Message-ID: <bb74313d0911140045s168c2fddq5870920f44352e28@mail.gmail.com>
Subject: Re: get security_class_t for objects
From: michel m <michel.mcgregor@gmail.com>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=000e0cdfdb1e3a314e047850cda7
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cdfdb1e3a314e047850cda7
Content-Type: text/plain; charset=ISO-8859-1

thanks Chad,
but may you explain your tricky solution a bit more.

Regards.

On Wed, Nov 11, 2009 at 8:34 PM, Chad Sellers <csellers@tresys.com> wrote:

> On 11/11/09 7:15 AM, "michel m" <michel.mcgregor@gmail.com> wrote:
>
> > Hi,
> > as an userspace object manager which uses libselinux, I am trying to use
> > avc_has_perm(3) for determining access decisions. when I open a file, I
> can
> > get its security context and change it to SID by using fgetfilecon(3) and
> > avc_context_to_sid(3), respectively. but when I want to have access
> decision
> > by calling avc_has_perm(3), I am not sure what to pass as the third
> > argument,that is security_class_t. I would like to know if there is any
> API by
> > which I can determine an already opened file`s class. may some one direct
> me
> > to a sample code please
> >
> You generally figure out that third parameter by using
> string_to_security_class() (found in libselinux, discussed in the
> selinux_check_passwd_access thread a few days ago). That will convert a
> string class name to a security_class_t. As far as an API to determine the
> class of an already opened file, fstat() combined with S_ISREG/S_ISDIR/etc.
> should do the trick. A bit more work than you might like, but that's how
> I'd
> do it.
>
> Thanks,
> Chad
>
>

--000e0cdfdb1e3a314e047850cda7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

thanks Chad,<br>but may you explain your tricky solution a bit more.<br><br=
>Regards.<br><br><div class=3D"gmail_quote">On Wed, Nov 11, 2009 at 8:34 PM=
, Chad Sellers <span dir=3D"ltr">&lt;<a href=3D"mailto:csellers@tresys.com"=
>csellers@tresys.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On 11/11/09 7:15 AM, &quot;michel m&quot; &lt;<a href=3D"m=
ailto:michel.mcgregor@gmail.com">michel.mcgregor@gmail.com</a>&gt; wrote:<b=
r>

<br>
&gt; Hi,<br>
&gt; as an userspace object manager which uses libselinux, I am trying to u=
se<br>
&gt; avc_has_perm(3) for determining access decisions. when I open a file, =
I can<br>
&gt; get its security context and change it to SID by using fgetfilecon(3) =
and<br>
&gt; avc_context_to_sid(3), respectively. but when I want to have access de=
cision<br>
&gt; by calling avc_has_perm(3), I am not sure what to pass as the third<br=
>
&gt; argument,that is security_class_t. I would like to know if there is an=
y API by<br>
&gt; which I can determine an already opened file`s class. may some one dir=
ect me<br>
&gt; to a sample code please<br>
&gt;<br>
</div></div>You generally figure out that third parameter by using<br>
string_to_security_class() (found in libselinux, discussed in the<br>
selinux_check_passwd_access thread a few days ago). That will convert a<br>
string class name to a security_class_t. As far as an API to determine the<=
br>
class of an already opened file, fstat() combined with S_ISREG/S_ISDIR/etc.=
<br>
should do the trick. A bit more work than you might like, but that&#39;s ho=
w I&#39;d<br>
do it.<br>
<br>
Thanks,<br>
<font color=3D"#888888">Chad<br>
<br>
</font></blockquote></div><br>

--000e0cdfdb1e3a314e047850cda7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
