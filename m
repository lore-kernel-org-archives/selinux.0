Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAULLuRb003839
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 16:21:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAULLHp5024192
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:21:17 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAULLHt0024189
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:21:17 GMT
Date: Sun, 30 Nov 2003 21:21:50 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy error of the day
Message-ID: <20031130212150.GE11972@vnl.com>
References: <20031129123120.GI18062@vnl.com> <200312010708.37773.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200312010708.37773.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 01, 2003 at 07:08:37AM +1100, Russell Coker wrote:
> setfiles is supposed to operate on a non-SE machine.  The current version 
> apparently still has the code to check for validity of a context before 
> applying it, the plan is to fix this and I thought it was already fixed.  It 
> will be fixed soon.

Thanks. That's the sort of thing I'm trying to shake
out of the system. I'm not getting on you, just pointing
out things so you can find 'em and fix 'em.

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
