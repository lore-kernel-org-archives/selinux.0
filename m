Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OFctrT027752
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:38:55 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OFcAMZ014572
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:38:10 GMT
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
   "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
References: 
	 <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com>
	 <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
	 <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil>
	 <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp>
Content-Type: text/plain
Message-Id: <1093361844.1800.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 11:37:24 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-08-24 at 03:25, Kaigai Kohei wrote:
> You are right. Indeed, the lock for hash bucket is also necessary
> when avc_insert() is called. I fixed them.

avc_has_perm* can be called from interrupt or bh, e.g. send_sigio or
sock_rcv_skb.  So using just spin_lock/spin_unlock rather than
spin_lock_irqsave/restore is unsafe, right?
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
