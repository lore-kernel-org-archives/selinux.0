Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA19643
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2001 14:56:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA19944
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2001 18:56:28 GMT
Received: from csoc-fire05.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzband.ncsc.mil  with SMTP id SAA19938
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2001 18:56:24 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015241D1@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: FreeSwan Intergration.
Date: Mon, 27 Aug 2001 13:56:22 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is the changes for the ipsec domian for intergration of FreeSwan
You must have applied the patch (key.patch) that Mr Smalley has posted to
the list.

The key.patch was posted 8-27-01


Mark Westerman
Thank to Mr. Smalley for all the sujestions!



###########################################
file: rbac
all ipsec_t to role system_r types


###########################################
file: domains/program/modutil.te
Add the following lines

# Rules for ipsec Domain 
allow insmod_t ipsec_t:process signal;

##########################################
file: domains/system/initrc.te
Add the following lines

# ipsec Domain
domain_auto_trans(initrc_t, ipsec_exec_t, ipsec_t)
allow initrc_t ipsec_file_t:file { read ioctl };
allow initrc_t ipsec_var_run_t:sock_file { read write };

############################################
file: domains/system/ipsec.te
Create the file and add the following lines

#
# Authors: Mark Westerman mark.westerman@westcam.com
#
########################################
#
# Rules for the ipsec_t domain.
#
type ipsec_t, domain, privlog;
type ipsec_exec_t, file_type, sysadmfile, exec_type;
type ipsec_file_t, file_type, syadmfile;
type ipsec_var_run_t, file_type, sysadmfile, pidfile;

allow ipsec_t self:capability { net_admin net_bind_service };

domain_auto_trans(ipsec_t, insmod_exec_t, insmod_t)

domain_auto_trans(ipsec_t, ifconfig_exec_t, ifconfig_t)
file_type_auto_trans(ipsec_t, var_run_t, ipsec_var_run_t)

allow ipsec_t var_lock_t:dir rw_dir_perms;
allow ipsec_t var_lock_t:file create_file_perms;

# Inherit and use descriptors from init.
allow ipsec_t init_t:fd inherit_fd_perms;

allow ipsec_t ipsec_file_t:file { getattr read ioctl };

allow ipsec_t self:key_socket { create write read };


#####################################################
file: domains/admin/sysadm.te
Add the following before the ') line

#
# This will allow the sysadm user to read and 
# modify the /etc/ipsec.secrets file.
# I will create a ipsecadm_r role for this file
# Mark Westerman mark.westerman@westcam.com

allow $1_t ipsec_file_t:file rw_file_perms;


####################################################
file: ../setfiles/file_contexts
I would add the following line right before the 
persistent label mapping. Order does mater for this file


#
# IPSEC Defination
#
/etc/ipsec.secrets              system_u:object_r:ipsec_file_t
/usr/local/lib/ipsec(|/.*)      system_u:object_r:sbin_t
/usr/local/lib/ipsec/eroute     system_u:object_r:ipsec_exec_t
/usr/local/lib/ipsec/klipsdebug system_u:object_r:ipsec_exec_t
/usr/local/lib/ipsec/pluto      system_u:object_r:ipsec_exec_t
/usr/local/lib/ipsec/spi        system_u:object_r:ipsec_exec_t



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
