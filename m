Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1K74uok019329
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 02:04:56 -0500
Received: from rv-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1K71WwQ017197
	for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2009 07:01:32 GMT
Received: by rv-out-0708.google.com with SMTP id f25so882395rvb.54
        for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2009 23:04:54 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 19 Feb 2009 23:04:54 -0800
Message-ID: <dd18b0c30902192304w76b8c2ebt1f0954d2d5cb903b@mail.gmail.com>
Subject: ext3 security labels missing
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've a strange issue.
with my experimental learning machine(LFS)
I'm able to load the policy etc.. but have no labels
on my files.(just a question mark);


ls -lZ shows

drwxr-xr-x   2 root root ?  4096 Feb 18 11:19 bin
drwxr-xr-x   3 root root ?  4096 Feb 19 22:36 boot
lrwxrwxrwx   1 root  999 ?    11 Feb  9 16:34 cdrom -> media/cdrom
drwxr-xr-x  17 root root ?  4120 Feb 19 22:42 dev
drwxr-xr-x  28 root root ?  4096 Feb 19 22:47 etc
drwxr-xr-x   4 root root ?  4096 Feb 19 22:36 home
drwxr-xr-x   4 root root ?  4096 Feb 18 11:19 include
drwxr-xr-x  10 root root ?  4096 Feb 19 18:52 lib
drwx------   2 root root ? 16384 Feb  9 16:34 lost+found
drwxr-xr-x   3 root root ?  4096 Feb 19 22:42 media
drwxr-xr-x   3 root root ?  4096 Feb 11 12:09 mnt
drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 opt
dr-xr-xr-x 113 root root ?     0 Feb 19 22:42 proc
drwxr-xr-x   5 root root ?  4096 Feb 18 11:24 root
drwxr-xr-x   2 root root ?  4096 Feb 19 21:11 sbin
drwxr-xr-x   7 root root ?     0 Feb 19 22:42 selinux
drwxr-xr-x   8 root root ?  4096 Feb 18 11:19 share
drwxr-xr-x   2 root root ?  4096 Feb 10 09:54 srv
drwxr-xr-x  12 root root ?     0 Feb 19 22:42 sys
drwxrwxrwt   5 root root ?  4096 Feb 19 22:50 tmp
drwxr-xr-x   6 root root ?  4096 Feb 11 12:05 tools
drwxr-xr-x  14 root root ?  4096 Feb 14 10:09 usr
drwxr-xr-x  10 root root ?  4096 Feb 18 22:31 var
lrwxrwxrwx   1 root root ?    24 Feb 10 13:11 vmlinuz ->
/boot/vmlinuz-2.6.29-rc4

if I do a id -Z I get:
id: --context (-Z) works only on an SELinux-enabled kernel
(but it is enabled in the kernel)

>From looking back, I enabled as much as possible in any app/lib I was compiling
that provided selinux support.(libc,xserver,hal,dbus, etc..);
But could be missing an important app/lib that might make the security labels
give the proper label. by chance if anybody had experienced this and/or knows
what might be going on,(would be really appreciated).

regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
