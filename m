Message-ID: <434C41D9.7010206@tresys.com>
Date: Tue, 11 Oct 2005 18:51:05 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	<1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	<1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	<1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>	<1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>	<4346CE4C.1030201@tresys.com>	<1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>	<4346D745.6080203@tresys.com>	<1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>	<4346DD70.1070806@tresys.com> <1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-10-07 at 16:41 -0400, Joshua Brindle wrote:
> 
>>Sure, setting the policy version is probably not useful for most users, 
>>it's more of a development/debugging option than anything.
>>
>>What if the user wants to build a policy for the new kernel he just 
>>installed? I guess a rebuild/reload after booting the kernel isn't bad, 
>>although we don't provide a way to do that without starting a 
>>transaction in the store.
> 
> 
> libsemanage doesn't appear to support just building a policy without
> loading it AFAICS.  And load_policy no longer honors the path argument,
> so it will always load a version <= security_policyvers() for the
> current kernel.
> 
right.

> Also, I just noticed that:
> 1) semanage_install_active() blindly uses security_policyvers() as the
> version suffix for the running policy path even prior to my changes,
> without considering sh->conf->policyvers at all, and
> 2) semanage_install_sandbox() similarly constructs a running policy path
> based solely on security_policyvers(), but never uses it.
> 

Why are we still adding the policy version if we aren't going to support 
building different versions anyway.

In the case of multiple kernels with different supported versions this 
could be detrimental in the case that, for example, a version 18 policy 
is built, the kernel is upgraded, a version 20 policy is built, the 
policy is changed, modules/users/whatever added. Then an older kernel is 
booted and loads the stale version 18 policy..

I'm not exactly sure how to handle this situation but this scenerio 
seems undesirable.

> Patch below fixes this logic to make (1) consistent with the version
> selection in semanage_expand_sandbox (i.e. use security_policyvers() if
> it is in the range supported by the shared libsepol, otherwise use the
> sh->conf->policyvers, which will be sepol_policy_kern_vers_max() by
> default), and drops the dead code from (2).  But note that in the case
> where semanage.conf sets the policy version to anything other than the
> default, load_policy won't know about it, and no longer honors the path
> argument, so it won't load that policy.  I think I'll change
> selinux_mkload_policy to also check whether security_policyvers() falls
> outside of the libsepol supported range and fall back to
> sepol_policy_kern_vers_max() in that case.  But the policy version
> setting in semanage.conf is still useless.
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
