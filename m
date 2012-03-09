MIME-Version: 1.0
In-Reply-To: <1331131202.16697.39.camel@moss-pluto>
References: <CAD8iFzxusoJpp=kAMjhT8-toA0N_ejDE=bFTjV7OvsJYyKeDtw@mail.gmail.com>
	<1331127372.16697.21.camel@moss-pluto>
	<CAD8iFzwjZbUsmPJan6tU-un9goYWxZFbrykqYXr3HU+o6ea1_Q@mail.gmail.com>
	<1331129177.16697.26.camel@moss-pluto>
	<1331131202.16697.39.camel@moss-pluto>
Date: Fri, 9 Mar 2012 12:37:08 -0800
Message-ID: <CAE-gBNb0LTW9Ce9K1M4cLsHQ96Qp0GOUxrBhXWBY-E9+b1=Zcg@mail.gmail.com>
Subject: Re: CTS failure on SEAndroid Galaxy Nexus
From: Fred Aguirre <2playerfootball@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Subramani Venkatesh <selinuxv31@gmail.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b33d60c42dd3204bad55b0e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b33d60c42dd3204bad55b0e
Content-Type: text/plain; charset=ISO-8859-1

List

On Wed, Mar 7, 2012 at 6:40 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2012-03-07 at 09:06 -0500, Stephen Smalley wrote:
> > On Wed, 2012-03-07 at 08:57 -0500, Subramani Venkatesh wrote:
> > > Hi Stephen,
> > >
> > > Thanks for the response, my comments are inlined
> > >
> > > On Wed, Mar 7, 2012 at 8:36 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > > > On Wed, 2012-03-07 at 08:18 -0500, Subramani Venkatesh wrote:
> > > >> Hi,
> > > >> Trying to execute CTS on SEAndroid with security enforce, but I am
> not
> > > >> successful getting it working, it crashes at the very beginning with
> > > >> an exeception, is anyone else seeing the same issue?
> > > >
> > > > First, did you make sure that you had no avc messages before going
> into
> > > > enforcing mode and even trying to run the CTS?  adb shell dmesg |
> grep
> > > > avc should yield no output.
> > > <Subbu>: I fixed most of it, they were couple of them missing, I will
> > > fix them and try again.
> > > >
> > > > Second, make sure you can run the CTS in permissive mode without any
> > > > difficulties as your baseline.
> > > <Subbu>: Yes CTS executes in permissive mode without any issues.
> > > >
> > > > Third, make sure you enable the android_cts policy boolean before
> > > > running the CTS.  If you have configured the CTS to not reboot the
> > > > device (set maxTestCount to -1 in repository/host_config.xml), then
> you
> > > > can just do this once via adb shell su 0 setsebool android_cts=1.
> > > > Otherwise, if you want to allow periodic reboots during the CTS, you
> > > > need to add setsebool android_cts=1 and setenforce 1 to your init.rc
> or
> > > > init.<board>.rc file so that it happens on each boot.
> > > <Subbu>: I did enable android_cts_policy boolean, I shall try changed
> > > my init.rc file to setenforce 1 all the time.
> >
> > If you can run the CTS while in permissive mode, then you should do that
> > again (leaving it in permissive mode, with android_cts=1) and collect up
> > the denials.
> >
> > adb shell su 0 cat /proc/kmsg > dmesg.txt
> >
> > You can then add any necessary rules to cts.te under the boolean.
>
> Just tried this myself, and I see that we'll need to make a few
> adjustments to policy for the current CTS.  Some of those will be made
> unconditionally outside of the android_cts boolean, while others are
> really only appropriate under test conditions and not production use.
>
> --
> Stephen Smalley
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--047d7b33d60c42dd3204bad55b0e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

List<br><br><div class=3D"gmail_quote">On Wed, Mar 7, 2012 at 6:40 AM, Step=
hen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@=
tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote style=3D"margin:0px 0px =
0px 0.8ex;padding-left:1ex;border-left-color:rgb(204,204,204);border-left-w=
idth:1px;border-left-style:solid" class=3D"gmail_quote">
On Wed, 2012-03-07 at 09:06 -0500, Stephen Smalley wrote:<br>
&gt; On Wed, 2012-03-07 at 08:57 -0500, Subramani Venkatesh wrote:<br>
&gt; &gt; Hi Stephen,<br>
&gt; &gt;<br>
&gt; &gt; Thanks for the response, my comments are inlined<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Mar 7, 2012 at 8:36 AM, Stephen Smalley &lt;<a href=3D"ma=
ilto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt; &gt; &gt; On Wed, 2012-03-07 at 08:18 -0500, Subramani Venkatesh wrote=
:<br>
&gt; &gt; &gt;&gt; Hi,<br>
&gt; &gt; &gt;&gt; Trying to execute CTS on SEAndroid with security enforce=
, but I am not<br>
&gt; &gt; &gt;&gt; successful getting it working, it crashes at the very be=
ginning with<br>
&gt; &gt; &gt;&gt; an exeception, is anyone else seeing the same issue?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; First, did you make sure that you had no avc messages before=
 going into<br>
&gt; &gt; &gt; enforcing mode and even trying to run the CTS? =A0adb shell =
dmesg | grep<br>
&gt; &gt; &gt; avc should yield no output.<br>
&gt; &gt; &lt;Subbu&gt;: I fixed most of it, they were couple of them missi=
ng, I will<br>
&gt; &gt; fix them and try again.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Second, make sure you can run the CTS in permissive mode wit=
hout any<br>
&gt; &gt; &gt; difficulties as your baseline.<br>
&gt; &gt; &lt;Subbu&gt;: Yes CTS executes in permissive mode without any is=
sues.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Third, make sure you enable the android_cts policy boolean b=
efore<br>
&gt; &gt; &gt; running the CTS. =A0If you have configured the CTS to not re=
boot the<br>
&gt; &gt; &gt; device (set maxTestCount to -1 in repository/host_config.xml=
), then you<br>
&gt; &gt; &gt; can just do this once via adb shell su 0 setsebool android_c=
ts=3D1.<br>
&gt; &gt; &gt; Otherwise, if you want to allow periodic reboots during the =
CTS, you<br>
&gt; &gt; &gt; need to add setsebool android_cts=3D1 and setenforce 1 to yo=
ur init.rc or<br>
&gt; &gt; &gt; init.&lt;board&gt;.rc file so that it happens on each boot.<=
br>
&gt; &gt; &lt;Subbu&gt;: I did enable android_cts_policy boolean, I shall t=
ry changed<br>
&gt; &gt; my init.rc file to setenforce 1 all the time.<br>
&gt;<br>
&gt; If you can run the CTS while in permissive mode, then you should do th=
at<br>
&gt; again (leaving it in permissive mode, with android_cts=3D1) and collec=
t up<br>
&gt; the denials.<br>
&gt;<br>
&gt; adb shell su 0 cat /proc/kmsg &gt; dmesg.txt<br>
&gt;<br>
&gt; You can then add any necessary rules to cts.te under the boolean.<br>
<br>
Just tried this myself, and I see that we&#39;ll need to make a few<br>
adjustments to policy for the current CTS. =A0Some of those will be made<br=
>
unconditionally outside of the android_cts boolean, while others are<br>
really only appropriate under test conditions and not production use.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></span></blockquote></div><br>

--047d7b33d60c42dd3204bad55b0e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
