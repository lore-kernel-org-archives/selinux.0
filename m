Message-ID: <4627B5DE.2030907@manicmethod.com>
Date: Thu, 19 Apr 2007 14:33:02 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [PATCH][RFC] selinux: preserve boolean values across policy	reloads
References: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>	 <4627B314.8050103@manicmethod.com> <1177007462.27654.187.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1177007462.27654.187.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-04-19 at 14:21 -0400, Joshua Brindle wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> At present, the userland policy loading code has to go through contortions to preserve
>>> boolean values across policy reloads, and cannot do so atomically.  
>>> As this is what we always want to do for reloads, let the kernel preserve them instead.
>>>
>>>   
>>>       
>> Are there situation where you may want to reset the boolean state to 
>> policy defaults? I can't think of realistic scenarios but if one ever 
>> comes up do we want to provide that facility?
>>     
>
> You can always set them after the load if you want to force them back to
> those defaults.  But I don't think anything is presently using
> load_policy -b.
>
> Alternative model is to make it a policy config flag (which I also
> played with), but then you don't gain anything in libselinux wrt
> removing/reducing the libsepol dependency - you still need sepol
> interfaces to set/clear that flag.
>   
Thats what I was thinking. We could always have an selinuxfs node but 
that is racy. It seems like we need some sort of options struct we can 
send the kernel that is generated at load time and sent before the 
policy so thats its atomic. Would anything else use this? compat_net for 
example?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
