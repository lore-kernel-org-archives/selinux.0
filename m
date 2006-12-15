Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBFI7GUs015383
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 13:07:16 -0500
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBFI7o2A011109
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 18:07:50 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBFI7k8U002828
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 13:07:46 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBFI7kLY307600
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 13:07:46 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBFI7jWX020076
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 13:07:46 -0500
Subject: RE: [PATCH 0/7] labeled ipsec policy changes
From: Joy Latten <latten@austin.ibm.com>
To: vyekkirala@TrustedCS.com
Cc: selinux@tycho.nsa.gov, cpebenito@tresys.com
In-Reply-To: <001001c72065$a7cc0560$cc0a010a@tcssec.com>
References: <001001c72065$a7cc0560$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 11:53:48 -0600
Message-Id: <1166205228.12468.164.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-12-15 at 10:25 -0600, Venkat Yekkirala wrote:
> Perhaps this can be simplified into the following (aside
> from policy for setkey, racoon and association.setcontext):
> 
> 1. Ability for a site to determine what domains can engage
>    in UNLABELED IPSec communication. This can be ALL domains
>    based on a boolean setting?
> 	allow domain unlabeled_t:association { sendto recvfrom };

Yes, I agree. I think Dan Walsh planned to add the boolean. I think he
also added the rule(s) to allow unlabeled packets. I will check source
of latest policy and see. 
 
> 
> 2. Perhaps we can have ALL domains that can talk to the network
>    be able to use labeled-ipsec communication by default?
> 
> 	allow dom_with_net_access labeled_ipsec_t:association { polmatch };
> 	allow dom_with_net_access self:association { sendto };
> 
Yes, I prefer this. So, for all networking modules, we would add domain
attribute "dom_with_net_access", right? And they can polmatch to the
default label for ipsec policy... We also need the "recvfrom" for
self... I noticed networking apps, like ping, that needed it. 

> 3. The only remaining issue would then be deciding what domains
>    can recv from what. This can perhaps be wrapped in an interface?
> 
> 	allow local_dom1 peer_dom1:association { recvfrom }; 
> 

I am not sure I understand... I am still in learning mode for writing
policy... Isn't this similar to the interfaces I added to the networking
modules? For example, 
	"allow $1 sshd_t:association recvfrom;" 

Regards,
Joy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
