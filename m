MIME-Version: 1.0
In-Reply-To: <CAPMH7-9GusaaSkfiBcX1+wQM1pdT++jcpz3pku1WQixdWMJ60Q@mail.gmail.com>
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
 <CAPMH7-8Urca69_7SHXjbPP9Re+8SQ9Wykj_+U6yqtSsNXUVQJA@mail.gmail.com>
 <1511976858.10464.20.camel@tycho.nsa.gov>
 <CAPMH7-9GusaaSkfiBcX1+wQM1pdT++jcpz3pku1WQixdWMJ60Q@mail.gmail.com>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Thu, 30 Nov 2017 21:13:25 +0530
Message-ID: <CAPMH7--BCZEWMOfYiurktLXxrezX7n+B32Q=e8qRYHn9-zyghg@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a11351a00e74c56055f351ce6"
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11351a00e74c56055f351ce6
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Do you have any other way to change the context from id command ?

Thanks
Aman

On Thu, Nov 30, 2017 at 11:10 AM, Aman Sharma <amansh.sharma5@gmail.com>
wrote:

> Hi Stephen,
>
> After reseting Selinux targeted folder also (the steps you mentioned in
> the earlier mail), Still its showing the same Id context i.e.
>
> *id*
> *uid=0(root) gid=0(root) groups=0(root)
> context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> *[root@cucm2 ~]# id -Z*
> *system_u:system_r:unconfined_t:s0-s0:c0.c1023*
>
> *And semanage login -l is showing blank output. *
>
> *Do you have any idea about this.*
>
> *Thanks*
> *Aman*
>
>
> On Wed, Nov 29, 2017 at 11:04 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>
>> On Wed, 2017-11-29 at 22:01 +0530, Aman Sharma wrote:
>> > After resetting boolean also, showing the same id context.
>>
>> And did you try fully resetting your policy as I suggested:
>> mv /etc/selinux/targeted /etc/selinux/targeted.old
>> yum reinstall selinux-policy-targeted
>> reboot
>>
>> >
>> >
>> > On Wed, Nov 29, 2017 at 9:50 PM, Stephen Smalley <sds@tycho.nsa.gov>
>> > wrote:
>> > > On Wed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:
>> > > > Hi Stephen,
>> > > >
>> > > > After enabling the unconfined module and after reboot also, Still
>> > > > showing the same id context.
>> > > >
>> > > > Is there any way to make the id context to normal state again ?
>> > >
>> > > Hmmm...try resetting all booleans too?  semanage boolean -D
>> > >
>> > > Or you could be drastic and completely reset your policy:
>> > > mv /etc/selinux/targeted /etc/selinux/targeted.old
>> > > yum reinstall selinux-policy-targeted
>> > >
>> >
>> >
>> >
>> > --
>> >
>> > Thanks
>> > Aman
>> > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
>>
>
>
>
> --
>
> Thanks
> Aman
> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a11351a00e74c56055f351ce6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>Do you have any other way t=
o change the context from id command ?</div><div><br></div><div>Thanks</div=
><div>Aman</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_qu=
ote">On Thu, Nov 30, 2017 at 11:10 AM, Aman Sharma <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:amansh.sharma5@gmail.com" target=3D"_blank">amansh.sharma5@=
gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr">Hi Stephen,<div><br></div><div>After reseting Selinux targeted fol=
der also (the steps you mentioned in the earlier mail), Still its showing t=
he same Id context i.e.=C2=A0</div><div><b><br></b></div><div><span class=
=3D""><div><b>id</b></div><div><b>uid=3D0(root) gid=3D0(root) groups=3D0(ro=
ot) context=3Dsystem_u:system_r:<wbr>unconfined_t:s0-s0:c0.c1023</b></div><=
/span><div><b>[root@cucm2 ~]# id -Z</b></div><span class=3D""><div><b>syste=
m_u:system_r:unconfined_<wbr>t:s0-s0:c0.c1023</b></div></span></div><div><b=
><br></b></div><div><b>And semanage login -l is showing blank output.=C2=A0=
</b></div><div><b><br></b></div><div><b>Do you have any idea about this.</b=
></div><div><b><br></b></div><div><b>Thanks</b></div><span class=3D"HOEnZb"=
><font color=3D"#888888"><div><b>Aman</b></div><div><br></div></font></span=
></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On Wed, Nov 29, 2017 at 11:04 PM, Stephen Sma=
lley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_=
blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><span>On Wed, 2017-11-29 at 22:01 +0530, Aman Sharma wrote:<br>
&gt; After resetting boolean also, showing the same id context.<br>
<br>
</span>And did you try fully resetting your policy as I suggested:<br>
<span>mv /etc/selinux/targeted /etc/selinux/targeted.old<br>
yum reinstall selinux-policy-targeted<br>
</span>reboot<br>
<div class=3D"m_-64616182288065019HOEnZb"><div class=3D"m_-6461618228806501=
9h5"><br>
&gt;<br>
&gt;<br>
&gt; On Wed, Nov 29, 2017 at 9:50 PM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;<br>
&gt; wrote:<br>
&gt; &gt; On Wed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:<br>
&gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; After enabling the unconfined module and after reboot also, =
Still<br>
&gt; &gt; &gt; showing the same id context.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Is there any way to make the id context to normal state agai=
n ?=C2=A0<br>
&gt; &gt;<br>
&gt; &gt; Hmmm...try resetting all booleans too?=C2=A0 semanage boolean -D<=
br>
&gt; &gt;<br>
&gt; &gt; Or you could be drastic and completely reset your policy:<br>
&gt; &gt; mv /etc/selinux/targeted /etc/selinux/targeted.old<br>
&gt; &gt; yum reinstall selinux-policy-targeted<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --=C2=A0<br>
&gt;<br>
&gt; Thanks<br>
&gt; Aman<br>
&gt; Cell: +91 9990296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharm=
a5@gmail.com" target=3D"_blank">amansh.sharma5@gmail.com</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"m_-64616182288065019gmail_signature" data-smartmail=3D"gmail_=
signature"><div dir=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div>=
<div>Cell: +91 9990296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharm=
a5@gmail.com" target=3D"_blank">amansh.sharma5@gmail.com</a></div></div></d=
iv>
</div>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a11351a00e74c56055f351ce6--
