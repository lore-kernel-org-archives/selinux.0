Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ALmNL9014876
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 16:48:23 -0500 (EST)
Subject: Re: TTY question
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1108071596.3689.15.camel@cobra.ivg2.net>
References: <1107915334.6602.1.camel@cobra.ivg2.net>
	 <1107954368.17568.25.camel@moss-spartans.epoch.ncsc.mil>
	 <1108000939.5241.10.camel@cobra.ivg2.net>
	 <1108039573.22172.37.camel@moss-spartans.epoch.ncsc.mil>
	 <1108043320.326.1.camel@cobra.ivg2.net>
	 <1108058666.3808.2.camel@cobra.ivg2.net>
	 <1108062931.4443.3.camel@cobra.ivg2.net>
	 <1108063884.22172.231.camel@moss-spartans.epoch.ncsc.mil>
	 <1108067400.5249.10.camel@cobra.ivg2.net>
	 <1108067486.22172.251.camel@moss-spartans.epoch.ncsc.mil>
	 <1108069944.3689.9.camel@cobra.ivg2.net>
	 <1108070175.22172.262.camel@moss-spartans.epoch.ncsc.mil>
	 <1108071596.3689.15.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1108071674.22172.267.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 16:41:15 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-10 at 16:39, Ivan Gyurdiev wrote:
> Actually here's probably why:
> it's duplicated in su_mini_domain:
> 
> # Close and re-open ttys and ptys to get the fd into the correct domain.
> allow $1_su_t { ttyfile ptyfile }:chr_file { read write };
> 
> So it's all good.

That likely isn't necessary presently, as su/pam_selinux no longer does
that (it caused breakage; we'd have to directly patch su to do it right,
and at that point, we'd likely just introduce a proxy pty).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
