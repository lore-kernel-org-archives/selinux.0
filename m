Subject: SELinux Policy Editor and CAP_SYS_BOOT
From: Nick <nick-lists@austin.rr.com>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 13 Jan 2005 13:37:14 -0600
Message-Id: <1105645034.32758.35.camel@hawaii.efficax.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have the need to enable (and make work) the shutdown and halt
accounts. I set a password for these accounts and tried to use them and
got the expected "you must be root" a collegue pointed out that I might
need the CAP_SYS_BOOT capability turned on. After an hour of Googling on
something that relates to CAP_SYS_BOOT and makes sense within the
context of SELinux. 

I came up with a reference in the old SELinux Policy Editor page that
indicates you could set a "boot system call" check-box
To check this allows the current domain to use the "reboot" system call.
This corresponds to the capability "CAP_SYS_BOOT" in Linux system.

The page also go on to say that SELinux Policy Editor is for 2.4 Kernel
only ...

Can someone give me some info on making this work?

Nix

-- 
Nick Gray
Senior Systems Engineer
Bruzenak Inc
Office: 512-331-7998
Cell: 512-630-7009


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
