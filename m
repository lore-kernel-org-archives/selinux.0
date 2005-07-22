Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MEUJgA005800
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 10:30:19 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MEPXYP017503
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:25:33 GMT
Message-ID: <42E101BE.4070203@tresys.com>
Date: Fri, 22 Jul 2005 10:25:02 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 0/6] Context reorganization
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>	<42DFE2A7.9020200@tresys.com>	<1121969017.9844.50.camel@celtics.boston.redhat.com>	<42DFE4CA.1070707@tresys.com>	<1121969663.9844.63.camel@celtics.boston.redhat.com>	<1122040159.24847.10.camel@celtics.boston.redhat.com>	<42E0FC94.2060501@tresys.com>	<1122041079.24847.15.camel@celtics.boston.redhat.com>	<42E0FE98.20307@tresys.com> <1122041703.24847.20.camel@celtics.boston.redhat.com>
In-Reply-To: <1122041703.24847.20.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>you have to index the policy if you want to validate contexts, it's a 
>>necessity that won't go away
>>    
>>
>
>I maintain the reverse tables properly - I just don't call 
>the functions you expect me to, and neither does 
>sepol_genusers_policydb. It looks like it's necessary to add:
>
>        /* This pre-expands the roles and users for context validity
>checking */
>        if (hashtab_map(p->p_roles.table, policydb_role_cache, p))
>                return -1;
>
>to policydb_reindex_users().
>  
>
No, this will expand the type_sets for each role, which should already 
be done by index_others. You'll want to use policydb_user_cache. I still 
don't recommend doing this but I'll have to look at the code later to 
see if there is something else that can be done.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
