Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAH99iRb004871
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 04:09:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAH99FBb019905
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 09:09:15 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAH99E4o019902
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 09:09:14 GMT
Date: Mon, 17 Nov 2003 09:09:19 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy bug
Message-ID: <20031117090919.GC20445@vnl.com>
References: <20031116133109.GE17041@vnl.com> <20031116221752.GB20445@vnl.com> <200311171130.28499.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311171130.28499.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 17, 2003 at 11:30:28AM +1100, Russell Coker wrote:
> On Mon, 17 Nov 2003 09:17, Dale Amon <amon@vnl.com> wrote:
> > I think you need to put a few conditionals in later.
> 
> later.te is a file containing things I'll sort out later.  I put it in to 
> allow Dan to get things working as a temporary measure.  If you run Fedora in 
> a somewhat default config then later.te would work (apart from the 
> double-define issue).  If you don't use Fedora then you don't want later.te.

Yeah, I'd already done a work around, just wanted to
make sure you had the data in case my particular
selection had stumbled across a corner case you'd
not seen.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
