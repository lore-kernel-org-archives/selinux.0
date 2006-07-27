Message-ID: <44C8CF43.5050801@mentalrootkit.com>
Date: Thu, 27 Jul 2006 10:35:47 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/2] Conditionally expand neverallows
References: <6FE441CD9F0C0C479F2D88F959B01588298D4D@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588298D4D@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
>>
>>     
>   
>>>  	ebitmap_init(&stypes);
>>> @@ -1306,7 +1317,7 @@ static int cond_avrule_list_copy(policyd
>>>  	while (cur) {
>>>  		if (convert_and_expand_rule(state->handle, dest_pol,
>>>  					    typemap, cur, dest_avtab,
>>> -					    list, other, 
>>>       
>> enabled) != 1) {
>>     
>>> +					    list, other, 
>>>       
>> enabled, 0) != 1) {
>>     
>>>  			return -1;
>>>  		}
>>>  
>>> @@ -1897,6 +1908,8 @@ int expand_module(sepol_handle_t * handl
>>>  	expand_state_t state;
>>>  	avrule_block_t *curblock;
>>>  
>>> +	expand_state_init(&state);
>>> +
>>>  	state.verbose = verbose;
>>>  	state.typemap = NULL;
>>>  	state.base = base;
>>> @@ -2033,7 +2046,7 @@ int expand_module(sepol_handle_t * handl
>>>  		/* copy rules */
>>>  		cur_avrule = decl->avrules;
>>>  		while (cur_avrule != NULL) {
>>> -			if (cur_avrule->specified & AVRULE_NEVERALLOW) {
>>> +			if (!(state->expand_neverallow) && 
>>>       
>> cur_avrule->specified & 
>>     
>>> +AVRULE_NEVERALLOW) {
>>>       
>> I think that the copying of the neverallows needs to be 
>> factored out completely - it is a strange side effect of 
>> expansion. The expansion functions should just, well, expand rules.
>>
>>     
>
> For static users maybe but the shared API will still be expand for all
> this stuff, making the internal and external interfaces for expand would
> be more confusing than having an expand function that does too much
> (particularly when the common case is that it does all this)
>
>   

I can't quite parse this comment. Copying the neverallows when they are 
not expanded is just strange. A separate function to copy the 
neverallows should be provided.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
