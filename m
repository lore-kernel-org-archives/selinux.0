Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5EvtRb005000
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 09:57:55 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB5EvElU016003
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 14:57:14 GMT
Received: from hotmail.com (bay1-dav25.bay1.hotmail.com [65.54.244.82])
	by jazzswing.ncsc.mil  with ESMTP id hB5EvDSX016000
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 14:57:14 GMT
From: "Stephen" <mridion@hotmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: Problems loading policy
Date: Sat, 6 Dec 2003 01:57:47 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <BAY1-DAV25idcOHuICu0000353b@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi
I'm getting the follwing error when I try and load my selinux policy
load_policy /etc/security/selinux/policy.15 (or policy.12 - whats the
diference?)
security_load_policy: Function not implemented

Im using the selinux-policy-default and selinux packages from cocker.com.au.
The packages installed fine and ran make relabel etc fine
Running checkpolicy
checkpolicy:  loading policy configuration from policy.conf
security:  5 users, 5 roles, 1049 types
security:  29 classes, 119120 rules
checkpolicy:  policy configuration loaded

I have compiled my kernel with ROMFS, capabilities and SELinux. Here is my
kernel dmesg
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized


apt-get install cramfsprogs initrd-tools genromfs

Created a /etc/mkinitrd/mkinitrd.conf file with this in it
MKIMAGE='genromfs -d %s -f %s > /dev/null'

I have created a initrd file "cd /boot ; mkinitrd -o initrd.img-2.4.22
/lib/modules/2.4.22"
In /etc/lilo.conf I have added initrd=/boot/initrd.img-2.4.22 under the
relevant image section
"mkdir /selinux" and add line to /etc/fstab
none /selinux selinuxfs defaults 0 0

But when I try and load the policy it fails
root@anskiere:/etc/selinux# make load
/usr/sbin/load_policy /etc/security/selinux/policy.12
security_load_policy: Function not implemented
make: *** [reload] Error 2

Any ideas?

Thanks
Stephen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
