Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96G86rT005905
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 12:08:06 -0400 (EDT)
Date: Wed, 6 Oct 2004 12:08:01 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
In-Reply-To: <058301c4ab69$ea86b8f0$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0410061205100.32613-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Oct 2004, Kaigai Kohei wrote:

> [The attached patch]

In sel_netif_lookup():

	rcu_read_lock();

        netif = sel_netif_find(dev);
        if (likely(netif != NULL))
                return netif;

return without unlock.  Please use goto.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
