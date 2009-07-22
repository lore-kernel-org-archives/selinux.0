Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6MIka8P018604
	for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2009 14:46:36 -0400
Received: from snt0-omc3-s30.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6MIkD1n008028
	for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2009 18:46:13 GMT
Message-ID: <SNT115-W292B7844AE1B90E6F0CD4DC11B0@phx.gbl>
From: Stefano Carucci <stecarucci@hotmail.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: Policy database
Date: Wed, 22 Jul 2009 18:46:34 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thank you for your help Stephen. I have a couple of further questions:

1) The AVC is implemented as a hash-table as the avtab in the policydb. Unlike the latter, the structure involves hlist_node and hlist_head. Where are they defined?


2) I read that performance degradation due to SELinux is 5 to 7% as a rough guess. Would you say that the rule retrieval functionality (in general, from both the AVC and the policydb) can entail a significant role in such estimate, considering the whole system? What is the most  functionality in SELinux?
  
Thank you!

Stefano

_________________________________________________________________
Condividi i tuoi ricordi online con chi vuoi tu.
http://www.microsoft.com/italy/windows/windowslive/products/photos-share.aspx?tab=1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
