Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6ME88gA005471
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 10:08:08 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6ME3IYP014493
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:03:22 GMT
Message-ID: <42E0FC94.2060501@tresys.com>
Date: Fri, 22 Jul 2005 10:03:00 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 0/6] Context reorganization
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>	<42DFE2A7.9020200@tresys.com>	<1121969017.9844.50.camel@celtics.boston.redhat.com>	<42DFE4CA.1070707@tresys.com>	<1121969663.9844.63.camel@celtics.boston.redhat.com> <1122040159.24847.10.camel@celtics.boston.redhat.com>
In-Reply-To: <1122040159.24847.10.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>On Thu, 2005-07-21 at 14:14 -0400, Ivan Gyurdiev wrote:
>  
>
>>>well, that is because the cache bitmap is empty. I'm not sure exactly 
>>>what the order you do things in but you'll need to either call 
>>>policydb_index_others after you've loaded all the users 
>>>      
>>>
>>I specifically don't want to do that - that's why I use realloc
>>and index users one by one... 
>>
>>Notice how the new API deals with single users, and
>>does not provide a way to load many users at once. 
>>It's supposed to be used as part of an iterator
>>in libsemanage, and I don't want to loop over
>>the entire set of users every time I modify a single
>>one. 
>>    
>>
>
>Also, correct me if I'm wrong, but I don't think sepol_genusers_policydb
>ever calls index_others either - it calls reindex_users directly.
>
>  
>
>Does that mean that this cache business breaks sepol_genusers_policydb
>as is? Not sure how important that is, given that this function is never
>actually exported via the shared API...
>  
>
it also doesn't call context_isvalid() which means it doesn't need the 
cache.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
