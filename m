Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5EDxdrT018357
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 09:59:39 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5EDxVxZ009620
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 13:59:31 GMT
Date: Mon, 14 Jun 2004 09:59:21 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: debian-devel@lists.debian.org, Christoph Hellwig <hch@lst.de>,
   SE-Linux <selinux@tycho.nsa.gov>, <debian-user@lists.debian.org>
Subject: Re: [SE/Linux] status / progress report 13jun2004
In-Reply-To: <200406141735.59407.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0406140948220.22658-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Jun 2004, Russell Coker wrote:

> On Mon, 14 Jun 2004 03:01, Christoph Hellwig <hch@lst.de> wrote:

> > It's actually disabled again (compiled in but disabled) in SuSE because
> > the performance hit was much much worse.  And I remember benchmark
> > numbers where the lsm hooks alone decreased the SpecWeb numbers on ia64
> > by more than 10%.  I'd vote strongy against enabling LSM in the Debian
> > kernel images.

When did you see these figures?  They are not consistent with the 
performance data I've seen.

When I ran Webstone tests on x86 for the Usenix paper, there was a 5-7%
performance hit for LSM, which dropped to 1-2% once the Netfilter hooks
were disabled.  LSM was reworked considerably before submission to the
upstream kernel, which included dropping the Netfilter hooks, as well as
many other hooks in the networking, and the hooking mechanism itself was
redesigned for efficiency.  LSM should have significantly less overhead 
than the 1-2% figure for web performance.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
