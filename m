MIME-Version: 1.0
In-Reply-To: <1343135089.2383.28.camel@moss-pluto.epoch.ncsc.mil>
References: <1342739276-1686-4-git-send-email-hqjiang1988@gmail.com>
	<1343050007.23118.28.camel@moss-pluto.epoch.ncsc.mil>
	<CAO-4OdG2zH+9dDQYboh2itGN6a5cUMPc23TJO3vJZ6DDaR9TwA@mail.gmail.com>
	<1343135089.2383.28.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 24 Jul 2012 09:10:21 -0700
Message-ID: <CAO-4OdEJJg+gnXwRL75+WdsCFMcwjRLSuWUvQjY8eM2YqAnDyA@mail.gmail.com>
Subject: Re: [PATCH 3/6] external/sepolicy: mediaserver talk to rild via socket
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=14dae9d719766b99cf04c59599be
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--14dae9d719766b99cf04c59599be
Content-Type: text/plain; charset=ISO-8859-1

I cannot find the corresponding avc logs at this moment.. I will let you
know when I find it.

On Tue, Jul 24, 2012 at 6:04 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Mon, 2012-07-23 at 15:05 -0700, Haiqing Jiang wrote:
> > If in that case, I don't think it's a good idea to allow permission to
> > mediaserver over rild. Thanks for your comments.
>
> It may be legitimate, but I want to understand why and how it happens
> before allowing it.
>
> >
> > On Mon, Jul 23, 2012 at 6:26 AM, Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> >         On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> >         > ---
> >         >  mediaserver.te |    3 +++
> >         >  1 files changed, 3 insertions(+), 0 deletions(-)
> >         >
> >         > diff --git a/mediaserver.te b/mediaserver.te
> >         > index d3f0334..6dd4d4a 100644
> >         > --- a/mediaserver.te
> >         > +++ b/mediaserver.te
> >         > @@ -40,3 +40,6 @@ allow mediaserver
> >         camera_calibration_file:file r_file_perms;
> >         >  # Read/[write] to /proc/net/xt_qtaguid/ctrl
> >         and /dev/xt_qtaguid
> >         >  allow mediaserver qtaguid_proc:file rw_file_perms;
> >         >  allow mediaserver qtaguid_device:chr_file r_file_perms;
> >         > +
> >         > +# Talk to rild via socket
> >         > +unix_socket_connect(mediaserver, rild, rild)
> >
> >
> >         Hmm...it used to be that only radio could connect to rild.
> >         socket perms are 660 root radio, and mediaserver runs as
> >         media.
> >         Doesn't seem like this is possible even under DAC.
> >          Clarification
> >         requested?
> >
> >         --
> >         Stephen Smalley
> >         National Security Agency
> >
> >
> >
> >
> >
> > --
> > -----------------------------------
> > Haiqing Jiang, PH.D student
> >
> >
> > Computer Science Department, North Carolina State University
> >
> >
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

--14dae9d719766b99cf04c59599be
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I cannot find the corresponding avc logs at this moment.. I will let you kn=
ow when I find it.=A0<br><br><div class=3D"gmail_quote">On Tue, Jul 24, 201=
2 at 6:04 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@t=
ycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Mon, 2012-07-23 at 15:0=
5 -0700, Haiqing Jiang wrote:<br>
&gt; If in that case, I don&#39;t think it&#39;s a good idea to allow permi=
ssion to<br>
&gt; mediaserver over rild. Thanks for your comments.<br>
<br>
</div>It may be legitimate, but I want to understand why and how it happens=
<br>
before allowing it.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; On Mon, Jul 23, 2012 at 6:26 AM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
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

--14dae9d719766b99cf04c59599be--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
