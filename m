MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: controlling VM access to different tap devices
Date: Wed, 3 Nov 2010 12:19:11 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E024A0888@exchange2.columbia.tresys.com>
From: "Ryan Haggerty" <rhaggerty@tresys.com>
To: <libvirt-users@redhat.com>
Cc: <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry if this off-topic but I have a qemu related question I was going
to send to the qemu users mailing list but that list appears to have
vanished.  I thought this community might have some insight.

I am interested in controlling VM access to different tap devices so I
want to have different qemu processes bound to different tun devices.
I've created new tun devices (eg. /dev/net/tun_low) followed by the use
of tunctl to create new tap devices based off of the new device nodes
(ie tunctl -t tap0 -f /dev/net/tun_low). This also did not seem to work
as the VM's seemed to still be accessing /dev/net/tun (running strace on
qemu-spice I found it was still doing an open on /dev/net/tun) and not
my new device /dev/net/tun_low.  Any suggestions on forcing qemu to use
alternative tun devices?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
