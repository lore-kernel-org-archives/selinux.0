Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8GErvLa020169
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 10:53:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8GEqGLa006934
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 14:52:16 GMT
Date: Tue, 16 Sep 2003 15:53:53 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Boot time avc messages
Message-ID: <20030916145353.GM8988@vnl.com>
References: <20030915214153.GE8988@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030915214153.GE8988@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Okay Stephen, here's what is left after I've disabled most nonstandard daemons. 
System is 2.6.0-test5, patched for reiserfs but not using it yet; root is
ext3; debian packages are current with sid dist as of about 5 hours ago.


avc:  denied  { write } for  pid=303 exe=/usr/sbin/setfiles path=/dev/tty1 dev=sda2 ino=946919 scontext=root:sysadm_r:setfiles_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

# REBOOT

# DEVFSD was disincluded from this test kernel but daemon is here
avc:  denied  { sys_tty_config } for  pid=319 exe=/bin/bash capability=26 scontext=system_u:system_r:devfsd_t tcontext=system_u:system_r:devfsd_t tclass=capability

avc:  denied  { sys_tty_config } for  pid=328 exe=/sbin/hwclock capability=26 scontext=system_u:system_r:hwclock_t tcontext=system_u:system_r:hwclock_t tclass=capability

# There does not seem to be any bootlogd policy
avc:  denied  { read write } for  pid=48 exe=/sbin/bootlogd dev=sda2 ino=946402 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:device_t tclass=chr_file

avc:  denied  { ioctl } for  pid=48 exe=/sbin/bootlogd path=/dev/ptyp0 dev=sda2 ino=946402 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:device_t tclass=chr_file

avc:  denied  { read } for  pid=50 exe=/sbin/bootlogd path=/dev/ptyp0 dev=sda2 ino=946402 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:device_t tclass=chr_file


avc:  denied  { write } for  pid=72 exe=/sbin/fsck path=/dev/ttyp0 dev=sda2 ino=946403 scontext=system_u:system_r:fsadm_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

avc:  denied  { rename } for  pid=50 exe=/sbin/bootlogd dev=sda2 ino=929847 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:var_log_t tclass=file

avc:  denied  { write } for  pid=95 exe=/sbin/fsck path=/dev/ttyp0 dev=sda2 ino=946403 scontext=system_u:system_r:fsadm_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

avc:  denied  { write } for  pid=113 exe=/bin/mount path=/dev/ttyp0 dev=sda2 ino=946403 scontext=system_u:system_r:mount_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

avc:  denied  { mounton } for  pid=113 exe=/bin/mount path=/dev/pts dev= ino=1 scontext=system_u:system_r:mount_t tcontext=system_u:object_r:devpts_t tclass=dir

avc:  denied  { setattr } for  pid=193 exe=/bin/chmod dev=sda2 ino=946755 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:tty_device_t tclass=chr_file

avc:  denied  { setattr } for  pid=214 exe=/bin/touch dev=sda2 ino=1679395 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:var_run_t tclass=dir


# I'm using syslog-ng instead with minor policy changes. Perhaps 
# Russ's latest have these items fixed?
avc:  denied  { read } for  pid=220 exe=/sbin/syslog-ng path=pipe:[1143] dev= ino=1143 scontext=system_u:system_r:syslogd_t tcontext=system_u:system_r:syslogd_t tclass=fifo_file

avc:  denied  { syslog_mod } for  pid=221 exe=/sbin/syslog-ng scontext=system_u:system_r:syslogd_t tcontext=system_u:system_r:kernel_t tclass=system

avc:  denied  { name_bind } for  pid=221 exe=/sbin/syslog-ng port=999 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:port_t tclass=tcp_socket

avc:  denied  { write } for  pid=221 exe=/sbin/syslog-ng path=pipe:[1143] dev= ino=1143 scontext=system_u:system_r:syslogd_t tcontext=system_u:system_r:syslogd_t tclass=fifo_file

avc:  denied  { fsetid } for  pid=221 exe=/sbin/syslog-ng capability=4 scontext=system_u:system_r:syslogd_t tcontext=system_u:system_r:syslogd_t tclass=capability

avc:  denied  { setattr } for  pid=221 exe=/sbin/syslog-ng dev=sda2 ino=946940 scontext=system_u:system_r:syslogd_t tcontext=system_u:object_r:tty_device_t tclass=chr_file


# DEVFSD was disincluded from this test kernel but daemon is here
avc:  denied  { sys_tty_config } for  pid=231 exe=/bin/bash capability=26 scontext=system_u:system_r:devfsd_t tcontext=system_u:system_r:devfsd_t tclass=capability


avc:  denied  { search } for  pid=230 exe=/usr/sbin/inetd dev=sda2 ino=903169 scontext=system_u:system_r:inetd_t tcontext=system_u:object_r:var_lib_t tclass=dir

avc:  denied  { name_bind } for  pid=230 exe=/usr/sbin/inetd port=25 scontext=system_u:system_r:inetd_t tcontext=system_u:object_r:smtp_port_t tclass=tcp_socket

avc:  denied  { unlink } for  pid=258 exe=/bin/rm dev=sda2 ino=929844 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:var_log_t tclass=file


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
