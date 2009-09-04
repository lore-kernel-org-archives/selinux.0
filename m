MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux and SSH Timers ?...
Date: Fri, 4 Sep 2009 12:15:38 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0736043C@de01exm68.ds.mot.com>
In-Reply-To: <1252080383.13634.324.camel@moss-pluto.epoch.ncsc.mil>
References: <4A996106.4060604@martinorr.name> <87my5ijji4.fsf@anzu.internal.golden-gryphon.com> <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil> <4A9BCE45.7060704@martinorr.name> <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil> <4A9D2500.8050008@martinorr.name>  <4A9D30F8.1040707@martinorr.name> <1251816403.27334.114.camel@moss-pluto.epoch.ncsc.mil> <4A9E6406.5000501@martinorr.name> <1251895923.2785.94.camel@moss-pluto.epoch.ncsc.mil> <4A9F90B1.3000908@martinorr.name> <1251991548.13634.81.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D0731CB89@de01exm68.ds.mot.com> <1252009947.13634.203.camel@moss-pluto.epoch.ncsc.mil> <1252064944.13634.207.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D073602DB@de01exm68.ds.mot.com> <1252076160.13634.291.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D0736036B@de01exm68.ds.mot.com> <1252080383.13634.324.camel@moss-pluto.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Awesome. Thanks for the detailed info   :-)

 

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Friday, September 04, 2009 11:06 AM
To: Hasan Rezaul-CHR010
Cc: selinux@tycho.nsa.gov
Subject: RE: SELinux and SSH Timers ?...

On Fri, 2009-09-04 at 11:17 -0400, Hasan Rezaul-CHR010 wrote:
> By the way, would patching the kernel this way have the same effect as

> changing the  /selinux/avc/cache_threshold value to "0" for example ?
> 
> If that is the case, which would be the more recommended approach to 
> follow (kernel patch  vs.  Changing cache_threshold)? And would you 
> kindly explain why the preferred approach is better over the other ?
> Thanks again for all your help !

The kernel patch completely removes the adding of denied permissions to
the AVC.  So if they never get added, then they always get logged and
you don't need to evict the cache entry.  More reliable and more
performant.

Setting the cache threshold is just a way to speed up the eviction of
cache entries (by reducing the max number of entries).  It carries with
it a performance cost.

As I've said before, you also have the option of manually flushing the
cache by running load_policy at any time.  So if you only wanted to see
each instance of a denial within a ssh session, you could do that just
by running load_policy upon each login, or you could run load_policy at
selected points during a session (e.g. just before re-running an
application) to force a reset.

But if you truly want to see every instance of every denial in
permissive mode, just like enforcing mode, then the kernel patch is the
best choice.  Just be warned that it may render your system unusable if
your policy is in poor shape or your processes are running in the wrong
domains, as it can easily flood the system with AVC denials.

FWIW, modern SELinux also has permissive domains (the ability to make
individual domains permissive while leaving the rest of the system
enforcing).  But you'd need a newer kernel (>= 2.6.26) and the right
version of the SELinux userland for that.

--
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
