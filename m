MIME-Version: 1.0
In-Reply-To: <1343050007.23118.28.camel@moss-pluto.epoch.ncsc.mil>
References: <1342739276-1686-4-git-send-email-hqjiang1988@gmail.com>
	<1343050007.23118.28.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 23 Jul 2012 15:05:09 -0700
Message-ID: <CAO-4OdG2zH+9dDQYboh2itGN6a5cUMPc23TJO3vJZ6DDaR9TwA@mail.gmail.com>
Subject: Re: [PATCH 3/6] external/sepolicy: mediaserver talk to rild via socket
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d042184d96ea3bc04c58670b2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042184d96ea3bc04c58670b2
Content-Type: text/plain; charset=ISO-8859-1

If in that case, I don't think it's a good idea to allow permission to
mediaserver over rild. Thanks for your comments.

On Mon, Jul 23, 2012 at 6:26 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> > ---
> >  mediaserver.te |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/mediaserver.te b/mediaserver.te
> > index d3f0334..6dd4d4a 100644
> > --- a/mediaserver.te
> > +++ b/mediaserver.te
> > @@ -40,3 +40,6 @@ allow mediaserver camera_calibration_file:file
> r_file_perms;
> >  # Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
> >  allow mediaserver qtaguid_proc:file rw_file_perms;
> >  allow mediaserver qtaguid_device:chr_file r_file_perms;
> > +
> > +# Talk to rild via socket
> > +unix_socket_connect(mediaserver, rild, rild)
>
> Hmm...it used to be that only radio could connect to rild.
> socket perms are 660 root radio, and mediaserver runs as media.
> Doesn't seem like this is possible even under DAC.  Clarification
> requested?
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

--f46d042184d96ea3bc04c58670b2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

If in that case, I don&#39;t think it&#39;s a good idea to allow permission=
 to mediaserver over rild. Thanks for your comments.=A0<br><br><div class=
=3D"gmail_quote">On Mon, Jul 23, 2012 at 6:26 AM, Stephen Smalley <span dir=
=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tyc=
ho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:<br>
&gt; ---<br>
&gt; =A0mediaserver.te | =A0 =A03 +++<br>
&gt; =A01 files changed, 3 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/mediaserver.te b/mediaserver.te<br>
&gt; index d3f0334..6dd4d4a 100644<br>
&gt; --- a/mediaserver.te<br>
&gt; +++ b/mediaserver.te<br>
&gt; @@ -40,3 +40,6 @@ allow mediaserver camera_calibration_file:file r_fil=
e_perms;<br>
&gt; =A0# Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid<br>
&gt; =A0allow mediaserver qtaguid_proc:file rw_file_perms;<br>
&gt; =A0allow mediaserver qtaguid_device:chr_file r_file_perms;<br>
&gt; +<br>
&gt; +# Talk to rild via socket<br>
&gt; +unix_socket_connect(mediaserver, rild, rild)<br>
<br>
</div></div>Hmm...it used to be that only radio could connect to rild.<br>
socket perms are 660 root radio, and mediaserver runs as media.<br>
Doesn&#39;t seem like this is possible even under DAC. =A0Clarification<br>
requested?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div>-----------------------------------</div>Haiqing Jiang, PH.D student=
<div><br></div><div>Computer Science Department, North Carolina State Unive=
rsity<br>
<div><br></div></div><br>

--f46d042184d96ea3bc04c58670b2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
