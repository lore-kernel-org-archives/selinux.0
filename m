Date: Sun, 9 Oct 2005 15:34:26 +0700
From: Dave Patterson <sdpatt2@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: System hang during boot on Debian Sid
Message-ID: <20051009083426.GA10995@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With kernel 2.6.13.3 with NSA patch applied the options
CONFIG_DEVPTS_FS_XATTR and CONFIG_DEVPTS_FS_SECURITY disappear.  Or
have gone somewhere...

Compiling while ignoring these two options and booting selinux=1 in
grub I get ...

SELinux initialized (dev sysfs type sysfs) uses genfs contexts

and the system hangs.  Any suggestions?


-- 
Regards, Dave
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
