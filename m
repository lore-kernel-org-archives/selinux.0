Message-ID: <1343670565.2346.121.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] add read permission over dev_type to appdomain on
 android_cts enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 30 Jul 2012 13:49:25 -0400
In-Reply-To: <CAO-4OdEpa70Tm-NhOT00nni1HgAtP_tn-fftFW9xAqSjGryB4Q@mail.gmail.com>
References: <1343428827-6808-1-git-send-email-hqjiang1988@gmail.com>
	 <1343650449.2346.0.camel@moss-pluto.epoch.ncsc.mil>
	 <CAO-4OdF9eOgwpF6_Jg_izcY-cqijrQjQEMDU1_7+Pf5vb3L1Tg@mail.gmail.com>
	 <CAO-4OdEpa70Tm-NhOT00nni1HgAtP_tn-fftFW9xAqSjGryB4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-30 at 10:46 -0700, Haiqing Jiang wrote:
> The policy to the denials should be: allow untrusted_app
> {block_device, radio_device, log_device}:lnk_file read; (ignore the
> syntax error). Do you think it's OK to merge it to: allow appdomain
> dev_type:dir_file_class_set { getattr read }???? Or we need to add
> separate policies? (like, allow untrusted_app specific device
> type:lnk_file read;)

Merging into the dev_type:dir_class_file_set rule opens up far more
access than is necessary or desired - read access to every device in the
system.  So here you want a more specific rule.  You can still use
appdomain and dev_type attributes, but only for symlinks:
	allow appdomain dev_type:lnk_file read;

And for the log device, a specific rule for its type:
	allow appdomain log_device:chr_file read;

> 
> On Mon, Jul 30, 2012 at 10:33 AM, Haiqing Jiang
> <hqjiang1988@gmail.com> wrote:
>         The denial information is shown as below:
>         
>         
>         <5>[ 2219.393524] type=1400 audit(1342221801.398:17): avc:
>          denied  { read } for  pid=2687 comm="ationTestRunner"
>         name="mtdblock0" dev=tmpfs ino=2562
>         scontext=u:r:untrusted_app:s0:c38
>         tcontext=u:object_r:block_device:s0 tclass=lnk_file
>         
>         <5>[ 2219.399566] type=1400 audit(1342221801.406:18): avc:
>          denied  { read } for  pid=2687 comm="ationTestRunner"
>         name="radio" dev=tmpfs ino=2527
>         scontext=u:r:untrusted_app:s0:c38
>         tcontext=u:object_r:radio_device:s0 tclass=lnk_file
>         
>         <5>[ 2005.011016] type=1400 audit(1342224760.046:32): avc:
>          denied  { read } for  pid=7264 comm="onCtsTestRunner"
>         name="events" dev=tmpfs ino=2902
>         scontext=u:r:untrusted_app:s0:c38
>         tcontext=u:object_r:log_device:s0 tclass=chr_file
>         
>         
>         On Mon, Jul 30, 2012 at 5:14 AM, Stephen Smalley
>         <sds@tycho.nsa.gov> wrote:
>                 On Fri, 2012-07-27 at 15:40 -0700, Haiqing Jiang
>                 wrote:
>                 > ---
>                 >  cts.te |    2 +-
>                 >  1 files changed, 1 insertions(+), 1 deletions(-)
>                 >
>                 > diff --git a/cts.te b/cts.te
>                 > index 489be1a..ff8a9f0 100644
>                 > --- a/cts.te
>                 > +++ b/cts.te
>                 > @@ -20,7 +20,7 @@ allow appdomain file_type:dir
>                 r_dir_perms;
>                 >  allow appdomain fs_type:dir r_dir_perms;
>                 >  allow appdomain dev_type:dir r_dir_perms;
>                 >  allow appdomain file_type:dir_file_class_set
>                 getattr;
>                 > -allow appdomain dev_type:dir_file_class_set
>                 getattr;
>                 > +allow appdomain dev_type:dir_file_class_set
>                 { getattr read };
>                 >  allow appdomain fs_type:dir_file_class_set getattr;
>                 >
>                 >  # Execute the shell or other system executables.
>                 
>                 
>                 I don't think you want to allow all app domains to
>                 read all devices.
>                 Nor should that be required even for CTS.  Which
>                 devices triggered
>                 denials?
>                 
>                 --
>                 Stephen Smalley
>                 National Security Agency
>                 
>         
>         
>         
>         
>         -- 
>         -----------------------------------
>         Haiqing Jiang, PH.D student
>         
>         
>         Computer Science Department, North Carolina State University
>         
>         
>         
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

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
