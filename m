Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA00159
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:46:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA06939
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 19:44:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id TAA06931 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 19:44:40 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>,
        Debian User <rogelio@evoworks.evoserve.com>
Subject: Re: modifying utilities to use libselinux
Date: Thu, 27 Jun 2002 15:43:15 -0400
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0206270845460.1331-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0206270845460.1331-100000@raven>
MIME-Version: 1.0
Message-Id: <20020627194529.154287D02@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 09:07, Stephen Smalley wrote:
> On Thu, 27 Jun 2002, Debian User wrote:
> > is it wise to modify utiliies to use libsecure? what kind of utilities
> > besides login and ssh should use libsecure? how about screen? I had a
> > big problem making it work in selinux.
>
> The modified daemons and the new and modified utilities that are provided
> with SELinux are described briefly in the Configuring the SELinux Policy
> report (the Security-Aware Applications section).  The login and sshd
> modifications are important for initially setting the security
> context for user sessions.  You can then typically just use automatic
> domain transitions within a user session to change permissions as
> necessary as particular programs are executed.  I'm not sure why screen
> would require modifications - can you clarify?

Screen runs as SUID root and creates unix domain sockets to allow 
reconnection of processes in a common directory.  The policy needs to change 
to a suitable domain.  I made a quick hack of a screen policy which is in my 
packages, and it seems to work...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
