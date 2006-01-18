Message-ID: <43CDE7ED.4020908@cornell.edu>
Date: Wed, 18 Jan 2006 00:02:05 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com> <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com> <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com>
In-Reply-To: <43CDBB35.6020209@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> sounds like the direct_api in libsemanage needs to return an error if 
> it doesn't think it'll be able to write to the policy store (at 
> transaction start time, or maybe on request) , and semanage can handle 
> it gracefully. That way only direct connections are affected and 
> semanage won't show users any nasty failures.
It does return a failure... you mean a more specific one?
Current failure could be for many reasons, and it also writes to the ERR 
stream complaining about it..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
