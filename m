Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UFbBrT005698
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 11:37:11 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UFaMAE000975
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 15:36:23 GMT
Subject: Re: [PATCH]SELinux performance improvement by RCU (Re: RCU issue
	with SELinux)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
   "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
   James Morris <jmorris@redhat.com>, "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <066f01c48e82$f4ec3530$f97d220a@linux.bs1.fc.nec.co.jp>
References: 
	 <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com>
	 <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil>
	 <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil>
	 <024501c48a89$12d30b30$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093449047.6743.186.camel@moss-spartans.epoch.ncsc.mil>
	 <02b701c48b41$b6b05100$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093526652.9280.104.camel@moss-spartans.epoch.ncsc.mil>
	 <066f01c48e82$f4ec3530$f97d220a@linux.bs1.fc.nec.co.jp>
Content-Type: text/plain
Message-Id: <1093880119.5447.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 30 Aug 2004 11:35:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-30 at 07:17, Kaigai Kohei wrote:
> I fixed the take-3 patch according to your and Paul's suggestions.
> 
> The attached take-4 patches replace the avc_lock in security/selinux/avc.c
> by the lock-less read access with RCU.

Thanks.  Was there a reason you didn't move the rcu_read_lock call after
the avc_insert call per the suggestion of Paul McKenney, or was that
just an oversight?  No need to send a new patch, just ack whether or not
you meant to switch the order there.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
