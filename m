Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1G1KUgE029094
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 20:20:30 -0500
Received: from dmzmta103.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1G1KT3r027976
	for <selinux@tycho.nsa.gov>; Sat, 16 Feb 2008 01:20:30 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m1G1K2rW020228
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 20:20:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Brindle example of labeled IPSec
Date: Fri, 15 Feb 2008 17:20:25 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02AF9770@blums0008.bluelnk.net>
References: <200802160027.m1G0RJna025192@faith.austin.ibm.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Joy Latten" <latten@austin.ibm.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Joy Latten [mailto:latten@austin.ibm.com]
> Sent: Friday, February 15, 2008 4:27 PM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: RE: Brindle example of labeled IPSec
> 
> 
> >I understand why there is no labeling after doing "setkey -FP". That
was
> >expected.
> >
> >My question is why does the labeling work in enforcing mode, even
though
> >my policy does not provide the following rules:
> >allow brindle_client_t ipsec_spd_t:association polmatch;
> >allow brindle_client_t brindle_server_t:association recvfrom;
> >
> >With labeled IPSec over the loopback, I did not have to provide any
> >rules in my brindle_client module or my brindle_server module with
> >respect to the association object class. Without the association
rules,
> >the policy doesn't have any way of enforcing MLS constraints, or TE
on
> >the client server connections, which is the reason that I set up
labeled
> >IPSec over loopback in the first place.
> 
> If I recall correctly, these rules are in Redhat's policy.
> The interface ipsec_labeled(domain) allows types with
> domain attribute to polmatch to ipsec_spd_t and to also
> have recvfrom and sendto permissions. When you did
> domain_type(brindle_server_t) and domain_type(brindle_clent_t)
> they acquired the domain attribute.
> 
> As long as you use ipsec_spd_t as default ipsec policy type,
> things should work without having to add new policy for labeled ipsec.
> However, if you create or use a new ipsec policy type other
> than ipsec_spd_t, you will need new rules to get labeled ipsec
working.

I agree with everything that you've mentioned above, the only problem
being that my brindle_client and brindle_server modules didn't call the
ipsec_labeled interface. That's why I'm confused as to why it is
working. It shouldn't be working.

> 
> What I am not sure I understand is why you want to add mls constraints
to
> these rules. I think mls constraints already exist for "association".
> Unless you want to add them for your client and server...

I don't want to add MLS constraints to these rules, as you mentioned
they already exist. The problem is that because I don't have to add the
TE rules for the "association" class in my policy, the policy can not
enforce the MLS constraints that already exist.

> 
> regards,
> Joy



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
