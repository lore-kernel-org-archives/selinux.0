MIME-Version: 1.0
In-Reply-To: <1511972400.10464.16.camel@tycho.nsa.gov>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <1511963505.10464.2.camel@tycho.nsa.gov>
 <CAPMH7-80BqKG1XB1UDXWAJp1cHKYL3ri_0XjVYdppCNdyom9hQ@mail.gmail.com>
 <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
 <1511970015.10464.10.camel@tycho.nsa.gov>
 <CAPMH7--q4AUQcyuEiGi-X1RAqukROFkC-ged4aw5aKj8Wwc=gw@mail.gmail.com>
 <1511971345.10464.14.camel@tycho.nsa.gov>
 <CAPMH7-9JxKDOO8dMC_wZwRTm+Z8G4gOPvYZxf3obsB1GBGSMhQ@mail.gmail.com>
 <1511972400.10464.16.camel@tycho.nsa.gov>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 22:01:19 +0530
Message-ID: <CAPMH7-8Urca69_7SHXjbPP9Re+8SQ9Wykj_+U6yqtSsNXUVQJA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a1140eeea5e9446055f21aa08"
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140eeea5e9446055f21aa08
Content-Type: text/plain; charset="UTF-8"

After resetting boolean also, showing the same id context.


On Wed, Nov 29, 2017 at 9:50 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:
> > Hi Stephen,
> >
> > After enabling the unconfined module and after reboot also, Still
> > showing the same id context.
> >
> > Is there any way to make the id context to normal state again ?
>
> Hmmm...try resetting all booleans too?  semanage boolean -D
>
> Or you could be drastic and completely reset your policy:
> mv /etc/selinux/targeted /etc/selinux/targeted.old
> yum reinstall selinux-policy-targeted
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a1140eeea5e9446055f21aa08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">After resetting boolean also, showing the same id context.=
<div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Nov 29, 2017 at 9:50 PM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On W=
ed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:<br>
&gt; Hi Stephen,<br>
&gt;<br>
</span><span class=3D"">&gt; After enabling the unconfined module and after=
 reboot also, Still<br>
&gt; showing the same id context.<br>
&gt;<br>
&gt; Is there any way to make the id context to normal state again ?=C2=A0<=
br>
<br>
</span>Hmmm...try resetting all booleans too?=C2=A0 semanage boolean -D<br>
<br>
Or you could be drastic and completely reset your policy:<br>
mv /etc/selinux/targeted /etc/selinux/targeted.old<br>
yum reinstall selinux-policy-targeted<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990296404 | =
=C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" target=3D"_bla=
nk">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a1140eeea5e9446055f21aa08--
