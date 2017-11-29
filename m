MIME-Version: 1.0
In-Reply-To: <1511965250.10464.5.camel@tycho.nsa.gov>
References: <CAPMH7--5mGMZ4UMLM9763ukX-CBOzfUD96_wnCea57+RM8uakw@mail.gmail.com>
 <1511963807.10464.4.camel@tycho.nsa.gov>
 <1511965250.10464.5.camel@tycho.nsa.gov>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 20:14:27 +0530
Message-ID: <CAPMH7-8unpJmwWiTvnO3zAsKosDfqtxDXhYgkj3PKbJxvF0aEw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a11351a0024e130055f202cf7"
Subject: Re: Default User in Selinux
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11351a0024e130055f202cf7
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

During boot up,this error message is coming i.e. command is not working but
after the system boot up, this command is working fine.

Means facing the issue during boot up.

Please let me know your comments on this.

Thanks
Aman



On Wed, Nov 29, 2017 at 7:50 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2017-11-29 at 08:56 -0500, Stephen Smalley wrote:
> > On Wed, 2017-11-29 at 17:19 +0530, Aman Sharma wrote:
> > > Hi All,
> > >
> > > During System boot up, I am running some semanage commands to
> > > change
> > > the User to sysadm_u.  But in Cent OS 7.3 , Below error message is
> > > coming i.e.  ValueError: Login mapping for __default__ is not
> > > defined.
> > >
> > > /usr/sbin/semanage login -m -S targeted -s user_u -r s0
> > > __default__
> > >     ValueError: Login mapping for __default__ is not defined
> > >
> > > But the same command is working fine in Cent OS 6.8.
> > >
> > > Please let me know why this error message is coming for Cent OS 7.
> >
> > That suggests something is very wrong with your seusers
> > configuration,
> > or maybe you have too many underscores before or after default
> > (should
> > be two _ before and after).
>
> BTW, the command above works fine for me on CentOS 7.4 (don't have 7.3
> handy).
>
> >
> > You can delete all local customizations to your seusers configuration
> > via semanage login -D.  This will revert to the stock configuration
> > in
> > your policy package.  Likewise for semanage user -D.
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a11351a0024e130055f202cf7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>During boot up,this error m=
essage is coming i.e. command is not working but after the system boot up, =
this command is working fine.</div><div><br></div><div>Means facing the iss=
ue during boot up.</div><div><br></div><div>Please let me know your comment=
s on this.</div><div><br></div><div>Thanks</div><div>Aman=C2=A0<br><div><br=
></div><div><br></div></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Wed, Nov 29, 2017 at 7:50 PM, Stephen Smalley <span dir=
=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tyc=
ho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On Wed, 2017-11-29 at 08:56 -0500, Stephen Smalley wrote:<br>
&gt; On Wed, 2017-11-29 at 17:19 +0530, Aman Sharma wrote:<br>
&gt; &gt; Hi All,<br>
&gt; &gt;<br>
&gt; &gt; During System boot up, I am running some semanage commands to<br>
&gt; &gt; change<br>
&gt; &gt; the User to sysadm_u.=C2=A0 But in Cent OS 7.3 , Below error mess=
age is<br>
&gt; &gt; coming i.e.=C2=A0=C2=A0ValueError: Login mapping for __default__ =
is not<br>
&gt; &gt; defined.<br>
&gt; &gt;<br>
&gt; &gt; /usr/sbin/semanage login -m -S targeted -s user_u -r s0<br>
&gt; &gt; __default__=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0ValueError: Login mapping for __default__=
 is not defined<br>
&gt; &gt;<br>
&gt; &gt; But the same command is working fine in Cent OS 6.8.=C2=A0<br>
&gt; &gt;<br>
&gt; &gt; Please let me know why this error message is coming for Cent OS 7=
.<br>
&gt;<br>
&gt; That suggests something is very wrong with your seusers<br>
&gt; configuration,<br>
&gt; or maybe you have too many underscores before or after default<br>
&gt; (should<br>
&gt; be two _ before and after).<br>
<br>
</span>BTW, the command above works fine for me on CentOS 7.4 (don&#39;t ha=
ve 7.3<br>
handy).<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; You can delete all local customizations to your seusers configuration<=
br>
&gt; via semanage login -D.=C2=A0=C2=A0This will revert to the stock config=
uration<br>
&gt; in<br>
&gt; your policy package.=C2=A0=C2=A0Likewise for semanage user -D.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a11351a0024e130055f202cf7--
