Message-ID: <5550B663.1070000@tycho.nsa.gov>
Date: Mon, 11 May 2015 10:02:11 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com> <5550B1FE.5040304@tycho.nsa.gov>
 <5550B368.5020600@redhat.com>
In-Reply-To: <5550B368.5020600@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/11/2015 09:49 AM, Petr Lautrbach wrote:
> On 05/11/2015 03:43 PM, Stephen Smalley wrote:
>> On 05/11/2015 09:40 AM, Petr Lautrbach wrote:
>>> On 04/17/2015 03:42 PM, Stephen Smalley wrote:
>>>> SELinux can be disabled via the selinux=0 kernel parameter or via
>>>> /sys/fs/selinux/disable (triggered by setting SELINUX=disabled in
>>>> /etc/selinux/config).  In either case, selinuxfs will be unmounted
>>>> and unregistered and therefore it is sufficient to check for the
>>>> selinuxfs mount.  We do not need to check for no-policy-loaded and
>>>> treat that as SELinux-disabled anymore; that is a relic of Fedora Core 2
>>>> days.  Drop the no-policy-loaded test, which was a bit of a hack anyway
>>>> (checking whether getcon_raw() returned "kernel" as that can only happen
>>>> if no policy is yet loaded and therefore security_sid_to_context() only
>>>> has the initial SID name available to return as the context).
>>>>
>>>> May possibly fix https://bugzilla.redhat.com/show_bug.cgi?id=1195074
>>>> by virtue of removing the call to getcon_raw() and therefore avoiding
>>>> use of tls on is_selinux_enabled() calls.  Regardless, it will make
>>>> is_selinux_enabled() faster and simpler.
>>>>
>>>
>>> This patch breaks system with SELinux enabled kernel and without
>>> loaded/installed an SELinux policy, see [1].
>>>
>>> Would it be feasible to have is_selinux_enabled() connected to existence
>>> of SELINUX variable in /etc/selinux/config file for the cases when
>>> there's no specific kernel command line option used in running system?
>>> Or would it break something else?
>>>
>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1219045
>>
>> Sorry, does this occur even if they have SELINUX=disabled in
>> /etc/selinux/config?
> 
> It works with SELINUX=disabled. It's only related to systems without
> /etc/selinux/config and without selinux=0 on kernel command line.

I see.  So I can see that it is a regression for such systems, but such
systems are definitely running suboptimally by NOT disabling SELinux if
they are not going to even load a policy.  They are just wasting all of
the SELinux hook call overhead in the kernel.

In any event, one of the benefits of the change that caused this
regression is that it makes is_selinux_enabled() very fast and avoids
any need to open any extra files on calls to it, thereby improving
performance on both SELinux-enabled and SELinux-disabled systems.

I don't think we need or want to actually have it read
/etc/selinux/config and look for a SELINUX= variable.  Isn't it
sufficient to test for the existence of an /etc/selinux/config file,
e.g. access("/etc/selinux/config", F_OK)?

We'll have to wrap that test with #ifndef ANDROID as Android does not
use /etc/selinux/config.
