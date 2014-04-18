Message-ID: <53512214.60900@tycho.nsa.gov>
Date: Fri, 18 Apr 2014 09:01:08 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Will Woods <wwoods@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: selinux_init_load_policy() and systemd switch-root
References: <1397770748.3305.386.camel@metroid.usersys.redhat.com>
 <5351203D.7060303@tycho.nsa.gov>
In-Reply-To: <5351203D.7060303@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/18/2014 08:53 AM, Stephen Smalley wrote:
> On 04/17/2014 05:39 PM, Will Woods wrote:
>> Hey all. I have a few questions for you! 
>>
>> * Is it OK to load policy more than once? (e.g. load new policy after 
>>   chroot/switch-root to new system)
> 
> It is certainly ok to load policy any number of times.
> 
>> * If so (and I'm pretty sure that's OK), are we supposed to call
>>   selinux_init_load_policy for each switch-root, or is
>>   selinux_mkload_policy supposed to be sufficient?
> 
> As you note below, only selinux_init_load_policy() does all of the
> (re-)initialization required for reloading policy from a new root;
> selinux_mkload_policy() is only for reloading policy afterward.
> 
>> * What should happen if we switch-root from a system with SELinux
>>   enabled/permissive to one that has SELINUX=disabled? 
> 
> That's not a scenario we've ever considered/supported.  It is not
> possible to disable SELinux at runtime (via /sys/fs/selinux/disable)
> after policy has been loaded; that's a security feature.
> 
>> The problem: Currently, we try to load policy during initramfs. This
>> turns out to be a bad idea: nothing in initramfs is labeled, every
>> process ends up with kernel_t, and so files created in /run or /dev may
>> have the wrong labels.
> 
> Yes, this can only truly work if you put the policy in the initramfs (as
> in Android).
> 
>> So a saner plan would seem to be to let the system load policy as normal
>> (i.e.: do nothing during initramfs, load policy when entering real
>> root), then load the *new* policy when switching to upgrade.img.
> 
> Where does upgrade.img live?  Are you switching to the real root to get
> access to it initially, mounting it, and then switching to it?
> 
>> But: systemd refuses to load policy more than once, for reasons that
>> seem unrelated to loading policy itself[2].
> 
> Yes, we only ever considered/supported the scenario of one "initial"
> policy load followed by subsequent reloads with an already established
> root.  selinux_init_load_policy is actually what used to be directly in
> the init program code, ripped out of it and taken to libselinux.
> 
>> So: maybe it would make sense to have call selinux_init_load_policy()
>> after *every* switch-root?
> 
> Possibly, although obviously that hasn't been tested.
> 
>> We can't just use selinux_mkload_policy() because (as the comment in
>> selinux_init_load_policy() points out) we need to do things like reset
>> the config and re-mount selinuxfs after a chroot.
> 
> Agreed.
> 
>> But it also seems like selinux_init_load_policy() assumes it will only
>> be called once; a later comment says:
>>
>>         /*
>>          * If we failed to disable, SELinux will still be 
>>          * effectively permissive, because no policy is loaded. 
>>          * No need to call security_setenforce(0) here.
>>          */
>>
>> Except: if we were enforcing in the previous root, and the new root
>> requests SELINUX=disabled.. then policy *is* loaded, and we *do* need
>> security_setenforce(0).
>>
>> So: is that just a bug, or is selinux_init_load_policy() really not
>> intended to be called more than once? And if that's the case, how should
>> I re-load config/policy/etc. after a switch-root?
> 
> I guess it is a bug, but note that you cannot truly disable SELinux at
> this point.  So while we could trivially add a security_setenforce(0)
> call here, and that seems harmless, SELinux won't be disabled at that
> point, just permissive and operating under the real root policy?  In
> which case newly created files will be labeled in accordance with that
> policy, and non-permission-related SELinux failures can still occur.
> 
>> Any help / suggestions / comments / questions / expert guidance is very
>> welcome here. 
>>
>> Thanks in advance,
>>
>> -w
>>
>> [1] initramfs and upgrade.img are actually the same image in the current
>> implementation, but that's not really important here.
> 
> Oh, in that case, why do we need to switch to the real root before
> switching to upgrade.img?  Why can't we just switch to upgrade.img directly?
> 
>> [2] The original code[3] seems to be avoiding an infinite loop:
>>   * when systemd v12 starts, it tries to load policy
>>   * if policy loads OK, systemd restarts
>> So in *that* case, yes, systemd needed to load policy *only* once.
>> But these days, selinux_setup() is only called at system startup and
>> after each switch-root, and it doesn't restart systemd. So that's not a
>> problem.
>>
>> [3] http://cgit.freedesktop.org/systemd/systemd/commit?id=c4dcdb9
> 
> The original init model was to load policy and then re-exec so that init
> would transition into the correct domain, but I think systemd (and
> definitely Android init) now use setcon() to switch into the correct
> security context directly and do not re-exec.  So, yes, we likely do not
> need to restart systemd after policy load.

Note however that there may be some policy implications there, e.g. init
may need kernel_t:fd use if it doesn't already have it to continue using
already open file descriptors originally opened while running in kernel_t.
