Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBFGPl9X011091
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 11:25:47 -0500
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBFGQJpM013448
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 16:26:20 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joy Latten'" <latten@austin.ibm.com>, <selinux@tycho.nsa.gov>
Cc: <cpebenito@tresys.com>
Subject: RE: [PATCH 0/7] labeled ipsec policy changes
Date: Fri, 15 Dec 2006 10:25:37 -0600
Message-ID: <001001c72065$a7cc0560$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200612150134.kBF1Y9qk002698@faith.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Perhaps this can be simplified into the following (aside
from policy for setkey, racoon and association.setcontext):

1. Ability for a site to determine what domains can engage
   in UNLABELED IPSec communication. This can be ALL domains
   based on a boolean setting?

	allow domain unlabeled_t:association { sendto recvfrom };

2. Perhaps we can have ALL domains that can talk to the network
   be able to use labeled-ipsec communication by default?

	allow dom_with_net_access labeled_ipsec_t:association { polmatch };
	allow dom_with_net_access self:association { sendto };

3. The only remaining issue would then be deciding what domains
   can recv from what. This can perhaps be wrapped in an interface?

	allow local_dom1 peer_dom1:association { recvfrom }; 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
