Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2LNw9x6025630
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 18:58:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2LNselY015535
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 23:54:40 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h2LNsOKX015532
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 23:54:32 GMT
Date: Sat, 22 Mar 2003 10:57:35 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Dale Amon <amon@vnl.com>, "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE-Linux and 2.4.20
Message-ID: <20030321235735.GA8789@snoopy.apana.org.au>
References: <200303211604.LAA20617@moss-shockers.ncsc.mil> <20030320002246.GC13288@snoopy.apana.org.au> <20030320111227.GJ24908@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200303211604.LAA20617@moss-shockers.ncsc.mil> <20030320111227.GJ24908@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 20, 2003 at 11:12:27AM +0000, Dale Amon wrote:
> Just as another data point: I had to back a 2.4.20
> kernel off a firewall because it was oopsing in random
> processes after a couple hours. Might not be related...
> the kernel had crypto, freeswan and grsec, the oops
> was during kernel paging. Are you seeing an OOPS when
> you get the lockup?

No kernel OOPS.

My kernel also has freeswan support, too. It is a module though and not
loaded. Coincidence?

On Fri, Mar 21, 2003 at 11:04:32AM -0500, Stephen D. Smalley wrote:
> I haven't seen this behavior myself.  Was there anything useful in
> /var/log/messages or the dmesg output, e.g. a kernel Oops message?  As
> a reminder, we don't incorporate other bug fix patches in the
> LSM/SELinux patches, so you do need to apply any other bug fix patches
> that you want for the base kernel, e.g. the ext3 fixes for 2.4.20.

No useful messages.

No unexpected messages.

My debug.log file is badly currupted at the point of the crash, but
apart from that nothing unusual.

I use the Debian kernel source, which I believe is already patched
with the ext3 bug fix (at least according to the changelog it is).

I have also applied the ptrace security fixes, although the problem
happened before then.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
