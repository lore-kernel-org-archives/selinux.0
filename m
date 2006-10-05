Message-ID: <45252ADE.7080905@us.ibm.com>
Date: Thu, 05 Oct 2006 10:55:10 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com> <45250F35.6030204@redhat.com>	 <452519BC.1060204@us.ibm.com> <1160060310.2132.102.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160060310.2132.102.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-10-05 at 09:42 -0500, Michael C Thompson wrote:
>> Daniel J Walsh wrote:
>>> Does the code continue to work correctly if I compile in AUDIT_LOG_PRIV 
>>> and NAMESPACE_PRIV but run it without the setuid bit and as a normal 
>>> user.  IE, We want the option to only set this setuid when in an MLS 
>>> environment.  This is not required for targeted or strict policy machines.
>> What happens (currently), is it attempts to drop capabilities and if it 
>> can't do that, newrole fails and exists. The reason I chose this 
>> behavior is, as I figured, if you have compiled newrole with 
>> AUDIT_LOG_PRIV or NAMESPACE_PRIV, you requiring that behaviour.
>>
>> It should be easy to change this behavior, as I expect RH will want a 
>> single compiled binary that can do it all, right? :)
>>
>> Suggested patch attached. If you have a more elegant solution, feel free 
>> to let me know.
> 
> Concerns with this approach:
> 1) The geteuid() test is ambiguous in the case where the caller was
> already uid 0 (i.e. root runs newrole).

Well, this is a really hackish patch. I could integrate this check into 
drop_capabilties, and have it return 0 on success, >0 for ignore 
privileged actions, and <0 on real failure. This way its more consolidated.

 > For dropping capabilities and
> switching uids, this has no real effect since that processing is skipped
> when the caller had uid 0.  But it does have an impact on the audit and
> namespace functionality.

In what way? Either you have the capability to do these actions, or you 
don't, right? I can see 4 cases:
uid == 0 && euid == 0 : you're root
uid == 0 && euid != 0 : you're root with euid non-0
                         (not sure why you would have this)
uid != 0 && euid == 0 : non-root running suid newrole
uid == 0 && euid != 0 : non-root running non-suid newrole

In the case you are root with non-0 euid, this would ignore the 
privileged actions, although I suspect you would still have the 
capabilities to do them (being root and all)?

 > Note btw that the
> pam_open_session/pam_close_session calls don't strictly require such a
> test, since we can always put pam_permit as a session module in the
> default pam config.

Is that something we would want to rely on though?

> 2) I'm not sure how RH plans to set and maintain the suid bit on newrole
> in the LSPP case, since they want to have it off by default.  If another
> package, like the lspp package, modifies the suid bit on newrole, then a
> rpm -V policycoreutils will report a change in mode from the package
> defaults and any update of policycoreutils could reset the mode to the
> original one.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
