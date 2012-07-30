MIME-Version: 1.0
In-Reply-To: <CAO-4OdF9eOgwpF6_Jg_izcY-cqijrQjQEMDU1_7+Pf5vb3L1Tg@mail.gmail.com>
References: <1343428827-6808-1-git-send-email-hqjiang1988@gmail.com>
	<1343650449.2346.0.camel@moss-pluto.epoch.ncsc.mil>
	<CAO-4OdF9eOgwpF6_Jg_izcY-cqijrQjQEMDU1_7+Pf5vb3L1Tg@mail.gmail.com>
Date: Mon, 30 Jul 2012 10:46:58 -0700
Message-ID: <CAO-4OdEpa70Tm-NhOT00nni1HgAtP_tn-fftFW9xAqSjGryB4Q@mail.gmail.com>
Subject: Re: [PATCH] add read permission over dev_type to appdomain on
 android_cts enabled
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=bcaec554de600521ac04c60fa686
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec554de600521ac04c60fa686
Content-Type: text/plain; charset=ISO-8859-1

The policy to the denials should be: allow untrusted_app {block_device,
radio_device, log_device}:lnk_file read; (ignore the syntax error). Do you
think it's OK to merge it to: allow appdomain dev_type:dir_file_class_set {
getattr read }???? Or we need to add separate policies? (like, allow
untrusted_app specific device type:lnk_file read;)

On Mon, Jul 30, 2012 at 10:33 AM, Haiqing Jiang <hqjiang1988@gmail.com>wrote:

> The denial information is shown as below:
>
> *<5>[ 2219.393524] type=1400 audit(1342221801.398:17): avc:  denied  {
> read } for  pid=2687 comm="ationTestRunner" name="mtdblock0" dev=tmpfs
> ino=2562 scontext=u:r:untrusted_app:s0:c38
> tcontext=u:object_r:block_device:s0 tclass=lnk_file
>
> <5>[ 2219.399566] type=1400 audit(1342221801.406:18): avc:  denied  { read
> } for  pid=2687 comm="ationTestRunner" name="radio" dev=tmpfs ino=2527
> scontext=u:r:untrusted_app:s0:c38 tcontext=u:object_r:radio_device:s0
> tclass=lnk_file
>
> <5>[ 2005.011016] type=1400 audit(1342224760.046:32): avc:  denied  { read
> } for  pid=7264 comm="onCtsTestRunner" name="events" dev=tmpfs ino=2902
> scontext=u:r:untrusted_app:s0:c38 tcontext=u:object_r:log_device:s0
> tclass=chr_file*
>
>
> On Mon, Jul 30, 2012 at 5:14 AM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>
>> On Fri, 2012-07-27 at 15:40 -0700, Haiqing Jiang wrote:
>> > ---
>> >  cts.te |    2 +-
>> >  1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/cts.te b/cts.te
>> > index 489be1a..ff8a9f0 100644
>> > --- a/cts.te
>> > +++ b/cts.te
>> > @@ -20,7 +20,7 @@ allow appdomain file_type:dir r_dir_perms;
>> >  allow appdomain fs_type:dir r_dir_perms;
>> >  allow appdomain dev_type:dir r_dir_perms;
>> >  allow appdomain file_type:dir_file_class_set getattr;
>> > -allow appdomain dev_type:dir_file_class_set getattr;
>> > +allow appdomain dev_type:dir_file_class_set { getattr read };
>> >  allow appdomain fs_type:dir_file_class_set getattr;
>> >
>> >  # Execute the shell or other system executables.
>>
>> I don't think you want to allow all app domains to read all devices.
>> Nor should that be required even for CTS.  Which devices triggered
>> denials?
>>
>> --
>> Stephen Smalley
>> National Security Agency
>>
>>
>
>
> --
> -----------------------------------
> Haiqing Jiang, PH.D student
>
> Computer Science Department, North Carolina State University
>
>
>


-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--bcaec554de600521ac04c60fa686
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The policy to the denials should be: allow untrusted_app {block_device, rad=
io_device, log_device}:lnk_file read; (ignore the syntax error). Do you thi=
nk it&#39;s OK to merge it to:=A0<span style=3D"color:rgb(34,34,34);font-fa=
mily:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255)">all=
ow appdomain dev_type:dir_file_class_set { getattr read }???? Or we need to=
 add separate policies? (like, allow untrusted_app specific device type:lnk=
_file read;)</span><br>
<br><div class=3D"gmail_quote">On Mon, Jul 30, 2012 at 10:33 AM, Haiqing Ji=
ang <span dir=3D"ltr">&lt;<a href=3D"mailto:hqjiang1988@gmail.com" target=
=3D"_blank">hqjiang1988@gmail.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
The denial information is shown as below:<div><br></div><div><b style=3D"fo=
nt-family:&#39;Times New Roman&#39;;font-size:medium;font-weight:normal"><s=
pan style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;white=
-space:pre-wrap">&lt;5&gt;[ 2219.393524] type=3D1400 audit(1342221801.398:1=
7): avc: =A0denied =A0{ read } for =A0pid=3D2687 comm=3D&quot;ationTestRunn=
er&quot; name=3D&quot;mtdblock0&quot; dev=3Dtmpfs ino=3D2562 scontext=3Du:r=
:untrusted_app:s0:c38 tcontext=3Du:object_r:block_device:s0 tclass=3Dlnk_fi=
le</span><br>

<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap"></span><br><span style=3D"font-size:15px;font-family:Ari=
al;vertical-align:baseline;white-space:pre-wrap">&lt;5&gt;[ 2219.399566] ty=
pe=3D1400 audit(1342221801.406:18): avc: =A0denied =A0{ read } for =A0pid=
=3D2687 comm=3D&quot;ationTestRunner&quot; name=3D&quot;radio&quot; dev=3Dt=
mpfs ino=3D2527 scontext=3Du:r:untrusted_app:s0:c38 tcontext=3Du:object_r:r=
adio_device:s0 tclass=3Dlnk_file</span><br>

<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap"></span><br><b style=3D"font-weight:normal"><span style=
=3D"font-size:15px;font-family:Arial;vertical-align:baseline;white-space:pr=
e-wrap">&lt;5&gt;[ 2005.011016] type=3D1400 audit(1342224760.046:32): avc: =
=A0denied =A0{ read } for =A0pid=3D7264 comm=3D&quot;onCtsTestRunner&quot; =
name=3D&quot;events&quot; dev=3Dtmpfs ino=3D2902 scontext=3Du:r:untrusted_a=
pp:s0:c38 tcontext=3Du:object_r:log_device:s0 tclass=3Dchr_file</span></b><=
/b></div>

<div><div><div class=3D"h5"><font face=3D"Arial"><span style=3D"font-size:1=
5px;white-space:pre-wrap"><br></span></font><br><div class=3D"gmail_quote">=
On Mon, Jul 30, 2012 at 5:14 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt=
;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div>On Fri, 2012-07-27 at 15:40 -0700,=
 Haiqing Jiang wrote:<br>
&gt; ---<br>
&gt; =A0cts.te | =A0 =A02 +-<br>
&gt; =A01 files changed, 1 insertions(+), 1 deletions(-)<br>
&gt;<br>
&gt; diff --git a/cts.te b/cts.te<br>
&gt; index 489be1a..ff8a9f0 100644<br>
&gt; --- a/cts.te<br>
&gt; +++ b/cts.te<br>
&gt; @@ -20,7 +20,7 @@ allow appdomain file_type:dir r_dir_perms;<br>
&gt; =A0allow appdomain fs_type:dir r_dir_perms;<br>
&gt; =A0allow appdomain dev_type:dir r_dir_perms;<br>
&gt; =A0allow appdomain file_type:dir_file_class_set getattr;<br>
&gt; -allow appdomain dev_type:dir_file_class_set getattr;<br>
&gt; +allow appdomain dev_type:dir_file_class_set { getattr read };<br>
&gt; =A0allow appdomain fs_type:dir_file_class_set getattr;<br>
&gt;<br>
&gt; =A0# Execute the shell or other system executables.<br>
<br>
</div></div>I don&#39;t think you want to allow all app domains to read all=
 devices.<br>
Nor should that be required even for CTS. =A0Which devices triggered<br>
denials?<br>
<span><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div></div=
></div><span class=3D"HOEnZb"><font color=3D"#888888">-- <br><div>---------=
--------------------------</div>Haiqing Jiang, PH.D student<div><br></div><=
div>
Computer Science Department, North Carolina State University<br>
<div><br></div></div><br>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>-------=
----------------------------</div>Haiqing Jiang, PH.D student<div><br></div=
><div>Computer Science Department, North Carolina State University<br><div>
<br></div></div><br>

--bcaec554de600521ac04c60fa686--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
