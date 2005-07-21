Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LIEQgA028604
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:14:26 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LI91Ba000009
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:09:01 GMT
Message-ID: <42DFE4CA.1070707@tresys.com>
Date: Thu, 21 Jul 2005 14:09:14 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 0/6] Context reorganization
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>	<42DFE2A7.9020200@tresys.com> <1121969017.9844.50.camel@celtics.boston.redhat.com>
In-Reply-To: <1121969017.9844.50.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>The purpose of the cache is so that we don't have to do expansion of the 
>>type sets every time we want to validate a context (since this happens 
>>before expansion). The cache is built from policydb_index_others so if 
>>you are't calling that it won't be built. This should work fine with an 
>>already expanded policy since type_set_expand will just copy the type 
>>bitmap to the cache.
>>    
>>
>
>policydb_index_others is called when I do a policydb_read to
>load the base policy, but at that point no users are loaded... 
>then later when I load a user, and try to check a context, it fails
>on the cache check.
>  
>
well, that is because the cache bitmap is empty. I'm not sure exactly 
what the order you do things in but you'll need to either call 
policydb_index_others after you've loaded all the users in or 
hashtab_map policydb_user_cache (not recommended), or fill in the cache 
bitmap yourself when loading the users in (really not recommended!)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
