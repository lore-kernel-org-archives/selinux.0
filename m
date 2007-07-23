Message-ID: <46A4D0B5.3030401@redhat.com>
Date: Mon, 23 Jul 2007 12:00:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: There is a bug in checkmodule that is driving me nuts
References: <46A11983.5090405@redhat.com>	 <1184970504.14677.6.camel@localhost.localdomain> <1185201029.1998.19.camel@moss-spartans.epoch.ncsc.mil> <46A4BD5F.6070408@redhat.com> <46A4C2A6.80605@mentalrootkit.com>
In-Reply-To: <46A4C2A6.80605@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Daniel J Walsh wrote:
>> Stephen Smalley wrote:
>>> On Fri, 2007-07-20 at 18:28 -0400, Karl MacMillan wrote:
>>>  
>>>> On Fri, 2007-07-20 at 16:22 -0400, Daniel J Walsh wrote:
>>>>   
>>>>> The compiler is mistakenly seeing a
>>>>>
>>>>> gen_requires {
>>>>>        type  xguest_gnome_home_t;
>>>>> }
>>>>>
>>>>> As a redefinition of the type
>>>>>
>>>>>  /usr/bin/checkmodule -M -m guest.tmp -o 
>>>>> guest.mod/usr/bin/checkmodule:  loading policy configuration from 
>>>>> guest.tmp
>>>>> policy/modules/users/guest.te:4:ERROR 'duplicate declaration of 
>>>>> type/attribute' at token ';' on line 55020:
>>>>>         type xguest_gnome_home_t;
>>>>> #line 4
>>>>> /usr/bin/checkmodule:  error(s) encountered while parsing 
>>>>> configuration
>>>>>
>>>>> The problem is the gen_requires happens before the declaration.
>>>>>
>>>>> The type is being declared in  a template file.
>>>>>       
>>>> For better or discarding of requires upon hitting a declaration isn't
>>>> like to be fixed (when the require is first).
>>>>     
>>>
>>> How hard is it to escalate a requires to a decl?
>>> Already happens for users and roles, right?
>>>
>>>  
>>>> I have an alternative suggestion - remove all of the requires from the
>>>> policy and use an sepolgen-based pre-processor to add them back in 
>>>> until
>>>> the policyrep work is done. That will ease the migration and can be 
>>>> done
>>>> far more easily than fixing the current compiler.
>>>>
>>>> Karl
>>>>
>>>>
>>>> -- 
>>>> This message was distributed to subscribers of the selinux mailing 
>>>> list.
>>>> If you no longer wish to subscribe, send mail to 
>>>> majordomo@tycho.nsa.gov with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>     
>> If we resorted Templates before Interfaces, would this problem go away?
>>
>
> Potentially - requires after declarations works fine (the requires is 
> just ignored). The other way around is what is more trouble.
>
> Karl
>
>
>>
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to 
>> majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>
template(`userdom_unpriv_xwindows_login_user', `

userdom_unpriv_login_user($1)
# Should be optional but policy will not build because of compiler problems
# Must be before xwindows calls
#optional_policy(`
    gnome_per_role_template($1, $1_usertype, $1_r)
    gnome_exec_gconf($1_t)
#')

userdom_xwindows_client_template($1)
...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
