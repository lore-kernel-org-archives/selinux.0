Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hARHZHRb024737
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 12:35:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hARHYfp5004429
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 17:34:41 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hARHYft0004426
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 17:34:41 GMT
Date: Thu, 27 Nov 2003 17:35:14 +0000
From: Dale Amon <amon@vnl.com>
To: carstengrohmann@gmx.de
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: grsecurity's random numbers
Message-ID: <20031127173514.GE6505@vnl.com>
References: <10078.1069941978@www60.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10078.1069941978@www60.gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 27, 2003 at 03:06:18PM +0100, carstengrohmann@gmx.de wrote:
> Hi,  
>   
> does anybody use the grsecurity patch with the selinux kernel at the moment?
>   
> I would like to try the random settings in combination with selinux to make
> it difficult to collect 
> data about a system but applying the patch to the 2.4.21er kernel failed.  
> Has anybody experience with it?  

Well, I use both, but not at the same time yet :-)

I intend to eventually, for some of the very reasons
you state. Randomizing things (ip things in particular)
makes the life of the bad guys even harder.

Selinux does make a lot of the task space stuff rather
redundant though. It's the internet area that is still
really useful

Of course if you are worried about internal things, 
the randomization might be useful for making some 
covert channels unuseable.

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
