Subject: /dev/mem error starting X11
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 01 Jul 2002 09:51:20 -0400
Message-Id: <1025531480.13205.19.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Howdy all,

I just installed the latest 2.4-lsm package on an almost fresh install
of RH7.3 (stock + gnome 2) and when I try to start X11 I get an error
accessing /dev/mem (and as I just noticed /dev/apm_bios)

avc:  denied  { read } for  pid=10290 exe=/usr/X11R6/bin/XFree86
path=/dev/mem dev=03:03 ino=65566 scontext=root:sysadm_r:sysadm_t
tcontext=system_u:object_r:memory_device_t tclass=chr_file

avc:  denied  { read write } for  pid=10290 exe=/usr/X11R6/bin/XFree86
path=/dev/apm_bios dev=03:03 ino=65587 scontext=root:sysadm_r:sysadm_t
tcontext=system_u:object_r:apm_bios_t tclass=chr_file

avc:  denied  { read write } for  pid=10290 exe=/usr/X11R6/bin/XFree86
path=/dev/mem dev=03:03 ino=65566 scontext=root:sysadm_r:sysadm_t
tcontext=system_u:object_r:memory_device_t tclass=chr_file
Jul  1 

Anyone have any ideas?  Also, despite that my networking works and
everything I keep getting an avc message dealing with dhcp.  The dhcp
works, I'm just curious about the message if anyone can explain it.

avc:  denied  { recvfrom } for  saddr=192.168.42.242 daddr=192.168.42.7
netif=eth0 scontext=system_u:system_r:dhcpc_t
tcontext=system_u:system_r:icmp_socket_t tclass=packet_socket

Thanks,



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
