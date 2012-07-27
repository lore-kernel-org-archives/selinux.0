MIME-Version: 1.0
In-Reply-To: <1343414258.17570.72.camel@moss-pluto.epoch.ncsc.mil>
References: <1343414055-3831-1-git-send-email-hqjiang1988@gmail.com>
	<1343414258.17570.72.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 27 Jul 2012 11:46:52 -0700
Message-ID: <CAO-4OdF=FRiKqUhVwPeucHRrKsYWBNJiRktJJhHnNYf_=V1cwA@mail.gmail.com>
Subject: Re: [PATCH 1/1] allocate perms to platformappdomain over system_data_file
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d042c6c4dae180204c5d422a5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042c6c4dae180204c5d422a5
Content-Type: text/plain; charset=ISO-8859-1

This is the denial information. What is your opinion? Thanks.

5>[ 2978.206604] type=1400 audit(1342634359.195:1155): avc:  denied  { open
} for  pid=10393 comm="android.cts.jni" name="libjnitest.so" dev=mmcblk0p12
ino=578521 scontext=u:r:release_app:s0:c41
tcontext=u:object_r:system_data_file:s0 tclass=file
<5>[12124.019561] type=1400 audit(1342643505.007:1919): avc:  denied  {
open } for  pid=24055 comm="ationTestRunner" name="libctspermission_jni.so"
dev=mmcblk0p12 ino=578541 scontext=u:r:release_app:s0:c41
tcontext=u:object_r:system_data_file:s0 tclass=file


On Fri, Jul 27, 2012 at 11:37 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2012-07-27 at 11:34 -0700, Haiqing Jiang wrote:
> > ---
> >  app.te |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/app.te b/app.te
> > index 85de816..dca2e0c 100644
> > --- a/app.te
> > +++ b/app.te
> > @@ -83,6 +83,8 @@ allow platformappdomain
> platform_app_data_file:notdevfile_class_set create_file_
> >  # App sdcard file accesses
> >  allow platformappdomain sdcard:dir create_dir_perms;
> >  allow platformappdomain sdcard:file create_file_perms;
> > +# System data file accesses XXX????
> > +allow platformappdomain system_data_file:file open;
> >
> >  #
> >  # Untrusted apps.
>
> Need to know more about the denial to diagnose.
> Also, enabling syscall audit may help with getting full pathnames,
> although you likely need the ARM audit patches for that.
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

--f46d042c6c4dae180204c5d422a5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is the denial information. What is your opinion? Thanks.=A0<div><br></=
div><div><div>5&gt;[ 2978.206604] type=3D1400 audit(1342634359.195:1155): a=
vc: =A0denied =A0{ open } for =A0pid=3D10393 comm=3D&quot;android.cts.jni&q=
uot; name=3D&quot;libjnitest.so&quot; dev=3Dmmcblk0p12 ino=3D578521 scontex=
t=3Du:r:release_app:s0:c41 tcontext=3Du:object_r:system_data_file:s0 tclass=
=3Dfile</div>
<div>&lt;5&gt;[12124.019561] type=3D1400 audit(1342643505.007:1919): avc: =
=A0denied =A0{ open } for =A0pid=3D24055 comm=3D&quot;ationTestRunner&quot;=
 name=3D&quot;libctspermission_jni.so&quot; dev=3Dmmcblk0p12 ino=3D578541 s=
context=3Du:r:release_app:s0:c41 tcontext=3Du:object_r:system_data_file:s0 =
tclass=3Dfile</div>
<div><br></div><br><div class=3D"gmail_quote">On Fri, Jul 27, 2012 at 11:37=
 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.=
gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Fri, 2012-07-27 at 11:34 -0700, =
Haiqing Jiang wrote:<br>
&gt; ---<br>
&gt; =A0app.te | =A0 =A02 ++<br>
&gt; =A01 files changed, 2 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/app.te b/app.te<br>
&gt; index 85de816..dca2e0c 100644<br>
&gt; --- a/app.te<br>
&gt; +++ b/app.te<br>
&gt; @@ -83,6 +83,8 @@ allow platformappdomain platform_app_data_file:notde=
vfile_class_set create_file_<br>
&gt; =A0# App sdcard file accesses<br>
&gt; =A0allow platformappdomain sdcard:dir create_dir_perms;<br>
&gt; =A0allow platformappdomain sdcard:file create_file_perms;<br>
&gt; +# System data file accesses XXX????<br>
&gt; +allow platformappdomain system_data_file:file open;<br>
&gt;<br>
&gt; =A0#<br>
&gt; =A0# Untrusted apps.<br>
<br>
</div></div>Need to know more about the denial to diagnose.<br>
Also, enabling syscall audit may help with getting full pathnames,<br>
although you likely need the ARM audit patches for that.<br>
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
</div>

--f46d042c6c4dae180204c5d422a5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
