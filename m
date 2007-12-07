Message-ID: <47595CF5.7020903@manicmethod.com>
Date: Fri, 07 Dec 2007 09:47:17 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Todd Miller <Tmiller@tresys.com>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [patch 0/2] policy capability support
References: <20071205184848.180973622@tresys.com>	 <200712051421.39624.paul.moore@hp.com>	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>	 <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>	 <4757073B.70907@manicmethod.com>	 <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>	 <47570BAC.3050705@manicmethod.com>	 <1196887806.16006.131.camel@moss-spartans.epoch.ncsc.mil>	 <4757109B.2080209@manicmethod.com>	 <1196954491.27508.15.camel@moss-spartans.epoch.ncsc.mil>	 <475826F2.1000601@manicmethod.com>	 <1196964486.27508.107.camel@moss-spartans.epoch.ncsc.mil>	 <4758684C.9040409@manicmethod.com> <1196977378.27508.235.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1196977378.27508.235.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-12-06 at 16:23 -0500, Joshua Brindle wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Thu, 2007-12-06 at 11:44 -0500, Joshua Brindle wrote:
>>>   
>>>       
>>>> Stephen Smalley wrote:
>>>>     
>>>>         
>>>>> Overall, I have to wonder if we are really buying anything via
>>>>> per-module capability declaration vs. per-policy.  The only reason you
>>>>> tried to make it per-module was you were trying to drop distinctions
>>>>> between base and non-base, right?  But maybe we shouldn't be so
>>>>> concerned with having a notion of a base module even if we reduce the
>>>>> differences between what is supported by base vs. non-base
>>>>>       
>>>>>           
>>>> At first that was my reason but after talking it seems like doing it in 
>>>> base is bad for the same reason that allowing a single module to turn on 
>>>> a cap is. Why should base be able to turn on the cap if all the other 
>>>> modules aren't written wrt the cap?
>>>>     
>>>>         
>>> Upgrade of base usually reflects a full policy update, whereas inserting
>>> a random module does not.  And if base doesn't work (e.g. doesn't have
>>> the capabilities it requires), then the system likely won't boot or
>>> function at all (modulo legacy rules).  I'm more comfortable with
>>> letting base dictate the policy capabilities than other modules.
>>>
>>>   
>>>       
>> I am not comfortable with base changing anything about other modules. If 
>> base can turn on capabilities without regard to the modules being 
>> installed then everything built as modules that uses network controls 
>> (or whatever future caps affect) suddenly don't work. I also don't want 
>> to just punt on this decision for now because we don't know the answer, 
>> we'll have to answer it eventually if we successfully get rid of the 
>> base vs. module distinction.
>>     
>
> If you aren't comfortable with base enabling capabilities without regard
> to the other modules, then you aren't comfortable with the union
> proposal anymore.  So where does that leave you?  With Chris on the
> intersection proposal?  See my comments there.
>
>   

That is correct, as a result of you guys convincing me that union as 
wrong I also believe putting it in base is wrong. The intersection is 
the most compelling to me so far, though it seems like no optimum 
solutions exist. I'm wondering if caps are the right solution to the 
problem at all..

> When does base get updated?  When we are updating the entire policy,
> typically all in a single libsemanage transaction.  At what time do we
> want to gain new capabilities?  When we are updating the entire policy.
> What capabilities do we want audit2allow-generated modules to inherit?
> The same as the base system policy.
>
>   

Yes base gets updated when the entire policy is updated, that one is 
fair. as for audit2allow, base system policy != base module.

> Where would the policycap statements come from if we kept them
> per-module?  From the policy_module definition provided by...the base
> policy against which the module was built.
>
>   
policy_module is just a macro from refpolicy, it has nothing to do with 
base vs. non-base.

> Maybe I'm missing something but it all leads back to the base module
> providing the definitions, and if we're moving toward link-time
> expansion of interfaces, then they'll end up coming from the base module
> at link time anyway then.
>   

Well, interfaces aren't necessarily in base. corenetwork is in base by 
necessity now because of limitations on the module language. When that 
limitation goes away I'd hope corenetwork would not be in base. That 
would leave base as basically object class definitions, which makes its 
ability to determine the capabilities questionable since it won't even 
have rules (the rules which determine with caps are actually in use)

> As for base vs. non-base, I'm all for making non-base modules more
> functional, but that doesn't mean that semodule -b is going away
> (compatibility of user interfaces and all that) or that we can't retain
> a notion of a special base module that defines certain policy-wide
> properties (a useful thing, even if the rest of the policy is fully
> modularized).
>
>   

Chris says there will always be the concept of a base in refpolicy, that 
is fine with me. What I want to get rid of us the code treating base 
specially and this would be yet-another way we treat it specially that 
would have to be removed later (and we'd have to figure out how to 
handle it then anyway, we are just punting the decision for now.. boo )


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
