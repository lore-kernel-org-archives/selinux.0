Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA28162
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 21:39:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA03079
	for <selinux@tycho.nsa.gov>; Fri, 30 Aug 2002 01:38:08 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id BAA03075
	for <selinux@tycho.nsa.gov>; Fri, 30 Aug 2002 01:38:06 GMT
Date: Fri, 30 Aug 2002 11:38:51 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tislabs.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: devfs change, trivial patches, netscape & x patches
Message-ID: <20020830013851.GA29593@snoopy.apana.org.au>
References: <Pine.GSO.4.33.0208270946320.11201-100000@raven> <20020827144612.A22212355@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020827144612.A22212355@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 27, 2002 at 04:46:12PM +0200, Russell Coker wrote:
> > 2) oav-update.te:  There was a spurious amavisd rule in this file, likely
> > a cut-and-paste error.  Removed.
> 
> I've CC'd Brian, it's his policy.

I have looked for that error in my oav-update.te file, but can't find
it.

"grep amavis domains/program/oav-update.te" returns no results
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
