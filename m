Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i58HBLrT013689
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 13:11:21 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i58HBF22024397
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 13:11:15 -0400 (EDT)
Subject: Re: support for fireflight reading /proc/NNN/fd and /proc/NNN/exe
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
In-Reply-To: <20040607232158.GA2073@jmh.mhn.de>
References: <20040607082243.GH4543@lkcl.net>
	 <20040607205957.GA3063@lkcl.net>  <20040607232158.GA2073@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1086714639.32646.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 08 Jun 2004 13:11:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-06-07 at 19:21, Thomas Bleher wrote:
> Not the macro directly, otherwise all domains which use can_ps() will be
> affected. If you really need that much access, you should probably add a
> rule like
>         allow fireflier_t file_type:file_class_set getattr;
>         allow fireflier_t domain:{ socket_class_set fifo_file } getattr;
> But this seems just too broad (see below).

Definitely too broad.  Use dontaudit rules to suppress the audit
messages, and only allow it what it truly needs to function.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
