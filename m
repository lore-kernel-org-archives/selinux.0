Message-ID: <407A001D.3010805@snu.edu>
Date: Sun, 11 Apr 2004 21:34:05 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: sys_admin cap breakup
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russel brought up a good point on that audio-entropyd policy, adding to 
the random pool requires sys_admin cap, here is the relavent line in 
random.c

         case RNDADDENTROPY:
                 if (!capable(CAP_SYS_ADMIN))
                         return -EPERM

around line 1768

So this is a question for the guys that are doing kernel work and 
possibly interacting with linus and friends. How plausible would it be 
to suggest breaking up caps that give lots of access in the next major 
version, 2.7 or 2.8? do you think they'd go for it?

it would mean a major change in just about every security system 
developed for linux but the payoff could be very good.. just as a 
reference where are the other things sys_admin grants, as you can see 
the potential for something with sys_admin access to damage the system 
is great..

  CAP_SYS_ADMIN
	Allow configuration of the secure attention key;
	Allow administration of the random device;
	Allow examination and configuration of disk quotas;
	Allow configuring the kernel's syslog (printk behaviour);
	Allow setting the domainname;
	Allow setting the hostname;
	Allow calling bdflush();
	Allow mount() and umount(), setting up new smb connection;
	Allow some autofs root ioctls;
	Allow nfsservctl; Allow VM86_REQUEST_IRQ;
	Allow to read/write pci config on alpha; Allow irix_prctl on mips 
(setstacksize);
	Allow flushing all cache on m68k (sys_cacheflush);
	Allow removing semaphores; Used instead of CAP_CHOWN to "chown" IPC 
message queues, semaphores and shared memory;
	Allow locking/unlocking of shared memory segment;
	Allow turning swap on/off;
	Allow forged pids on socket credentials passing;
	Allow setting readahead and flushing buffers on block devices;
	Allow setting geometry in floppy driver;
	Allow turning DMA on/off in xd driver;
	Allow administration of md devices (mostly the above, but some extra 
ioctls);
	Allow tuning the ide driver;
	Allow access to the nvram device;
	Allow administration of apm_bios, serial and bttv (TV) device;
	Allow manufacturer commands in isdn CAPI support driver;
	Allow reading nonstandardized portions of pci configuration space;
	Allow DDI debug ioctl on sbpcd driver;
	Allow setting up serial ports;
	Allow sending raw qic117 commands;
	Allow enabling/disabling tagged queuing on SCSI controllers and sending 
arbitrary SCSI commands;
	Allow setting encryption key on loopback filesystem.



Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
