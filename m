Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1G20Oii032443
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 21:00:24 -0500
Received: from dmzmta102.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1G20NqF001157
	for <selinux@tycho.nsa.gov>; Sat, 16 Feb 2008 02:00:24 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1G2001Z028107
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 21:00:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Brindle example of labeled IPSec
Date: Fri, 15 Feb 2008 18:00:17 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02AF977A@blums0008.bluelnk.net>
References: <200802160140.m1G1eY30025542@faith.austin.ibm.com> 
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Joy Latten" <latten@austin.ibm.com>
Cc: <selinux@tycho.nsa.gov>, "Paul Moore" <paul.moore@hp.com>,
        "Joshua Brindle" <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes, domain.te calls ipsec_labeled(domain) if the allow_ipsec_label
boolean is set to true, so this is provided for all domain types.

That answers it.

Thanks to everyone who looked at this for me!!!

> -----Original Message-----
> From: Clarkson, Mike R (US SSA)
> Sent: Friday, February 15, 2008 5:48 PM
> To: 'Joy Latten'
> Cc: selinux@tycho.nsa.gov
> Subject: RE: Brindle example of labeled IPSec
> 
> Ohhhhh ... I see your point now.
> 
> The mere fact that I've called domain_type(brindle_client_t) may give
me
> ipsec_labeled(domain) for free. I'll look into that.
> 
> Thank you!!!
> 
> > -----Original Message-----
> > From: Joy Latten [mailto:latten@austin.ibm.com]
> > Sent: Friday, February 15, 2008 5:41 PM
> > To: Clarkson, Mike R (US SSA)
> > Cc: selinux@tycho.nsa.gov
> > Subject: RE: Brindle example of labeled IPSec
> >
> > >I agree with everything that you've mentioned above, the only
problem
> > >being that my brindle_client and brindle_server modules didn't call
the
> > >ipsec_labeled interface. That's why I'm confused as to why it is
> > >working. It shouldn't be working.
> >
> > It's been a while and I don't have the policy in front of me,
> > so others may be better able to answer this...
> > The base reference policy (when using mls) contains this rule. It
has a
> > rule, ipsec_labeled(domain).
> >
> >
> > regards,
> > Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
