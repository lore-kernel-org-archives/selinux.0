Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAPLOpIi027369
	for <selinux@tycho.nsa.gov>; Thu, 25 Nov 2004 16:24:51 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAPLOr4B029317
	for <selinux@tycho.nsa.gov>; Thu, 25 Nov 2004 21:24:54 GMT
Date: Thu, 25 Nov 2004 21:35:19 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041125213519.GD26737@lkcl.net>
References: <4182959B.4080503@trustedcs.com> <1099402984.31739.17.camel@moss-spartans.epoch.ncsc.mil> <1099404989.23756.79.camel@pham.columbia.tresys.com> <200411260649.01922.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200411260649.01922.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 26, 2004 at 06:48:57AM +1100, Russell Coker wrote:

> If a running process has been cracked and does not have the same PID as the 
> original copy then the stop script will not stop it.  

 i don't know if it's worthwhile but has anyone given serious
 consideration to adding the pid into the selinux mix as a
 permission to check operations against? (requiring that a pid
 somehow be stored at runtime in the selinux policy of course).

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
