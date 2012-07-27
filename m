Message-ID: <1343415126.17570.82.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] allocate perms to platformappdomain over
 system_data_file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Fri, 27 Jul 2012 14:52:06 -0400
In-Reply-To: <CAO-4OdF=FRiKqUhVwPeucHRrKsYWBNJiRktJJhHnNYf_=V1cwA@mail.gmail.com>
References: <1343414055-3831-1-git-send-email-hqjiang1988@gmail.com>
	 <1343414258.17570.72.camel@moss-pluto.epoch.ncsc.mil>
	 <CAO-4OdF=FRiKqUhVwPeucHRrKsYWBNJiRktJJhHnNYf_=V1cwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 11:46 -0700, Haiqing Jiang wrote:
> This is the denial information. What is your opinion? Thanks. 
> 
> 
> 5>[ 2978.206604] type=1400 audit(1342634359.195:1155): avc:  denied
>  { open } for  pid=10393 comm="android.cts.jni" name="libjnitest.so"
> dev=mmcblk0p12 ino=578521 scontext=u:r:release_app:s0:c41
> tcontext=u:object_r:system_data_file:s0 tclass=file
> <5>[12124.019561] type=1400 audit(1342643505.007:1919): avc:  denied
> { open } for  pid=24055 comm="ationTestRunner"
> name="libctspermission_jni.so" dev=mmcblk0p12 ino=578541
> scontext=u:r:release_app:s0:c41
> tcontext=u:object_r:system_data_file:s0 tclass=file

It is trying to execute a shared object from the lib directory.  So it
is the same as app_ndk, except for platformappdomain rather than
untrusted_app.  

> 
> 
> On Fri, Jul 27, 2012 at 11:37 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>         On Fri, 2012-07-27 at 11:34 -0700, Haiqing Jiang wrote:
>         > ---
>         >  app.te |    2 ++
>         >  1 files changed, 2 insertions(+), 0 deletions(-)
>         >
>         > diff --git a/app.te b/app.te
>         > index 85de816..dca2e0c 100644
>         > --- a/app.te
>         > +++ b/app.te
>         > @@ -83,6 +83,8 @@ allow platformappdomain
>         platform_app_data_file:notdevfile_class_set create_file_
>         >  # App sdcard file accesses
>         >  allow platformappdomain sdcard:dir create_dir_perms;
>         >  allow platformappdomain sdcard:file create_file_perms;
>         > +# System data file accesses XXX????
>         > +allow platformappdomain system_data_file:file open;
>         >
>         >  #
>         >  # Untrusted apps.
>         
>         
>         Need to know more about the denial to diagnose.
>         Also, enabling syscall audit may help with getting full
>         pathnames,
>         although you likely need the ARM audit patches for that.
>         
>         --
>         Stephen Smalley
>         National Security Agency
>         
> 
> 
> 
> 
> -- 
> -----------------------------------
> Haiqing Jiang, PH.D student
> 
> 
> Computer Science Department, North Carolina State University
> 
> 
> 
> 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
