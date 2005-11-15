Subject: Re: [ SEMANAGE ] Stub pserver backend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <4379E4D1.2010900@redhat.com>
References: <437907D7.8090002@cornell.edu>
	 <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil>
	 <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil>
	 <4379E4D1.2010900@redhat.com>
Content-Type: multipart/mixed; boundary="=-wPgsq7BJkrTmTM1bOhvS"
Date: Tue, 15 Nov 2005 09:12:10 -0500
Message-Id: <1132063930.5415.364.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wPgsq7BJkrTmTM1bOhvS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-11-15 at 08:38 -0500, Daniel J Walsh wrote:
> refpolicy went in last night.   Now we need to get strict/mls working.  
> As well as clean up the bugs that
> refpolicy will cause.

Ok, I'm presently updated a rawhide targeted system, and have attached
three files with relevant output from yum, dmesg, and avc audit.  The
yum output shows what booleans were lost in translation and what files
were relabeled by restorecon.  The dmesg output shows what security
contexts were no longer valid in the new policy, which then triggers
subsequent inode_doinit errors upon the relabeling.  The avc audit
output shows the denials that would have occurred during the restorecon
if I had done this in enforcing mode.  I also noticed that policy is
reloaded twice; second load occurs during cleanup phase for some reason.

-- 
Stephen Smalley
National Security Agency

--=-wPgsq7BJkrTmTM1bOhvS
Content-Disposition: attachment; filename=yum.out
Content-Type: text/plain; name=yum.out; charset=utf-8
Content-Transfer-Encoding: 7bit

  Updating  : selinux-policy-targeted      ####################### [39/76]
Attempting to install base module '/usr/share/selinux/targeted/base.pp':
Ok: return value of 0.
Committing changes:
libsepol.sepol_genbools_array: boolean allow_postgresql_use_pam no longer in policy
libsepol.sepol_genbools_array: boolean allow_write_xshm no longer in policy
libsepol.sepol_genbools_array: boolean getty_disable_trans no longer in policy
libsepol.sepol_genbools_array: boolean pppd_for_user no longer in policy
libsepol.sepol_genbools_array: boolean system_dbusd_disable_trans no longer in policy
/var/lib is already defined in /etc/selinux/targeted/contexts/files/file_contexts,
/usr/sbin/genhomedircon will not create a new context.
Ok: transaction number 0.
/sbin/restorecon reset /usr/X11R6/lib/X11/xkb/xkbcomp context system_u:object_r:lib_t->system_u:object_r:bin_t
/sbin/restorecon reset /usr/share/texmf/web2c/pdfxmltex.fmt context root:object_r:tmp_t->system_u:object_r:usr_t
/sbin/restorecon reset /usr/share/texmf/web2c/xmltex.log context root:object_r:tmp_t->system_u:object_r:usr_t
/sbin/restorecon reset /usr/share/texmf/web2c/xmltex.fmt context root:object_r:tmp_t->system_u:object_r:usr_t
/sbin/restorecon reset /usr/share/texmf/web2c/pdfxmltex.log context root:object_r:tmp_t->system_u:object_r:usr_t
/sbin/restorecon reset /usr/share/texmf/web2c/jadetex.log context root:object_r:tmp_t->system_u:object_r:usr_t
/sbin/restorecon reset /usr/share/texmf/web2c/pdfjadetex.log context root:object_r:tmp_t->system_u:object_r:usr_t
/sbin/restorecon reset /usr/share/texmf/web2c/pdfjadetex.fmt context root:object_r:tmp_t->system_u:object_r:usr_t
/sbin/restorecon reset /usr/share/texmf/web2c/jadetex.fmt context root:object_r:tmp_t->system_u:object_r:usr_t
/sbin/restorecon reset /usr/share/cracklib context system_u:object_r:usr_t->system_u:object_r:crack_db_t
/sbin/restorecon reset /usr/share/cracklib/pw_dict.pwd context system_u:object_r:usr_t->system_u:object_r:crack_db_t
/sbin/restorecon reset /usr/share/cracklib/pw_dict.hwm context system_u:object_r:usr_t->system_u:object_r:crack_db_t
/sbin/restorecon reset /usr/share/cracklib/cracklib.magic context system_u:object_r:usr_t->system_u:object_r:crack_db_t
/sbin/restorecon reset /usr/share/cracklib/pw_dict.pwi context system_u:object_r:usr_t->system_u:object_r:crack_db_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/rmiregistry context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/javac context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/rebuild-gcj-db context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/rmic context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/aot-compile-rpm context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/jar context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/javah context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/javadoc context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/java context system_u:object_r:bin_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/qt-3.3/etc/settings context system_u:object_r:unlabeled_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/qt-3.3/etc/settings/kstylerc context system_u:object_r:unlabeled_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/lib/qt-3.3/etc/settings/qtrc context system_u:object_r:unlabeled_t->system_u:object_r:lib_t
/sbin/restorecon reset /usr/bin/at context system_u:object_r:bin_t->system_u:object_r:crontab_exec_t
/sbin/restorecon reset /usr/bin/smbmnt context system_u:object_r:bin_t->system_u:object_r:smbmount_exec_t
/sbin/restorecon reset /usr/bin/gpasswd context system_u:object_r:bin_t->system_u:object_r:groupadd_exec_t
/sbin/restorecon reset /usr/bin/crontab context system_u:object_r:bin_t->system_u:object_r:crontab_exec_t
/sbin/restorecon reset /usr/bin/nmap context system_u:object_r:bin_t->system_u:object_r:traceroute_exec_t
/sbin/restorecon reset /usr/bin/smbmount context system_u:object_r:bin_t->system_u:object_r:smbmount_exec_t
/sbin/restorecon reset /usr/bin/spamassassin context system_u:object_r:bin_t->system_u:object_r:spamassassin_exec_t
/sbin/restorecon reset /usr/sbin/cracklib-format context system_u:object_r:sbin_t->system_u:object_r:crack_exec_t
/sbin/restorecon reset /usr/sbin/logrotate context system_u:object_r:sbin_t->system_u:object_r:logrotate_exec_t
/sbin/restorecon reset /usr/sbin/cracklib-check context system_u:object_r:sbin_t->system_u:object_r:crack_exec_t
/sbin/restorecon reset /usr/sbin/groupdel context system_u:object_r:sbin_t->system_u:object_r:groupadd_exec_t
/sbin/restorecon reset /usr/sbin/cracklib-packer context system_u:object_r:sbin_t->system_u:object_r:crack_exec_t
/sbin/restorecon reset /usr/sbin/tmpwatch context system_u:object_r:sbin_t->system_u:object_r:tmpreaper_exec_t
/sbin/restorecon reset /usr/sbin/utempter context system_u:object_r:sbin_t->system_u:object_r:utempter_exec_t
/sbin/restorecon reset /usr/sbin/groupadd context system_u:object_r:sbin_t->system_u:object_r:groupadd_exec_t
/sbin/restorecon reset /usr/sbin/userdel context system_u:object_r:sbin_t->system_u:object_r:useradd_exec_t
/sbin/restorecon reset /usr/sbin/groupmod context system_u:object_r:sbin_t->system_u:object_r:groupadd_exec_t
/sbin/restorecon reset /usr/sbin/usermod context system_u:object_r:sbin_t->system_u:object_r:useradd_exec_t
/sbin/restorecon reset /usr/sbin/gdm-binary context system_u:object_r:xdm_exec_t->system_u:object_r:sbin_t
/sbin/restorecon reset /usr/sbin/tcpd context system_u:object_r:sbin_t->system_u:object_r:tcpd_exec_t
/sbin/restorecon reset /usr/sbin/cracklib-unpacker context system_u:object_r:sbin_t->system_u:object_r:crack_exec_t
/sbin/restorecon reset /usr/sbin/useradd context system_u:object_r:sbin_t->system_u:object_r:useradd_exec_t
/sbin/restorecon reset /boot/System.map context system_u:object_r:system_map_t->system_u:object_r:boot_t
/sbin/restorecon reset /lib/security/pam_krb5/pam_krb5_storetmp context system_u:object_r:lib_t->system_u:object_r:pam_exec_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.seriomap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.inputmap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.ccwmap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.isapnpmap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.usbmap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.dep context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.alias context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.pcimap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.ieee1394map context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1674_FC5smp/modules.symbols context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.seriomap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.inputmap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.ccwmap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.isapnpmap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.usbmap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.dep context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.alias context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.pcimap context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.ieee1394map context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /lib/modules/2.6.14-1.1665_FC5smp/modules.symbols context root:object_r:modules_object_t->system_u:object_r:modules_dep_t
/sbin/restorecon reset /var/lock/subsys/sm-client context system_u:object_r:unlabeled_t->system_u:object_r:var_lock_t
/sbin/restorecon reset /var/lock/subsys/sendmail context system_u:object_r:unlabeled_t->system_u:object_r:var_lock_t
/sbin/restorecon reset /var/gdm context system_u:object_r:unlabeled_t->system_u:object_r:var_t
/sbin/restorecon reset /var/gdm/.cookie context system_u:object_r:unlabeled_t->system_u:object_r:var_t
/sbin/restorecon reset /var/gdm/:0.Xauth context system_u:object_r:unlabeled_t->system_u:object_r:var_t
/sbin/restorecon reset /var/gdm/.gdmfifo context system_u:object_r:unlabeled_t->system_u:object_r:var_t
/sbin/restorecon reset /var/lib/logrotate.status context system_u:object_r:var_lib_t->system_u:object_r:logrotate_var_lib_t
/sbin/restorecon reset /var/log/rpmpkgs context system_u:object_r:var_log_t->system_u:object_r:rpm_log_t
/sbin/restorecon reset /var/log/gdm context system_u:object_r:unlabeled_t->system_u:object_r:var_log_t
/sbin/restorecon reset /var/log/gdm/:0.log.1 context system_u:object_r:unlabeled_t->system_u:object_r:var_log_t
/sbin/restorecon reset /var/log/gdm/:0.log context system_u:object_r:unlabeled_t->system_u:object_r:var_log_t
/sbin/restorecon reset /var/log/gdm/:0.log.3 context system_u:object_r:unlabeled_t->system_u:object_r:var_log_t
/sbin/restorecon reset /var/log/gdm/:0.log.2 context system_u:object_r:unlabeled_t->system_u:object_r:var_log_t
/sbin/restorecon reset /var/log/gdm/:0.log.4 context system_u:object_r:unlabeled_t->system_u:object_r:var_log_t
/sbin/restorecon reset /var/log/yum.log context system_u:object_r:var_log_t->system_u:object_r:rpm_log_t
/sbin/restorecon reset /var/log/yum.log.1 context system_u:object_r:rpm_log_t->system_u:object_r:var_log_t
/sbin/restorecon reset /var/run/sudo context system_u:object_r:var_run_t->system_u:object_r:pam_var_run_t
/sbin/restorecon reset /var/run/sudo/sds context system_u:object_r:var_run_t->system_u:object_r:pam_var_run_t
/sbin/restorecon reset /var/run/sudo/root context system_u:object_r:var_run_t->system_u:object_r:pam_var_run_t
/sbin/restorecon reset /var/run/sudo/_pam_timestamp_key context system_u:object_r:var_run_t->system_u:object_r:pam_var_run_t
/sbin/restorecon reset /var/run/console context system_u:object_r:var_run_t->system_u:object_r:pam_var_console_t
/sbin/restorecon reset /bin/tracepath context system_u:object_r:bin_t->system_u:object_r:traceroute_exec_t
/sbin/restorecon reset /bin/mount context system_u:object_r:bin_t->system_u:object_r:mount_exec_t
/sbin/restorecon reset /bin/traceroute context system_u:object_r:bin_t->system_u:object_r:traceroute_exec_t
/sbin/restorecon reset /bin/umount context system_u:object_r:bin_t->system_u:object_r:mount_exec_t
/sbin/restorecon reset /bin/tracepath6 context system_u:object_r:bin_t->system_u:object_r:traceroute_exec_t
/sbin/restorecon reset /sbin/dmsetup.static context system_u:object_r:unlabeled_t->system_u:object_r:sbin_t
/sbin/restorecon reset /sbin/mkinitrd context system_u:object_r:sbin_t->system_u:object_r:bootloader_exec_t
/sbin/restorecon reset /sbin/grubby context system_u:object_r:sbin_t->system_u:object_r:bootloader_exec_t
/sbin/restorecon reset /sbin/sulogin context system_u:object_r:sbin_t->system_u:object_r:sulogin_exec_t
/sbin/restorecon reset /sbin/cryptsetup context system_u:object_r:unlabeled_t->system_u:object_r:sbin_t
/sbin/restorecon reset /sbin/grub-terminfo context system_u:object_r:sbin_t->system_u:object_r:bootloader_exec_t
/sbin/restorecon reset /sbin/grub-install context system_u:object_r:sbin_t->system_u:object_r:bootloader_exec_t
/sbin/restorecon reset /sbin/grub-md5-crypt context system_u:object_r:sbin_t->system_u:object_r:bootloader_exec_t
/sbin/restorecon reset /sbin/grub context system_u:object_r:sbin_t->system_u:object_r:bootloader_exec_t
/sbin/restorecon reset /sbin/pam_timestamp_check context system_u:object_r:sbin_t->system_u:object_r:pam_exec_t
/sbin/restorecon reset /sbin/pam_console_apply context system_u:object_r:sbin_t->system_u:object_r:pam_console_exec_t
/sbin/restorecon reset /etc/ld.so.cache context root:object_r:etc_t->system_u:object_r:ld_so_cache_t
/sbin/restorecon reset /etc/rc.d/init.d/sendmail context system_u:object_r:unlabeled_t->system_u:object_r:initrc_exec_t
/sbin/restorecon reset /etc/X11/xdm/Xsession context system_u:object_r:unlabeled_t->system_u:object_r:etc_t




--=-wPgsq7BJkrTmTM1bOhvS
Content-Disposition: attachment; filename=dmesg.out
Content-Type: text/plain; name=dmesg.out; charset=utf-8
Content-Transfer-Encoding: 7bit

security:  3 users, 6 roles, 1044 types, 116 bools, 1 sens, 256 cats
security:  55 classes, 31351 rules
security:  invalidating context system_u:system_r:sendmail_launch_t:s0
security:  invalidating context system_u:object_r:sendmail_launch_exec_t:s0
security:  invalidating context system_u:object_r:sendmail_launch_lock_t:s0
security:  invalidating context user_u:system_r:ypxfr_t:s0
security:  invalidating context system_u:object_r:xserver_log_t:s0
security:  invalidating context system_u:object_r:xdm_xserver_tmp_t:s0
security:  invalidating context system_u:object_r:xsession_exec_t:s0
security:  invalidating context system_u:object_r:xdm_rw_etc_t:s0
security:  invalidating context system_u:object_r:xdm_var_run_t:s0
security:  invalidating context system_u:object_r:xdm_var_lib_t:s0
security:  invalidating context user_u:sysadm_r:ypxfr_t:s0
security:  invalidating context system_u:system_r:procmail_t:s0
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:xdm_var_run_t:s0) returned 22 for dev=dm-0 ino=2494768
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:xdm_var_run_t:s0) returned 22 for dev=dm-0 ino=2494119
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:sendmail_launch_lock_t:s0) returned 22 for dev=dm-0 ino=5626272
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:sendmail_launch_lock_t:s0) returned 22 for dev=dm-0 ino=5626270
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:xserver_log_t:s0) returned 22 for dev=dm-0 ino=5657925
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:xserver_log_t:s0) returned 22 for dev=dm-0 ino=5657949
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:xserver_log_t:s0) returned 22 for dev=dm-0 ino=5657950
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:xserver_log_t:s0) returned 22 for dev=dm-0 ino=5657928
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:xserver_log_t:s0) returned 22 for dev=dm-0 ino=5657952
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:xserver_log_t:s0) returned 22 for dev=dm-0 ino=5657931
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:lvm_exec_t:s0) returned 22 for dev=dm-0 ino=7685553
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:lvm_exec_t:s0) returned 22 for dev=dm-0 ino=7685538
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:sendmail_launch_exec_t:s0) returned 22 for dev=dm-0 ino=5102806
inode_doinit_with_dentry:  context_to_sid(system_u:object_r:xsession_exec_t) returned 22 for dev=dm-0 ino=5103774
security:  3 users, 6 roles, 1044 types, 116 bools, 1 sens, 256 cats
security:  55 classes, 31351 rules

--=-wPgsq7BJkrTmTM1bOhvS
Content-Disposition: attachment; filename=audit.out
Content-Type: text/plain; name=audit.out; charset=utf-8
Content-Transfer-Encoding: 7bit

type=AVC msg=audit(1132062016.379:234): avc:  denied  { getattr } for  pid=25793 comm="find" name="gdm-binary" dev=dm-0 ino=2035791 scontext=root:system_r:rpm_script_t:s0-s0:c0.c255 tcontext=system_u:object_r:xdm_exec_t:s0 tclass=file
type=AVC msg=audit(1132062016.831:235): avc:  denied  { getattr } for  pid=25789 comm="restorecon" name="gdm-binary" dev=dm-0 ino=2035791 scontext=root:system_r:restorecon_t:s0-s0:c0.c255 tcontext=system_u:object_r:xdm_exec_t:s0 tclass=file
type=AVC msg=audit(1132062016.831:236): avc:  denied  { relabelfrom } for  pid=25789 comm="restorecon" name="gdm-binary" dev=dm-0 ino=2035791 scontext=root:system_r:restorecon_t:s0-s0:c0.c255 tcontext=system_u:object_r:xdm_exec_t:s0 tclass=file

--=-wPgsq7BJkrTmTM1bOhvS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
