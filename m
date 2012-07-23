MIME-Version: 1.0
In-Reply-To: <1343049803.23118.25.camel@moss-pluto.epoch.ncsc.mil>
References: <1342739276-1686-3-git-send-email-hqjiang1988@gmail.com>
	<1343049803.23118.25.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 23 Jul 2012 09:22:12 -0700
Message-ID: <CAO-4OdEgeDCosnK8Nm8HOTFF+Q-tE4242UA5Bw7f-a-on4yRrA@mail.gmail.com>
Subject: Re: [PATCH 2/6] external/sepolicy: mediaserver open application data files
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d0401730bf4d49804c581a554
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0401730bf4d49804c581a554
Content-Type: text/plain; charset=ISO-8859-1

Thanks. I should be more careful to find the related existing policies.

On Mon, Jul 23, 2012 at 6:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> > ---
> >  mediaserver.te |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/mediaserver.te b/mediaserver.te
> > index 057e39d..d3f0334 100644
> > --- a/mediaserver.te
> > +++ b/mediaserver.te
> > @@ -25,6 +25,7 @@ allow mediaserver sysfs:file rw_file_perms;
> >  # XXX Why?
> >  allow mediaserver apk_data_file:file { read getattr };
> >  allow mediaserver ion_device:chr_file rw_file_perms;
> > +allow mediaserver app_data_file:file open;
> >
> >  # To use remote processor
> >  allow mediaserver rpmsg_device:chr_file rw_file_perms;
>
> If this is required, then merge it into the existing allow rule for
> app_data_file, at which point you can just use r_file_perms;
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--f46d0401730bf4d49804c581a554
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks. I should be more careful to find the related existing policies.=A0<=
br><br><div class=3D"gmail_quote">On Mon, Jul 23, 2012 at 6:23 AM, Stephen =
Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=
=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:<br>
&gt; ---<br>
&gt; =A0mediaserver.te | =A0 =A01 +<br>
&gt; =A01 files changed, 1 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/mediaserver.te b/mediaserver.te<br>
&gt; index 057e39d..d3f0334 100644<br>
&gt; --- a/mediaserver.te<br>
&gt; +++ b/mediaserver.te<br>
&gt; @@ -25,6 +25,7 @@ allow mediaserver sysfs:file rw_file_perms;<br>
&gt; =A0# XXX Why?<br>
&gt; =A0allow mediaserver apk_data_file:file { read getattr };<br>
&gt; =A0allow mediaserver ion_device:chr_file rw_file_perms;<br>
&gt; +allow mediaserver app_data_file:file open;<br>
&gt;<br>
&gt; =A0# To use remote processor<br>
&gt; =A0allow mediaserver rpmsg_device:chr_file rw_file_perms;<br>
<br>
</div></div>If this is required, then merge it into the existing allow rule=
 for<br>
app_data_file, at which point you can just use r_file_perms;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div>-----------------------------------</div>Haiqing Jiang, PH.D student=
<div><br></div><div>Computer Science Department, North Carolina State Unive=
rsity<br>
<div><br></div></div><br>

--f46d0401730bf4d49804c581a554--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
