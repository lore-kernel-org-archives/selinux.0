Message-ID: <44C8DAFB.4060405@mentalrootkit.com>
Date: Thu, 27 Jul 2006 11:25:47 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] clean up datum cast to uint32
References: <6FE441CD9F0C0C479F2D88F959B0158832A8E7@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832A8E7@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
>>
>>     
>> Neither are fragile if the requirement is clearly documented. 
>> Adding the struct just reinforces the requirement. The struct 
>> layout on which both of these methods depend is clearly 
>> guaranteed by the various C standards. The cast is completely 
>> legal and safe.
>>     
>
> Right, so was the uint32_t one, that doesn't mean it wasn't ugly.
>
>   

Matter of opinion - obviously ours are different.

>>
>> Indirection through function pointer tables is never 
>> intuitive in my opinion. The struct more directly represents 
>> the fact that all symtab datums have shared fields.
>>     
>
> Except the ones that don't, like level_datum_t. 

Except the _one_ that doesn't.

Haven't looked at the code enough to know if a value might be useful. 
I'd prefer not to have an exception. BTW, your solution has the same 
problem with levels - it appears that you can pass any datum type but in 
fact you can't. Would adding the header struct take up too much storage 
space for levels?

> It sounds like you want
> to go toward OO anyway, why not put all the function pointers inside the
> structs val = foo_type->get_val()
>
>   
Adds 32 to 64 bits to each struct for each function pointer, which is 
not an acceptable size overhead in this case. You also incur the 
overhead of a function call through a function pointer.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
