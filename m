Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA08939
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 16:14:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA16047
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 21:14:06 GMT
Received: from csoc-mail-msfc.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzswing.ncsc.mil  with ESMTP id VAA16020
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 21:13:58 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152407F@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: hwclock
Date: Mon, 12 Feb 2001 15:14:01 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Thanks to all,  
I got it to finally work here are the complete rules
If there is something amiss please let me know thanks,

Thanks !!!
Mark

PS. My first rules



##Add to file_contexts

/sbin/hwclock                   system_u:object_r:hwclock_exec_t

##Add to rbac

role system_r type {
     ...
     hwclock_t
     ...
};

##Add to domains/system/initrc.te

domain_auto_trans(initrc_t, hwclock_exec_t, hwclock_t)


create file domains/system/hwclock.te

#
# Authors:  Mark Westerman <mark.westerman@csoconline.com>
#
#################################
#
# Rules for the hwclock_t domain.
#
type hwclock_t, domain, privlog;
type hwclock_exec_t, file_type, sysadmfile, exec_type;

# Use capabilities.
allow hwclock_t self:capability { sys_admin sys_rawio sys_time};

# Inherit and use descriptors from init.
allow hwclock_t init_t:fd inherit_fd_perms;

# Read and write ttys.
allow hwclock_t clock_device_t:chr_file rw_file_perms;
allow hwclock_t sysadm_tty_device_t:chr_file rw_file_perms;




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
