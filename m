Date: Thu, 29 Nov 2007 09:38:15 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Crispin Cowan <crispin@crispincowan.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@manicmethod.com>,
        Mark Nelson <markn@au1.ibm.com>, containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        menage@google.com, James Morris <jmorris@namei.org>
Subject: Re: [PATCH 2/2] hijack: update task_alloc_security
Message-ID: <20071129153815.GA8140@sergelap.austin.ibm.com>
References: <474B78CB.5070607@au1.ibm.com> <474B7A51.3080300@au1.ibm.com> <474BB095.8080302@manicmethod.com> <1196174188.3925.32.camel@moss-spartans.epoch.ncsc.mil> <20071127154356.GA32362@sergelap.austin.ibm.com> <474D0188.2040600@crispincowan.com> <20071128145422.GC3820@sergelap.austin.ibm.com> <474E3E4E.3060908@crispincowan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <474E3E4E.3060908@crispincowan.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Crispin Cowan (crispin@crispincowan.com):
> Serge E. Hallyn wrote:
> > Quoting Crispin Cowan (crispin@crispincowan.com):
> >   
> >> Is there to be an LSM hook, so that modules can decide on an arbitrary
> >> decision of whether to allow a hijack? So that this "do the right
> >> SELinux" thing can be generalized for all LSMs to do the right thing.
> >>     
> > Currently:
> >
> > 	1. the permission is granted through ptrace
> > 	2. the lsm knows a hijack is going in security_task_alloc()
> > 		when task != current
> >
> > so the lsm has all the information it needs.  But I have no objection
> > to a separate security_task_hijack() hook if you find the ptrace hook
> > insufficient.
> >   
> I find that ptrace, specifically CAP_SYS_PTRACE, is overloaded. AppArmor
> is having problems because we have to choose between granting
> cap_sys_ptrace, or not allowing the process to read /proc/pid/self &
> such like. So there, the problem is that we have to grant too much power
> to a process to just let it read some /proc stuff about itself.
> 
> Here the problem appears to be the other way. cap_sys_ptrace is powerful
> enough to mess with other user's processes on the system, but if ptrace
> gives you hijack, then that seems to give you the power to control
> processes in someone else's namespace.

The user namespace patchset I'm working on right now to start having
signals respect user namespaces introduces CAP_NS_OVERRIDE.  Once that
is in, then hijack would require CAP_NS_OVERRIDE|CAP_SYS_PTRACE.

Of course, since we're considering only allowing HIJACK_NS which is
only allowed into a different namespace, hijack would then always
require CAP_NS_OVERRIDE...

Does that suffice?

If you still prefer an LSM hook, we can add that.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
