MIME-Version: 1.0
In-Reply-To: <1343652922.2346.19.camel@moss-pluto.epoch.ncsc.mil>
References: <1343427185-6377-1-git-send-email-hqjiang1988@gmail.com>
	<1343652922.2346.19.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 30 Jul 2012 11:10:07 -0700
Message-ID: <CAO-4OdGZYg9cXQPTKsMAptBpREWM2VL4LWKuCuU7=7vR8MFUHw@mail.gmail.com>
Subject: Re: [PATCH 1/1] appdomain r/w apk_tmp_file and shell_data_file on
 android_cts enabled
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=bcaec554de60c8527504c60ff8b4
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec554de60c8527504c60ff8b4
Content-Type: text/plain; charset=ISO-8859-1

In my opinion, it's too general to be applied out of CTS. Only
CTStestStubs.apk and Packagemanager need to access to apm_tmp_file and
shell_data_file. The denial information is shown as below:

*<5>[   76.435272] type=1400 audit(1342043186.382:4): avc:  denied  { read
} for  pid=815 comm=42696E646572205468726561642023 name="CtsTestStubs.apk"
dev=mmcblk0p12 ino=667811 scontext=u:r:untrusted_app:s0:c9
tcontext=u:object_r:shell_data_file:s0 tclass=file
<5>[   76.435516] type=1400 audit(1342043186.382:5): avc:  denied  { open }
for  pid=815 comm=42696E646572205468726561642023 name="CtsTestStubs.apk"
dev=mmcblk0p12 ino=667811 scontext=u:r:untrusted_app:s0:c9
tcontext=u:object_r:shell_data_file:s0 tclass=file
<5>[   76.472808] type=1400 audit(1342043186.421:6): avc:  denied  { read
write } for  pid=206 comm="PackageManager"
path="/data/app/vmdl-400972190.tmp" dev=mmcblk0p12 ino=781829
scontext=u:r:untrusted_app:s0:c9 tcontext=u:object_r:apk_tmp_file:s0
tclass=file
<5>[   97.407379] type=1400 audit(1342043207.359:7): avc:  denied  { read }
for  pid=814 comm=42696E646572205468726561642023 name="CtsAppTestCases.apk"
dev=mmcblk0p12 ino=667812 scontext=u:r:untrusted_app:s0:c9
tcontext=u:object_r:shell_data_file:s0 tclass=file
<5>[   97.407562] type=1400 audit(1342043207.359:8): avc:  denied  { open }
for  pid=814 comm=42696E646572205468726561642023 name="CtsAppTestCases.apk"
dev=mmcblk0p12 ino=667812 scontext=u:r:untrusted_app:s0:c9
tcontext=u:object_r:shell_data_file:s0 tclass=file
<5>[   97.410003] type=1400 audit(1342043207.359:9): avc:  denied  { read
write } for  pid=206 comm="PackageManager"
path="/data/app/vmdl1671180406.tmp" dev=mmcblk0p12 ino=781831
scontext=u:r:untrusted_app:s0:c9 tcontext=u:object_r:apk_tmp_file:s0
tclass=file*



On Mon, Jul 30, 2012 at 5:55 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2012-07-27 at 15:13 -0700, Haiqing Jiang wrote:
> > ---
> >  cts.te |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
>
> Applied.  However, for each such denial, we need to consider whether
> these should only be allowed for CTS purposes or whether they belong as
> part of the base policy in general (and if the latter, whether they are
> required for all app domains or just some of them).
>
> > diff --git a/cts.te b/cts.te
> > index 3600e94..489be1a 100644
> > --- a/cts.te
> > +++ b/cts.te
> > @@ -27,6 +27,10 @@ allow appdomain fs_type:dir_file_class_set getattr;
> >  allow appdomain shell_exec:file rx_file_perms;
> >  allow appdomain system_file:file rx_file_perms;
> >
> > +# Accesses to apk_tmp_file and shell_data_file
> > +allow appdomain apk_tmp_file:file rw_file_perms;
> > +allow appdomain shell_data_file:file r_file_perms;
> > +
> >  # Read routing information.
> >  allow netdomain self:netlink_route_socket { create read write
> nlmsg_read };
> >
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--bcaec554de60c8527504c60ff8b4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

In my opinion, it&#39;s too general to be applied out of CTS. Only CTStestS=
tubs.apk and Packagemanager need to access to apm_tmp_file and shell_data_f=
ile. The denial information is shown as below:<div><br></div><div><b id=3D"=
internal-source-marker_0.5502668635454029" style=3D"font-family:&#39;Times =
New Roman&#39;;font-size:medium;font-weight:normal"><span style=3D"font-siz=
e:15px;font-family:Arial;vertical-align:baseline;white-space:pre-wrap">&lt;=
5&gt;[ =A0=A076.435272] type=3D1400 audit(1342043186.382:4): avc: =A0denied=
 =A0{ read } for =A0pid=3D815 comm=3D42696E646572205468726561642023 name=3D=
&quot;CtsTestStubs.apk&quot; dev=3Dmmcblk0p12 ino=3D667811 scontext=3Du:r:u=
ntrusted_app:s0:c9 tcontext=3Du:object_r:shell_data_file:s0 tclass=3Dfile</=
span><br>
<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap">&lt;5&gt;[ =A0=A076.435516] type=3D1400 audit(1342043186=
.382:5): avc: =A0denied =A0{ open } for =A0pid=3D815 comm=3D42696E646572205=
468726561642023 name=3D&quot;CtsTestStubs.apk&quot; dev=3Dmmcblk0p12 ino=3D=
667811 scontext=3Du:r:untrusted_app:s0:c9 tcontext=3Du:object_r:shell_data_=
file:s0 tclass=3Dfile</span><br>
<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap">&lt;5&gt;[ =A0=A076.472808] type=3D1400 audit(1342043186=
.421:6): avc: =A0denied =A0{ read write } for =A0pid=3D206 comm=3D&quot;Pac=
kageManager&quot; path=3D&quot;/data/app/vmdl-400972190.tmp&quot; dev=3Dmmc=
blk0p12 ino=3D781829 scontext=3Du:r:untrusted_app:s0:c9 tcontext=3Du:object=
_r:apk_tmp_file:s0 tclass=3Dfile</span><br>
<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap">&lt;5&gt;[ =A0=A097.407379] type=3D1400 audit(1342043207=
.359:7): avc: =A0denied =A0{ read } for =A0pid=3D814 comm=3D42696E646572205=
468726561642023 name=3D&quot;CtsAppTestCases.apk&quot; dev=3Dmmcblk0p12 ino=
=3D667812 scontext=3Du:r:untrusted_app:s0:c9 tcontext=3Du:object_r:shell_da=
ta_file:s0 tclass=3Dfile</span><br>
<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap">&lt;5&gt;[ =A0=A097.407562] type=3D1400 audit(1342043207=
.359:8): avc: =A0denied =A0{ open } for =A0pid=3D814 comm=3D42696E646572205=
468726561642023 name=3D&quot;CtsAppTestCases.apk&quot; dev=3Dmmcblk0p12 ino=
=3D667812 scontext=3Du:r:untrusted_app:s0:c9 tcontext=3Du:object_r:shell_da=
ta_file:s0 tclass=3Dfile</span><br>
<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap">&lt;5&gt;[ =A0=A097.410003] type=3D1400 audit(1342043207=
.359:9): avc: =A0denied =A0{ read write } for =A0pid=3D206 comm=3D&quot;Pac=
kageManager&quot; path=3D&quot;/data/app/vmdl1671180406.tmp&quot; dev=3Dmmc=
blk0p12 ino=3D781831 scontext=3Du:r:untrusted_app:s0:c9 tcontext=3Du:object=
_r:apk_tmp_file:s0 tclass=3Dfile</span></b></div>
<div><font face=3D"Arial"><span style=3D"font-size:15px;white-space:pre-wra=
p"><br></span></font></div><div><font face=3D"Arial"><span style=3D"font-si=
ze:15px;white-space:pre-wrap"><br></span></font><br><div class=3D"gmail_quo=
te">On Mon, Jul 30, 2012 at 5:55 AM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Fri, 2012-07-27 at 15:1=
3 -0700, Haiqing Jiang wrote:<br>
&gt; ---<br>
&gt; =A0cts.te | =A0 =A04 ++++<br>
&gt; =A01 files changed, 4 insertions(+), 0 deletions(-)<br>
<br>
</div>Applied. =A0However, for each such denial, we need to consider whethe=
r<br>
these should only be allowed for CTS purposes or whether they belong as<br>
part of the base policy in general (and if the latter, whether they are<br>
required for all app domains or just some of them).<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; diff --git a/cts.te b/cts.te<br>
&gt; index 3600e94..489be1a 100644<br>
&gt; --- a/cts.te<br>
&gt; +++ b/cts.te<br>
&gt; @@ -27,6 +27,10 @@ allow appdomain fs_type:dir_file_class_set getattr;=
<br>
&gt; =A0allow appdomain shell_exec:file rx_file_perms;<br>
&gt; =A0allow appdomain system_file:file rx_file_perms;<br>
&gt;<br>
&gt; +# Accesses to apk_tmp_file and shell_data_file<br>
&gt; +allow appdomain apk_tmp_file:file rw_file_perms;<br>
&gt; +allow appdomain shell_data_file:file r_file_perms;<br>
&gt; +<br>
&gt; =A0# Read routing information.<br>
&gt; =A0allow netdomain self:netlink_route_socket { create read write nlmsg=
_read };<br>
&gt;<br>
<br>
--<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">Stephen Smalley<=
br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div>-----------------------------------</div>Haiqing Jiang, PH.D student=
<div><br></div><div>Computer Science Department, North Carolina State Unive=
rsity<br>
<div><br></div></div><br>
</div>

--bcaec554de60c8527504c60ff8b4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
