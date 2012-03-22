Subject: Re: [next] Null pointer dereference in mls_compute_sid()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Martin Nyhus <martin.nyhus@gmx.com>, selinux@tycho.nsa.gov
In-Reply-To: <1332423869.18538.0.camel@localhost>
References: <20120321231218.2e40fca9@gmx.com>
	 <1332423869.18538.0.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Mar 2012 10:55:20 -0400
Message-ID: <1332428120.10315.25.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'd still be concerned about why a class value of 0 is getting passed
from userspace.  Bug in systemd or libselinux?

On Thu, 2012-03-22 at 09:44 -0400, Eric Paris wrote:
> It should be fixed in today's linux-next!  I'm so sorry about that!
> 
> On Wed, 2012-03-21 at 23:12 +0100, Martin Nyhus wrote:
> > Hi,
> > 
> > while running next-20120321 the class passed in to mls_compute_sid()
> > (tclass) is sometimes 0 which leads to a read from
> > policydb.class_val_to_struct[-1] causing a null pointer dereference
> > when cladatum is used (at mls.c:535).
> > 
> > The crash happens on every boot, just after mounting the filesystem.
> > 
> > Calltrace:
> > security_compute_sid.part.7
> > security_compute_sid
> > security_transition_sid_user
> > ? security_context_to_sid
> > sel_write_create
> > ? might_fault
> > ? _raw_spin_unlock
> > ? sel_write_member
> > selinux_transaction_write
> > vfs_write
> > sys_write
> > system_call_fastpath
> > 
> > 
> > 	Martin Nyhus
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
