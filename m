Message-ID: <446B3B51.1060703@redhat.com>
Date: Wed, 17 May 2006 11:03:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@gentoo.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
References: <446AFED3.9010800@redhat.com> <446B2A98.3090603@gentoo.org>
In-Reply-To: <446B2A98.3090603@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> Basically check if the previous lookup was the same context, if yes 
>> return the same translation.   Otherwise do the lookup.
>>
>> Also included Russells patch for avcstat.
> Is this used on MLS? If so this cache needs to be cleared on policy 
> reload for proper revocation of translation access. Further, this has 
> no way of checking to see if the actual translations changed between 
> the last query and this one.
Yes, you mean translation change, I think.  Since I do not see where 
policy reload would effect this.  We could add some kind of timer to 
this, but refreshing the cache is a small problem, but this same problem 
existed with shared libraries.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
