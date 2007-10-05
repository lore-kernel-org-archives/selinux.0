Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l95HsvZs032272
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 13:54:57 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l95HsuSq027897
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 17:54:56 GMT
Subject: Re: un-escaped dots cleanup
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jan-Frode Myklebust <janfrode@tanso.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071003212541.GA22482@lc4eb8045376502.ibm.com>
References: <20071003212541.GA22482@lc4eb8045376502.ibm.com>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 13:52:07 -0400
Message-Id: <1191606727.13098.6.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-03 at 17:25 -0400, Jan-Frode Myklebust wrote:
> Here's a patch against refpolicy-20070928. cleaning up the trivial
> examples of labeling rules with un-escaped dots (.pid vs. \.pid).

Merged.
> 
> 
> 
> 
> 
> 
> plain text
> document
> attachment
> (unescaped-dots.patch), "unescaped-dots.patch"
> 
> diff -ruN refpolicy.old/policy/modules/kernel/corecommands.fc refpolicy/policy/modules/kernel/corecommands.fc
> --- refpolicy.old/policy/modules/kernel/corecommands.fc 2007-08-07 19:06:32.000000000 +0200
> +++ refpolicy/policy/modules/kernel/corecommands.fc     2007-10-03 23:06:05.000000000 +0200
> @@ -197,7 +197,7 @@
>  /usr/lib64/bluetooth(/.*)?     --      gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/authconfig/authconfig-gtk\.py -- gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/authconfig/authconfig-tui\.py -- gen_context(system_u:object_r:bin_t,s0)
> -/usr/share/authconfig/authconfig.py -- gen_context(system_u:object_r:bin_t,s0)
> +/usr/share/authconfig/authconfig\.py --        gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/cvs/contrib/rcs2log --      gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/clamav/clamd-gen    --      gen_context(system_u:object_r:bin_t,s0)
>  /usr/share/clamav/freshclam-sleep --   gen_context(system_u:object_r:bin_t,s0)
> diff -ruN refpolicy.old/policy/modules/kernel/files.fc refpolicy/policy/modules/kernel/files.fc
> --- refpolicy.old/policy/modules/kernel/files.fc        2007-08-21 21:03:34.000000000 +0200
> +++ refpolicy/policy/modules/kernel/files.fc    2007-10-03 23:06:49.000000000 +0200
> @@ -57,7 +57,7 @@
>  /etc/motd              --      gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/nohotplug         --      gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/nologin.*         --      gen_context(system_u:object_r:etc_runtime_t,s0)
> -/etc/reader.conf       --      gen_context(system_u:object_r:etc_runtime_t,s0)
> +/etc/reader\.conf      --      gen_context(system_u:object_r:etc_runtime_t,s0)
>  /etc/smartd\.conf.*    --      gen_context(system_u:object_r:etc_runtime_t,s0)
>  
>  /etc/cups/client\.conf --      gen_context(system_u:object_r:etc_t,s0)
> diff -ruN refpolicy.old/policy/modules/services/aide.fc refpolicy/policy/modules/services/aide.fc
> --- refpolicy.old/policy/modules/services/aide.fc       2007-04-30 17:09:15.000000000 +0200
> +++ refpolicy/policy/modules/services/aide.fc   2007-10-03 23:07:34.000000000 +0200
> @@ -3,4 +3,4 @@
>  /var/lib/aide(/.*)             gen_context(system_u:object_r:aide_db_t,mls_systemhigh)
>  
>  /var/log/aide(/.*)?            gen_context(system_u:object_r:aide_log_t,mls_systemhigh)
> -/var/log/aide.log      --      gen_context(system_u:object_r:aide_log_t,mls_systemhigh)
> +/var/log/aide\.log     --      gen_context(system_u:object_r:aide_log_t,mls_systemhigh)
> diff -ruN refpolicy.old/policy/modules/services/apcupsd.fc refpolicy/policy/modules/services/apcupsd.fc
> --- refpolicy.old/policy/modules/services/apcupsd.fc    2007-09-06 20:34:40.000000000 +0200
> +++ refpolicy/policy/modules/services/apcupsd.fc        2007-10-03 23:08:14.000000000 +0200
> @@ -9,7 +9,7 @@
>  
>  /var/run/apcupsd\.pid          --      gen_context(system_u:object_r:apcupsd_var_run_t,s0)
>  
> -/var/www/apcupsd/multimon.cgi  --      gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
> -/var/www/apcupsd/upsfstats.cgi --      gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
> -/var/www/apcupsd/upsimage.cgi  --      gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
> -/var/www/apcupsd/upsstats.cgi  --      gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
> +/var/www/apcupsd/multimon\.cgi --      gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
> +/var/www/apcupsd/upsfstats\.cgi        --      gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
> +/var/www/apcupsd/upsimage\.cgi --      gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
> +/var/www/apcupsd/upsstats\.cgi --      gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
> diff -ruN refpolicy.old/policy/modules/services/consolekit.fc refpolicy/policy/modules/services/consolekit.fc
> --- refpolicy.old/policy/modules/services/consolekit.fc 2007-04-11 16:04:35.000000000 +0200
> +++ refpolicy/policy/modules/services/consolekit.fc     2007-10-03 23:09:27.000000000 +0200
> @@ -1,3 +1,3 @@
>  /usr/sbin/console-kit-daemon   --      gen_context(system_u:object_r:consolekit_exec_t,s0)
>  
> -/var/run/consolekit.pid                --      gen_context(system_u:object_r:consolekit_var_run_t,s0)
> +/var/run/consolekit\.pid       --      gen_context(system_u:object_r:consolekit_var_run_t,s0)
> diff -ruN refpolicy.old/policy/modules/services/fail2ban.fc refpolicy/policy/modules/services/fail2ban.fc
> --- refpolicy.old/policy/modules/services/fail2ban.fc   2007-03-21 16:51:52.000000000 +0100
> +++ refpolicy/policy/modules/services/fail2ban.fc       2007-10-03 23:09:59.000000000 +0200
> @@ -1,3 +1,3 @@
>  /usr/bin/fail2ban      --      gen_context(system_u:object_r:fail2ban_exec_t,s0)
> -/var/log/fail2ban.log  --      gen_context(system_u:object_r:fail2ban_log_t,s0)
> -/var/run/fail2ban.pid  --      gen_context(system_u:object_r:fail2ban_var_run_t,s0)
> +/var/log/fail2ban\.log --      gen_context(system_u:object_r:fail2ban_log_t,s0)
> +/var/run/fail2ban\.pid --      gen_context(system_u:object_r:fail2ban_var_run_t,s0)
> diff -ruN refpolicy.old/policy/modules/services/hal.fc refpolicy/policy/modules/services/hal.fc
> --- refpolicy.old/policy/modules/services/hal.fc        2007-09-05 16:48:21.000000000 +0200
> +++ refpolicy/policy/modules/services/hal.fc    2007-10-03 23:10:29.000000000 +0200
> @@ -15,7 +15,7 @@
>  
>  /var/lib/hal(/.*)?                             gen_context(system_u:object_r:hald_var_lib_t,s0)
>  
> -/var/log/pm-suspend.log                                gen_context(system_u:object_r:hald_log_t,s0)
> +/var/log/pm-suspend\.log                       gen_context(system_u:object_r:hald_log_t,s0)
>  
> -/var/run/haldaemon.pid --                      gen_context(system_u:object_r:hald_var_run_t,s0)
> +/var/run/haldaemon\.pid        --                      gen_context(system_u:object_r:hald_var_run_t,s0)
>  /var/run/vbestate      --                      gen_context(system_u:object_r:hald_var_run_t,s0)
> diff -ruN refpolicy.old/policy/modules/services/oddjob.fc refpolicy/policy/modules/services/oddjob.fc
> --- refpolicy.old/policy/modules/services/oddjob.fc     2006-09-28 16:37:29.000000000 +0200
> +++ refpolicy/policy/modules/services/oddjob.fc 2007-10-03 23:11:11.000000000 +0200
> @@ -2,4 +2,4 @@
>  
>  /usr/sbin/oddjobd              --      gen_context(system_u:object_r:oddjob_exec_t,s0)
>  
> -/var/run/oddjobd.pid                   gen_context(system_u:object_r:oddjob_var_run_t,s0)
> +/var/run/oddjobd\.pid                  gen_context(system_u:object_r:oddjob_var_run_t,s0)
> diff -ruN refpolicy.old/policy/modules/services/radius.fc refpolicy/policy/modules/services/radius.fc
> --- refpolicy.old/policy/modules/services/radius.fc     2006-07-28 17:13:58.000000000 +0200
> +++ refpolicy/policy/modules/services/radius.fc 2007-10-03 23:11:41.000000000 +0200
> @@ -3,7 +3,7 @@
>  /etc/cron\.(daily|weekly|monthly)/freeradius -- gen_context(system_u:object_r:radiusd_exec_t,s0)
>  
>  /etc/raddb(/.*)?                gen_context(system_u:object_r:radiusd_etc_t,s0)
> -/etc/raddb/db.daily     --      gen_context(system_u:object_r:radiusd_etc_rw_t,s0)
> +/etc/raddb/db\.daily     --      gen_context(system_u:object_r:radiusd_etc_rw_t,s0)
>  
>  /usr/sbin/radiusd      --      gen_context(system_u:object_r:radiusd_exec_t,s0)
>  /usr/sbin/freeradius   --      gen_context(system_u:object_r:radiusd_exec_t,s0)
> diff -ruN refpolicy.old/policy/modules/services/ricci.fc refpolicy/policy/modules/services/ricci.fc
> --- refpolicy.old/policy/modules/services/ricci.fc      2006-11-16 21:56:24.000000000 +0100
> +++ refpolicy/policy/modules/services/ricci.fc  2007-10-03 23:12:27.000000000 +0200
> @@ -9,8 +9,8 @@
>  
>  /var/lib/ricci(/.*)?                   gen_context(system_u:object_r:ricci_var_lib_t,s0)
>  
> -/var/log/clumond.log           --      gen_context(system_u:object_r:ricci_modcluster_var_log_t,s0)
> +/var/log/clumond\.log          --      gen_context(system_u:object_r:ricci_modcluster_var_log_t,s0)
>  
> -/var/run/clumond.sock          -s      gen_context(system_u:object_r:ricci_modcluster_var_run_t,s0)
> -/var/run/modclusterd.pid       --      gen_context(system_u:object_r:ricci_modcluster_var_run_t,s0)
> -/var/run/ricci.pid             --      gen_context(system_u:object_r:ricci_var_run_t,s0)
> +/var/run/clumond\.sock                 -s      gen_context(system_u:object_r:ricci_modcluster_var_run_t,s0)
> +/var/run/modclusterd\.pid      --      gen_context(system_u:object_r:ricci_modcluster_var_run_t,s0)
> +/var/run/ricci\.pid            --      gen_context(system_u:object_r:ricci_var_run_t,s0)
> diff -ruN refpolicy.old/policy/modules/services/rpcbind.fc refpolicy/policy/modules/services/rpcbind.fc
> --- refpolicy.old/policy/modules/services/rpcbind.fc    2007-06-27 18:31:55.000000000 +0200
> +++ refpolicy/policy/modules/services/rpcbind.fc        2007-10-03 23:13:04.000000000 +0200
> @@ -2,6 +2,6 @@
>  
>  /var/lib/rpcbind(/.*)?         gen_context(system_u:object_r:rpcbind_var_lib_t,s0)
>  
> -/var/run/rpc.statd.pid --      gen_context(system_u:object_r:rpcbind_var_run_t,s0)
> -/var/run/rpcbind.lock  --      gen_context(system_u:object_r:rpcbind_var_run_t,s0)
> -/var/run/rpcbind.sock  -s      gen_context(system_u:object_r:rpcbind_var_run_t,s0)
> +/var/run/rpc.statd\.pid        --      gen_context(system_u:object_r:rpcbind_var_run_t,s0)
> +/var/run/rpcbind\.lock --      gen_context(system_u:object_r:rpcbind_var_run_t,s0)
> +/var/run/rpcbind\.sock -s      gen_context(system_u:object_r:rpcbind_var_run_t,s0)
> diff -ruN refpolicy.old/policy/modules/services/samba.fc refpolicy/policy/modules/services/samba.fc
> --- refpolicy.old/policy/modules/services/samba.fc      2007-06-19 21:11:35.000000000 +0200
> +++ refpolicy/policy/modules/services/samba.fc  2007-10-03 23:13:21.000000000 +0200
> @@ -3,7 +3,7 @@
>  # /etc
>  #
>  /etc/samba/MACHINE\.SID                --      gen_context(system_u:object_r:samba_secrets_t,s0)
> -/etc/samba/passdb.tdb          --      gen_context(system_u:object_r:samba_secrets_t,s0)
> +/etc/samba/passdb\.tdb         --      gen_context(system_u:object_r:samba_secrets_t,s0)
>  /etc/samba/secrets\.tdb                --      gen_context(system_u:object_r:samba_secrets_t,s0)
>  /etc/samba/smbpasswd           --      gen_context(system_u:object_r:samba_secrets_t,s0)
>  /etc/samba(/.*)?                       gen_context(system_u:object_r:samba_etc_t,s0)
> diff -ruN refpolicy.old/policy/modules/system/init.fc refpolicy/policy/modules/system/init.fc
> --- refpolicy.old/policy/modules/system/init.fc 2006-11-07 20:38:10.000000000 +0100
> +++ refpolicy/policy/modules/system/init.fc     2007-10-03 23:14:18.000000000 +0200
> @@ -11,7 +11,7 @@
>  
>  ifdef(`distro_gentoo',`
>  /etc/vmware/init\.d/vmware --  gen_context(system_u:object_r:initrc_exec_t,s0)
> -/etc/x11/startDM.sh    --      gen_context(system_u:object_r:initrc_exec_t,s0)
> +/etc/x11/startDM\.sh   --      gen_context(system_u:object_r:initrc_exec_t,s0)
>  ')
>  
>  ifdef(`strict_policy',`
> diff -ruN refpolicy.old/policy/modules/system/iscsi.fc refpolicy/policy/modules/system/iscsi.fc
> --- refpolicy.old/policy/modules/system/iscsi.fc        2006-10-31 22:01:48.000000000 +0100
> +++ refpolicy/policy/modules/system/iscsi.fc    2007-10-03 23:14:33.000000000 +0200
> @@ -2,4 +2,4 @@
>  
>  /var/lib/iscsi(/.*)?   --      gen_context(system_u:object_r:iscsi_var_lib_t,s0)
>  /var/lock/iscsi(/.*)?  --      gen_context(system_u:object_r:iscsi_lock_t,s0)
> -/var/run/iscsid.pid    --      gen_context(system_u:object_r:iscsi_var_run_t,s0)
> +/var/run/iscsid\.pid   --      gen_context(system_u:object_r:iscsi_var_run_t,s0)
> diff -ruN refpolicy.old/policy/modules/system/libraries.fc refpolicy/policy/modules/system/libraries.fc
> --- refpolicy.old/policy/modules/system/libraries.fc    2007-06-20 22:08:26.000000000 +0200
> +++ refpolicy/policy/modules/system/libraries.fc        2007-10-03 23:16:03.000000000 +0200
> @@ -132,9 +132,9 @@
>  
>  /usr/(.*/)?nvidia/.+\.so(\..*)?                --      gen_context(system_u:object_r:textrel_shlib_t,s0)
>  
> -/usr/lib/transgaming_cedega/gddb_parser.so --  gen_context(system_u:object_r:shlib_t,s0)
> -/usr/lib/vlc/codec/libdmo_plugin.so       --   gen_context(system_u:object_r:textrel_shlib_t,s0)
> -/usr/lib/vlc/codec/librealaudio_plugin.so  --  gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/lib/transgaming_cedega/gddb_parser\.so -- gen_context(system_u:object_r:shlib_t,s0)
> +/usr/lib/vlc/codec/libdmo_plugin\.so      --   gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/lib/vlc/codec/librealaudio_plugin\.so  -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/lib/win32/.*                      --      gen_context(system_u:object_r:shlib_t,s0)
>  
>  /usr/(.*/)?lib(64)?(/.*)?/nvidia/.+\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> @@ -280,10 +280,10 @@
>  /usr/(local/)?Adobe/(.*/)?lib/[^/]*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/(local/)?acroread/(.*/)?lib/[^/]*\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/(local/)?Adobe/.*\.api            --      gen_context(system_u:object_r:textrel_shlib_t,s0)
> -/usr/(local/)?lib/xchat/plugins/systray.so --  gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/(local/)?lib/xchat/plugins/systray\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/(local/)?matlab.*/bin/glnx86/libmwlapack\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> -/usr/(local/)?matlab.*/bin/glnx86/(libmw(lapack|mathutil|services)|lapack|libmkl).so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> -/usr/(local/)?matlab.*/sys/os/glnx86/libtermcap.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/(local/)?matlab.*/bin/glnx86/(libmw(lapack|mathutil|services)|lapack|libmkl)\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/(local/)?matlab.*/sys/os/glnx86/libtermcap\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  
>  /usr/(.*/)?intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  
> diff -ruN refpolicy.old/policy/modules/system/lvm.fc refpolicy/policy/modules/system/lvm.fc
> --- refpolicy.old/policy/modules/system/lvm.fc  2006-12-04 21:10:56.000000000 +0100
> +++ refpolicy/policy/modules/system/lvm.fc      2007-10-03 23:16:20.000000000 +0200
> @@ -94,5 +94,5 @@
>  #
>  /var/cache/multipathd(/.*)?    gen_context(system_u:object_r:lvm_metadata_t,s0)
>  /var/lock/lvm(/.*)?            gen_context(system_u:object_r:lvm_lock_t,s0)
> -/var/run/multipathd.sock -s    gen_context(system_u:object_r:lvm_var_run_t,s0)
> +/var/run/multipathd\.sock -s   gen_context(system_u:object_r:lvm_var_run_t,s0)
>  /var/lib/multipath(/.*)?       gen_context(system_u:object_r:lvm_var_lib_t,s0)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
