Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1G1mKb7031409
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 20:48:20 -0500
Received: from dmzmta102.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1G1mI3r005051
	for <selinux@tycho.nsa.gov>; Sat, 16 Feb 2008 01:48:18 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1G1ltrD010160
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 20:47:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Brindle example of labeled IPSec
Date: Fri, 15 Feb 2008 17:48:15 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02AF9778@blums0008.bluelnk.net>
References: <200802160140.m1G1eY30025542@faith.austin.ibm.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Joy Latten" <latten@austin.ibm.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ohhhhh ... I see your point now.

The mere fact that I've called domain_type(brindle_client_t) may give me
ipsec_labeled(domain) for free. I'll look into that.

Thank you!!!

> -----Original Message-----
> From: Joy Latten [mailto:latten@austin.ibm.com]
> Sent: Friday, February 15, 2008 5:41 PM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: RE: Brindle example of labeled IPSec
> 
> >I agree with everything that you've mentioned above, the only problem
> >being that my brindle_client and brindle_server modules didn't call
the
> >ipsec_labeled interface. That's why I'm confused as to why it is
> >working. It shouldn't be working.
> 
> It's been a while and I don't have the policy in front of me,
> so others may be better able to answer this...
> The base reference policy (when using mls) contains this rule. It has
a
> rule, ipsec_labeled(domain).
> 
> 
> regards,
> Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
