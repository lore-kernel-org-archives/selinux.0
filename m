Message-ID: <4630AC81.6090709@manicmethod.com>
Date: Thu, 26 Apr 2007 09:43:29 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
 to libsepol
References: <20070420133430.9884.86379.stgit@localhost.localdomain>	 <1177432926.24282.176.camel@moss-spartans.epoch.ncsc.mil>	 <1177530561.14349.0.camel@localhost.localdomain>	 <462FBE8A.30308@manicmethod.com> <1177588173.24282.267.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1177588173.24282.267.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-04-25 at 16:48 -0400, Joshua Brindle wrote:
>   
>> Karl MacMillan wrote:
>>     
>>> On Tue, 2007-04-24 at 12:42 -0400, Stephen Smalley wrote:
>>>   
>>>       
>>>> On Fri, 2007-04-20 at 09:34 -0400, Karl MacMillan wrote:
>>>>     
>>>>         
>>>>> Add a generic iterator data structure and a linked-list implementation
>>>>> based that uses the iterators to libsepol. Includes test cases for the
>>>>> linked-list implementation.
>>>>>
>>>>> This version is updated to remove improper use of void** based on comments 
>>>>> from James Antill.
>>>>>
>>>>> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
>>>>>       
>>>>>           
>>>> For the entire policyrep patch series so far,
>>>>
>>>> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>>>>
>>>> Merge at will.
>>>>
>>>>     
>>>>         
>>> Merged as libsepol 2.0.4.
>>>   
>>>       
>> shouldn't this be 2.1.4 or similar since 2.0.4 will be the next revision 
>> of trunk?
>>     
>
> It doesn't actually matter, as we can update the version just before
> merging to trunk.
>
>   
but if we ever roll up rpm's for testing this branch it will be 
undesirable to have overlapping versions.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
