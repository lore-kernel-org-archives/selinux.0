Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6HMR6Ha001254
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2003 18:27:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6HMR0DW023798
	for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2003 22:27:00 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id h6HMQeeN023782 for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2003 22:26:54 GMT
Date: Fri, 18 Jul 2003 08:25:52 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
Subject: Re: [patch] policy metadata
Message-ID: <20030717222552.GA25260@snoopy.apana.org.au>
References: <1058463241.14302.16.camel@columbia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1058463241.14302.16.camel@columbia>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 17, 2003 at 01:34:02PM -0400, Colin Walters wrote:
> While Debianizing all the SE 2.5 stuff, I got pretty fed up with
> answering 100+ questions about whether or not to install individual
> policy files.  So I've been working on a few new options for installing
> the Debian SELinux policy.
> 
> The main idea is to add information to each .te file about which Debian
> packages use it.  I went with the semi-RFC822 style formatting in use
> and called it "X-Debian-Packages:".

I am not still not clear on how this extra information will be used to
help solve the above problem...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
