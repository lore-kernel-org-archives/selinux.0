Message-ID: <45256F49.1070105@us.ibm.com>
Date: Thu, 05 Oct 2006 15:47:05 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Steve Grubb <sgrubb@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com> <45250F35.6030204@redhat.com>	 <452519BC.1060204@us.ibm.com>	 <1160060310.2132.102.camel@moss-spartans.epoch.ncsc.mil>	 <45252ADE.7080905@us.ibm.com>	 <1160073550.2132.163.camel@moss-spartans.epoch.ncsc.mil>	 <4525629C.90804@us.ibm.com> <1160079125.2132.232.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160079125.2132.232.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-10-05 at 14:53 -0500, Michael C Thompson wrote:
>> Stephen Smalley wrote:
>>> It is cleaner to make the calls unconditional and just let the
>>> configuration vary.  It would be nice if we could do the same thing with
>>> the audit support, just letting libaudit do different things in the
>>> non-LSPP vs. LSPP configurations.
>> What I didn't understand that the desire was to have those actions be 
>> dependent on the suid state of newrole, and not the ability to perform 
>> the actions.
>>
>> It would be possible to stat the newrole binary's permissions to see if 
>> newrole is suid, but we then need to watch out for the possibility that 
>> argv[0] isn't correct, so we'd need to address that (could hardcode into 
>> newrole where it expects to be, for example).
> 
> Not a good idea - too susceptible to caller subversion or a simple
> mistake leading to newrole failing to drop capabilities and/or skipping
> security-relevant processing.
> 
> The best option is to make the calls to audit and to pam be
> unconditional and provide a way in audit and pam configuration to
> effectively make them no-ops (already possible for pam via pam_permit).
> Then only the capability dropping and uid switching has to be
> conditional, and that processing can be based on whether newrole is able
> to perform those actions.
> 
> If that isn't possible for audit, then I guess we just live with audit
> always being generated when the caller has euid 0, regardless of whether
> newrole was suid.  That is better than the alternative.

OK, so this is rather ugly in general, and I don't really like where 
this is heading. However, I do understand the desire to have the 
multi-purpose binary. So here's my thoughts:

Making calls to pam_open_session can work with minor modifications to 
the config file, so there is not a big concern there.

AFAIK, we can't call audit without getting a failure, and I would really 
rather not suppress those errors. It would be possible to add a check to 
make sure that either we have CAP_AUDIT_WRITE or euid=0 or something, 
but I'm not really fond of that.

RedHat: is there going to be a scenario where you are sending out this 
package on a system which doesn't have an audit-aware kernel?

If so, we can probably do the euid check and if euid is non-zero, we 
skip calling to audit. The fallout of that is you would see audit 
records when root, and only root, uses newrole. Again, I am not fond of 
this solution.

Is there no sane way to check if an app is suid? Because this would 
relieve some of the headaches from this.

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
