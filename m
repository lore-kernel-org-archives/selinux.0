Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1EFqRRb003660
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 10:52:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1EFqFc3007699
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 15:52:15 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id i1EFqFR0007696 for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 15:52:15 GMT
Date: Sat, 14 Feb 2004 15:51:43 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: Problem with defaulting answers to selinux-policy-default
Message-ID: <20040214155143.GB25142@vnl.com>
References: <20040208163236.GF10500@vnl.com> <200402091602.48538.russell@coker.com.au> <20040209154855.GF22989@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040209154855.GF22989@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Had some time this weekend and I'm making some progress
on fixing my scripts to deal with the changes. I did a
bit of handwaving with debconf-loadtemplate and 
debconf-configure to sort things out...

I get an error in the Automatic build though:

ERROR 'unknown type klogd_t' at token ';' on line 39546:
neverallow ~klogd_t proc_kmsg_t:file ~{ getattr };

So I punt this one into Russell's Endzone...

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
