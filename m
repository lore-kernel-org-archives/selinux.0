Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA00579
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 09:24:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA18678
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 14:21:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA18673
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 14:21:07 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 77CA292569
	for <selinux@tycho.nsa.gov>; Tue,  4 Mar 2003 01:24:20 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 47D83743
	for <selinux@tycho.nsa.gov>; Mon,  3 Mar 2003 15:24:13 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fwd: Re: SE play machine
Date: Mon, 3 Mar 2003 15:24:12 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MW2Y+0Pv8Q7Q8nS"
Message-Id: <200303031524.12794.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_MW2Y+0Pv8Q7Q8nS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_MW2Y+0Pv8Q7Q8nS
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 8bit
Content-Description: Russell Coker <russell@coker.com.au>: Re: SE play machine

From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SE play machine
Date: Mon, 3 Mar 2003 15:23:49 +0100
User-Agent: KMail/1.5
References: <200303031414.JAA18269@moss-shockers.ncsc.mil>
In-Reply-To: <200303031414.JAA18269@moss-shockers.ncsc.mil>
X-KMail-Link-Message: 138545156
X-KMail-Link-Type: reply
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303031523.49483.russell@coker.com.au>
Status: RO
X-Status: S
X-KMail-EncryptionState: 
X-KMail-SignatureState: 

On Mon, 3 Mar 2003 15:14, Stephen D. Smalley wrote:
> sshd_t to sysadm_t as in the example policy), then you might want a
> second unprivileged user role and domain for the initial login of
> administrators that can be protected from user_r:user_t and that
> can transition to sysadm_r:sysadm_t via newrole.

True.  This is one of the uses of the staff_r role that I have as comments 
currently in my policy tree.  I have been thinking of making it part of the 
default policy for my tree and submitting it for inclusion in your tree.

Currently I have too many of my policy patches in progress at the moment so 
I'm not submitting any more for now.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_MW2Y+0Pv8Q7Q8nS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
