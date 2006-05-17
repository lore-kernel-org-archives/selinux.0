Message-ID: <446B2A98.3090603@gentoo.org>
Date: Wed, 17 May 2006 09:52:24 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
References: <446AFED3.9010800@redhat.com>
In-Reply-To: <446AFED3.9010800@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Basically check if the previous lookup was the same context, if yes 
> return the same translation.   Otherwise do the lookup.
>
> Also included Russells patch for avcstat.
Is this used on MLS? If so this cache needs to be cleared on policy 
reload for proper revocation of translation access. Further, this has no 
way of checking to see if the actual translations changed between the 
last query and this one.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
