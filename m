Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5JEnZrT023313
	for <selinux@tycho.nsa.gov>; Sat, 19 Jun 2004 10:49:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5JEnMVl001781
	for <selinux@tycho.nsa.gov>; Sat, 19 Jun 2004 14:49:23 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DCCA361C99
	for <selinux@tycho.nsa.gov>; Sun, 20 Jun 2004 00:49:29 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16089-10 for <selinux@tycho.nsa.gov>;
	Sun, 20 Jun 2004 00:49:29 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BA2EC61BB4
	for <selinux@tycho.nsa.gov>; Sun, 20 Jun 2004 00:49:28 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D48CFB59C9
	for <selinux@tycho.nsa.gov>; Sun, 20 Jun 2004 00:49:26 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: sched_setscheduler()
Date: Sun, 20 Jun 2004 00:49:25 +1000
MIME-Version: 1.0
Message-Id: <200406200049.25402.russell@coker.com.au>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1JF1AWV8e/jiIU6"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_1JF1AWV8e/jiIU6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am having some problems with asterisk (the VOIP server).

According to strace it does the following:
sched_setscheduler(0, SCHED_OTHER, { 0 }) = -1 EACCES (Permission denied)

This failure happens in enforcing mode but not in permissive mode, however 
nothing is audited!

I have attached the relevant section of strace output as asterisk.strace.

I wrote a little test program (attached as test.c) which seems to never fail.

The asterisk policy I've written is attached, and the following needs to be 
added to net_contexts:

ifdef(`asterisk.te', `
portcon tcp 1720 system_u:object_r:asterisk_port_t
portcon tcp 2000 system_u:object_r:asterisk_port_t
portcon udp 2427 system_u:object_r:asterisk_port_t
portcon udp 4569 system_u:object_r:asterisk_port_t
portcon udp 5060 system_u:object_r:asterisk_port_t
')

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--Boundary-00=_1JF1AWV8e/jiIU6
Content-Type: text/plain;
  charset="us-ascii";
  name="asterisk.strace"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asterisk.strace"

setsid()                                = 2560
chdir("/")                              = 0
open("/dev/null", O_RDWR)               = 3
fstat64(3, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
dup2(3, 0)                              = 0
dup2(3, 1)                              = 1
dup2(3, 2)                              = 2
close(3)                                = 0
unlink("/var/run/asterisk/asterisk.pid") = 0
open("/var/run/asterisk/asterisk.pid", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
getpid()                                = 2560
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
write(3, "2560\n", 5)                   = 5
close(3)                                = 0
munmap(0x40018000, 4096)                = 0
unlink("/var/run/asterisk/asterisk.ctl") = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 3
bind(3, {sa_family=AF_FILE, path="/var/run/asterisk/asterisk.ctl"}, 110) = 0
listen(3, 2)                            = 0
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40207000
mprotect(0x40207000, 4096, PROT_NONE)   = 0
clone(child_stack=0x40a07b48, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0x40a07bf8, {entry_number:6, base_addr:0x40a07bb0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}, child_tidptr=0x40a07bf8) = 2561
rt_sigprocmask(SIG_BLOCK, [HUP INT PIPE TERM WINCH], NULL, 8) = 0
rt_sigaction(SIGURG, {0x80751b8, [URG], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x8075878, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x8075878, [TERM], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGHUP, {0x80751f0, [HUP], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGCHLD, {0x807523c, [CHLD], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGPIPE, {SIG_IGN}, {SIG_DFL}, 8) = 0
sched_setscheduler(0, SCHED_OTHER, { 0 }) = -1 EACCES (Permission denied)
time([1087655102])                      = 1087655102
open("/etc/localtime", O_RDONLY)        = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=785, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40a08000
read(4, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0"..., 4096) = 785
close(4)                                = 0
munmap(0x40a08000, 4096)                = 0
fstat64(1, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfffd20c) = -1 ENOTTY (Inappropriate ioctl for device)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40a08000
write(1, "Unable to set normal priority\n", 30) = 30
munmap(0x40a08000, 4096)                = 0
exit_group(1)                           = ?

--Boundary-00=_1JF1AWV8e/jiIU6
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test.c"

#include <sched.h>
#include <stdio.h>
#include <string.h>

int main()
{
  struct sched_param p;
  memset(&p, 0, sizeof(p));
  printf("return:%d\n", sched_setscheduler(0, SCHED_OTHER, &p));
  return 0;
}

--Boundary-00=_1JF1AWV8e/jiIU6
Content-Type: text/plain;
  charset="us-ascii";
  name="asterisk.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asterisk.fc"

# asterisk
/usr/sbin/asterisk	--	system_u:object_r:asterisk_exec_t
/var/run/asterisk(/.*)?		system_u:object_r:asterisk_var_run_t
/etc/asterisk(/.*)?		system_u:object_r:asterisk_etc_t
/var/log/asterisk(/.*)?		system_u:object_r:asterisk_log_t
/var/lib/asterisk(/.*)?		system_u:object_r:asterisk_var_lib_t
/var/spool/asterisk(/.*)?	system_u:object_r:asterisk_spool_t

--Boundary-00=_1JF1AWV8e/jiIU6
Content-Type: text/plain;
  charset="us-ascii";
  name="asterisk.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asterisk.te"

#DESC Asterisk IP telephony server
#
# Author:  Russell Coker <russell@coker.com.au>
#
# X-Debian-Packages: asterisk

type asterisk_port_t, port_type;

daemon_domain(asterisk)
allow asterisk_t asterisk_var_run_t:{ sock_file fifo_file } create_file_perms;
allow initrc_t asterisk_var_run_t:fifo_file unlink;

etcdir_domain(asterisk)
logdir_domain(asterisk)
var_lib_domain(asterisk)

allow asterisk_t asterisk_port_t:{ udp_socket tcp_socket } name_bind;

allow asterisk_t device_t:lnk_file read;
allow asterisk_t sound_device_t:chr_file rw_file_perms;

type asterisk_spool_t, file_type, sysadmfile;
rw_dir_create_file(asterisk_t, asterisk_spool_t)
allow asterisk_t var_spool_t:dir search;

can_network(asterisk_t)
allow asterisk_t etc_t:file { getattr read };

allow asterisk_t self:unix_stream_socket { connectto create_stream_socket_perms };

# for /var/run/asterisk
allow asterisk_t self:capability dac_override;

--Boundary-00=_1JF1AWV8e/jiIU6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
