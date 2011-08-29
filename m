Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7T8LCoU031190
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 04:21:16 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7T8LBFQ015395
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 08:21:11 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>
CC: <selinux@tycho.nsa.gov>
Subject: v1 Discard unused tunables from raw policy
Date: Mon, 29 Aug 2011 16:20:59 +0800
Message-ID: <1314606066-12314-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Special Notes
---------------
1. So far the latest master toolchain seems to have a segfault problem related
   with the commit of "libsemanage: patch for MCS/MLS in user files", which
   would be gone if we revert that commit or specify
   "disable-genhomedircon = true" in semanage.conf.
   
2. After using the "-P" option for semodule to preserve all tunables, the
   "preserve_tunables" flag file created in module store would be preserved
   after "make load" completes, resulting in builds after that would inherit
   same behavior until this flag file is mannually removed.
   
   Other options such as "-D/--disalbe_dontaudit" shares the same behavior.


Major differences from v0
---------------------------
1. As suggested by Chris, the mixture of tunables and booleans in one
   expression won't be allowed, so bail out with error rather than printing
   information message in bool_copy_callback() in link.c;

2. As suggested by Joshua, move the separate_tunables() from the very end of
   link to the very beginning of expand (and renamed to discard_tunables()
   now), this is for the interest of preserving the linked policy intact for
   analysis purpose;

3. As required by Dan and suggested by Joshua, add a new flag
   "preserve_tunables" in sepol_handle_t to save and pass a new option "-P"
   from semodule to the expand phase, so that all tunables would be treated
   as booleans and preserved in the raw policy for debug purpose.


Tests I've done
----------------
1. Apply below patchset for refpolicy to cope with toolchain:

   0001-Add-the-definition-of-the-boolean_policy-marcro.patch
   0002-user_ping-is-a-tunable-use-tunable_policy-for-it.patch
   0003-mmap_low_allowed-is-a-tunable-use-tunable_policy-for.patch
   0004-secure_mode_insmod-is-a-boolean-use-boolean_policy-f.patch

   Mostly these patches would add a new boolean_policy() macro and make
   the tunable_policy() macro use "tunable" keyword rather than "bool".

2. We can see the size of policy.X droped significantly from 466k to 316k.

3. With the checkpolicy tool, we can see there are only 4 booleans preserved in
   the raw policy:

   Choose:  f
   secure_mode : 0
   pppd_can_insmod : 0
   secure_mode_insmod : 0
   secure_mode_policyload : 0

4. So far the "console_login" tunable defaults to true, we can see the related
   type_change rules for console_device_t in its conditionals are available in
   the raw policy:

   11 rules match the search criteria.
   Number of enabled conditional rules: 0
   Number of disabled conditional rules: 0
   
   type_change auditadm_t console_device_t : chr_file user_tty_device_t;
   type_change dbadm_t console_device_t : chr_file user_tty_device_t;
   type_change guest_t console_device_t : chr_file user_tty_device_t;
   type_change logadm_t console_device_t : chr_file user_tty_device_t;
   type_change secadm_t console_device_t : chr_file user_tty_device_t;
   type_change staff_t console_device_t : chr_file user_tty_device_t;
   type_change sysadm_t console_device_t : chr_file user_tty_device_t;
   type_change unconfined_t console_device_t : chr_file user_tty_device_t;
   type_change user_t console_device_t : chr_file user_tty_device_t;
   type_change webadm_t console_device_t : chr_file user_tty_device_t;
   type_change xguest_t console_device_t : chr_file user_tty_device_t;

5. Re-build policy with console_login defaults to false, then all above
   type_change rules for console_device_t would be gone:

   0 rules match the search criteria.
   Number of enabled conditional rules: 0
   Number of disabled conditional rules: 0
   
   (And the raw policy's size would further goes down from 3163312 bytes
    to 3163180 bytes)
   
6. Specifiy the "-P" option for semodule to preserve all tunables:

   ls /usr/share/selinux/refpolicy/*.pp | grep -v base.pp | sudo /usr/sbin/semodule -P -s refpolicy -b /usr/share/selinux/refpolicy/base.pp

   And we can see that the size of raw policy would be back to 466k with all
   tunables preserved as booleans:

   cao@cao-laptop:/etc/selinux/refpolicy$ ls -lt policy/
   total 12240
   -rw-r--r--. 1 root root 4666684 2011-08-29 14:49 policy.24
   cao@cao-laptop:/etc/selinux/refpolicy$
   
   Choose:  f
   allow_ftpd_full_access : 0
   allow_zebra_write_config : 0
   cdrecord_read_content : 0
   fcron_crond : 0
   mmap_low_allowed : 0
   samba_share_fusefs : 0
   sepgsql_enable_users_ddl : 1
   allow_ftpd_use_cifs : 0
   allow_java_execstack : 0
   cron_can_relabel : 0
   openvpn_enable_homedirs : 0
   samba_export_all_ro : 0
   secure_mode : 0
   spamassassin_can_network : 0
   virt_use_sysfs : 0
   xserver_object_manager : 0
   allow_cvs_read_shadow : 0
   allow_gssd_read_tmp : 1
   allow_httpd_bugzilla_script_anon_write : 0
   fenced_can_network_connect : 0
   httpd_enable_ftp_server : 0
   httpd_use_nfs : 0
   nfs_export_all_ro : 0
   qemu_use_usb : 1
   user_dmesg : 0
   virt_use_nfs : 0
   xguest_mount_media : 1
   allow_httpd_munin_script_anon_write : 0
   allow_httpd_squid_script_anon_write : 0
   allow_mplayer_execstack : 0
   named_write_master_zones : 0
   portage_use_nfs : 0
   pppd_can_insmod : 0
   qemu_use_nfs : 1
   virt_use_samba : 0
   virt_use_usb : 1
   xend_run_blktap : 1
   allow_httpd_anon_write : 0
   allow_httpd_user_script_anon_write : 0
   allow_ssh_keysign : 0
   cobbler_anon_write : 0
   entropyd_use_audio : 0
   exim_can_connect_db : 0
   httpd_can_network_relay : 0
   samba_create_home_dirs : 0
   samba_enable_home_dirs : 0
   spamd_enable_home_dirs : 1
   telepathy_tcp_connect_generic_network_ports : 0
   use_lpd_server : 0
   user_direct_mouse : 0
   allow_httpd_mediawiki_script_anon_write : 0
   allow_httpd_prewikka_script_anon_write : 0
   allow_rsync_anon_write : 0
   clamd_use_jit : 0
   httpd_tty_comm : 0
   httpd_unified : 0
   init_upstart : 0
   qemu_full_network : 0
   qemu_use_comm : 0
   rsync_export_all_ro : 0
   secure_mode_insmod : 0
   squid_connect_any : 0
   user_ping : 0
   virt_use_comm : 0
   allow_execmod : 0
   httpd_use_gpg : 0
   samba_share_nfs : 0
   user_tcp_server : 0
   user_ttyfile_stat : 0
   virt_use_fusefs : 0
   allow_user_postgresql_connect : 0
   console_login : 0
   httpd_builtin_scripting : 0
   httpd_can_sendmail : 0
   httpd_enable_cgi : 0
   racoon_read_shadow : 0
   allow_ftpd_use_nfs : 0
   allow_httpd_mojomojo_script_anon_write : 0
   samba_run_unconfined : 0
   wine_mmap_zero_ignore : 0
   xen_use_nfs : 0
   allow_execheap : 0
   allow_execstack : 0
   allow_httpd_nagios_script_anon_write : 0
   allow_httpd_w3c_validator_script_anon_write : 0
   rgmanager_can_network_connect : 0
   samba_domain_controller : 0
   samba_export_all_rw : 0
   varnishd_connect_any : 0
   allow_kerberos : 0
   global_ssp : 0
   gpg_agent_env_file : 0
   httpd_dbus_avahi : 0
   mozilla_read_content : 0
   nfs_export_all_rw : 0
   sepgsql_unconfined_dbadm : 1
   sftpd_anon_write : 0
   webadm_manage_user_files : 0
   allow_httpd_apcupsd_cgi_script_anon_write : 0
   ftp_home_dir : 0
   httpd_enable_homedirs : 0
   httpd_ssi_exec : 0
   httpd_use_cifs : 0
   mysql_connect_any : 0
   pppd_for_user : 0
   qemu_use_cifs : 1
   sftpd_enable_homedirs : 0
   squid_use_tproxy : 0
   telepathy_connect_all_ports : 0
   xguest_connect_network : 1
   allow_httpd_awstats_script_anon_write : 0
   allow_httpd_cvs_script_anon_write : 0
   allow_httpd_git_script_anon_write : 0
   allow_httpd_smokeping_cgi_script_anon_write : 0
   allow_httpd_sys_script_anon_write : 0
   allow_saslauthd_read_shadow : 0
   allow_ypbind : 0
   sftpd_full_access : 0
   user_rw_noexattrfile : 0
   allow_ptrace : 0
   dbadm_manage_user_files : 0
   exim_manage_user_files : 0
   puppet_manage_all_files : 0
   secure_mode_policyload : 0
   tftp_anon_write : 0
   use_samba_home_dirs : 0
   xend_run_qemu : 1
   allow_mount_anyfile : 0
   allow_user_mysql_connect : 0
   dbadm_read_user_files : 0
   exim_read_user_files : 0
   httpd_can_network_connect : 0
   mail_read_content : 0
   smartmon_3ware : 0
   ssh_sysadm_login : 0
   webadm_read_user_files : 0
   xdm_sysadm_login : 0
   xguest_use_bluetooth : 1
   allow_execmem : 0
   allow_ftpd_anon_write : 0
   allow_httpd_cobbler_script_anon_write : 0
   allow_httpd_nutups_cgi_script_anon_write : 0
   allow_nfsd_anon_write : 0
   allow_polyinstantiation : 0
   allow_smbd_anon_write : 0
   allow_write_xshm : 0
   httpd_can_network_connect_db : 0
   privoxy_connect_any : 0
   tor_bind_all_unreserved_ports : 0
   use_nfs_home_dirs : 0
   vbetool_mmap_zero_ignore : 0
   
   Choose:
   
7. Monolithic policy builds ok:   
   cao@cao-laptop:/work/selinux/refpolicy$ sudo make policy
   ......
   cao@cao-laptop:/work/selinux/refpolicy$ ls -lt policy.24
   -rw-r--r--. 1 root root 3163312 2011-08-29 15:00 policy.24
   cao@cao-laptop:/work/selinux/refpolicy$

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
