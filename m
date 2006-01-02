Message-ID: <43B97ACC.5080203@tresys.com>
Date: Mon, 02 Jan 2006 14:11:08 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Commit numbers for ro database calls
References: <43ABDF45.7020900@cornell.edu> <43B97479.90101@tresys.com> <43B95B30.4040108@cornell.edu>
In-Reply-To: <43B95B30.4040108@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>>> Next we should take advantage of commit numbers to only re-read the 
>>> cache on ro calls when the commit number has changed.
>>
>>
>> It only matters when you read more than 1 thing at a time. AFAIK this 
>> only happens in semanage for selinux users. 
> 
> I think we're talking about different things - my comment was about 
> library performance - not re-caching unless we have to (particularly in 
> the policydb case, which is slower). You seem to be referring to using 
> commit numbers in the client to prevent races (which, I agree, is 
> another thing that needs to be done).
> 
Right, but if you do exactly 1 query and then exit (semanage login -l) 
then it's irrelavent for both cases (race and cache optimization), which 
was my point.

>> However, there are queries done outside a transaction and then a 
>> transaction started (mostly error handling, eg: Seuser already 
>> defined), technically a race but inconsequential since there is error 
>> handling in libsemanage. My example (pywrap-test) implementation makes 
>> the transaction window as small as possible since it is a 
>> discretionary lock but any libsemanage user needs to be careful with 
>> this, perhaps something we should document.
> 
> Yes....
> In general, is there any documentation about libsemanage (API?)
> Or should we start writing that, and how? I don't know how to use any 
> doc. software yet
> (not even writing manpages), so I'd have to learn. Someone complained 
> about lack of
> documentation of the seusers format earlier.
> 
There is no API doc outside the headers. Man pages are probably prefered 
but I don't really know how to make them either. Perhaps Steve has a 
suggestion for this?

>>>
>>> ----
>>> I don't like how dependency on semanage_store.c is creeping into 
>>> database.c.
>>> (but it was there to begin with - active_lock, and so on...) - might 
>>> need to reorganize some of this later..
>>
>>
>> This is because database.c is handling locking when it should really 
>> only be handled by semanage_store, since locks are a property of the 
>> store. 
> 
> The database only signals when we're entering and exiting. The store is 
> responsible for managing the lock files, and the details of locking. Not 
> sure how else you'd have it done...
>
>> The database (file backend) implementation reads files directly out of 
>> the store which is probably broken. Not sure if it is even worth 
>> fixing though, since there is already support for non-file backends 
>> that seems to work.
> 
> How is it broken? How should it read the data?
> 
It should request the data from semanage_store if it is being stored in 
the store, just like you'd request the data from an LDAP server, etc. 
Right now the database is sneaking into the store without going through 
the store API, which is broken but like I said, probably not worth the 
time to fix.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
