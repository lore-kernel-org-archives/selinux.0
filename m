Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7ON6WrT001565
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 19:06:32 -0400 (EDT)
Received: from linux.local (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7ON6TCV022743
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 23:06:30 GMT
Date: Tue, 24 Aug 2004 16:02:45 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
   "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
   James Morris <jmorris@redhat.com>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Message-ID: <20040824230245.GA1243@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil> <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 04:25:32PM +0900, Kaigai Kohei wrote:
> Hi Stephen, Thanks for your comments.
> 
> > I'm not overly familiar with RCU myself, but the comments in list.h for
> > list_add_rcu suggest that you still need to hold a lock to avoid racing
> > with another list_add_rcu or list_del_rcu call on the same list.  But
> > avc_insert is calling list_add_rcu without holding any lock; can't it
> > race with another avc_insert on the same hash bucket?  Do I just
> > misunderstand, or is this unsafe?  Thanks for clarifying.
> 
> You are right. Indeed, the lock for hash bucket is also necessary
> when avc_insert() is called. I fixed them.
> 
> > I think we can likely eliminate the mutation of the node in the
> > !selinux_enforcing case in avc_has_perm_noaudit, i.e. eliminate the
> > entire else clause and just fall through with rc still 0.  Adding the
> > requested permissions to the node was simply to avoid flooding denials
> > in permissive mode on the same permission check, but this can be
> > addressed separately using the audit ratelimit mechanism.
> 
> I have another opinion.
> This simple mechanism against the flood of audit log is necessary,
> because it prevents the depletion of the system log buffer and denied log
> all over the console when we are debugging the security policy in permissive mode.
> So, I improved the avc_update_node() function and avc_node data structure.
> It does not need kmalloc() when avc_update_node(). 
> 
> This approach is good for durability and compatibility of original implementation,
> but double area of avc_nodes is needed for updating without kmalloc().
> This approach can apply to any kinds of updating of avc_entry.
> This idea is pretty complexer, though.
> 
> I modified the following points:
> - We hold the lock for hash backet when avc_insert() and avc_ss_reset() are
>   called for safety.
> - list_for_each_rcu() and list_entry() are replaced by list_for_entry().

One subtlety here...

The traversals that are protected by rcu_read_lock() (rather than an
update-side spinlock) need to be list_for_each_entry_rcu() rather than
list_for_each_entry().  The "_rcu()" is required in order to work
reliably on Alpha, and has the added benefit of calling out exactly
which traversals are RCU-protected.

Update-side code remains list_for_each_entry().

> - avc_node_dual structure which contains two avc_node objects is defined. 
>   It allows to do avc_update_node() without kmalloc() or any locks.

What happens when you have two consecutive updates to the same object?
Don't you have to defer the second update until a grace period has
elapsed since the first update in order to avoid confusing readers that
are still accessing the original version?

One way to do this would be to set a "don't-touch-me" bit that is
cleared by an RCU callback.  An update to an element with the
"don't-touch-me" bit set would block until the bit clears.  There
are probably better ways...

							Thanx, Paul

> Any comments please. Thanks.
> --------
> Kai Gai <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
