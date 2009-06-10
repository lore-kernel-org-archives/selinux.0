Date: Wed, 10 Jun 2009 09:59:12 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Linux Containers <containers@lists.osdl.org>,
        Oren Laadan <orenl@cs.columbia.edu>,
        David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morgan <morgan@kernel.org>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 09/10] cr: restore LSM credentials
Message-ID: <20090610145912.GA15224@us.ibm.com>
References: <20090610014412.GA5628@us.ibm.com> <20090610014637.GH5658@us.ibm.com> <1244642042.20265.143.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244642042.20265.143.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Tue, 2009-06-09 at 20:46 -0500, Serge E. Hallyn wrote:
> > Checkpoint and restore task and ipc struct ->security info.
> > (files->f_security yet to be done).
> > 
> > LSM contexts (a string representation of obj->security) are
> > checkpointed as shared objects before any object referencing
> > it.  The object's checkpoint header struct has a reference
> > (h->sec_ref) to the shared object.  A NULL ->security is indicated
> > by h->sec_ref = -1.
> > 
> > At checkpoint time, for each obj->security to be checkpointed,
> > the LSM will be asked (once) to convert it to a string, in memory
> > which the checkpoint subsystem will kfree.  At restart time,
> > the LSM will first return some meaningful token given the
> > checkpointed string.  That token will be passed to per-object-type
> > restore functions (task_restore_context(), shm_restore_security(),
> > etc) where the LSM can determine based on the object type, the
> > caller, and the token, whether to allow the object restore, and
> > what value to actually assign to ->security.  In smack, the
> > token is the actual imported label.  In SELinux, it is a temporary
> > pointer to the sid which the checkpointed context referred to.

Thanks for taking a look.

> Possibly I misunderstand, but it appears that you have a single
> security_context_to_str() hook that tries to take an arbitrary

Yikes, you're right.  And I remember telling myself that wouldn't
work - then apparently I ran into the next problem and forgot.

> ->security pointer for any object type.  I don't believe that is safe,
> as each object type may have its own security structure.

Absolutely.  Which begs the question why it was working for me :)

> There are already LSM hooks to obtain secids for objects (task, ipc,
> inode, sock), and to convert between secid and secctx strings for use by
> the audit subsystem and networking subsystem.  Why can't you just use
> those hooks for getting the secids and then converting them to secctx
> strings later?

I had taken a look at the *_secid() hooks, and think I misunderstood
them.  Using those makes sense;  I'll make that change.

> > In smack, the checkpointed labels are used for both tasks and
> > ipc objects so long as the task calling sys_restart() has
> > CAP_MAC_ADMIN.  Otherwise, if the checkpointed label is different
> > from current_security(), -EPERM is returned.
> > 
> > The basics of SELinux support are there (enough to demonstrate working
> > c/r with SELinux enforcing), but there will need to be new object
> > permissions for restore, so the precise nature of those needs to be
> > discussed.  For instance, do we want to define process:restore
> > and ipc_msg_msg:restore, in which case
> >         allow root_t user_t:process restore
> > would mean that root_t may restart a task and label it user_t?
> 
> I think so, yes.

Ok, I'll define those in the next set.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
