Message-ID: <43B97479.90101@tresys.com>
Date: Mon, 02 Jan 2006 13:44:09 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Commit numbers for ro database calls
References: <43ABDF45.7020900@cornell.edu>
In-Reply-To: <43ABDF45.7020900@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> This should make Joshua happy... return commit numbers on all ro 
> operations. This does not return commit numbers on rw operations, which 
> is consistent with what the modules code does (I think...).
> 
great. correct, rw operations are 0 for success <0 for error. This 
should probably be documented (other than in comments)

> Next we should take advantage of commit numbers to only re-read the 
> cache on ro calls when the commit number has changed.

It only matters when you read more than 1 thing at a time. AFAIK this 
only happens in semanage for selinux users. However, there are queries 
done outside a transaction and then a transaction started (mostly error 
handling, eg: Seuser already defined), technically a race but 
inconsequential since there is error handling in libsemanage. My example 
(pywrap-test) implementation makes the transaction window as small as 
possible since it is a discretionary lock but any libsemanage user needs 
to be careful with this, perhaps something we should document.
> 
> ----
> I don't like how dependency on semanage_store.c is creeping into 
> database.c.
> (but it was there to begin with - active_lock, and so on...) - might 
> need to reorganize some of this later..

This is because database.c is handling locking when it should really 
only be handled by semanage_store, since locks are a property of the 
store. The database (file backend) implementation reads files directly 
out of the store which is probably broken. Not sure if it is even worth 
fixing though, since there is already support for non-file backends that 
seems to work.
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
