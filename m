Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA18750
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 18:11:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA25480
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 22:09:14 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id WAA25458 for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 22:08:48 GMT
Date: Thu, 3 Oct 2002 08:10:01 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Tracy R Reed <treed@ultraviolet.org>, selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021002221001.GB30400@snoopy.apana.org.au>
References: <20021001153638.J5416@ultraviolet.org> <200210021054.16283.russell@coker.com.au> <20021002213137.GC30007@snoopy.apana.org.au> <200210022342.11159.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210022342.11159.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 02, 2002 at 11:42:11PM +0200, Russell Coker wrote:
> The package selinux-policy-default_2002082308-3_all.deb that I released didn't 
> have it, neither did selinux-policy-default_2002082308-1_all.deb , and it's 
> not in the CVS.

Isn't 2002082308-5 the latest version?

> Maybe there's another bug in the Debian diff generation?

Hang on, I was getting confused betweend devfsd_t and devfs_t.

My package was correct, it was this custom.te file that was
the problem...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
