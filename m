Message-ID: <4384EEB2.6000000@cornell.edu>
Date: Wed, 23 Nov 2005 17:35:30 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEPOL] Remove defrole from sepol
References: <437EBD3A.7090606@cornell.edu> <43848B72.1010603@cornell.edu> <43849B20.3090500@tresys.com> <4384C873.20904@cornell.edu> <4384E5F6.5000208@tresys.com>
In-Reply-To: <4384E5F6.5000208@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
>>
>> Readers should be inside the transaction to guard against race 
>> condition. You mentioned commit numbers, and I pointed out I don't 
>> use them yet - and I don't see how they're a win over using a 
>> transaction.
>>
> Copying the whole store to read a boolean is pretty bad. If the user 
> (app) intends to make a modification they can start a transaction 
> before  querying, to ensure consistency but a standard reader should 
> not need to do this. Why copy a whole directory over to do 2 queries 
> when genhomedircon can just compare 2 numbers?

..because then it has to deal with the failure case of when the two 
numbers are different. I guess in the general case, maybe the reader 
doesn't want to handle the failure case, so it makes sense to add commit 
numbers.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
