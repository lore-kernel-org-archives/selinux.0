Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9UNluWt016515
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 18:47:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9UNlcC7021463
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 23:47:38 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h9UNlQuw021447
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 23:47:30 GMT
Date: Fri, 31 Oct 2003 10:47:12 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user's access to files in their own home directory
Message-ID: <20031030234711.GA31194@snoopy.apana.org.au>
References: <200310310610.14859.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310310610.14859.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 31, 2003 at 06:10:14AM +1100, Russell Coker wrote:
> So far in writing the policy I have allowed the user full access to files in 
> their own home directory, with the exception of gpg where secrecy requires 
> that the user's processes often be denied read access.
> 
> I would like some feedback on how people feel about having files/dirs under a 
> user's home directory that they can't unlink or rename.

This would seem to imply a useability/security tradeoff that is
dependant on the security requirements of the computer.

However, what files/dirs are you thinking of?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
