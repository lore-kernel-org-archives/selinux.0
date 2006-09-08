Message-ID: <45017F9A.7090307@us.ibm.com>
Date: Fri, 08 Sep 2006 10:35:06 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, sgrubb@redhat.com, dwalsh@redhat.com,
        tmraz@redhat.com, ltcgcw@us.ibm.com, klaus@atsec.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] newrole: use pam session management services - v4
References: <1157403682.7223.16.camel@localhost.localdomain> <1157467315.4014.105.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1157467315.4014.105.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-09-04 at 17:01 -0400, Janak Desai wrote:
> 
>>This patch updates newrole to allow it to use pam session mangement
>>services. Currently newrole only uses the authenticaion services of
>>pam. Session management services are needed to allow pam_namespace
>>to appropriately reconfigure polyinstantiated namespace for the
>>new session being established with newrole.
>>
>>For newrole to work correctly with pam_namespace, in addtion to
>>this patch, a patch to pam_namespace and a patch to the lssp 
>>policy will also be required. These additional patches will be
>>posted the selinux mailing list following this patch.
>>
>>Changes since v3 of this patch, posted on 8/27/06:
>>    1. Incorporated feedback to v2
>>       a. Create/install an lspp version of newrole.pamd when
>>          building with LSPP_PRIV=y
>>       b. Removed duplicate definition of _GNU_SOURCE
>>       c. Keep CAP_SYS_ADMIN, CAP_FOWNER, CAP_CHOWN and
>>          CAP_DAC_OVERRIDE in permitted set and raise them in the
>>          effective set prior to calling pam session management
>>          functions.
> 
> 
> Implications of retaining those capabilities while still reverting to
> the caller's uid?  ptrace checks capabilities, but e.g. kill does not.
> This is similar to the issues associated with file capabilities, see
> http://marc.theaimsgroup.com/?t=115422220700001&r=1&w=2
> 
> Now, in the case where newrole runs in its own domain, SELinux will
> itself provide isolation/protection, so for the strict/MLS policy,
> newrole should be protected against interference by the caller.  But
> under targeted/MCS, you don't get such guarantees.  But I assume you
> want to build a single newrole binary for everyone.
> 
> Does running in the caller's uid have any other implications for
> pam_namespace, e.g. ownership of the directories it creates?
> 

No, pam_namespace will try and set ownership and mode of the
instance directories that it creates to those of the polyinstantiated
directory. That's why pam_namespace needs those powerful dac
capabilities. Instance parent, by default, is 000. To create
new instances, changing their ownership and mode and to
mount/unmount them requires that pam_namespace have chown,
fowner, dac_override and sys_admin capabilities.

-Janak




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
