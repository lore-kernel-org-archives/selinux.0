Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7V4XPrT009804
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 00:33:25 -0400 (EDT)
Message-ID: <00ee01c48f13$acb88160$f97d220a@linux.bs1.fc.nec.co.jp>
From: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
To: <paulmck@us.ibm.com>, "Stephen Smalley" <sds@epoch.ncsc.mil>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
   "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
   "James Morris" <jmorris@redhat.com>
References: <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil> <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp> <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil> <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp> <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil> <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp> <1093526652.9280.104.camel@moss-spartans.epoch.ncsc.mil> <066f01c48e82$f4ec3530$f97d220a@linux.bs1.fc.nec.co.jp> <1093880119.5447.87.camel@moss-spartans.epoch.ncsc.mil> <20040830161328.GC1243@us.ibm.com>
Subject: Re: [PATCH]SELinux performance improvement by RCU (Re: RCU issue with SELinux)
Date: Tue, 31 Aug 2004 13:33:33 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen, Paul, thanks for your comments.

> > > The attached take-4 patches replace the avc_lock in security/selinux/avc.c
> > > by the lock-less read access with RCU.
> > 
> > Thanks.  Was there a reason you didn't move the rcu_read_lock call after
> > the avc_insert call per the suggestion of Paul McKenney, or was that
> > just an oversight?  No need to send a new patch, just ack whether or not
> > you meant to switch the order there.
> 
> One reason might be because I called it out in the text of my message,
> but failed to put it in my patch.  :-/  Of course, if there is some reason
> why moving the rcu_read_lock() call is bad, I would like to know for
> my own education.

In my understanding, the issue is the Paul's suggestion as follows:

> So I do not believe that avc_insert() needs rcu_read_lock().
> Unless I am missing something, the rcu_read_lock() acquired
> in avc_has_perm_noaudit() should be moved after the call to
> avc_insert().

I don't move the rcu_read_lock() because of the possibility of preemption
between the spin_unlock_irqrestore() in avc_insert() and the rcu_read_lock()
which may be inserted after avc_insert() in avc_has_perm_noaudit().

When it's returning from avc_insert(), we can't ignore the possibility
that execution is preempted in this timing.
Therefore, I didn't move rcu_read_lock() in spite of its redundancy.

If rcu_read_lock() was moved after avc_insert()
[ in avc_insert() ]----------------------------
                :
        spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
        list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
                :
        }
        list_add_rcu(&node->list, &avc_cache.slots[hvalue]);
found:
        spin_unlock_irqrestore(&avc_cache.slots_lock[hvalue], flag);  ---------
        //  +--> including preempt_enable()                               |
                It has the danger of releasing the 'node'.                V
    }                                                                preemption
out:                                                                     is
    return node;                                                       possible
}
-----------------------------------------------
Because it's legal to hold the rcu_read_lock() twice as Paul says,
we should do it for safety.
It's the reason that I didn't move rcu_read_lock() at this point,
and it might be lack of my explanation, sorry.

Thanks.
--------
Kai Gai <kaigai@ak.jp.nec.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
