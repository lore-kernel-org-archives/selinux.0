Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA22369
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 19:37:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA02744
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 23:36:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA02740 for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 23:36:02 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new debian SE Linux packages
Date: Tue, 16 Apr 2002 01:36:44 +0200
Cc: Debian Devel <debian-devel@lists.debian.org>
MIME-Version: 1.0
Message-Id: <20020415233645.44387198@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have uploaded a new kernel-patch-2.4-lsm package that implements the V9 
policy format and uses /etc/security/selinux to store it.  I have also 
uploaded a matching "selinux" package that will compile to the same format.

With the location change the upgrade path will be a lot smoother.  If you 
want to upgrade from V8 policy to V9 then you should first install the 
"selinux" package and tell it to install the policy (you can't load the 
policy into a V8 kernel because of format differences).

Then at that time you will have both V8 and V9 policy databases installed in 
different locations, when you boot the kernel will select the appropriate 
policy database.

After that you can compile, install, and boot a kernel for a V9 policy at 
your leisure (but you will be unable to recompile the policy for the V8 
kernel with the latest "selinux" package).


Now the problem I have is that I want it to be possible to compile a V8 and a 
V9 policy database at the same time for easy upgrade support (you don't 
generally do a quick kernel upgrade on the type of machine you run SE Linux 
on).

What I plan to do is to split out the checkpolicy program (the program that 
compiles the ASCII policy file into the database) into a separate package 
with a name based on it's version number.  Then it'll be possible to have 
multiple versions installed at the same time.  As this program depends on 
both the kernel source package and the selinux-small source package in a 
version-dependant fashion it will be impossible to have multiple versions be 
buildable by auto-builders.  I plan to keep packages of old versions of the 
checkpolicy package for i386 on my web site.

If anyone has a better solution to this then please make suggestions.


PS  For the Debian people who are getting a bad opinion about SE Linux, most 
of the strange stuff I discussed before (like diverting start-stop-daemon and 
hacking devfsd) was backed out long before I started uploading the packages 
to unstable.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
