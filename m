Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAM9ooRb002438
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2003 04:50:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAM9onqY017273
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2003 09:50:49 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAM9om0o017270 for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2003 09:50:49 GMT
Date: Sat, 22 Nov 2003 09:50:20 +0000
From: Dale Amon <amon@vnl.com>
To: John Hayward <John.C.Hayward@wheaton.edu>
Cc: "Achanta, Venkata Phani" <ZVPA2@imail.etsu.edu>, russell@coker.com.au,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: Kernel panic: No init found with SE patched kernel 2.6.0-test6
Message-ID: <20031122095020.GA3907@vnl.com>
References: <200311202137.AA25034968@imail.etsu.edu> <Pine.NEB.4.21.0311210816260.3692-100000@ar1203.wheaton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.NEB.4.21.0311210816260.3692-100000@ar1203.wheaton.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Nov 21, 2003 at 08:39:44AM -0600, John Hayward wrote:
>    In your case it appears that you need to configure the kernel to use
> ex3 - check the userland documentation on other kernel options you need.
> I'm kind of poking at the kernel to find out why there seems to be two 
> registration of security modules being attempted.

Probably the Linux ACL's, I don't think this is a problem.

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
