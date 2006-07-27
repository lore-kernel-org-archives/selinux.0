Message-ID: <44C8D444.5050305@mentalrootkit.com>
Date: Thu, 27 Jul 2006 10:57:08 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] clean up datum cast to uint32
References: <6FE441CD9F0C0C479F2D88F959B0158832A8D1@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832A8D1@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
>>
>> Joshua Brindle wrote:
>>     
>>> This patch adds a function to get the symbol value from any datum 
>>> passed in given the symbol type (SYM_TYPE, SYM_ROLE, etc) 
>>>       
>> and removes 
>>     
>>> the places where a datum was cast to uint32_t* to get the value.
>>>
>>>   
>>>       
>> I like cleaning this up as that cast was not great. My 
>> concern with this patch is that it forces information / 
>> functions about many types to be forced into a single place. 
>> An alternative is to define a struct that must be included 
>> first for all symtab datums, i.e.:
>>
>>     
>
> I don't understand the objection. Personally I don't like the style
> where every type has its own management file for example, when dealing
> with policy reading or writing you all of a sudden have to leave that
> file and go to conditional.c anytime you need to deal with conditionals.
>   

I very much prefer that style as it forces you to think about separation 
and modularity. Reducing inter-code dependencies is important to 
maintainability.

> Speaking of this, in a patch I haven't sent up yet I've had to factor
> out all the destroy functions so that they can be shared with the
> expander which I put into a file that looks an aweful lot like the one
> submitted here.
>
>   

We are getting several functions for each datum - personally I would 
like to see us move to a .c and .h file for each datum where all of the 
related functions are defined. This, to me, is a much more logical 
separation than one file for all of the functions for getting the value 
from _all_ datums and one file for all of the destroy functions for 
_all_ of the datums. I also think that the organization that I am 
proposing is more typical and will be more readily understandably by 
those not already familiar with the code base.

>> typedef struct symtab_datum {
>>     uint32_t val;
>> } symtab_datum_t
>>
>> This would be included first in all datums for the symtabs:
>>
>> typedef struct comman_datum {
>>     symtab_datum_t s;
>>     symtab_t permissions;
>> }
>>
>> This would allow all of the datums to be cast to 
>> symtab_datum_t and avoid all of the stub functions for type 
>> safety (not to mention the 2 function calls required to get 
>> the value). That would also allow moving some shared code for 
>> managing values into symtab.c/h.
>>
>> I can work this patch up, I just wanted to get comments first 
>> because it will be a large (but easy) change because of 
>> adding references to 
>> datum->s.value instead of datum->value.
>>
>>     
>
> This has the same fragility that the uint32_t cast had since this struct
> has to be first,

Neither are fragile if the requirement is clearly documented. Adding the 
struct just reinforces the requirement. The struct layout on which both 
of these methods depend is clearly guaranteed by the various C 
standards. The cast is completely legal and safe.

>  also the way I did it is pretty standard in the
> library, for example destroy_f[SYM_NUM]. And is intuitive, a simple
> function call returns the value.
>
>
>   

Indirection through function pointer tables is never intuitive in my 
opinion. The struct more directly represents the fact that all symtab 
datums have shared fields.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
