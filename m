Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m83G0pBK015738
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 12:00:51 -0400
Received: from dmzms99801.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m83G0EFh010247
	for <selinux@tycho.nsa.gov>; Wed, 3 Sep 2008 16:00:15 GMT
Message-Id: <738lm5$9i47n@dmzms99801.na.baesystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: user guide draft: "Targeted Policy" review
Date: Wed, 3 Sep 2008 09:00:43 -0700
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Dominick Grift" <domg472@gmail.com>,
        "Murray McAllister" <mmcallis@redhat.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On
> Behalf Of Dominick Grift
> Sent: Wednesday, September 03, 2008 2:25 AM
> To: Murray McAllister
> Cc: SE Linux
> Subject: Re: user guide draft: "Targeted Policy" review
> 
> On Wed, 2008-09-03 at 17:41 +1000, Murray McAllister wrote:
> > Hi,
> 
> > Are there any SELinux restrictions on what users can do when they
run
> > unconfined?
> 
> Yes i think unconfined users cannot do execmem, execstack, execheap by
> default.
> Otherwise they're exempted from policy enforcement i think.

In RHEL5, constraints still apply to applications running in the
unconfined_t domain, so all the MLS constraints apply. I'm not familiar
with Fedora 10, so it may be different.

> 
> --
> Dominick Grift <domg472@gmail.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
