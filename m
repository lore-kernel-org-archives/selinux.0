Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KHKErT005594
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 13:20:14 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KHJW4v022310
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 17:19:32 GMT
Date: Fri, 20 Aug 2004 18:31:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: James Morris <jmorris@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
   "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Message-ID: <20040820173124.GA11086@lkcl.net>
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 20, 2004 at 10:36:03PM +0900, Kaigai Kohei wrote:
> Hello, everyone.
> 
> Tuesday, August 17, 2004 12:19 AM
> James Morris wrote:
> > > Is removing direct reference to AVC-Entry approach acceptable?
> > > 
> > > I'll try to consider this issue further.
> > 
> > Sure, if you can make it work without problems.
> 
> The attached patches against to 2.6.8.1 kernel improve the performance
> and the scalability of SELinux by RCU-approach.
> 
> The evaluation results are as follows:
> <Environment>
> CPU: Itanium2(1GHz) x 4/8/16/32
> Memory: enough (no swap)
> OS: 2.6.8.1 (SELinux disabled by 'selinux=0' boot option)
>     2.6.8.1 (SELinux enabled)
>     2.6.8.1 + rwlock patch by KaiGai
>     2.6.8.1 + RCU patch by KaiGai
> 
> The test program iterates write() to files on tmpfs 500,000 times in parallel.
                                                ^^^^^
 i presume that that is without the xattr patch which adds extended
 attributes to tmpfs?

 (see http://hands.com/~lkcl/selinux)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
