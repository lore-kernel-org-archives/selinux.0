Subject: RE: SELinux and SSH Timers ?...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D073602DB@de01exm68.ds.mot.com>
References: <4A996106.4060604@martinorr.name>
	 <87my5ijji4.fsf@anzu.internal.golden-gryphon.com>
	 <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9BCE45.7060704@martinorr.name>
	 <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9D2500.8050008@martinorr.name>  <4A9D30F8.1040707@martinorr.name>
	 <1251816403.27334.114.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9E6406.5000501@martinorr.name>
	 <1251895923.2785.94.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9F90B1.3000908@martinorr.name>
	 <1251991548.13634.81.camel@moss-pluto.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D0731CB89@de01exm68.ds.mot.com>
	 <1252009947.13634.203.camel@moss-pluto.epoch.ncsc.mil>
	 <1252064944.13634.207.camel@moss-pluto.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D073602DB@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Fri, 04 Sep 2009 10:56:00 -0400
Message-Id: <1252076160.13634.291.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-09-04 at 10:45 -0400, Hasan Rezaul-CHR010 wrote:
> My Linux kernel version is 2.6.21.

So if you wanted to have SELinux audit every denial in permissive mode,
you'd just apply this patch and rebuild your kernel.  

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index da8caf1..b190eb7 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -874,10 +874,6 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	if (!requested || denied) {
 		if (selinux_enforcing)
 			rc = -EACCES;
-		else
-			if (node)
-				avc_update_node(AVC_CALLBACK_GRANT,requested,
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
