Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA07703
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 13:58:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA08516
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 18:58:47 GMT
Received: from csoc-mail-msfc.csoconline.com (csoc-mail-msfc.csoconline.com [140.169.36.3])
	by jazzswing.ncsc.mil  with ESMTP id SAA08484
	for <selinux@tycho.nsa.gov>; Mon, 12 Feb 2001 18:58:38 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A10152407B@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: selinux@tycho.nsa.gov
Subject: SeLinux Question
Date: Mon, 12 Feb 2001 12:58:10 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

To all,

I have been try to get selinux running on a Redhat 7 box. I have the
kernel running in debug mode and i am try to get rid of the denied messages

I am work on the /sbin/hwclock program.

Thanks
Mark Westerman
mark.westerman@csoconline.com



Here are the rules


file:   domains/system/hwclock.te
#################################
#
# Rules for the hwclock_t domain.
#
type hwclock_t, domain, privlog;
type hwclock_exec_t, file_type, sysadmfile, exec_type;

# Use capabilities.
allow hwclock_t self:capability { sys_admin };

# Inherit and use descriptors from init.
#allow hwclock_t init_t:fd inherit_fd_perms;

# Use a pipe created by initrc_t.
#allow hwclock_t initrc_t:pipe rw_file_perms;

# Read and write ttys.
allow hwclock_t tty_device_t:chr_file rw_file_perms;


file: domains/system/initrc.te

domain_auto_trans(initrc_t, hwclock_exec_t, hwclock_t)


file:  file_context
/sbin/hwclock                   system_u:object_r:hwclock_exec_t


ls --scontext /sbin/hwclock

system_u:object_r:hwclock_exec_t /sbin/hwclock


file: /var/log/messages

security_compute_sid:  invalid context system_u:system_r:hwclock_t 
        for scontext=system_u:system_r:initrc_t 
              tcontext=system_u:object_r:hwclock_exec_t tclass=process


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
