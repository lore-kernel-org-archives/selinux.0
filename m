Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA07965
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 13:28:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA23272
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 17:27:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id RAA23268 for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 17:27:18 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B90A992466
	for <selinux@tycho.nsa.gov>; Wed, 14 Aug 2002 03:28:51 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 50EB3C68
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 19:28:43 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: woody packages, chroot, etc
Date: Tue, 13 Aug 2002 19:28:42 +0200
MIME-Version: 1.0
Message-Id: <20020813172843.50EB3C68@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

deb http://www.coker.com.au/woody/ ./

If you add the above to your /etc/apt/sources.list file then it'll download 
woody packages for SE Linux.  Currently all I have is devfsd, but shortly 
I'll start back-porting all my packages to woody.

I've not got my chroot policy working almost perfectly and have a fully 
functional woody chroot setup.

I found that I could not get pseudo-tty's working correctly unless I did a 
bind mount of all of devfs, it seems that the library call grantpt() in that 
sshd is calling does a statfs() on /dev/pts and /dev, when it finds that 
/dev/pts is devfs and /dev is not then it aborts.  :(

The problem with this is that /dev/log is the same as the main /dev/log.  To 
solve this I made /dev/log a symlink pointing at /var/run/log, and then made 
syslogd start with "-p/var/run/log" in both the chroot and the main 
environment.

The problem with this is that the file_type_auto_trans() macro doesn't allow 
different types for different object classes.  So I extended the 
file_type_auto_trans() macro to take an optional type parameter and I changed 
the syslog policy to match with different rules for "file" and "sock_file" 
classes.

I've put the policy in the usual place for those who are interested.

Also my new mail server policy is working well.  The two most important 
servers I run are using it now.  I hope that Steve will accept this change 
into his CVS tree before the next release - I think it's worthy.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
