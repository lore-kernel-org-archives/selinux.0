Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UGHPrT005993
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 12:17:25 -0400 (EDT)
Received: from linux.local (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UGHO10024377
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 16:17:24 GMT
Date: Mon, 30 Aug 2004 09:13:28 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
   "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
   James Morris <jmorris@redhat.com>
Subject: Re: [PATCH]SELinux performance improvement by RCU (Re: RCU issue with SELinux)
Message-ID: <20040830161328.GC1243@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil> <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp> <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil> <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp> <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil> <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp> <1093526652.9280.104.camel@moss-spartans.epoch.ncsc.mil> <066f01c48e82$f4ec3530$f97d220a@linux.bs1.fc.nec.co.jp> <1093880119.5447.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1093880119.5447.87.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 30, 2004 at 11:35:19AM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-30 at 07:17, Kaigai Kohei wrote:
> > I fixed the take-3 patch according to your and Paul's suggestions.
> > 
> > The attached take-4 patches replace the avc_lock in security/selinux/avc.c
> > by the lock-less read access with RCU.
> 
> Thanks.  Was there a reason you didn't move the rcu_read_lock call after
> the avc_insert call per the suggestion of Paul McKenney, or was that
> just an oversight?  No need to send a new patch, just ack whether or not
> you meant to switch the order there.

One reason might be because I called it out in the text of my message,
but failed to put it in my patch.  :-/  Of course, if there is some reason
why moving the rcu_read_lock() call is bad, I would like to know for
my own education.

						Thanx, Paul

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
