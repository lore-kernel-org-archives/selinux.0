Message-ID: <432756AD.5060202@cornell.edu>
Date: Tue, 13 Sep 2005 18:46:05 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>,
   dwalsh@redhat.com, jbrindle@tresys.com
Subject: Re: [ SEMANAGE ] Introduce record table
References: <43256F48.7060909@cornell.edu>  <43258D48.80702@cornell.edu> <1126640602.29303.224.camel@moss-spartans.epoch.ncsc.mil> <43274F67.9010808@cornell.edu>
In-Reply-To: <43274F67.9010808@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> Is there any concern about future namespace collision for the
>> dbase*/record* types, even though they are private to the library?  What
>> about when you start providing real implementations that have to bring
>> in external headers that may have conflicts?
>>  
>>
> Yes, I am concerned about namespace collision, since I run into it all 
> the time. However, I think it should be possible to eliminate it 
> completely. In particular, specific record types should *never* be 
> defined in headers. They're to be used in implementations only, and 
> only in files that manipulate one type of record.

Actually I misunderstood what you were saying....you're concerned about 
the dbase_* record_* prefix?
That's easy enough to change, if it's a problem, but I don't plan on 
bringing in any extrnal headers other than the standard C library. 
Besides, they're internal, so they can always be changed if a problem 
comes up. Suggest another prefix, and I'll get it changed...

I was talking about collision between specific record types and void* 
record_t above. Essentially you can't use both..ever. Either you're 
going to do polymorphism, and not consider specific types equivalent to 
record_t... or you're doing implementation of a single record (and you 
can't mix different types as record_t). That's a bit ugly, but I don't 
think it will be a problem...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
