Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8AJnerT021181
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 15:49:40 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8AJndl6017970
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 19:49:39 GMT
Subject: Re: Unexpected behaviour with SELinux.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4141FF4C.2030602@redhat.com>
References: <4141FF4C.2030602@redhat.com>
Content-Type: text/plain
Message-Id: <1094845654.29997.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Sep 2004 15:47:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-10 at 15:23, Daniel J Walsh wrote:
> On both strict and targetd policy.
> 
> ldd /usr/sbin/named gives no output.
> 
> ldd must be starting up the daemon and transitioning to it and can not 
> write output to the terminal.

Yes, at present, it appears that ldd is running the program with a set
of LD_* variable settings, so when sysadm_t runs ldd and
direct_sysadm_daemon is enabled, it will transition to the daemon domain
and lose access to the terminal.  Question:  Why doesn't ldd run the
program via ld.so and thus avoid the domain transition, e.g.

--- /usr/bin/ldd	2004-09-04 08:53:30.000000000 -0400
+++ ldd	2004-09-10 15:44:01.219386464 -0400
@@ -154,7 +154,7 @@
     fi
     case $ret in
     0)
-      eval $add_env '"$file"' || result=1
+      eval $add_env \${RTLD} '"$file"' || result=1
       ;;
     1)
       # This can be a non-ELF binary or no binary at all.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
