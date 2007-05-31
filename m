Subject: Re: [patch] Reducing size of libselinux/libsepol: 3rd
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
Cc: selinux@tycho.nsa.gov, busybox@kaigai.gr.jp
In-Reply-To: <20070523103936.baf38e0b.ynakam@hitachisoft.jp>
References: <20070523103936.baf38e0b.ynakam@hitachisoft.jp>
Content-Type: text/plain
Date: Thu, 31 May 2007 17:00:56 -0400
Message-Id: <1180645256.3340.390.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-23 at 10:39 +0900, Yuichi Nakamura wrote:
> Hi. 
> As discussed in previous threads, 
> http://marc.info/?t=117609454600002&r=1&w=2
> http://marc.info/?t=117886013000001&r=1&w=2
> I would like to submit patch to reduce size of libselinux+libsepol, again.
> 
> 1. Background
> Current libselinux+libsepol size is big for embedded devices.
> libselinux.so.1: 115348 byte
> libsepol.so.1:302067
> Total: 417415 byte
> It uses more than 400kbyte.
> Needs for embedded device is various, because hardware resource is various.
> If device is rich enough, people may want full-featured SELinux.
> If device is not rich, people want to reduce binary size by removing 
> some features. 
> For example, some may not want modular policy, may not want boolean.
> 
> We thought size of libselinux+libsepol can be reduced 
> by removing libsepol and removing unnecessary functions from libselinux.
> 
> 2. What this patch does
> 1) libsepol is separated from libselinux
>  libsepol is not required by libselinux. 
>  So you do not have to compile libsepol,
>  if you do not need libsepol functions.
> 
> 2) Some features are disabled in libselinux
> By typing "make EMBEDDED=y" in libselinux dir, what happens is following.
> Following values are defined in Makefile.
> >ifeq ($(EMBEDDED),y)
> >        override DISABLE_AVC=y
> >        override DISABLE_SETRANS=y
> >        override DISABLE_RPM=y
> >        override DISABLE_BOOL=y
> >endif
> 
> * DISABLE_AVC
>   Disables user space avc support, avc.c avc_internal.c avc_sidtab.c are not compiled.
> * DISABLE_SETRANS
>   Some functions of translations are replaced with stubs in setrans_client.c
> * DISABLE_RPM
>   Disables rpm features, rpm.c are not compiled.
> * DISABLE_BOOL
>   Disable boolean features, booleans.c are not compiled.
> 
> 3) Fixes to libselinux/utils
>  * -lsepol is removed
>  *  When make EMBEDDED=y, some utils are not compiled.
> 
> 3. Size measurement
> Compiled libselinux/libsepol in trunk by gcc(x86).
> 
> * Before
> libselinux.so.1: 115348 byte
> libsepol.so.1:302067
> Total: 417415 byte
> 
> * After
> libselinux.so.1: 77103 byte
> libsepol.so.1:0 byte(do not have to compile)
> Total: 77103 byte
> 
> Please consider merging this patch.

Thanks, merged.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
