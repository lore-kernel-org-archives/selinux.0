MIME-Version: 1.0
In-Reply-To: <4A8AEE9E.1020102@redhat.com>
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com>
	 <1250521053.3629.117.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170755n2f5df6c2h3ca57faff998e6d6@mail.gmail.com>
	 <81092d890908171338j36a27012h3b87c5828f1d24ab@mail.gmail.com>
	 <1250597961.3629.209.camel@moss-pluto.epoch.ncsc.mil>
	 <1250599197.3629.210.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908181015j71ce6b62tdc5f5251220d84a9@mail.gmail.com>
	 <4A8AEE9E.1020102@redhat.com>
Date: Tue, 18 Aug 2009 11:57:25 -0700
Message-ID: <47aa07810908181157s6e164724oaf32e9ead4d1be30@mail.gmail.com>
Subject: Re: checking user status
From: Larry <selinux@8martialartsforhealth.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Larry Ross <selinux.larry@gmail.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Steve Grubb <sgrubb@redhat.com>
Content-Type: multipart/alternative; boundary=0016364eda1cdae98504716f1634
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364eda1cdae98504716f1634
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Tue, Aug 18, 2009 at 11:10 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:

>  On 08/18/2009 01:15 PM, Larry Ross wrote:
> > On Tue, Aug 18, 2009 at 5:39 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> >
> >> On Tue, 2009-08-18 at 08:19 -0400, Stephen Smalley wrote:
> >>> If this is another manifestation of the same problem, then the easiest
> >>> approach would be to grab the libselinux .src.rpm, patch
> >>> libselinux/src/checkAccess.c to syslog() a message whenever there is a
> >>> denial, build and install your patched libselinux, and then retry and
> >>> look for the log message.
> >>
> >> Something like this patch (un-tested, against the current upstream
> >> libselinux):
> >>
> >> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> >> index c1982c7..cae1626 100644
> >> --- a/libselinux/src/checkAccess.c
> >> +++ b/libselinux/src/checkAccess.c
> >> @@ -2,6 +2,7 @@
> >>  #include <sys/types.h>
> >>  #include <stdlib.h>
> >>  #include <errno.h>
> >> +#include <syslog.h>
> >>  #include "selinux_internal.h"
> >>  #include <selinux/flask.h>
> >>  #include <selinux/av_permissions.h>
> >> @@ -29,7 +30,15 @@ int selinux_check_passwd_access(access_vector_t
> >> requested)
> >>
> >>                if ((retval == 0) && ((requested & avd.allowed) ==
> >> requested)) {
> >>                        status = 0;
> >> +               } else {
> >> +                       syslog(LOG_ERR,
> >> +                              "avc:  denied { %s } for scontext=%s "
> >> +                              "tcontext=%s tclass=passwd\n",
> >> +                              security_av_perm_to_string(passwd_class,
> >> +                                                         requested),
> >> +                              user_context, user_context);
> >>                }
> >> +
> >>                freecon(user_context);
> >>         }
> >>
> >
> > Where does the passwd_class come from?
> >
> >   -- Larry
> >
> >
> >
> >
> >>
> >>
> >>
> >> --
> >> Stephen Smalley
> >> National Security Agency
> >>
> >>
> >
>
> This is not the responsibility of the library to log this fact, it is the
> responsibility of the tool (passwd) to log
> any denials.  I am surprised that we do not audit this event.  Since I
> think a MAC denial on changing a security sensitive object should probably
> be audited.


In the meantime, do you have any suggestions on how I can determine what the
problem is?

   Thank you,
   Larry




>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--0016364eda1cdae98504716f1634
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Aug 18, 2009 at 11:10 AM, Daniel J Walsh=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:dwalsh@redhat.com">dwalsh@redhat.c=
om</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On 08/18/2009 01:15 PM, Larry Ross wrote:<br>&gt; On Tue,=
 Aug 18, 2009 at 5:39 AM, Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.n=
sa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>&gt;<br>&gt;&gt; On Tue, 2009-0=
8-18 at 08:19 -0400, Stephen Smalley wrote:<br>
&gt;&gt;&gt; If this is another manifestation of the same problem, then the=
 easiest<br>&gt;&gt;&gt; approach would be to grab the libselinux .src.rpm,=
 patch<br>&gt;&gt;&gt; libselinux/src/checkAccess.c to syslog() a message w=
henever there is a<br>
&gt;&gt;&gt; denial, build and install your patched libselinux, and then re=
try and<br>&gt;&gt;&gt; look for the log message.<br>&gt;&gt;<br>&gt;&gt; S=
omething like this patch (un-tested, against the current upstream<br>&gt;&g=
t; libselinux):<br>
&gt;&gt;<br>&gt;&gt; diff --git a/libselinux/src/checkAccess.c b/libselinux=
/src/checkAccess.c<br>&gt;&gt; index c1982c7..cae1626 100644<br>&gt;&gt; --=
- a/libselinux/src/checkAccess.c<br>&gt;&gt; +++ b/libselinux/src/checkAcce=
ss.c<br>
&gt;&gt; @@ -2,6 +2,7 @@<br>&gt;&gt; =A0#include &lt;sys/types.h&gt;<br>&gt=
;&gt; =A0#include &lt;stdlib.h&gt;<br>&gt;&gt; =A0#include &lt;errno.h&gt;<=
br>&gt;&gt; +#include &lt;syslog.h&gt;<br>&gt;&gt; =A0#include &quot;selinu=
x_internal.h&quot;<br>
&gt;&gt; =A0#include &lt;selinux/flask.h&gt;<br>&gt;&gt; =A0#include &lt;se=
linux/av_permissions.h&gt;<br>&gt;&gt; @@ -29,7 +30,15 @@ int selinux_check=
_passwd_access(access_vector_t<br>&gt;&gt; requested)<br>&gt;&gt;<br>&gt;&g=
t; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((retval =3D=3D 0) &amp;&amp; ((reques=
ted &amp; avd.allowed) =3D=3D<br>
&gt;&gt; requested)) {<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0status =3D 0;<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>=
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syslog(LOG_ERR,<br>&=
gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;=
avc: =A0denied { %s } for scontext=3D%s &quot;<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot=
;tcontext=3D%s tclass=3Dpasswd\n&quot;,<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0security_av_perm_to_string(passwd_cl=
ass,<br>&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 requested),<br>
&gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0user_=
context, user_context);<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>&gt=
;&gt; +<br>&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0freecon(user_context);<b=
r>&gt;&gt; =A0 =A0 =A0 =A0 }<br>&gt;&gt;<br>&gt;<br>&gt; Where does the pas=
swd_class come from?<br>
&gt;<br>&gt; =A0 -- Larry<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;&gt;<br>&g=
t;&gt;<br>&gt;&gt;<br>&gt;&gt; --<br>&gt;&gt; Stephen Smalley<br>&gt;&gt; N=
ational Security Agency<br>&gt;&gt;<br>&gt;&gt;<br>&gt;<br><br></div></div>
This is not the responsibility of the library to log this fact, it is the r=
esponsibility of the tool (passwd) to log<br>any denials. =A0I am surprised=
 that we do not audit this event. =A0Since I think a MAC denial on changing=
 a security sensitive object should probably be audited.</blockquote>

<div>=A0</div>
<div>In the meantime, do you have any suggestions on how I can determine wh=
at the problem is?</div>
<div>=A0</div>
<div>=A0=A0 Thank you,</div>
<div>=A0=A0 Larry</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span id=3D""></span><br>
<div>
<div></div>
<div class=3D"h5"><br>--<br>This message was distributed to subscribers of =
the selinux mailing list.<br>If you no longer wish to subscribe, send mail =
to <a href=3D"mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> w=
ith<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
></div></div></blockquote></div><br>

--0016364eda1cdae98504716f1634--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
