Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11DQK53015153
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 08:26:20 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j11DQKYD011633
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 13:26:22 GMT
Subject: Re: File Browsing apps and getattr
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>
References: <1107210369.1928.5.camel@cobra.ivg2.net>
	 <1107259894.26936.27.camel@moss-spartans.epoch.ncsc.mil>
	 <1107263308.6722.5.camel@cobra.ivg2.net>
	 <1107263499.26936.50.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 06:26:24 -0700
Message-Id: <1107264384.6956.2.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > "These  functions  return information about the specified file.  You do
> > not need any access rights to the file to get this information but you
> > need search rights to all directories named in the path leading to the
> > file."
> 
> Yes, that is in the absence of mandatory access control.  Properties of
> the file should be protected in accordance with the security label of
> the file, not the parent directory.  The name is part of the directory
> state, but the stat(2) information is part of the inode state.

Why is the stat() information so important for security?
If you won't do this, how do you plan to address the denials I have
posted about? 

Will you leave ls in this state:

[phantom@cobra ~]$ ls -l /var
total 112
?---------   ? ?    ?       ?            ? account
drwxr-xr-x  10 root root 4096 Jan 16 05:33 cache
drwxr-xr-x   3 root root 4096 Oct 19 13:20 db
drwxr-xr-x   3 root root 4096 Aug 12 11:02 empty
?---------   ? ?    ?       ?            ? gdm
drwxr-xr-x  24 root root 4096 Jan 16 05:33 lib
drwxr-xr-x   2 root root 4096 Aug 12 11:02 local
?---------   ? ?    ?       ?            ? lock
drwxr-xr-x  13 root root 4096 Feb  1 04:02 log
?---------   ? ?    ?       ?            ? mail
?---------   ? ?    ?       ?            ? named
drwx------   2 root root 4096 Dec  1 13:49 net-snmp
drwxr-xr-x   2 root root 4096 Aug 12 11:02 nis
drwxr-xr-x   2 root root 4096 Aug 12 11:02 opt
drwxr-xr-x   2 root root 4096 Aug 12 11:02 preserve
drwxr-xr-x  18 root root 4096 Feb  1 06:16 run
drwxr-xr-x  14 root root 4096 Aug 12 11:02 spool
drwxrwxrwt   2 root root 4096 Feb  1 06:16 tmp
drwxr-xr-x  12 root root 4096 Jan 11 19:28 www
?---------   ? ?    ?       ?            ? yp
[phantom@cobra ~]$

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
