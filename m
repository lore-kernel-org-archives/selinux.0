MIME-Version: 1.0
In-Reply-To: <1250521053.3629.117.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com>
	 <1250521053.3629.117.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 17 Aug 2009 07:55:56 -0700
Message-ID: <81092d890908170755n2f5df6c2h3ca57faff998e6d6@mail.gmail.com>
Subject: Re: checking user status
From: Larry Ross <selinux.larry@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0015174755605f36190471579965
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0015174755605f36190471579965
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Aug 17, 2009 at 7:57 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

>  On Mon, 2009-08-17 at 07:47 -0700, Larry Ross wrote:
> > On Mon, Aug 17, 2009 at 5:29 AM, Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> >         On Sun, 2009-08-16 at 11:53 -0700, Larry Ross wrote:
> >         > Using the RHEL5.3 strict policy I am trying to allow a
> >         custom selinux
> >         > user permission to use the passwd and chage commands to get
> >         the status
> >         > of a local user.
> >         >
> >         > With selinux in permissive it works as expected, with
> >         selinux in
> >         > enforcing, all I get are cryptic error messages.  I
> >         installed the
> >         > enableaudit.pp base policy module, still no denials.
> >         >
> >         > Does anyone know what permissions I need to add or what I
> >         could
> >         > be doing wrong?  Is this even possible?
> >
> > Stephen,
> > Thank you for your response.
> >
> >
> >         Did you allow the :passwd permission to the custom selinux
> >         user's
> >         domain?
> >
> >         allow <userdomain> self:passwd { passwd };
> >
> > I would have if I had know about it, is this documented somewhere?.
> >
> > That worked for "passwd -S", is there something similar to allow a
> > user to use the chage command?
>
> Looks like that is using rootok, although it ought to use a permission
> of its own rather than overlapping with pam_rootok.
>
> So:
>        allow <userdomain> self:passwd { passwd rootok };
>
> These programs ought to be converted to using the userspace AVC so that
> they emit proper avc messages on denials.


I will agree with that.  Thank you for your help.

  -- Larry


>
>
> --
>  Stephen Smalley
> National Security Agency
>
>

--0015174755605f36190471579965
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Aug 17, 2009 at 7:57 AM, Stephen Smalley=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.g=
ov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Mon, 2009-08-17 at 07:47 -0700, Larry Ross wrote:<br>&=
gt; On Mon, Aug 17, 2009 at 5:29 AM, Stephen Smalley &lt;<a href=3D"mailto:=
sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>&gt; wrote:<br>&gt; =A0 =A0=
 =A0 =A0 On Sun, 2009-08-16 at 11:53 -0700, Larry Ross wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; Using the RHEL5.3 strict policy I am trying to al=
low a<br>&gt; =A0 =A0 =A0 =A0 custom selinux<br>&gt; =A0 =A0 =A0 =A0 &gt; u=
ser permission to use the passwd and chage commands to get<br>&gt; =A0 =A0 =
=A0 =A0 the status<br>&gt; =A0 =A0 =A0 =A0 &gt; of a local user.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; With selinux in perm=
issive it works as expected, with<br>&gt; =A0 =A0 =A0 =A0 selinux in<br>&gt=
; =A0 =A0 =A0 =A0 &gt; enforcing, all I get are cryptic error messages. =A0=
I<br>&gt; =A0 =A0 =A0 =A0 installed the<br>
&gt; =A0 =A0 =A0 =A0 &gt; enableaudit.pp base policy module, still no denia=
ls.<br>&gt; =A0 =A0 =A0 =A0 &gt;<br>&gt; =A0 =A0 =A0 =A0 &gt; Does anyone k=
now what permissions I need to add or what I<br>&gt; =A0 =A0 =A0 =A0 could<=
br>&gt; =A0 =A0 =A0 =A0 &gt; be doing wrong? =A0Is this even possible?<br>
&gt;<br>&gt; Stephen,<br>&gt; Thank you for your response.<br>&gt;<br>&gt;<=
br>&gt; =A0 =A0 =A0 =A0 Did you allow the :passwd permission to the custom =
selinux<br>&gt; =A0 =A0 =A0 =A0 user&#39;s<br>&gt; =A0 =A0 =A0 =A0 domain?<=
br>&gt;<br>&gt; =A0 =A0 =A0 =A0 allow &lt;userdomain&gt; self:passwd { pass=
wd };<br>
&gt;<br>&gt; I would have if I had know about it, is this documented somewh=
ere?.<br>&gt;<br>&gt; That worked for &quot;passwd -S&quot;, is there somet=
hing similar to allow a<br>&gt; user to use the chage command?<br><br></div=
>
</div>Looks like that is using rootok, although it ought to use a permissio=
n<br>of its own rather than overlapping with pam_rootok.<br><br>So:<br>=A0 =
=A0 =A0 =A0allow &lt;userdomain&gt; self:passwd { passwd rootok };<br><br>T=
hese programs ought to be converted to using the userspace AVC so that<br>
they emit proper avc messages on denials.</blockquote>
<div>=A0</div>
<div>I will agree with that.=A0 Thank you for your help.</div>
<div>=A0</div>
<div>=A0 -- Larry</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span id=3D""></span><br><font c=
olor=3D"#888888"><br>--<br></font>
<div>
<div></div>
<div class=3D"h5">Stephen Smalley<br>National Security Agency<br><br></div>=
</div></blockquote></div><br>

--0015174755605f36190471579965--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
