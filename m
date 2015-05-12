Message-ID: <5551F886.40100@tycho.nsa.gov>
Date: Tue, 12 May 2015 08:56:38 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com> <5550B1FE.5040304@tycho.nsa.gov>
 <5550B368.5020600@redhat.com> <5550B663.1070000@tycho.nsa.gov>
 <5550B6D4.4070002@tycho.nsa.gov> <5550B899.7060603@redhat.com>
 <5550C212.6090702@tycho.nsa.gov> <5551F7F4.5050907@redhat.com>
In-Reply-To: <5551F7F4.5050907@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/12/2015 08:54 AM, Petr Lautrbach wrote:
> On 05/11/2015 04:52 PM, Stephen Smalley wrote:
>> On 05/11/2015 10:11 AM, Petr Lautrbach wrote:
>>> On 05/11/2015 04:04 PM, Stephen Smalley wrote:
>>>> On 05/11/2015 10:02 AM, Stephen Smalley wrote:
>>>>> On 05/11/2015 09:49 AM, Petr Lautrbach wrote:
>>>>>> On 05/11/2015 03:43 PM, Stephen Smalley wrote:
>>>>>>> On 05/11/2015 09:40 AM, Petr Lautrbach wrote:
>>>>>>>> On 04/17/2015 03:42 PM, Stephen Smalley wrote:
>>>>>>>>> SELinux can be disabled via the selinux=0 kernel parameter or via
>>>>>>>>> /sys/fs/selinux/disable (triggered by setting SELINUX=disabled in
>>>>>>>>> /etc/selinux/config).  In either case, selinuxfs will be unmounted
>>>>>>>>> and unregistered and therefore it is sufficient to check for the
>>>>>>>>> selinuxfs mount.  We do not need to check for no-policy-loaded and
>>>>>>>>> treat that as SELinux-disabled anymore; that is a relic of Fedora Core 2
>>>>>>>>> days.  Drop the no-policy-loaded test, which was a bit of a hack anyway
>>>>>>>>> (checking whether getcon_raw() returned "kernel" as that can only happen
>>>>>>>>> if no policy is yet loaded and therefore security_sid_to_context() only
>>>>>>>>> has the initial SID name available to return as the context).
>>>>>>>>>
>>>>>>>>> May possibly fix https://bugzilla.redhat.com/show_bug.cgi?id=1195074
>>>>>>>>> by virtue of removing the call to getcon_raw() and therefore avoiding
>>>>>>>>> use of tls on is_selinux_enabled() calls.  Regardless, it will make
>>>>>>>>> is_selinux_enabled() faster and simpler.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This patch breaks system with SELinux enabled kernel and without
>>>>>>>> loaded/installed an SELinux policy, see [1].
>>>>>>>>
>>>>>>>> Would it be feasible to have is_selinux_enabled() connected to existence
>>>>>>>> of SELINUX variable in /etc/selinux/config file for the cases when
>>>>>>>> there's no specific kernel command line option used in running system?
>>>>>>>> Or would it break something else?
>>>>>>>>
>>>>>>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1219045
>>>>>>>
>>>>>>> Sorry, does this occur even if they have SELINUX=disabled in
>>>>>>> /etc/selinux/config?
>>>>>>
>>>>>> It works with SELINUX=disabled. It's only related to systems without
>>>>>> /etc/selinux/config and without selinux=0 on kernel command line.
>>>>>
>>>>> I see.  So I can see that it is a regression for such systems, but such
>>>>> systems are definitely running suboptimally by NOT disabling SELinux if
>>>>> they are not going to even load a policy.  They are just wasting all of
>>>>> the SELinux hook call overhead in the kernel.
>>>
>>> I agree.
>>>
>>>>>
>>>>> In any event, one of the benefits of the change that caused this
>>>>> regression is that it makes is_selinux_enabled() very fast and avoids
>>>>> any need to open any extra files on calls to it, thereby improving
>>>>> performance on both SELinux-enabled and SELinux-disabled systems.
>>>>>
>>>>> I don't think we need or want to actually have it read
>>>>> /etc/selinux/config and look for a SELINUX= variable.  Isn't it
>>>>> sufficient to test for the existence of an /etc/selinux/config file,
>>>>> e.g. access("/etc/selinux/config", F_OK)?
>>>
>>> I'm fine with that.
>>>
>>>>>
>>>>> We'll have to wrap that test with #ifndef ANDROID as Android does not
>>>>> use /etc/selinux/config.
>>>>
>>>> Oh, and let's do it once in init_selinuxmnt() and cache the result so we
>>>> aren't calling access() on each is_selinux_enabled() call.
>>>
>>> Do you want me to prepare and send a patch?
>>
>> See if my patch solves the problem.  I do however see one other
>> potential scenario that could occur in Fedora, i.e. where they have
>> selinux-policy installed (and thus have an /etc/selinux/config) but do
>> not have selinux-policy-targeted installed (and thus do not have any
>> /etc/selinux/targeted).  Not sure how far down this path we should travel...
>>
> 
> The patch solves the problem. Thanks.
> 
> I would say that a system with /etc/selinux/config with
> SELINUXTYPE=targeted and without targeted policy is misconfigured. A
> problem could with an empty config file but it's probably a minor corner
> case.

Agreed.  BTW, in trying to test these scenarios, I did a yum remove
selinux-policy-targeted at one point and was surprised to find that I
couldn't subsequently do a yum install selinux-policy-targeted.  It
would always fail.  Ultimately I found that if I created an empty
/etc/selinux/targeted/contexts/files/file_contexts file and then tried
installing it, it would work.  So I guess rpm -i fails if there is no
file_contexts file?  That doesn't seem right.
