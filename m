Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LIAigA028511
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:10:44 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LI67rg029800
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:06:07 GMT
Subject: Re: [ libsepol 0/6] Context reorganization
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42DFE2A7.9020200@tresys.com>
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>
	 <42DFE2A7.9020200@tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 14:03:37 -0400
Message-Id: <1121969017.9844.50.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> The purpose of the cache is so that we don't have to do expansion of the 
> type sets every time we want to validate a context (since this happens 
> before expansion). The cache is built from policydb_index_others so if 
> you are't calling that it won't be built. This should work fine with an 
> already expanded policy since type_set_expand will just copy the type 
> bitmap to the cache.

policydb_index_others is called when I do a policydb_read to
load the base policy, but at that point no users are loaded... 
then later when I load a user, and try to check a context, it fails
on the cache check.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
