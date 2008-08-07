Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77MXglF003462
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 18:33:42 -0400
Received: from mailhub5.stratus.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m77MXdH9010977
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 22:33:40 GMT
Received: from EXNAR.corp.stratus.com (exnar.corp.stratus.com [134.111.200.165])
	by mailhub5.stratus.com (8.12.11/8.12.11) with ESMTP id m77MXNx5007117
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 18:33:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: logging to FIFOs
Date: Thu, 7 Aug 2008 18:33:36 -0400
Message-ID: <DA0E7D869C862D4095C265233CD1D41E0B709B@EXNA.corp.stratus.com>
From: "Johnson, Richard" <Richard.Johnson@stratus.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to script an install of a set of rpms on a RHEL5.2 system
(targeted policy 2.4.6-137)

Some rpm %post scripts trigger policy violations when trying to redirect
the rpm output.  Two specifics:
    /sbin/restorecon when installing a policy module
    /bin/mount as invoked by "service kdump restart"

The violations trigger for both files and fifos, they do not trigger
when not rpm output goes directly to the tty.

A sample violation (from kdump service):

time->Thu Aug  7 15:52:21 2008
type=SYSCALL msg=audit(1218138741.316:791): arch=c000003e syscall=59
success=yes exit=0 a0=1fdd3350 a1=1fdd3590 a2=1fde7540 a3=8 items=0
ppid=11571 pid=11572 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
sgid=0 fsgid=0 tty=ttyS1 ses=46 comm="mount" exe="/bin/mount"
subj=root:system_r:mount_t:s0 key=(null)
type=AVC msg=audit(1218138741.316:791): avc:  denied  { write } for
pid=11572 comm="mount"
path="/tmp/opt/ft/install_6.0.2-190_20080807_1546/rpm_log_fifo" dev=md2
ino=5358268 scontext=root:system_r:mount_t:s0
tcontext=root:object_r:tmp_t:s0 tclass=fifo_file

The idiom used is:
	# The following gets exit status from RPM and logs its output.
	#
	# Set up a fifo to chase the rpm output w/o blocking access to
the rpm
	# command's exit status
	fifoname=/${tmp_dir}/rpm_log_fifo 
	mkfifo ${fifoname} || abort "Could not create RPM log fifo"
	tee -a ${log_file} <${fifoname} &

	eval ${install_env} \
	   rpm -Uvh ${rpm_flags} ${to_install_rpms} >${fifoname} 2>&1
	status=$?
	rm -f ${fifoname}	#...tear down the fifo

Violations are triggered for both tmp_t and var_log_t fifo's.

Is there another idiom that would satisfy both the logging and timely
feedback requirements for a >5 minute rpm transaction?
       


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
