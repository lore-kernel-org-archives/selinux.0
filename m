Message-ID: <4790D956.6050300@manicmethod.com>
Date: Fri, 18 Jan 2008 11:52:38 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] REFPOL: Add "rogue" Fedora packet class permissions
References: <20080117172246.341834342@hp.com> <478FA8C3.40600@manicmethod.com>	 <1200598421.7025.73.camel@moss-spartans.epoch.ncsc.mil>	 <1200663127.4595.23.camel@gorn> <7e0fb38c0801180706s130ff8cbv769f91fe18789f36@mail.gmail.com>
In-Reply-To: <7e0fb38c0801180706s130ff8cbv769f91fe18789f36@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On 1/18/08, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
>   
>> On Thu, 2008-01-17 at 14:33 -0500, Stephen Smalley wrote:
>>     
>>> On Thu, 2008-01-17 at 14:13 -0500, Joshua Brindle wrote:
>>>       
>>>> Paul Moore wrote:
>>>>         
>>>>> At some point in the Fedora 6 timeframe the "flow_in" and "flow_out"
>>>>> permissions were added to the "packet" class, most likely as part of the
>>>>> ill-fated secid-reconciliation effort.  Despite the fact that these permissions
>>>>> are not currently used they should be included in the Reference Policy as they
>>>>> are now a permanent fixture in Fedora and it is crucial that the FLASK
>>>>> defines be kept in sync.
>>>>>
>>>>> This patch needs to be applied before any other patches that affect the
>>>>> "packet" class, otherwise the resulting policy may not load.
>>>>>           
>>>> This also points out how much of a bad idea it is to add object
>>>> class/perm definitions into distro policies before they are in
>>>> refpolicy, I hope that this will be avoided in the future.
>>>>         
>> Definitely.
>>     
>
> Dan and I are both well aware of this and I think we can all be
> certain it won't happen again.
>
>   

I'm fine with drilling it in just to make sure ;)

>>> This all came up because akpm reported the failure on his FC6 test box
>>> with latest -mm.
>>>       
>
> failure == kernel panic
>
>   
>>> I suggested just using flow_in/flow_out instead of
>>> forward_in/forward_out for Paul's new controls so that we don't have any
>>> unused permissions, but Paul and Eric want the more precise names.
>>>       
>> I strongly agree with Stephen's suggestion.  Do we have a strategy for
>> eventually reclaiming these permissions if we don't reuse them right
>> now?
>>     
>
> I'm willing to do the kernel work to support NULL names for these
> permissions and maybe in 5 years or so we will all feel comfortable
> reusing them (basically the same situation we are in for things like
> unused classes we carry around for PAX, we can't reclaim it till we
> can be sure everything that ever used it is dead).  But labeled net is
> convoluted and difficult enough without even the slightest of
> misdirection of permission names.  If down the road people search teh
> intarwebz on flow_in they are going to get back to all of venkat's old
> discussions of 'flow.'  This isn't what we want.
>
>   

I think we know the Pax object class isn't being used anymore. One thing 
on our long list is to fix up the kernel to request object class and 
perm values similarly to the work done to do that from userspace last 
year. Once that is done we can hopefully do a wholesale cleaning of 
unused values.

> I know it sucks and fedora screwed up on this one getting a little
> overzelous trying to stay ahead of the development game but at this
> point lets waste that 50 bytes of memory or whatever so down the road
> we don't have issues.
>   




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
