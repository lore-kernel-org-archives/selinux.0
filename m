Message-ID: <3F88FAEB.8000707@cisco.com>
Date: Sat, 11 Oct 2003 23:55:39 -0700
From: Michael Reilly <michaelr@cisco.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: How to get Xfree86 to run - old API
References: <sf880644.030@atlas.snu.edu>
In-Reply-To: <sf880644.030@atlas.snu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When trying to run the Xfree86 server using startx as michaelr:sysadm_r:sysadm_t

the server does not startup.  This message is displayed

Fatal server error:
xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)

Looking at /dev/tty0

ls --context /dev/tty0
crw-------  michaelr staff    system_u:object_r:tty_device_t   /dev/tty0

And the server -

ls --context /usr/X11R6/bin/X
lrwxrwxrwx  root     root     system_u:object_r:xserver_exec_t 
/usr/X11R6/bin/X -> XFree86

ls --context /usr/X11R6/bin/XFree86
-rws--x--x  root     bin      system_u:object_r:xserver_exec_t 
/usr/X11R6/bin/XFree86

Nothing is printed in syslog - no avc deneid nor anything else.

How can I determine what is wrong and fix it?  What should I look at next?

Thanks,

michael
-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
     Cisco Systems, Santa Cruz, CA


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
