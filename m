Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA13200
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2002 15:51:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA03097
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2002 20:50:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA03093 for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2002 20:50:41 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 18E0292443
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 07:51:38 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 4BB5519FE7
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2002 21:31:49 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: package configuration (for dpkg - rpm will have the same issues)
Date: Thu, 14 Mar 2002 18:28:22 +0100
MIME-Version: 1.0
Message-Id: <20020314203149.4BB5519FE7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When a package is installed in Debian scripts are run before and after the 
installation.  Among other things the pre-install script will often stop a 
daemon and the post-install script will start it again.

The problem comes when some scripts start daemons in such a fashion that the 
start script can't get standard input for run_init...

To solve this I was thinking of having an automatic transition from sysadm_t 
to dpkg_t when dpkg_exec_t programs are run.  Then there would be an 
automatic transition from dpkg_t when running initrc_exec_t binaries (all the 
start scripts) which stops run_init from needing a password.

What do you think of this idea?

If no-one comes up with a flaw in this idea then I'll implement it, and then 
it can be copied to an rpm script (both dpkg and rpm perform the same tasks 
using similar methods so their configuration should be very similar).

Also of course I'll set it up such that only dpkg can change it's own 
database etc (the usual boring things).

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
