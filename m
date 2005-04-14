Subject: RE: dcache_lock deadlock due to auditing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel H Jones <danjones@us.ibm.com>, linux-audit@redhat.com,
   selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <20050414203549.46129.qmail@web51510.mail.yahoo.com>
References: <20050414203549.46129.qmail@web51510.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 16:47:05 -0400
Message-Id: <1113511625.2123.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-14 at 13:35 -0700, Steve G wrote:
> >I'm guessing the security context obtained from the SELinux hooks are 
> >is represented by a sid. Is this true? 
> 
> Yes. This patch is already part of the audit subsystem code and on its way
> upstream.

I didn't see the original posting, but the security_getprocattr (->
selinux_getprocattr) and security_inode_getsecurity (->
selinux_inode_getsecurity) hooks copy security contexts into buffers
supplied by the caller.  That is what I was referring to.  The pathname
lookup code would need to be modified to invoke
security_inode_getsecurity(), possibly from audit_inode() by passing the
inode structure to it, and copy the context into the auxiliary item list
on the current audit context for display upon audit_log_exit.  And
audit_log_exit could be modified to call security_getprocattr to get the
current process context and display it.  I don't believe anyone has done
that yet.  There has been a patch to log the exe and comm information
for the current task upon audit_log_exit, but that is different.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
