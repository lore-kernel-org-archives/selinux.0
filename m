Message-Id: <200504141606.j3EG6S8R023875@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Serge Hallyn'" <serue@us.ibm.com>
Cc: <selinux@tycho.nsa.gov>, "'James Morris'" <jmorris@redhat.com>,
   <selinux-dev@tresys.com>
Subject: RE: dcache_lock deadlock due to auditing
Date: Thu, 14 Apr 2005 12:06:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1113489017.373.80.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > Deferring the actual audit work to the audit subsystem in a manner
> > similar to what Stephen's recent audit_log_exit() patch did seems one
> > possible way to solve this problem.  Another might be to determine our
> > context before the audit_log_d_path( vma->vm_file->f_dentry ), and, if
> > we can determine that we were called from interrupt, simply print out
> > the f_dentry->d_name.name itself.
> 
> I think that in_softirq can have false positive, so I don't think we
> want to try to test for it in avc_audit.  We could add a flag to the
> avc_audit_data structure so that the caller of avc_has_perm* could
> specify that avc_audit should not attempt to take the dcache lock, but
> that seems ugly.
> 
> The cleanest solution in my mind is to remove all logging of pid, exe,
> and comm from avc_audit as per my patch and handle that entirely in
> audit_log_exit.  But that requires people to enable syscall auditing to
> still get that information for avc denials, and will break compatibility
> for seaudit, requiring it to be modified to acquire that information
> from the subsequent syscall audit record.  One side benefit of this
> solution is that it eliminates the confusion about bogus pid and exe
> information on permission checks that are not performed in process
> context like the socket receive checks and sigio delivery.
> 

We can certainly update seaudit to handle this and it certainly looks like this
is going to have to be done regardless this specific instance in the future. 

Just to be clear, this decision is really to continue the movement away from avc
messages being a complete source for audit message related to SELinux to both
avc and syscall auditing being required to get a full picture. My sense is that
this is the direction that things must go in for technical and political
reasons, though I have to say that my preference would be (for what it's worth)
for SELinux avc audit messages to be complete, self-contained, and be triggered
even with DAC permissions deny access.

At this point, my only real concern is that it be easier for users to get this
information and I simply don't know enough about the audit infrastructure to
know whether this will be the case or not. What kind of configuration will be
required to get the additional syscall audit messages?

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> A less clean solution that preserves compatibility would be to still
> include the pid=, exe=, and comm= information in avc_audit but only
> include the last d_name component of the exe, as you suggest above.
> 
> One item to note is that the current avc_audit code includes support for
> logging information about another task rather than current by having the
> caller set the tsk field of the avc_audit_data structure prior to
> calling avc_has_perm*.  That was originally included for replacing the
> hardcoded capability checks by the OOM killer on possible target tasks
> with calls to the LSM capable hook, but is not presently used as that
> part of the LSM patch was never mainstreamed into 2.6.  I could also see
> that potentially being useful for the task_kill hook, in order to get
> information about the target task other than just its security context,
> although in that case I would want information on both current and the
> target task, which we presently don't allow for.
> 
> > Are there other solutions?
> >
> > Currently the team is testing Stephen's patch (from march 31) to see
> > whether it is sufficient.
> 
> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
