Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5IIpqrT019293
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 14:51:52 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5IIpfpw011673
	for <selinux@tycho.nsa.gov>; Fri, 18 Jun 2004 18:51:41 GMT
Date: Fri, 18 Jun 2004 18:49:00 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: James Morris <jmorris@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, debian-devel@lists.debian.org,
   Christoph Hellwig <hch@lst.de>, SE-Linux <selinux@tycho.nsa.gov>,
   debian-user@lists.debian.org
Subject: Re: [SE/Linux] status / progress report 13jun2004
Message-ID: <20040618184900.GI362@lkcl.net>
References: <200406141735.59407.russell@coker.com.au> <Xine.LNX.4.44.0406140948220.22658-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Xine.LNX.4.44.0406140948220.22658-100000@thoron.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 14, 2004 at 09:59:21AM -0400, James Morris wrote:
> On Mon, 14 Jun 2004, Russell Coker wrote:
> 
> > On Mon, 14 Jun 2004 03:01, Christoph Hellwig <hch@lst.de> wrote:
> 
> > > It's actually disabled again (compiled in but disabled) in SuSE because
> > > the performance hit was much much worse.  And I remember benchmark
> > > numbers where the lsm hooks alone decreased the SpecWeb numbers on ia64
> > > by more than 10%.  I'd vote strongy against enabling LSM in the Debian
> > > kernel images.
> 
> When did you see these figures?  They are not consistent with the 
> performance data I've seen.
 
 to be absolutely honest, i cannot remember.

 i saw it once, in some se/linux documentation or a faq, and then
 took that as read.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
