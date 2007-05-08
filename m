Message-ID: <4640C374.3030403@manicmethod.com>
Date: Tue, 08 May 2007 14:37:40 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Basic policy representation
References: <bd4ee6e00a634ac9157f.1178575607@localhost.localdomain>	 <46408CF6.1050409@manicmethod.com>	 <1178636917.25354.28.camel@localhost.localdomain>	 <46409BB6.7040500@manicmethod.com>	 <1178640671.25354.49.camel@localhost.localdomain> <1178644404.6056.85.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1178644404.6056.85.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-05-08 at 12:11 -0400, Karl MacMillan wrote:
>   
>> On Tue, 2007-05-08 at 11:48 -0400, Joshua Brindle wrote:
>>     
> <snip>
>   
>>>>>> +int sepol_policy_create(struct sepol_handle *h, struct sepol_policy **policy)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +	struct sepol_policy *x;
>>>>>> +
>>>>>> +	*policy = NULL;
>>>>>> +	x = calloc(1, sizeof(struct sepol_policy));
>>>>>>   
>>>>>>       
>>>>>>             
>>>>> I am adverse to calloc used on structs, this implicitly initializes the 
>>>>> struct and makes it harder to update the initial state. Why not have an 
>>>>> explicit initializer?
>>>>>
>>>>>     
>>>>>           
>>>> I like calloc because you don't have to explicitly set all of the
>>>> members and the code tends (in my experience) to be more reliable in the
>>>> face of change because of this. I don't have a strong opinion though -
>>>> what do others think?
>>>>
>>>>   
>>>>         
>>> an initializer that does memset would be just as reliable in the face of 
>>> change and have the additional advantage of being maintainable when 
>>> initial state changes.
>>>
>>>       
>> I think I'm missing something - what is the difference between malloc +
>> memset and calloc? And what do you mean by initializer?
>>     
>
> I'd say stay with calloc here.
>
>   

Umm, and then when the initial state changes we have to audit every user 
of the struct to make sure its initialized correctly instead of just 
doing it from the beginning and using an initialization function?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
