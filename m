Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux@tycho.nsa.gov
Subject: distribution of kernel patches
Date: Fri, 28 Sep 2001 18:47:55 +0200
MIME-Version: 1.0
Message-Id: <20010928180800.00E31334E9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I believe that the current method of distributing the kernel code could be
improved by supplying it as either a single patch, or a tar file with a tiny
patch.

Most kernel code is distributed in the form of a unified diff.  This form is
easy to separate from other related code (often we need kernel code and
user-space code separate for compilation on different machines).  It is easy
to manipulate in scripts (such as for the Debian packages I am preparing),
and is easy to combine with other patches.

A tar file and a small patch would also be easy to deal with.

The current situation of having a Makefile which applies a patch, creates
sym-links, etc makes it virtually impossible to automatically do anything
with the code.  This means I can't use pure upstream source in my
kernel-patch package which adds a risk of error, and makes it more difficult 
for anyone who wants to audit my work.

Could the management of the kernel patch be changed in the next release?


Also could the kernel patch please change the EXTRAVERSION variable in the 
top-level makefile?  Currently the kernel-patch package I am playing with 
changes it from "-lsm" to "-selinux", but it would be equally valid to change 
it to "-lsm-selinux" instead.  I believe that a change to the EXTRAVERSION is 
necessary for anyone who is attempting to manage kernel builds for 
dis-similar machines.  The results of installing a non-SE kernel when you 
want a SE kernel or of installing a SE kernel when you want a non-SE kernel 
are both unpleasant!


PS  Anyone who wants a pre-release Debian kernel-patch-2.4.10-selinux package 
please contact me off-list.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
