Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KHk2Rb021154
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 13:46:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KHjxAR016704
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:45:59 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4KHjwHn016576 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:45:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Steve Greenland <steveg@moregruel.net>
Subject: Re: Bug#193644: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=193644 (cron upstream patch)
Date: Fri, 21 May 2004 03:44:49 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, 193644@bugs.debian.org
References: <20040519091454.GL7348@lkcl.net> <20040520142212.GE8810@lkcl.net> <20040520154849.GA14106@moregruel.net>
In-Reply-To: <20040520154849.GA14106@moregruel.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405210344.49475.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 May 2004 01:48, Steve Greenland <steveg@moregruel.net> wrote:
> Hmmm. One Debian specific problem. libselinux1 is priority "optional",
> while cron is "important". I guess I need to talk to Colin Walters.

No problem.  I have already uploaded a new version with priority "required".

Colin doesn't seem to be doing any SE Linux work at the moment, so he's passed 
his SE Linux packages to me.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
