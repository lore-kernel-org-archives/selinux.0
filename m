Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0JF7lXf003270
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 10:07:47 -0500 (EST)
Received: from uproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0JF6bgR002196
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 15:06:38 GMT
Received: by uproxy.gmail.com with SMTP id u2so276286uge
        for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 07:07:45 -0800 (PST)
Message-ID: <ae023b600601190707ra462043i8d6de864d1afa3ea@mail.gmail.com>
Date: Thu, 19 Jan 2006 10:07:44 -0500
From: Jim McCullough <jim.mccullough@gmail.com>
To: russell@coker.com.au
Subject: Re: dropping pppd_script_exec_t
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200601200039.38070.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8381_33135719.1137683264777"
References: <1137083967.29815.205.camel@sgc.columbia.tresys.com>
	 <200601200039.38070.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_8381_33135719.1137683264777
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This may create an issue on some workstations that interface with dsl modem=
s
and handle the ppoe or ppoa connection via the user level.  Such as with kd=
e
and gnome under multiple distrobutions.  I will test this when I get home
tonight and see if I can get anything to break.

On 1/19/06, Russell Coker <russell@coker.com.au> wrote:
>
> On Friday 13 January 2006 03:39, "Christopher J. PeBenito"
> <cpebenito@tresys.com> wrote:
> > In the ppp module there is a type pppd_script_exec_t and its only used
> > in one rule:
> >
> > domain_auto_trans(pppd_t, pppd_script_exec_t, initrc_t)
> >
> > Looking at the actual scripts, they seem similar to regular init script=
s
> > for configuring network devices.  Since the scripts transition to
> > initrc_t already, it seems like they should instead be labeled
> > initrc_exec_t and the regular interface call for transitioning to initr=
c
> > can be used.  Then pppd_script_exec_t would be dropped (made an alias o=
f
> > initrc_exec_t for compatibility).  Is there any problem with doing this=
?
>
> The only problem is that escape from the pppd_t domain is possible via an=
y
> of
> the initrc_exec_t scripts (of which there are many) instead of merely the
> pppd_script_exec_t (of which there will be few if any).
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux package=
s
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govw=
ith
> the words "unsubscribe selinux" without quotes as the message.
>



--
Jim McCullough

------=_Part_8381_33135719.1137683264777
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This may create an issue on some workstations that interface with dsl modem=
s and handle the ppoe or ppoa connection via the user level.&nbsp; Such as =
with kde and gnome under multiple distrobutions.&nbsp; I will test this whe=
n I get home tonight and see if I can get anything to break.
<br><br><div><span class=3D"gmail_quote">On 1/19/06, <b class=3D"gmail_send=
ername">Russell Coker</b> &lt;<a href=3D"mailto:russell@coker.com.au">russe=
ll@coker.com.au</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
On Friday 13 January 2006 03:39, &quot;Christopher J. PeBenito&quot;<br>&lt=
;<a href=3D"mailto:cpebenito@tresys.com">cpebenito@tresys.com</a>&gt; wrote=
:<br>&gt; In the ppp module there is a type pppd_script_exec_t and its only=
 used
<br>&gt; in one rule:<br>&gt;<br>&gt; domain_auto_trans(pppd_t, pppd_script=
_exec_t, initrc_t)<br>&gt;<br>&gt; Looking at the actual scripts, they seem=
 similar to regular init scripts<br>&gt; for configuring network devices.&n=
bsp;&nbsp;Since the scripts transition to
<br>&gt; initrc_t already, it seems like they should instead be labeled<br>=
&gt; initrc_exec_t and the regular interface call for transitioning to init=
rc<br>&gt; can be used.&nbsp;&nbsp;Then pppd_script_exec_t would be dropped=
 (made an alias of
<br>&gt; initrc_exec_t for compatibility).&nbsp;&nbsp;Is there any problem =
with doing this?<br><br>The only problem is that escape from the pppd_t dom=
ain is possible via any of<br>the initrc_exec_t scripts (of which there are=
 many) instead of merely the
<br>pppd_script_exec_t (of which there will be few if any).<br><br>--<br><a=
 href=3D"http://www.coker.com.au/selinux/">http://www.coker.com.au/selinux/=
</a>&nbsp;&nbsp; My NSA Security Enhanced Linux packages<br><a href=3D"http=
://www.coker.com.au/bonnie++/">
http://www.coker.com.au/bonnie++/</a>&nbsp;&nbsp;Bonnie++ hard drive benchm=
ark<br><a href=3D"http://www.coker.com.au/postal/">http://www.coker.com.au/=
postal/</a>&nbsp;&nbsp;&nbsp;&nbsp;Postal SMTP/POP benchmark<br><a href=3D"=
http://www.coker.com.au/~russell/">
http://www.coker.com.au/~russell/</a>&nbsp;&nbsp;My home page<br><br>--<br>=
This message was distributed to subscribers of the selinux mailing list.<br=
>If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordo=
mo@tycho.nsa.gov">
majordomo@tycho.nsa.gov</a> with<br>the words &quot;unsubscribe selinux&quo=
t; without quotes as the message.<br></blockquote></div><br><br clear=3D"al=
l"><br>-- <br>Jim McCullough<br>

------=_Part_8381_33135719.1137683264777--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
