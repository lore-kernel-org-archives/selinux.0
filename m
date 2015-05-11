Message-ID: <5550B1FE.5040304@tycho.nsa.gov>
Date: Mon, 11 May 2015 09:43:26 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com>
In-Reply-To: <5550B134.6050606@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/11/2015 09:40 AM, Petr Lautrbach wrote:
> On 04/17/2015 03:42 PM, Stephen Smalley wrote:
>> SELinux can be disabled via the selinux=0 kernel parameter or via
>> /sys/fs/selinux/disable (triggered by setting SELINUX=disabled in
>> /etc/selinux/config).  In either case, selinuxfs will be unmounted
>> and unregistered and therefore it is sufficient to check for the
>> selinuxfs mount.  We do not need to check for no-policy-loaded and
>> treat that as SELinux-disabled anymore; that is a relic of Fedora Core 2
>> days.  Drop the no-policy-loaded test, which was a bit of a hack anyway
>> (checking whether getcon_raw() returned "kernel" as that can only happen
>> if no policy is yet loaded and therefore security_sid_to_context() only
>> has the initial SID name available to return as the context).
>>
>> May possibly fix https://bugzilla.redhat.com/show_bug.cgi?id=1195074
>> by virtue of removing the call to getcon_raw() and therefore avoiding
>> use of tls on is_selinux_enabled() calls.  Regardless, it will make
>> is_selinux_enabled() faster and simpler.
>>
> 
> This patch breaks system with SELinux enabled kernel and without
> loaded/installed an SELinux policy, see [1].
> 
> Would it be feasible to have is_selinux_enabled() connected to existence
> of SELINUX variable in /etc/selinux/config file for the cases when
> there's no specific kernel command line option used in running system?
> Or would it break something else?
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1219045

Sorry, does this occur even if they have SELINUX=disabled in
/etc/selinux/config?
