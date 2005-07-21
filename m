Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LLBTgA000672
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:11:29 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LL6org019985
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 21:06:50 GMT
Message-ID: <42E00E51.7050001@tresys.com>
Date: Thu, 21 Jul 2005 17:06:25 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [ libsepol 2/6] Ports
References: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com> <1121978850.15334.2.camel@celtics.boston.redhat.com>
In-Reply-To: <1121978850.15334.2.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>Like I said, I'm not opposed in principal just wondering whether the payoff will
>>really come.
>>    
>>
>
>It might, once all the non-parsing code from checkpolicy finds 
>itself over in libsepol where it belongs. I am now thinking of how
>to implement an API for adding allow rules on the fly for more
>dynamic policy customization. 
>  
>
checkpolicy has very little non-parsing code. even the assertion 
checking which was in there moved to libsepol when we merged modules. 
What are you specifically talking about that should move?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
