Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hACGnUSf013875
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 11:49:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hACGn0Bb008605
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 16:49:00 GMT
Received: from sjtu.edu.cn (mailhost.shnet.edu.cn [202.112.26.54])
	by jazzswing.ncsc.mil  with ESMTP id hACGmh4o008578
	for <selinux@tycho.nsa.gov>; Wed, 12 Nov 2003 16:48:58 GMT
Message-ID: <002e01c3a93e$794e31a0$5d38a8c0@lky>
From: "lky" <lky77@sjtu.edu.cn>
To: "SELINUX" <SELinux@tycho.nsa.gov>, <russell@coker.com.au>
References: <000a01c3a892$805101f0$5d38a8c0@lky> <200311120805.33472.russell@coker.com.au>
Subject: Re: questions about sysadm
Date: Thu, 13 Nov 2003 01:00:26 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, November 12, 2003 5:05 AM,Russell Coker wrote:
> Edit load_policy.te appropriately and change the lines referring to sysadm_r 
> and sysadm_t.
> 
> But this is not all you need.  sysadm_t can still modify almost every file on 
> the system, so it will be easy for them to get secadm_r if they want.
> 
> Implementing a sysadm vs secadm split will be really difficult.

I tried to edit load_policy.te as follows:

---------------------------------------------------------------------------------
type load_policy_t, domain;
#role sysadm_r types load_policy_t;

###############################################
role secadm_r types load_policy_t;
###############################################

#type load_policy_exec_t, file_type, exec_type, sysadmfile;
type load_policy_exec_t, file_type, exec_type;

# 
# Rules

#domain_auto_trans(sysadm_t, load_policy_exec_t, load_policy_t)

#############################################
domain_auto_trans(secadm_t, load_policy_exec_t, load_policy_t)
############################################

# for running it from an init script
domain_auto_trans(initrc_t, load_policy_exec_t, load_policy_t)
allow load_policy_t init_t:fd use;
allow load_policy_t console_device_t:chr_file { read write };
role system_r types load_policy_t;

ifdef(`dpkg.te', `
domain_auto_trans(dpkg_t, load_policy_exec_t, load_policy_t)
')

# Reload the policy configuration (sysadm_t no longer has this ability)
can_loadpol(load_policy_t)

###########################################
allow load_policy_t locale_t:file { read getattr };
allow load_policy_t locale_t:dir { search };
allow load_policy_t secadm_tty_device_t:chr_file { read write };
##########################################

# constrain from where load_policy can load a policy, specifically 
# policy_config_t files 
#

# only allow read of policy config files
allow load_policy_t policy_config_t:dir r_dir_perms;
allow load_policy_t policy_config_t:notdevfile_class_set r_file_perms;

# directory search permissions for path to binary policy files
allow load_policy_t root_t:dir search;
allow load_policy_t etc_t:dir search;

# Read the devpts root directory (needed?)  
allow load_policy_t devpts_t:dir r_dir_perms;

# Other access
allow load_policy_t { initrc_devpts_t admin_tty_type }:chr_file { read write ioctl getattr };
uses_shlib(load_policy_t)
allow load_policy_t self:capability dac_override;

allow load_policy_t { initrc_t privfd }:fd use;

allow load_policy_t fs_t:filesystem getattr;

#allow load_policy_t sysadm_tmp_t:file { getattr write } ;
allow load_policy_t secadm_tmp_t:file { getattr write };
-------------------------------------------------------

But I still can't run 'make reload'or 'make relabel'.The same errors are there:

-------------------------------------------------------
/usr/sbin/load_policy /etc/security/selinux/policy.15-mls
/usr/sbin/load_policy:  security_load_policy failed
make: *** [reload] Error 3
----------------------------------------------------------------------------------------
How should I modify the load_policy.te? The error message is too simple to figure out the direct reason.Should I need to modify some other files? I think perhaps secadm lacks some rights. Secadm is created as a common user with fully access rights to /selinux/src/policy/. I have modified checkpolicy.te and load_policy.te in order to let secadm can checkpolicy and load it. But now  secadm can only check the policy while can't load the policy.
Thanks!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
