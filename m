Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3D9ruRb014774
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 05:53:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3D9rtmw023743
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 09:53:55 GMT
Received: from plusmx1.polkomtel.com.pl (plusmx1.polkomtel.com.pl [212.2.96.51])
        by jazzband.ncsc.mil  with ESMTP id i3D9rs4w023740 for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 09:53:54 GMT
Received: from mswwaw2.corp.plusnet (plus-96-119.polkomtel.com.pl [212.2.96.119])
	by plusmx1.polkomtel.com.pl (Postfix) with ESMTP id 4ABF838020
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 11:53:53 +0200 (CEST)
Received: from E2K2.corp.plusnet (mcs1baln1.corp.plusnet) by mswwaw2.corp.plusnet
 (Content Technologies SMTPRS 4.3.12) with ESMTP id <T68f02011c4c0a8011f460@mswwaw2.corp.plusnet> for <selinux@tycho.nsa.gov>;
 Tue, 13 Apr 2004 11:53:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Subject: Problems with 2.4.24
Date: Tue, 13 Apr 2004 11:53:52 +0200
Message-ID: <2A857CE92C11FE40858689CAEC7BED490A43910D@E2K2.corp.plusnet>
From: =?iso-8859-2?Q?Jaros=B3aw_Nozderko?= <jaroslaw.nozderko@polkomtel.com.pl>
To: "SELinux Mailing List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

 I'm trying to set up SELinux (SUSE 9 Pro) and have
problems. I realize, of course, that I'm probably
making some basic mistake, as I'm quite new
to SELinux.

I've downloaded prepatched 2.4.24 kernel and
userland tools from NSA. I've also added systrace
(http://www.systrace.org) and epoll 
(http://www.xmailserver.org/linux-patches/nio-improve.html),
resolving few patch conflicts (later, I also tried the same
with unmodified NSA 2.4.24 kernel, but had the same problems).
 
I've built and install kernel, trying to follow instructions
in SELinux README. Kernel boots OK with enforcing=1:

$ dmesg | grep SELinux
SELinux:  Initializing.
SELinux:  Starting in enforcing mode

I've created /selinux directory. README (BUILDING AND 
INSTALLING, p. 4) says selinuxfs should be mounted by init.
It doesn't seem to do it - I had to do it manually or to 
add fstab entry:

none /selinux  selinuxfs  defaults   0 0

Then selinuxfs gets mounted:

# mount
/dev/hda3 on / type ext3 (rw,acl,user_xattr)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/hda4 on /home1 type ext3 (rw,acl,user_xattr)
none on /selinux type selinuxfs (rw)
tmpfs on /dev/shm type tmpfs (rw)

# more /selinux/enforce
1

I've installed SEL userland and added my user 'jarek' 
to policy/users:

user jarek roles { user_r };

... and moved up *.te from unused directory. Then I've 
installed by 'make install'. 

After reboot, the situation is as follows:

# ps --context
  PID    SID CONTEXT                                  COMMAND
 1414      - -                                        su
 1415      - -                                        bash
 1787      - -                                        ps --context

# newrole -r sysadm_r
Sorry, newrole may be used only on a SELinux kernel.

So, it seems something is seriously wrong here.

I'm trying to assign ext. attributes (README, p. 6):

# cd /etc/security/selinux/src/policy

policy# make relabel
m4 file_contexts/types.fc  file_contexts/program/checkpolicy.fc
file_contexts/program/chkpwd.fc file_contexts/program/crond.fc
file_contexts/program/crontab.fc file_contexts/program/fsadm.fc
file_contexts/program/getty.fc file_contexts/program/hostname.fc
file_contexts/program/ifconfig.fc file_contexts/program/initrc.fc
file_contexts/program/init.fc file_contexts/program/klogd.fc
file_contexts/program/ldconfig.fc file_contexts/program/load_policy.fc
file_contexts/program/login.fc file_contexts/program/logrotate.fc
file_contexts/program/modutil.fc file_contexts/program/mount.fc
file_contexts/program/mta.fc file_contexts/program/netutils.fc
file_contexts/program/newrole.fc file_contexts/program/passwd.fc
file_contexts/program/setfiles.fc file_contexts/program/ssh.fc
file_contexts/program/su.fc file_contexts/program/syslogd.fc
file_contexts/program/tmpreaper.fc file_contexts/program/useradd.fc
file_contexts/program/xdm.fc file_contexts/program/xfs.fc
file_contexts/program/xserver.fc > file_contexts/file_contexts.tmp
cat file_contexts/file_contexts.homedirtmp >> file_contexts/file_contexts.tmp
mv file_contexts/file_contexts.tmp file_contexts/file_contexts
/usr/sbin/setfiles file_contexts/file_contexts `mount | awk '/(ext[23]|
xfs).*rw/{print $3}'`
/usr/sbin/setfiles:  read 455 specifications
/usr/sbin/setfiles:  invalid context system_u:object_r:file_t on line number
39
/usr/sbin/setfiles:  invalid context system_u:object_r:root_t on line number
44
/usr/sbin/setfiles:  invalid context system_u:object_r:mnt_t on line number
 48 /usr/sbin/setfiles:  invalid context system_u:object_r:var_t on line
 number 53 /usr/sbin/setfiles:  invalid context system_u:object_r:catman_t on
 line number 54
/usr/sbin/setfiles:  invalid context system_u:object_r:catman_t on line
 number 55
/usr/sbin/setfiles:  invalid context system_u:object_r:var_yp_t on line
 number 56
/usr/sbin/setfiles:  invalid context system_u:object_r:var_lib_t on line
number 57
/usr/sbin/setfiles:  invalid context system_u:object_r:var_lib_nfs_t on line
number 58
/usr/sbin/setfiles:  invalid context system_u:object_r:tetex_data_t on line
number 59
Exiting after 10 errors.

There are entries in logs:

/var/log/warn:

Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:file_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:root_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:mnt_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_yp_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_nfs_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:tetex_data_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:file_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:root_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:mnt_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_yp_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_nfs_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:tetex_data_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:file_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:root_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:mnt_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_yp_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_nfs_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:tetex_data_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:file_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:root_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:mnt_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_yp_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_nfs_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:tetex_data_t

======================================================
/var/log/messages:

Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:file_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:root_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:mnt_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_yp_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_nfs_t
Apr 12 17:43:22 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:tetex_data_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:file_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:root_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:mnt_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_yp_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_nfs_t
Apr 12 17:49:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:tetex_data_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:file_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:root_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:mnt_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_yp_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_nfs_t
Apr 12 17:54:31 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:tetex_data_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:file_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:root_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:mnt_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:catman_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_yp_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:var_lib_nfs_t
Apr 12 17:56:23 skorpion kernel: security_context_to_sid: called before
initial load_policy on unknown context system_u:object_r:tetex_data_t

Does "before initial load_policy" mean that policy is not loaded ?
Did I miss something obvious ?

Best regards,
Jarek


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
