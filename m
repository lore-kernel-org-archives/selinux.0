MIME-Version: 1.0
In-Reply-To: <1343417710.17570.91.camel@moss-pluto.epoch.ncsc.mil>
References: <1343414055-3831-1-git-send-email-hqjiang1988@gmail.com>
	<1343414258.17570.72.camel@moss-pluto.epoch.ncsc.mil>
	<CAO-4OdF=FRiKqUhVwPeucHRrKsYWBNJiRktJJhHnNYf_=V1cwA@mail.gmail.com>
	<1343415126.17570.82.camel@moss-pluto.epoch.ncsc.mil>
	<CAO-4OdEq6VXhytSV1MW=PK-HCrN=epixK5HRMPi0PR-Ay0d-=A@mail.gmail.com>
	<1343417710.17570.91.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 27 Jul 2012 12:42:57 -0700
Message-ID: <CAO-4OdEUaZtXx7bc7n_XWWi7DE8FJDsXEM+EfXodXH_vzwvfqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] allocate perms to platformappdomain over system_data_file
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com,
        "Craig, Robert P." <rpcraig@tycho.ncsc.mil>
Content-Type: multipart/alternative; boundary=f46d0401240b414bb904c5d4eb57
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0401240b414bb904c5d4eb57
Content-Type: text/plain; charset=ISO-8859-1

I don't need to modify the patch. So, could you help to update the patch to
branches? Thanks.

On Fri, Jul 27, 2012 at 12:35 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2012-07-27 at 12:33 -0700, Haiqing Jiang wrote:
> > Exactly. I was thinking of adding the policy into if (app_ndk). But
> > later on I wondered whether it could be generic for platformappdomain.
> > So, what is your opinion? Add the permissions to if (app_ndk) or to
> > platformappdomain rules? Thanks.
>
> The latter.  Although this suggests to me that we ought to explore using
> different types on the lib directory for platform apps vs. third party
> apps, possibly based on seinfo=, so that we can allow platform apps to
> execute platform shared objects while blocking execution of any .so
> files shipped by a third party app as a safety measure.
>
> >
> > On Fri, Jul 27, 2012 at 11:52 AM, Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> >         On Fri, 2012-07-27 at 11:46 -0700, Haiqing Jiang wrote:
> >         > This is the denial information. What is your opinion?
> >         Thanks.
> >         >
> >         >
> >         > 5>[ 2978.206604] type=1400 audit(1342634359.195:1155): avc:
> >          denied
> >         >  { open } for  pid=10393 comm="android.cts.jni"
> >         name="libjnitest.so"
> >         > dev=mmcblk0p12 ino=578521 scontext=u:r:release_app:s0:c41
> >         > tcontext=u:object_r:system_data_file:s0 tclass=file
> >         > <5>[12124.019561] type=1400 audit(1342643505.007:1919):
> >         avc:  denied
> >         > { open } for  pid=24055 comm="ationTestRunner"
> >         > name="libctspermission_jni.so" dev=mmcblk0p12 ino=578541
> >         > scontext=u:r:release_app:s0:c41
> >         > tcontext=u:object_r:system_data_file:s0 tclass=file
> >
> >
> >         It is trying to execute a shared object from the lib
> >         directory.  So it
> >         is the same as app_ndk, except for platformappdomain rather
> >         than
> >         untrusted_app.
> >
> >         >
> >         >
> >         > On Fri, Jul 27, 2012 at 11:37 AM, Stephen Smalley
> >         <sds@tycho.nsa.gov>
> >         > wrote:
> >         >         On Fri, 2012-07-27 at 11:34 -0700, Haiqing Jiang
> >         wrote:
> >         >         > ---
> >         >         >  app.te |    2 ++
> >         >         >  1 files changed, 2 insertions(+), 0 deletions(-)
> >         >         >
> >         >         > diff --git a/app.te b/app.te
> >         >         > index 85de816..dca2e0c 100644
> >         >         > --- a/app.te
> >         >         > +++ b/app.te
> >         >         > @@ -83,6 +83,8 @@ allow platformappdomain
> >         >         platform_app_data_file:notdevfile_class_set
> >         create_file_
> >         >         >  # App sdcard file accesses
> >         >         >  allow platformappdomain sdcard:dir
> >         create_dir_perms;
> >         >         >  allow platformappdomain sdcard:file
> >         create_file_perms;
> >         >         > +# System data file accesses XXX????
> >         >         > +allow platformappdomain system_data_file:file
> >         open;
> >         >         >
> >         >         >  #
> >         >         >  # Untrusted apps.
> >         >
> >         >
> >         >         Need to know more about the denial to diagnose.
> >         >         Also, enabling syscall audit may help with getting
> >         full
> >         >         pathnames,
> >         >         although you likely need the ARM audit patches for
> >         that.
> >         >
> >         >         --
> >         >         Stephen Smalley
> >         >         National Security Agency
> >         >
> >         >
> >         >
> >         >
> >         >
> >         > --
> >         > -----------------------------------
> >         > Haiqing Jiang, PH.D student
> >         >
> >         >
> >         > Computer Science Department, North Carolina State University
> >         >
> >         >
> >         >
> >         >
> >
> >         --
> >         Stephen Smalley
> >         National Security Agency
> >
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

--f46d0401240b414bb904c5d4eb57
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I don&#39;t need to modify the patch. So, could you help to update the patc=
h to branches? Thanks.=A0<br><br><div class=3D"gmail_quote">On Fri, Jul 27,=
 2012 at 12:35 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:=
sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote=
:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Fri, 2012-07-27 at 12:3=
3 -0700, Haiqing Jiang wrote:<br>
&gt; Exactly. I was thinking of adding the policy into if (app_ndk). But<br=
>
&gt; later on I wondered whether it could be generic for platformappdomain.=
<br>
&gt; So, what is your opinion? Add the permissions to if (app_ndk) or to<br=
>
&gt; platformappdomain rules? Thanks.<br>
<br>
</div>The latter. =A0Although this suggests to me that we ought to explore =
using<br>
different types on the lib directory for platform apps vs. third party<br>
apps, possibly based on seinfo=3D, so that we can allow platform apps to<br=
>
execute platform shared objects while blocking execution of any .so<br>
files shipped by a third party app as a safety measure.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; On Fri, Jul 27, 2012 at 11:52 AM, Stephen Smalley &lt;<a href=3D"mailt=
o:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 On Fri, 2012-07-27 at 11:46 -0700, Haiqing Jiang wrote=
:<br>
&gt; =A0 =A0 =A0 =A0 &gt; This is the denial information. What is your opin=
ion?<br>
&gt; =A0 =A0 =A0 =A0 Thanks.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 5&gt;[ 2978.206604] type=3D1400 audit(1342634359.=
195:1155): avc:<br>
&gt; =A0 =A0 =A0 =A0 =A0denied<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0{ open } for =A0pid=3D10393 comm=3D&quot;andro=
id.cts.jni&quot;<br>
&gt; =A0 =A0 =A0 =A0 name=3D&quot;libjnitest.so&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt; dev=3Dmmcblk0p12 ino=3D578521 scontext=3Du:r:rele=
ase_app:s0:c41<br>
&gt; =A0 =A0 =A0 =A0 &gt; tcontext=3Du:object_r:system_data_file:s0 tclass=
=3Dfile<br>
&gt; =A0 =A0 =A0 =A0 &gt; &lt;5&gt;[12124.019561] type=3D1400 audit(1342643=
505.007:1919):<br>
&gt; =A0 =A0 =A0 =A0 avc: =A0denied<br>
&gt; =A0 =A0 =A0 =A0 &gt; { open } for =A0pid=3D24055 comm=3D&quot;ationTes=
tRunner&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt; name=3D&quot;libctspermission_jni.so&quot; dev=3D=
mmcblk0p12 ino=3D578541<br>
&gt; =A0 =A0 =A0 =A0 &gt; scontext=3Du:r:release_app:s0:c41<br>
&gt; =A0 =A0 =A0 =A0 &gt; tcontext=3Du:object_r:system_data_file:s0 tclass=
=3Dfile<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 It is trying to execute a shared object from the lib<b=
r>
&gt; =A0 =A0 =A0 =A0 directory. =A0So it<br>
&gt; =A0 =A0 =A0 =A0 is the same as app_ndk, except for platformappdomain r=
ather<br>
&gt; =A0 =A0 =A0 =A0 than<br>
&gt; =A0 =A0 =A0 =A0 untrusted_app.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; On Fri, Jul 27, 2012 at 11:37 AM, Stephen Smalley=
<br>
&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa=
.gov</a>&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 On Fri, 2012-07-27 at 11:34 -0700=
, Haiqing Jiang<br>
&gt; =A0 =A0 =A0 =A0 wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; ---<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0app.te | =A0 =A02 ++<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A01 files changed, 2 insert=
ions(+), 0 deletions(-)<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; diff --git a/app.te b/app.te=
<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; index 85de816..dca2e0c 10064=
4<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; --- a/app.te<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; +++ b/app.te<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; @@ -83,6 +83,8 @@ allow plat=
formappdomain<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 platform_app_data_file:notdevfile=
_class_set<br>
&gt; =A0 =A0 =A0 =A0 create_file_<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0# App sdcard file accesse=
s<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0allow platformappdomain s=
dcard:dir<br>
&gt; =A0 =A0 =A0 =A0 create_dir_perms;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0allow platformappdomain s=
dcard:file<br>
&gt; =A0 =A0 =A0 =A0 create_file_perms;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; +# System data file accesses=
 XXX????<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; +allow platformappdomain sys=
tem_data_file:file<br>
&gt; =A0 =A0 =A0 =A0 open;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0#<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 &gt; =A0# Untrusted apps.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 Need to know more about the denia=
l to diagnose.<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 Also, enabling syscall audit may =
help with getting<br>
&gt; =A0 =A0 =A0 =A0 full<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 pathnames,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 although you likely need the ARM =
audit patches for<br>
&gt; =A0 =A0 =A0 =A0 that.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 Stephen Smalley<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 National Security Agency<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; --<br>
&gt; =A0 =A0 =A0 =A0 &gt; -----------------------------------<br>
&gt; =A0 =A0 =A0 =A0 &gt; Haiqing Jiang, PH.D student<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Computer Science Department, North Carolina State=
 University<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 Stephen Smalley<br>
&gt; =A0 =A0 =A0 =A0 National Security Agency<br>
&gt;<br>
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

--f46d0401240b414bb904c5d4eb57--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
