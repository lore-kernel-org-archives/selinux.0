Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5UCDfnJ005691
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2010 08:13:41 -0400
Received: from e37.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5UCCmUn025025
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2010 12:12:48 GMT
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5UCBmRZ014866
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2010 06:11:48 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o5UCDU0X069160
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2010 06:13:32 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o5UCDTwS019422
	for <selinux@tycho.nsa.gov>; Wed, 30 Jun 2010 06:13:30 -0600
Subject: Re: selinux testsuite
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>,
        James Morris <jmorris@redhat.com>, kaigai@ak.jp.nec.com,
        ltp-list <ltp-list@lists.sf.net>
In-Reply-To: <20100629195210.GA14549@hallyn.com>
References: <20100629195210.GA14549@hallyn.com>
Content-Type: text/plain
Date: Wed, 30 Jun 2010 17:43:24 +0530
Message-Id: <1277900005.5710.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Serge,

On Tue, 2010-06-29 at 14:52 -0500, Serge E. Hallyn wrote:
> Just a little note to announce that the selinux testsuite is now up as a
> git tree at kernel.org.  You can fetch it using
> 
> 	git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite

Great. So, how far does it differ from that we have in LTP ?
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=tree;f=testcases/kernel/security/selinux-testsuite;h=066df4cdf2f8a80a0045e338b4bb2bf0f5d37091;hb=HEAD

As you, Stephen and others in SELinux <selinux@tycho.nsa.gov> were the
main contributors to the SELinux test(s) in LTP, i guess the next/future
development for SELinux tests will be happening in the new tree.

So, i would rather keep pulling to LTP from your tree. Now, could you
please let me know:

     1. Whether the new tree contains all scenarios which is present in
        LTP. In such a case a complete pruning of LTP SELinux tests can
        be done and replaced with your tree contents,
     2. If some of the LTP tests are not there, then i would like to
        retain them in LTP side-by-side your tree contents,

Regards--
Subrata

> 
> The README shows how to run.
> 
> Many thanks to Stephen for keeping it running so nicely and allowing me
> to post it.  I intend to test against Fedora regularly-ish, and to start
> seeing how best to nudge it to work against Debian and Ubuntu in the next
> month or so.
> 
> -serge
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
