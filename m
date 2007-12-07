Message-ID: <4759BB7E.3040107@manicmethod.com>
Date: Fri, 07 Dec 2007 16:30:38 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Todd Miller <Tmiller@tresys.com>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [patch 0/2] policy capability support
References: <20071205184848.180973622@tresys.com>	 <200712051421.39624.paul.moore@hp.com>	 <6FE441CD9F0C0C479F2D88F959B0158801455FBA@exchange.columbia.tresys.com>	 <1196883697.16006.103.camel@moss-spartans.epoch.ncsc.mil>	 <4757073B.70907@manicmethod.com>	 <1196886844.16006.117.camel@moss-spartans.epoch.ncsc.mil>	 <47570BAC.3050705@manicmethod.com>	 <1196887806.16006.131.camel@moss-spartans.epoch.ncsc.mil>	 <4757109B.2080209@manicmethod.com>	 <1196954491.27508.15.camel@moss-spartans.epoch.ncsc.mil>	 <475826F2.1000601@manicmethod.com>	 <1196964486.27508.107.camel@moss-spartans.epoch.ncsc.mil>	 <4758684C.9040409@manicmethod.com>	 <1196977378.27508.235.camel@moss-spartans.epoch.ncsc.mil>	 <47595CF5.7020903@manicmethod.com> <1197044809.2569.78.camel@moss-spartans.epoch.ncsc.mil> <4759B857.6050705@redhat.com>
In-Reply-To: <4759B857.6050705@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Stephen Smalley wrote:
>   
>> On Fri, 2007-12-07 at 09:47 -0500, Joshua Brindle wrote:
>>     
>>> Stephen Smalley wrote:
>>>       
>>>> On Thu, 2007-12-06 at 16:23 -0500, Joshua Brindle wrote:
>>>>   
>>>>         
>>>>> Stephen Smalley wrote:
>>>>>     
>>>>>           
>>>>>> On Thu, 2007-12-06 at 11:44 -0500, Joshua Brindle wrote:
>>>>>>   
>>>>>>       
>>>>>>             
>>>>>>> Stephen Smalley wrote:
>>>>>>>     
>>>>>>>         
>>>>>>>               
>>>>>>>> Overall, I have to wonder if we are really buying anything via
>>>>>>>> per-module capability declaration vs. per-policy.  The only reason you
>>>>>>>> tried to make it per-module was you were trying to drop distinctions
>>>>>>>> between base and non-base, right?  But maybe we shouldn't be so
>>>>>>>> concerned with having a notion of a base module even if we reduce the
>>>>>>>> differences between what is supported by base vs. non-base
>>>>>>>>       
>>>>>>>>           
>>>>>>>>                 
>>>>>>> At first that was my reason but after talking it seems like doing it in 
>>>>>>> base is bad for the same reason that allowing a single module to turn on 
>>>>>>> a cap is. Why should base be able to turn on the cap if all the other 
>>>>>>> modules aren't written wrt the cap?
>>>>>>>     
>>>>>>>         
>>>>>>>               
>>>>>> Upgrade of base usually reflects a full policy update, whereas inserting
>>>>>> a random module does not.  And if base doesn't work (e.g. doesn't have
>>>>>> the capabilities it requires), then the system likely won't boot or
>>>>>> function at all (modulo legacy rules).  I'm more comfortable with
>>>>>> letting base dictate the policy capabilities than other modules.
>>>>>>
>>>>>>   
>>>>>>       
>>>>>>             
>>>>> I am not comfortable with base changing anything about other modules. If 
>>>>> base can turn on capabilities without regard to the modules being 
>>>>> installed then everything built as modules that uses network controls 
>>>>> (or whatever future caps affect) suddenly don't work. I also don't want 
>>>>> to just punt on this decision for now because we don't know the answer, 
>>>>> we'll have to answer it eventually if we successfully get rid of the 
>>>>> base vs. module distinction.
>>>>>     
>>>>>           
>>>> If you aren't comfortable with base enabling capabilities without regard
>>>> to the other modules, then you aren't comfortable with the union
>>>> proposal anymore.  So where does that leave you?  With Chris on the
>>>> intersection proposal?  See my comments there.
>>>>
>>>>   
>>>>         
>>> That is correct, as a result of you guys convincing me that union as 
>>> wrong I also believe putting it in base is wrong. The intersection is 
>>> the most compelling to me so far, though it seems like no optimum 
>>> solutions exist. I'm wondering if caps are the right solution to the 
>>> problem at all..
>>>       
>> Well, to re-state the problem:  we want to provide a way of selectively
>> enabling new features (e.g. new checks, switching from one set of checks
>> to another, splitting or folding classes and perms, ...) in the kernel
>> such that no change in behavior occurs until a policy that supports the
>> new features is in place, in particular no userspace breakage.
>> Intersection as a model is very appealing there, as it maximizes
>> compatibility.  The two concerns I have are:
>> - It is prone to never enabling new features at all due to the presence
>> of local modules - it lets local modules drive the rest of the policy
>> rather than the other way around,
>> - It isn't truly defining what features are supported by a given module,
>> only what features were supported by some version of the policy headers
>> against which the module was built, thereby increasing the likelihood
>> that we're unnecessarily disabling caps.
>>
>> When we first talked about the kernel support, my expectation was that
>> the capabilitites would be defined once for the entire policy (as in the
>> kernel policy), and when we upgraded from e.g. F8 policy to F9 policy,
>> that upgrade would turn on the new capabilities in the F9 policy.
>> Ensuring that the user's local modules would keep working entirely has
>> never really been a goal - they should keep allowing the same
>> permissions as before, but there is no promise that new checks weren't
>> defined by the new policy (same as Eric's handle unknown support - once
>> the new policy defines the new perms, local modules are out of luck if
>> they needed to allow them but did not).
>>
>> Remember that what we're trying to prevent here is userspace breakage
>> when someone boots a new kernel with old userspace + policy.  Nothing
>> more.
>>
>>     
> Ok I am confused by all this emails.
>
> You are suggesting that you add a new access control to the kernel the
> kernel will allow all domains access.
>
> Eventually a policy update comes along and tells the kernel it now
> supports the new access control.
>
> At this point any confined domain that did not know about the access
> will get denied, until the policy module is updated.
>
> Is my understanding correct?
>   

This is basically correct. The discussion is where to put the 
declarations of polcaps and how to handle when some modules support them 
and others don't.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
