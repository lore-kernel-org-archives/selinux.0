Message-ID: <72222DC86846D411ABD300A0C9EB08A10152434C@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: SELinux@tycho.nsa.gov
Cc: "'russell@coker.com.au'" <russell@coker.com.au>,
        "'sds@tislabs.com'"
	 <sds@tislabs.com>,
        "'hdholm@epoch.ncsc.mil'" <hdholm@epoch.ncsc.mil>
Subject: RE: Generic SELinux Package
Date: Thu, 18 Apr 2002 11:42:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

More on The Generic Package

>From log file messages


Apr 18 10:46:07 localhost kernel: NET4: Unix domain sockets 1.0/SMP for
Linux NET4.0.
Apr 18 10:46:07 localhost kernel: ds: no socket drivers loaded!
Apr 18 10:46:07 localhost kernel: RAMDISK: Compressed image found at block 0
Apr 18 10:46:07 localhost kernel: Freeing initrd memory: 445k freed
Apr 18 10:46:07 localhost kernel: VFS: Mounted root (ext2 filesystem).
Apr 18 10:46:07 localhost kernel: security:  starting up (compiled Apr 18
2002)
Apr 18 10:46:07 localhost kernel: security:  loading policy configuration
from /ss_policy
Apr 18 10:46:07 localhost kernel: security:  5 users, 5 roles, 406 types
Apr 18 10:46:07 localhost kernel: security:  29 classes, 43869 rules


The ram disk must have the /ss_policy to boot. The question I am not
understanding
from the log messages. I see the RAMDISK freed and the root filesystem
mounted
then security loads the /ss_policy. Which policy is the selinux really using
?
in an off line mail conversion with Stephen Smalley he stated the ramdisk is
the
one. The question is why ?


Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
