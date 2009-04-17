Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3HIsKl5003716
	for <selinux@tycho.nsa.gov>; Fri, 17 Apr 2009 14:54:21 -0400
Received: from mail-qy0-f131.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3HIsKfm002372
	for <selinux@tycho.nsa.gov>; Fri, 17 Apr 2009 18:54:20 GMT
Received: by qyk37 with SMTP id 37so1206712qyk.32
        for <selinux@tycho.nsa.gov>; Fri, 17 Apr 2009 11:54:20 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 17 Apr 2009 11:54:19 -0700
Message-ID: <dd18b0c30904171154s571bc232q34dd4b6274f0b88d@mail.gmail.com>
Subject: SELinux: unrecognized netlink message
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm seeing this in dmesg:
(as I add the allow rules to a new machine)

[   13.769513] SELinux: initialized (dev tmpfs, type tmpfs), uses
transition SIDs
[   19.025365] ndiswrapper version 1.54-2.6.27.7 loaded (smp=yes, preempt=no)
[   19.329584] ndiswrapper: driver bcmwl5 (Broadcom,03/21/2008,
4.170.77.3) loaded
[   19.330401] ndiswrapper 0000:03:00.0: power state changed by ACPI to D0
[   19.330571] ndiswrapper 0000:03:00.0: PCI INT A -> Link[Z00F] ->
GSI 22 (level, low) -> IRQ 22
[   19.330856] ndiswrapper 0000:03:00.0: power state changed by ACPI to D0
[   19.330973] ndiswrapper 0000:03:00.0: setting latency timer to 64
[   19.344429] ndiswrapper: using IRQ 22
[   19.570301] wlan0 (ndiswrapper): not using net_device_ops yet
[   19.570825] wlan0: ethernet device 00:1f:f3:bd:f0:98 using NDIS
driver: bcmwl5, version: 0x4aa4d03, NDIS version: 0x501, vendor: 'NDIS
Network Adapter', 14E4:432B.5.conf
[   19.570876] wlan0: encryption modes supported: WEP; TKIP with WPA,
WPA2, WPA2PSK; AES/CCMP with WPA, WPA2, WPA2PSK
[   19.572385] usbcore: registered new interface driver ndiswrapper
[   23.017545] type=1401 audit(1239994223.882:3): SELinux:
unrecognized netlink message type=28265 for sclass=43
[   23.017547]
[   23.017574] type=1300 audit(1239994223.882:3): arch=40000003
syscall=4 success=yes exit=18 a0=2 a1=8064c17 a2=12 a3=12 items=0
ppid=1690 pid=1780 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="ip"
exe="/sbin/ip" subj=system_u:system_r:ifconfig_t:s0 key=(null)


Hopefully I can start the system in full enforcement.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
