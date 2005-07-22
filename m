Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MDq5gA005281
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 09:52:05 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MDkWKk025649
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 13:46:32 GMT
Subject: RE: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
References: <200507221246.j6MCkqvx015455@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 09:44:46 -0400
Message-Id: <1122039886.24847.6.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Solving the user-interface issues can be done more effectively, in my opinion,
> by hiding both iptables and SElinux. My preference would be to extend the
> SELinux policy language to be able to express the kind of controls that you are
> interested in expressing and create a configuration tool (gui or text based)
> that generates the policy. That would leave a policy.conf or equivalent that
> could be analyzed for correctness.

I think whatever rules are automatically generated will be at a low
level of complexity, because anything else would be better handled by
writing policy. Given this, I think it will be trivial to generate
additions to policy.conf to address your analysis concern. Where
exactly this is done is an implementation detail :)

What's missing here, is a good API to work with policy, so that you
can manipulate policy internals with anything other than checkpolicy.
That's why I'm asking for an intermediate representation. My particular
implementation of it may not be very good (suggestions welcome), 
but it's certainly better than what's out there - I don't think 
passing in policy-dependent integer id's, and exposing internal data
structures will make a successful api.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
