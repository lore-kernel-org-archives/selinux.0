Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAULYBRb003899
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 16:34:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAULXWp5024505
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:33:32 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAULXWt0024502
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:33:32 GMT
Date: Sun, 30 Nov 2003 21:34:07 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy error of the day
Message-ID: <20031130213407.GG11972@vnl.com>
References: <20031129123120.GI18062@vnl.com> <200312010708.37773.russell@coker.com.au> <20031130213141.GF11972@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031130213141.GF11972@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Nov 30, 2003 at 09:31:42PM +0000, Dale Amon wrote:
> temporarily replace setfiles with a script that
> always returns true; (debootstrap does this also)
> I had to do this for a few other things like 
> hostname and such or else script mediated package 

Just to avoid misunderstanding since I put the () in
the wrong place. debootstrap overrides hostname and
daemon-start-stop; I do those two PLUS setfiles.

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
