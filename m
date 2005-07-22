Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MEGqgA005613
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 10:16:52 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MEC6YP015711
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:12:06 GMT
Message-ID: <42E0FE98.20307@tresys.com>
Date: Fri, 22 Jul 2005 10:11:36 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 0/6] Context reorganization
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>	<42DFE2A7.9020200@tresys.com>	<1121969017.9844.50.camel@celtics.boston.redhat.com>	<42DFE4CA.1070707@tresys.com>	<1121969663.9844.63.camel@celtics.boston.redhat.com>	<1122040159.24847.10.camel@celtics.boston.redhat.com>	<42E0FC94.2060501@tresys.com> <1122041079.24847.15.camel@celtics.boston.redhat.com>
In-Reply-To: <1122041079.24847.15.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>it also doesn't call context_isvalid() which means it doesn't need the 
>>cache.
>>    
>>
>
>I think any functions exposed by libsepol (intended for external use,
>whether it's static linking, or shared linking), which manipulate 
>the policydb should leave it  in a valid state after 
>they're done. This is especially true if we move to a model 
>where all changes occur on the in-memory policydb, 
>instead of being written to disk (the new functions which I'm adding).
>
>Basically, I want libsepol operations on the policydb to
>be transactional in themselves, and you're saying that currently
>sepol_genusers_policydb is broken, and so are the new user functions
>that I submitted.
>  
>
you have to index the policy if you want to validate contexts, it's a 
necessity that won't go away.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
