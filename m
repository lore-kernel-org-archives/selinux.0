Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i65J1prT026113
	for <selinux@tycho.nsa.gov>; Mon, 5 Jul 2004 15:01:51 -0400 (EDT)
Received: from snowstorm.hosts.ndo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i65J1nUd004727
	for <selinux@tycho.nsa.gov>; Mon, 5 Jul 2004 19:01:49 GMT
Date: Mon, 5 Jul 2004 18:58:22 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: cifs_t
Message-ID: <20040705185822.GC3279@lkcl.net>
References: <200407052352.53439.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407052352.53439.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

CIFS is the protocol (common internet file system).
also known as SMB (server message block).

there are two open source CIFS server projects currently available.

three.

1) cliffs - an experimental project where the majority of the network
   traffic is parsed with some auto-generated code.

2) samba - the original open source smb server.

3) samba-tng - a fork of 2) which splits the incredible number of
   protocols implemented in samba out into separate services.

so yes, like postfix+exim+sendmail+etc all implement SMTP,
it'd be good to have a cifs_t type recognising the use of ports
445 and 139 (not counting 135 for dce/rpc portmapping, not counting
137 for WINS / Network Neighbourhood, not counting 138 for the
NetBIOS-equivalent of UDP traffic... i _did_ say there were a 
lot of protocols implemented in samba didn't i :)

l.

On Mon, Jul 05, 2004 at 11:52:53PM +1000, Russell Coker wrote:
> typealias sambafs_t alias cifs_t;
> 
> What is the benefit of the above?
> 
> If we are going to make cifs_t the new name for what is currently sambafs_t 
> then surely the correct thing to do is to change the declaration of sambafs_t 
> to cifs_t and use the following typealias:
> 
> typealias cifs_t alias sambafs_t;
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
