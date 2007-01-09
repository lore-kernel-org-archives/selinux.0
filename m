Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09CUZcA000961
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 07:30:35 -0500
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l09CVNeY016604
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 12:31:23 GMT
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 09 Jan 2007 13:31:22 +0100
From: selinux770@tortenboxer.de
Message-ID: <20070109123122.248320@gmx.net>
MIME-Version: 1.0
Subject: Error!  Shell is not valid.
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi there.

I'm still trying to enable SELinux no my Linux system. Seems to work in some way, but a strange error remains.

When I want to login via ssh to the system, "newrole" does not work.

Looks like this:

~$ ssh anna@selinux
anna@selinux's password:
selinux:~$ newrole -r im_user_r
Error!  Shell is not valid.
selinux:~$ ps axZ |grep anna
system_u:system_r:sshd_t	1160	?	Ss	0:00	sshd: anna [priv]
system_u:system_r:sshd_t	1162	?	S	0:00	sshd: anna@pts/1
anna:user_r:user_t		1163	pts/1	Ss	0:00	-bash
anna:user_r:user_t		1179	pts/1	R+	0:00	ps axZ
anna:user_r:user_t		1180	pts/1	S+	0:00	grep anna

What does this mean? As you can see, the shell is bash; /etc/passwd specified to be found in /bin/bash
selinux:~$ ls -Z /bin/bash
lrwxrwxrwx	root	root	system_u:object_r:bin_t		/bin/bash
linked to
selinux:~$ ls -Z /usr/bin/bash
-rwxr-xr-x	root	root	system_u:object_r:bin_t		/usr/bin/bash

What is the problem? How do I make a shell "valid"?
Or, at least, (create a rule to) bypass this error (even if it's insecure).
If you need more information, please ask.

Thanks in advance
Roland Bender



-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
