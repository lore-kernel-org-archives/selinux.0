Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KKZurT007052
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 16:35:56 -0400 (EDT)
Date: Fri, 20 Aug 2004 16:35:47 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Kaigai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
   "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
In-Reply-To: <20040820201914.GA1244@us.ibm.com>
Message-ID: <Xine.LNX.4.44.0408201633390.2238-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > +		hvalue = atomic_inc_return(&avc_cache.lru_hint) % AVC_CACHE_SLOTS;

atomic_inc_return() is not implemented on ia32 or x86-64.  Is there a 
workaround, or do we need to implement it?  (Andi Kleen suggested using 
the xadd instruction and altinstructions for i386).


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
