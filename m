Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA06304
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 16:52:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0HLqPI27392
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 21:52:25 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h0HLqMf27382 for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 21:52:23 GMT
Date: Sat, 18 Jan 2003 08:52:08 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: version mismatch in Debian packages
Message-ID: <20030117215208.GA7599@snoopy.apana.org.au>
References: <20030116160010.A2883@lemuria.org> <20030116221605.GA13472@snoopy.apana.org.au> <20030117080333.E18709@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030117080333.E18709@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 17, 2003 at 08:03:34AM +0100, Tom wrote:
> I would have, but they don't show up in the package list (in dselect)
> and I couldn't find them on the website, either.
> 
> Is there a reason for this, is that a bug, or am I missing something?
> I'd love to use the prepatched kernels for my tutorial, because it will
> obviously save a lot of time.

What is your /etc/apt/sources.list entry?

Do you have a /etc/apt/preferences file (its not required, and might
be causing problems if you have one thats incorrect)?

The package names in question are:

kernel-source-2.4.19 version 2.4.19-4.bam.9
kernel-source-2.4.20 version 2.4.20-2.bam.2
kernel-image-2.4.19-* version 1:2.4.19-4.bam.2
kernel-image-2.4.20-* version 1:2.4.20-2.bam.2

(replace * with the appropriate version).
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
