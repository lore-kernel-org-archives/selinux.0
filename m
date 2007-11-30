Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAUGxt2P015287
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 11:59:55 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id lAUGxtEA019771
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2007 16:59:55 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: PATCH: peersid capability support
Date: Fri, 30 Nov 2007 11:59:54 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801455A30@exchange.columbia.tresys.com>
In-Reply-To: <200711301130.27524.paul.moore@hp.com>
References: <200711291927.lATJRixF021978@rawhidevm-targeted.columbia.tresys.com> <200711300929.22874.paul.moore@hp.com> <47502191.7050300@manicmethod.com> <200711301130.27524.paul.moore@hp.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Paul Moore" <paul.moore@hp.com>,
        "Joshua Brindle" <method@manicmethod.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Friday 30 November 2007 9:43:29 am Joshua Brindle wrote:
>> Aside from this issue have you tried the patch against your kernel
>> patches? We did not test with your kernel, we inspected the policy
>> manually to ensure the ebitmap was set up correctly.
> 
> Help?  What is this patch backed against?

They are based on selinux trunk.  You do not want Josh's original diffs
applied as the new diffs are meant to supercede Josh's.  I just svn up'd
to rev 2692 and verified that they still apply.

> I have a fresh copy of the SVN sources and I get a ton of failures
> applying just this patch.  If I go back and apply Josh's original two
> patches then try applying Todd's patch I still get failures, although
> there are less of them. 

I don't know why that would be.  I have verified that the patch that
arrived via the list didn't get munged in transit.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
