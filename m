Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA29218
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 16:55:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA13640
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 21:51:52 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA13636
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 21:51:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
        wsalamon@tislabs.com
Subject: Re: Core policy
Date: Tue, 25 Feb 2003 22:54:53 +0100
References: <200302251541.KAA15178@moss-shockers.ncsc.mil>
In-Reply-To: <200302251541.KAA15178@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302252254.53288.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Feb 2003 16:41, Stephen D. Smalley wrote:
> merely express the common case).  In contrast, every_domain does not
> provide any useful abstraction and merely conceals many permissions.
> Some of its finer-grained macros might be ok (e.g.
> general_domain_access) while others need to be split up further or
> eliminated entirely.  Likewise, can_exec_any should likely be
> eliminated entirely.

I think that the reason that not much has been done on this issue is that the 
macros in question have to be removed from the main tree.

Once those macros get removed from the main tree I'll copy the change into my 
tree and start work on fixing whatever breaks (and I'm sure that other people 
will do the same).

While things are working moderately well I'm not in a hurry to make such 
changes on my own.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
