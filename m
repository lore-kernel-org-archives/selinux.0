Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2LJwoI3032486
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 15:58:50 -0400
Message-ID: <46018E64.2080704@tycho.nsa.gov>
Date: Wed, 21 Mar 2007 15:58:28 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] refpolicy: experimental X policy -v2
References: <45B938EE.8010303@tycho.nsa.gov>	 <cadfc0e40702131226y3cef4a81h626bcdb264c563ee@mail.gmail.com>	 <45D2498C.3090902@tycho.nsa.gov> <1172602429.11157.48.camel@sgc>	 <46005FD3.8020203@tycho.nsa.gov> <1174496088.30666.11.camel@sgc>
In-Reply-To: <1174496088.30666.11.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2007-03-20 at 18:27 -0400, Eamon Walsh wrote: 
>> Christopher J. PeBenito wrote:
>>> On Tue, 2007-02-13 at 18:28 -0500, Eamon Walsh wrote:
>>>> This is an experimental policy for use with the X userspace object 
>>>> manager.  It includes both unconfined and strict policy and is 
>>>> controlled by a tunable, xwindows_object_manager.  The labeling conf 
>>>> file in the X.org xserver git (XACE-SELINUX branch) assumes that this 
>>>> policy is loaded, i.e. the types listed in that file are defined in this 
>>>> policy.
>>> Unfortunately I didn't get a chance to look at this until today.  It'll
>>> take some time to fully understand all this, but I have some notes from
>>> my initial review inline:
>>>
>>>>  modules/services/xwindows.fc |   13 +
>>>>  modules/services/xwindows.if |  521 +++++++++++++++++++++++++++++++++++++++++++
>>>>  modules/services/xwindows.te |   65 +++++
>>> Eventually this should probably be merged into the xserver module.
>>> Potentially in a tunable, when that support becomes available.  However,
>>> for the purposes of vetting the design, a separate module is fine.
>> I think it's important to distinguish between the policy that governs 
>> the operation of the X server itself and the policy that governs X 
>> applications.  Putting everything into xserver may blur that distinction.
> 
> These are common rules among X client programs that are tied to how the
> enforcement of the X server works, which is why I think it belongs in
> the xserver module.

Look at the example of the /dev/mem access denial.  This issue was 
reported to me even though it's an X server issue, not an X application 
issue.  If I were in charge of managing X application policy on some 
installation, I wouldn't want the kernel policy for the X server jumbled 
in with it.

Just like how we're separating userspace object manager Flask 
definitions from the kernel ones.  In fact, I had originally created an 
entire separate directory "userspace" to use instead of services/. 
Reconsidered that, but still like the idea of separate modules.

> 
>>>> +template(`xwindows_displaymgr_client',`
>>>> +	gen_require(`
>>>> +		class xextension use;
>>>> +	')
>>>> +	xwindows_basic_client($1,$2,$3,$4)
>>>> +	tunable_policy(`xwindows_object_manager',`
>>>> +		# X Protocol Extensions
>>>> +		allow $3 output_xext_t:xextension use;
>>>> +
>>>> +		# allow server grabs
>>>> +		allow $3 $1_xserver_t:xserver { grab ungrab };
>>>> +		allow $3 $1_xserver_t:xinput { getattr activegrab };
>>>> +
>>>> +		# can move the mouse cursor
>>>> +		allow $3 $1_xserver_t:xinput warppointer;
>>>> +
>>>> +		# can set resource manager properties
>>>> +		allow $3 $2_rm_xproperty_t:property { write free };
>>>> +
>>>> +		# can enumerate windows
>>>> +		allow $3 $1_root_window_t:window enumerate;
>>>> +	')
>>>> +')
>>> I suspect this might work as part of xserver_user_client_template(), but
>>> the derived type for the property is going to be a problem.
>> Why is that?  The derived property types should all be defined in the 
>> same module.
>>
>> In this particular case though it's probably safe to say that $1 and $2 
>> will both be "xdm".
> 
> Ok, we'll leave it for now, though I'm not yet 100% convinced.
> 
>> I think a deeper question somewhat related to this is what the prefix on 
>> the X server's domain should be.  In the policy as written I'm assuming 
>> that the user domain prefix $2 and X server domain prefix $1 are 
>> independent.  This is because 1) the xserver runs as xdm_xserver_t when 
>> started from gdm but user_xserver_t when started by user with startx, 
>> and
> 
> Well thats because with startx the user itself is starting up the
> xserver, whereas with a display manager, you don't know the user until
> after the xserver is already running.

Maybe gdm should restart the X server after the user has logged in, or 
the xserver should change its own context.  Both programs already have 
SELinux patches, adding this functionality could be done.


> 
>>  2) because you might want to allow things like sysadm_xdomain_t
>> programs to work on user_xserver_t X servers.  It would be useful to
>> standardize on either always running the X server under a single
>> domain, or always running it with the user prefixed domain.
> 
> 
>>>> +template(`xwindows_resourcemgr_client',`
>>>> +	gen_require(`
>>>> +		class property all_property_perms;
>>>> +	')
>>>> +	tunable_policy(`xwindows_object_manager',`
>>>> +		# X Properties
>>>> +		# can read and write resource manager settings
>>>> +		allow $3 $2_rm_xproperty_t:property { read write };
>>>> +	')
>>>> +')
>>> Not sure why there is no $1.  Do you anticipate this being used outside
>>> of the one use in the patch?  If not, the rule might as well go in the
>>> caller.
> 
> You missed responding on this.
> 

I guess this one could be inlined in the per_user template for now.

But as far as outside callers, there will be external modules that need 
to call at a minimum the basic X client interface in the future to 
authorize their types for X access.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
