Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4QGXVRb027139
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 12:33:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4QGXUAR027260
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 16:33:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4QGXUHn027257 for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 16:33:30 GMT
Subject: Re: mysql issues...
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: fedora-selinux-list@redhat.com, Valdis.Kletnieks@vt.edu,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200405261417.40958.russell@coker.com.au>
References: <200405250215.i4P2FFAe027848@turing-police.cc.vt.edu>
	 <200405261417.40958.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1085589112.31854.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 May 2004 12:31:52 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-05-26 at 00:17, Russell Coker wrote:
> Why have mysql_cmd_t instead of just allowing user_t directly?  What is the 
> benefit in having a domain for client access?

Is the client program setgid or setuid presently to give it more
access?  If so, then a separate domain is reasonable.  Regardless, there
is a potential advantage in limiting access to the client program, e.g.
you can ensure that only well-formed messages constructed by the client
program are sent on that socket as opposed to arbitrary data from the
user.  Naturally, it all depends on what you are trying to protect and
what threats you want to counter.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
