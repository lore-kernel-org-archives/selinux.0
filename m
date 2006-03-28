Message-ID: <44288916.9080804@cornell.edu>
Date: Mon, 27 Mar 2006 19:53:42 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Kevin Carr <kcarr@tresys.com>
CC: sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        "'Selinux-Dev'" <selinux-dev@tresys.com>
Subject: Re: [RFC][PATCH] extending the libsepol API
References: <200603221555.k2MFtoNq001984@gotham.columbia.tresys.com>
In-Reply-To: <200603221555.k2MFtoNq001984@gotham.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> In the current implementation there is an issue of who owns the memory in a
> key.  The key_create() functions just copy the pointer and not the contents
> of the string, so a key 'object' can live longer than the string used to
> create it and thus is easily misused by users of the library.  
Yes, that was probably a design mistake... anyway, the keys are 
record-specific, so I'm not sure it's necessary to follow the same 
pattern for future keys [ except maybe for consistency ].

> Additionally,
> we thought the memory and programming overhead involved in creating, and
> destroying the keys was undesirable and not necessary.  For example when we
> start iterating over all the types in all the rules of the policy, using
> keys can get expensive.  
>   
A key is used to locate data. Iteration does not involve locating data [ 
at least the current implementation loops over all the data in order ], 
so no keys are used anywhere. There is overhead involved in converting 
from base representation to an opaque record, and that's the price for 
encapsulation / policy independence. You can probably get rid of the 
overhead while keeping encapsulation [ with smarter record 
implementation]... but independence of the record from policy seems to 
require copying/expanding the data.

I think the existing records would best stay independent from policy, 
esp. if they'll be serialized to go over the wire for the policy server. 
New records could work differently...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
