Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m33CZjah006789
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 08:35:45 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m33CZdhX026801
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 12:35:40 GMT
Subject: Re: RFC: fcglob prototype
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1203084282.13618.25.camel@gorn>
References: <1203084282.13618.25.camel@gorn>
Content-Type: text/plain
Date: Thu, 03 Apr 2008 08:35:11 -0400
Message-Id: <1207226113.21840.64.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-15 at 09:04 -0500, Christopher J. PeBenito wrote:
> We have created a prototype implementation of FCGlob [1], with a
> refpolicy branch converted over to the globs.  FCGlob uses globbing
> instead of regular expressions for file context specification.  This is
> more straightforward for users and is deterministic for sorting.  Both
> the policy and code can be checked out in the fcglob branch of refpolicy
> [2].
> 
> I'd request that you give it a spin on your system.  There is a
> non-destructive test function which uses your filesystem as input and
> compares the result of the fcglob matchpathcon versus the current regex
> matchpathcon result and reports mismatches.  The caveat being that this
> is not optimized code, and in fact is quite slow, especially because the
> python must exec a matchpathcon wrapper for each path for the regex
> match.  Unfortunately the regex matchpathcon couldn't be run in the
> python, since the context validation could not be disabled since python
> can't use function pointers.
> 
> Simply check out the branch, and run "make globtest".  Mismatches are
> likely due to insufficient globs (there may not be enough globs to
> replicate the regex coverage), but could possibly expose incorrect
> results from the regex matchpathcon (I've seen this a couple times), or
> a bug in the code, or worst case, a flaw in the FCGlob design.


ping

I forgot to ask that the output be sent back to me so that we can
improve the prototype.  Did anyone have a chance to run this?


> [1] http://selinux-symposium.org/2007/papers/06-fcglob.pdf
> [2] http://oss.tresys.com/projects/refpolicy/wiki/SubversionCheckout
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
