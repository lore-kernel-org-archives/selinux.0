Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: /var/lock
Date: Fri, 13 Sep 2002 20:39:59 +0200
MIME-Version: 1.0
Message-Id: <200209132039.59879.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently to run minicom you have to be in sysadm_r, minicom needs to create a 
lock file under /var/lock which needs sysadm_t.

This is wrong.

I am thinking of adding a user_lock_t file type for this purpose.

Also it would need a userlock attribute for allowing appropriate programs to 
unlink the lock files.

I also thought of giving system programs (such as pppd) the ability to unlink 
userlock files so that they can break locks.  However this would also require 
access to kill the user_t processes which hold the locks, and is possibly 
undesirable.

What do you think?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
