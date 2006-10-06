Message-ID: <45268D9A.3060207@redhat.com>
Date: Fri, 06 Oct 2006 13:08:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Steve Grubb <sgrubb@redhat.com>, Michael C Thompson <thompsmc@us.ibm.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com>	 <200610051748.06669.sgrubb@redhat.com>	 <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>	 <200610061134.27916.sgrubb@redhat.com> <1160151252.12253.144.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160151252.12253.144.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-10-06 at 11:34 -0400, Steve Grubb wrote:
>   
>> On Friday 06 October 2006 10:52, Stephen Smalley wrote:
>>     
>>> Dan had suggested only making newrole suid under the LSPP configuration,
>>> leaving it non-suid otherwise, and having newrole dynamically test
>>> whether it is suid (which it cannot actually do precisely) to decide
>>> whether or not to perform privileged operations.
>>>       
>> It can easily test for CAP_SYS_ADMIN, CAP_DAC_OVERRIDE.
>>     
>
> True.  That still has the same issue of yielding a "false" positive when
> the caller was already uid 0.
>
>   
>>> This was motivated by the desire to not expose non-LSPP systems
>>> (particularly a stock system with targeted policy) to greater risk, since
>>> the changes to newrole for pam_namespace leave it much more privileged than
>>> your earlier changes for audit.
>>>       
>> So, in a higher assurance deployment we will have something more powerful that 
>> is not being used by the majority of users? If its dangerous for general 
>> deployment, it would be dangerous for higher assurance, too.
>>     
>
> That's why Michael is working on making newrole more paranoid about its
> caller.  But in the "general deployment" there is no functional need for
> a privileged newrole, so there is no benefit to making it privileged
> there and there is risk.  The risk in fact is _greater_ in the general
> deployment if you make newrole privileged because neither newrole nor
> its caller are confined in -targeted policy, so you have _only_ DAC
> protections and you've just removed almost all DAC restrictions from
> newrole.  Whereas under -strict or -mls, you further have SELinux
> protection/isolation of newrole's domain, and the caller is much more
> limited.  
>
>   
>> You know, it occurs to me that we would not need newrole if we were able to 
>> chose a role at login. We used to be able to do that a long time ago. Maybe 
>> that solves all the problems? Need to change roles...log out and log in.
>>     
>
> Well, I would certainly be glad to see such support restored and
> expanded (e.g. to include gdm).  But there was resistance to that from
> RH in the past.
>   
This causes problems with Root apps that use su to transition to a 
different uid, which prompted the creation of runuser, and end up with 
the app frozen waiting for the file context to be chosen.    Since su no 
longer uses pam_selinux this is less of a problem.  Also the multiple 
flag sometimes returned login domains that made no sense.  I would not 
have a problem with adding it back, but I would prefer it turned off by 
default.  So MLS/Strict people could turn it on, but targeted would 
leave it off.

>   
>>> Possibly, but if we can just call audit_open() unconditionally and use
>>> get_auditfail_action() to decide how to handle an error, then I don't
>>> think we need to do any checking of suid or capability first.  
>>>       
>> What if they don't have audit compiled into their kernel but want 
>> pam_namespace? Weird, but people are like that.
>>     
>
> Not sure why that presents a problem if newrole unconditionally calls
> audit_open() but uses get_auditfail_action() to decide how to handle an
> error (in that case, they presumably have it configured to ignore
> failures since they built their kernel without support for it).  
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
