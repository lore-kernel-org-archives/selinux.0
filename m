Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8CKpf50017496
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2012 16:51:41 -0400
Received: by wibhn17 with SMTP id hn17so2116627wib.12
        for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2012 13:51:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdoi3XTxNREPzYhVH-FJ=id+2m0EYHV-b97Pk7HxiUOcvw@mail.gmail.com>
References: <CAN93RkJ63JnR-ajfVtKx772+NsFT=-P2_L7Cv3cr4rEAJxMYDg@mail.gmail.com>
 <CAN93Rk+Q1QSftoKtV=kiJ7gUqq8V-C6uJJmibeUQhjR5-AgiAw@mail.gmail.com>
 <CAFftDdqD-VRvrFjbvg=jxsFyo8Ucp50bOwS1Cs+0GLAe9vNMFg@mail.gmail.com>
 <CAN93RkJ24TMdj7J-yWRE14HhPaGdAYoOMcvLyyA_r0D_eGXzzA@mail.gmail.com>
 <5050AC29.30400@tycho.ncsc.mil> <CAN93RkLPPD=kULgYAN0y9_sVOHrQT9PUmQHrcarwMVV9PND2bQ@mail.gmail.com>
 <CAFftDdoi3XTxNREPzYhVH-FJ=id+2m0EYHV-b97Pk7HxiUOcvw@mail.gmail.com>
From: Cesar Maiorino <cesar.maiorino@gmail.com>
Date: Wed, 12 Sep 2012 16:50:58 -0400
Message-ID: <CAN93RkLAgyVR=7EzgxA5vOCQNMpyoud1P9XhLK67nQsEa=B8kQ@mail.gmail.com>
Subject: Re: Problem with SEManager app on Seandroid 4.0.4
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Joman Chu <jcchu@tycho.ncsc.mil>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=000e0cd401c077fabe04c9875b7f
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cd401c077fabe04c9875b7f
Content-Type: text/plain; charset=ISO-8859-1

That is enormously helpful. Thanks.

So I have a couple more questions:

(1) I would naively expect that the denials would be more device-specific.
For example, there are
several related to zygote that look pretty generic. Shouldn't those already
be in the "base" policy?
Or am I missing something?

(2) If I don't add the "shell allow" rules, how do I deal with those
denials?



On Wed, Sep 12, 2012 at 4:29 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> So you have a lot of denials. You need to correct these before you go
> to enforcing mode.
>
> Below, I show you how you can use audit2allow to gather the rules to
> add to your device policy. If you create a file called sepolicy.te in
> your projects device directory or vendor directory with these rules it
> should fix it. Take a look at external/sepolicy/Android.mk, that make
> file searches vendor and device directories based on the lunch option
> of the device being built for to automatically include specially named
> policy files.
>
> The general rule of thumb is NOT to add the shell allow rules. You
> should also use the macro's when granting access that are defined in
> external.sepolicy/global_macros
>
> If you use the macro's this line:
>
> allow media_app ion_device:chr_file { read open };
>
> becomes:
> allow media_app ion_device:chr_file r_file_perms;
>
> The macro's help, you should really use them. If a process asks for
> read, it likeley needs getattr and other accesses too and the macro's
> wrap these up cleanly for you.
>
> Also, never allow access to "device" or "block_device". These are
> large domains and granting access to them is generally not a good
> idea. This rule "allow mediaserver device:chr_file { read write ioctl
> open };" is caused by these denied message:
>
> <5>[    9.119517] type=1400 audit(11394.900:33): avc:  denied  { read
> write } for  pid=194 comm="mediaserver" name="diag" dev=tmpfs ino=5559
> scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[    9.154951] type=1400 audit(11394.930:34): avc:  denied  { open
> } for  pid=194 comm="mediaserver" name="diag" dev=tmpfs ino=5559
> scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
> tclass=chr_file
> <5>[    9.185441] type=1400 audit(11394.960:35): avc:  denied  { ioctl
> } for  pid=194 comm="mediaserver" path="/dev/diag" dev=tmpfs ino=5559
> scontext=u:r:mediaserver:s0 tcontext=u:object_r:device:s0
>
> which are accesses on:
> /dev/diag
>
> You should relabel dev diag in sepolicy.fc (again in your
> device/vendor directory) to some other type and grant access on it. If
> you allow mediaserver access to device, it could then read and write
> to a lot of stuff under /dev that you may want to not give it access
> too. (/dev is initially labeled as device, everything else gets a
> specific label as needed)
>
>
> Example of taking dmesg output and generating rules, don't just copy
> and paste. Read these and make sure they make sense for your
> application... We also may want to submit some of these upstream
> (SELinux/Google).
>
> $ cat /home/wroberts/Downloads/seandroid_proc_kmsg.txt | audit2allow
>
> #============= media_app ==============
> allow media_app ion_device:chr_file { read open };
> allow media_app tmpfs:dir getattr;
>
> #============= mediaserver ==============
> allow mediaserver device:chr_file { read write ioctl open };
> allow mediaserver system_data_file:file { write open };
>
> #============= platform_app ==============
> allow platform_app device:chr_file { read write open };
> allow platform_app ion_device:chr_file { read open };
> allow platform_app system_data_file:fifo_file { write read open };
>
> #============= radio ==============
> allow radio ion_device:chr_file { read open };
>
> #============= release_app ==============
> allow release_app ion_device:chr_file { read open };
>
> #============= rild ==============
> allow rild device:chr_file { read write open };
> allow rild device:dir { write add_name };
> allow rild device:sock_file { write create };
> allow rild self:netlink_socket { bind create };
>
> #============= shared_app ==============
> allow shared_app device:chr_file { read write ioctl open };
> allow shared_app ion_device:chr_file { read open };
>
> #============= shell ==============
> allow shell ctl_default_prop:property_service set;
> allow shell ctl_rildaemon_prop:property_service set;
> allow shell default_prop:property_service set;
> allow shell device:chr_file { read write getattr open };
> allow shell device:dir { read open };
> allow shell init:fifo_file { read getattr };
> allow shell init:unix_stream_socket { connectto read write };
> allow shell proc:file write;
> allow shell rootfs:file { read open };
> allow shell self:capability { net_admin chown fsetid dac_override };
> allow shell self:capability2 syslog;
> allow shell sysfs:file { write setattr };
> allow shell system_data_file:dir { write remove_name add_name setattr };
> allow shell system_data_file:file { write create unlink open };
> allow shell system_file:lnk_file getattr;
> allow shell system_prop:property_service set;
> allow shell tmpfs:chr_file { read write getattr };
>
> #============= surfaceflinger ==============
> allow surfaceflinger device:chr_file { read write ioctl open };
>
> #============= system ==============
> allow system device:dir { write add_name };
> allow system device:sock_file create;
> allow system ion_device:chr_file { read open };
> allow system zygote:binder { receive call };
> allow system zygote:file write;
>
> #============= system_app ==============
> allow system_app ctl_default_prop:property_service set;
> allow system_app device:chr_file { read write ioctl open };
> allow system_app device:sock_file write;
> allow system_app ion_device:chr_file { read open };
> allow system_app radio_prop:property_service set;
>
> #============= ueventd ==============
> allow ueventd sdcard:dir search;
> allow ueventd sdcard:file { read getattr open };
> allow ueventd self:capability fowner;
>
> #============= zygote ==============
> allow zygote ashmem_device:chr_file execute;
> allow zygote init:unix_stream_socket connectto;
> allow zygote ion_device:chr_file { read open };
> allow zygote property_socket:sock_file write;
> allow zygote self:binder transfer;
> allow zygote servicemanager:binder call;
> allow zygote surfaceflinger:binder { receive call };
> allow zygote surfaceflinger:fd use;
> allow zygote system:binder { receive call };
> allow zygote system_prop:property_service set;
>
>
>
>
>
> On Wed, Sep 12, 2012 at 11:48 AM, Cesar Maiorino
> <cesar.maiorino@gmail.com> wrote:
> > Here is my /proc/kmsg.  I am going to dig into it myself, but if you have
> > the time to take a look, any
> > pointers would be appreciated.
> >
> > On Wed, Sep 12, 2012 at 11:37 AM, Joman Chu <jcchu@tycho.ncsc.mil>
> wrote:
> >>
> >> On 09/12/2012 11:01 AM, Cesar Maiorino wrote:
> >>
> >> I did have these in my init.rc, but my build was not copying init.rc to
> >> to the out directory.
> >> I copied it over manually and rebuilt the boot.img and it now I can
> change
> >> the values.
> >> So that is progress.
> >> Now, however, when I toggle on SELinux, my device locks up. On reboot it
> >> is stuck at the
> >> lock screen.
> >> Thanks for the help.
> >>
> >> On Tue, Sep 11, 2012 at 4:37 PM, William Roberts
> >> <bill.c.roberts@gmail.com> wrote:
> >>>
> >>> My guess is you need to change the permissions of /selinux/*
> >>> (/selinux/booleans for the booleans) to system system.
> >>>
> >>> the init.rc needs to have chown system system for all of the booleans,
> >>> setenforce etc
> >>>
> >>>     chown system system /selinux/enforce
> >>>     chown -R system system /selinux/booleans
> >>>     chown system system /selinux/commit_pending_bools
> >>>
> >>> You'll need to patch in the recursive support or enumerate all the
> >>> bools. The patch for recursive support can be found:
> >>> https://android-review.googlesource.com/#/c/32220/
> >>>
> >>> Hope this helps.
> >>>
> >>>
> >>> On Tue, Sep 11, 2012 at 1:23 PM, Cesar Maiorino
> >>> <cesar.maiorino@gmail.com> wrote:
> >>> > I finally got a version of seandroid (4.0.4) running on my Qualcomm
> >>> > MSM8960
> >>> > Mobile Development Platform. This required some manual intervention
> as
> >>> > the
> >>> > patch files did not all apply cleanly, so it's possible that I've
> >>> > messed
> >>> > something up in the process.
> >>> >
> >>> > That being said, the SEManager app does not let me change any
> settings
> >>> > aside
> >>> > from toggling "MAC Mode" on and off. So I can't change '"SELinux
> Mode"
> >>> > (stuck in permissive), and I can't change any of the Booleans.
> >>> >
> >>> > AVC and MAC logging seem to be working.
> >>> >
> >>> > Any ideas?
> >>> >
> >>>
> >>>
> >>>
> >>> --
> >>> Respectfully,
> >>>
> >>> William C Roberts
> >>
> >>
> >> Perhaps you're running into AVC denials. Can you post the kernel logs
> from
> >> /proc/kmsg?
> >
> >
>
>
>
> --
> Respectfully,
>
> William C Roberts
>

--000e0cd401c077fabe04c9875b7f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

That is enormously helpful. Thanks.<br><br>So I have a couple more question=
s:<br><br>(1) I would naively expect that the denials would be more device-=
specific. For example, there are<br>several related to zygote that look pre=
tty generic. Shouldn&#39;t those already be in the &quot;base&quot; policy?=
<br>


Or am I missing something?<br><br>(2) If I don&#39;t add the &quot;shell al=
low&quot; rules, how do I deal with those denials?<br><br><br><br><div clas=
s=3D"gmail_quote">On Wed, Sep 12, 2012 at 4:29 PM, William Roberts <span di=
r=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank"=
>bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">So you have a lot of denials. You need to co=
rrect these before you go<br>
to enforcing mode.<br>
<br>
Below, I show you how you can use audit2allow to gather the rules to<br>
add to your device policy. If you create a file called sepolicy.te in<br>
your projects device directory or vendor directory with these rules it<br>
should fix it. Take a look at external/sepolicy/Android.mk, that make<br>
file searches vendor and device directories based on the lunch option<br>
of the device being built for to automatically include specially named<br>
policy files.<br>
<br>
The general rule of thumb is NOT to add the shell allow rules. You<br>
should also use the macro&#39;s when granting access that are defined in<br=
>
external.sepolicy/global_macros<br>
<br>
If you use the macro&#39;s this line:<br>
<br>
allow media_app ion_device:chr_file { read open };<br>
<br>
becomes:<br>
allow media_app ion_device:chr_file r_file_perms;<br>
<br>
The macro&#39;s help, you should really use them. If a process asks for<br>
read, it likeley needs getattr and other accesses too and the macro&#39;s<b=
r>
wrap these up cleanly for you.<br>
<br>
Also, never allow access to &quot;device&quot; or &quot;block_device&quot;.=
 These are<br>
large domains and granting access to them is generally not a good<br>
idea. This rule &quot;allow mediaserver device:chr_file { read write ioctl<=
br>
open };&quot; is caused by these denied message:<br>
<br>
&lt;5&gt;[ =A0 =A09.119517] type=3D1400 audit(11394.900:33): avc: =A0denied=
 =A0{ read<br>
write } for =A0pid=3D194 comm=3D&quot;mediaserver&quot; name=3D&quot;diag&q=
uot; dev=3Dtmpfs ino=3D5559<br>
scontext=3Du:r:mediaserver:s0 tcontext=3Du:object_r:device:s0<br>
tclass=3Dchr_file<br>
&lt;5&gt;[ =A0 =A09.154951] type=3D1400 audit(11394.930:34): avc: =A0denied=
 =A0{ open<br>
} for =A0pid=3D194 comm=3D&quot;mediaserver&quot; name=3D&quot;diag&quot; d=
ev=3Dtmpfs ino=3D5559<br>
scontext=3Du:r:mediaserver:s0 tcontext=3Du:object_r:device:s0<br>
tclass=3Dchr_file<br>
&lt;5&gt;[ =A0 =A09.185441] type=3D1400 audit(11394.960:35): avc: =A0denied=
 =A0{ ioctl<br>
} for =A0pid=3D194 comm=3D&quot;mediaserver&quot; path=3D&quot;/dev/diag&qu=
ot; dev=3Dtmpfs ino=3D5559<br>
scontext=3Du:r:mediaserver:s0 tcontext=3Du:object_r:device:s0<br>
<br>
which are accesses on:<br>
/dev/diag<br>
<br>
You should relabel dev diag in sepolicy.fc (again in your<br>
device/vendor directory) to some other type and grant access on it. If<br>
you allow mediaserver access to device, it could then read and write<br>
to a lot of stuff under /dev that you may want to not give it access<br>
too. (/dev is initially labeled as device, everything else gets a<br>
specific label as needed)<br>
<br>
<br>
Example of taking dmesg output and generating rules, don&#39;t just copy<br=
>
and paste. Read these and make sure they make sense for your<br>
application... We also may want to submit some of these upstream<br>
(SELinux/Google).<br>
<br>
$ cat /home/wroberts/Downloads/seandroid_proc_kmsg.txt | audit2allow<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D media_app =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
allow media_app ion_device:chr_file { read open };<br>
allow media_app tmpfs:dir getattr;<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D mediaserver =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
allow mediaserver device:chr_file { read write ioctl open };<br>
allow mediaserver system_data_file:file { write open };<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D platform_app =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
allow platform_app device:chr_file { read write open };<br>
allow platform_app ion_device:chr_file { read open };<br>
allow platform_app system_data_file:fifo_file { write read open };<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D radio =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
allow radio ion_device:chr_file { read open };<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D release_app =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
allow release_app ion_device:chr_file { read open };<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D rild =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
allow rild device:chr_file { read write open };<br>
allow rild device:dir { write add_name };<br>
allow rild device:sock_file { write create };<br>
allow rild self:netlink_socket { bind create };<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D shared_app =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
allow shared_app device:chr_file { read write ioctl open };<br>
allow shared_app ion_device:chr_file { read open };<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D shell =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
allow shell ctl_default_prop:property_service set;<br>
allow shell ctl_rildaemon_prop:property_service set;<br>
allow shell default_prop:property_service set;<br>
allow shell device:chr_file { read write getattr open };<br>
allow shell device:dir { read open };<br>
allow shell init:fifo_file { read getattr };<br>
allow shell init:unix_stream_socket { connectto read write };<br>
allow shell proc:file write;<br>
allow shell rootfs:file { read open };<br>
allow shell self:capability { net_admin chown fsetid dac_override };<br>
allow shell self:capability2 syslog;<br>
allow shell sysfs:file { write setattr };<br>
allow shell system_data_file:dir { write remove_name add_name setattr };<br=
>
allow shell system_data_file:file { write create unlink open };<br>
allow shell system_file:lnk_file getattr;<br>
allow shell system_prop:property_service set;<br>
allow shell tmpfs:chr_file { read write getattr };<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D surfaceflinger =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>
allow surfaceflinger device:chr_file { read write ioctl open };<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D system =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
allow system device:dir { write add_name };<br>
allow system device:sock_file create;<br>
allow system ion_device:chr_file { read open };<br>
allow system zygote:binder { receive call };<br>
allow system zygote:file write;<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D system_app =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>
allow system_app ctl_default_prop:property_service set;<br>
allow system_app device:chr_file { read write ioctl open };<br>
allow system_app device:sock_file write;<br>
allow system_app ion_device:chr_file { read open };<br>
allow system_app radio_prop:property_service set;<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ueventd =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
allow ueventd sdcard:dir search;<br>
allow ueventd sdcard:file { read getattr open };<br>
allow ueventd self:capability fowner;<br>
<br>
#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D zygote =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
allow zygote ashmem_device:chr_file execute;<br>
allow zygote init:unix_stream_socket connectto;<br>
allow zygote ion_device:chr_file { read open };<br>
allow zygote property_socket:sock_file write;<br>
allow zygote self:binder transfer;<br>
allow zygote servicemanager:binder call;<br>
allow zygote surfaceflinger:binder { receive call };<br>
allow zygote surfaceflinger:fd use;<br>
allow zygote system:binder { receive call };<br>
allow zygote system_prop:property_service set;<br>
<div><div><br>
<br>
<br>
<br>
<br>
On Wed, Sep 12, 2012 at 11:48 AM, Cesar Maiorino<br>
&lt;<a href=3D"mailto:cesar.maiorino@gmail.com" target=3D"_blank">cesar.mai=
orino@gmail.com</a>&gt; wrote:<br>
&gt; Here is my /proc/kmsg. =A0I am going to dig into it myself, but if you=
 have<br>
&gt; the time to take a look, any<br>
&gt; pointers would be appreciated.<br>
&gt;<br>
&gt; On Wed, Sep 12, 2012 at 11:37 AM, Joman Chu &lt;<a href=3D"mailto:jcch=
u@tycho.ncsc.mil" target=3D"_blank">jcchu@tycho.ncsc.mil</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 09/12/2012 11:01 AM, Cesar Maiorino wrote:<br>
&gt;&gt;<br>
&gt;&gt; I did have these in my init.rc, but my build was not copying init.=
rc to<br>
&gt;&gt; to the out directory.<br>
&gt;&gt; I copied it over manually and rebuilt the boot.img and it now I ca=
n change<br>
&gt;&gt; the values.<br>
&gt;&gt; So that is progress.<br>
&gt;&gt; Now, however, when I toggle on SELinux, my device locks up. On reb=
oot it<br>
&gt;&gt; is stuck at the<br>
&gt;&gt; lock screen.<br>
&gt;&gt; Thanks for the help.<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Sep 11, 2012 at 4:37 PM, William Roberts<br>
&gt;&gt; &lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">=
bill.c.roberts@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; My guess is you need to change the permissions of /selinux/*<b=
r>
&gt;&gt;&gt; (/selinux/booleans for the booleans) to system system.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; the init.rc needs to have chown system system for all of the b=
ooleans,<br>
&gt;&gt;&gt; setenforce etc<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =A0 =A0 chown system system /selinux/enforce<br>
&gt;&gt;&gt; =A0 =A0 chown -R system system /selinux/booleans<br>
&gt;&gt;&gt; =A0 =A0 chown system system /selinux/commit_pending_bools<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You&#39;ll need to patch in the recursive support or enumerate=
 all the<br>
&gt;&gt;&gt; bools. The patch for recursive support can be found:<br>
&gt;&gt;&gt; <a href=3D"https://android-review.googlesource.com/#/c/32220/"=
 target=3D"_blank">https://android-review.googlesource.com/#/c/32220/</a><b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hope this helps.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Tue, Sep 11, 2012 at 1:23 PM, Cesar Maiorino<br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:cesar.maiorino@gmail.com" target=3D"_bla=
nk">cesar.maiorino@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt; &gt; I finally got a version of seandroid (4.0.4) running on m=
y Qualcomm<br>
&gt;&gt;&gt; &gt; MSM8960<br>
&gt;&gt;&gt; &gt; Mobile Development Platform. This required some manual in=
tervention as<br>
&gt;&gt;&gt; &gt; the<br>
&gt;&gt;&gt; &gt; patch files did not all apply cleanly, so it&#39;s possib=
le that I&#39;ve<br>
&gt;&gt;&gt; &gt; messed<br>
&gt;&gt;&gt; &gt; something up in the process.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; That being said, the SEManager app does not let me change=
 any settings<br>
&gt;&gt;&gt; &gt; aside<br>
&gt;&gt;&gt; &gt; from toggling &quot;MAC Mode&quot; on and off. So I can&#=
39;t change &#39;&quot;SELinux Mode&quot;<br>
&gt;&gt;&gt; &gt; (stuck in permissive), and I can&#39;t change any of the =
Booleans.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; AVC and MAC logging seem to be working.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Any ideas?<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Respectfully,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; William C Roberts<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Perhaps you&#39;re running into AVC denials. Can you post the kern=
el logs from<br>
&gt;&gt; /proc/kmsg?<br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
--<br>
Respectfully,<br>
<br>
William C Roberts<br>
</div></div></blockquote></div><br>

--000e0cd401c077fabe04c9875b7f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
