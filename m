Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3MGQ2I4026404
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 12:26:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3MGPuVf023869
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 16:25:56 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3MGPt4D023866
	for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2003 16:25:56 GMT
Subject: Re: Fwd: Bug#189251: oops, cosmetics
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, Peter Gervai <grin@tolna.net>
In-Reply-To: <200304162233.47714.russell@coker.com.au>
References: <200304162233.47714.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1051028724.14761.66.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Apr 2003 12:25:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-16 at 08:33, Russell Coker wrote:
> If you have a file named "a+++b" or some other name that is a regex wildcard 
> then newrules.pl does not handle AVC messages referring to it correctly.  
> This patch fixes that, and I've applied it to my Debian package already.

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
