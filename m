MIME-Version: 1.0
In-Reply-To: <1250599197.3629.210.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com>
	 <1250521053.3629.117.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170755n2f5df6c2h3ca57faff998e6d6@mail.gmail.com>
	 <81092d890908171338j36a27012h3b87c5828f1d24ab@mail.gmail.com>
	 <1250597961.3629.209.camel@moss-pluto.epoch.ncsc.mil>
	 <1250599197.3629.210.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 18 Aug 2009 10:15:23 -0700
Message-ID: <81092d890908181015j71ce6b62tdc5f5251220d84a9@mail.gmail.com>
Subject: Re: checking user status
From: Larry Ross <selinux.larry@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00151747af9af06ece04716da90c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00151747af9af06ece04716da90c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Tue, Aug 18, 2009 at 5:39 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2009-08-18 at 08:19 -0400, Stephen Smalley wrote:
> > If this is another manifestation of the same problem, then the easiest
> > approach would be to grab the libselinux .src.rpm, patch
> > libselinux/src/checkAccess.c to syslog() a message whenever there is a
> > denial, build and install your patched libselinux, and then retry and
> > look for the log message.
>
> Something like this patch (un-tested, against the current upstream
> libselinux):
>
> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> index c1982c7..cae1626 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -2,6 +2,7 @@
>  #include <sys/types.h>
>  #include <stdlib.h>
>  #include <errno.h>
> +#include <syslog.h>
>  #include "selinux_internal.h"
>  #include <selinux/flask.h>
>  #include <selinux/av_permissions.h>
> @@ -29,7 +30,15 @@ int selinux_check_passwd_access(access_vector_t
> requested)
>
>                if ((retval == 0) && ((requested & avd.allowed) ==
> requested)) {
>                        status = 0;
> +               } else {
> +                       syslog(LOG_ERR,
> +                              "avc:  denied { %s } for scontext=%s "
> +                              "tcontext=%s tclass=passwd\n",
> +                              security_av_perm_to_string(passwd_class,
> +                                                         requested),
> +                              user_context, user_context);
>                }
> +
>                freecon(user_context);
>         }
>

Where does the passwd_class come from?

  -- Larry




>
>
>
> --
> Stephen Smalley
> National Security Agency
>
>

--00151747af9af06ece04716da90c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Aug 18, 2009 at 5:39 AM, Stephen Smalley=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.g=
ov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Tue, 2009-08-18 at 08:19 -0400, Stephen Smalley wrote:=
<br>&gt; If this is another manifestation of the same problem, then the eas=
iest<br>&gt; approach would be to grab the libselinux .src.rpm, patch<br>
&gt; libselinux/src/checkAccess.c to syslog() a message whenever there is a=
<br>&gt; denial, build and install your patched libselinux, and then retry =
and<br>&gt; look for the log message.<br><br></div>Something like this patc=
h (un-tested, against the current upstream<br>
libselinux):<br><br>diff --git a/libselinux/src/checkAccess.c b/libselinux/=
src/checkAccess.c<br>index c1982c7..cae1626 100644<br>--- a/libselinux/src/=
checkAccess.c<br>+++ b/libselinux/src/checkAccess.c<br>@@ -2,6 +2,7 @@<br>
=A0#include &lt;sys/types.h&gt;<br>=A0#include &lt;stdlib.h&gt;<br>=A0#incl=
ude &lt;errno.h&gt;<br>+#include &lt;syslog.h&gt;<br>=A0#include &quot;seli=
nux_internal.h&quot;<br>=A0#include &lt;selinux/flask.h&gt;<br>=A0#include =
&lt;selinux/av_permissions.h&gt;<br>
@@ -29,7 +30,15 @@ int selinux_check_passwd_access(access_vector_t requeste=
d)<br><br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((retval =3D=3D 0) &amp;&amp; (=
(requested &amp; avd.allowed) =3D=3D requested)) {<br>=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D 0;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=
 else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 syslog(LOG_ERR,<br>+ =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&quot;avc: =A0denied { %=
s } for scontext=3D%s &quot;<br>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0&quot;tcontext=3D%s tclass=3Dpasswd\n&quot;,<br>+ =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0security_av_perm_to_=
string(passwd_class,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 requested),<br>+ =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0user_context, user_context);<br>=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>+<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fre=
econ(user_context);<br>
<div>
<div></div>
<div class=3D"h5">=A0 =A0 =A0 =A0}</div></div></blockquote>
<div>=A0</div>
<div>Where does the passwd_class come from?</div>
<div>=A0</div>
<div>=A0 -- Larry</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div class=3D"h5"><span id=3D""></span><br><br><br>--<br>Stephen Smalley<br=
>National Security Agency<br><br></div></div></blockquote></div><br>

--00151747af9af06ece04716da90c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
