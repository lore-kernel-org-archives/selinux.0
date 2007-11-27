Date: Tue, 27 Nov 2007 10:01:27 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Mark Nelson <markn@au1.ibm.com>, containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        menage@google.com, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH 2/2] hijack: update task_alloc_security
Message-ID: <20071127160127.GC32362@sergelap.austin.ibm.com>
References: <474B7A51.3080300@au1.ibm.com> <820903.72193.qm@web36603.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <820903.72193.qm@web36603.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Casey Schaufler (casey@schaufler-ca.com):
> 
> --- Mark Nelson <markn@au1.ibm.com> wrote:
> 
> > Subject: [PATCH 2/2] hijack: update task_alloc_security
> > 
> > Update task_alloc_security() to take the hijacked task as a second
> > argument.
> 
> Could y'all bring me up to speed on what this is intended to
> accomplish so that I can understand the Smack implications?

It's basically like ptracing a process, forcing it to fork, then having
the child execute a file and continue as your child.  It takes part of
its state from the current process (stack etc), some from the hijacked
process (namespaces, keys?), and an lsm can decide for itself whose ->security
should be used for the child process.

There are a few reasons to do this.  One is to do an admin activity
inside a private namespace, i.e. doing a new mount in a vserver in which
only websphere is running.

Paul has another use for it - basically (iiuc) wanting to be able to
keep a set of namespaces around which he can always enter.  For mounts
namespaces that can be accomplished independent of hijack by setting up
a private mount tree and pivot_root()ing into there.  But for other
namespaces that isn't an option.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
