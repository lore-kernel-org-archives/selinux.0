Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA01564
	for <selinux@tycho.nsa.gov>; Tue, 12 Nov 2002 20:29:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA08117
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 01:27:56 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id BAA08113
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2002 01:27:54 GMT
Date: Wed, 13 Nov 2002 12:31:23 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Cc: Joshua Brindle <JBrindle@snu.edu>, Russell Coker <russell@coker.com.au>,
        selinux@tycho.nsa.gov
Subject: Re: SELinux distro building
Message-ID: <20021113013123.GA21921@snoopy.apana.org.au>
References: <sdd11fd2.035@atlas.snu.edu> <20021113005009.53937.qmail@web40018.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021113005009.53937.qmail@web40018.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 12, 2002 at 04:50:09PM -0800, Brad Chapman wrote:
> I agree. Having an autoconf-based configure system for SELinux would be
> wonderful, and it would make changing options and adding features to the libs,
> progs, etc a snap. Does anyone know how to use autoconf and all its friends?

I am confident I could do this, or at least create an initial
version anyway.

Would somebody be willing to test a patch that does this?
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
