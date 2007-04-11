Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BHpIw3003458
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 13:51:18 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3BHpGT2025813
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 17:51:17 GMT
Subject: Re: Random file context diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46042362.4010803@redhat.com>
References: <46042362.4010803@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 13:51:58 -0400
Message-Id: <1176313918.9840.49.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 14:58 -0400, Daniel J Walsh wrote:
> Pretty self explanatory

Merged.  Last hunk was already there.
> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (fc.diff),
> "fc.diff"
> 
> --- nsaserefpolicy/policy/modules/apps/games.fc 2007-02-28 10:12:23.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/apps/games.fc     2007-03-22 15:06:58.000000000 -0400
> @@ -4,6 +4,7 @@
>  /usr/games/powermanga  --      gen_context(system_u:object_r:games_exec_t,s0)
>  /usr/games/nethack-3.4.3/nethack -- gen_context(system_u:object_r:games_exec_t,s0)
>  /usr/games/vulturesclaw/vulturesclaw -- gen_context(system_u:object_r:games_exec_t,s0)
> +/usr/games/vultureseye/vultureseye -- gen_context(system_u:object_r:games_exec_t,s0)
>  
>  /usr/lib/games(/.*)?           gen_context(system_u:object_r:games_exec_t,s0)
>  
> --- nsaserefpolicy/policy/modules/kernel/corecommands.fc        2007-03-01 10:01:48.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/kernel/corecommands.fc    2007-03-22 15:06:58.000000000 -0400
> @@ -190,6 +190,7 @@
>  ifdef(`distro_redhat', `
>  /usr/lib/.*/program(/.*)?              gen_context(system_u:object_r:bin_t,s0)
>  /usr/lib/bluetooth(/.*)?       --      gen_context(system_u:object_r:bin_t,s0)
> +/usr/lib64/bluetooth(/.*)?     --      gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/authconfig/authconfig-gtk\.py -- gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/authconfig/authconfig-tui\.py -- gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/authconfig/authconfig.py -- gen_context(system_u:object_r:bin_t,s0)
> @@ -206,6 +207,7 @@
>  /usr/share/ssl/misc(/.*)?              gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/switchdesk/switchdesk-gui\.py -- gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/system-config-date/system-config-date\.py -- gen_context(system_u:object_r:bin_t,s0)
> +/usr/share/system-config-selinux/system-config-selinux\.py -- gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/system-config-display/system-config-display -- gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/system-config-httpd/system-config-httpd -- gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/system-config-keyboard/system-config-keyboard -- gen_context(system_u:object_r:bin_t,s0)
> --- nsaserefpolicy/policy/modules/kernel/storage.fc     2006-11-16 17:15:04.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/kernel/storage.fc 2007-03-22 15:06:58.000000000 -0400
> @@ -42,7 +42,8 @@
>  /dev/sjcd              -b      gen_context(system_u:object_r:removable_device_t,s0)
>  /dev/sonycd            -b      gen_context(system_u:object_r:removable_device_t,s0)
>  /dev/tape.*            -c      gen_context(system_u:object_r:tape_device_t,s0)
> -/dev/ub[a-z]           -b      gen_context(system_u:object_r:removable_device_t,mls_systemhigh)
> +/dev/tw[a-z][^/]+      -c      gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
> +/dev/ub[a-z][^/]+      -b      gen_context(system_u:object_r:removable_device_t,mls_systemhigh)
>  /dev/ubd[^/]*          -b      gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  /dev/xvd[^/]*          -b      gen_context(system_u:object_r:fixed_disk_device_t,mls_systemhigh)
>  
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
