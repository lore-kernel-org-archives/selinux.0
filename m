Message-Id: <200212171725.MAA01304@moss-shockers.ncsc.mil>
Date: Tue, 17 Dec 2002 12:25:33 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Domain transition -- enabling user_r in eklogin
To: fw@fwsystems.com
Cc: russell@coker.com.au, SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> avc:  denied  { ioctl } for  pid=142 exe=/bin/bash path=/dev/tty1 dev=08:02 
ino=22757 scontext=system_u:system_r:user_t 
tcontext=system_u:object_r:tty_device_t tclass=chr_file
> avc:  denied  { ioctl } for  pid=142 exe=/bin/bash path=/dev/tty1 dev=08:02 
ino=22757 scontext=system_u:system_r:user_t 
tcontext=system_u:object_r:tty_device_t tclass=chr_file

This looks like you aren't using the SELinux-patched login program.
The login process needs to set the security context for the user session
and to relabel the tty based on that security context.  If you use an
unmodified login, you'll get the behavior above.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
