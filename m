Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB14QNpe023527
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 23:26:25 -0500
Received: by mail-it0-f53.google.com with SMTP id u62so1098896ita.2
 for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2017 20:26:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171130201920.GA32637@julius.enp8s0.d30>
References: <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
 <1511970015.10464.10.camel@tycho.nsa.gov>
 <CAPMH7--q4AUQcyuEiGi-X1RAqukROFkC-ged4aw5aKj8Wwc=gw@mail.gmail.com>
 <1511971345.10464.14.camel@tycho.nsa.gov>
 <CAPMH7-9JxKDOO8dMC_wZwRTm+Z8G4gOPvYZxf3obsB1GBGSMhQ@mail.gmail.com>
 <1511972400.10464.16.camel@tycho.nsa.gov>
 <CAPMH7-8Urca69_7SHXjbPP9Re+8SQ9Wykj_+U6yqtSsNXUVQJA@mail.gmail.com>
 <1511976858.10464.20.camel@tycho.nsa.gov>
 <CAPMH7-9GusaaSkfiBcX1+wQM1pdT++jcpz3pku1WQixdWMJ60Q@mail.gmail.com>
 <20171130201920.GA32637@julius.enp8s0.d30>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Fri, 1 Dec 2017 09:56:21 +0530
Message-ID: <CAPMH7-9zGFSRz3qPJup2y8=zNo6X1dRgNf8gUWv=d+UK1EdO9A@mail.gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a11474a54550a60055f3fc5cf"
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11474a54550a60055f3fc5cf
Content-Type: text/plain; charset="UTF-8"

Hi ,

mv /var/lib/selinux/targeted /var/lib/selinux/targeted.old

This targeted folder is not there.

After searching I got the below result :

find / -type d -name "*targeted" -print

/usr/share/selinux/targeted
/etc/selinux/targeted

Pleas let me know your comments.


On Fri, Dec 1, 2017 at 1:49 AM, Dominick Grift <dac.override@gmail.com>
wrote:

> On Thu, Nov 30, 2017 at 11:10:43AM +0530, Aman Sharma wrote:
> > Hi Stephen,
> >
> > After reseting Selinux targeted folder also (the steps you mentioned in
> the
> > earlier mail), Still its showing the same Id context i.e.
> >
> > *id*
> > *uid=0(root) gid=0(root) groups=0(root)
> > context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> > *[root@cucm2 ~]# id -Z*
> > *system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> >
> > *And semanage login -l is showing blank output. *
> >
> > *Do you have any idea about this.*
> >
> > *Thanks*
> > *Aman*
>
> Try the same procedure again but this time also do before reinstalling:
>
> mv /var/lib/selinux/targeted /var/lib/selinux/targeted.old
>
> >
> >
> > On Wed, Nov 29, 2017 at 11:04 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> >
> > > On Wed, 2017-11-29 at 22:01 +0530, Aman Sharma wrote:
> > > > After resetting boolean also, showing the same id context.
> > >
> > > And did you try fully resetting your policy as I suggested:
> > > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > > yum reinstall selinux-policy-targeted
> > > reboot
> > >
> > > >
> > > >
> > > > On Wed, Nov 29, 2017 at 9:50 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > > > wrote:
> > > > > On Wed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:
> > > > > > Hi Stephen,
> > > > > >
> > > > > > After enabling the unconfined module and after reboot also, Still
> > > > > > showing the same id context.
> > > > > >
> > > > > > Is there any way to make the id context to normal state again ?
> > > > >
> > > > > Hmmm...try resetting all booleans too?  semanage boolean -D
> > > > >
> > > > > Or you could be drastic and completely reset your policy:
> > > > > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > > > > yum reinstall selinux-policy-targeted
> > > > >
> > > >
> > > >
> > > >
> > > > --
> > > >
> > > > Thanks
> > > > Aman
> > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > >
> >
> >
> >
> > --
> >
> > Thanks
> > Aman
> > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
>
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a11474a54550a60055f3fc5cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi ,<div><br></div><div><span style=3D"font-size:12.8px">m=
v /var/lib/selinux/targeted /var/lib/selinux/targeted.old</span><br></div><=
div><span style=3D"font-size:12.8px"><br></span></div><div><span style=3D"f=
ont-size:12.8px">This targeted folder is not there.=C2=A0</span></div><div>=
<span style=3D"font-size:12.8px"><br></span></div><div><span style=3D"font-=
size:12.8px">After searching I got the below result :</span></div><div><spa=
n style=3D"font-size:12.8px"><br></span></div><div><div><span style=3D"font=
-size:12.8px">find / -type d -name &quot;*targeted&quot; -print</span></div=
><div><span style=3D"font-size:12.8px"><br></span></div><div><span style=3D=
"font-size:12.8px">/usr/share/selinux/targeted</span></div><div><span style=
=3D"font-size:12.8px">/etc/selinux/targeted</span></div></div><div><span st=
yle=3D"font-size:12.8px"><br></span></div><div><span style=3D"font-size:12.=
8px">Pleas let me know your comments.</span></div><div><br></div></div><div=
 class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Dec 1, 2017 a=
t 1:49 AM, Dominick Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:dac.overr=
ide@gmail.com" target=3D"_blank">dac.override@gmail.com</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><span class=3D"">On Thu, Nov 30, 2017 =
at 11:10:43AM +0530, Aman Sharma wrote:<br>
&gt; Hi Stephen,<br>
&gt;<br>
</span><span class=3D"">&gt; After reseting Selinux targeted folder also (t=
he steps you mentioned in the<br>
&gt; earlier mail), Still its showing the same Id context i.e.<br>
&gt;<br>
</span>&gt; *id*<br>
&gt; *uid=3D0(root) gid=3D0(root) groups=3D0(root)<br>
&gt; context=3Dsystem_u:system_r:<wbr>unconfined_t:s0-s0:c0.c1023*<br>
&gt; *[root@cucm2 ~]# id -Z*<br>
<span class=3D"">&gt; *system_u:system_r:unconfined_<wbr>t:s0-s0:c0.c1023*<=
br>
&gt;<br>
</span>&gt; *And semanage login -l is showing blank output. *<br>
&gt;<br>
&gt; *Do you have any idea about this.*<br>
&gt;<br>
&gt; *Thanks*<br>
&gt; *Aman*<br>
<br>
Try the same procedure again but this time also do before reinstalling:<br>
<br>
mv /var/lib/selinux/targeted /var/lib/selinux/targeted.old<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt; On Wed, Nov 29, 2017 at 11:04 PM, Stephen Smalley &lt;<a href=3D"mailt=
o:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Wed, 2017-11-29 at 22:01 +0530, Aman Sharma wrote:<br>
&gt; &gt; &gt; After resetting boolean also, showing the same id context.<b=
r>
&gt; &gt;<br>
&gt; &gt; And did you try fully resetting your policy as I suggested:<br>
&gt; &gt; mv /etc/selinux/targeted /etc/selinux/targeted.old<br>
&gt; &gt; yum reinstall selinux-policy-targeted<br>
&gt; &gt; reboot<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Nov 29, 2017 at 9:50 PM, Stephen Smalley &lt;<a href=
=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; On Wed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:<b=
r>
&gt; &gt; &gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; After enabling the unconfined module and after reb=
oot also, Still<br>
&gt; &gt; &gt; &gt; &gt; showing the same id context.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Is there any way to make the id context to normal =
state again ?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Hmmm...try resetting all booleans too?=C2=A0 semanage b=
oolean -D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Or you could be drastic and completely reset your polic=
y:<br>
&gt; &gt; &gt; &gt; mv /etc/selinux/targeted /etc/selinux/targeted.old<br>
&gt; &gt; &gt; &gt; yum reinstall selinux-policy-targeted<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; Aman<br>
&gt; &gt; &gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D"mailto:am=
ansh.sharma5@gmail.com">amansh.sharma5@gmail.com</a><br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt; Thanks<br>
&gt; Aman<br>
&gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D"mailto:amansh.sharm=
a5@gmail.com">amansh.sharma5@gmail.com</a><br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">--<br>
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8=C2=A0 02D5 3B6C 5F1D 2C7B 6B02=
<br>
<a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B=
6C5F1D2C7B6B02" rel=3D"noreferrer" target=3D"_blank">https://sks-keyservers=
.net/<wbr>pks/lookup?op=3Dget&amp;search=3D<wbr>0x3B6C5F1D2C7B6B02</a><br>
Dominick Grift<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a11474a54550a60055f3fc5cf--
