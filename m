Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA25736
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 11:32:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PGWeI17719
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 16:32:40 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h1PGWdf17715 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 16:32:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>
Subject: Re: Core policy
Date: Tue, 25 Feb 2003 17:32:25 +0100
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0302250628140.1479-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0302250628140.1479-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302251732.25555.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 25 Feb 2003 12:35, Wayne Salamon wrote:
> I also thought of a #DEPENDS tag, but I'm not sure how well it would be
> maintained by the policy writers. What would be nice is to have some way
> of annotating policy file relationships in a modular way; possibly an
> #IMPORTS tag that means something to the compiler. If a policy file uses a
> type defined in another file, unless that file is imported, it's an error.
> The goal is to have more control over the relationships between policy
> components.

Surely #IMPORTS or #DEPENDS would work equally well.

As for raising an error, it should be either treated as a warning, an error, 
or ignored depending on command line options.  I think that most people won't 
want to maintain such things when they modify their own policy files.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
