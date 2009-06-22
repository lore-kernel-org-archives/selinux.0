Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5MGPlcn014148
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 12:25:47 -0400
Received: from e37.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n5MGQH00011815
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 16:26:17 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5MGOxws019931
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 10:24:59 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n5MGPVg5229246
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 10:25:38 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n5MGPQlZ029447
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 10:25:27 -0600
Date: Mon, 22 Jun 2009 11:25:24 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@epoch.ncsc.mil>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
Message-ID: <20090622162524.GA926@us.ibm.com>
References: <20090620013216.GA4435@us.ibm.com> <alpine.LRH.2.00.0906221537190.19585@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.0906221537190.19585@tundra.namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting James Morris (jmorris@namei.org):
> On Fri, 19 Jun 2009, Serge E. Hallyn wrote:
> 
> > Here is the next version of the patch implementing checkpoint
> > and restore of LSM contexts.  This is just handling IPC objects
> > as a proof of concept.  But actually, looking ahead and both
> > files and tasks, I see that selinux stores several sids in the
> > security structs.  For instance, for tasks there is the current
> > sid, exec sid, create sid, keycreate_sid, and sockcreate_sid.
> > So I guess I'll have to ask the LSM for how many secids it wants
> > to checkpoint, then checkpoint an array of contexts?
> > 
> 
> Can you please explain exactly what checkpoint/restart is?

Take a container or (it is still subject to debate whether to allow
this) any process tree, freeze it, record the state of the tasks,
all objects they own, and the filesystem.  The result is a checkpoint
image file for later use.  Unfreeze, and either continue running or
kill.  Later, restart from the checkpoint image, which will create
a new container containing all of the needed objects (IPC semaphores,
open files, sockets, etc) and restart all tasks exactly where they
left off.

While it seems very likely that in the end (when it hits upstream)
we will require privilege to use restart at all, we are doing our
best to design it so that it is safe for unprivileged users.  That
means that every object creation must be contingent on the authorization
of the task calling sys_restart().  After all, it is a trivial matter
to call sys_checkpoint() on your own vim process, edit the checkpoint
file to change the filename to /etc/passwd and the process uid to 0,
and then call sys_restart() on the result.

Since we don't want to talk about any 'trusted' user in SELinux at
all, the same mindset required to support unprivileged restart for the
DAC perms very much applies to c/r of SELinux state.

I'll add an explanation to the next version of the patch.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
