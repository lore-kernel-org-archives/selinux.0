Message-ID: <475826F2.1000601@manicmethod.com>
Date: Thu, 06 Dec 2007 11:44:34 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Todd Miller <Tmiller@tresys.com>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [patch 0/2] policy capability support
References: <20071205184848.180973622@tresys.com>	 <200712051421.39624.paul.moore@hp.com>	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>	 <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>	 <4757073B.70907@manicmethod.com>	 <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>	 <47570BAC.3050705@manicmethod.com>	 <1196887806.16006.131.camel@moss-spartans.epoch.ncsc.mil>	 <4757109B.2080209@manicmethod.com> <1196954491.27508.15.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1196954491.27508.15.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-12-05 at 15:56 -0500, Joshua Brindle wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> On Wed, 2007-12-05 at 15:35 -0500, Joshua Brindle wrote:
>>>   
>>>       
>>>> Stephen Smalley wrote:
>>>>     
>>>>         
>>>>> On Wed, 2007-12-05 at 15:16 -0500, Joshua Brindle wrote:
>>>>>   
>>>>>       
>>>>>           
>>>>>> Stephen Smalley wrote:
>>>>>>     
>>>>>>         
>>>>>>             
>>>>>>> On Wed, 2007-12-05 at 14:30 -0500, Todd Miller wrote:
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>>>>> Paul Moore wrote:
>>>>>>>>         
>>>>>>>>             
>>>>>>>>                 
>>>>>>>>> The discussion for this appears to have gone quiet (at least I
>>>>>>>>> haven't seen anything else on this list).  Where do things currently
>>>>>>>>> stand?
>>>>>>>>>           
>>>>>>>>>               
>>>>>>>>>                   
>>>>>>>> At this point I'd be OK with requiring equivalence and throwing an error
>>>>>>>> otherwise.  I do think that this will result in usability issues that we
>>>>>>>> will have to address once people start using the caps.  However, with
>>>>>>>> only
>>>>>>>> a single cap defined so far it is not really possible to know how these
>>>>>>>> will end up being used.
>>>>>>>>         
>>>>>>>>             
>>>>>>>>                 
>>>>>>> We could try to come up with a solution at least for allowing clean
>>>>>>> upgrades from F8 (w/o any caps) to F9 (likely w/ peer cap defined)
>>>>>>> without requiring manual user intervention for dealing with local
>>>>>>> modules.
>>>>>>>
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>>> This was my exact objection to using an intersection or equivalence. IMO 
>>>>>> it is incompatible to require all modules to be the same and to also 
>>>>>> require upgrades to work without manual intervention.
>>>>>>
>>>>>> Do you still think unioning is wrong?
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> Yes, I'm still against (automatic, default) unioning of the capabilities
>>>>> by the linker - that is clearly not a safe default.  semodule could
>>>>> possibly override that behavior based on an option though, at which
>>>>> point the %post scriptlet in the policy rpm could use that option if we
>>>>> wanted to force it w/o user intervention.
>>>>>
>>>>>   
>>>>>       
>>>>>           
>>>> And when a user installs a new module via audit2allow they have to know 
>>>> to select --ignore-stuff-the-modules-say-and-do-something-else-anyway? I 
>>>> don't like this idea either.
>>>>     
>>>>         
>>> Shrug.  Then we'll just go with equivalence only, and the user will have
>>> to remove local modules before upgrade.
>>>   
>>>       
>> Well, Todd just suggested, rather than forcing install (which has 
>> strange semantics anyway since it isn't clear which set of caps would 
>> end up in the kernel policy) we could have an --upgrade-polcaps option 
>> that unions the bitmaps of the modules installed. It isn't pretty but it 
>> requires manual intervention to union them instead of doing so 
>> automatically. This obviously will break local policies that do not 
>> support the cap but need to. The user will have to figure out how to 
>> update those local policies to add the required permissions, this isn't 
>> any different than adding new permission checks to the kernel though.
>>
>> I'm still concerned about audit2allow's ability to decide what caps to 
>> put in a policy module being generated. I also have concerns about new 
>> policy modules that are being written by hand, the users aren't going to 
>> necessarily know what caps are available and why they should care. I'm 
>> sure SLIDE will be able to take care of that though ;)
>>     
>
> Ok, so let's think about where these policycap statements are likely to
> actually originate.
>
> A typical module author won't know what capabilities his module
> requires, and in at least common cases, the capabilities required will
> actually depend on the implementations of the interfaces he is using.
> Thus, a given refpolicy interface will likely include policycap
> statements for the capabilities required by that interface, e.g. the
> network permission interfaces would require the network_peer_controls
> capability if they are implemented using those checks rather than the
> legacy ones.
>
>   

either that or the policy_module macro will define all caps that the 
refpolicy is written with respect to, this should fix audit2allow as well.

> For raw audit2allow output (no refpolicy interface matching),
> audit2allow itself has to determine the capabilities required and insert
> policycap statements accordingly.  Do we still need to support that mode
> of operation, or can we turn on -R by default going forward for
> audit2allow so that we always use refpolicy interfaces?
>
>   

My main concern is audit2allow generated modules that have already been 
generated and the source is no longer available. It would be ashame if 
the people who are actually using selinux and generating local modules 
don't get to take advantage of the new access control because they have 
old non-upgradable modules.

> Also interesting to think about how policycaps get determined for a
> module in a world where refpolicy interfaces are link-time expanded
> rather than compiled into the module - there the actual caps for the
> module won't be known until link.
>
>   

Fortunately I think the module binary format will be long gone by the 
time interfaces are link-time expanded so that may not be a problem.

> Overall, I have to wonder if we are really buying anything via
> per-module capability declaration vs. per-policy.  The only reason you
> tried to make it per-module was you were trying to drop distinctions
> between base and non-base, right?  But maybe we shouldn't be so
> concerned with having a notion of a base module even if we reduce the
> differences between what is supported by base vs. non-base

At first that was my reason but after talking it seems like doing it in 
base is bad for the same reason that allowing a single module to turn on 
a cap is. Why should base be able to turn on the cap if all the other 
modules aren't written wrt the cap?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
