Message-ID: <511E5568.90103@tycho.nsa.gov>
Date: Fri, 15 Feb 2013 10:34:00 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Luis Ressel <aranea@aixah.de>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux enforcing
 mode
References: <20130214222502.2f7d657c@gentp.lnet> <511E38E7.4040609@tycho.nsa.gov> <20130215150649.22c20d5c@gentp.lnet> <511E45F6.4030300@tycho.nsa.gov> <20130215160240.47e8d1da@gentp.lnet>
In-Reply-To: <20130215160240.47e8d1da@gentp.lnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/15/2013 10:02 AM, Luis Ressel wrote:
> On Fri, 15 Feb 2013 09:28:06 -0500
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>> So, just to be clear, you are saying that avc_has_perm_noaudit() is
>> getting a denial (i.e. denied != 0) but you are never getting an avc
>> denied message even with no dontaudit rules?
>
> I know this sounds strange, but that's exactly what it looks like to me
> at the moment. (I'm a SELinux beginner, though)
>
>> You could call slow_avc_audit() directly to display the arguments in
>> a meaningful format.
>
> I did the following in hooks.c:
>
>           rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
> +        if (rc == -13)
> +        {
> +            printk(KERN_ERR "avc_has_perm_noaudit(%u, %u, %u, %u, 0, &avd)", sid, isec->sid, isec->sclass, perms);
> +            slow_avc_audit(sid, isec->sid, isec->sclass, perms, 1, 1, NULL, 0);
> +        }
>
> But that also didn't yield any audit messages. The printk call works, however.
> To be honest, I don't know exactly what to fill in for the last 4 arguments.
>
> The call chain leading there is
> cgroup_addrm_files
> cgroup_add_file
> lookup_one_len
> inode_permission
> __inode_permission
> security_inode_permission
> selinux_inode_permission
>
> Inside selinux_inode_permission, avc_has_perm_noaudit returns -ENOACCES
> and avc_audit_required returns 0.

Output from the printk was what?
Also of interest would be avd->allowed, avd->auditdeny, from_access.
In this situation, if you just let it fall through to 
audit_inode_permission() rather than bailing on !audited, you should get 
an avc audit message.  audit_inode_permission() calls slow_avc_audit() 
for you.

Are you sure your audit messages aren't just going to audit.log rather 
than syslog?  That would be the case if auditd has started.

Need to figure out why the kernel isn't auditing the denial for you 
(that's a kernel bug), but the policy bug here is likely that you aren't 
allowing the process to search the cgroup dir.  Don't know anything 
about your policy.








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
