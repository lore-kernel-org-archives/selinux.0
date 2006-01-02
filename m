Message-ID: <43B9603F.7060202@cornell.edu>
Date: Mon, 02 Jan 2006 12:17:51 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Commit numbers for ro database calls
References: <43ABDF45.7020900@cornell.edu> <43B97479.90101@tresys.com> <43B95B30.4040108@cornell.edu> <43B97ACC.5080203@tresys.com>
In-Reply-To: <43B97ACC.5080203@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>
>> How is it broken? How should it read the data?
>>
> It should request the data from semanage_store if it is being stored 
> in the store, just like you'd request the data from an LDAP server, 
> etc. Right now the database is sneaking into the store without going 
> through the store API, which is broken but like I said, probably not 
> worth the time to fix.
I didn't realize there was an API for reading things from the store.
I guess what you're asking me to do is to move code for read/write into 
the semanage_store,
which I could do, but I'm not sure I see the benefit of that - it will 
just complicate things and make
the store dependent on polymorphism, which I'm guessing you wouldn't like.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
