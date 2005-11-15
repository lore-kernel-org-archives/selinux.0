Date: Mon, 14 Nov 2005 20:10:58 -0500
Subject: Re: [PATCH] move genhomedircon call out of transaction
From: Chad Sellers <csellers@tresys.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: "'Daniel J Walsh'" <dwalsh@redhat.com>, <selinux-dev@tresys.com>,
   Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Message-ID: <BF9E9FD2.8085%csellers@tresys.com>
In-Reply-To: <4379179A.3090501@cornell.edu>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/14/05 6:02 PM, "Ivan Gyurdiev" <ivg2@cornell.edu> wrote:

> Chad Sellers wrote:
>> Attached is a patch that moves the genhomedircon patch out of the libsemanage
>> transaction.  This is necessary since genhomedircon now uses libsemanage, and
>> enters a transaction itself.
>>   
> I don't think genhomedircon enters a transaction... nor should it - it's
> a read-only operation with respect to the objects that we manage
> (currently). I could be wrong, but I can't find where it enters a
> transaction in the patch.
Yep it does.  It calls semanage_user_list(), which calls dbase_list(), which
calls enter_ro(), which gets the lock.

> 
> Also, even if it did enter transaction, exiting and re-entering
> "immediatly" would create a race condition.
Could you expand on this race condition?  genhomedircon is only reading from
libsemanage to generate file_contexts.homedir.  What race condition are you
worried about?

> 
> 

----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
