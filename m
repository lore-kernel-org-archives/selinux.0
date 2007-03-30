Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UDEQxW014458
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 09:14:26 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UDEOkK020310
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 13:14:25 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id l2UD9oBk021017
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 09:09:50 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id l2UD9oGR021016
	for selinux@tycho.nsa.gov; Fri, 30 Mar 2007 09:09:50 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UCjew6013205
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 08:45:40 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UCjbO8004881
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 12:45:38 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2UCjbvU019795
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 08:45:37 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2UCjbwE021651
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 08:45:37 -0400
Received: from [10.13.248.7] (vpn-248-7.boston.redhat.com [10.13.248.7])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2UCjawE022483
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 08:45:36 -0400
Message-ID: <460D0655.2080905@redhat.com>
Date: Fri, 30 Mar 2007 08:45:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SELinux userland patches.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I did a quick search through packages that require libselinux.so.1 in 
rawhide

# rpm -q --whatrequires libselinux.s0.1
passwd-0.74-2
rpm-devel-4.4.2-40.fc7
iptables-1.3.7-1.1
tar-1.15.1-26.fc7
setools-3.1-3.fc7
dump-0.4b41-5.fc7
cryptsetup-luks-1.0.3-4.fc7
SysVinit-2.86-15
rpm-libs-4.4.2-40.fc7
findutils-4.2.29-2
prelink-0.3.10-1
xinetd-2.3.14-11
rpm-4.4.2-40.fc7
MAKEDEV-3.23-1.2
iptables-ipv6-1.3.7-1.1
rusers-server-0.17-47
dmraid-1.0.0.rc14-2.fc7
rpm-build-4.4.2-40.fc7
nss_db-2.2-36
pam-0.99.7.1-3.fc7
coreutils-6.7-9.fc7
device-mapper-libs-1.02.17-7.fc7
device-mapper-1.02.17-7.fc7
vim-minimal-7.0.201-1.fc7
libuser-0.56.1-1
vim-enhanced-7.0.201-1.fc7
psmisc-22.3-1.fc7
logrotate-3.7.5-1.fc7
mcstrans-0.2.5-1.fc7
lsof-4.78-5.fc7
util-linux-2.13-0.50.fc7
vnc-server-4.1.2-15.fc7
vixie-cron-4.1-78.fc7
udev-106-1.fc7
gnome-user-share-0.11-1.fc7
gnome-vfs2-2.18.0.1-1.fc7
httpd-2.2.4-2
gnome-vfs2-smb-2.18.0.1-1.fc7
libsemanage-2.0.1-1.fc7
usermode-1.91-1
shadow-utils-4.0.18.1-11.fc7
mesa-libGL-6.5.2-8.fc7
xorg-x11-server-Xorg-1.2.99.902-1.fc7
lvm2-2.02.24-1.fc7
nscd-2.5.90-19
net-tools-1.60-80.fc7
parted-1.8.6-1.fc7
nash-6.0.8-4
cups-1.2.10-1.fc7
mkinitrd-6.0.8-4
openssh-server-4.5p1-6.fc7
gdm-2.18.0-5.fc7
ipsec-tools-0.6.6-3.fc7
policycoreutils-2.0.7-5.fc7
policycoreutils-newrole-2.0.7-5.fc7
libselinux-2.0.8-1.fc7
libselinux-python-2.0.8-1.fc7
dbus-1.0.2-2.fc7

Then I went into the source pool for each one of these and looked for 
patches with the word
audit, mls, selinux, or context and gathered them into a tarball and put 
it on my people page.

http://people.redhat.com/dwalsh/SELinux/selinux-userland-patches.tgz
http://people.redhat.com/dwalsh/SELinux/selinux-userland-patches.txt

The txt file maps the rpm package version to the patch.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
