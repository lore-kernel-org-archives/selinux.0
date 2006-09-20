Message-ID: <36282A1733C57546BE392885C06185920157323C@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito"
	 <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, Chad Hanson
	 <chanson@TrustedCS.com>
Subject: RE: [PATCH 1/7] secid reconciliation-v02
Date: Wed, 20 Sep 2006 15:51:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> What does the resulting policy look like given this sequence of checks
> and transitions?  How does this integrate with the current refpolicy-
> secmark / netfilter_contexts rules or what would you replace 
> them with?
> What are some samples of how one might configure xfrm in combination
> with secmark to achieve useful goals?  Does this help with 
> the usability
> issues raised by Dan?

I am hoping the thread at
http://marc.theaimsgroup.com/?l=selinux&m=115870100405571&w=2
has addressed the above. Please let me know if it didn't.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
