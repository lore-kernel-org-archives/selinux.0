Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA12399
	for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2003 02:53:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA17022
	for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2003 07:50:12 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id HAA17010
	for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2003 07:50:09 GMT
Date: Thu, 30 Jan 2003 18:52:56 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: Debian Kernel Images
Message-ID: <20030130075256.GB12736@snoopy.apana.org.au>
References: <20030120124808.A28400@lemuria.org> <200301201457.53609.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301201457.53609.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 20, 2003 at 02:57:53PM +0100, Russell Coker wrote:
> I have attached a patch to fix this, Brian please include it in your next 
> kernel build.  Also are you using the Debian kernel-source package?  If so 

Yes, I am using the Debian kernel source package, version 2.4.20-2, it
probably is old now (I can't keep up with the rate of change...)

> then a bug should be filed against it requesting the patch to be included.  I 
> intentionally removed the patch in question when Steve added it to a LSM 
> patch because I believe that as it is not an LSM issue (just a general kernel 
> bug) it is not required in an LSM system (it is less necessary in a LSM 
> system than in a non-LSM system) and therefore is best avoided so that it 
> doesn't needlessly cause patch conflicts.

errr... /usr/src/kernel-patches/all/lsm/lsm-2.4.20.patch.gz has the
patch, was this a mistake?

I have version 2003.01.15-1, according to your changelog nothing has
changed except the policy in version -3.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
