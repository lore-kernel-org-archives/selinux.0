Message-ID: <48B41C67.4080609@redhat.com>
Date: Tue, 26 Aug 2008 11:08:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Vikram Ambrose <Vikram.Ambrose@windriver.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: PAM security transitions
References: <48AF21C3.9020506@windriver.com> <1219664725.2721.4.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1219664725.2721.4.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2008-08-22 at 16:29 -0400, Vikram Ambrose wrote:
>> I've been messing around with various modules and installations and I've 
>> come across a strange PAM problem. Without any SELinux support in 
>> pam.d/login, root's shell gets system_r:local_login_t
> 
> Yes, we stopped patching login directly a long time ago, and thus use of
> pam_selinux is required to get login session contexts set properly.
> 
>> But then using: pam_selinux.so close/open, root's shell gets 
>> root:staff_r:system_chkpwd_t
>>
>> I have another installation with the same pam config, but it gets the 
>> correct root:sysadm_r:sysadm_t context. This system uses a different policy.
>>
>> Trying to debug this. Any ideas why one of my boxes gets the wrong 
>> domain after login?
> 
> Based on your own description, it is presumably a bug in the policy on
> that system.  pam_selinux should map the Linux user to a SELinux user
> via the seusers mapping, then ask the kernel for a list of reachable
> security contexts for that SELinux user from the calling context (e.g.
> system_u:system_r:local_login_t), then order that list based on the
> default_contexts file's entry for the calling context.
> 
> libselinux/utils/getdefaultcon will let you exercise much the same
> logic, e.g.
> 	getdefaultcon vikram system_u:system_r:local_login_t
> 
This often happens if  /etc/selinux/POLICYTYPE/contexts/default_contexts
 and /etc/selinux/POLICYTYPE/context/users/SELINUXUSER_U do not map to
any possible value.

The service will just choose the first context it can transition to

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
