Content-Type: text/plain;
  charset="us-ascii"
From: Bill Laut <wlsel@verizon.net>
To: SELinux@tycho.nsa.gov
Subject: Newbie Q on "disappearing" boot dialog
Date: Mon, 7 Jul 2003 12:32:49 -0400
MIME-Version: 1.0
Message-Id: <200307071232.49186.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I recently installed SELinux on my gateway/router, and as a novice I'm now 
formulating some "baby-step" questions about SELinux.

The first thing I'm noticing is that a majority of the boot dialog (such as 
the kernel initialization messages) is no longer being recorded into 
/var/log/messages.  For example, I traditionally would see:

Jul  7 09:34:26 scanner kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jul  7 09:34:26 scanner kernel: Inspecting /boot/System.map-2.4.18
Jul  7 09:34:26 scanner syslog: klogd startup succeeded
Jul  7 09:34:26 scanner kernel: Loaded 20220 symbols from 
/boot/System.map-2.4.18.
Jul  7 09:34:26 scanner kernel: Symbols match kernel version 2.4.18.
Jul  7 09:34:26 scanner kernel: Loaded 13 symbols from 1 module.
Jul  7 09:34:26 scanner kernel: Linux version 2.4.18 (...)
[...]
Jul  7 09:34:26 scanner keytable: Loading keymap:  succeeded
Jul  7 09:34:26 scanner kernel: On node 0 totalpages: 131068
Jul  7 09:34:26 scanner kernel: zone(0): 4096 pages.
Jul  7 09:34:26 scanner kernel: zone(1): 126972 pages.
Jul  7 09:34:26 scanner kernel: zone(2): 0 pages.
Jul  7 09:34:26 scanner kernel: Local APIC disabled by BIOS -- reenabling.
Jul  7 09:34:26 scanner kernel: Found and enabled local APIC!
Jul  7 09:34:26 scanner kernel: Kernel command line: ro root=/dev/hda9 
hdc=ide-scsi
Jul  7 09:34:26 scanner kernel: ide_setup: hdc=ide-scsi
Jul  7 09:34:26 scanner kernel: Initializing CPU#0
Jul  7 09:34:26 scanner kernel: Detected 1211.906 MHz processor.
Jul  7 09:34:26 scanner kernel: Console: colour VGA+ 80x25
Jul  7 09:34:26 scanner kernel: Calibrating delay loop... 2418.27 BogoMIPS

etc., etc.  Instead, what is showing up under SELinux is:

Jun 29 20:36:33 vortex syslogd 1.4.1: restart.
Jun 29 20:36:33 vortex syslog: syslogd startup succeeded
Jun 29 20:36:34 vortex syslog: klogd startup succeeded
Jun 29 20:36:34 vortex kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jun 29 20:36:34 vortex kernel: Inspecting /boot/System.map-2.4.21-vortex
       (Lots of startup messages missing between these two lines)
Jun 29 20:36:31 vortex network: Bringing up interface eth1:  succeeded
Jun 29 20:36:37 vortex keytable: Loading keymap:  succeeded
Jun 29 20:36:38 vortex keytable: Loading system font:  succeeded
Jun 29 20:36:40 vortex random: Initializing random number generator:  
succeeded
Jun 29 20:36:43 vortex autofs: automount startup succeeded
Jun 29 20:36:45 vortex sshd: Starting sshd:
Jun 29 20:36:46 vortex sshd:  succeeded
Jun 29 20:36:47 vortex sshd:
Jun 29 20:36:47 vortex rc: Starting sshd:  succeeded
    (etc.)

How do I get all of the startup messages to be logged again?  Is the default 
kernel ring buffer too small?  (I haven't yet edited the policy to resolve 
the "avc: denied" messages).  Or is there an SELinux parameter somewhere I 
need to set? 

Thank you in advance for your time to answer this query.


Regards,

Bill Laut


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
