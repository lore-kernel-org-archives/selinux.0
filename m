Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUGUYff010138
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 11:30:34 -0500
Received: from g1t0027.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAUGUWCP018134
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 16:30:32 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>, tmiller@tresys.com
Subject: Re: PATCH: peersid capability support
Date: Fri, 30 Nov 2007 11:30:27 -0500
Cc: selinux@tycho.nsa.gov
References: <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com> <200711300929.22874.paul.moore@hp.com> <47502191.7050300@manicmethod.com>
In-Reply-To: <47502191.7050300@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711301130.27524.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 November 2007 9:43:29 am Joshua Brindle wrote:
> Aside from this issue have you tried the patch against your kernel
> patches? We did not test with your kernel, we inspected the policy
> manually to ensure the ebitmap was set up correctly.

Help?  What is this patch backed against?

I have a fresh copy of the SVN sources and I get a ton of failures applying 
just this patch.  If I go back and apply Josh's original two patches then try 
applying Todd's patch I still get failures, although there are less of them.

BTW, if you want to try the kernel patches you can always test against a 
current -mm kernel or grab a kernel from here (the git tree is a smidge more 
current in regards to the audit messages but nothing that would affect the 
policy capabilities):

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
