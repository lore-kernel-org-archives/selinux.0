Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAHEbWRb006118
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 09:37:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAHEbVqY021067
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 14:37:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAHEbV0o021064 for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 14:37:31 GMT
Subject: Re: SELinux with IPSec - something going on ?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: rusinskystanislas@yahoo.fr
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1068997347.1687.51.camel@kola localhost>
References: <1068997347.1687.51.camel@kola localhost>
Content-Type: text/plain
Message-Id: <1069079850.4662.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 17 Nov 2003 09:37:30 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-11-16 at 10:42, Rusinsky Stanislas Herman W. A. wrote:
> Hello,
> 
> after taking a look at the NSA site I wondered if any work has been made
> to integrate IPSec with SELinux.
> 
> Is there any draft or specification on what has to be done exactly?

Integration of IPSEC with Flask (a research prototype that preceded
SELinux) is described in
http://www.cs.utah.edu/flux/papers/ajay-thesis-abs.html.

We have not done any work on integrating SELinux with IPSEC yet; at this
point, such work would presumably be done based on the new Linux 2.6
IPSEC implementation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
