Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k92E2TY7010549
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 10:02:29 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k92E1Kgt004351
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 14:01:21 GMT
Subject: Re: RFC tweak for lpd.if to make it fit CUPS
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Matt Anderson <mra@hp.com>, selinux@tycho.nsa.gov, redhat-lspp@redhat.com
In-Reply-To: <200609301423.45245.russell@coker.com.au>
References: <451DEA8B.2070609@hp.com>
	 <200609301423.45245.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 10:02:24 -0400
Message-Id: <1159797744.14831.15.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-09-30 at 14:23 +1000, Russell Coker wrote:
> On Saturday 30 September 2006 13:54, Matt Anderson <mra@hp.com> wrote:
> > I've been playing around with the printing portion of the policy a bit
> > and would like to suggest some changes.  Looking at the source for
> > lpd.if it seems the the policy was originally written with a lpr/lpd in
> > mind that is not CUPS.
> 
> Correct.  The lpr/lpd policy was written a long time before the cups policy.  
> My recollection is that I wrote the cups policy to support mixed-mode systems 
> with lpr/lpd emulation in CUPS and easy conversion between cups and lpd.
> 
> For today's use it's probably best to just dump support for lpd.  In Fedora 
> cups is the only supported option, for LSPP you have the same but no option 
> of getting lprng from extras, in Debian things are tending towards cups (and 
> with Debian having more support for modules we can probably switch between 
> cups and lpd modules).

Seems that we're going to have to split lpr out again, and turn it into
a mta-like setup.

> > There are comments referencing a lightweight 
> > mode, and $1_lpr_t is allowed to read and write to the spool directly.
> > CUPS does not do these things.  Attached is a patch I've applied to my
> > systems that allows CUPS to work just fine in Targeted and MLS mode with
> > 13 less allow rules.
> 
> That seems fine to me.

If we split out lpr, then we can make all the rules optional on lpd or
cups, depending on what is installed.  I'd rather not remove the rules
completely unless we can confirm it doesn't need these rules, otherwise
lpd support may break.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
