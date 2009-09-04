MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: SELinux and SSH Timers ?...
Date: Fri, 4 Sep 2009 11:17:43 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D0736036B@de01exm68.ds.mot.com>
References: <4A996106.4060604@martinorr.name> <87my5ijji4.fsf@anzu.internal.golden-gryphon.com> <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil> <4A9BCE45.7060704@martinorr.name> <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil> <4A9D2500.8050008@martinorr.name>  <4A9D30F8.1040707@martinorr.name> <1251816403.27334.114.camel@moss-pluto.epoch.ncsc.mil> <4A9E6406.5000501@martinorr.name> <1251895923.2785.94.camel@moss-pluto.epoch.ncsc.mil> <4A9F90B1.3000908@martinorr.name> <1251991548.13634.81.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D0731CB89@de01exm68.ds.mot.com> <1252009947.13634.203.camel@moss-pluto.epoch.ncsc.mil> <1252064944.13634.207.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D073602DB@de01exm68.ds.mot.com> <1252076160.13634.291.camel@moss-pluto.epoch.ncsc.mil> 
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

By the way, would patching the kernel this way have the same effect as
changing the  /selinux/avc/cache_threshold value to "0" for example ? 

If that is the case, which would be the more recommended approach to
follow (kernel patch  vs.  Changing cache_threshold)? And would you
kindly explain why the preferred approach is better over the other ?
Thanks again for all your help !


-----Original Message-----
From: Hasan Rezaul-CHR010 
Sent: Friday, September 04, 2009 9:56 AM
To: 'Stephen Smalley'
Cc: selinux@tycho.nsa.gov
Subject: RE: SELinux and SSH Timers ?...

Great, Thank You Sir  :-)
 

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
Sent: Friday, September 04, 2009 9:56 AM
To: Hasan Rezaul-CHR010
Cc: selinux@tycho.nsa.gov
Subject: RE: SELinux and SSH Timers ?...

On Fri, 2009-09-04 at 10:45 -0400, Hasan Rezaul-CHR010 wrote:
> My Linux kernel version is 2.6.21.

So if you wanted to have SELinux audit every denial in permissive mode,
you'd just apply this patch and rebuild your kernel.  

diff --git a/security/selinux/avc.c b/security/selinux/avc.c index
da8caf1..b190eb7 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -874,10 +874,6 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	if (!requested || denied) {
 		if (selinux_enforcing)
 			rc = -EACCES;
-		else
-			if (node)
-
avc_update_node(AVC_CALLBACK_GRANT,requested,
-						ssid,tsid,tclass);
 	}
 
 	rcu_read_unlock();

--
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
