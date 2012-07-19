MIME-Version: 1.0
Date: Thu, 19 Jul 2012 13:51:02 -0700
Message-ID: <CAO-4OdEsiBOPifHoQK+oPv63MJXfDPzaGLrA8ED_z768Ko5edg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Target the denials/policies over qtaguid file and
 device: 1. Relabel /proc/net/xt_qtaguid/ctrl from "qtaguid" to
 "qtaguid_proc"; 2. Label /dev/xt_qtaguid with "qtaguid_device"; 3. Allow
 mediaserver read/[write] to qtaguid_proc and qta
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary=f46d04088fad0925c204c534f0dd
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04088fad0925c204c534f0dd
Content-Type: text/plain; charset=ISO-8859-1

Thanks for your kind reminder. I will be careful next time.

Best,

On Thu, Jul 19, 2012 at 1:14 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-07-19 at 11:07 -0700, hqjiang wrote:
> > Actually, some of policies related to qtaguid have been there already,
> but
> > we refind existing ones and add new ones.
>
> Applied to external/sepolicy.  Next time, put the project name in the
> subject line, keep the subject line shorter, and put the longer
> description in the body.  Also, try to avoid renaming types unless truly
> justified and consider adding a typealias when doing so to avoid
> breakage on policy reload on a running system.
>
> > ---
> >  app.te         |    6 ++++--
> >  device.te      |    1 +
> >  file.te        |    2 +-
> >  file_contexts  |    1 +
> >  genfs_contexts |    2 +-
> >  mediaserver.te |    4 ++++
> >  system.te      |    3 ++-
> >  7 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/app.te b/app.te
> > index c55f4e0..0866e95 100644
> > --- a/app.te
> > +++ b/app.te
> > @@ -42,7 +42,9 @@ allow media_app cache_file:file create_file_perms;
> >  # Access sdcard.
> >  allow media_app sdcard:dir create_dir_perms;
> >  allow media_app sdcard:file create_file_perms;
> > -
> > +# Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
> > +allow media_app qtaguid_proc:file rw_file_perms;
> > +allow media_app qtaguid_device:chr_file r_file_perms;
> >  # Apps signed with the shared key.
> >  type shared_app, domain;
> >  app_domain(shared_app)
> > @@ -141,7 +143,7 @@ allow appdomain anr_data_file:dir search;
> >  allow appdomain anr_data_file:file { open append };
> >
> >  # Write to /proc/net/xt_qtaguid/ctrl file.
> > -allow appdomain qtaguid:file write;
> > +allow appdomain qtaguid_proc:file write;
> >
> >  # Use the Binder.
> >  binder_use(appdomain)
> > diff --git a/device.te b/device.te
> > index c9098e9..7818ce8 100644
> > --- a/device.te
> > +++ b/device.te
> > @@ -40,6 +40,7 @@ type zero_device, dev_type;
> >  type fuse_device, dev_type;
> >  type ion_device, dev_type;
> >  type gps_device, dev_type;
> > +type qtaguid_device, dev_type;
> >
> >  # All devices have a uart for the hci
> >  # attach service. The uart dev node
> > diff --git a/file.te b/file.te
> > index e5c8502..9af8ca5 100644
> > --- a/file.te
> > +++ b/file.te
> > @@ -4,7 +4,7 @@ type pipefs, fs_type;
> >  type sockfs, fs_type;
> >  type rootfs, fs_type;
> >  type proc, fs_type;
> > -type qtaguid, fs_type, mlstrustedobject;
> > +type qtaguid_proc, fs_type, mlstrustedobject;
> >  type selinuxfs, fs_type;
> >  type cgroup, fs_type, mlstrustedobject;
> >  type sysfs, fs_type, mlstrustedobject;
> > diff --git a/file_contexts b/file_contexts
> > index 39c4363..f7abbb7 100644
> > --- a/file_contexts
> > +++ b/file_contexts
> > @@ -77,6 +77,7 @@
> >  /dev/urandom         u:object_r:urandom_device:s0
> >  /dev/vcs[0-9a-z]*    u:object_r:vcs_device:s0
> >  /dev/video[0-9]*     u:object_r:video_device:s0
> > +/dev/xt_qtaguid      u:object_r:qtaguid_device:s0
> >  /dev/zero            u:object_r:zero_device:s0
> >  #############################
> >  # System files
> > diff --git a/genfs_contexts b/genfs_contexts
> > index 103136c..ff633a7 100644
> > --- a/genfs_contexts
> > +++ b/genfs_contexts
> > @@ -2,7 +2,7 @@
> >  genfscon rootfs / u:object_r:rootfs:s0
> >  # proc labeling can be further refined (longest matching prefix).
> >  genfscon proc / u:object_r:proc:s0
> > -genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0
> > +genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid_proc:s0
> >  # selinuxfs booleans can be individually labeled.
> >  genfscon selinuxfs / u:object_r:selinuxfs:s0
> >  genfscon cgroup / u:object_r:cgroup:s0
> > diff --git a/mediaserver.te b/mediaserver.te
> > index 8d37fb7..057e39d 100644
> > --- a/mediaserver.te
> > +++ b/mediaserver.te
> > @@ -35,3 +35,7 @@ allow mediaserver system:fifo_file r_file_perms;
> >  # Camera calibration
> >  allow mediaserver camera_calibration_file:dir r_dir_perms;
> >  allow mediaserver camera_calibration_file:file r_file_perms;
> > +
> > +# Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid
> > +allow mediaserver qtaguid_proc:file rw_file_perms;
> > +allow mediaserver qtaguid_device:chr_file r_file_perms;
> > diff --git a/system.te b/system.te
> > index 04ff84c..a4065cf 100644
> > --- a/system.te
> > +++ b/system.te
> > @@ -89,7 +89,8 @@ allow system appdomain:dir r_dir_perms;
> >  allow system appdomain:{ file lnk_file } rw_file_perms;
> >
> >  # Write to /proc/net/xt_qtaguid/ctrl.
> > -allow system qtaguid:file rw_file_perms;
> > +allow system qtaguid_proc:file rw_file_perms;
> > +allow system qtaguid_device:chr_file rw_file_perms;
> >
> >  # Notify init of death.
> >  allow system init:process sigchld;
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

--f46d04088fad0925c204c534f0dd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for your kind reminder. I will be careful next time.=A0<div><br></di=
v><div>Best,<br><br><div class=3D"gmail_quote">On Thu, Jul 19, 2012 at 1:14=
 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.=
gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Thu, 2012-07-19 at 11:0=
7 -0700, hqjiang wrote:<br>
&gt; Actually, some of policies related to qtaguid have been there already,=
 but<br>
&gt; we refind existing ones and add new ones.<br>
<br>
</div>Applied to external/sepolicy. =A0Next time, put the project name in t=
he<br>
subject line, keep the subject line shorter, and put the longer<br>
description in the body. =A0Also, try to avoid renaming types unless truly<=
br>
justified and consider adding a typealias when doing so to avoid<br>
breakage on policy reload on a running system.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0app.te =A0 =A0 =A0 =A0 | =A0 =A06 ++++--<br>
&gt; =A0device.te =A0 =A0 =A0| =A0 =A01 +<br>
&gt; =A0file.te =A0 =A0 =A0 =A0| =A0 =A02 +-<br>
&gt; =A0file_contexts =A0| =A0 =A01 +<br>
&gt; =A0genfs_contexts | =A0 =A02 +-<br>
&gt; =A0mediaserver.te | =A0 =A04 ++++<br>
&gt; =A0system.te =A0 =A0 =A0| =A0 =A03 ++-<br>
&gt; =A07 files changed, 14 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/app.te b/app.te<br>
&gt; index c55f4e0..0866e95 100644<br>
&gt; --- a/app.te<br>
&gt; +++ b/app.te<br>
&gt; @@ -42,7 +42,9 @@ allow media_app cache_file:file create_file_perms;<b=
r>
&gt; =A0# Access sdcard.<br>
&gt; =A0allow media_app sdcard:dir create_dir_perms;<br>
&gt; =A0allow media_app sdcard:file create_file_perms;<br>
&gt; -<br>
&gt; +# Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid<br>
&gt; +allow media_app qtaguid_proc:file rw_file_perms;<br>
&gt; +allow media_app qtaguid_device:chr_file r_file_perms;<br>
&gt; =A0# Apps signed with the shared key.<br>
&gt; =A0type shared_app, domain;<br>
&gt; =A0app_domain(shared_app)<br>
&gt; @@ -141,7 +143,7 @@ allow appdomain anr_data_file:dir search;<br>
&gt; =A0allow appdomain anr_data_file:file { open append };<br>
&gt;<br>
&gt; =A0# Write to /proc/net/xt_qtaguid/ctrl file.<br>
&gt; -allow appdomain qtaguid:file write;<br>
&gt; +allow appdomain qtaguid_proc:file write;<br>
&gt;<br>
&gt; =A0# Use the Binder.<br>
&gt; =A0binder_use(appdomain)<br>
&gt; diff --git a/device.te b/device.te<br>
&gt; index c9098e9..7818ce8 100644<br>
&gt; --- a/device.te<br>
&gt; +++ b/device.te<br>
&gt; @@ -40,6 +40,7 @@ type zero_device, dev_type;<br>
&gt; =A0type fuse_device, dev_type;<br>
&gt; =A0type ion_device, dev_type;<br>
&gt; =A0type gps_device, dev_type;<br>
&gt; +type qtaguid_device, dev_type;<br>
&gt;<br>
&gt; =A0# All devices have a uart for the hci<br>
&gt; =A0# attach service. The uart dev node<br>
&gt; diff --git a/file.te b/file.te<br>
&gt; index e5c8502..9af8ca5 100644<br>
&gt; --- a/file.te<br>
&gt; +++ b/file.te<br>
&gt; @@ -4,7 +4,7 @@ type pipefs, fs_type;<br>
&gt; =A0type sockfs, fs_type;<br>
&gt; =A0type rootfs, fs_type;<br>
&gt; =A0type proc, fs_type;<br>
&gt; -type qtaguid, fs_type, mlstrustedobject;<br>
&gt; +type qtaguid_proc, fs_type, mlstrustedobject;<br>
&gt; =A0type selinuxfs, fs_type;<br>
&gt; =A0type cgroup, fs_type, mlstrustedobject;<br>
&gt; =A0type sysfs, fs_type, mlstrustedobject;<br>
&gt; diff --git a/file_contexts b/file_contexts<br>
&gt; index 39c4363..f7abbb7 100644<br>
&gt; --- a/file_contexts<br>
&gt; +++ b/file_contexts<br>
&gt; @@ -77,6 +77,7 @@<br>
&gt; =A0/dev/urandom =A0 =A0 =A0 =A0 u:object_r:urandom_device:s0<br>
&gt; =A0/dev/vcs[0-9a-z]* =A0 =A0u:object_r:vcs_device:s0<br>
&gt; =A0/dev/video[0-9]* =A0 =A0 u:object_r:video_device:s0<br>
&gt; +/dev/xt_qtaguid =A0 =A0 =A0u:object_r:qtaguid_device:s0<br>
&gt; =A0/dev/zero =A0 =A0 =A0 =A0 =A0 =A0u:object_r:zero_device:s0<br>
&gt; =A0#############################<br>
&gt; =A0# System files<br>
&gt; diff --git a/genfs_contexts b/genfs_contexts<br>
&gt; index 103136c..ff633a7 100644<br>
&gt; --- a/genfs_contexts<br>
&gt; +++ b/genfs_contexts<br>
&gt; @@ -2,7 +2,7 @@<br>
&gt; =A0genfscon rootfs / u:object_r:rootfs:s0<br>
&gt; =A0# proc labeling can be further refined (longest matching prefix).<b=
r>
&gt; =A0genfscon proc / u:object_r:proc:s0<br>
&gt; -genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid:s0<br>
&gt; +genfscon proc /net/xt_qtaguid/ctrl u:object_r:qtaguid_proc:s0<br>
&gt; =A0# selinuxfs booleans can be individually labeled.<br>
&gt; =A0genfscon selinuxfs / u:object_r:selinuxfs:s0<br>
&gt; =A0genfscon cgroup / u:object_r:cgroup:s0<br>
&gt; diff --git a/mediaserver.te b/mediaserver.te<br>
&gt; index 8d37fb7..057e39d 100644<br>
&gt; --- a/mediaserver.te<br>
&gt; +++ b/mediaserver.te<br>
&gt; @@ -35,3 +35,7 @@ allow mediaserver system:fifo_file r_file_perms;<br>
&gt; =A0# Camera calibration<br>
&gt; =A0allow mediaserver camera_calibration_file:dir r_dir_perms;<br>
&gt; =A0allow mediaserver camera_calibration_file:file r_file_perms;<br>
&gt; +<br>
&gt; +# Read/[write] to /proc/net/xt_qtaguid/ctrl and /dev/xt_qtaguid<br>
&gt; +allow mediaserver qtaguid_proc:file rw_file_perms;<br>
&gt; +allow mediaserver qtaguid_device:chr_file r_file_perms;<br>
&gt; diff --git a/system.te b/system.te<br>
&gt; index 04ff84c..a4065cf 100644<br>
&gt; --- a/system.te<br>
&gt; +++ b/system.te<br>
&gt; @@ -89,7 +89,8 @@ allow system appdomain:dir r_dir_perms;<br>
&gt; =A0allow system appdomain:{ file lnk_file } rw_file_perms;<br>
&gt;<br>
&gt; =A0# Write to /proc/net/xt_qtaguid/ctrl.<br>
&gt; -allow system qtaguid:file rw_file_perms;<br>
&gt; +allow system qtaguid_proc:file rw_file_perms;<br>
&gt; +allow system qtaguid_device:chr_file rw_file_perms;<br>
&gt;<br>
&gt; =A0# Notify init of death.<br>
&gt; =A0allow system init:process sigchld;<br>
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

--f46d04088fad0925c204c534f0dd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
