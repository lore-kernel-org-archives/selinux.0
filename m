Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: trivial logging bug
Date: Mon, 30 Sep 2002 20:04:38 +0200
MIME-Version: 1.0
Message-Id: <200209302004.38709.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  denied  { rmdir } for  pid=9631 exe=/bin/rm path=/rjc/.ssh/old (deleted) 
dev=03:07 ino=3406 scontext=rjc:user_r:user_t 
tcontext=system_u:object_r:user_home_ssh_t tclass=dir

The above is from an rmdir operation.  It seems that the dentry gets updated 
with the new name BEFORE the operation is permitted so we get (deleted) in 
the log message which is confusing.

I think that perhaps the logging code should be changed to remove the last 10 
characters of the file name.

However maybe it would be more correct in terms of code operation to have the 
check earlier?  (I don't know I haven't looked at the code in question).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
