Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9CNhvWt012029
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2003 19:43:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9CNhp0p001428
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2003 23:43:51 GMT
Received: from mta06-svc.ntlworld.com (mta06-svc.ntlworld.com [62.253.162.46])
	by jazzswing.ncsc.mil  with ESMTP id h9CNhpr7001425
	for <selinux@tycho.nsa.gov>; Sun, 12 Oct 2003 23:43:51 GMT
Message-ID: <3F89E737.7090004@hotmail.com>
Date: Mon, 13 Oct 2003 00:43:51 +0100
From: James de Lurker <jtl2nospamMUNGIEjump@hotmail.com>
Reply-To: see.the.sig.2.reply.by.email.offlist@hotmail.com
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [patch] 2.6.0-test7-selinux1
References: <1065712103.8181.266.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09 Oct 2003 at 11:08:23 UT -0400  Stephen Smalley wrote:
> 2.6.0-test7 has been released and includes the following SELinux-related
> changes:
[..]

> Patch against 2.6.0-test7 follows.

I just can't get this to apply cleanly. I assume that the reference here is
the standard kernel.org linux-2.6.0-test7 ?

I copied the patch out of the email to a patch file, as below

Testing with:

patch -p0 --verbose --dry-run <2.6.0-test7-selinux1-list.patch 
 >260t7patch-KORef.txt 2>&1


It complains in these places:
[..]
|Index: linux-2.6/security/selinux/avc.c
|diff -u linux-2.6/security/selinux/avc.c:1.1.1.2 
linux-2.6/security/selinux/avc.c:1.35
|--- linux-2.6/security/selinux/avc.c:1.1.1.2    Mon Aug 25 10:58:08 2003
|+++ linux-2.6/security/selinux/avc.c    Wed Sep 24 12:15:25 2003
--------------------------
Patching file linux-2.6/security/selinux/avc.c using Plan A...
Hunk #1 FAILED at 575.
1 out of 1 hunk FAILED -- saving rejects to file 
linux-2.6/security/selinux/avc.c.rej

[..]
|Index: linux-2.6/security/selinux/selinuxfs.c
|diff -u linux-2.6/security/selinux/selinuxfs.c:1.1.1.3 
linux-2.6/security/selinux/selinuxfs.c:1.32
|--- linux-2.6/security/selinux/selinuxfs.c:1.1.1.3      Mon Sep 29 
09:14:40 2003
|+++ linux-2.6/security/selinux/selinuxfs.c      Fri Oct  3 16:01:16 2003
--------------------------
Patching file linux-2.6/security/selinux/selinuxfs.c using Plan A...
Hunk #1 FAILED at 37.
Hunk #2 succeeded at 126 with fuzz 2.
Hunk #3 FAILED at 609.
2 out of 3 hunks FAILED -- saving rejects to file 
linux-2.6/security/selinux/selinuxfs.c.rej

[..]
Patching file linux-2.6/security/selinux/ss/policydb.h using Plan A...
Hunk #1 succeeded at 225.
Hmm...  Ignoring the trailing garbage.
done

Advise please. I'm about to build another trial system, and would prefer
to try out the later test7 kernel if possible. Target system is an i586
box with a command line only upgraded install of RedHat 9. Desktop system
used for patching and configuring kernels is a RedHat 7.2 box.

-- 

   -- James

 From and Reply To are INVALID.

All public postings use munged headers[1]- To contact me off list:
   1) Remove "M U N G I E j u m p" ONLY: leave that "nospam" in there!
   2) change "hotmail" 2 "myrealbox" after the @



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
