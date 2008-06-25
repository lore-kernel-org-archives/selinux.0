Message-ID: <48628E65.8030701@tycho.nsa.gov>
Date: Wed, 25 Jun 2008 14:28:53 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Trying to get XAce policy straightened out but our tool chain
 is too broken to handle it.
References: <48480210.60309@redhat.com>	 <1213625437.15523.71.camel@moss-spartans.epoch.ncsc.mil>	 <485F863B.1040603@redhat.com> <1214227346.11146.237.camel@gorn>
In-Reply-To: <1214227346.11146.237.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Mon, 2008-06-23 at 07:17 -0400, Daniel J Walsh wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Thu, 2008-06-05 at 11:11 -0400, Daniel J Walsh wrote:
>>>       
>
>   
>>>> The problem I have is the compiler is too stupid to understand the
>>>> differences between a gen_requires block defining the required types and
>>>> the actual type definition.
>>>>
>>>> So I end up in a catch 22 where the compiler tells me I need to require
>>>> $1_rootwindow_t, but if I gen_require type $1_rootwindow_t, it tells me
>>>> I have a duplicate definition.
>>>>
>>>> So if you have a derived type in a gen_requires block the compiler can
>>>> not handle it.
>>>>         
>>> I'm a little unclear as to why this is required (why do you need to
>>> require and declare the same symbol again?).  However, is there some
>>> reason we can't just automatically promote a require to a declaration
>>> upon encountering the latter?  Seems like we've talked about this
>>> before.  Not sure whether that should happen within libsepol
>>> symtab_insert() or in the callers, e.g. declare_type().
>>>
>>>       
>> I don't know,  All I know is the compiler complains if it is there and
>> if it is not there.  Catch 22.  I end up going to great lengths to hack
>> around compiler errors...
>>     
>
> We add requires to templates, so that if they're used outside xserver,
> the caller gets the appropriate require.  But then we also use the
> template inside xserver for code reuse, which is where the problem
> creeps up.  There are a couple other examples of this in refpolicy, but
> I was able to work around them by reordering statements.  It sounds like
> Dan's situation may not be something that can be easily worked around
> without some restructuring

I opened a ticket in the refpolicy Trac for this:   
http://oss.tresys.com/projects/refpolicy/ticket/43


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
