Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8KGD3d7018352
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 12:13:03 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8KGC6us028707
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 16:12:06 GMT
Message-ID: <45116881.3060406@redhat.com>
Date: Wed, 20 Sep 2006 12:12:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://people.redhat.com/dwalsh/SELinux/policy.diff

Changed to allow 1024 categories.

serefpolicy-2.3.14/policy/flask/mkaccess_vector.sh Changes to not output blank lines.  Kernel folks don't like blank lines.

I have a request for a boolean to allow all domains to talk to the ttys in targeted policy.  This would allow a domain to 
output errors if their is a failure.  Currenly if I screw up my httpd.conf file apache has no easy way of telling me, via 
the init script.

More changes to amanda paths

Don't transition on grubby.  Some one needs to write grubby policy, but it should not be the same as bootloader

+	#https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=202410
+	allow bootloader_t boot_runtime_t:file { rw_file_perms unlink };

+corecmd_etc_runtime_alias(firstboot_rw_t)
Adding a new alias is a pain in reference policy.  We need a better way of doing this.

logwatch scans the / directory

new rpm_exec_t executables

su needs to deal with kernel keys

mono needs to be able to be started by initrc,  Will need to confine domains we know about in the future.

gnome-pty-helper on 64 bit platforms

Fix files.if interfaces

Add a files_manage_non_secure_dirs for autofs

nfs now uses rpc_pipefs_t:fifo_file

Stop using bluetooth_helper_t

Lots of fixes to make ppp work from network manager with bluetooth

dhcpd speaks dbus

New version  of kerberos library checks access to /lib/kerberos/krb5kdc directory

add file_context for /usr/bin/lp

new networkmanager file

ntp needs to talk to unconfined_t for setting date from gnome.

oddjob policy should be added

sendmail should create pid with correct context in targeted policy

small changes to setroubleshootd to eliminate avc messages

xfs needs dac_override

need policy for pcscd any one up for it?

don't transition to su domain in targeted policy

libGL and libfame are moving around

xen has a new log directory

xen needs ptrace

xen needs to read from removable devices









--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
