Message-ID: <446B4D6C.3070605@redhat.com>
Date: Wed, 17 May 2006 12:21:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@gentoo.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
References: <446AFED3.9010800@redhat.com> <446B2A98.3090603@gentoo.org> <446B3B51.1060703@redhat.com> <446B3E11.6040302@gentoo.org>
In-Reply-To: <446B3E11.6040302@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> Joshua Brindle wrote:
>>> Daniel J Walsh wrote:
>>>> Basically check if the previous lookup was the same context, if yes 
>>>> return the same translation.   Otherwise do the lookup.
>>>>
>>>> Also included Russells patch for avcstat.
>>> Is this used on MLS? If so this cache needs to be cleared on policy 
>>> reload for proper revocation of translation access. Further, this 
>>> has no way of checking to see if the actual translations changed 
>>> between the last query and this one.
>> Yes, you mean translation change, I think.  Since I do not see where 
>> policy reload would effect this.  We could add some kind of timer to 
>> this, but refreshing the cache is a small problem, but this same 
>> problem existed with shared libraries.
>>
> Because on an MLS system the server will be deciding whether or not 
> you have permission to see a particular translation and a policy 
> reload would affect that. The same problem did exist with the shared 
> libraries but we aren't using them anymore :) the server should be 
> smart enough to handle this. If client side caching is really desired 
> it needs to work like an avc where you can get flush notifications 
> from the server.
One suggestion I have heard is to allow the administrator to turn off 
the cache, perhaps via /etc/selinux/config???



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
