MIME-Version: 1.0
In-Reply-To: <CABXk95D6JEVXuUBBbkCcOqfZH5+okmjf_pD=HV0jqfb5OmE5sw@mail.gmail.com>
References: <CABXk95B697exgYtCQOF=+P4=xW-M5THjBmZM9byLZERGpi75Gg@mail.gmail.com>
 <CADjGSjg0c7X2kY1_qUg4GgKtOnkmFkPsmEMDXxwmj7a-h+K+5Q@mail.gmail.com>
 <CABXk95D6JEVXuUBBbkCcOqfZH5+okmjf_pD=HV0jqfb5OmE5sw@mail.gmail.com>
Date: Thu, 9 Oct 2014 06:54:11 -0700
Message-ID: <CAFJ0LnHo54QJhc+ojK5HP8RsiS0BNRHiC113SS=kEshVVf2drw@mail.gmail.com>
Subject: Re: [PATCH] selinux: hooks: Add permission for network MAC address
From: Nick Kralevich <nnk@google.com>
To: Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: multipart/alternative; boundary=001a1141bac0657e610504fdc45a
Cc: SELinux <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1141bac0657e610504fdc45a
Content-Type: text/plain; charset=UTF-8

Thank you for putting together this patch Jeff.

FWIW, I'm supportive of patches like this. Allowing policy to restrict
access to unique persistent device identifiers without impacting other
ioctl operations feels like a small but important privacy win for me,
especially on distributions designed to run potentially untrustworthy
applications. Hopefully the wider SELinux team agrees with this, and we can
make progress towards producing a patch which works well for everyone.

Joshua: This patch wasn't intended to address off-device leakage of MAC
addresses. That's an important problem, but not something solvable via
SELinux policy.

-- Nick



On Wed, Oct 8, 2014 at 9:09 PM, Jeffrey Vander Stoep <jeffv@google.com>
wrote:

> Hi Joshua,
>
> Thank you for responding.
>
> The intent is not to hide the MAC address from the local-area-network, it
> is to restrict which applications on the local machine have access to it.
> The use-case is to more tightly sandbox untrusted applications from
> accessing persistent hardware identifiers.
>
> Consider a web client application that has a legitimate reason to access
> the internet and network information in order to retrieve information from
> a remote web server. Unbeknownst to the user, the application reads the MAC
> address and sends it to the web server to uniquely identify/fingerprint the
> hardware that its running on (instead of using more privacy-friendly
> non-persistent methods like cookies, certificates, temp files,
> username/password). Tracking with persistent identifiers such as the MAC
> address is surprisingly common, invisible to the user, and it allows for
> tracking that persists across multiple users, different networks, history
> wipes, disk wipes, factory resets, username/password changes etc. The
> ability to limit access to persistent hardware identifiers like the MAC
> address allows for writing policy that enhances user privacy by making it
> more difficult for software to tie itself to specific hardware. Many
> applications need network access, very few need the MAC address. It would
> be useful to be able to write policy that allows access to one without the
> other.
>
> On Wed, Oct 8, 2014 at 6:01 PM, Joshua Brindle <brindle@quarksecurity.com>
> wrote:
>
>> On Wed, Oct 8, 2014 at 8:41 PM, Jeffrey Vander Stoep <jeffv@google.com>
>> wrote:
>> > First time poster to the list. I would appreciate feedback/suggestions
>> > regarding the following patch.
>> >
>> > This patch which provides SELinux control over network interface MAC
>> > addresses. This patch allows access to the MAC address to be controlled
>> by
>> > policy. Network MAC addresses are a long lived unique device
>> identifier, and
>> > a security policy may wish to control access to the identifier without
>> > further limiting network use, perhaps for privacy reasons.
>> >
>> > The existing SE Linux permissions are too coarse in that they only allow
>> > blanket read/no-read access to this socket ioctl. We would like to
>> consider
>> > both the read/no-read permission as well as an additional permission
>> that
>> > checks the ioctl cmd argument. This allows applications to continue
>> > accessing the IP address, netmask, etc, while being denied access to
>> the MAC
>> > address.
>> >
>>
>> If someone has another system on the same network they can just get
>> the address by pinging it and running arp -a, right?
>>
>> What use case do you see covering by adding this permission?
>>
>> > Thanks,
>> > Jeff Vander Stoep
>> >
>> > ---
>> >  security/selinux/hooks.c            | 7 +++++++
>> >  security/selinux/include/classmap.h | 2 +-
>> >  2 files changed, 8 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> > index 1e1266b..cb65fd9 100644
>> > --- a/security/selinux/hooks.c
>> > +++ b/security/selinux/hooks.c
>> > @@ -3142,6 +3142,13 @@ static int selinux_file_ioctl(struct file *file,
>> > unsigned int cmd,
>> >      SECURITY_CAP_AUDIT);
>> >   break;
>> >
>> > +    case SIOCGIFHWADDR:
>> > +        error = file_has_perm(cred, file, FILE__IOCTL);
>> > +        if (error)
>> > +            break;
>> > +        error = file_has_perm(cred, file, SOCKET__GET_HWADDR);
>> > +        break;
>> > +
>> >   /* default case assumes that the command will go
>> >   * to the file's ioctl() function.
>> >   */
>> > diff --git a/security/selinux/include/classmap.h
>> > b/security/selinux/include/classmap.h
>> > index c32ff7b..306f0d2 100644
>> > --- a/security/selinux/include/classmap.h
>> > +++ b/security/selinux/include/classmap.h
>> > @@ -7,7 +7,7 @@
>> >
>> >  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
>> >      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
>> > -    "sendto", "recv_msg", "send_msg", "name_bind"
>> > +    "sendto", "recv_msg", "send_msg", "name_bind", "get_hwaddr"
>> >
>> >  #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr",
>> "read",
>> > \
>> >      "write", "associate", "unix_read", "unix_write"
>> > --
>> > 2.1.0.rc2.206.gedb03e5
>> >
>> >
>> > _______________________________________________
>> > Selinux mailing list
>> > Selinux@tycho.nsa.gov
>> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > To get help, send an email containing "help" to
>> > Selinux-request@tycho.nsa.gov.
>>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

--001a1141bac0657e610504fdc45a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for putting together this patch Jeff.=C2=A0<div>=
<br></div><div>FWIW, I&#39;m supportive of patches like this. Allowing poli=
cy to restrict access to unique persistent device identifiers without impac=
ting other ioctl operations feels like a small but important privacy win fo=
r me, especially on distributions designed to run potentially untrustworthy=
 applications. Hopefully the wider SELinux team agrees with this, and we ca=
n make progress towards producing a patch which works well for everyone.</d=
iv><div><br></div><div>Joshua: This patch wasn&#39;t intended to address of=
f-device leakage of MAC addresses. That&#39;s an important problem, but not=
 something solvable via SELinux policy.</div><div><br></div><div>-- Nick<br=
></div><div><div><br></div><div><br></div></div></div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Wed, Oct 8, 2014 at 9:09 PM, Jeffre=
y Vander Stoep <span dir=3D"ltr">&lt;<a href=3D"mailto:jeffv@google.com" ta=
rget=3D"_blank">jeffv@google.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><p dir=3D"ltr" style=3D"font-family:arial,sa=
ns-serif;font-size:13px;line-height:1.15;margin-top:0pt;margin-bottom:0pt">=
<span style=3D"font-family:Arial;color:rgb(0,0,0);vertical-align:baseline;w=
hite-space:pre-wrap;background-color:transparent">Hi Joshua,</span></p><br =
style=3D"font-family:arial,sans-serif;font-size:13px"><p dir=3D"ltr" style=
=3D"font-family:arial,sans-serif;font-size:13px;line-height:1.15;margin-top=
:0pt;margin-bottom:0pt"><span style=3D"font-family:Arial;color:rgb(0,0,0);v=
ertical-align:baseline;white-space:pre-wrap;background-color:transparent">T=
hank you for responding. </span></p><br style=3D"font-family:arial,sans-ser=
if;font-size:13px"><p dir=3D"ltr" style=3D"font-family:arial,sans-serif;fon=
t-size:13px;line-height:1.15;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-family:Arial;color:rgb(0,0,0);vertical-align:baseline;white-space:=
pre-wrap;background-color:transparent">The intent is not to hide the MAC ad=
dress from the local-area-network, it is to restrict which applications on =
the local machine have access to it. The use-case is to more tightly sandbo=
x untrusted applications from accessing persistent hardware identifiers.</s=
pan></p><br style=3D"font-family:arial,sans-serif;font-size:13px"><span sty=
le=3D"font-size:13px;font-family:Arial;color:rgb(0,0,0);vertical-align:base=
line;white-space:pre-wrap;background-color:transparent">Consider a web clie=
nt application that has a legitimate reason to access the internet and netw=
ork information in order to retrieve information from a remote web server. =
Unbeknownst to the user, the application reads the MAC address and sends it=
 to the web server to uniquely identify/fingerprint the hardware that its r=
unning on (instead of using more privacy-friendly non-persistent methods li=
ke cookies, certificates, temp files, username/password). Tracking with per=
sistent identifiers such as the MAC address is surprisingly common, invisib=
le to the user, and it allows for tracking that persists across multiple us=
ers, different networks, history wipes, disk wipes, factory resets, usernam=
e/password changes etc. The ability to limit access to persistent hardware =
identifiers like the MAC address allows for writing policy that enhances us=
er privacy by making it more difficult for software to tie itself to specif=
ic hardware. Many applications need network access, very few need the MAC a=
ddress. It would be useful to be able to write policy that allows access to=
 one without the other.</span><br></div><div class=3D"HOEnZb"><div class=3D=
"h5"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Oct =
8, 2014 at 6:01 PM, Joshua Brindle <span dir=3D"ltr">&lt;<a href=3D"mailto:=
brindle@quarksecurity.com" target=3D"_blank">brindle@quarksecurity.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On Wed, Oct 8, 20=
14 at 8:41 PM, Jeffrey Vander Stoep &lt;<a href=3D"mailto:jeffv@google.com"=
 target=3D"_blank">jeffv@google.com</a>&gt; wrote:<br>
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
<div><div><br>
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
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tyc=
ho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to<br>
&gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov" target=3D"_blank">Sel=
inux-request@tycho.nsa.gov</a>.<br>
</blockquote></div><br></div>
</div></div><br>_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>Nick Kralevi=
ch | Android Security | <a href=3D"mailto:nnk@google.com" target=3D"_blank"=
>nnk@google.com</a> | 650.214.4037</div>
</div>

--001a1141bac0657e610504fdc45a--
