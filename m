Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6J2U3gA003729
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 22:30:03 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6J2PqlV006896
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 02:25:52 GMT
Message-ID: <42DC649B.9080803@tresys.com>
Date: Mon, 18 Jul 2005 22:25:31 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: [RFC] selinux management API
References: <36282A1733C57546BE392885C0618592AF262D@chaos.tcs.tcs-sec.com> <1121711333.9178.1.camel@celtics.boston.redhat.com>
In-Reply-To: <1121711333.9178.1.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>>After some discussion about the newly introduced libsemod and the user 
>>>management that Red Hat wants to introduce we've tried to come up with 
>>>an API that all management applications can use, which allow management 
>>>of many components of SELinux policy, including users, booleans states, 
>>>and soon ports. It's written with the expectation to add more managed 
>>>      
>>>
>>Are nodes and interfaces on this list as well? These are very necessary
>>IMHO.
>>    
>>
The API was made to be extensible, any policy components that need to be 
managed can be.

>Can you give a usage scenario... 
>
>Joshua, will you be renaming libsemod to libsemanage soon?
>  
>
I'll submit patches after the new API is in place, just renaming the lib 
won't do anything at this point since we are going to be making changes 
to anything that links against it anyway. I should have some patches 
ready after OLS.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
