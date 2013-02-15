Message-ID: <511E7C2A.1070101@tycho.nsa.gov>
Date: Fri, 15 Feb 2013 13:19:22 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Luis Ressel <aranea@aixah.de>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux enforcing
 mode
References: <20130214222502.2f7d657c@gentp.lnet> <511E38E7.4040609@tycho.nsa.gov> <20130215150649.22c20d5c@gentp.lnet> <511E45F6.4030300@tycho.nsa.gov> <20130215160240.47e8d1da@gentp.lnet> <511E5568.90103@tycho.nsa.gov> <20130215170749.624be7b1@gentp.lnet>
In-Reply-To: <20130215170749.624be7b1@gentp.lnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/15/2013 11:07 AM, Luis Ressel wrote:
> On Fri, 15 Feb 2013 10:34:00 -0500
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>> Output from the printk was what?
>> Also of interest would be avd->allowed, avd->auditdeny, from_access.
>
> I attached a syslog snippet.

Easier to read if you use %x for the access vectors - perms, allowed, 
auditdeny, put everything into a single printk statement so that there 
is no potential for interleaving of the output and put a newline (\n) at 
the end of that printk so we don't end up with mixed output on lines. 
You could also compute the set of denied permissions (perms & ~allowed) 
and the set of permissions to be audited (denied & auditdeny) and 
display those for convenience. But anyway, let's look at this one:

avc_has_perm_noaudit(1, 3, 7, 8388608, 0, &avd)
allowed: 65536, auditdeny: -8388609, from_access: 0
cgroup_addrm_files: failed to add cgroup.procs, err=-13

Mapping to slightly more readable output, that would be:
avc_has_perm_noaudit(1, 3, 7, 0x800000, 0, &avd)
allowed: 0x10000, auditdeny: 0xff7fffff, from_access: 0

So in this situation, the requested permission is in fact not allowed, 
but it is masked out of auditdeny, so it will not be audited. 
Presumably you booted this time with a policy that has dontaudit rules; 
otherwise your auditdeny vectors would have all permission bits set. 
The kernel is functioning correctly there but your policy is denying 
access and silencing the audit message.

If we try to map this to more readable output using 
security/selinux/flask.h and security/selinux/av_permissions.h, we have:

avc_has_perm_noaudit(SECINITSID_KERNEL, SECINITSID_UNLABELED, 
SECCLASS_DIR, DIR__SEARCH, 0, &avd)
allowed: DIR__MOUNTON, auditdeny: <everything except DIR__SEARCH>

We can map the SIDs because the SIDs in that case happen to be 
predefined SIDs as opposed to dynamically allocated ones; otherwise we 
need security_sid_to_context() to look them up, which is what 
avc_audit() will do for us.  So this was a directory search denial 
between the kernel context and the unlabeled context.

On the policy side, I think the problem is that your policy doesn't 
include the unconfined module (so kernel is confined) while not granting 
sufficient permissions individually.  I still don't understand why you 
aren't getting avc denials if you truly stripped the dontaudit rules but 
I can't tell that from this log - this log was clearly of a policy that 
has dontaudit rules.







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
