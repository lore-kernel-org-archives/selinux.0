Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6HaTDa005727
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 12:36:30 -0500
Received: from ccerelbas03.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6HZhiG011331
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 17:35:44 GMT
Message-ID: <454F7298.9070306@hp.com>
Date: Mon, 06 Nov 2006 12:36:24 -0500
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: redhat-lspp@redhat.com
Cc: selinux@tycho.nsa.gov
Subject: Policy for aide
Content-Type: multipart/mixed;
 boundary="------------040508090608060902090501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040508090608060902090501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Here is an initial attempt at an aide policy.  So far I've only been
testing it on strict-mls so if you are using the Tresys reference policy
Makefile.example you'll need to use TYPE=strict-mls as an option to
build it.

This policy assumes that /var/lib/aide/ exists and is aide_db_t:SysHigh.
   It does not allow aide_t to read shadow_t, even though it is common
to have aide check the shadow files, since there is an assert in the
policy against types reading shadow_t.  Aide can complete its scan
without being able to read shadow files with only a little complaining.
 The testing of this policy has focused on using James Antill's
aide.conf and his patched version of aide which is SELinux aware.
http://people.redhat.com/jantill/aide/

-matt

--------------040508090608060902090501
Content-Type: text/plain;
 name="aide.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aide.fc"

/usr/sbin/aide	--	gen_context(system_u:object_r:aide_exec_t,mls_systemhigh)
/var/lib/aide(/.*)	gen_context(system_u:object_r:aide_db_t,mls_systemhigh)
/var/log/aide.log	--	gen_context(system_u:object_r:aide_log_t,mls_systemhigh)

--------------040508090608060902090501
Content-Type: text/plain;
 name="aide.if"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aide.if"

## <summary>Aide filesystem integrity checker</summary>

########################################
## <summary>
##      Execute aide in the aide domain
## </summary>
## <param name="domain">
##      <summary>
##      The type of the process performing this action.
##      </summary>
## </param>
#
interface(`aide_domtrans',`
        gen_require(`
                type aide_t, aide_exec_t;
        ')

        domain_auto_trans($1,aide_exec_t,aide_t)
')


--------------040508090608060902090501
Content-Type: text/plain;
 name="aide.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aide.te"


policy_module(aide,1.0)

########################################
#
# Declarations
#

type aide_t;
type aide_exec_t;

domain_type(aide_t)
domain_entry_file(aide_t,aide_exec_t)

# log files
type aide_log_t;
logging_log_file(aide_log_t)

# aide database
type aide_db_t;
files_type(aide_db_t)

########################################
#
# aide local policy
#
domain_auto_trans(secadm_t,aide_exec_t,aide_t)
role secadm_r types aide_t;

allow secadm_t aide_exec_t:file { execute read };

allow aide_t secadm_t:fd use;
allow aide_t secadm_t:fifo_file rw_file_perms;
allow aide_t secadm_t:process sigchld;
allow aide_t secadm_devpts_t:chr_file { ioctl read write };

allow aide_t newrole_t:fd use;

# database actions
allow aide_t aide_db_t:file { create ioctl getattr read write };
allow aide_t aide_db_t:dir rw_dir_perms;
allow secadm_t aide_db_t:dir { add_name remove_name write };

# logs
type_transition aide_t var_log_t:file aide_log_t;
allow aide_t var_log_t:dir { add_name getattr read search write };
allow aide_t aide_log_t:file { create getattr read write };

# audit
allow aide_t self:capability audit_write;
allow aide_t self:netlink_audit_socket { create read nlmsg_relay write };


########################################
#
# Allow aide to look at a bunch of files
#
require {
	class capability { dac_override fowner audit_write }; 
	class chr_file { ioctl getattr read write };
	class dir { getattr read search }; 
	class fd use;
	class file { getattr ioctl read write }; 
	class lnk_file { getattr read }; 
	class netlink_audit_socket { create read nlmsg_relay write };
	type etc_t;
	type lib_t;
	type ld_so_cache_t;
	type usr_t;
	type secadm_t;
	type secadm_devpts_t;
	type shlib_t;
	type newrole_t;
        type var_log_t;
	type NetworkManager_exec_t; 
	type acct_exec_t; 
	type adjtime_t; 
	type admin_passwd_exec_t; 
	type aide_t; 
	type amanda_dumpdates_t; 
	type anacron_exec_t; 
	type apm_exec_t; 
	type apmd_exec_t; 
	type auditctl_exec_t; 
	type auditd_etc_t; 
	type auditd_exec_t; 
	type auditd_log_t; 
	type automount_etc_t; 
	type automount_exec_t; 
	type bin_t; 
	type bluetooth_conf_t; 
	type bluetooth_exec_t; 
	type bluetooth_helper_exec_t; 
	type boot_t; 
	type bootloader_exec_t; 
	type cert_t; 
	type checkpolicy_exec_t; 
	type chfn_exec_t; 
	type chkpwd_exec_t; 
	type consoletype_exec_t; 
	type cpucontrol_conf_t; 
	type cpucontrol_exec_t; 
	type cpuspeed_exec_t; 
	type crack_db_t; 
	type crack_exec_t; 
	type cron_spool_t; 
	type crond_exec_t; 
	type crontab_exec_t; 
	type cupsd_etc_t; 
	type cupsd_exec_t; 
	type cupsd_log_t; 
	type cupsd_rw_etc_t; 
	type cvs_exec_t; 
	type dbusd_etc_t; 
	type default_context_t; 
	type devpts_t;
	type depmod_exec_t; 
	type dhcpc_exec_t; 
	type dmesg_exec_t; 
	type dmidecode_exec_t; 
	type dnssec_t; 
	type etc_aliases_t; 
	type etc_runtime_t; 
	type etc_t; 
	type exports_t; 
	type faillog_t; 
	type file_context_t; 
	type firstboot_exec_t; 
	type fonts_t; 
	type fsadm_exec_t; 
	type fsdaemon_exec_t; 
	type ftpd_exec_t; 
	type getty_exec_t; 
	type gpg_exec_t; 
	type gpg_helper_exec_t; 
	type gpm_exec_t; 
	type groupadd_exec_t; 
	type gssd_exec_t; 
	type hald_exec_t; 
	type hostname_exec_t; 
	type hotplug_exec_t; 
	type hwclock_exec_t; 
	type hwdata_t; 
	type ifconfig_exec_t; 
	type inetd_exec_t; 
	type init_exec_t; 
	type initrc_exec_t; 
	type insmod_exec_t; 
	type ipsec_conf_file_t; 
	type ipsec_exec_t; 
	type ipsec_key_file_t; 
	type iptables_exec_t; 
	type irqbalance_exec_t; 
	type klogd_exec_t; 
	type krb5_conf_t; 
	type kudzu_exec_t; 
	type lastlog_t; 
	type ld_so_t; 
	type ldconfig_exec_t; 
	type lib_t; 
	type load_policy_exec_t; 
	type loadkeys_exec_t; 
	type locale_t; 
	type locate_exec_t; 
	type login_exec_t; 
	type logrotate_exec_t; 
	type logwatch_exec_t; 
	type lost_found_t; 
	type lpr_exec_t; 
	type ls_exec_t; 
	type lvm_etc_t; 
	type lvm_exec_t; 
	type lvm_metadata_t; 
	type man_t; 
	type mdadm_exec_t; 
	type modules_conf_t; 
	type modules_dep_t; 
	type modules_object_t; 
	type mount_exec_t; 
	type named_checkconf_exec_t; 
	type named_conf_t; 
	type named_exec_t; 
	type ndc_exec_t; 
	type net_conf_t; 
	type netutils_exec_t; 
	type newrole_exec_t; 
	type nfsd_exec_t; 
	type nscd_exec_t; 
	type pam_console_exec_t; 
	type pam_exec_t; 
	type passwd_exec_t; 
	type ping_exec_t; 
	type policy_config_t; 
	type portmap_exec_t; 
	type portmap_helper_exec_t; 
	type postfix_bounce_exec_t; 
	type postfix_cleanup_exec_t; 
	type postfix_etc_t; 
	type postfix_exec_t; 
	type postfix_local_exec_t; 
	type postfix_map_exec_t; 
	type postfix_master_exec_t; 
	type postfix_pickup_exec_t; 
	type postfix_pipe_exec_t; 
	type postfix_postdrop_exec_t; 
	type postfix_postqueue_exec_t; 
	type postfix_qmgr_exec_t; 
	type postfix_showq_exec_t; 
	type postfix_smtp_exec_t; 
	type postfix_smtpd_exec_t; 
	type pppd_etc_rw_t; 
	type pppd_etc_t; 
	type pppd_exec_t; 
	type pppd_script_exec_t; 
	type pppd_secret_t; 
	type prelink_cache_t; 
	type prelink_exec_t; 
	type prelink_log_t; 
	type quota_exec_t; 
	type rdisc_exec_t; 
	type readahead_exec_t; 
	type restorecon_exec_t; 
	type restorecond_exec_t; 
	type rlogind_exec_t; 
	type rpcd_exec_t; 
	type rpm_exec_t; 
	type rpm_log_t; 
	type rshd_exec_t; 
	type rsync_exec_t; 
	type run_init_exec_t; 
	type saslauthd_exec_t; 
	type sbin_t; 
	type secadm_devpts_t; 
	type selinux_config_t; 
	type semanage_exec_t; 
	type semanage_read_lock_t; 
	type semanage_store_t; 
	type semanage_trans_lock_t; 
	type sendmail_exec_t; 
	type setfiles_exec_t; 
	type setrans_exec_t; 
	type shadow_t; 
	type shell_exec_t; 
	type src_t; 
	type ssh_agent_exec_t; 
	type ssh_exec_t; 
	type ssh_keygen_exec_t; 
	type ssh_keysign_exec_t; 
	type sshd_exec_t; 
	type sshd_key_t; 
	type stunnel_etc_t; 
	type stunnel_exec_t; 
	type su_exec_t; 
	type sudo_exec_t; 
	type sulogin_exec_t; 
	type sysadm_home_dir_t; 
	type sysadm_home_ssh_t; 
	type sysadm_home_t; 
	type syslogd_exec_t; 
	type system_cron_spool_t; 
	type system_dbusd_exec_t; 
	type system_map_t; 
	type tcpd_exec_t; 
	type telnetd_exec_t; 
	type textrel_shlib_t; 
	type tmpreaper_exec_t; 
	type traceroute_exec_t; 
	type udev_exec_t; 
	type unlabeled_t; 
	type update_modules_exec_t; 
	type useradd_exec_t; 
	type usr_t; 
	type var_lib_t; 
	type var_log_t; 
	type var_spool_t; 
	type var_t; 
	type vbetool_exec_t; 
	type wtmp_t; 
	type ypbind_exec_t; 

        role secadm_r;
};

# These are the rules aide needs in order to run
allow aide_t etc_t:dir search;
allow aide_t lib_t:dir { getattr search };
allow aide_t usr_t:dir search;
allow aide_t ld_so_cache_t:file { read getattr };
allow aide_t shlib_t:file { read getattr execute };
allow aide_t lib_t:lnk_file read;

# These are the read rules aide needs based on aide.conf
allow aide_t NetworkManager_exec_t:file { getattr read };
allow aide_t acct_exec_t:file { getattr read };
allow aide_t adjtime_t:file { getattr read };
allow aide_t admin_passwd_exec_t:file { getattr read };
allow aide_t self:capability { dac_override fowner };
allow aide_t amanda_dumpdates_t:file { getattr read };
allow aide_t anacron_exec_t:file { getattr read };
allow aide_t apm_exec_t:file { getattr read };
allow aide_t apmd_exec_t:file { getattr read };
allow aide_t auditctl_exec_t:file { getattr read };
allow aide_t auditd_etc_t:dir { getattr read search };
allow aide_t auditd_etc_t:file { getattr read };
allow aide_t auditd_exec_t:file { getattr read };
allow aide_t auditd_log_t:dir { getattr read search };
allow aide_t auditd_log_t:file { getattr read };
allow aide_t automount_etc_t:file { getattr read };
allow aide_t automount_exec_t:file { getattr read };
allow aide_t bin_t:dir { getattr read search };
allow aide_t bin_t:file { getattr read };
allow aide_t bin_t:lnk_file { getattr read };
allow aide_t bluetooth_conf_t:dir { getattr read search };
allow aide_t bluetooth_conf_t:file { getattr read };
allow aide_t bluetooth_exec_t:file { getattr read };
allow aide_t bluetooth_helper_exec_t:file { getattr read };
allow aide_t boot_t:dir { getattr read search };
allow aide_t boot_t:file { getattr read };
allow aide_t boot_t:lnk_file { getattr read };
allow aide_t bootloader_exec_t:file { getattr read };
allow aide_t cert_t:dir { getattr read search };
allow aide_t cert_t:file { getattr read };
allow aide_t cert_t:lnk_file { getattr read };
allow aide_t checkpolicy_exec_t:file { getattr read };
allow aide_t chfn_exec_t:file { getattr read };
allow aide_t chkpwd_exec_t:file { getattr read };
allow aide_t consoletype_exec_t:file { getattr read };
allow aide_t cpucontrol_conf_t:file { getattr read };
allow aide_t cpucontrol_exec_t:file { getattr read };
allow aide_t cpuspeed_exec_t:file { getattr read };
allow aide_t crack_db_t:dir { getattr read search };
allow aide_t crack_db_t:file { getattr read };
allow aide_t crack_exec_t:file { getattr read };
allow aide_t cron_spool_t:dir { getattr read search };
allow aide_t cron_spool_t:file { getattr read };
allow aide_t crond_exec_t:file { getattr read };
allow aide_t crontab_exec_t:file { getattr read };
allow aide_t cupsd_etc_t:dir { getattr read search };
allow aide_t cupsd_etc_t:file { getattr read };
allow aide_t cupsd_etc_t:lnk_file { getattr read };
allow aide_t cupsd_exec_t:file { getattr read };
allow aide_t cupsd_log_t:dir { getattr read search };
allow aide_t cupsd_log_t:file { getattr read };
allow aide_t cupsd_rw_etc_t:file { getattr read };
allow aide_t cvs_exec_t:file { getattr read };
allow aide_t dbusd_etc_t:dir { getattr read search };
allow aide_t dbusd_etc_t:file { getattr read };
allow aide_t default_context_t:dir { getattr read search };
allow aide_t default_context_t:file { getattr read };
allow aide_t devpts_t:dir { getattr read search };
allow aide_t depmod_exec_t:file { getattr read };
allow aide_t dhcpc_exec_t:file { getattr read };
allow aide_t dmesg_exec_t:file { getattr read };
allow aide_t dmidecode_exec_t:file { getattr read };
allow aide_t dnssec_t:file { getattr read };
allow aide_t etc_aliases_t:file { getattr read };
allow aide_t etc_runtime_t:dir { getattr read search };
allow aide_t etc_runtime_t:file { getattr read };
allow aide_t etc_t:dir { getattr read };
allow aide_t etc_t:file { getattr ioctl read };
allow aide_t etc_t:lnk_file { getattr read };
allow aide_t exports_t:file { getattr read };
allow aide_t faillog_t:file { getattr read };
allow aide_t file_context_t:dir { getattr read search };
allow aide_t file_context_t:file { getattr read };
allow aide_t firstboot_exec_t:file { getattr read };
allow aide_t fonts_t:dir { getattr read };
allow aide_t fonts_t:lnk_file { getattr read };
allow aide_t fsadm_exec_t:file { getattr read };
allow aide_t fsdaemon_exec_t:file { getattr read };
allow aide_t ftpd_exec_t:file { getattr read };
allow aide_t getty_exec_t:file { getattr read };
allow aide_t gpg_exec_t:file { getattr read };
allow aide_t gpg_helper_exec_t:file { getattr read };
allow aide_t gpm_exec_t:file { getattr read };
allow aide_t groupadd_exec_t:file { getattr read };
allow aide_t gssd_exec_t:file { getattr read };
allow aide_t hald_exec_t:file { getattr read };
allow aide_t hostname_exec_t:file { getattr read };
allow aide_t hotplug_exec_t:file { getattr read };
allow aide_t hwclock_exec_t:file { getattr read };
allow aide_t hwdata_t:dir { getattr read search };
allow aide_t hwdata_t:file { getattr read };
allow aide_t ifconfig_exec_t:file { getattr read };
allow aide_t inetd_exec_t:file { getattr read };
allow aide_t init_exec_t:file { getattr read };
allow aide_t initrc_exec_t:file { getattr read };
allow aide_t insmod_exec_t:file { getattr read };
allow aide_t ipsec_conf_file_t:dir { getattr read search };
allow aide_t ipsec_conf_file_t:file { getattr read };
allow aide_t ipsec_exec_t:file { getattr read };
allow aide_t ipsec_key_file_t:dir { getattr read };
allow aide_t ipsec_key_file_t:file { getattr read };
allow aide_t iptables_exec_t:file { getattr read };
allow aide_t irqbalance_exec_t:file { getattr read };
allow aide_t klogd_exec_t:file { getattr read };
allow aide_t krb5_conf_t:file { getattr read };
allow aide_t kudzu_exec_t:file { getattr read };
allow aide_t lastlog_t:file { getattr read };
allow aide_t ld_so_t:file { getattr read };
allow aide_t ldconfig_exec_t:file { getattr read };
allow aide_t lib_t:dir read;
allow aide_t lib_t:file { getattr read };
allow aide_t lib_t:lnk_file { getattr read };
allow aide_t load_policy_exec_t:file { getattr read };
allow aide_t loadkeys_exec_t:file { getattr read };
allow aide_t locale_t:dir { getattr read search };
allow aide_t locale_t:file { getattr read };
allow aide_t locale_t:lnk_file { getattr read };
allow aide_t locate_exec_t:file { getattr read };
allow aide_t login_exec_t:file { getattr read };
allow aide_t logrotate_exec_t:file { getattr read };
allow aide_t logwatch_exec_t:file { getattr read };
allow aide_t lost_found_t:dir { getattr read };
allow aide_t lpr_exec_t:file { getattr read };
allow aide_t ls_exec_t:file { getattr read };
allow aide_t lvm_etc_t:dir { getattr read search };
allow aide_t lvm_etc_t:file { getattr read };
allow aide_t lvm_exec_t:file { getattr read };
allow aide_t lvm_metadata_t:dir { getattr read search };
allow aide_t lvm_metadata_t:file { getattr read };
allow aide_t man_t:dir { getattr read search };
allow aide_t man_t:file { getattr read };
allow aide_t man_t:lnk_file { getattr read };
allow aide_t mdadm_exec_t:file { getattr read };
allow aide_t modules_conf_t:file { getattr read };
allow aide_t modules_dep_t:file { getattr read };
allow aide_t modules_object_t:dir { getattr read search };
allow aide_t modules_object_t:file { getattr read };
allow aide_t modules_object_t:lnk_file { getattr read };
allow aide_t mount_exec_t:file { getattr read };
allow aide_t named_checkconf_exec_t:file { getattr read };
allow aide_t named_conf_t:file { getattr read };
allow aide_t named_exec_t:file { getattr read };
allow aide_t ndc_exec_t:file { getattr read };
allow aide_t net_conf_t:file { getattr read };
allow aide_t netutils_exec_t:file { getattr read };
allow aide_t newrole_exec_t:file { getattr read };
allow aide_t nfsd_exec_t:file { getattr read };
allow aide_t nscd_exec_t:file { getattr read };
allow aide_t pam_console_exec_t:file { getattr read };
allow aide_t pam_exec_t:file { getattr read };
allow aide_t passwd_exec_t:file { getattr read };
allow aide_t ping_exec_t:file { getattr read };
allow aide_t policy_config_t:dir { getattr read search };
allow aide_t policy_config_t:file { getattr read };
allow aide_t portmap_exec_t:file { getattr read };
allow aide_t portmap_helper_exec_t:file { getattr read };
allow aide_t postfix_bounce_exec_t:file { getattr read };
allow aide_t postfix_cleanup_exec_t:file { getattr read };
allow aide_t postfix_etc_t:dir { getattr read search };
allow aide_t postfix_etc_t:file { getattr read };
allow aide_t postfix_exec_t:file { getattr read };
allow aide_t postfix_local_exec_t:file { getattr read };
allow aide_t postfix_map_exec_t:file { getattr read };
allow aide_t postfix_master_exec_t:file { getattr read };
allow aide_t postfix_pickup_exec_t:file { getattr read };
allow aide_t postfix_pipe_exec_t:file { getattr read };
allow aide_t postfix_postdrop_exec_t:file { getattr read };
allow aide_t postfix_postqueue_exec_t:file { getattr read };
allow aide_t postfix_qmgr_exec_t:file { getattr read };
allow aide_t postfix_showq_exec_t:file { getattr read };
allow aide_t postfix_smtp_exec_t:file { getattr read };
allow aide_t postfix_smtpd_exec_t:file { getattr read };
allow aide_t pppd_etc_rw_t:dir { getattr read };
allow aide_t pppd_etc_rw_t:file { getattr read };
allow aide_t pppd_etc_t:dir { getattr read search };
allow aide_t pppd_exec_t:file { getattr read };
allow aide_t pppd_script_exec_t:file { getattr read };
allow aide_t pppd_secret_t:file { getattr read };
allow aide_t prelink_cache_t:file { getattr read };
allow aide_t prelink_exec_t:file { getattr read };
allow aide_t prelink_log_t:dir { getattr read search };
allow aide_t prelink_log_t:file { getattr read };
allow aide_t quota_exec_t:file { getattr read };
allow aide_t rdisc_exec_t:file { getattr read };
allow aide_t readahead_exec_t:file { getattr read };
allow aide_t restorecon_exec_t:file { getattr read };
allow aide_t restorecond_exec_t:file { getattr read };
allow aide_t rlogind_exec_t:file { getattr read };
allow aide_t rpcd_exec_t:file { getattr read };
allow aide_t rpm_exec_t:file { getattr read };
allow aide_t rpm_log_t:file { getattr read };
allow aide_t rshd_exec_t:file { getattr read };
allow aide_t rsync_exec_t:file { getattr read };
allow aide_t run_init_exec_t:file { getattr read };
allow aide_t saslauthd_exec_t:file { getattr read };
allow aide_t sbin_t:dir { getattr read search };
allow aide_t sbin_t:file { getattr read };
allow aide_t sbin_t:lnk_file { getattr read };
allow aide_t secadm_devpts_t:chr_file { getattr read };
allow aide_t selinux_config_t:dir { getattr read };
allow aide_t semanage_exec_t:file { getattr read };
allow aide_t semanage_read_lock_t:file { getattr read };
allow aide_t semanage_store_t:dir { getattr read search };
allow aide_t semanage_store_t:file { getattr read };
allow aide_t semanage_trans_lock_t:file { getattr read };
allow aide_t sendmail_exec_t:file { getattr read };
allow aide_t setfiles_exec_t:file { getattr read };
allow aide_t setrans_exec_t:file { getattr read };
#
# Disallow aide to look at the shadow file even though
# it wants to, base policy _really_ doesn't like that idea
#allow aide_t shadow_t:file { getattr read };
#
allow aide_t shell_exec_t:file { getattr read };
allow aide_t src_t:dir { getattr read };
allow aide_t ssh_agent_exec_t:file { getattr read };
allow aide_t ssh_exec_t:file { getattr read };
allow aide_t ssh_keygen_exec_t:file { getattr read };
allow aide_t ssh_keysign_exec_t:file { getattr read };
allow aide_t sshd_exec_t:file { getattr read };
allow aide_t sshd_key_t:file { getattr read };
allow aide_t stunnel_etc_t:dir { getattr read };
allow aide_t stunnel_exec_t:file { getattr read };
allow aide_t su_exec_t:file { getattr read };
allow aide_t sudo_exec_t:file { getattr read };
allow aide_t sulogin_exec_t:file { getattr read };
allow aide_t sysadm_home_dir_t:dir { getattr read search };
allow aide_t sysadm_home_ssh_t:dir { getattr read search };
allow aide_t sysadm_home_ssh_t:file { getattr read };
allow aide_t sysadm_home_t:dir { getattr read search };
allow aide_t sysadm_home_t:file { getattr read };
allow aide_t syslogd_exec_t:file { getattr read };
allow aide_t system_cron_spool_t:dir { getattr read };
allow aide_t system_cron_spool_t:file { getattr read };
allow aide_t system_dbusd_exec_t:file { getattr read };
allow aide_t system_map_t:file { getattr read };
allow aide_t tcpd_exec_t:file { getattr read };
allow aide_t telnetd_exec_t:file { getattr read };
allow aide_t textrel_shlib_t:file { getattr read };
allow aide_t tmpreaper_exec_t:file { getattr read };
allow aide_t traceroute_exec_t:file { getattr read };
allow aide_t udev_exec_t:file { getattr read };
allow aide_t unlabeled_t:file { getattr read write };
allow aide_t update_modules_exec_t:file { getattr read };
allow aide_t useradd_exec_t:file { getattr read };
allow aide_t usr_t:dir { getattr read };
allow aide_t usr_t:file { getattr read };
allow aide_t usr_t:lnk_file { getattr read };
allow aide_t var_lib_t:dir search;
allow aide_t var_log_t:file { getattr read };
allow aide_t var_spool_t:dir { getattr read search };
allow aide_t var_t:dir read;
allow aide_t vbetool_exec_t:file { getattr read };
allow aide_t wtmp_t:file { getattr read };
allow aide_t ypbind_exec_t:file { getattr read };

--------------040508090608060902090501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
