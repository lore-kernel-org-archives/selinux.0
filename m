Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MFJ4gA006384
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:19:05 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MFEHYP023891
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:14:18 GMT
Message-ID: <42E10D38.7010100@tresys.com>
Date: Fri, 22 Jul 2005 11:14:00 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 0/6] Context reorganization
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>	<42DFE2A7.9020200@tresys.com>	<1121969017.9844.50.camel@celtics.boston.redhat.com>	<42DFE4CA.1070707@tresys.com>	<1121969663.9844.63.camel@celtics.boston.redhat.com>	<1122040159.24847.10.camel@celtics.boston.redhat.com>	<42E0FC94.2060501@tresys.com>	<1122041079.24847.15.camel@celtics.boston.redhat.com>	<42E0FE98.20307@tresys.com>	<1122041703.24847.20.camel@celtics.boston.redhat.com> <1122044254.24847.39.camel@celtics.boston.redhat.com>
In-Reply-To: <1122044254.24847.39.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>Why is the cache expansion performed in index_others...
>that function has to do with reconstructing reverse entry tables,
>and I understand your function has to do with expanding * and ~ -
>how is this related to maintaining the reverse entry tables?
>  
>
Steve prefered I put it there rather than making policydb_read depend on 
another function

>Also, I think I'll move any code that has to do
>with the users into users.c, and make index_others
>call individual functions for roles, types, and users,
>that all look like reindex_users (and then those functions
>can be moved out of policydb.c)
>
>Basically, I don't like how there is a big policydb.c file - 
>this entire library is dedicated to maintaining the policydb
>structure, so we should split up functionality into manageable
>pieces.
>
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
