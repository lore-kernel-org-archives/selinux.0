Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA09221
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 12:44:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA25587
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 17:42:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA25582
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 17:42:28 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AA77592668
	for <selinux@tycho.nsa.gov>; Wed,  4 Dec 2002 04:44:41 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E3B71BE30
	for <selinux@tycho.nsa.gov>; Tue,  3 Dec 2002 18:44:32 +0100 (CET)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: get_ordered_sid_list
Date: Tue, 3 Dec 2002 18:44:32 +0100
References: <200212031600.LAA26035@moss-shockers.ncsc.mil>
In-Reply-To: <200212031600.LAA26035@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200212031844.32531.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Dec 2002 17:00, Stephen D. Smalley wrote:
> get_ordered_sid_list only returns legal SIDs for the user that
> are reachable from the specified from_sid (or the current SID
> by default when from_sid is 0).  In the example policy, xdm_t
> can only transition to unpriv_userdomain, so it can reach user_t
> but not sysadm_t.

Before anyone asks, this was done for a reason.  An xdm login runs all sorts 
of scripts that you probably don't want to have running with full 
administrative privs.  Also after looking through the xdm/kdm source it's not 
something I'd trust as much as /bin/login...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
