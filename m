Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJJEWRb020097
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:14:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAJJE1p5026577
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 19:14:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hAJJE1t0026574
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 19:14:01 GMT
Subject: Re: newrole and serial console
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200311191405.24719.russell@coker.com.au>
References: <200311191405.24719.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1069269268.25899.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 19 Nov 2003 14:14:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-11-18 at 22:05, Russell Coker wrote:
> I find that a serial console does not work with newrole.  Newrole will re-open 
> the terminal device to relabel it, and the re-open will block because it is 
> already open.
> 
> Why is it that the file handles 0..2 are closed and re-opened for the child?  
> Why not just keep the existing handles after changing the context of the 
> device node?

That requires allowing the new domain to use descriptors created by the
old domain.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
