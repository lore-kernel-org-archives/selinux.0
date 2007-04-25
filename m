Message-ID: <462FC48B.9040808@manicmethod.com>
Date: Wed, 25 Apr 2007 17:13:47 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
 to libsepol
References: <20070420133430.9884.86379.stgit@localhost.localdomain>	 <1177432926.24282.176.camel@moss-spartans.epoch.ncsc.mil>	 <1177530561.14349.0.camel@localhost.localdomain>	 <462FBE8A.30308@manicmethod.com> <1177535353.14349.5.camel@localhost.localdomain>
In-Reply-To: <1177535353.14349.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
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
>>     
>
> Yeah - I bumped it to 2.1.0. That sound OK or do we want to leave space
> for another release of trunk before the merge?
>
>   
I think thats fine, hopefully this will be the next release, if not we 
can adjust when the time comes.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
