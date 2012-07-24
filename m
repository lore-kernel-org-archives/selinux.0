MIME-Version: 1.0
In-Reply-To: <CAO-4OdEJJg+gnXwRL75+WdsCFMcwjRLSuWUvQjY8eM2YqAnDyA@mail.gmail.com>
References: <1342739276-1686-4-git-send-email-hqjiang1988@gmail.com>
	<1343050007.23118.28.camel@moss-pluto.epoch.ncsc.mil>
	<CAO-4OdG2zH+9dDQYboh2itGN6a5cUMPc23TJO3vJZ6DDaR9TwA@mail.gmail.com>
	<1343135089.2383.28.camel@moss-pluto.epoch.ncsc.mil>
	<CAO-4OdEJJg+gnXwRL75+WdsCFMcwjRLSuWUvQjY8eM2YqAnDyA@mail.gmail.com>
Date: Tue, 24 Jul 2012 15:32:29 -0700
Message-ID: <CAO-4OdEmRH9toR4QX7qnR+h1-fw9742hFUAYv3trwPzW_GbU+w@mail.gmail.com>
Subject: Re: [PATCH 3/6] external/sepolicy: mediaserver talk to rild via socket
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=14dae9d7197607dcae04c59af06e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--14dae9d7197607dcae04c59af06e
Content-Type: text/plain; charset=ISO-8859-1

Hi, Stephen

I find the denial. But have not ideas about the exact object related to the
denial. Please let me know your comments. Thanks.

*#============= mediaserver ==============
allow mediaserver rild:unix_stream_socket connectto;

<5>[ 9719.676422] type=1400 audit(1343162276.710:1512): avc:  denied  {
connectto } for  pid=519 comm=42696E646572205468726561642023
path=004D756C7469636C69656E74 scontext=u:r:mediaserver:s0
tcontext=u:r:rild:s0 tclass=unix_stream_socket*



On Tue, Jul 24, 2012 at 9:10 AM, Haiqing Jiang <hqjiang1988@gmail.com>wrote:

> I cannot find the corresponding avc logs at this moment.. I will let you
> know when I find it.
>
>
> On Tue, Jul 24, 2012 at 6:04 AM, Stephen Smalley <sds@tycho.nsa.gov>wrote:
>
>> On Mon, 2012-07-23 at 15:05 -0700, Haiqing Jiang wrote:
>> > If in that case, I don't think it's a good idea to allow permission to
>> > mediaserver over rild. Thanks for your comments.
>>
>> It may be legitimate, but I want to understand why and how it happens
>> before allowing it.
>>
>> >
>> > On Mon, Jul 23, 2012 at 6:26 AM, Stephen Smalley <sds@tycho.nsa.gov>
>> > wrote:
>> >         On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
>> >         > ---
>> >         >  mediaserver.te |    3 +++
>> >         >  1 files changed, 3 insertions(+), 0 deletions(-)
>> >         >
>> >         > diff --git a/mediaserver.te b/mediaserver.te
>> >         > index d3f0334..6dd4d4a 100644
>> >         > --- a/mediaserver.te
>> >         > +++ b/mediaserver.te
>> >         > @@ -40,3 +40,6 @@ allow mediaserver
>> >         camera_calibration_file:file r_file_perms;
>> >         >  # Read/[write] to /proc/net/xt_qtaguid/ctrl
>> >         and /dev/xt_qtaguid
>> >         >  allow mediaserver qtaguid_proc:file rw_file_perms;
>> >         >  allow mediaserver qtaguid_device:chr_file r_file_perms;
>> >         > +
>> >         > +# Talk to rild via socket
>> >         > +unix_socket_connect(mediaserver, rild, rild)
>> >
>> >
>> >         Hmm...it used to be that only radio could connect to rild.
>> >         socket perms are 660 root radio, and mediaserver runs as
>> >         media.
>> >         Doesn't seem like this is possible even under DAC.
>> >          Clarification
>> >         requested?
>> >
>> >         --
>> >         Stephen Smalley
>> >         National Security Agency
>> >
>> >
>> >
>> >
>> >
>> > --
>> > -----------------------------------
>> > Haiqing Jiang, PH.D student
>> >
>> >
>> > Computer Science Department, North Carolina State University
>> >
>> >
>> >
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

--14dae9d7197607dcae04c59af06e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, Stephen<div><br></div><div>I find the denial. But have not ideas about =
the exact object related to the denial. Please let me know your comments. T=
hanks.=A0</div><div><br></div><div><b id=3D"internal-source-marker_0.458570=
48174366355" style=3D"font-family:&#39;Times New Roman&#39;;font-size:mediu=
m;font-weight:normal"><span style=3D"font-size:15px;font-family:Arial;verti=
cal-align:baseline;white-space:pre-wrap">#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D mediaserver =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br class=3D"k=
ix-line-break">
allow mediaserver rild:unix_stream_socket connectto;<br class=3D"kix-line-b=
reak"></span><br><span style=3D"font-size:15px;font-family:Arial;vertical-a=
lign:baseline;white-space:pre-wrap">&lt;5&gt;[ 9719.676422] type=3D1400 aud=
it(1343162276.710:1512): avc: =A0denied =A0{ connectto } for =A0pid=3D519 c=
omm=3D42696E646572205468726561642023 path=3D004D756C7469636C69656E74 sconte=
xt=3Du:r:mediaserver:s0 tcontext=3Du:r:rild:s0 tclass=3Dunix_stream_socket<=
/span></b></div>
<div><br></div><div><br><br><div class=3D"gmail_quote">On Tue, Jul 24, 2012=
 at 9:10 AM, Haiqing Jiang <span dir=3D"ltr">&lt;<a href=3D"mailto:hqjiang1=
988@gmail.com" target=3D"_blank">hqjiang1988@gmail.com</a>&gt;</span> wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I cannot find the corresponding avc logs at =
this moment.. I will let you know when I find it.=A0<div class=3D"HOEnZb"><=
div class=3D"h5">
<br><br><div class=3D"gmail_quote">On Tue, Jul 24, 2012 at 6:04 AM, Stephen=
 Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=
=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div>On Mon, 2012-07-23 at 15:05 -0700, Haiq=
ing Jiang wrote:<br>
&gt; If in that case, I don&#39;t think it&#39;s a good idea to allow permi=
ssion to<br>
&gt; mediaserver over rild. Thanks for your comments.<br>
<br>
</div>It may be legitimate, but I want to understand why and how it happens=
<br>
before allowing it.<br>
<div><div><br>
&gt;<br>
&gt; On Mon, Jul 23, 2012 at 6:26 AM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;<br>
&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote=
:<br>
&gt; =A0 =A0 =A0 =A0 &gt; ---<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0mediaserver.te | =A0 =A03 +++<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A01 files changed, 3 insertions(+), 0 deletions(=
-)<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; diff --git a/mediaserver.te b/mediaserver.te<br>
&gt; =A0 =A0 =A0 =A0 &gt; index d3f0334..6dd4d4a 100644<br>
&gt; =A0 =A0 =A0 =A0 &gt; --- a/mediaserver.te<br>
&gt; =A0 =A0 =A0 =A0 &gt; +++ b/mediaserver.te<br>
&gt; =A0 =A0 =A0 =A0 &gt; @@ -40,3 +40,6 @@ allow mediaserver<br>
&gt; =A0 =A0 =A0 =A0 camera_calibration_file:file r_file_perms;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0# Read/[write] to /proc/net/xt_qtaguid/ctrl<br=
>
&gt; =A0 =A0 =A0 =A0 and /dev/xt_qtaguid<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0allow mediaserver qtaguid_proc:file rw_file_pe=
rms;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0allow mediaserver qtaguid_device:chr_file r_fi=
le_perms;<br>
&gt; =A0 =A0 =A0 =A0 &gt; +<br>
&gt; =A0 =A0 =A0 =A0 &gt; +# Talk to rild via socket<br>
&gt; =A0 =A0 =A0 =A0 &gt; +unix_socket_connect(mediaserver, rild, rild)<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Hmm...it used to be that only radio could connect to r=
ild.<br>
&gt; =A0 =A0 =A0 =A0 socket perms are 660 root radio, and mediaserver runs =
as<br>
&gt; =A0 =A0 =A0 =A0 media.<br>
&gt; =A0 =A0 =A0 =A0 Doesn&#39;t seem like this is possible even under DAC.=
<br>
&gt; =A0 =A0 =A0 =A0 =A0Clarification<br>
&gt; =A0 =A0 =A0 =A0 requested?<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 Stephen Smalley<br>
&gt; =A0 =A0 =A0 =A0 National Security Agency<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; -----------------------------------<br>
&gt; Haiqing Jiang, PH.D student<br>
&gt;<br>
&gt;<br>
&gt; Computer Science Department, North Carolina State University<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div>-----------------------------------</div>Haiqing Jiang, PH.D student<d=
iv><br></div><div>Computer Science Department, North Carolina State Univers=
ity<br>

<div><br></div></div><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div>-----------------------------------</div>Haiqing Jiang, PH.D student<d=
iv><br></div><div>Computer Science Department, North Carolina State Univers=
ity<br>
<div><br></div></div><br>
</div>

--14dae9d7197607dcae04c59af06e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
