Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA03950
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 14:09:01 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA07932
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 19:05:34 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA07927
	for <selinux@tycho.nsa.gov>; Mon, 3 Mar 2003 19:05:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy, third pass
Date: Mon, 3 Mar 2003 20:08:38 +0100
Cc: selinux@tycho.nsa.gov
References: <200303031838.NAA18412@moss-shockers.ncsc.mil>
In-Reply-To: <200303031838.NAA18412@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303032008.38268.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 3 Mar 2003 19:38, Stephen D. Smalley wrote:
> grouping related network utilities together, we might want to see
> whether each of ping.te and traceroute.te might be folded into one of
> the resulting domains.  However, it may be desirable to keep them
> separate from each other due to differences in their permission sets.

Another thing to consider is that it is sometimes desirable to allow pinging 
in situations where you don't necessarily wish to allow traceroute.

Many daemons spawn ping, but don't need to be able to spawn traceroute.  
Although allowing a program such as dhcpd to run traceroute probably isn't a 
big deal.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
