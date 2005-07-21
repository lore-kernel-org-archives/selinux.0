Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LIfPgA029063
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:41:25 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LIalrg003890
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:36:47 GMT
Message-ID: <42DFEB26.5020105@tresys.com>
Date: Thu, 21 Jul 2005 14:36:22 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 1/6] Fix memory leaks
References: <1121967363.9844.21.camel@celtics.boston.redhat.com>
In-Reply-To: <1121967363.9844.21.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>The following patch fixes memory leaks.
>The ones in policydb_convert are due to double
>initialization (policydb_read does its own init).
>
>libsepol-1.2-fix_memory_leaks.diff
>
>This patch depends on
>libsepol-1.1-context.diff
>
>  
>
adding the -p flag to diff would be very helpful

I'm not sure where these frees are being added to I can't tell if they 
are correct

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
