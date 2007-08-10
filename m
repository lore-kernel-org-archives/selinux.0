Message-ID: <46BC8B3E.40309@manicmethod.com>
Date: Fri, 10 Aug 2007 11:58:54 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinuxfs to globally disable dontaudit rules
References: <1186696737.20393.10.camel@localhost.localdomain>	 <Pine.LNX.4.64.0708091525410.30691@us.intercode.com.au>	 <46BBAE00.7050600@manicmethod.com>  <46BBBDDF.2000307@manicmethod.com> <1186747308.7233.22.camel@moss-spartans.epoch.ncsc.mil> <46BC8476.9010800@redhat.com>
In-Reply-To: <46BC8476.9010800@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Stephen Smalley wrote:
>> On Thu, 2007-08-09 at 21:22 -0400, Joshua Brindle wrote:
>>  
>>> Joshua Brindle wrote:
>>>    
>>>> James Morris wrote:
>>>>      
>>>>> On Thu, 9 Aug 2007, Eric Paris wrote:
>>>>>
>>>>>  
>>>>>        
>>>>>> Currently to disable dontaudit rules best you can do it to load the
>>>>>> enableaudit.pp base policy.  Which still doesn't remove the 
>>>>>> dontaudit
>>>>>> rules from modules.
>>>>>>               
>>>>> Are we sure this can't be done in userspace?  Like, mangle all the 
>>>>> existing policy and reload it?
>>>>>
>>>>>           
>>>> I agree, the infrastructure is certainly in place to do it, just 
>>>> add something in the sepol_handle that says dontaudits should be 
>>>> discarded, then make an interface in libsemanage that uses that and 
>>>> rebuild the policy.
>>>>
>>>> If noone beats me to it I will see if my conclusions about it being 
>>>> fairly simple are accurate this weekend :)
>>>>
>>>>       
>>> I changed my mind, patch below
>>>
>>> it compiles and seems to work after semodule -DB:
>>>     
>>
>> Hmm...doing it this way means that the "disable_dontaudit" behavior
>> won't persist across subsequent policy changes, so if I e.g. then change
>> a boolean persistently, I'll get back all of the dontaudit rules too.
>>
>> Is that what you want, or do you want this flag saved in the policy
>> module store and settable/clearable via semanage to be applied to all
>> subsequent policy builds?
>>
>>   
> This looks great but it needs to survive a policy rebuild as Stephen 
> says.
>

Hrm... I'm trying to figure out if that is really the behavior we want. 
The purpose of this was to let someone get some denials from (possibly) 
dontaudits hiding behavior. After switching dontaudits off the user will 
generate a module with the rules and insert it. Assuming they exercised 
enough of the app he won't want the dontaudits off anymore and will 
happily go about running the app. Are there other use cases where 
dontaudits should be persistently disabled?

If dontaudits are to be persistently disabled I'd rather do it in the 
kernel with eric's patch, mainly because eric's will at least only 
persist until reboot whereas if I added something to libsemanage to make 
it persist it would last across reboots.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
