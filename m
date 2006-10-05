Message-ID: <4525629C.90804@us.ibm.com>
Date: Thu, 05 Oct 2006 14:53:00 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com> <45250F35.6030204@redhat.com>	 <452519BC.1060204@us.ibm.com>	 <1160060310.2132.102.camel@moss-spartans.epoch.ncsc.mil>	 <45252ADE.7080905@us.ibm.com> <1160073550.2132.163.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160073550.2132.163.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-10-05 at 10:55 -0500, Michael C Thompson wrote:
>> Stephen Smalley wrote:
>>> On Thu, 2006-10-05 at 09:42 -0500, Michael C Thompson wrote:
>>>> Daniel J Walsh wrote:
>>>>> Does the code continue to work correctly if I compile in AUDIT_LOG_PRIV 
>>>>> and NAMESPACE_PRIV but run it without the setuid bit and as a normal 
>>>>> user.  IE, We want the option to only set this setuid when in an MLS 
>>>>> environment.  This is not required for targeted or strict policy machines.
>>>> What happens (currently), is it attempts to drop capabilities and if it 
>>>> can't do that, newrole fails and exists. The reason I chose this 
>>>> behavior is, as I figured, if you have compiled newrole with 
>>>> AUDIT_LOG_PRIV or NAMESPACE_PRIV, you requiring that behaviour.
>>>>
>>>> It should be easy to change this behavior, as I expect RH will want a 
>>>> single compiled binary that can do it all, right? :)
>>>>
>>>> Suggested patch attached. If you have a more elegant solution, feel free 
>>>> to let me know.
>>> Concerns with this approach:
>>> 1) The geteuid() test is ambiguous in the case where the caller was
>>> already uid 0 (i.e. root runs newrole).
>> Well, this is a really hackish patch. I could integrate this check into 
>> drop_capabilties, and have it return 0 on success, >0 for ignore 
>> privileged actions, and <0 on real failure. This way its more consolidated.
> 
> That doesn't change the ambiguity in the geteuid() test.  The point is
> that if we want to make certain logic in newrole conditional on whether
> or not newrole is suid, we can't distinguish in the case where the
> caller was already uid 0.  See below.
> 
>>  > For dropping capabilities and
>>> switching uids, this has no real effect since that processing is skipped
>>> when the caller had uid 0.  But it does have an impact on the audit and
>>> namespace functionality.
>> In what way? Either you have the capability to do these actions, or you 
>> don't, right? I can see 4 cases:
>> uid == 0 && euid == 0 : you're root
> 
> Right.  And per your logic, this means that newrole would always try to
> send an audit message and call pam_open/close_session, right?  Even if
> newrole was _not_ marked suid, just by virtue of the fact that the
> caller was uid 0.  Suppose that I have a non-LSPP system and I run
> newrole as root - it will still end up trying to perform those actions.
> 
>>  > Note btw that the
>>> pam_open_session/pam_close_session calls don't strictly require such a
>>> test, since we can always put pam_permit as a session module in the
>>> default pam config.
>> Is that something we would want to rely on though?
> 
> It is cleaner to make the calls unconditional and just let the
> configuration vary.  It would be nice if we could do the same thing with
> the audit support, just letting libaudit do different things in the
> non-LSPP vs. LSPP configurations.

What I didn't understand that the desire was to have those actions be 
dependent on the suid state of newrole, and not the ability to perform 
the actions.

It would be possible to stat the newrole binary's permissions to see if 
newrole is suid, but we then need to watch out for the possibility that 
argv[0] isn't correct, so we'd need to address that (could hardcode into 
newrole where it expects to be, for example).

With this approach, we would either attempt to perform the privileged 
actions we've been compiled with, or not. Audit would always be 
performed, and pam_open_session would always be called, but we could 
disable the namespace actions through the pam.d file. Is this approach 
acceptable?

>>> 2) I'm not sure how RH plans to set and maintain the suid bit on newrole
>>> in the LSPP case, since they want to have it off by default.  If another
>>> package, like the lspp package, modifies the suid bit on newrole, then a
>>> rpm -V policycoreutils will report a change in mode from the package
>>> defaults and any update of policycoreutils could reset the mode to the
>>> original one.
> 
> This remains a problem AFAICS.

Yup, can't really weigh in on that though.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
