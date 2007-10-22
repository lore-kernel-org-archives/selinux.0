Date: Tue, 23 Oct 2007 08:50:27 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, roland@redhat.com
Subject: Re: [PATCH] SELinux: always check SIGCHLD in selinux_task_wait
In-Reply-To: <1193083831.2950.7.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0710230849570.18829@us.intercode.com.au>
References: <1193083831.2950.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Oct 2007, Eric Paris wrote:

> When checking if we can wait on a child we were looking at
> p->exit_signal and trying to make the decision based on if the signal
> would eventually be allowed.  One big flaw is that p->exit_signal is -1
> for NPTL threads and so aignal_to_av was not actually checking SIGCHLD
> which is what would have been sent.  Even is exit_signal was set to
> something strange it wouldn't change the fact that the child was there
> and needed to be waited on.  This patch just assumes wait is based on
> SIGCHLD.  Specific permission checks are made when the child actually
> attempts to send a signal.
> 
> This resolves the problem of things like using GDB on confined domains
> such as in RH BZ 232371.  The confined domain did not have permission to
> send a generic signal (exit_signal == -1) back to the unconfined GDB.
> With this patch the GDB wait works and since the actual signal sent is
> allowed everything functions as it should.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-linus


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
