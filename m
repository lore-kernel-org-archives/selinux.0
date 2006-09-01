Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81JjKqx021289
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 15:45:20 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k81JielZ028552
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 19:44:40 GMT
Message-ID: <44F88DD4.6020804@redhat.com>
Date: Fri, 01 Sep 2006 15:45:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest updates
References: <44F7358E.4010101@redhat.com> <1157125888.3199.157.camel@sgc.columbia.tresys.com>
In-Reply-To: <1157125888.3199.157.camel@sgc.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------090603000204090902020102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090603000204090902020102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Thu, 2006-08-31 at 15:16 -0400, Daniel J Walsh wrote:
>   
>> Amanda changes, not sure why you didn't take them last time
>>     
>
> Sorry about that, forgot to send an email about that last patch.  As for
> this bit, I'm hesitant to remove the contexts.  This policy seems to be
> overengineered, and since we intend to fix it, the unused types should
> be removed too.  Otherwise we start getting dead policy, and more mess
> in general.
>
>   
Removed Types
>> Fixing some labels to march what actually ends up on disk  see /boot/grub
>>     
>
> These say /boot/grup; I assume this is a typo.  Also they should be in
> the files module.
>
>   
Fixed and placed in correct fc files.
>> Change firstboot to create etc_runtime_t instead of firstboot_rw_t.
>>     
>
>   
> The type should be removed too, see above comments on
> amanda.  /usr/share/firstboot is also labeled firstboot_rw_t, so that
> should be resolved too.
>
>   
Removed Types
>> Please change /opt java line to match what IBM ships
>>     
>
> I'm concerned this is too broad.  Can we get additional, more specific
> regexes?
>
>   
I went looking for this, and I believe it was placed in a IBM directory, 
but can not find it right now.
Also not sure where BEA places there java.
>> In corecommands prelink also creates lnk_file, when it recreates 
>> executables.
>>     
>
>   
> I assume this refers to the hunk in corecommands.if?  I don't agree with
> this change.  Only the executables should be specially labeled, not the
> symlinks.
>
>   
Changed to bin_t and sbin_t only.
>> gfs supports xattr
>>     
>
> IIRC, last time the question was if this was widely avaiable?
>
>   
Could swear I got email telling me to do this, but can not find now so 
removing.
>> Lots of domains need term_dontaudit_use_unallocated_ttys for startup 
>> from a tty.
>>     
>
> Can you clarify this?  I don't know what you mean by "startup from a
> tty".
>
>   
Log in to console terminals

ctrl-alt-f1

restart daemons, generated lots of avc messages when daemons try to talk 
to tty_device_t. 

you will see this same pattern on almost all daemons.
>> Apache uses ldap
>>     
>
> This reverts my change; this access is handled by auth_use_nsswitch().
>
>   
Removed.
>> bluetooth_helper started for startx needs some more privs
>>     
>
> This corenet addition seems out of place, since it doesn't have complete
> networking perms.  Fixed the xserver_stream_connect_xdm() interface
> instead of the xdm addition.
>
>   
Changed to use your stuff.
>> crontab changes for setting MLS values.
>>     
>
> The userdomain sending a sigchld to crontab doesn't make sense to me.
> Also $1_tmp_t can't be referenced directly by this template, it needs to
> use the userdomain interfaces.  Besides that, I think it would probably
> be best for crontab to have its own $1_crontab_tmp_t type anyway, unless
> there is a compelling reason for it to write the user's tmp files.
>
>   
Changed to $1_crontab_tmp_t, removed the other stuff and will retest on mls.
> Why does system_crond_t need to create crond pid files?
>
>   
Saw an AVC but I am removing this code for now.
>> dovecot wants to read some files labeled var_t.
>>     
>
> Moved rule down.
>
>   
>> ldap uses a socket to communicate
>>     
>
> Generic socket doesn't make sense here.
>
>   
Should be a sock_file
>> NetworkManager wants to ptrace itself
>>     
>
> I can't reproduce this on my notebook.  Can you look more into this?  It
> seems highly irregular.
>
>   
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=204161
>> stunnel reads route table
>> and connects to smtp
>>     
>
> Is this an explicit requirement, or should it really be tcp connect to
> all ports?
>   
Probably.


>   
>> X No longer needs execstack, execheap, execmem
>>     
>
> I am setting this to !distro_redhat, as this is not necessarily the case
> for other distros (incl RHEL4).
>
>   
Fine
>> Changes to semanage
>>     
>
> Can't use these templates here.  The netlink addition is handled by
> auth_use_nsswitch().
>
>   
Ok I removed some other netlink_route for same reason
>> /usr/lib/ia32el/ia32x_loader needs to run unconfined_execmem_t if we 
>> have any hope of turning off allow_execmem
>>     
>
> Out of curiosity, what is this program?
>   
See eric's email
> The ntp change shouldn't be needed, since net_bind_service is allowed by
> corenet_udp_bind_ntp_port(ntpd_t).
>
>   
Removed
> The procmail change shouldn't be needed since udp bind to inaddr_any is
> allowed by corenet_udp_bind_all_nodes(procmail_t).
>
>   
Removed
> The rpc change shouldn't be needed since all domains have self:file
> { getattr read };
>
>   
Removed
> The unconfined change should not be needed since it can do * to all
> domains keys (see domain.te).
>   
Removed
> Holding off on the other new policies since you said they're still WiP.
>
> Why are the following needed?
>
> fsadm exec a shell
>
>   
I am not sure, I removed until I find it.
> initrc write locale_t
>
> lvm_t net_admin (!)
>   
Removed, might be some network file system?  iscsi maybe, just guessing.
> depmod using terms other than the ones it gets from it's run interface
>
>   
Removed.
> udev transition to dhcpc
>
>
>   
It does when networks are plugged in, I believe.
> The remainder is merged.
>
>   


--------------090603000204090902020102
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/amanda.fc serefpolicy-2.3.11/policy/modules/admin/amanda.fc
--- nsaserefpolicy/policy/modules/admin/amanda.fc	2006-08-29 09:00:30.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/admin/amanda.fc	2006-09-01 15:41:44.000000000 -0400
@@ -11,61 +11,11 @@
 /usr/lib(64)?/amanda		-d	gen_context(system_u:object_r:amanda_usr_lib_t,s0)
 /usr/lib(64)?/amanda/.+		--	gen_context(system_u:object_r:amanda_exec_t,s0)
 /usr/lib(64)?/amanda/amandad	--	gen_context(system_u:object_r:amanda_inetd_exec_t,s0)
-/usr/lib(64)?/amanda/amcat\.awk	--	gen_context(system_u:object_r:amanda_script_exec_t,s0)
-/usr/lib(64)?/amanda/amcleanupdisk --	gen_context(system_u:object_r:amanda_exec_t,s0)
 /usr/lib(64)?/amanda/amidxtaped	--	gen_context(system_u:object_r:amanda_inetd_exec_t,s0)
 /usr/lib(64)?/amanda/amindexd	--	gen_context(system_u:object_r:amanda_inetd_exec_t,s0)
-/usr/lib(64)?/amanda/amlogroll	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/amplot\.awk --	gen_context(system_u:object_r:amanda_script_exec_t,s0)
-/usr/lib(64)?/amanda/amplot\.g	--	gen_context(system_u:object_r:amanda_script_exec_t,s0)
-/usr/lib(64)?/amanda/amplot\.gp	--	gen_context(system_u:object_r:amanda_script_exec_t,s0)
-/usr/lib(64)?/amanda/amtrmidx	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/amtrmlog	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/calcsize	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/chg-chio	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/chg-chs	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/chg-manual	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/chg-mtx	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/chg-multi	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/chg-rth	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/chg-scsi	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/chg-zd-mtx	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/driver	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/dumper	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/killpgrp	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/patch-system --	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/planner	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/rundump	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/runtar	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/selfcheck	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/sendbackup	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/sendsize	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/taper	--	gen_context(system_u:object_r:amanda_exec_t,s0)
-/usr/lib(64)?/amanda/versionsuffix --	gen_context(system_u:object_r:amanda_exec_t,s0)
-
-/usr/sbin/amadmin		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amcheck		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amcheckdb		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amcleanup		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amdump		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amflush		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amgetconf		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amlabel		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amoverview		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amplot		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
 /usr/sbin/amrecover		--	gen_context(system_u:object_r:amanda_recover_exec_t,s0)
-/usr/sbin/amreport		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amrestore		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amrmtape		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amstatus		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amtape		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amtoc			--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-/usr/sbin/amverify		--	gen_context(system_u:object_r:amanda_user_exec_t,s0)
-
 /var/lib/amanda			-d	gen_context(system_u:object_r:amanda_var_lib_t,s0)
 /var/lib/amanda/\.amandahosts	--	gen_context(system_u:object_r:amanda_config_t,s0)
-/var/lib/amanda/\.bashrc	--	gen_context(system_u:object_r:amanda_shellconfig_t,s0)
-/var/lib/amanda/\.profile	--	gen_context(system_u:object_r:amanda_shellconfig_t,s0)
 /var/lib/amanda/disklist	--	gen_context(system_u:object_r:amanda_data_t,s0)
 /var/lib/amanda/gnutar-lists(/.*)?	gen_context(system_u:object_r:amanda_gnutarlists_t,s0)
 /var/lib/amanda/index			gen_context(system_u:object_r:amanda_data_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/amanda.te serefpolicy-2.3.11/policy/modules/admin/amanda.te
--- nsaserefpolicy/policy/modules/admin/amanda.te	2006-08-29 09:00:30.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/admin/amanda.te	2006-09-01 15:41:44.000000000 -0400
@@ -33,18 +33,6 @@
 type amanda_gnutarlists_t;
 files_type(amanda_gnutarlists_t)
 
-# type for user startable files
-type amanda_user_exec_t;
-corecmd_executable_file(amanda_user_exec_t)
-
-# type for same awk and other scripts
-type amanda_script_exec_t;
-corecmd_executable_file(amanda_script_exec_t)
-
-# type for the shell configuration files 
-type amanda_shellconfig_t;
-files_type(amanda_shellconfig_t)
-
 type amanda_tmp_t;
 files_tmp_file(amanda_tmp_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/anaconda.te serefpolicy-2.3.11/policy/modules/admin/anaconda.te
--- nsaserefpolicy/policy/modules/admin/anaconda.te	2006-09-01 14:10:19.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/admin/anaconda.te	2006-09-01 15:41:44.000000000 -0400
@@ -64,3 +64,9 @@
 optional_policy(`
 	usermanage_domtrans_admin_passwd(anaconda_t)
 ')
+
+
+# The following is just to quiet the anaconda complaining during the install
+domain_dontaudit_getattr_all_stream_sockets(anaconda_t)
+dontaudit domain anaconda_t:fd use;
+domain_dontaudit_use_interactive_fds(anaconda_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/bootloader.fc serefpolicy-2.3.11/policy/modules/admin/bootloader.fc
--- nsaserefpolicy/policy/modules/admin/bootloader.fc	2006-07-14 17:04:46.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/admin/bootloader.fc	2006-09-01 15:41:44.000000000 -0400
@@ -10,3 +10,4 @@
 /sbin/lilo.*		--	gen_context(system_u:object_r:bootloader_exec_t,s0)
 /sbin/mkinitrd		--	gen_context(system_u:object_r:bootloader_exec_t,s0)
 /sbin/ybin.*		--	gen_context(system_u:object_r:bootloader_exec_t,s0)
+/boot/grub/.*		--	gen_context(system_u:object_r:boot_runtime_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/bootloader.te serefpolicy-2.3.11/policy/modules/admin/bootloader.te
--- nsaserefpolicy/policy/modules/admin/bootloader.te	2006-08-29 09:00:30.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/admin/bootloader.te	2006-09-01 15:41:44.000000000 -0400
@@ -161,7 +161,7 @@
 	allow bootloader_t self:capability ipc_lock;
 
 	# new file system defaults to file_t, granting file_t access is still bad.
-	allow bootloader_t boot_runtime_t:file { r_file_perms unlink };
+	allow bootloader_t boot_runtime_t:file { rw_file_perms unlink };
 
 	# mkinitrd mount initrd on bootloader temp dir
 	files_mountpoint(bootloader_tmp_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/consoletype.te serefpolicy-2.3.11/policy/modules/admin/consoletype.te
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2006-08-29 09:00:30.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/admin/consoletype.te	2006-09-01 15:41:44.000000000 -0400
@@ -8,7 +8,12 @@
 
 type consoletype_t;
 type consoletype_exec_t;
-init_domain(consoletype_t,consoletype_exec_t)
+#dont transition from initrc
+#init_domain(consoletype_t,consoletype_exec_t)
+domain_type(consoletype_t)
+domain_entry_file(consoletype_t,consoletype_exec_t)
+role system_r types consoletype_t;
+
 mls_file_read_up(consoletype_t)
 mls_file_write_down(consoletype_t)
 role system_r types consoletype_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/firstboot.te serefpolicy-2.3.11/policy/modules/admin/firstboot.te
--- nsaserefpolicy/policy/modules/admin/firstboot.te	2006-08-29 09:00:30.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/admin/firstboot.te	2006-09-01 15:41:44.000000000 -0400
@@ -20,9 +20,6 @@
 type firstboot_etc_t;
 files_config_file(firstboot_etc_t)
 
-type firstboot_rw_t;
-files_type(firstboot_rw_t)
-
 ########################################
 #
 # Local policy
@@ -38,9 +35,8 @@
 
 allow firstboot_t firstboot_etc_t:file { getattr read };
 
-allow firstboot_t firstboot_rw_t:dir create_dir_perms;
-allow firstboot_t firstboot_rw_t:file create_file_perms;
-files_etc_filetrans(firstboot_t,firstboot_rw_t,file)
+files_manage_etc_runtime_files(firstboot_t)
+files_etc_filetrans_etc_runtime(firstboot_t, { file dir })
 
 # The big hammer
 unconfined_domain(firstboot_t) 
@@ -124,6 +120,11 @@
 	usermanage_domtrans_useradd(firstboot_t)
 ')
 
+optional_policy(`
+	usermanage_domtrans_admin_passwd(firstboot_t)
+')
+
+
 ifdef(`TODO',`
 allow firstboot_t proc_t:file write;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.fc serefpolicy-2.3.11/policy/modules/admin/rpm.fc
--- nsaserefpolicy/policy/modules/admin/rpm.fc	2006-07-14 17:04:46.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/admin/rpm.fc	2006-09-01 15:41:44.000000000 -0400
@@ -19,6 +19,8 @@
 /usr/sbin/pup			--	gen_context(system_u:object_r:rpm_exec_t,s0)
 /usr/sbin/rhn_check		--	gen_context(system_u:object_r:rpm_exec_t,s0)
 /usr/sbin/up2date		--	gen_context(system_u:object_r:rpm_exec_t,s0)
+/usr/bin/apt-get		--	gen_context(system_u:object_r:rpm_exec_t,s0)
+/usr/bin/apt-shell		--	gen_context(system_u:object_r:rpm_exec_t,s0)
 ')
 
 /var/lib/alternatives(/.*)?		gen_context(system_u:object_r:rpm_var_lib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.if serefpolicy-2.3.11/policy/modules/admin/rpm.if
--- nsaserefpolicy/policy/modules/admin/rpm.if	2006-08-02 10:34:09.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/admin/rpm.if	2006-09-01 15:41:44.000000000 -0400
@@ -75,12 +75,13 @@
 	')
 
 	rpm_domtrans($1)
-	role $2 types rpm_t;
-	role $2 types rpm_script_t;
-	seutil_run_loadpolicy(rpm_script_t,$2,$3)
-	seutil_run_semanage(rpm_script_t,$2,$3)
-	seutil_run_setfiles(rpm_script_t,$2,$3)
-	seutil_run_restorecon(rpm_script_t,$2,$3)
+	#role $2 types rpm_t;
+	#role $2 types rpm_script_t;
+	role_transition $2 rpm_exec_t system_r;
+	seutil_run_loadpolicy(rpm_script_t,system_r,$3)
+	seutil_run_semanage(rpm_script_t,system_r,$3)
+	seutil_run_setfiles(rpm_script_t,system_r,$3)
+	seutil_run_restorecon(rpm_script_t,system_r,$3)
 	allow rpm_t $3:chr_file rw_term_perms;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.fc serefpolicy-2.3.11/policy/modules/apps/java.fc
--- nsaserefpolicy/policy/modules/apps/java.fc	2006-08-29 09:00:26.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/apps/java.fc	2006-09-01 15:41:44.000000000 -0400
@@ -1,7 +1,7 @@
 #
 # /opt
 #
-/opt/(.*/)?bin/java([^/]*)? --	gen_context(system_u:object_r:java_exec_t,s0)
+/opt/(.*/)?java([^/]*)? --	gen_context(system_u:object_r:java_exec_t,s0)
 
 #
 # /usr
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.if serefpolicy-2.3.11/policy/modules/kernel/corecommands.if
--- nsaserefpolicy/policy/modules/kernel/corecommands.if	2006-08-02 10:34:05.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/kernel/corecommands.if	2006-09-01 15:41:44.000000000 -0400
@@ -950,6 +950,7 @@
 
 	allow $1 exec_type:file manage_file_perms;
 	allow $1 { bin_t sbin_t }:dir rw_dir_perms;
+	allow $1 { bin_t sbin_t }:lnk_file create_lnk_perms;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-2.3.11/policy/modules/kernel/corenetwork.te.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2006-09-01 14:10:17.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/kernel/corenetwork.te.in	2006-09-01 15:41:44.000000000 -0400
@@ -67,6 +67,7 @@
 network_port(clamd, tcp,3310,s0)
 network_port(clockspeed, udp,4041,s0)
 network_port(comsat, udp,512,s0)
+network_port(cluster, tcp,40040,s0)
 network_port(cvs, tcp,2401,s0, udp,2401,s0)
 network_port(dcc, udp,6276,s0, udp,6277,s0)
 network_port(dbskkd, tcp,1178,s0)
@@ -121,12 +122,13 @@
 network_port(radacct, udp,1646,s0, udp,1813,s0)
 network_port(radius, udp,1645,s0, udp,1812,s0)
 network_port(razor, tcp,2703,s0)
+network_port(ricci, tcp,11111,s0, udp,11111,s0)
+network_port(ricci_modcluster, tcp,16851,s0, udp,16851,s0)
 network_port(rlogind, tcp,513,s0)
 network_port(rndc, tcp,953,s0)
 network_port(router, udp,520,s0)
 network_port(rsh, tcp,514,s0)
 network_port(rsync, tcp,873,s0, udp,873,s0)
-network_port(setroubleshoot, tcp,3267,s0)
 network_port(smbd, tcp,137-139,s0, tcp,445,s0)
 network_port(smtp, tcp,25,s0, tcp,465,s0, tcp,587,s0)
 network_port(snmp, udp,161,s0, udp,162,s0, tcp,199,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.fc serefpolicy-2.3.11/policy/modules/kernel/files.fc
--- nsaserefpolicy/policy/modules/kernel/files.fc	2006-09-01 14:10:17.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/kernel/files.fc	2006-09-01 15:41:44.000000000 -0400
@@ -32,6 +32,7 @@
 /boot/lost\+found	-d	gen_context(system_u:object_r:lost_found_t,s15:c0.c255)
 /boot/lost\+found/.*		<<none>>
 /boot/System\.map(-.*)?	--	gen_context(system_u:object_r:system_map_t,s0)
+/boot/grub/slapsh.xpm.gz --	gen_context(system_u:object_r:boot_t,s0)
 
 #
 # /emul
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/terminal.if serefpolicy-2.3.11/policy/modules/kernel/terminal.if
--- nsaserefpolicy/policy/modules/kernel/terminal.if	2006-08-29 09:00:26.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/kernel/terminal.if	2006-09-01 15:41:44.000000000 -0400
@@ -886,7 +886,7 @@
 		type tty_device_t;
 	')
 
-	dontaudit $1 tty_device_t:chr_file { read write };
+	dontaudit $1 tty_device_t:chr_file rw_file_perms;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/amavis.te serefpolicy-2.3.11/policy/modules/services/amavis.te
--- nsaserefpolicy/policy/modules/services/amavis.te	2006-08-29 09:00:27.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/amavis.te	2006-09-01 15:41:44.000000000 -0400
@@ -155,6 +155,7 @@
 
 ifdef(`targeted_policy',`
 	term_dontaudit_use_generic_ptys(amavis_t)
+	term_dontaudit_use_unallocated_ttys(amavis_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.te serefpolicy-2.3.11/policy/modules/services/apache.te
--- nsaserefpolicy/policy/modules/services/apache.te	2006-08-29 09:00:28.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/apache.te	2006-09-01 15:41:44.000000000 -0400
@@ -141,7 +141,6 @@
 allow httpd_t self:msg { send receive };
 allow httpd_t self:unix_dgram_socket { create_socket_perms sendto };
 allow httpd_t self:unix_stream_socket { create_stream_socket_perms connectto };
-allow httpd_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
 allow httpd_t self:tcp_socket create_stream_socket_perms;
 allow httpd_t self:udp_socket create_socket_perms;
 
@@ -713,4 +712,5 @@
 
 ifdef(`targeted_policy',`
 	term_dontaudit_use_generic_ptys(httpd_rotatelogs_t)
+	term_dontaudit_use_unallocated_ttys(httpd_rotatelogs_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bluetooth.te serefpolicy-2.3.11/policy/modules/services/bluetooth.te
--- nsaserefpolicy/policy/modules/services/bluetooth.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/bluetooth.te	2006-09-01 15:41:44.000000000 -0400
@@ -217,14 +217,16 @@
 	fs_rw_tmpfs_files(bluetooth_helper_t)
 
 	term_dontaudit_use_generic_ptys(bluetooth_helper_t)
+	term_dontaudit_use_unallocated_ttys(bluetooth_helper_t)
 
 	unconfined_stream_connect(bluetooth_helper_t)
 
 	userdom_manage_generic_user_home_content_files(bluetooth_helper_t)
 
+	corenet_non_ipsec_sendrecv(bluetooth_helper_t)
+
 	optional_policy(`
 	        corenet_tcp_connect_xserver_port(bluetooth_helper_t)
-
 		xserver_stream_connect_xdm(bluetooth_helper_t)
 		xserver_use_xdm_fds(bluetooth_helper_t)
 		xserver_rw_xdm_pipes(bluetooth_helper_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ccs.fc serefpolicy-2.3.11/policy/modules/services/ccs.fc
--- nsaserefpolicy/policy/modules/services/ccs.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/ccs.fc	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,8 @@
+# ccs executable will have:
+# label: system_u:object_r:ccs_exec_t
+# MLS sensitivity: s0
+# MCS categories: <none>
+
+/sbin/ccsd		--	gen_context(system_u:object_r:ccs_exec_t,s0)
+/var/run/cluster(/.*)?		gen_context(system_u:object_r:ccs_var_run_t,s0)
+/etc/cluster(/.*)?		gen_context(system_u:object_r:cluster_conf_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ccs.if serefpolicy-2.3.11/policy/modules/services/ccs.if
--- nsaserefpolicy/policy/modules/services/ccs.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/ccs.if	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,65 @@
+## <summary>policy for ccs</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run ccs.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`ccs_domtrans',`
+	gen_require(`
+		type ccs_t, ccs_exec_t;
+	')
+
+	domain_auto_trans($1,ccs_exec_t,ccs_t)
+
+	allow $1 ccs_t:fd use;
+	allow ccs_t $1:fd use;
+	allow ccs_t $1:fifo_file rw_file_perms;
+	allow ccs_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Connect to ccs over an unix stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ccs_stream_connect',`
+	gen_require(`
+		type ccs_t, ccs_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 ccs_var_run_t:dir r_dir_perms;
+	allow $1 ccs_var_run_t:sock_file write;
+	allow $1 ccs_t:unix_stream_socket connectto;
+')
+
+########################################
+## <summary>
+##	Read cluster configuration files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ccs_read_config',`
+	gen_require(`
+		type cluster_conf_t;
+	')
+
+	allow $1 cluster_conf_t:dir search_dir_perms;
+	allow $1 cluster_conf_t:file { getattr read };
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ccs.te serefpolicy-2.3.11/policy/modules/services/ccs.te
--- nsaserefpolicy/policy/modules/services/ccs.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/ccs.te	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,87 @@
+policy_module(ccs,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type ccs_t;
+type ccs_exec_t;
+domain_type(ccs_t)
+init_daemon_domain(ccs_t, ccs_exec_t)
+
+# pid files
+type ccs_var_run_t;
+files_pid_file(ccs_var_run_t)
+
+# pid files
+type cluster_conf_t;
+files_type(cluster_conf_t)
+
+# log files
+type ccs_var_log_t;
+logging_log_file(ccs_var_log_t)
+
+########################################
+#
+# ccs local policy
+#
+# Check in /etc/selinux/refpolicy/include for macros to use instead of allow rules.
+
+allow ccs_t self:process signal;
+
+allow ccs_t self:socket create_socket_perms;
+allow ccs_t self:tcp_socket create_stream_socket_perms;
+allow ccs_t self:udp_socket { create_socket_perms listen recv_msg send_msg };
+allow ccs_t self:unix_dgram_socket create_socket_perms;
+allow ccs_t self:netlink_route_socket r_netlink_socket_perms;
+## Networking basics (adjust to your needs!)
+sysnet_dns_name_resolve(ccs_t)
+corenet_tcp_sendrecv_all_if(ccs_t)
+corenet_tcp_sendrecv_all_nodes(ccs_t)
+corenet_tcp_sendrecv_all_ports(ccs_t)
+corenet_udp_sendrecv_all_ports(ccs_t)
+corenet_non_ipsec_sendrecv(ccs_t)
+corenet_tcp_bind_all_nodes(ccs_t)
+corenet_udp_bind_all_nodes(ccs_t)
+# Wants to connect to 40040
+corenet_tcp_connect_all_ports(ccs_t)
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(ccs_t)
+libs_use_ld_so(ccs_t)
+libs_use_shared_libs(ccs_t)
+miscfiles_read_localization(ccs_t)
+## internal communication is often done using fifo and unix sockets.
+allow ccs_t self:fifo_file { read write };
+allow ccs_t self:unix_stream_socket create_stream_socket_perms;
+
+# pid file
+allow ccs_t ccs_var_run_t:file manage_file_perms;
+allow ccs_t ccs_var_run_t:sock_file manage_file_perms;
+allow ccs_t ccs_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(ccs_t,ccs_var_run_t, { file sock_file })
+
+# log files
+allow ccs_t ccs_var_log_t:file create_file_perms;
+allow ccs_t ccs_var_log_t:sock_file create_file_perms;
+allow ccs_t ccs_var_log_t:dir { rw_dir_perms setattr };
+logging_log_filetrans(ccs_t,ccs_var_log_t,{ sock_file file dir })
+
+logging_send_syslog_msg(ccs_t)
+
+files_read_etc_runtime_files(ccs_t)
+
+kernel_read_kernel_sysctls(ccs_t)
+
+sysnet_dns_name_resolve(ccs_t)
+
+unconfined_use_fds(ccs_t)
+
+ifdef(`targeted_policy', `
+	term_dontaudit_use_generic_ptys(ccs_t)
+	term_dontaudit_use_unallocated_ttys(ccs_t)
+')
+
+allow ccs_t cluster_conf_t:dir r_dir_perms;
+allow ccs_t cluster_conf_t:file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/clamav.te serefpolicy-2.3.11/policy/modules/services/clamav.te
--- nsaserefpolicy/policy/modules/services/clamav.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/clamav.te	2006-09-01 15:41:44.000000000 -0400
@@ -121,6 +121,7 @@
 cron_rw_pipes(clamd_t)
 
 ifdef(`targeted_policy',`
+	term_dontaudit_use_unallocated_ttys(clamd_t)
 	term_dontaudit_use_generic_ptys(clamd_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.if serefpolicy-2.3.11/policy/modules/services/cron.if
--- nsaserefpolicy/policy/modules/services/cron.if	2006-08-29 09:00:28.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/cron.if	2006-09-01 15:41:44.000000000 -0400
@@ -54,6 +54,11 @@
 	domain_entry_file($1_crontab_t,crontab_exec_t)
 	role $3 types $1_crontab_t;
 
+	type $1_crontab_tmp_t;
+	files_tmp_file($1_crontab_tmp_t)
+
+
+
 	##############################
 	#
 	# $1_crond_t local policy
@@ -193,6 +198,10 @@
 	# Allow crond to read those crontabs in cron spool.
 	allow crond_t $1_cron_spool_t:file create_file_perms;
 
+	allow $1_crontab_t tmp_t:dir rw_dir_perms;
+	allow $1_crontab_t $1_crontab_tmp_t:file create_file_perms;
+	type_transition $1_crontab_t tmp_t:file $1_crontab_tmp_t;
+
 	# dac_override is to create the file in the directory under /tmp
 	allow $1_crontab_t self:capability { fowner setuid setgid chown dac_override };
 	allow $1_crontab_t self:process signal_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-2.3.11/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2006-08-29 09:00:28.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/cron.te	2006-09-01 15:41:44.000000000 -0400
@@ -36,6 +36,9 @@
 type crontab_exec_t;
 corecmd_executable_file(crontab_exec_t)
 
+type crontab_tmp_t;
+files_tmp_file(crontab_tmp_t)
+
 type system_cron_spool_t, cron_spool_type;
 files_type(system_cron_spool_t)
 
@@ -175,6 +178,7 @@
 	allow crond_t crond_tmp_t:dir create_dir_perms;
 	allow crond_t crond_tmp_t:file create_file_perms;
 	files_tmp_filetrans(crond_t, crond_tmp_t, { file dir })
+	files_pid_filetrans(system_crond_t,crond_var_run_t,file)
 ')
 
 tunable_policy(`fcron_crond', `
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cyrus.te serefpolicy-2.3.11/policy/modules/services/cyrus.te
--- nsaserefpolicy/policy/modules/services/cyrus.te	2006-08-29 09:00:28.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/cyrus.te	2006-09-01 15:41:44.000000000 -0400
@@ -93,6 +93,7 @@
 files_list_var_lib(cyrus_t)
 files_read_etc_files(cyrus_t)
 files_read_etc_runtime_files(cyrus_t)
+files_read_usr_files(cyrus_t)
 
 init_use_fds(cyrus_t)
 init_use_script_ptys(cyrus_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dbus.if serefpolicy-2.3.11/policy/modules/services/dbus.if
--- nsaserefpolicy/policy/modules/services/dbus.if	2006-08-29 09:00:28.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/dbus.if	2006-09-01 15:41:44.000000000 -0400
@@ -123,6 +123,7 @@
 	selinux_compute_relabel_context($1_dbusd_t)
 	selinux_compute_user_contexts($1_dbusd_t)
 
+	corecmd_bin_domtrans($1_dbusd_t, $1_t)
 	corecmd_list_bin($1_dbusd_t)
 	corecmd_read_bin_symlinks($1_dbusd_t)
 	corecmd_read_bin_files($1_dbusd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dbus.te serefpolicy-2.3.11/policy/modules/services/dbus.te
--- nsaserefpolicy/policy/modules/services/dbus.te	2006-08-29 09:00:28.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/dbus.te	2006-09-01 15:41:44.000000000 -0400
@@ -38,7 +38,6 @@
 allow system_dbusd_t self:unix_stream_socket { connectto create_stream_socket_perms connectto };
 allow system_dbusd_t self:unix_dgram_socket create_socket_perms;
 allow system_dbusd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
-allow system_dbusd_t self:netlink_route_socket r_netlink_socket_perms;
 # Receive notifications of policy reloads and enforcing status changes.
 allow system_dbusd_t self:netlink_selinux_socket { create bind read };
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dovecot.te serefpolicy-2.3.11/policy/modules/services/dovecot.te
--- nsaserefpolicy/policy/modules/services/dovecot.te	2006-09-01 14:10:18.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/dovecot.te	2006-09-01 15:41:44.000000000 -0400
@@ -46,8 +46,6 @@
 allow dovecot_t self:tcp_socket create_stream_socket_perms;
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket { create_stream_socket_perms connectto };
-allow dovecot_t self:netlink_route_socket r_netlink_socket_perms;
-
 domain_auto_trans(dovecot_t, dovecot_auth_exec_t, dovecot_auth_t)
 allow dovecot_t dovecot_auth_t:fd use;
 allow dovecot_auth_t dovecot_t:process sigchld;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ftp.te serefpolicy-2.3.11/policy/modules/services/ftp.te
--- nsaserefpolicy/policy/modules/services/ftp.te	2006-08-23 12:14:53.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/ftp.te	2006-09-01 15:41:44.000000000 -0400
@@ -50,7 +50,6 @@
 allow ftpd_t self:unix_stream_socket create_stream_socket_perms;
 allow ftpd_t self:tcp_socket create_stream_socket_perms;
 allow ftpd_t self:udp_socket create_socket_perms;
-allow ftpd_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow ftpd_t ftpd_etc_t:file r_file_perms;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.3.11/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-09-01 14:10:18.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/hal.te	2006-09-01 15:41:44.000000000 -0400
@@ -28,7 +28,6 @@
 allow hald_t self:fifo_file rw_file_perms;
 allow hald_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow hald_t self:unix_dgram_socket create_socket_perms;
-allow hald_t self:netlink_route_socket r_netlink_socket_perms;
 allow hald_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 allow hald_t self:netlink_kobject_uevent_socket create_socket_perms;
 allow hald_t self:tcp_socket create_stream_socket_perms;
@@ -78,6 +77,7 @@
 dev_rw_sysfs(hald_t)
 
 domain_use_interactive_fds(hald_t)
+domain_read_all_domains_state(hald_t)
 
 files_exec_etc_files(hald_t)
 files_read_etc_files(hald_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ldap.te serefpolicy-2.3.11/policy/modules/services/ldap.te
--- nsaserefpolicy/policy/modules/services/ldap.te	2006-08-16 08:46:30.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/ldap.te	2006-09-01 15:41:44.000000000 -0400
@@ -72,7 +72,7 @@
 
 allow slapd_t slapd_var_run_t:file create_file_perms;
 allow slapd_t slapd_var_run_t:dir rw_dir_perms;
-files_pid_filetrans(slapd_t,slapd_var_run_t,file)
+files_pid_filetrans(slapd_t,slapd_var_run_t,{ file sock_file })
 
 kernel_read_system_state(slapd_t)
 kernel_read_kernel_sysctls(slapd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.te serefpolicy-2.3.11/policy/modules/services/networkmanager.te
--- nsaserefpolicy/policy/modules/services/networkmanager.te	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/networkmanager.te	2006-09-01 15:41:44.000000000 -0400
@@ -18,9 +18,9 @@
 # Local policy
 #
 
-allow NetworkManager_t self:capability { kill setgid setuid sys_nice dac_override net_admin net_raw net_bind_service ipc_lock};
+allow NetworkManager_t self:capability { kill setgid setuid sys_nice sys_ptrace dac_override net_admin net_raw net_bind_service ipc_lock};
 dontaudit NetworkManager_t self:capability sys_tty_config;
-allow NetworkManager_t self:process { setcap getsched signal_perms };
+allow NetworkManager_t self:process { ptrace setcap getsched signal_perms };
 allow NetworkManager_t self:fifo_file rw_file_perms;
 allow NetworkManager_t self:unix_dgram_socket { sendto create_socket_perms };
 allow NetworkManager_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ntp.te serefpolicy-2.3.11/policy/modules/services/ntp.te
--- nsaserefpolicy/policy/modules/services/ntp.te	2006-08-23 12:14:54.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/ntp.te	2006-09-01 15:41:44.000000000 -0400
@@ -38,7 +38,6 @@
 allow ntpd_t self:fifo_file { read write getattr };
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
 allow ntpd_t self:unix_stream_socket create_socket_perms;
-allow ntpd_t self:netlink_route_socket r_netlink_socket_perms;
 allow ntpd_t self:tcp_socket create_stream_socket_perms;
 allow ntpd_t self:udp_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/oddjob.fc serefpolicy-2.3.11/policy/modules/services/oddjob.fc
--- nsaserefpolicy/policy/modules/services/oddjob.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/oddjob.fc	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,8 @@
+# oddjob executable will have:
+# label: system_u:object_r:oddjob_exec_t
+# MLS sensitivity: s0
+# MCS categories: <none>
+
+/usr/sbin/oddjobd		--	gen_context(system_u:object_r:oddjob_exec_t,s0)
+/var/run/oddjobd.pid			gen_context(system_u:object_r:oddjob_var_run_t,s0)
+/usr/lib/oddjobd			gen_context(system_u:object_r:oddjob_var_lib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/oddjob.if serefpolicy-2.3.11/policy/modules/services/oddjob.if
--- nsaserefpolicy/policy/modules/services/oddjob.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/oddjob.if	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,76 @@
+## <summary>policy for oddjob</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run oddjob.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`oddjob_domtrans',`
+	gen_require(`
+		type oddjob_t, oddjob_exec_t;
+	')
+
+	domain_auto_trans($1,oddjob_exec_t,oddjob_t)
+
+	allow $1 oddjob_t:fd use;
+	allow oddjob_t $1:fd use;
+	allow oddjob_t $1:fifo_file rw_file_perms;
+	allow oddjob_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Make the specified program domain accessable
+##	from the oddjob.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process to transition to.
+##	</summary>
+## </param>
+## <param name="entrypoint">
+##	<summary>
+##	The type of the file used as an entrypoint to this domain.
+##	</summary>
+## </param>
+#
+interface(`oddjob_system_entry',`
+	gen_require(`
+		type oddjob_t;
+	')
+
+	domain_auto_trans(oddjob_t, $2, $1)
+
+	allow oddjob_t $1:fd use;
+	allow $1 oddjob_t:fd use;
+	allow $1 oddjob_t:fifo_file rw_file_perms;
+	allow $1 oddjob_t:process sigchld;
+
+')
+
+
+########################################
+## <summary>
+##	Send and receive messages from
+##	oddjob over dbus.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`oddjob_dbus_chat',`
+	gen_require(`
+		type oddjob_t;
+		class dbus send_msg;
+	')
+
+	allow $1 oddjob_t:dbus send_msg;
+	allow oddjob_t $1:dbus send_msg;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/oddjob_mkhomedir.fc serefpolicy-2.3.11/policy/modules/services/oddjob_mkhomedir.fc
--- nsaserefpolicy/policy/modules/services/oddjob_mkhomedir.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/oddjob_mkhomedir.fc	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,6 @@
+# oddjob_mkhomedir executable will have:
+# label: system_u:object_r:oddjob_mkhomedir_exec_t
+# MLS sensitivity: s0
+# MCS categories: <none>
+
+/usr/lib/oddjob/mkhomedir		--	gen_context(system_u:object_r:oddjob_mkhomedir_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/oddjob_mkhomedir.if serefpolicy-2.3.11/policy/modules/services/oddjob_mkhomedir.if
--- nsaserefpolicy/policy/modules/services/oddjob_mkhomedir.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/oddjob_mkhomedir.if	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,24 @@
+## <summary>policy for oddjob_mkhomedir</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run oddjob_mkhomedir.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`oddjob_mkhomedir_domtrans',`
+	gen_require(`
+		type oddjob_mkhomedir_t, oddjob_mkhomedir_exec_t;
+	')
+
+	domain_auto_trans($1,oddjob_mkhomedir_exec_t,oddjob_mkhomedir_t)
+
+	allow $1 oddjob_mkhomedir_t:fd use;
+	allow oddjob_mkhomedir_t $1:fd use;
+	allow oddjob_mkhomedir_t $1:fifo_file rw_file_perms;
+	allow oddjob_mkhomedir_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/oddjob_mkhomedir.te serefpolicy-2.3.11/policy/modules/services/oddjob_mkhomedir.te
--- nsaserefpolicy/policy/modules/services/oddjob_mkhomedir.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/oddjob_mkhomedir.te	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,29 @@
+policy_module(oddjob_mkhomedir,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type oddjob_mkhomedir_t;
+type oddjob_mkhomedir_exec_t;
+domain_type(oddjob_mkhomedir_t)
+init_daemon_domain(oddjob_mkhomedir_t, oddjob_mkhomedir_exec_t)
+
+########################################
+#
+# oddjob_mkhomedir local policy
+#
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(oddjob_mkhomedir_t)
+libs_use_ld_so(oddjob_mkhomedir_t)
+libs_use_shared_libs(oddjob_mkhomedir_t)
+miscfiles_read_localization(oddjob_mkhomedir_t)
+## internal communication is often done using fifo and unix sockets.
+allow oddjob_mkhomedir_t self:fifo_file { read write };
+allow oddjob_mkhomedir_t self:unix_stream_socket create_stream_socket_perms;
+
+oddjob_system_entry(oddjob_mkhomedir_t, oddjob_mkhomedir_exec_t)
+domain_auto_trans(unconfined_t,oddjob_mkhomedir_exec_t,oddjob_mkhomedir_t)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/oddjob.te serefpolicy-2.3.11/policy/modules/services/oddjob.te
--- nsaserefpolicy/policy/modules/services/oddjob.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/oddjob.te	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,73 @@
+policy_module(oddjob,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type oddjob_t;
+type oddjob_exec_t;
+domain_type(oddjob_t)
+init_daemon_domain(oddjob_t, oddjob_exec_t)
+
+# pid files
+type oddjob_var_run_t;
+files_pid_file(oddjob_var_run_t)
+
+# var/lib files
+type oddjob_var_lib_t;
+files_type(oddjob_var_lib_t)
+
+########################################
+#
+# oddjob local policy
+#
+# Check in /etc/selinux/refpolicy/include for macros to use instead of allow rules.
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(oddjob_t)
+libs_use_ld_so(oddjob_t)
+libs_use_shared_libs(oddjob_t)
+miscfiles_read_localization(oddjob_t)
+## internal communication is often done using fifo and unix sockets.
+allow oddjob_t self:fifo_file { read write };
+allow oddjob_t self:unix_stream_socket create_stream_socket_perms;
+
+# pid file
+allow oddjob_t oddjob_var_run_t:file manage_file_perms;
+allow oddjob_t oddjob_var_run_t:sock_file manage_file_perms;
+allow oddjob_t oddjob_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(oddjob_t,oddjob_var_run_t, { file sock_file })
+
+# var/lib files for oddjob
+allow oddjob_t oddjob_var_lib_t:file create_file_perms;
+allow oddjob_t oddjob_var_lib_t:sock_file create_file_perms;
+allow oddjob_t oddjob_var_lib_t:dir create_dir_perms;
+files_var_lib_filetrans(oddjob_t,oddjob_var_lib_t, { file dir sock_file })
+
+init_dontaudit_use_fds(oddjob_t)
+allow oddjob_t self:capability { audit_write setgid } ;
+allow oddjob_t self:process setexec;
+
+locallogin_dontaudit_use_fds(oddjob_t)
+
+optional_policy(`
+	dbus_system_bus_client_template(oddjob,oddjob_t)
+	dbus_send_system_bus(oddjob_t)
+	dbus_connect_system_bus(oddjob_t)
+')
+
+corecmd_search_sbin(oddjob_t)
+corecmd_exec_shell(oddjob_t)
+
+selinux_compute_create_context(oddjob_t)
+
+kernel_read_system_state(oddjob_t)
+
+unconfined_domtrans(oddjob_t)
+
+ifdef(`targeted_policy', `
+	term_dontaudit_use_generic_ptys(oddjob_t)
+	term_dontaudit_use_unallocated_ttys(oddjob_t)
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.if serefpolicy-2.3.11/policy/modules/services/pegasus.if
--- nsaserefpolicy/policy/modules/services/pegasus.if	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/pegasus.if	2006-09-01 15:41:44.000000000 -0400
@@ -1 +1,32 @@
 ## <summary>The Open Group Pegasus CIM/WBEM Server.</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run pegasus.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`pegasus_domtrans',`
+	gen_require(`
+		type pegasus_t, pegasus_exec_t;
+	')
+
+	ifdef(`targeted_policy',`
+		if(pegasus_disable_trans) {
+			can_exec($1,pegasus_exec_t)
+		} else {
+			domain_auto_trans($1,pegasus_exec_t,pegasus_t)
+		}
+	', `
+		domain_auto_trans($1,pegasus_exec_t,pegasus_t)
+	')
+
+	allow $1 pegasus_t:fd use;
+	allow pegasus_t $1:fd use;
+	allow pegasus_t $1:fifo_file rw_file_perms;
+	allow pegasus_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.te serefpolicy-2.3.11/policy/modules/services/pegasus.te
--- nsaserefpolicy/policy/modules/services/pegasus.te	2006-08-23 12:14:54.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/pegasus.te	2006-09-01 15:41:44.000000000 -0400
@@ -100,13 +100,12 @@
 
 auth_use_nsswitch(pegasus_t)
 auth_domtrans_chk_passwd(pegasus_t)
+auth_read_shadow(pegasus_t)
 
 domain_use_interactive_fds(pegasus_t)
 domain_read_all_domains_state(pegasus_t)
 
-files_read_etc_files(pegasus_t)
-files_list_var_lib(pegasus_t)
-files_read_var_lib_files(pegasus_t)
+files_read_all_files(pegasus_t)
 files_read_var_lib_symlinks(pegasus_t)
 
 hostname_exec(pegasus_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-2.3.11/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2006-08-29 09:00:28.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/postfix.te	2006-09-01 15:41:44.000000000 -0400
@@ -171,6 +171,11 @@
 mta_rw_aliases(postfix_master_t)
 mta_read_sendmail_bin(postfix_master_t)
 
+ifdef(`targeted_policy',`
+	term_dontaudit_use_unallocated_ttys(postfix_master_t)
+	term_dontaudit_use_generic_ptys(postfix_master_t)
+')
+
 optional_policy(`
 	cyrus_stream_connect(postfix_master_t)
 ')
@@ -361,6 +366,7 @@
 sysnet_read_config(postfix_map_t)
 
 ifdef(`targeted_policy',`
+	term_dontaudit_use_unallocated_ttys(postfix_map_t)
 	term_dontaudit_use_generic_ptys(postfix_map_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ricci.fc serefpolicy-2.3.11/policy/modules/services/ricci.fc
--- nsaserefpolicy/policy/modules/services/ricci.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/ricci.fc	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,20 @@
+# ricci executable will have:
+# label: system_u:object_r:ricci_exec_t
+# MLS sensitivity: s0
+# MCS categories: <none>
+
+/usr/sbin/ricci		--	gen_context(system_u:object_r:ricci_exec_t,s0)
+/var/lib/ricci(/.*)?		gen_context(system_u:object_r:ricci_var_lib_t,s0)
+
+/usr/sbin/ricci-modclusterd	--	gen_context(system_u:object_r:ricci_modclusterd_exec_t,s0)
+/var/run/ricci-modclusterd.pid  --	gen_context(system_u:object_r:ricci_modcluster_var_run_t,s0)
+/var/log/clumond.log 		--	gen_context(system_u:object_r:ricci_modcluster_var_log_t,s0)
+
+/usr/sbin/ricci-modlog		--	gen_context(system_u:object_r:ricci_modlog_exec_t,s0)
+/usr/sbin/ricci-modlog_ro	--	gen_context(system_u:object_r:ricci_modlog_ro_exec_t,s0)
+
+/usr/sbin/ricci-modrpm		--	gen_context(system_u:object_r:ricci_modrpm_exec_t,s0)
+/usr/sbin/ricci-modcluster	--	gen_context(system_u:object_r:ricci_modcluster_exec_t,s0)
+/usr/sbin/ricci-modservice	--	gen_context(system_u:object_r:ricci_modservice_exec_t,s0)
+/usr/sbin/ricci-modstorage	--	gen_context(system_u:object_r:ricci_modstorage_exec_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ricci.if serefpolicy-2.3.11/policy/modules/services/ricci.if
--- nsaserefpolicy/policy/modules/services/ricci.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/ricci.if	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,184 @@
+## <summary>policy for ricci</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run ricci.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`ricci_domtrans',`
+	gen_require(`
+		type ricci_t, ricci_exec_t;
+	')
+
+	domain_auto_trans($1,ricci_exec_t,ricci_t)
+
+	allow $1 ricci_t:fd use;
+	allow ricci_t $1:fd use;
+	allow ricci_t $1:fifo_file rw_file_perms;
+	allow ricci_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run ricci_modlog.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`ricci_modlog_domtrans',`
+	gen_require(`
+		type ricci_modlog_t, ricci_modlog_exec_t;
+	')
+
+	domain_auto_trans($1,ricci_modlog_exec_t,ricci_modlog_t)
+
+	allow $1 ricci_modlog_t:fd use;
+	allow ricci_modlog_t $1:fd use;
+	allow ricci_modlog_t $1:fifo_file rw_file_perms;
+	allow ricci_modlog_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run ricci_modlog_ro.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`ricci_modlog_ro_domtrans',`
+	gen_require(`
+		type ricci_modlog_ro_t, ricci_modlog_ro_exec_t;
+	')
+
+	domain_auto_trans($1,ricci_modlog_ro_exec_t,ricci_modlog_ro_t)
+
+	allow $1 ricci_modlog_ro_t:fd use;
+	allow ricci_modlog_ro_t $1:fd use;
+	allow ricci_modlog_ro_t $1:fifo_file rw_file_perms;
+	allow ricci_modlog_ro_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run ricci_modrpm.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`ricci_modrpm_domtrans',`
+	gen_require(`
+		type ricci_modrpm_t, ricci_modrpm_exec_t;
+	')
+
+	domain_auto_trans($1,ricci_modrpm_exec_t,ricci_modrpm_t)
+
+	allow $1 ricci_modrpm_t:fd use;
+	allow ricci_modrpm_t $1:fd use;
+	allow ricci_modrpm_t $1:fifo_file rw_file_perms;
+	allow ricci_modrpm_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run ricci_modservice.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`ricci_modservice_domtrans',`
+	gen_require(`
+		type ricci_modservice_t, ricci_modservice_exec_t;
+	')
+
+	domain_auto_trans($1,ricci_modservice_exec_t,ricci_modservice_t)
+
+	allow $1 ricci_modservice_t:fd use;
+	allow ricci_modservice_t $1:fd use;
+	allow ricci_modservice_t $1:fifo_file rw_file_perms;
+	allow ricci_modservice_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run ricci_modcluster.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`ricci_modcluster_domtrans',`
+	gen_require(`
+		type ricci_modcluster_t, ricci_modcluster_exec_t;
+	')
+
+	domain_auto_trans($1,ricci_modcluster_exec_t,ricci_modcluster_t)
+
+	allow $1 ricci_modcluster_t:fd use;
+	allow ricci_modcluster_t $1:fd use;
+	allow ricci_modcluster_t $1:fifo_file rw_file_perms;
+	allow ricci_modcluster_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##	Execute a domain transition to run ricci_modstorage.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`ricci_modstorage_domtrans',`
+	gen_require(`
+		type ricci_modstorage_t, ricci_modstorage_exec_t;
+	')
+
+	domain_auto_trans($1,ricci_modstorage_exec_t,ricci_modstorage_t)
+
+	allow $1 ricci_modstorage_t:fd use;
+	allow ricci_modstorage_t $1:fd use;
+	allow ricci_modstorage_t $1:fifo_file rw_file_perms;
+	allow ricci_modstorage_t $1:process sigchld;
+')
+
+
+
+########################################
+## <summary>
+##	Connect to ricci_modclusterd over an unix stream socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ricci_modclusterd_stream_connect',`
+	gen_require(`
+		type ricci_modclusterd_t, ricci_modcluster_var_run_t;
+	')
+
+	files_search_pids($1)
+	allow $1 ricci_modcluster_var_run_t:sock_file write;
+	allow $1 ricci_modclusterd_t:unix_stream_socket connectto;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ricci.te serefpolicy-2.3.11/policy/modules/services/ricci.te
--- nsaserefpolicy/policy/modules/services/ricci.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.11/policy/modules/services/ricci.te	2006-09-01 15:41:44.000000000 -0400
@@ -0,0 +1,386 @@
+policy_module(ricci,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type ricci_t;
+type ricci_exec_t;
+domain_type(ricci_t)
+init_daemon_domain(ricci_t, ricci_exec_t)
+
+# pid files
+type ricci_var_run_t;
+files_pid_file(ricci_var_run_t)
+
+# tmp files
+type ricci_tmp_t;
+files_tmp_file(ricci_tmp_t)
+
+# var/lib files
+type ricci_var_lib_t;
+files_type(ricci_var_lib_t)
+
+# log files
+type ricci_var_log_t;
+logging_log_file(ricci_var_log_t)
+
+type ricci_modclusterd_t;
+type ricci_modclusterd_exec_t;
+domain_type(ricci_modclusterd_t)
+init_daemon_domain(ricci_modclusterd_t, ricci_modclusterd_exec_t)
+
+type ricci_modlog_t;
+type ricci_modlog_exec_t;
+domain_type(ricci_modlog_t)
+domain_entry_file(ricci_modlog_t, ricci_modlog_exec_t)
+role system_r types ricci_modlog_t;
+
+type ricci_modlog_ro_t;
+type ricci_modlog_ro_exec_t;
+domain_type(ricci_modlog_ro_t)
+domain_entry_file(ricci_modlog_ro_t, ricci_modlog_ro_exec_t)
+role system_r types ricci_modlog_ro_t;
+
+type ricci_modrpm_t;
+type ricci_modrpm_exec_t;
+domain_type(ricci_modrpm_t)
+domain_entry_file(ricci_modrpm_t, ricci_modrpm_exec_t)
+role system_r types ricci_modrpm_t;
+
+type ricci_modservice_t;
+type ricci_modservice_exec_t;
+domain_type(ricci_modservice_t)
+domain_entry_file(ricci_modservice_t, ricci_modservice_exec_t)
+role system_r types ricci_modservice_t;
+
+type ricci_modstorage_t;
+type ricci_modstorage_exec_t;
+domain_type(ricci_modstorage_t)
+domain_entry_file(ricci_modstorage_t, ricci_modstorage_exec_t)
+role system_r types ricci_modstorage_t;
+
+type ricci_modcluster_t;
+type ricci_modcluster_exec_t;
+domain_type(ricci_modcluster_t)
+domain_entry_file(ricci_modcluster_t, ricci_modcluster_exec_t)
+role system_r types ricci_modcluster_t;
+
+# pid files
+type ricci_modcluster_var_run_t;
+files_pid_file(ricci_modcluster_var_run_t)
+
+# var/lib files
+type ricci_modcluster_var_lib_t;
+files_type(ricci_modcluster_var_lib_t)
+
+# log files
+type ricci_modcluster_var_log_t;
+logging_log_file(ricci_modcluster_var_log_t)
+
+########################################
+#
+# ricci local policy
+#
+allow ricci_t self:capability { setuid sys_nice };
+allow ricci_t self:process setsched;
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(ricci_t)
+files_read_etc_runtime_files(ricci_t)
+
+libs_use_ld_so(ricci_t)
+libs_use_shared_libs(ricci_t)
+miscfiles_read_localization(ricci_t)
+## internal communication is often done using fifo and unix sockets.
+allow ricci_t self:fifo_file { read write };
+allow ricci_t self:unix_stream_socket create_stream_socket_perms;
+
+# pid file
+allow ricci_t ricci_var_run_t:file manage_file_perms;
+allow ricci_t ricci_var_run_t:sock_file manage_file_perms;
+allow ricci_t ricci_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(ricci_t,ricci_var_run_t, { file sock_file })
+
+# tmp file
+allow ricci_t ricci_tmp_t:dir create_dir_perms;
+allow ricci_t ricci_tmp_t:file create_file_perms;
+files_tmp_filetrans(ricci_t, ricci_tmp_t, { file dir })
+
+# log files
+allow ricci_t ricci_var_log_t:file create_file_perms;
+allow ricci_t ricci_var_log_t:sock_file create_file_perms;
+allow ricci_t ricci_var_log_t:dir { rw_dir_perms setattr };
+logging_log_filetrans(ricci_t,ricci_var_log_t,{ sock_file file dir })
+
+init_dontaudit_use_fds(ricci_t)
+
+kernel_read_kernel_sysctls(ricci_t)
+
+optional_policy(`
+	dbus_system_bus_client_template(ricci,ricci_t)
+	dbus_send_system_bus(ricci_t)
+	oddjob_dbus_chat(ricci_t)
+')
+
+# var/lib files for ricci
+allow ricci_t ricci_var_lib_t:file create_file_perms;
+allow ricci_t ricci_var_lib_t:sock_file create_file_perms;
+allow ricci_t ricci_var_lib_t:dir create_dir_perms;
+files_var_lib_filetrans(ricci_t,ricci_var_lib_t, { file dir sock_file })
+
+auth_domtrans_chk_passwd(ricci_t)
+
+ifdef(`targeted_policy', `
+	term_dontaudit_use_generic_ptys(ricci_t)
+	term_dontaudit_use_unallocated_ttys(ricci_t)
+')
+
+locallogin_dontaudit_use_fds(ricci_t)
+
+## Networking basics (adjust to your needs!)
+sysnet_dns_name_resolve(ricci_t)
+corenet_tcp_sendrecv_all_if(ricci_t)
+corenet_tcp_sendrecv_all_nodes(ricci_t)
+corenet_tcp_sendrecv_all_ports(ricci_t)
+corenet_non_ipsec_sendrecv(ricci_t)
+corenet_tcp_connect_http_port(ricci_t)
+#corenet_tcp_connect_all_ports(ricci_t)
+## if it is a network daemon, consider these:
+#corenet_tcp_bind_all_ports(ricci_t)
+#corenet_tcp_bind_all_nodes(ricci_t)
+allow ricci_t self:tcp_socket { listen accept };
+
+# ricci wants to bind to 11111
+corenet_udp_bind_ricci_port(ricci_t)
+corenet_tcp_bind_ricci_port(ricci_t)
+corenet_tcp_bind_inaddr_any_node(ricci_t)
+
+corecmd_exec_sbin(ricci_t)
+
+dev_read_urand(ricci_t)
+
+unconfined_use_fds(ricci_t)
+
+optional_policy(`
+	ccs_read_config(ricci_t)
+')
+
+########################################
+#
+# ricci_modclusterd local policy
+#
+allow ricci_modclusterd_t self:capability sys_nice;
+allow ricci_modclusterd_t self:process { signal sigkill setsched };
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(ricci_modclusterd_t)
+libs_use_ld_so(ricci_modclusterd_t)
+libs_use_shared_libs(ricci_modclusterd_t)
+miscfiles_read_localization(ricci_modclusterd_t)
+## internal communication is often done using fifo and unix sockets.
+allow ricci_modclusterd_t self:fifo_file rw_file_perms;
+allow ricci_modclusterd_t self:unix_stream_socket create_stream_socket_perms;
+allow ricci_modclusterd_t self:tcp_socket create_stream_socket_perms;
+allow ricci_modclusterd_t self:netlink_route_socket r_netlink_socket_perms;
+
+corenet_tcp_connect_ricci_modcluster_port(ricci_modclusterd_t)
+corenet_tcp_bind_ricci_modcluster_port(ricci_modclusterd_t)
+
+corenet_tcp_sendrecv_all_ports(ricci_modclusterd_t)
+corenet_tcp_bind_inaddr_any_node(ricci_modclusterd_t)
+corenet_tcp_bind_all_nodes(ricci_modclusterd_t)
+allow ricci_modclusterd_t self:tcp_socket create_socket_perms;
+allow ricci_modclusterd_t self:socket create_socket_perms;
+files_read_etc_runtime_files(ricci_modclusterd_t)
+
+corecmd_exec_bin(ricci_modclusterd_t)
+corecmd_exec_sbin(ricci_modclusterd_t)
+
+# pid file
+allow ricci_modclusterd_t ricci_modcluster_var_run_t:file manage_file_perms;
+allow ricci_modclusterd_t ricci_modcluster_var_run_t:sock_file manage_file_perms;
+allow ricci_modclusterd_t ricci_modcluster_var_run_t:dir rw_dir_perms;
+files_pid_filetrans(ricci_modclusterd_t,ricci_modcluster_var_run_t, { file sock_file })
+
+# log files
+allow ricci_modclusterd_t ricci_modcluster_var_log_t:file create_file_perms;
+allow ricci_modclusterd_t ricci_modcluster_var_log_t:sock_file create_file_perms;
+allow ricci_modclusterd_t ricci_modcluster_var_log_t:dir { rw_dir_perms setattr };
+logging_log_filetrans(ricci_modclusterd_t,ricci_modcluster_var_log_t,{ sock_file file dir })
+
+init_dontaudit_use_fds(ricci_modclusterd_t)
+
+ifdef(`targeted_policy', `
+	term_dontaudit_use_generic_ptys(ricci_modclusterd_t)
+	term_dontaudit_use_unallocated_ttys(ricci_modclusterd_t)
+')
+
+locallogin_dontaudit_use_fds(ricci_modclusterd_t)
+
+fs_getattr_xattr_fs(ricci_modclusterd_t)
+
+kernel_read_kernel_sysctls(ricci_modclusterd_t)
+kernel_read_system_state(ricci_modclusterd_t)
+
+sysnet_domtrans_ifconfig(ricci_modclusterd_t)
+sysnet_dns_name_resolve(ricci_modclusterd_t)
+
+unconfined_use_fds(ricci_modclusterd_t)
+
+optional_policy(`
+	ccs_stream_connect(ricci_modclusterd_t)
+	ccs_read_config(ricci_modclusterd_t)
+')
+
+########################################
+#
+# ricci_modlog local policy
+#
+
+oddjob_system_entry(ricci_modlog_t, ricci_modlog_exec_t)
+domain_auto_trans(ricci_t,ricci_modlog_exec_t,ricci_modlog_t)
+
+########################################
+#
+# ricci_modlog_ro local policy
+#
+
+oddjob_system_entry(ricci_modlog_ro_t, ricci_modlog_ro_exec_t)
+domain_auto_trans(ricci_t,ricci_modlog_ro_exec_t,ricci_modlog_ro_t)
+files_read_etc_files(ricci_modlog_t)
+
+libs_use_ld_so(ricci_modlog_t)
+libs_use_shared_libs(ricci_modlog_t)
+miscfiles_read_localization(ricci_modlog_t)
+
+nscd_dontaudit_search_pid(ricci_modlog_t)
+
+allow ricci_modlog_t self:capability sys_nice;
+allow ricci_modlog_t self:process setsched;
+
+corecmd_exec_bin(ricci_modlog_t)
+corecmd_exec_sbin(ricci_modlog_t)
+
+kernel_read_kernel_sysctls(ricci_modlog_t)
+kernel_read_system_state(ricci_modlog_t)
+
+files_search_usr(ricci_modlog_t)
+logging_read_generic_logs(ricci_modlog_t)
+
+domain_read_all_domains_state(ricci_modlog_t)
+
+########################################
+#
+# ricci_modrpm local policy
+#
+
+oddjob_system_entry(ricci_modrpm_t, ricci_modrpm_exec_t)
+domain_auto_trans(ricci_t,ricci_modrpm_exec_t,ricci_modrpm_t)
+
+########################################
+#
+# ricci_modservice local policy
+#
+
+oddjob_system_entry(ricci_modservice_t, ricci_modservice_exec_t)
+domain_auto_trans(ricci_t,ricci_modservice_exec_t,ricci_modservice_t)
+
+consoletype_exec(ricci_modservice_t)
+
+files_read_etc_runtime_files(ricci_modservice_t)
+
+init_domtrans_script(ricci_modservice_t)
+
+libs_use_ld_so(ricci_modservice_t)
+libs_use_shared_libs(ricci_modservice_t)
+miscfiles_read_localization(ricci_modservice_t)
+
+nscd_dontaudit_search_pid(ricci_modservice_t)
+
+allow ricci_modservice_t self:capability { dac_override sys_nice };
+allow ricci_modservice_t self:fifo_file { getattr read write };
+allow ricci_modservice_t self:process setsched;
+
+corecmd_exec_sbin(ricci_modservice_t)
+corecmd_exec_bin(ricci_modservice_t)
+corecmd_exec_shell(ricci_modservice_t)
+
+kernel_read_kernel_sysctls(ricci_modservice_t)
+kernel_read_system_state(ricci_modservice_t)
+
+files_search_usr(ricci_modservice_t)
+
+optional_policy(`
+	ccs_read_config(ricci_modservice_t)
+')
+
+########################################
+#
+# ricci_modstorage local policy
+#
+
+oddjob_system_entry(ricci_modstorage_t, ricci_modstorage_exec_t)
+domain_auto_trans(ricci_t,ricci_modstorage_exec_t,ricci_modstorage_t)
+
+allow ricci_modstorage_t self:process setsched;
+allow ricci_modstorage_t self:capability { mknod sys_nice };
+allow ricci_modstorage_t self:fifo_file rw_file_perms;
+
+corecmd_exec_bin(ricci_modstorage_t)
+corecmd_exec_sbin(ricci_modstorage_t)
+
+files_read_etc_files(ricci_modstorage_t)
+files_read_etc_runtime_files(ricci_modstorage_t)
+
+fstools_domtrans(ricci_modstorage_t)
+
+libs_use_ld_so(ricci_modstorage_t)
+libs_use_shared_libs(ricci_modstorage_t)
+miscfiles_read_localization(ricci_modstorage_t)
+
+lvm_domtrans(ricci_modstorage_t)
+
+kernel_read_kernel_sysctls(ricci_modstorage_t)
+dev_read_sysfs(ricci_modstorage_t)
+dev_read_urand(ricci_modstorage_t)
+
+files_read_usr_files(ricci_modstorage_t)
+
+########################################
+#
+# ricci_modcluster local policy
+#
+
+oddjob_system_entry(ricci_modcluster_t, ricci_modcluster_exec_t)
+domain_auto_trans(ricci_t,ricci_modcluster_exec_t,ricci_modcluster_t)
+
+files_read_etc_runtime_files(ricci_modcluster_t)
+files_read_etc_files(ricci_modcluster_t)
+
+libs_use_ld_so(ricci_modcluster_t)
+libs_use_shared_libs(ricci_modcluster_t)
+
+miscfiles_read_localization(ricci_modcluster_t)
+
+nscd_socket_use(ricci_modcluster_t)
+
+allow ricci_modcluster_t self:capability sys_nice;
+allow ricci_modcluster_t self:process setsched;
+
+corecmd_exec_sbin(ricci_modcluster_t)
+corecmd_exec_bin(ricci_modcluster_t)
+
+kernel_read_kernel_sysctls(ricci_modcluster_t)
+kernel_read_system_state(ricci_modcluster_t)
+
+files_search_usr(ricci_modcluster_t)
+
+ricci_modclusterd_stream_connect(ricci_modcluster_t)
+
+optional_policy(`
+	ccs_read_config(ricci_modcluster_t)
+')
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/stunnel.te serefpolicy-2.3.11/policy/modules/services/stunnel.te
--- nsaserefpolicy/policy/modules/services/stunnel.te	2006-08-02 10:34:07.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/stunnel.te	2006-09-01 15:41:44.000000000 -0400
@@ -38,6 +38,7 @@
 allow stunnel_t self:fifo_file rw_file_perms;
 allow stunnel_t self:tcp_socket create_stream_socket_perms;
 allow stunnel_t self:udp_socket create_socket_perms;
+allow stunnel_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow stunnel_t stunnel_etc_t:dir { getattr read search };
 allow stunnel_t stunnel_etc_t:file { read getattr };
@@ -63,7 +64,7 @@
 corenet_tcp_sendrecv_all_ports(stunnel_t)
 corenet_udp_sendrecv_all_ports(stunnel_t)
 corenet_tcp_bind_all_nodes(stunnel_t)
-#corenet_tcp_bind_stunnel_port(stunnel_t)
+corenet_tcp_connect_all_ports(stunnel_t)
 
 fs_getattr_all_fs(stunnel_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.3.11/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-09-01 14:10:18.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/services/xserver.if	2006-09-01 15:41:44.000000000 -0400
@@ -1133,3 +1133,25 @@
 	allow $1 xdm_xserver_tmp_t:sock_file write;
 	allow $1 xdm_xserver_t:unix_stream_socket connectto;
 ')
+
+
+########################################
+## <summary>
+##	Create a named socket in a ice
+##	temporary directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`xserver_create_ice_tmp_sockets',`
+	gen_require(`
+		type ice_tmp_t;
+	')
+
+	files_search_tmp($1)
+	allow $1 ice_tmp_t:dir ra_dir_perms;
+	allow $1 ice_tmp_t:sock_file create_file_perms;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.3.11/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2006-08-29 09:00:29.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/system/hostname.te	2006-09-01 15:41:44.000000000 -0400
@@ -8,7 +8,10 @@
 
 type hostname_t;
 type hostname_exec_t;
-init_system_domain(hostname_t,hostname_exec_t)
+
+#dont transition from initrc
+domain_type(hostname_t)
+domain_entry_file(hostname_t,hostname_exec_t)
 role system_r types hostname_t;
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.3.11/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-08-28 16:22:32.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/system/init.te	2006-09-01 15:41:44.000000000 -0400
@@ -361,7 +361,8 @@
 logging_append_all_logs(initrc_t)
 logging_read_audit_config(initrc_t)
 
-miscfiles_read_localization(initrc_t)
+miscfiles_rw_localization(initrc_t)
+
 # slapd needs to read cert files from its initscript
 miscfiles_read_certs(initrc_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.fc serefpolicy-2.3.11/policy/modules/system/selinuxutil.fc
--- nsaserefpolicy/policy/modules/system/selinuxutil.fc	2006-08-02 10:34:08.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/system/selinuxutil.fc	2006-09-01 15:41:44.000000000 -0400
@@ -36,6 +36,7 @@
 /usr/sbin/restorecond		--	gen_context(system_u:object_r:restorecond_exec_t,s0)
 /usr/sbin/run_init		--	gen_context(system_u:object_r:run_init_exec_t,s0)
 /usr/sbin/setfiles.*		--	gen_context(system_u:object_r:setfiles_exec_t,s0)
+/sbin/setfiles.*		--	gen_context(system_u:object_r:setfiles_exec_t,s0)
 /usr/sbin/setsebool		--	gen_context(system_u:object_r:semanage_exec_t,s0)
 /usr/sbin/semanage		--	gen_context(system_u:object_r:semanage_exec_t,s0)
 /usr/sbin/semodule		--	gen_context(system_u:object_r:semanage_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.3.11/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-09-01 14:10:18.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/system/selinuxutil.te	2006-09-01 15:41:44.000000000 -0400
@@ -450,6 +450,7 @@
 selinux_compute_user_contexts(restorecond_t)
 
 term_dontaudit_use_generic_ptys(restorecond_t)
+term_dontaudit_use_unallocated_ttys(restorecond_t)
 
 auth_relabel_all_files_except_shadow(restorecond_t )
 auth_read_all_files_except_shadow(restorecond_t)
@@ -621,6 +622,12 @@
 	# Handle pp files created in homedir and /tmp
 	files_read_generic_tmp_files(semanage_t)
 	userdom_read_generic_user_home_content_files(semanage_t)
+',`
+	ifdef(`enable_mls',`
+		userdom_read_user_tmp_files(secadm, semanage_t)
+	',`
+		userdom_read_user_tmp_files(sysadm, semanage_t)
+	')
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.3.11/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-08-16 08:46:31.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/system/userdomain.if	2006-09-01 15:41:44.000000000 -0400
@@ -8,11 +8,10 @@
 ## <desc>
 ##	<p>
 ##	This template creates a user domain, types, and
-##	rules for the user's tty, pty, home directories,
-##	tmp, and tmpfs files.
+##	rules for the user's tty, pty, tmp, and tmpfs files.
 ##	</p>
 ##	<p>
-##	This generally should not be used, rather the
+##	This should only be used for new non login user roles, rather the
 ##	unpriv_user_template or admin_user_template should
 ##	be used.
 ##	</p>
@@ -25,7 +24,9 @@
 ## </param>
 #
 template(`base_user_template',`
-
+	gen_require(`
+		attribute userdomain, unpriv_userdomain;
+	')
 	attribute $1_file_type;
 
 	type $1_t, userdomain;
@@ -42,44 +43,17 @@
 	term_user_pty($1_t,$1_devpts_t)
 	files_type($1_devpts_t)
 
-	# type for contents of home directory
-	type $1_home_t, $1_file_type, home_type;
-	files_type($1_home_t)
-	files_associate_tmp($1_home_t)
-	fs_associate_tmpfs($1_home_t)
-
-	# type of home directory
-	type $1_home_dir_t, home_dir_type, home_type;
-	files_type($1_home_dir_t)
-	files_associate_tmp($1_home_dir_t)
-	fs_associate_tmpfs($1_home_dir_t)
-
 	type $1_tmp_t, $1_file_type;
 	files_tmp_file($1_tmp_t)
 
 	type $1_tmpfs_t;
 	files_tmpfs_file($1_tmpfs_t)
 
-	# types for network-obtained content
-	type $1_untrusted_content_t, $1_file_type, untrusted_content_type; #, customizable
-	files_type($1_untrusted_content_t)
-	files_poly_member($1_untrusted_content_t)
-
-	type $1_untrusted_content_tmp_t, $1_file_type, untrusted_content_tmp_type; # customizable
-	files_tmp_file($1_untrusted_content_tmp_t)
-
 	type $1_tty_device_t; 
 	term_tty($1_t,$1_tty_device_t)
 
 	##############################
 	#
-	# User home directory file rules
-	#
-
-	allow $1_file_type $1_home_t:filesystem associate;
-
-	##############################
-	#
 	# User domain Local policy
 	#
 
@@ -103,19 +77,6 @@
 	dontaudit $1_t self:netlink_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
 	dontaudit $1_t self:netlink_route_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown nlmsg_read nlmsg_write };
 
-	# execute files in the home directory
-	can_exec($1_t,$1_home_t)
-
-	# full control of the home directory
-	allow $1_t $1_home_t:file { create_file_perms relabelfrom relabelto entrypoint };
-	allow $1_t $1_home_t:lnk_file { create_lnk_perms relabelfrom relabelto };
-	allow $1_t $1_home_t:dir { create_dir_perms relabelfrom relabelto };
-	allow $1_t $1_home_t:sock_file { create_file_perms relabelfrom relabelto };
-	allow $1_t $1_home_t:fifo_file { create_file_perms relabelfrom relabelto };
-	allow $1_t $1_home_dir_t:dir { create_dir_perms relabelfrom relabelto };
-	type_transition $1_t $1_home_dir_t:{ dir notdevfile_class_set } $1_home_t;
-	files_search_home($1_t)
-
 	can_exec($1_t,$1_tmp_t)
 
 	# user temporary files
@@ -138,15 +99,16 @@
 	fs_tmpfs_filetrans($1_t,$1_tmpfs_t, { dir notdevfile_class_set } )
 
 	allow $1_t $1_tty_device_t:chr_file { setattr rw_file_perms };
-
-	# Allow user to relabel untrusted content
-	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:dir { create_dir_perms relabelto relabelfrom };
-	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:file { getattr unlink relabelto relabelfrom rename };
+	allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
+	term_create_pty($1_t,$1_devpts_t)
 
 	allow $1_t unpriv_userdomain:fd use;
 
+	kernel_read_system_state($1_t)
+	kernel_read_network_state($1_t)
 	kernel_read_kernel_sysctls($1_t)
 	kernel_read_net_sysctls($1_t)
+	kernel_read_fs_sysctls($1_t)
 	kernel_dontaudit_list_unlabeled($1_t)
 	kernel_dontaudit_getattr_unlabeled_files($1_t)
 	kernel_dontaudit_getattr_unlabeled_symlinks($1_t)
@@ -165,8 +127,10 @@
 
 	corenet_non_ipsec_sendrecv($1_t)
 	corenet_tcp_sendrecv_all_if($1_t)
+	corenet_raw_sendrecv_all_if($1_t)
 	corenet_udp_sendrecv_all_if($1_t)
 	corenet_tcp_sendrecv_all_nodes($1_t)
+	corenet_raw_sendrecv_all_nodes($1_t)
 	corenet_udp_sendrecv_all_nodes($1_t)
 	corenet_tcp_sendrecv_all_ports($1_t)
 	corenet_udp_sendrecv_all_ports($1_t)
@@ -193,6 +157,7 @@
 	fs_getattr_all_fs($1_t)
 	fs_getattr_all_dirs($1_t)
 	fs_search_auto_mountpoints($1_t)
+	fs_list_inotifyfs($1_t)
 
 	# cjp: some of this probably can be removed
 	selinux_get_fs_mount($1_t)
@@ -234,6 +199,11 @@
 	files_dontaudit_getattr_non_security_sockets($1_t)
 	files_dontaudit_getattr_non_security_blk_files($1_t)
 	files_dontaudit_getattr_non_security_chr_files($1_t)
+	files_read_var_files($1_t)
+	files_read_etc_files($1_t)
+	files_read_etc_runtime_files($1_t)
+	files_read_usr_files($1_t)
+	files_exec_usr_files($1_t)
 
 	# Caused by su - init scripts
 	init_dontaudit_use_script_ptys($1_t)
@@ -254,16 +224,88 @@
 	seutil_read_default_contexts($1_t)
 	seutil_run_newrole($1_t,$1_r,{ $1_devpts_t $1_tty_device_t })
 
-	tunable_policy(`allow_execmem',`
-		# Allow loading DSOs that require executable stack.
-		allow $1_t self:process execmem;
-	')
+	sysnet_dns_name_resolve($1_t)
+
+')
+#######################################
+## <summary>
+##	The template containing rules common to unprivileged
+##	users and administrative users.
+## </summary>
+## <desc>
+##	<p>
+##	This template creates a user home directories,
+##	</p>
+##	<p>
+##	This generally should not be used, rather the
+##	unpriv_user_template or admin_user_template should
+##	be used.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+#
+template(`base_login_user_template',`
 
-	tunable_policy(`allow_execmem && allow_execstack',`
-		# Allow making the stack executable via mprotect.
-		allow $1_t self:process execstack;
+	gen_require(`
+		attribute $1_file_type;
+		attribute home_dir_type, home_type;
+		attribute untrusted_content_type;
 	')
 
+	# type for contents of home directory
+	type $1_home_t, $1_file_type, home_type;
+	files_type($1_home_t)
+	files_associate_tmp($1_home_t)
+	fs_associate_tmpfs($1_home_t)
+
+	# type of home directory
+	type $1_home_dir_t, home_dir_type, home_type;
+	files_type($1_home_dir_t)
+	files_associate_tmp($1_home_dir_t)
+	fs_associate_tmpfs($1_home_dir_t)
+
+	# types for network-obtained content
+	type $1_untrusted_content_t, $1_file_type, untrusted_content_type; #, customizable
+	files_type($1_untrusted_content_t)
+	files_poly_member($1_untrusted_content_t)
+
+	type $1_untrusted_content_tmp_t, $1_file_type, untrusted_content_tmp_type; # customizable
+	files_tmp_file($1_untrusted_content_tmp_t)
+
+	##############################
+	#
+	# User home directory file rules
+	#
+
+	allow $1_file_type $1_home_t:filesystem associate;
+
+	##############################
+	#
+	# User domain Local policy
+	#
+
+	# execute files in the home directory
+	can_exec($1_t,$1_home_t)
+
+	# full control of the home directory
+	allow $1_t $1_home_t:file { create_file_perms relabelfrom relabelto entrypoint };
+	allow $1_t $1_home_t:lnk_file { create_lnk_perms relabelfrom relabelto };
+	allow $1_t $1_home_t:dir { create_dir_perms relabelfrom relabelto };
+	allow $1_t $1_home_t:sock_file { create_file_perms relabelfrom relabelto };
+	allow $1_t $1_home_t:fifo_file { create_file_perms relabelfrom relabelto };
+	allow $1_t $1_home_dir_t:dir { create_dir_perms relabelfrom relabelto };
+	type_transition $1_t $1_home_dir_t:{ dir notdevfile_class_set } $1_home_t;
+	files_search_home($1_t)
+
+	# Allow user to relabel untrusted content
+	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:dir { create_dir_perms relabelto relabelfrom };
+	allow $1_t { $1_untrusted_content_t $1_untrusted_content_tmp_t }:file { getattr unlink relabelto relabelfrom rename };
+
 	tunable_policy(`read_default_t',`
 		files_list_default($1_t)
 		files_read_default_files($1_t)
@@ -322,6 +364,10 @@
 	')
 
 	optional_policy(`
+		alsa_read_rw_config($1_t)
+	')
+
+	optional_policy(`
 		canna_stream_connect($1_t)
 	')
 
@@ -426,8 +472,10 @@
 		xserver_stream_connect_xdm($1_t)
 		# certain apps want to read xdm.pid file
 		xserver_read_xdm_pid($1_t)
+		xserver_read_xdm_tmp_files($1_t)
 		# gnome-session creates socket under /tmp/.ICE-unix/
 		xserver_create_xdm_tmp_sockets($1_t)
+		xserver_create_ice_tmp_sockets($1_t)
 	')
 ')
 
@@ -457,6 +505,7 @@
 
 	# Inherit rules for ordinary users.
 	base_user_template($1)
+	base_login_user_template($1)
 
 	typeattribute $1_t unpriv_userdomain;
 	domain_interactive_fd($1_t)
@@ -477,9 +526,6 @@
 	# Local policy
 	#
 
-	allow $1_t $1_devpts_t:chr_file { setattr ioctl read getattr lock write append };
-	term_create_pty($1_t,$1_devpts_t)
-
 	# Rules used to associate a homedir as a mountpoint
 	allow $1_home_t self:filesystem associate;
 	allow $1_file_type $1_home_t:filesystem associate;
@@ -491,10 +537,6 @@
 	allow privhome $1_home_t:sock_file create_file_perms;
 	allow privhome $1_home_t:fifo_file create_file_perms;
 	type_transition privhome $1_home_dir_t:{ dir notdevfile_class_set } $1_home_t;
-
-	kernel_read_system_state($1_t)
-	kernel_read_network_state($1_t)
-
 	dev_read_sysfs($1_t)
 
 	corecmd_exec_all_executables($1_t)
@@ -502,11 +544,8 @@
 	# port access is audited even if dac would not have allowed it, so dontaudit it here
 	corenet_dontaudit_tcp_bind_all_reserved_ports($1_t)
 
-	files_read_etc_files($1_t)
-	files_read_etc_runtime_files($1_t)
+
 	files_list_home($1_t)
-	files_read_usr_files($1_t)
-	files_exec_usr_files($1_t)
 	# Read directories and files with the readable_t type.
 	# This type is a general type for "world"-readable files.
 	files_list_world_readable($1_t)
@@ -514,8 +553,6 @@
 	files_read_world_readable_symlinks($1_t)
 	files_read_world_readable_pipes($1_t)
 	files_read_world_readable_sockets($1_t)
-	# cjp: why?
-	files_read_kernel_symbol_table($1_t)
 
 	init_read_utmp($1_t)
 	# The library functions always try to open read-write first,
@@ -621,6 +658,8 @@
 
 	# do not audit read on disk devices
 	dontaudit $1_t { removable_device_t fixed_disk_device_t }:blk_file read;
+	dontaudit $1_t sysadm_home_t:file { read append };
+	userdom_dontaudit_append_sysadm_home_content_files($1_t)
 
 	ifdef(`xdm.te', `
 		allow xdm_t $1_home_t:lnk_file read;
@@ -657,8 +696,6 @@
 	# Do not audit write denials to /etc/ld.so.cache.
 	dontaudit $1_t ld_so_cache_t:file write;
 
-	dontaudit $1_t sysadm_home_t:file { read append };
-
 	allow $1_t initrc_t:fifo_file write;
 	') dnl end TODO
 ')
@@ -704,6 +741,7 @@
 
 	# Inherit rules for ordinary users.
 	base_user_template($1)
+	base_login_user_template($1)
 
 	typeattribute $1_t privhome;
 	domain_obj_id_change_exemption($1_t)
@@ -736,11 +774,6 @@
 
 	allow $1_t self:netlink_audit_socket nlmsg_readpriv;
 
-	allow $1_t $1_devpts_t:chr_file { setattr ioctl read getattr lock write append };
-	term_create_pty($1_t,$1_devpts_t)
-
-	kernel_read_system_state($1_t)
-	kernel_read_network_state($1_t)
 	kernel_read_software_raid_state($1_t)
 	kernel_getattr_core_if($1_t)
 	kernel_getattr_message_if($1_t)
@@ -806,6 +839,7 @@
 	domain_getattr_all_sockets($1_t)
 
 	files_exec_usr_src_files($1_t)
+	files_create_boot_flag($1_t)
 
 	init_rw_initctl($1_t)
 
@@ -3359,6 +3393,25 @@
 
 ########################################
 ## <summary>
+##	Do not audit attempts to append to the sysadm
+##	users home directory.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`userdom_dontaudit_append_sysadm_home_content_files',`
+	gen_require(`
+		type sysadm_home_t;
+	')
+
+	dontaudit $1 sysadm_home_t:file ra_file_perms;
+')
+
+########################################
+## <summary>
 ##	Read files in the staff users home directory.
 ## </summary>
 ## <param name="domain">
@@ -4079,7 +4132,7 @@
 	gen_require(`
 		type user_home_dir_t;
 	')
-
+	allow $1 user_home_dir_t:dir manage_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
 
@@ -4164,7 +4217,7 @@
 	')
 
 	files_search_home($1)
-	allow $1 user_home_dir_t:dir search_dir_perms;
+	allow $1 user_home_dir_t:dir rw_dir_perms;
 	allow $1 user_home_t:dir create_dir_perms;
 ')
 
@@ -4206,7 +4259,7 @@
 	')
 
 	files_search_home($1)
-	allow $1 user_home_dir_t:dir search_dir_perms;
+	allow $1 user_home_dir_t:dir rw_dir_perms;
 	allow $1 user_home_t:dir rw_dir_perms;
 	allow $1 user_home_t:file create_file_perms;
 ')
@@ -4228,7 +4281,7 @@
 	')
 
 	files_search_home($1)
-	allow $1 user_home_dir_t:dir search_dir_perms;
+	allow $1 user_home_dir_t:dir rw_dir_perms;
 	allow $1 user_home_t:dir rw_dir_perms;
 	allow $1 user_home_t:lnk_file create_lnk_perms;
 ')
@@ -4250,7 +4303,7 @@
 	')
 
 	files_search_home($1)
-	allow $1 user_home_dir_t:dir search_dir_perms;
+	allow $1 user_home_dir_t:dir rw_dir_perms;
 	allow $1 user_home_t:dir rw_dir_perms;
 	allow $1 user_home_t:fifo_file create_file_perms;
 ')
@@ -4272,7 +4325,7 @@
 	')
 
 	files_search_home($1)
-	allow $1 user_home_dir_t:dir search_dir_perms;
+	allow $1 user_home_dir_t:dir rw_dir_perms;
 	allow $1 user_home_t:dir rw_dir_perms;
 	allow $1 user_home_t:sock_file create_file_perms;
 ')
@@ -4740,3 +4793,34 @@
 	allow $1 user_home_dir_t:dir create_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
+
+########################################
+## <summary>
+##	The template containing rules for changing from one role to another
+## </summary>
+## <desc>
+##	<p>
+##	This should only be used for new non login user roles, rather the
+##	unpriv_user_template or admin_user_template should
+##	be used.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	userdomain changing from 
+##	</summary>
+## </param>
+## <param name="userdomain_prefix">
+##	<summary>
+##	userdomain changing to
+##	</summary>
+## </param>
+#
+template(`role_change_template',`
+        allow $1_r $2_r;
+        type_change $2_t $1_devpts_t:chr_file $2_devpts_t;
+        type_change $2_t $1_tty_device_t:chr_file $2_tty_device_t;
+        # avoid annoying messages on terminal hangup
+        dontaudit $1_t { $2_devpts_t $2_tty_device_t }:chr_file ioctl;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.3.11/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-08-16 08:46:31.000000000 -0400
+++ serefpolicy-2.3.11/policy/modules/system/userdomain.te	2006-09-01 15:41:44.000000000 -0400
@@ -56,14 +56,6 @@
 # Local policy
 #
 
-define(`role_change',`
-	allow $1_r $2_r;
-	type_change $2_t $1_devpts_t:chr_file $2_devpts_t;
-	type_change $2_t $1_tty_device_t:chr_file $2_tty_device_t;
-	# avoid annoying messages on terminal hangup
-	dontaudit $1_t { $2_devpts_t $2_tty_device_t }:chr_file ioctl;
-')
-
 ifdef(`targeted_policy',`
 	# Define some type aliases to help with compatibility with
 	# macros and domains from the "strict" policy.
@@ -124,34 +116,34 @@
 
 	# user role change rules:
 	# sysadm_r can change to user roles
-	role_change(sysadm, user)
-	role_change(sysadm, staff)
+	role_change_template(sysadm, user)
+	role_change_template(sysadm, staff)
 
 	# only staff_r can change to sysadm_r
-	role_change(staff, sysadm)
+	role_change_template(staff, sysadm)
 
 	ifdef(`enable_mls',`
 		unpriv_user_template(secadm)
 		unpriv_user_template(auditadm)
 
-		role_change(staff,auditadm)
-		role_change(staff,secadm)
+		role_change_template(staff,auditadm)
+		role_change_template(staff,secadm)
 
-		role_change(sysadm,secadm)
-		role_change(sysadm,auditadm)
+		role_change_template(sysadm,secadm)
+		role_change_template(sysadm,auditadm)
 
-		role_change(auditadm,secadm)
-		role_change(auditadm,sysadm)
+		role_change_template(auditadm,secadm)
+		role_change_template(auditadm,sysadm)
 
-		role_change(secadm,auditadm)
-		role_change(secadm,sysadm)
+		role_change_template(secadm,auditadm)
+		role_change_template(secadm,sysadm)
 	')
 
 	# this should be tunable_policy, but
 	# currently type_change and RBAC allow
 	# do not work in conditionals
 	ifdef(`user_canbe_sysadm',`
-		role_change(user,sysadm)
+		role_change_template(user,sysadm)
 	')
 
 	allow privhome home_root_t:dir { getattr search };
@@ -172,6 +164,8 @@
 
 	mls_process_read_up(sysadm_t)
 
+	term_getattr_all_user_ttys(sysadm_t)
+
 	init_exec(sysadm_t)
 
 	ifdef(`direct_sysadm_daemon',`
@@ -210,7 +204,9 @@
 		init_exec(secadm_t)
 		logging_read_audit_log(secadm_t)
 	        logging_read_generic_logs(secadm_t)
-		userdom_dontaudit_append_staff_home_content_files(secadm_t)
+		userdom_dontaudit_append_sysadm_home_content_files(secadm_t)
+		userdom_dontaudit_read_sysadm_home_content_files(secadm_t)
+
 	', `
 		logging_manage_audit_log(sysadm_t)
 		logging_manage_audit_config(sysadm_t)
@@ -439,11 +435,11 @@
 			selinux_set_parameters(secadm_t)
 
 			seutil_manage_bin_policy(secadm_t)
-			seutil_run_checkpolicy(secadm_t,secadm_r,admin_terminal)
-			seutil_run_loadpolicy(secadm_t,secadm_r,admin_terminal)
-			seutil_run_semanage(secadm_t,secadm_r,admin_terminal)
-			seutil_run_setfiles(secadm_t,secadm_r,admin_terminal)
-			seutil_run_restorecon(secadm_t,secadm_r,admin_terminal)
+			seutil_run_checkpolicy(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
+			seutil_run_loadpolicy(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
+			seutil_run_semanage(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
+			seutil_run_setfiles(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
+			seutil_run_restorecon(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
 		', `
 			selinux_set_enforce_mode(sysadm_t)
 			selinux_set_boolean(sysadm_t)

--------------090603000204090902020102--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
