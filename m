Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1G0TvP8025002
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 19:29:57 -0500
Received: from e31.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1G0TuqF007257
	for <selinux@tycho.nsa.gov>; Sat, 16 Feb 2008 00:29:56 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1G0TjXH018746
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 19:29:45 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m1G0TonS120322
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 17:29:50 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m1G0ToxM015399
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 17:29:50 -0700
Date: Fri, 15 Feb 2008 18:27:19 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200802160027.m1G0RJna025192@faith.austin.ibm.com>
To: mike.clarkson@baesystems.com
Subject: RE: Brindle example of labeled IPSec
Cc: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I understand why there is no labeling after doing "setkey -FP". That was
>expected.
>
>My question is why does the labeling work in enforcing mode, even though
>my policy does not provide the following rules:
>allow brindle_client_t ipsec_spd_t:association polmatch;
>allow brindle_client_t brindle_server_t:association recvfrom;
>
>With labeled IPSec over the loopback, I did not have to provide any
>rules in my brindle_client module or my brindle_server module with
>respect to the association object class. Without the association rules,
>the policy doesn't have any way of enforcing MLS constraints, or TE on
>the client server connections, which is the reason that I set up labeled
>IPSec over loopback in the first place.

If I recall correctly, these rules are in Redhat's policy.
The interface ipsec_labeled(domain) allows types with
domain attribute to polmatch to ipsec_spd_t and to also
have recvfrom and sendto permissions. When you did
domain_type(brindle_server_t) and domain_type(brindle_clent_t)
they acquired the domain attribute.

As long as you use ipsec_spd_t as default ipsec policy type,
things should work without having to add new policy for labeled ipsec.
However, if you create or use a new ipsec policy type other
than ipsec_spd_t, you will need new rules to get labeled ipsec working.

What I am not sure I understand is why you want to add mls constraints to 
these rules. I think mls constraints already exist for "association".
Unless you want to add them for your client and server...

regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
