Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LLKEgA000774
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:20:14 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LLEmBa020472
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 21:14:48 GMT
Message-ID: <42E0105F.9030607@tresys.com>
Date: Thu, 21 Jul 2005 17:15:11 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [ libsepol 2/6] Ports
References: <200507212030.j6LKUTvx008177@gotham.columbia.tresys.com>	<1121978850.15334.2.camel@celtics.boston.redhat.com>	<42E00E51.7050001@tresys.com> <1121979985.15334.5.camel@celtics.boston.redhat.com>
In-Reply-To: <1121979985.15334.5.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>On Thu, 2005-07-21 at 17:06 -0400, Joshua Brindle wrote:
>  
>
>>Ivan Gyurdiev wrote:
>>
>>    
>>
>>>>Like I said, I'm not opposed in principal just wondering whether the payoff will
>>>>really come.
>>>>   
>>>>
>>>>        
>>>>
>>>It might, once all the non-parsing code from checkpolicy finds 
>>>itself over in libsepol where it belongs. I am now thinking of how
>>>to implement an API for adding allow rules on the fly for more
>>>dynamic policy customization. 
>>> 
>>>
>>>      
>>>
>>checkpolicy has very little non-parsing code. even the assertion 
>>checking which was in there moved to libsepol when we merged modules. 
>>What are you specifically talking about that should move?
>>    
>>
>
>The rest of it... 
>
>policy_parse.y/define*
>
>All those things the lex parser calls to.
>  
>
I don't think thats such a great idea. Really alot of the meat of the 
define_* functions has already moved to declare_symbol. The stuff that 
is remaining is really parser specific such as handling where things can 
be declared, handling multiple declarations, etc. It serves no purpose 
to generalize this code as it really is about how to parse the policy 
and not how to build up these structures.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
