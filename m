Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96HfIrT006920
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 13:41:18 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96HfHco024763
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 17:41:17 GMT
Subject: Re: [PATCH] security/selinux/netif.c has a serious problem
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0410061209010.32613-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0410061209010.32613-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1097084297.11370.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 06 Oct 2004 13:38:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-10-06 at 12:10, James Morris wrote:
> On Wed, 6 Oct 2004, James Morris wrote:
> 
> > return without unlock.  Please use goto.
> 
> Hold on, you want to hold the lock while the user has the netif?

Yes, that is necessary to avoid having it freed while it is still being
used.  Lock is released by the put method; looks sane to me.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
