MIME-Version: 1.0
In-Reply-To: <CADjGSjg0c7X2kY1_qUg4GgKtOnkmFkPsmEMDXxwmj7a-h+K+5Q@mail.gmail.com>
References: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
 <CADjGSjg0c7X2kY1_qUg4GgKtOnkmFkPsmEMDXxwmj7a-h+K+5Q@mail.gmail.com>
Date: Wed, 8 Oct 2014 21:09:40 -0700
Message-ID: <CABXk95D6JEVXuUBBbkCcOqfZH5+okmjf_pD=HV0jqfb5OmE5sw@mail.gmail.com>
Subject: Re: [PATCH] selinux: hooks: Add permission for network MAC address
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Content-Type: multipart/alternative; boundary=047d7b343d52fb1a500504f59930
Cc: SELinux <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b343d52fb1a500504f59930
Content-Type: text/plain; charset=UTF-8

Hi Joshua,

Thank you for responding.

The intent is not to hide the MAC address from the local-area-network, it
is to restrict which applications on the local machine have access to it.
The use-case is to more tightly sandbox untrusted applications from
accessing persistent hardware identifiers.

Consider a web client application that has a legitimate reason to access
the internet and network information in order to retrieve information from
a remote web server. Unbeknownst to the user, the application reads the MAC
address and sends it to the web server to uniquely identify/fingerprint the
hardware that its running on (instead of using more privacy-friendly
non-persistent methods like cookies, certificates, temp files,
username/password). Tracking with persistent identifiers such as the MAC
address is surprisingly common, invisible to the user, and it allows for
tracking that persists across multiple users, different networks, history
wipes, disk wipes, factory resets, username/password changes etc. The
ability to limit access to persistent hardware identifiers like the MAC
address allows for writing policy that enhances user privacy by making it
more difficult for software to tie itself to specific hardware. Many
applications need network access, very few need the MAC address. It would
be useful to be able to write policy that allows access to one without the
other.

On Wed, Oct 8, 2014 at 6:01 PM, Joshua Brindle <brindle@quarksecurity.com>
wrote:

> On Wed, Oct 8, 2014 at 8:41 PM, Jeffrey Vander Stoep <jeffv@google.com>
> wrote:
> > First time poster to the list. I would appreciate feedback/suggestions
> > regarding the following patch.
> >
> > This patch which provides SELinux control over network interface MAC
> > addresses. This patch allows access to the MAC address to be controlled
> by
> > policy. Network MAC addresses are a long lived unique device identifier,
> and
> > a security policy may wish to control access to the identifier without
> > further limiting network use, perhaps for privacy reasons.
> >
> > The existing SE Linux permissions are too coarse in that they only allow
> > blanket read/no-read access to this socket ioctl. We would like to
> consider
> > both the read/no-read permission as well as an additional permission that
> > checks the ioctl cmd argument. This allows applications to continue
> > accessing the IP address, netmask, etc, while being denied access to the
> MAC
> > address.
> >
>
> If someone has another system on the same network they can just get
> the address by pinging it and running arp -a, right?
>
> What use case do you see covering by adding this permission?
>
> > Thanks,
> > Jeff Vander Stoep
> >
> > ---
> >  security/selinux/hooks.c            | 7 +++++++
> >  security/selinux/include/classmap.h | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 1e1266b..cb65fd9 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3142,6 +3142,13 @@ static int selinux_file_ioctl(struct file *file,
> > unsigned int cmd,
> >      SECURITY_CAP_AUDIT);
> >   break;
> >
> > +    case SIOCGIFHWADDR:
> > +        error = file_has_perm(cred, file, FILE__IOCTL);
> > +        if (error)
> > +            break;
> > +        error = file_has_perm(cred, file, SOCKET__GET_HWADDR);
> > +        break;
> > +
> >   /* default case assumes that the command will go
> >   * to the file's ioctl() function.
> >   */
> > diff --git a/security/selinux/include/classmap.h
> > b/security/selinux/include/classmap.h
> > index c32ff7b..306f0d2 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -7,7 +7,7 @@
> >
> >  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
> >      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> > -    "sendto", "recv_msg", "send_msg", "name_bind"
> > +    "sendto", "recv_msg", "send_msg", "name_bind", "get_hwaddr"
> >
> >  #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr",
> "read",
> > \
> >      "write", "associate", "unix_read", "unix_write"
> > --
> > 2.1.0.rc2.206.gedb03e5
> >
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
>

--047d7b343d52fb1a500504f59930
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr" style=3D"font-family:arial,sans-serif;font-=
size:13px;line-height:1.15;margin-top:0pt;margin-bottom:0pt"><span style=3D=
"font-family:Arial;color:rgb(0,0,0);vertical-align:baseline;white-space:pre=
-wrap;background-color:transparent">Hi Joshua,</span></p><br style=3D"font-=
family:arial,sans-serif;font-size:13px"><p dir=3D"ltr" style=3D"font-family=
:arial,sans-serif;font-size:13px;line-height:1.15;margin-top:0pt;margin-bot=
tom:0pt"><span style=3D"font-family:Arial;color:rgb(0,0,0);vertical-align:b=
aseline;white-space:pre-wrap;background-color:transparent">Thank you for re=
sponding. </span></p><br style=3D"font-family:arial,sans-serif;font-size:13=
px"><p dir=3D"ltr" style=3D"font-family:arial,sans-serif;font-size:13px;lin=
e-height:1.15;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-family:=
Arial;color:rgb(0,0,0);vertical-align:baseline;white-space:pre-wrap;backgro=
und-color:transparent">The intent is not to hide the MAC address from the l=
ocal-area-network, it is to restrict which applications on the local machin=
e have access to it. The use-case is to more tightly sandbox untrusted appl=
ications from accessing persistent hardware identifiers.</span></p><br styl=
e=3D"font-family:arial,sans-serif;font-size:13px"><span style=3D"font-size:=
13px;font-family:Arial;color:rgb(0,0,0);vertical-align:baseline;white-space=
:pre-wrap;background-color:transparent">Consider a web client application t=
hat has a legitimate reason to access the internet and network information =
in order to retrieve information from a remote web server. Unbeknownst to t=
he user, the application reads the MAC address and sends it to the web serv=
er to uniquely identify/fingerprint the hardware that its running on (inste=
ad of using more privacy-friendly non-persistent methods like cookies, cert=
ificates, temp files, username/password). Tracking with persistent identifi=
ers such as the MAC address is surprisingly common, invisible to the user, =
and it allows for tracking that persists across multiple users, different n=
etworks, history wipes, disk wipes, factory resets, username/password chang=
es etc. The ability to limit access to persistent hardware identifiers like=
 the MAC address allows for writing policy that enhances user privacy by ma=
king it more difficult for software to tie itself to specific hardware. Man=
y applications need network access, very few need the MAC address. It would=
 be useful to be able to write policy that allows access to one without the=
 other.</span><br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Wed, Oct 8, 2014 at 6:01 PM, Joshua Brindle <span dir=3D"ltr">&lt=
;<a href=3D"mailto:brindle@quarksecurity.com" target=3D"_blank">brindle@qua=
rksecurity.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><spa=
n class=3D"">On Wed, Oct 8, 2014 at 8:41 PM, Jeffrey Vander Stoep &lt;<a hr=
ef=3D"mailto:jeffv@google.com">jeffv@google.com</a>&gt; wrote:<br>
&gt; First time poster to the list. I would appreciate feedback/suggestions=
<br>
&gt; regarding the following patch.<br>
&gt;<br>
&gt; This patch which provides SELinux control over network interface MAC<b=
r>
&gt; addresses. This patch allows access to the MAC address to be controlle=
d by<br>
&gt; policy. Network MAC addresses are a long lived unique device identifie=
r, and<br>
&gt; a security policy may wish to control access to the identifier without=
<br>
&gt; further limiting network use, perhaps for privacy reasons.<br>
&gt;<br>
&gt; The existing SE Linux permissions are too coarse in that they only all=
ow<br>
&gt; blanket read/no-read access to this socket ioctl. We would like to con=
sider<br>
&gt; both the read/no-read permission as well as an additional permission t=
hat<br>
&gt; checks the ioctl cmd argument. This allows applications to continue<br=
>
&gt; accessing the IP address, netmask, etc, while being denied access to t=
he MAC<br>
&gt; address.<br>
&gt;<br>
<br>
</span>If someone has another system on the same network they can just get<=
br>
the address by pinging it and running arp -a, right?<br>
<br>
What use case do you see covering by adding this permission?<br>
<div><div class=3D"h5"><br>
&gt; Thanks,<br>
&gt; Jeff Vander Stoep<br>
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 security/selinux/hooks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 7 +++++++<br>
&gt;=C2=A0 security/selinux/include/classmap.h | 2 +-<br>
&gt;=C2=A0 2 files changed, 8 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c<br>
&gt; index 1e1266b..cb65fd9 100644<br>
&gt; --- a/security/selinux/hooks.c<br>
&gt; +++ b/security/selinux/hooks.c<br>
&gt; @@ -3142,6 +3142,13 @@ static int selinux_file_ioctl(struct file *file=
,<br>
&gt; unsigned int cmd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SECURITY_CAP_AUDIT);<br>
&gt;=C2=A0 =C2=A0break;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 case SIOCGIFHWADDR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D file_has_perm(cred, file, FILE_=
_IOCTL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D file_has_perm(cred, file, SOCKE=
T__GET_HWADDR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* default case assumes that the command will go<br>
&gt;=C2=A0 =C2=A0* to the file&#39;s ioctl() function.<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; diff --git a/security/selinux/include/classmap.h<br>
&gt; b/security/selinux/include/classmap.h<br>
&gt; index c32ff7b..306f0d2 100644<br>
&gt; --- a/security/selinux/include/classmap.h<br>
&gt; +++ b/security/selinux/include/classmap.h<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;<br>
&gt;=C2=A0 #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, &quot;bind&quo=
t;, &quot;connect&quot;, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;listen&quot;, &quot;accept&quot;, &quot;geto=
pt&quot;, &quot;setopt&quot;, &quot;shutdown&quot;, &quot;recvfrom&quot;,=
=C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 &quot;sendto&quot;, &quot;recv_msg&quot;, &quot;send_ms=
g&quot;, &quot;name_bind&quot;<br>
&gt; +=C2=A0 =C2=A0 &quot;sendto&quot;, &quot;recv_msg&quot;, &quot;send_ms=
g&quot;, &quot;name_bind&quot;, &quot;get_hwaddr&quot;<br>
&gt;<br>
&gt;=C2=A0 #define COMMON_IPC_PERMS &quot;create&quot;, &quot;destroy&quot;=
, &quot;getattr&quot;, &quot;setattr&quot;, &quot;read&quot;,<br>
&gt; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;write&quot;, &quot;associate&quot;, &quot;un=
ix_read&quot;, &quot;unix_write&quot;<br>
&gt; --<br>
&gt; 2.1.0.rc2.206.gedb03e5<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to<br>
&gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho=
.nsa.gov</a>.<br>
</blockquote></div><br></div>

--047d7b343d52fb1a500504f59930--
