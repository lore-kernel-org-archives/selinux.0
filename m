Subject: Re: Error!  Shell is not valid.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070109123122.248320@gmx.net>
References: <20070109123122.248320@gmx.net>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 07:36:41 -0500
Message-Id: <1168346201.7993.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-09 at 13:31 +0100, selinux770@tortenboxer.de wrote:
> Hi there.
> 
> I'm still trying to enable SELinux no my Linux system. Seems to work in some way, but a strange error remains.
> 
> When I want to login via ssh to the system, "newrole" does not work.
> 
> Looks like this:
> 
> ~$ ssh anna@selinux
> anna@selinux's password:
> selinux:~$ newrole -r im_user_r
> Error!  Shell is not valid.
> selinux:~$ ps axZ |grep anna
> system_u:system_r:sshd_t	1160	?	Ss	0:00	sshd: anna [priv]
> system_u:system_r:sshd_t	1162	?	S	0:00	sshd: anna@pts/1
> anna:user_r:user_t		1163	pts/1	Ss	0:00	-bash
> anna:user_r:user_t		1179	pts/1	R+	0:00	ps axZ
> anna:user_r:user_t		1180	pts/1	S+	0:00	grep anna
> 
> What does this mean? As you can see, the shell is bash; /etc/passwd specified to be found in /bin/bash
> selinux:~$ ls -Z /bin/bash
> lrwxrwxrwx	root	root	system_u:object_r:bin_t		/bin/bash
> linked to
> selinux:~$ ls -Z /usr/bin/bash
> -rwxr-xr-x	root	root	system_u:object_r:bin_t		/usr/bin/bash
> 
> What is the problem? How do I make a shell "valid"?
> Or, at least, (create a rule to) bypass this error (even if it's insecure).
> If you need more information, please ask.

newrole calls getusershell(3), which reads from /etc/shells or falls
back to system defaults if it is not present (/bin/sh and /bin/csh per
the man page).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
