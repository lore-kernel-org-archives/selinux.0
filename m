Subject: Re: Getting the real task name in avc messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: James Morris <jmorris@redhat.com>, Steve G <linux_4ever@yahoo.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <424B27BA.8060706@trustedcs.com>
References: 
	 <Xine.LNX.4.44.0503301704130.15296-100000@thoron.boston.redhat.com>
	 <424B27BA.8060706@trustedcs.com>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 07:30:39 -0500
Message-Id: <1112272239.11216.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-30 at 16:27 -0600, Darrel Goeddel wrote:
> James Morris wrote:
> You could also just do:
> 
> 	task_lock(current);
> 	audit_log_format(ab, " comm=%s", current->comm);
> 	task_unlock(current);
> 
> This avoids an unnecessary copy since we have no use the data after the
> audit_log_format call.

Is this locking truly necessary when accessing current->comm (as opposed
to accessing the comm of another task)?  Can it be set by any other
task?  We don't presently hold the lock when accessing it in avc_audit.

> I really like the idea of moving this functionality to the standard
> syscall audit record.  I'm sure that this would be nice info to have
> for folks who do not run SELinux.

Yes, I think it would be useful; Steve, want to take the updated patch
to linux-audit?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
