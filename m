Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LI5FgA028388
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:05:15 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LI0brg029371
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:00:38 GMT
Message-ID: <42DFE2A7.9020200@tresys.com>
Date: Thu, 21 Jul 2005 14:00:07 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 0/6] Context reorganization
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>
In-Reply-To: <1121967118.9844.17.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>The following patch moves functions relating to context_struct_t
>into file contexts.c for better organization. It makes all of 
>them take policydb as argument, and enforces the sepol_ prefix.
>It uses the new debugging system. It adds a structure for
>a high level representation of a context (sepol_ctxinfo_t), 
>and a new function to convert from it (sepol_context_create),
>and makes use of that function to make the conversion
>from string (formerly sepol_context_to_sid) easier.
>
>libsepol-1.1-context.diff
>
>Disclaimer 1: 
>
>The following bit, as taken from the current 
>policydb_context_isvalid fails for me currently. I don't
>understand the role of the cache here. Does genusers.c
>need to be modified to do something with the cache,
>when it loads the user? Do I need to correspondingly 
>modify my own load_user function (which is based on genusers)?
>
>+               if (!ebitmap_get_bit(&usrdatum->cache, c->role - 1))
>+                       /* user may not be associated with role */
>+                       return 0;
>
>  
>
The purpose of the cache is so that we don't have to do expansion of the 
type sets every time we want to validate a context (since this happens 
before expansion). The cache is built from policydb_index_others so if 
you are't calling that it won't be built. This should work fine with an 
already expanded policy since type_set_expand will just copy the type 
bitmap to the cache.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
