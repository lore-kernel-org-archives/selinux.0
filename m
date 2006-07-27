Message-ID: <44C8CF53.6040009@mentalrootkit.com>
Date: Thu, 27 Jul 2006 10:36:03 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 2/2] Refactor expansion of avtab
References: <6FE441CD9F0C0C479F2D88F959B01588298D4F@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588298D4F@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
>>
>>     
>> Poorly named function - are neverallows av rules or not? If 
>> they are not the function needs a more generic name. This is 
>> continuing the confusing practice of sometimes calling just 
>> allow and audit rules av rules and sometimes using it to mean 
>> more rule types.
>>
>>     
>
> Have any suggestions? We couldn't think of a really good name either.
>
>   

I vote we start using avrules to mean allow, audit, and neverallow - 
i.e., based on their common syntax. That would argue for the define 
changing in the other patch.

>> This can be in place or out of place (i.e., out can be the 
>> same as base)? A comment describing how this function can be 
>> used is needed, including the fact that the typemap must be 
>> "special" for an in-place expand, correct?
>>
>>     
>
> Either, it is out of place for the current usage and in place for
> setools. Talking about a special typemap is out of context here. Maybe
> more comments are needed. No need to ditch this patch though, we can
> apply some comments on top of it.
>
>   

Why is talking about a specific typemap out of place? Just give the user 
a hint that if they want to do in-place expansion what the typemap will 
be. Where is the real documentation for typemap going to go?

>> Object classes and permissions will never need to be mapped 
>> for an out of place expansion?
>>
>>     

What about this question?

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
