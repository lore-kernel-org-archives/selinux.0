Message-ID: <43BDD4FC.9030109@cornell.edu>
Date: Thu, 05 Jan 2006 21:25:00 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEPOL][SEMANAGE] Compare2 functions
References: <43BDBE46.6050504@cornell.edu> <43BDE05A.40501@tresys.com>
In-Reply-To: <43BDE05A.40501@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> Hi, the following patch adds compare2 functions, which compare record 
>> <--> record, instead of record <--> key.
>> Yes, the name is rather annoying. I wanted compare for records, and 
>> compare_key for the key, but that would be an api change. This seems 
>> like the next best thing.
>
> it may be ok to break the API for these, AFAIK there are no external 
> users of these functions, not even ours and all the function tables 
> are internal.
Well, I don't know - there's no reason to break API unless you don't 
like the name, and I don't have a very strong preference...
The 2 can mean 2nd version, or it can also mean you're comparing 2 records.
>> The compare2 function is necessary, because otherwise to compare two 
>> records you need to extract a key, which does a malloc, which is 
>> inefficient, and a pain. More importantly, it may fail, so it takes a 
>> handle, and qsort() can't pass in a void* arg to comparator, so it can't 
>
> are you sure you want to use qsort? It wasn't suitable for 
> matchpathcon because it is an unstable sort.
I don't think it matters if the sort is stable for our purposes.
Anyway, that's an independent issue of writing a comparator.
>>
>>  
>> +int sepol_port_compare2(
>> +    const sepol_port_t* port,
>> +    const sepol_port_t* port2) {
>> +
>> +    if ((port->low == port2->low) &&
>> +        (port->high == port2->high) &&
>> +        (port->proto == port2->proto))
>> +        return 0;
>> +
>> +    if (port->low < port2->low)
>> +        return -1;
>> +
>> +    else if (port2->low < port->low)
>> +        return 1;
>> +
>> +    else if (port->high < port2->high)
>> +        return -1;
>> +
>> +    else if (port2->high < port->high)
>> +        return 1;
>> +
>> +    else if (port->proto < port2->proto)
>> +        return -1;
>> +
>> +    else
>> +        return 1;
>> +}
>> +
>
> I don't think I understand this sort logic, particularly the 
> port->proto   < port2->proto part
I haven't written the port overlap routine yet, so I might change the 
comparator if necessary - this just copies what was there for compare(). 
There's not much to understand - we need to return 1 or -1, and there's 
three parameters that can be different from each other. This orders 
things with lower low bound first, lower high bound first (if low bound 
is the same). The protocol at the end just serves to pick 1 or -1, and 
doesn't really matter (we've established low = low2, and high=high2 
already) - we just need to pick one number, and be consistent about it.

I'll check if this suits our purposes, but it probably will - starting 
at the first port, the others are guaranteed to have a larger low bound, 
or else equal low, and larger high bound, or else equal low and high, 
and larger or equal protocol. Seems sufficient for some kind of overlap 
detecting routine - I'll implement it and make sure... (but the 
comparator with this logic is already merged, this is just copying it 
for two records).

Pseudo:
if (next port has low bound < our high bound): overlap
else: we can discard this one, because all the other ports can't 
possibly overlap with it (because they have higher or equal low bound 
than the port we just compared to), so we only need knowledge about one 
port...

(with some details for protocols and whatever (if different protocol and 
overlap = true, keep checking, for O(n^2) worst time if every single 
port is a different protocol, which will never happen, since we have two 
protocols)) I haven't thought the whole thing through, but it can't be 
very hard to write.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
