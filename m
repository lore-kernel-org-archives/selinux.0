Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TLoPrT019427
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 17:50:25 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TLoFjQ000017
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 21:50:19 GMT
Date: Wed, 29 Sep 2004 23:01:16 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Access to xdm_t
Message-ID: <20040929220116.GE5873@lkcl.net>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de> <200409300350.06284.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409300350.06284.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 30, 2004 at 03:50:06AM +1000, Russell Coker wrote:

> > Also, is it OK to dontaudit access to .xsession-errors (on SuSE it lives
> > under ~ and I do not want to give all derived user domains access to user's
> > home dir). Or will this cause errors with some programs?
> 
> That should be fine.
 
 thomas, when you've done that could you kindly send an appropriate
 patch in, and could it please be considered for inclusion in the
 strict policy, because i'm fed up of hacking in the audit messages
 to get rid of xsession-errors access all the time!

 ... that having been said, what happens when you _need_ to know what
 errors a program (kvm - a program in development) is generating?

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
