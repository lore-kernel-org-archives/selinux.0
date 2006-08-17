Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7HKDIuM019878
	for <selinux@tycho.nsa.gov>; Thu, 17 Aug 2006 16:13:18 -0400
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7HKCqHE024052
	for <selinux@tycho.nsa.gov>; Thu, 17 Aug 2006 20:12:53 GMT
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 17 Aug 2006 22:13:16 +0200
From: selinux770@tortenboxer.de
Message-ID: <20060817201316.112230@gmx.net>
MIME-Version: 1.0
Subject: Controlling term: unknown (Operation not supported)
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi once again, sorry for not putting a subject into my last email. Bad start on this list. So let's start over:

I'm trying to enable SELinux on my Nokia 770 Internet Tablet which is running a modified Debian Linux for ARM processors. Until now I have replaced and installed several files and packages, but now I need further guidance. It seems like SELinux is working in some kind of way. But one main problem/question that persists is that i get a
Controlling term:               unknown (Operation not supported)
when doing a sestatus -v.

The "Current context" for user root is system_u:system_r:sshd_t when i log in via ssh.
(uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:kernel_t)

Within the device (when opening a console or whatever) the "Current context" is system_u:system_r:kernel_t.
(uid=0(root) gid=0(root) groups=0(root) context=system_u:system_r:kernel_t)
Just as many other (nearly all) processes, too.

So my questions:
1. What is the controlling term in sestatus for? What does it mean if it's unknown and how bad is this problem?
2. Are the wrong contexts of users a policy based problem or are they derived by the problem with the controlling term (or even orthers)? I need to know this since I changed much on the device for SELinux and now I'm not sure if I should continue searching missing functionalities within the system or searching for errors in the policy or file labelling.

If you need any more information feel free to ask.

Thanks in advance
Roland Bender

Further information:
~# sestatus -v
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          enforcing
Policy version:                 19
Policy from config file:        .

Process contexts:
Current context:                system_u:system_r:sshd_t
Init context:                   system_u:system_r:init_t

File contexts:
Controlling term:               unknown (Operation not supported)
/etc/passwd                     system_u:object_r:etc_t
/etc/shadow                     system_u:object_r:shadow_t
/bin/bash                       system_u:object_r:shell_exec_t -> system_u:object_r:shell_exec_t
/bin/login                      system_u:object_r:login_exec_t
/bin/sh                         system_u:object_r:bin_t -> system_u:object_r:shell_exec_t
/sbin/init                      system_u:object_r:init_exec_t
/var/lib/install/sbin/sshd      system_u:object_r:sshd_exec_t
/lib/libc.so.6                  system_u:object_r:lib_t -> system_u:object_r:shlib_t
/lib/ld-linux.so.2              system_u:object_r:lib_t -> system_u:object_r:ld_so_t

~# uname -r
2.6.12.3-omap1
-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
