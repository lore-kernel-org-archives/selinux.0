Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7GFKBrT007403
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 11:20:11 -0400 (EDT)
Date: Mon, 16 Aug 2004 11:19:58 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
   "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
   Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
In-Reply-To: <019201c48374$09efc510$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Aug 2004, Kaigai Kohei wrote:

> Is removing direct reference to AVC-Entry approach acceptable?
> 
> I'll try to consider this issue further.

Sure, if you can make it work without problems.



- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
