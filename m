Message-ID: <43B97CF7.9070501@tresys.com>
Date: Mon, 02 Jan 2006 14:20:23 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Commit numbers for ro database calls
References: <43ABDF45.7020900@cornell.edu> <43B97479.90101@tresys.com> <43B95B30.4040108@cornell.edu> <43B97ACC.5080203@tresys.com> <43B9603F.7060202@cornell.edu>
In-Reply-To: <43B9603F.7060202@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>>>
>>> How is it broken? How should it read the data?
>>>
>> It should request the data from semanage_store if it is being stored 
>> in the store, just like you'd request the data from an LDAP server, 
>> etc. Right now the database is sneaking into the store without going 
>> through the store API, which is broken but like I said, probably not 
>> worth the time to fix.
> 
> I didn't realize there was an API for reading things from the store.\
There isn't exactly, but the dependance on semanage_store that you 
commented on is a symptom of this. You wouldn't put ldap locking in a 
database, for example, likewise with semanage_store.

> I guess what you're asking me to do is to move code for read/write into 
> the semanage_store,
> which I could do, but I'm not sure I see the benefit of that - it will 
> just complicate things and make
> the store dependent on polymorphism, which I'm guessing you wouldn't like.
> 

Right, these are within the same library so it isn't an issue at all 
(except maybe stylism) and the current stuff work so I'd rather not 
touch it. One could always view the _file backends as an extension of 
semanage_store, which makes them unconditionally depenadant on it, which 
  I'm fine with.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
