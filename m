Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i42Gl9Rb001198
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 12:47:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i42GirZx008815
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 16:44:54 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i42GiqJv008776
	for <selinux@tycho.nsa.gov>; Sun, 2 May 2004 16:44:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: Policy file for 'aide' and/or 'tripwire'?
Date: Mon, 3 May 2004 02:45:39 +1000
Cc: Valdis.Kletnieks@vt.edu, selinux@tycho.nsa.gov
References: <200404271752.i3RHqC8E015562@turing-police.cc.vt.edu>
In-Reply-To: <200404271752.i3RHqC8E015562@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405030245.39737.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Apr 2004 03:52, Valdis.Kletnieks@vt.edu wrote:
> Has anybody already done a policy file for Tripwire or its
> open-sourced replacement 'aide'?

Why not run it in the domain backup_t?  Tripwire and backup programs both need 
read access to all files...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
